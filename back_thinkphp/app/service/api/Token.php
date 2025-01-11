<?php

namespace app\service\api;

use app\model\api\TokenModel;
use app\service\Curd;
use Exception;

class Token extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(TokenModel::class);
    }
}