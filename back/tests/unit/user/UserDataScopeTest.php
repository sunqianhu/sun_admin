<?php

namespace unit\user;

use app\helper\user\UserDataScopeHelper;
use PHPUnit\Framework\TestCase;

class UserDataScopeTest extends TestCase
{
    public function testAccessUser()
    {
        $userDataScopeHelper = new UserDataScopeHelper();
        if($userDataScopeHelper->canAccessUser(1, 'global_user_access', 1)){
            $this->assertTrue(true);
        }else{
            $this->assertTrue(false);
        }
    }
}