<?php

namespace app\entity\mobile;

use app\entity\User as UserEntity;

class Session
{
    public $token = '';
    public UserEntity $user;
}