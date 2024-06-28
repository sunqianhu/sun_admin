<?php

namespace app\desktop\controller\main\user;

use app\desktop\controller\Base;
use app\model\User as UserModel;
use app\service\File;
use Sunqianhu\Helper\Image;
use think\exception\ValidateException;
use think\facade\Config;

class Avatar extends Base
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
        $userModel = UserModel::field('avatar')->find($this->user->id);
        $avatar = $userModel->front_avatar_url;

        return $this->success('获取成功', $avatar);
    }

    /**
     * 保存
     * @return \think\Response
     */
    public function save()
    {
        $post = $this->request->post(['avatar_base64_content']);

        try {
            validate(MyValidate::class)->scene('edit_avatar')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $file = new File();
        $path = '';
        try {
            $path = $file->saveBase64ContentToFile('avatar', $post['avatar_base64_content']);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }
        $url = $file->getUrl($path);

        $rootPath = Config::get('filesystem.root_path');
        $fullPath = $rootPath . $path;
        $image = new Image();
        try {
            $image->thumbnail($fullPath, $fullPath, 100, 100);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        $userModel = UserModel::find($this->user->id);
        $userModel->avatar = $path;
        $userModel->save();

        return $this->success('修改成功', $url);
    }
}