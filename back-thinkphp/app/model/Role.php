<?php
namespace app\model;

use app\model\desktop\Module;

class Role extends Base
{
    /**
     * 菜单
     * @return \think\model\relation\BelongsToMany
     */
    public function menus()
    {
        return $this->belongsToMany(Module::class, 'role_menu', 'menu_id', 'role_id');
    }
}