<?php
namespace app\model\data_scope;

use app\model\BaseModel;
use app\model\DepartmentModel;
use think\model\relation\BelongsToMany;

class PolicyModel extends BaseModel
{
    protected $name = 'data_scope_policy';

    /**
     * 单位列表
     * @return BelongsToMany
     */
    public function departments()
    {
        return $this->belongsToMany(DepartmentModel::class, 'data_scope_policy_department', 'department_id', 'policy_id');
    }

    /**
     * 得到单位ID数组
     * @param $value
     * @param $data
     * @return array
     */
    public function getDepartmentIdsAttr($value, $data){
        if(empty($this->departments)){
            return [];
        }
        $departments = $this->departments->toArray();
        $ids = array_column($departments, 'id');
        return array_unique($ids);
    }
}