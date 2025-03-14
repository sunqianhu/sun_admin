<?php

namespace app\entity;

class SessionEntity
{
    /**
     * @var int 用户id
     */
    public int $userId = 0;

    /**
     * @var int 部门id
     */
    public int $departmentId = 0;

    /**
     * @var string 访问凭证
     */
    public string $token = '';
}