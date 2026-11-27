<?php

namespace app\helper\user;

use app\model\UserModel;
use app\helper\SiteHelper;
use Exception;
use Sunqianhu\Helper\File;
use Sunqianhu\Helper\Image;
use Sunqianhu\Helper\SingletonFactory;

class AvatarHelper
{
    /**
     * 得到头像url
     * @param $path
     * @return string
     * @throws Exception
     */
    public function getAvatarUrl($path)
    {
        if ($path === '') {
            $path = 'image/avatar.png';
            $siteHelper = SingletonFactory::getInstance(SiteHelper::class);
            return $siteHelper->getUrl($path);
        }

        $file = SingletonFactory::getInstance(File::class);
        return $file->getUrl($path);
    }

    /**
     * 通过用户id得到头像url
     * @param $userId
     * @return string
     * @throws Exception
     */
    public function getAvatarUrlByUserId($userId)
    {
        $userModel = UserModel::field('avatar')->find($userId);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $path = $userModel->avatar;
        return $this->getAvatarUrl($path);
    }

    /**
     * 得到大头像url
     * @param $path
     * @return string
     * @throws Exception
     */
    public function getBigAvatarUrl($path)
    {
        if ($path === '') {
            $path = 'image/big_avatar.png';
            $siteHelper = SingletonFactory::getInstance(SiteHelper::class);
            return $siteHelper->getUrl($path);
        }

        $file = SingletonFactory::getInstance(File::class);
        return $file->getUrl($path);
    }

    /**
     * 通过用户id得到大头像url
     * @param $userId
     * @return string
     * @throws Exception
     */
    public function getBigAvatarUrlByUserId($userId)
    {
        $userModel = UserModel::field('big_avatar')->find($userId);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $path = $userModel->big_avatar;
        return $this->getBigAvatarUrl($path);
    }

    /**
     * 通过base64内容修改头像
     * @param $userId
     * @param $base64ImageContent
     * @throws Exception
     */
    public function editAvatarByBase64Content($userId, $base64ImageContent)
    {
        $image = new Image();
        $bigPath = $image->saveBase64ContentToFile('big_avatar', $base64ImageContent);

        $file = SingletonFactory::getInstance(File::class);
        $fullBigPath = $file->getFullPath($bigPath);
        $image->generateThumbnail($fullBigPath, $fullBigPath, 1000);

        //小头像
        $ext = pathinfo($bigPath, PATHINFO_EXTENSION);
        $smallPath = $file->makeModuleFilePath('avatar', $ext);
        $fullSmallPath = $file->getFullPath($smallPath);
        $image->generateThumbnail($fullBigPath, $fullSmallPath, 100);

        $this->editAvatar($userId, $smallPath, $bigPath);
    }

    /**
     * 修改头像
     * @param $userId
     * @param $smallPath
     * @param $bigPath
     * @return void
     * @throws Exception
     */
    public function editAvatar($userId, $smallPath, $bigPath)
    {
        $userModel = UserModel::find($userId);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $userModel->save([
            'avatar' => $smallPath,
            'big_avatar' => $bigPath
        ]);
    }
}
