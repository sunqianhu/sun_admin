<?php
namespace app\model;

use app\model\desktop\Permission as DesktopPermissionModel;
use app\model\mobile\Permission as MobilePermissionModel;

class Role extends Base
{
    /**
     * 桌面端权限
     * @return \think\model\relation\BelongsToMany
     */
    public function desktopPermissions()
    {
        return $this->belongsToMany(DesktopPermissionModel::class, 'role_desktop_permission', 'permission_id', 'role_id');
    }

    /**
     * 移动端权限
     * @return \think\model\relation\BelongsToMany
     */
    public function mobilePermissions()
    {
        return $this->belongsToMany(MobilePermissionModel::class, 'role_mobile_permission', 'permission_id', 'role_id');
    }
}