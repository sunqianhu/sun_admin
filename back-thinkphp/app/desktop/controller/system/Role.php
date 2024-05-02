<?php

namespace app\desktop\controller\system;

use app\desktop\controller\Base;
use app\desktop\validate\system\Role as RoleValidate;
use app\model\desktop\Module as DesktopModuleModel;
use app\model\mobile\Module as MobileModuleModel;
use app\model\Role as RoleModel;
use app\model\RoleDesktopModule as RoleDesktopModuleModel;
use app\model\RoleMobileModule as RoleMobileModuleModel;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

/**
 * 角色管理
 */
class Role extends Base
{

    /**
     * 得到首页角色
     */
    public function getIndexRoles()
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
     * 初始化添加页面
     */
    public function initAdd()
    {
        //桌面端模块
        $desktopModuleModels = DesktopModuleModel::field('id, module_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $desktopModules = $desktopModuleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDesktopModules = $arrayHandler->convertTree($desktopModules, 'id', 'module_id', 'children');

        //移动端模块
        $mobileModuleModels = MobileModuleModel::field('id, module_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $mobileModules = $mobileModuleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeMobileModules = $arrayHandler->convertTree($mobileModules, 'id', 'module_id', 'children');

        $data = [
            'desktop_modules'=>$treeDesktopModules,
            'mobile_modules'=>$treeMobileModules,
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['name', 'desktop_module_ids' => [], 'mobile_module_ids' => []]);

        //验证
        try {
            validate(RoleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $roleModel = new RoleModel();
        $roleModel->save($post);

        if (!empty($post['desktop_module_ids'])) {
            foreach($post['desktop_module_ids'] as $desktopModuleId){
                $roleDesktopModuleModel = new RoleDesktopModuleModel();
                $roleDesktopModuleModel->save([
                    'role_id'=>$roleModel->id,
                    'module_id'=>$desktopModuleId
                ]);
            }
        }

        if (!empty($post['mobile_module_ids'])) {
            foreach($post['mobile_module_ids'] as $mobileModuleId){
                $roleMobileModuleModel = new RoleMobileModuleModel();
                $roleMobileModuleModel->save([
                    'role_id'=>$roleModel->id,
                    'module_id'=>$mobileModuleId
                ]);
            }
        }

        return $this->success('添加成功');
    }

    /**
     * 初始化修改
     *
     * @return void
     */
    public function initEdit()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        //角色
        $roleModel = RoleModel::with(['desktopModules', 'mobileModules'])
            ->field('id,name')
            ->find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $role = $roleModel->toArray();

        $role['desktop_module_ids'] = [];
        if (!empty($role['desktopModules'])) {
            $role['desktop_module_ids'] = array_column($role['desktopModules'], 'id');
        }
        $role['mobile_module_ids'] = [];
        if (!empty($role['mobileModules'])) {
            $role['mobile_module_ids'] = array_column($role['mobileModules'], 'id');
        }

        //桌面端模块
        $desktopModuleModels = DesktopModuleModel::field('id, id, module_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $desktopModules = $desktopModuleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDesktopModules = $arrayHandler->convertTree($desktopModules, 'id', 'module_id', 'children');

        //移动端模块
        $mobileModuleModels = MobileModuleModel::field('id, module_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $mobileModules = $mobileModuleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeMobileModules = $arrayHandler->convertTree($mobileModules, 'id', 'module_id', 'children');

        $data = [
            'role' => $role,
            'desktop_modules' => $treeDesktopModules,
            'mobile_modules'=>$treeMobileModules
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'name', 'desktop_module_ids' => [], 'mobile_module_ids' => []]);

        //验证
        try {
            validate(RoleValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $roleModel = RoleModel::find($post['id']);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->save($post);

        //桌面端模块
        $oldDesktopModuleIds = array_column($roleModel->desktopModules->toArray(), 'id');
        $deleteDesktopModuleIds = array_unique(array_values(array_diff($oldDesktopModuleIds, $post['desktop_module_ids'])));
        $addDesktopModuleIds = array_unique(array_values(array_diff($post['desktop_module_ids'], $oldDesktopModuleIds)));
        if(!empty($deleteDesktopModuleIds)){
            foreach($deleteDesktopModuleIds as $deleteDesktopModuleId){
                RoleDesktopModuleModel::where('role_id', $roleModel->id)
                    ->where('module_id', $deleteDesktopModuleId)
                    ->delete();
            }
        }
        if(!empty($addDesktopModuleIds)) {
            foreach($addDesktopModuleIds as $addDesktopModuleId){
                $roleDesktopModuleModel = new RoleDesktopModuleModel();
                $roleDesktopModuleModel->save([
                    'role_id'=>$roleModel->id,
                    'module_id'=>$addDesktopModuleId
                ]);
            }
        }

        //桌面端模块
        $oldDesktopModuleIds = array_column($roleModel->desktopModules->toArray(), 'id');
        $deleteDesktopModuleIds = array_unique(array_values(array_diff($oldDesktopModuleIds, $post['desktop_module_ids'])));
        $addDesktopModuleIds = array_unique(array_values(array_diff($post['desktop_module_ids'], $oldDesktopModuleIds)));
        if(!empty($deleteDesktopModuleIds)){
            foreach($deleteDesktopModuleIds as $deleteDesktopModuleId){
                RoleDesktopModuleModel::where('role_id', $roleModel->id)
                    ->where('module_id', $deleteDesktopModuleId)
                    ->delete();
            }
        }
        if(!empty($addDesktopModuleIds)) {
            foreach($addDesktopModuleIds as $addDesktopModuleId){
                $roleDesktopModuleModel = new RoleDesktopModuleModel();
                $roleDesktopModuleModel->save([
                    'role_id'=>$roleModel->id,
                    'module_id'=>$addDesktopModuleId
                ]);
            }
        }

        //移动端模块
        $oldMobileModuleIds = array_column($roleModel->mobileModules->toArray(), 'id');
        $deleteMobileModuleIds = array_unique(array_values(array_diff($oldMobileModuleIds, $post['mobile_module_ids'])));
        $addMobileModuleIds = array_unique(array_values(array_diff($post['mobile_module_ids'], $oldMobileModuleIds)));
        if(!empty($deleteMobileModuleIds)){
            foreach($deleteMobileModuleIds as $deleteMobileModuleId){
                RoleMobileModuleModel::where('role_id', $roleModel->id)
                    ->where('module_id', $deleteMobileModuleId)
                    ->delete();
            }
        }
        if(!empty($addMobileModuleIds)) {
            foreach($addMobileModuleIds as $addMobileModuleId){
                $roleMobileModuleModel = new RoleMobileModuleModel();
                $roleMobileModuleModel->save([
                    'role_id'=>$roleModel->id,
                    'module_id'=>$addMobileModuleId
                ]);
            }
        }

        return $this->success('修改成功');
    }

    /**
     * 删除
     *
     * @return void
     */
    public function delete()
    {
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $roleModel = RoleModel::find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->delete();
        RoleDesktopModuleModel::where('role_id', $roleModel->id)->delete();
        RoleMobileModuleModel::where('role_id', $roleModel->id)->delete();

        return $this->success('删除成功');
    }
}