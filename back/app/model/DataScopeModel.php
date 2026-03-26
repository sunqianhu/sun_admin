<?php
namespace app\model;

use app\model\data_scope\PolicyModel;
use think\model\relation\HasMany;

class DataScopeModel extends BaseModel
{
    protected $name = 'data_scope';

    /**
     * 策略列表
     * @return HasMany
     */
    public function policies()
    {
        return $this->hasMany(PolicyModel::class,'data_scope_id','id')
            ->field('id,data_scope_id,name')
            ->order('sort', 'asc');
    }
}