<?php

namespace app\service;

use app\model\UserModel;
use Exception;
use Sunqianhu\Helper\File;
use Sunqianhu\Helper\Image;
use Sunqianhu\Helper\SingletonFactory;
use Sunqianhu\Helper\thinkphp\Crud;

class UserAvatarService
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
            $siteService = SingletonFactory::getInstance(SiteService::class);
            return $siteService->getUrl($path);
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
        $userCrud = new Crud(UserModel::class);
        $path = $userCrud->selectValue($userId, 'avatar');
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
            $siteService = SingletonFactory::getInstance(SiteService::class);
            return $siteService->getUrl($path);
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
        $userCrud = new Crud(UserModel::class);
        $path = $userCrud->selectValue($userId, 'big_avatar');
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
        $relativeDir = $file->makeModuleDir('avatar');
        $ext = pathinfo($bigPath, PATHINFO_EXTENSION);
        $fileName = md5(time() .'_sun_'. rand(1000, 9999)) . '.' . $ext;
        $smallPath = $relativeDir . $fileName;
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
        $userCrud = new Crud(UserModel::class);
        $userCrud->update($userId, [
            'avatar' => $smallPath,
            'big_avatar' => $bigPath
        ]);
    }
}