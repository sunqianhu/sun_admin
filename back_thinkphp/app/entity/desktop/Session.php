<?php

namespace app\entity\desktop;

use app\entity\User as UserEntity;

class Session
{
    public $token = '';
    public UserEntity $user;
}