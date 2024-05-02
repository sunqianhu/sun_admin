<?php
namespace app\model;

use app\model\desktop\Module as DesktopModuleModel;
use app\model\mobile\Module as MobileModuleModel;

class Role extends Base
{
    /**
     * 桌面端模块
     * @return \think\model\relation\BelongsToMany
     */
    public function desktopModules()
    {
        return $this->belongsToMany(DesktopModuleModel::class, 'role_desktop_module', 'module_id', 'role_id');
    }

    /**
     * 移动端模块
     * @return \think\model\relation\BelongsToMany
     */
    public function mobileModules()
    {
        return $this->belongsToMany(MobileModuleModel::class, 'role_mobile_module', 'module_id', 'role_id');
    }
}