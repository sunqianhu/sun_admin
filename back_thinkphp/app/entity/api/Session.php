<?php

namespace app\entity\api;

use app\entity\User as UserEntity;

class Session
{
    public $token = '';
    public UserEntity $user;
}