<?php

namespace app\desktop\controller\layouts;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\service\desktop\SessionService;
use app\service\desktop\DesktopUserService;

/**
 * 主页
 */
class Side extends Base
{
    public $isApiAuth = false;

    /**
     * 得到树形菜单
     * @return void
     */
    public function getTreeMenu()
    {
        $user = new DesktopUserService();
        $treeMenu = $user->getTreeMenu($this->session->userId);

        return $this->success('获取成功', $treeMenu);
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
        $session = new SessionService();
        $session->logout($this->session->token);

        return $this->success("退出成功");
    }
}