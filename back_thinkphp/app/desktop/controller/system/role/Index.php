<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\Role as RoleModel;

class Index extends Base
{
    /**
     * 得到首页角色
     */
    public function getRoles()
    {
        $get = $this->request->get(['name' => '', 'size' => '30', 'page' => '1']);

        $query = RoleModel::field('id,name');
        if ($get['name'] !== '') {
            $query = $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query = $query->order('id', 'asc');
        $roles = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);

        return $this->success('获取成功', $roles);
    }
}