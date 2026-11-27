<?php
namespace app\model;

use app\model\desktop\MenuModel;
use app\model\desktop\RouteModel;
use app\model\data_scope\PolicyModel;
use think\model\relation\BelongsToMany;

class RoleModel extends BaseModel
{
    protected $name = 'role';

    /**
     * 权限
     * @return BelongsToMany
     */
    public function permissions()
    {
        return $this->belongsToMany(PermissionModel::class, 'role_permission', 'permission_id', 'role_id');
    }

    /**
     * 数据权限策略
     * @return BelongsToMany
     */
    public function policies()
    {
        return $this->belongsToMany(PolicyModel::class, 'role_policy', 'policy_id', 'role_id');
    }

    /**
     * 桌面端菜单
     * @return BelongsToMany
     */
    public function desktopMenus()
    {
        return $this->belongsToMany(MenuModel::class, 'role_desktop_menu', 'menu_id', 'role_id');
    }

    /**
     * 桌面端路由
     * @return BelongsToMany
     */
    public function desktopRoutes()
    {
        return $this->belongsToMany(RouteModel::class, 'role_desktop_route', 'route_id', 'role_id');
    }

    /**
     * 得到权限id列表
     * @param $value
     * @param $data
     * @return array
     */
    public function getPermissionIdsAttr($value, $data){
        if(empty($this->permissions)){
            return [];
        }
        $permissions = $this->permissions->toArray();
        $ids = array_column($permissions, 'id');
        return array_unique($ids);
    }

    /**
     * 得到策略ID列表
     * @param $value
     * @param $data
     * @return array
     */
    public function getPolicyIdsAttr($value, $data)
    {
        $policies = $this->policies->toArray();
        return array_column($policies, 'id');
    }

    /**
     * 得到桌面端菜单id列表
     * @param $value
     * @param $data
     * @return array
     */
    public function getDesktopMenuIdsAttr($value, $data){
        if(empty($this->desktop_menus)){
            return [];
        }
        $desktopMenus = $this->desktop_menus->toArray();
        $ids = array_column($desktopMenus, 'id');
        return array_unique($ids);
    }

    /**
     * 得到桌面端路由id列表
     * @param $value
     * @param $data
     * @return array
     */
    public function getDesktopRouteIdsAttr($value, $data){
        if(empty($this->desktop_routes)){
            return [];
        }
        $desktopRoutes = $this->desktop_routes->toArray();
        $ids = array_column($desktopRoutes, 'id');
        return array_unique($ids);
    }

}
