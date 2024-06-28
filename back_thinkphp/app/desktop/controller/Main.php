<?php

namespace app\desktop\controller;

use app\service\desktop\Session as SessionService;
use app\model\User as UserModel;
use app\service\Config as ConfigHelper;
use app\service\user\Desktop as DesktopService;
use app\service\Watermark as WatermarkService;

/**
 * 主页
 */
class Main extends Base
{
    /**
     * 初始化
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function init()
    {
        $configHelper = new ConfigHelper();
        $version = $configHelper->getValue('version');

        $data = [
            'version' => $version
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 得到菜单
     * @return void
     */
    public function getMenus()
    {
        $desktopService = new DesktopService();
        $treeMenus = $desktopService->getMenus($this->session->user->id);

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
        $userModel = UserModel::field('avatar')->find($this->session->user->id);
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
        $watermarkEntity = $watermarkService->getWatermark($this->session->user->id);
        $watermark = $watermarkEntity->toArray();

        return $this->success('获取成功', $watermark);
    }

    /**
     * 退出
     * @return void
     */
    public function logout()
    {
        $sSessionService = new SessionService();
        $sSessionService->logout($this->session->token);

        return $this->success("退出成功");
    }
}