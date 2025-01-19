<?php

namespace app\service\desktop;

use app\model\desktop\TokenModel;
use app\service\CurdService;
use Exception;

class TokenService extends CurdService
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