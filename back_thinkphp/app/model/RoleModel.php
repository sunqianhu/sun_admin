<?php
namespace app\model;

use app\model\desktop\DesktopMenuModel;
use app\model\desktop\DesktopPermissionModel;
use app\model\desktop\DesktopRouteModel;
use app\model\mobile\MobilePermissionModel;

class RoleModel extends BaseModel
{
    protected $name = 'role';

    /**
     * 桌面端权限
     * @return \think\model\relation\BelongsToMany
     */
    public function desktopPermissions()
    {
        return $this->belongsToMany(DesktopPermissionModel::class, 'role_desktop_permission', 'permission_id', 'role_id');
    }

    /**
     * 桌面端菜单
     * @return \think\model\relation\BelongsToMany
     */
    public function desktopMenus()
    {
        return $this->belongsToMany(DesktopMenuModel::class, 'role_desktop_menu', 'menu_id', 'role_id');
    }

    /**
     * 桌面端路由
     * @return \think\model\relation\BelongsToMany
     */
    public function desktopRoutes()
    {
        return $this->belongsToMany(DesktopRouteModel::class, 'role_desktop_route', 'route_id', 'role_id');
    }

    /**
     * 移动端权限
     * @return \think\model\relation\BelongsToMany
     */
    public function mobilePermissions()
    {
        return $this->belongsToMany(MobilePermissionModel::class, 'role_mobile_permission', 'permission_id', 'role_id');
    }

    /**
     * 得到桌面端权限id集合
     * @param $value
     * @param $data
     * @return array
     */
    public function getDesktopPermissionIdsAttr($value, $data){
        if(empty($this->desktopPermissions)){
            return [];
        }
        $desktopPermissions = $this->desktopPermissions->toArray();
        return array_column($desktopPermissions, 'id');
    }

    /**
     * 得到桌面端菜单id集合
     * @param $value
     * @param $data
     * @return array
     */
    public function getDesktopMenuIdsAttr($value, $data){
        if(empty($this->desktopMenus)){
            return [];
        }
        $desktopMenus = $this->desktopMenus->toArray();
        return array_column($desktopMenus, 'id');
    }

    /**
     * 得到桌面端路由id集合
     * @param $value
     * @param $data
     * @return array
     */
    public function getDesktopRouteIdsAttr($value, $data){
        if(empty($this->desktopRoutes)){
            return [];
        }
        $desktopRoutes = $this->desktopRoutes->toArray();
        return array_column($desktopRoutes, 'id');
    }

    /**
     * 得到移动端路由id集合
     * @param $value
     * @param $data
     * @return array
     */
    public function getMobilePermissionIdsAttr($value, $data){
        if(empty($this->mobilePermissions)){
            return [];
        }
        $mobilePermissions = $this->mobilePermissions->toArray();
        return array_column($mobilePermissions, 'id');
    }
}