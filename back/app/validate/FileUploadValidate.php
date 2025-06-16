<?php

namespace app\validate;

use think\Validate;

class FileUploadValidate extends Validate
{
    protected $rule = [
        'file' => 'file|fileExt:txt,png,jpg,jpeg,gif,doc,docx,xls,xlsx,ppt,pptx,zip,gz,rar,mp3,mp4|fileSize:'.(1024 * 1024 * 200)
    ];
    protected $message = [
        'file.file' => '文件上传必须是一个文件',
        'file.fileExt' => '此类型的文件不支持上传',
        'file.fileSize' => '上传文件大小超出限制'
    ];
}