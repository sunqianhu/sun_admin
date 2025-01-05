<?php

namespace app\desktop\controller\layouts;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\service\desktop\Session;
use app\service\user\desktop\User;

/**
 * 主页
 */
class Side extends Base
{
    public $isRouteAuth = false;

    /**
     * 得到菜单
     * @return void
     */
    public function getMenus()
    {
        $user = new User();
        $treeMenus = $user->getMenus($this->session->userId);

        return $this->success('获取成功', $treeMenus);
    }

    /**
     * 得到头像
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getAvatar()
    {
        $userModel = UserModel::field('avatar')->find($this->session->userId);
        $avatar = $userModel->avatar_url;

        return $this->success('获取成功', $avatar);
    }

    /**
     * 退出
     * @return void
     */
    public function logout()
    {
        $session = new Session();
        $session->logout($this->session->token);

        return $this->success("退出成功");
    }
}