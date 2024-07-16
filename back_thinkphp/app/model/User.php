<?php
namespace app\model;

use app\service\User as UserHelper;

class User extends Base
{
    /**
     * 部门
     * @return \think\model\relation\BelongsToMany
     */
    public function department()
    {
        return $this->belongsTo(Department::class, 'department_id', 'id')
            ->field('department.id,department.department_id,department.name');
    }

    /**
     * 角色
     * @return \think\model\relation\BelongsToMany
     */
    public function roles()
    {
        return $this->belongsToMany(Role::class, 'user_role', 'role_id', 'user_id')
            ->field('role.id,role.name');
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
        if($data['status_id'] != 1){
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
        $userService = new UserHelper();
        return $userService->getAvatarUrl($data['avatar']);
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
     * 得到角色id集合
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
     * 得到角色名称集合
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