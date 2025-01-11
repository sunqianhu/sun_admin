<?php
namespace app\model;

use app\service\SingletonFactory;
use app\service\User;

class UserModel extends BaseModel
{
    protected $name = 'user';

    /**
     * 部门
     * @return \think\model\relation\BelongsToMany
     */
    public function department()
    {
        return $this->belongsTo(DepartmentModel::class, 'department_id', 'id')
            ->field('id,type,department_id,name');
    }

    /**
     * 角色
     * @return \think\model\relation\BelongsToMany
     */
    public function roles()
    {
        return $this->belongsToMany(RoleModel::class, 'user_role', 'role_id', 'user_id');
    }

    /**
     * 得到状态名
     * @param $value
     * @param $data
     * @return null
     */
    public function getStatusNameAttr($value, $data)
    {
        $name = '启用';
        if($data['status'] == 0){
            $name = '停用';
        }

        return $name;
    }

    /**
     * 得到头像url
     * @param $path
     * @return string
     */
    public function getAvatarUrlAttr($value, $data)
    {
        $user = SingletonFactory::getInstance(User::class);
        return $user->getAvatarUrl($data['avatar']);
    }

    /**
     * 得到部门名字
     * @param $value
     * @param $data
     * @return array
     */
    public function getDepartmentNameAttr($value, $data){
        if(empty($this->department)){
            return '';
        }

        return $this->department->getData('name');
    }

    /**
     * 得到角色id列表
     * @param $value
     * @param $data
     * @return array
     */
    public function getRoleIdsAttr($value, $data){
        if(empty($this->roles)){
            return [];
        }
        $roles = $this->roles->toArray();
        return array_column($roles, 'id');
    }

    /**
     * 得到角色名称列表
     * @param $value
     * @param $data
     * @return array
     */
    public function getRoleNamesAttr($value, $data){
        if(empty($this->roles)){
            return [];
        }
        $roles = $this->roles->toArray();
        return array_column($roles, 'name');
    }
}