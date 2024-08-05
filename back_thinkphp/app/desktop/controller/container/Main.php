<?php

namespace app\desktop\controller\container;

use app\desktop\controller\Base;
use app\model\User as UserModel;
use app\service\desktop\Session as SessionService;
use app\service\user\Desktop as DesktopService;
use app\service\Watermark as WatermarkService;

/**
 * 主页
 */
class Main extends Base
{
    /**
     * 得到菜单
     * @return void
     */
    public function getMenus()
    {
        $desktopService = new DesktopService();
        $treeMenus = $desktopService->getMenus($this->session->userId);

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
     * 得到水印
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getWatermark()
    {
        $watermarkService = new WatermarkService();
        $watermarkEntity = $watermarkService->getWatermark($this->session->userId);
        $watermark = $watermarkEntity->toArray();

        return $this->success('获取成功', $watermark);
    }

    /**
     * 退出
     * @return void
     */
    public function logout()
    {
        $sessionService = new SessionService();
        $sessionService->logout($this->session->token);

        return $this->success("退出成功");
    }
}