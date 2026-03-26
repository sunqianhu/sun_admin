<?php

namespace app\helper\user;

use app\helper\department\DepartmentPathHelper;
use app\model\data_scope\PolicyDepartmentModel;
use app\model\data_scope\PolicyModel;
use app\model\DepartmentModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\db\Query;

class UserDataScopeHelper
{
    /**
     * 得到访问权限
     * @param $userId
     * @param $dataScopeKey
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function getAccess($userId, $dataScopeKey)
    {
        $access = [
            'granted'=>false,
            'all'=>false,
            'rules'=>[]
        ];
        $userRoleHelper = new UserRoleHelper();
        $roleIds = $userRoleHelper->getRoleIds($userId);
        if(empty($roleIds)){
            return $access;
        }

        //策略
        $policies = PolicyModel::alias('p')
            ->field('p.id,p.data_scope_id,p.name,p.type')
            ->join('role_data_scope_policy rdsp', 'rdsp.policy_id = p.id')
            ->join('data_scope ds', 'ds.id = rdsp.data_scope_id')
            ->whereIn('rdsp.role_id', $roleIds)
            ->where('ds.key', $dataScopeKey)
            ->group('p.id')
            ->select()
            ->toArray();

        //部门
        $userDepartmentHelper = new UserDepartmentHelper();
        $departmentId = $userDepartmentHelper->getDepartmentId($userId);
        if(empty($departmentId)){
            throw new Exception('用户还没有设置部门');
        }

        //规则
        $rules = [];
        foreach ($policies as $policy){
            //本用户
            if($policy['type'] == 0){
                $rule = [
                    'type'=>'self_user',
                    'value'=>$userId
                ];
                $rules[] = $rule;
                continue;
            }

            //本单位
            if($policy['type'] == 1){
                $rule = [
                    'type'=>'self_department',
                    'value'=>$departmentId
                ];
                $rules[] = $rule;
                continue;
            }

            //本单位及下级单位
            else if($policy['type'] == 2){
                $departmentPathHelper = new DepartmentPathHelper();
                $path = $departmentPathHelper->getPath($departmentId);
                $rule = [
                    'type'=>'self_and_children_department',
                    'value'=>$path
                ];
                $rules[] = $rule;
                continue;
            }

            //指定单位
            else if($policy['type'] == 98){
                $departmentIds = PolicyDepartmentModel::where('policy_id', $policy['id'])->column('department_id');
                $rule = [
                    'type'=>'specified_department',
                    'value'=>$departmentIds
                ];
                $rules[] = $rule;
                continue;
            }

            //全部权限
            else if($policy['type'] == 99){
                $rule = [
                    'type'=>'all',
                    'value'=>''
                ];
                $rules[] = $rule;
                $access['all'] = true;
                break;
            }
        }

        $access['granted'] = !empty($rules);
        $access['rules'] = $rules;
        return $access;
    }

    /**
     * 设置查询构造器
     * @param $userId
     * @param $dataScopeKey
     * @param $query
     * @param $departmentField
     * @param $userField
     * @return Query
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function setQuery($userId, $dataScopeKey, $query, $departmentField, $userField)
    {
        $access = $this->getAccess($userId, $dataScopeKey);

        //无权限
        if (!$access['granted']) {
            return $query->whereRaw('1 = 0');
        }

        //全部权限
        if ($access['all']) {
            return $query;
        }

        //加载权限
        $query->where(function ($linkQuery) use ($access,$departmentField, $userField) {
            foreach($access['rules'] as $rule){
                $linkQuery->whereOr(function ($ruleQuery) use ($rule, $departmentField, $userField) {
                    if ($rule['type'] == 'self_user') {
                        $ruleQuery->where($userField, $rule['value']);
                    }
                    else if ($rule['type'] == 'self_department') {
                        $ruleQuery->where($departmentField, $rule['value']);
                    } else if ($rule['type'] == 'self_and_children_department') {
                        $ruleQuery->whereIn($departmentField, function ($selfAndChildrenDepartmentQuery) use ($rule) {
                            $selfAndChildrenDepartmentQuery->table('department')
                                ->field('id')
                                ->where('path', 'like', $rule['value'] . '%');
                        });
                    } else if ($rule['type'] == 'specified_department') {
                        $ruleQuery->whereIn($departmentField, $rule['value']);
                    }
                });
            }
        });

        return $query;
    }
}