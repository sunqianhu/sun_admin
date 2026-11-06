<?php

namespace unit;

use app\helper\UserHelper;
use Exception;
use PHPUnit\Framework\TestCase;

class UserTest extends TestCase
{
    public function testNameGet()
    {
        $userHelper = new UserHelper();
        try{
            $name = $userHelper->getName(1);
            $this->assertTrue(true);
        }catch (Exception $exception){
            $this->assertTrue(false);
        }
    }
}