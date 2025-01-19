<?php

namespace app\service;

use Exception;
use think\facade\Config;

class FileService
{
    /**
     * 得到访问url
     * @param string $path 路径
     * @throws Exception
     */
    public function getUrl($path)
    {
        if($path === ''){
            throw new Exception('路径参数不能为空');
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
            throw new Exception('路径参数不能为空');
        }
        return Config::get('filesystem.root_path') . $path;
    }

    /**
     * 删除文件
     * @param $path
     * @return void
     * @throws Exception
     */
    public function unlinkFile($path){
        if($path === ''){
            throw new Exception('路径参数不能为空');
        }
        $fullPath = $this->getFullPath($path);
        if(!file_exists($fullPath)){
            throw new Exception('文件不存在');
        }
        if(!is_file($fullPath)){
            throw new Exception('只能删除文件');
        }
        unlink($fullPath);
    }

    /**
     * 创建模块目录
     * @param $module
     * @return string
     * @throws Exception
     */
    public function makeModuleDir($module = ''){
        $rootPath = Config::get('filesystem.root_path'); // 磁盘根目录
        if (empty($rootPath)) {
            throw new Exception('没有配置文件目录');
        }

        $relativeDir = '';
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
    public function saveBase64ImageContentToFile($module, $content)
    {
        $allowMimeTypes = [
            'image/jpg',
            'image/jpeg',
            'image/png',
            'image/gif'
        ];
        $extMap = [
            'image/jpg'=>'jpg',
            'image/jpeg'=>'jpeg',
            'image/png'=>'png',
            'image/gif'=>'gif'
        ];
        if (empty($content)) {
            throw new Exception('图片base64内容不能为空');
        }
        $contents = explode(';base64,', $content);
        $mimeType = $contents[0];
        $mimeType = str_replace('data:', '', $mimeType);
        if(empty($mimeType)){
            throw new Exception('没有获取到图片的mime类型');
        }
        if(!in_array($mimeType, $allowMimeTypes)){
            throw new Exception('此图片mime类型不支持');
        }
        $ext = $extMap[$mimeType];
        $base64Content = $contents[1] ?? '';
        $decodeContent = base64_decode($base64Content);

        $relativeDir = $this->makeModuleDir($module);
        $fileName = md5(time() .'_sun_'. rand(1000, 9999)) . '.' . $ext;
        $path = $relativeDir . $fileName; // 文件相对路径
        $fullPath = $this->getFullPath($path); // 全文件路径

        if (!file_put_contents($fullPath, $decodeContent)) {
            throw new Exception('文件保存到磁盘失败');
        }

        return $path;
    }
}