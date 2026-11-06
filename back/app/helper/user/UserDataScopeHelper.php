<?php

namespace app\helper\user;

use app\helper\department\DepartmentPathHelper;
use app\model\data_scope\PolicyDepartmentModel;
use app\model\data_scope\PolicyModel;
use app\model\DepartmentModel;
use app\model\UserModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\db\Query;
use think\facade\Cache;

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
        $cacheKey = 'user_data_scope_access_' . $userId . '_' . $dataScopeKey;
        $cacheTtl = 600;
        $cacheAccess = Cache::get($cacheKey);
        if($cacheAccess){
            return $cacheAccess;
        }

        $access = [
            'granted'=>false,
            'all'=>false,
            'rules'=>[]
        ];
        $userRoleHelper = new UserRoleHelper();
        $roleIds = $userRoleHelper->getRoleIds($userId);
        if(empty($roleIds)){
            Cache::tag('data_scope')->set($cacheKey, $access, $cacheTtl);
            return $access;
        }

        //策略
        $policies = PolicyModel::alias('p')
            ->field('p.id,p.data_scope_id,p.name,p.type')
            ->join('role_policy rp', 'rp.policy_id = p.id')
            ->join('data_scope ds', 'ds.id = p.data_scope_id')
            ->whereIn('rp.role_id', $roleIds)
            ->where('ds.key', $dataScopeKey)
            ->group('p.id')
            ->select()
            ->toArray();

        //部门
        $userDepartmentHelper = new UserDepartmentHelper();
        $departmentId = $userDepartmentHelper->getDepartmentId($userId);

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
            if($policy['type'] == 2){
                $departmentPathHelper = new DepartmentPathHelper();
                $path = $departmentPathHelper->getPath($departmentId);
                if($path === ''){
                    continue;
                }

                $departmentIds = DepartmentModel::field('id')
                    ->where('path', $path)
                    ->whereOr('path', 'like', $path . '/%')
                    ->column('id');

                $rule = [
                    'type'=>'self_and_children_department',
                    'value'=>$departmentIds
                ];
                $rules[] = $rule;
                continue;
            }

            //指定单位
            if($policy['type'] == 98){
                $departmentIds = PolicyDepartmentModel::where('policy_id', $policy['id'])->column('department_id');
                $rule = [
                    'type'=>'specified_department',
                    'value'=>$departmentIds
                ];
                $rules[] = $rule;
                continue;
            }

            //全部权限
            if($policy['type'] == 99){
                $rule = [
                    'type'=>'all',
                    'value'=>''
                ];
                $rules[] = $rule;
                $access['all'] = true;
                break;
            }

            //无权限
            if($policy['type'] == 100){
                $rule = [
                    'type'=>'no',
                    'value'=>''
                ];
                $rules[] = $rule;
                continue;
            }
        }
        foreach($rules as $rule){
            if($rule['type'] != 'no'){
                $access['granted'] = true;
            }
        }
        $access['rules'] = $rules;

        Cache::tag('data_scope')->set($cacheKey, $access, $cacheTtl);
        return $access;
    }

    /**
     * 构建查询限制
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
    public function buildQueryConstraint($userId, $dataScopeKey, $query, $departmentField, $userField = 'id')
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
        $query->where(function ($linkQuery) use ($access, $departmentField, $userField) {
            foreach($access['rules'] as $rule){
                $linkQuery->whereOr(function ($ruleQuery) use ($rule, $departmentField, $userField) {
                    if ($rule['type'] == 'self_user') {
                        $ruleQuery->where($userField, $rule['value']);
                    }
                    else if ($rule['type'] == 'self_department') {
                        $ruleQuery->where($departmentField, $rule['value']);
                    } else if ($rule['type'] == 'self_and_children_department') {
                        $departmentIds = $rule['value'];
                        if(empty($departmentIds)) {
                            $ruleQuery->whereRaw('1 = 0');
                        }else{
                            $ruleQuery->whereIn($departmentField, $departmentIds);
                        }
                    } else if ($rule['type'] == 'specified_department') {
                        $ruleQuery->whereIn($departmentField, $rule['value']);
                    } else if ($rule['type'] == 'no') {
                        $ruleQuery->whereRaw('1 = 0');
                    }
                });
            }
        });

        return $query;
    }

    /**
     * 是否能够访问部门
     * @param $userId
     * @param $dataScopeKey
     * @param $departmentId
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function canAccessDepartment($userId, $dataScopeKey, $departmentId)
    {
        $query = DepartmentModel::field('id')
            ->where('id', $departmentId);
        $query = $this->buildQueryConstraint($userId, $dataScopeKey, $query, 'id', '');
        $departmentModel = $query->find();
        if(!empty($departmentModel)){
            return true;
        }
        return false;
    }

    /**
     * 是否能够访问用户
     * @param $userId
     * @param $dataScopeKey
     * @param $targetUserId
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function canAccessUser($userId, $dataScopeKey, $targetUserId)
    {
        $query = UserModel::field('id')
            ->where('id', $targetUserId);
        $query = $this->buildQueryConstraint($userId, $dataScopeKey, $query, 'department_id', 'id');
        $userModel = $query->find();
        if(!empty($userModel)){
            return true;
        }
        return false;
    }

    /**
     * 清除缓存
     * @return void
     */
    public function clearCache()
    {
        Cache::tag('data_scope')->clear();
    }
}
