<?php

namespace app\mobile\controller;

use app\service\FileService;
use app\validate\UploadFileValidate;
use Exception;
use think\exception\ValidateException;
use think\facade\Filesystem;

class UploadFile extends Base
{
    private $allowModules = ['rich_editor'];

    /**
     * 上传
     * @return void
     */
    public function upload()
    {
        $requestFiles = $this->request->file();
        $module = $this->request->post('module', '');

        //验证
        try {
            validate(UploadFileValidate::class)->check($requestFiles);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        if (!in_array($module, $this->allowModules)) {
            return $this->error('模块文件夹不支持上传');
        }

        $requestFile = $requestFiles['file'];
        try{
            $path = Filesystem::putFile($module, $requestFile);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }
        $file = new FileService();
        $path = str_replace('\\', '/', $path);
        $url = $file->getUrl($path);

        $data = [
            'name' => $requestFile->getOriginalName(),
            'type' => $requestFile->getOriginalMime(),
            'ext' => $requestFile->getOriginalExtension(),
            'size' => $requestFile->getSize(),
            'path' => $path,
            'url' => $url
        ];
        return $this->success("上传成功", $data);
    }
}