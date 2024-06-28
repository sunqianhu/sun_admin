<?php

namespace app\service;

use Exception;
use think\facade\Config;

class File
{
    /**
     * 得到访问url
     * @param string $path 路径
     */
    public function getUrl($path)
    {
        if($path === ''){
            return '';
        }

        return Config::get('filesystem.access_prefix') . $path;
    }

    /**
     * 得到全路径
     * @param $path
     * @return string
     */
    public function getFullPath($path){
        if($path === ''){
            return '';
        }
        $rootPath = Config::get('filesystem.root_path');
        return $rootPath . $path;
    }

    /**
     * 创建权限目录
     * @param $module
     * @return string
     * @throws Exception
     */
    public function makePermissionDir($module = ''){
        $rootPath = Config::get('filesystem.root_path'); // 磁盘根目录
        if (empty($rootPath)) {
            throw new Exception('没有配置文件目录');
        }

        if ($module != '') {
            $relativeDir = $module . '/';
        }
        $relativeDir .= date('Y/m/d') . '/'; // 目录
        $fullDir = $rootPath . $relativeDir;
        if (!file_exists($fullDir)) {
            if (!@mkdir($fullDir, 0755, true)) {
                throw new Exception('目录创建失败');
            }
        }

        return $relativeDir;
    }

    /**
     * 保存base64内容到文件
     * @param $module
     * @param $content
     * @return string
     * @throws Exception
     */
    public function saveBase64ContentToFile($module, $content)
    {
        $allowMimeTypes = [
            'image/jpg',
            'image/jpeg',
            'image/png',
            'image/gif',
            'text/plain'
        ];
        $extMap = [
            'image/jpg'=>'jpg',
            'image/jpeg'=>'jpeg',
            'image/png'=>'png',
            'image/gif'=>'gif',
            'text/plain'=>'txt'
        ];
        if (empty($content)) {
            throw new Exception('base64内容不能为空');
        }
        $contents = explode(';base64,', $content);
        $mimeType = $contents[0];
        $mimeType = str_replace('data:', '', $mimeType);
        if(empty($mimeType)){
            throw new Exception('没有获取到mime类型');
        }
        if(!in_array($mimeType, $allowMimeTypes)){
            throw new Exception('此mime类型的内容不允许');
        }
        $ext = $extMap[$mimeType];
        $base64Content = $contents[1] ?? '';
        if(empty($base64Content)){
            throw new Exception('没有得到内容');
        }
        $decodeContent = base64_decode($base64Content);

        $relativeDir = $this->makePermissionDir($module);
        $fileName = md5(time() . rand(1000, 9999)) . '.' . $ext;
        $path = $relativeDir . $fileName; // 文件相对路径
        $fullPath = $this->getFullPath($path); // 全文件路径

        if (!file_put_contents($fullPath, $decodeContent)) {
            throw new Exception('文件保存失败');
        }

        return $path;
    }
}