<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\Role as RoleModel;
use app\service\Role as RoleService;

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

    /**
     * 删除
     * @return \think\Response|void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $roleService = new RoleService();
        try{
            $roleService->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}