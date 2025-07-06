<?php
namespace app\model;

use app\model\desktop\MenuModel as DesktopMenuModel;
use app\model\desktop\PermissionModel as DesktopPermissionModel;
use app\model\desktop\RouteModel as DesktopRouteModel;
use app\model\mobile\PermissionModel as MobilePermissionModel;
use think\model\relation\BelongsToMany;

class RoleModel extends BaseModel
{
    protected $name = 'role';

    /**
     * 桌面端权限
     * @return BelongsToMany
     */
    public function desktopPermissions()
    {
        return $this->belongsToMany(DesktopPermissionModel::class, 'role_desktop_permission', 'permission_id', 'role_id');
    }

    /**
     * 桌面端菜单
     * @return BelongsToMany
     */
    public function desktopMenus()
    {
        return $this->belongsToMany(DesktopMenuModel::class, 'role_desktop_menu', 'menu_id', 'role_id');
    }

    /**
     * 桌面端路由
     * @return BelongsToMany
     */
    public function desktopRoutes()
    {
        return $this->belongsToMany(DesktopRouteModel::class, 'role_desktop_route', 'route_id', 'role_id');
    }

    /**
     * 移动端权限
     * @return BelongsToMany
     */
    public function mobilePermissions()
    {
        return $this->belongsToMany(MobilePermissionModel::class, 'role_mobile_permission', 'permission_id', 'role_id');
    }

    /**
     * 得到桌面端权限id列表
     * @param $value
     * @param $data
     * @return array
     */
    public function getDesktopPermissionIdsAttr($value, $data){
        if(empty($this->desktop_permissions)){
            return [];
        }
        $desktopPermissions = $this->desktop_permissions->toArray();
        $ids = array_column($desktopPermissions, 'id');
        return array_unique($ids);
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

    /**
     * 得到移动端路由id列表
     * @param $value
     * @param $data
     * @return array
     */
    public function getMobilePermissionIdsAttr($value, $data){
        if(empty($this->mobile_permissions)){
            return [];
        }
        $mobilePermissions = $this->mobile_permissions->toArray();
        $ids = array_column($mobilePermissions, 'id');
        return array_unique($ids);
    }
}