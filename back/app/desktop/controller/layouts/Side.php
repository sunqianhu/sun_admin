<?php

namespace app\desktop\controller\layouts;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\service\desktop\SessionService;
use app\service\desktop\DesktopUserService;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

/**
 * 主页
 */
class Side extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树形菜单
     * @return Response
     */
    public function getTreeMenu()
    {
        $desktopUserService = new DesktopUserService();
        $treeMenu = $desktopUserService->getTreeMenu($this->userId);

        return $this->getSuccessResonse('获取成功', $treeMenu);
    }

    /**
     * 得到头像
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getAvatar()
    {
        $userModel = UserModel::field('avatar')->find($this->userId);
        $avatar = $userModel->avatar_url;

        return $this->getSuccessResonse('获取成功', $avatar);
    }

    /**
     * 退出
     * @return Response
     */
    public function logout()
    {
        $sessionService = new SessionService();
        $sessionService->logout($this->sessionId);

        return $this->getSuccessResonse("退出成功");
    }
}