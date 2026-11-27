<?php

namespace unit\user;

use app\helper\user\DataScopeHelper;
use PHPUnit\Framework\TestCase;

class UserDataScopeTest extends TestCase
{
    public function testAccessUser()
    {
        $dataScopeHelper = new DataScopeHelper();
        if($dataScopeHelper->canAccessUser(1, 'global_user_access', 1)){
            $this->assertTrue(true);
        }else{
            $this->assertTrue(false);
        }
    }
}