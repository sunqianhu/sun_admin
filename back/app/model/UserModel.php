<?php
namespace app\model;

use app\service\user\UserAvatarService;
use Exception;
use Sunqianhu\Helper\SingletonFactory;
use think\model\relation\BelongsTo;
use think\model\relation\BelongsToMany;

class UserModel extends BaseModel
{
    protected $name = 'user';

    /**
     * 部门
     * @return BelongsTo
     */
    public function department()
    {
        return $this->belongsTo(DepartmentModel::class, 'department_id', 'id')
            ->field('id,type,department_id,name');
    }

    /**
     * 角色
     * @return BelongsToMany
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
     * @param $value
     * @param $data
     * @return string
     * @throws Exception
     */
    public function getAvatarUrlAttr($value, $data)
    {
        $userAvatarService = SingletonFactory::getInstance(UserAvatarService::class);
        return $userAvatarService->getAvatarUrl($data['avatar']);
    }

    /**
     * 得到大头像url
     * @param $value
     * @param $data
     * @return string
     * @throws Exception
     */
    public function getBigAvatarUrlAttr($value, $data)
    {
        $userAvatarService = SingletonFactory::getInstance(UserAvatarService::class);
        return $userAvatarService->getBigAvatarUrl($data['big_avatar']);
    }

    /**
     * 得到部门名字
     * @param $value
     * @param $data
     * @return string
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