<?php

namespace app\service\mobile;

use app\model\mobile\TokenModel;
use app\service\CrudService;
use Exception;

class TokenService extends CrudService
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