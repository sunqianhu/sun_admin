<?php

namespace app\desktop\controller;

use app\service\FileService as FileHelper;
use app\validate\FileUploadValidate as FileUploadValidate;
use think\exception\ValidateException;
use think\facade\Filesystem;

class FileUpload extends Base
{
    private $allowModules = ['rich_editor'];

    /**
     * 上传
     * @return void
     */
    public function upload()
    {
        $requestFile = $this->request->file();
        $module = $this->request->post('module', ''); //权限

        //验证
        try {
            validate(FileUploadValidate::class)->check($requestFile);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        if (!in_array($module, $this->allowModules)) {
            return $this->error('权限参数不允许');
        }

        $fileHelper = new FileHelper();
        $file = $requestFile['file'];
        try{
            $path = Filesystem::putFile($module, $file);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }
        $path = str_replace('\\', '/', $path);
        $url = $fileHelper->getUrl($path);

        $data = [
            'name' => $file->getOriginalName(),
            'type' => $file->getOriginalMime(),
            'ext' => $file->getOriginalExtension(),
            'size' => $file->getSize(),
            'path' => $path,
            'url' => $url
        ];
        return $this->success("上传成功", $data);
    }
}