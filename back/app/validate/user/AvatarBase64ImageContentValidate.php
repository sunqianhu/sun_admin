<?php

namespace app\validate\user;

use think\Validate;

class AvatarBase64ImageContentValidate extends Validate
{
    protected $rule = [
        'avatar_base64_image_content'  =>  'require'
    ];
    protected $message = [
        'avatar_base64_image_content.require' => '头像内容不能为空'
    ];
}