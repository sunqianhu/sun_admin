<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\RoleService;
use Exception;

class Index extends Base
{
    /**
     * 得到角色分页
     */
    public function getRolePaginate()
    {
        $get = $this->request->get(['name' => '', 'size' => '30', 'page' => '1']);

        $query = RoleModel::field('id,name');
        if ($get['name'] !== '') {
            $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query->order('id', 'asc');
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $rolePaginate = $paginate->toArray();

        return $this->success('获取成功', $rolePaginate);
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

        $role = new RoleService();
        try{
            $role->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}