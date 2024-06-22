<?php

namespace app\desktop\controller\frame;

use app\desktop\controller\Base;
use app\service\File as FileHelper;
use app\validate\UploadFile as UploadFileValidate;
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
        $requestFile = $this->request->file();
        $module = $this->request->post('permission', ''); //模块

        //验证
        try {
            validate(UploadFileValidate::class)->check($requestFile);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        if (!in_array($module, $this->allowModules)) {
            return $this->error('模块参数不允许');
        }

        $fileHelper = new FileHelper();
        $file = $requestFile['file'];
        $path = Filesystem::putFile($module, $file);
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