<?php

namespace app\service\mobile;

use app\model\mobile\TokenModel;
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