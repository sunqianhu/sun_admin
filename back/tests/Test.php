<?php
use app\model\UserModel;
use PHPUnit\Framework\TestCase;

class Test extends TestCase
{
    public function test()
    {
        $userModels = UserModel::select();
        print_r($userModels->toArray());
        $this->assertTrue(true);
    }
}