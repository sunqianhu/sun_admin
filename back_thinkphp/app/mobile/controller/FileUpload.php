<?php

namespace app\mobile\controller;

use Sunqianhu\Helper\File;
use app\validate\FileUploadValidate;
use Exception;
use think\exception\ValidateException;
use think\facade\Filesystem;
use think\Response;

class FileUpload extends Base
{
    private $allowModules = ['rich_editor'];

    /**
     * 上传
     * @return Response
     * @throws Exception
     */
    public function upload()
    {
        $requestFiles = $this->request->file();
        $module = $this->request->post('module', '');

        //验证
        try {
            validate(FileUploadValidate::class)->check($requestFiles);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        if (!in_array($module, $this->allowModules)) {
            return $this->getErrorResponse('模块文件夹不支持上传');
        }

        $requestFile = $requestFiles['file'];
        try{
            $path = Filesystem::putFile($module, $requestFile);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }
        $file = new File();
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
        return $this->getSuccessResponse("上传成功", $data);
    }
}