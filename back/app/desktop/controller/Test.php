<?php

namespace app\desktop\controller;

use app\helper\JwtHelper;

class Test
{
    public function index()
    {
        $jwtHelper = new JwtHelper();
        $token = $jwtHelper->generateToken(333);
        $token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzU1MDYzMTQ3fQ.0xLIBSbHR8zLIlATR-SyK0fA85MO0dForejuIXsW-ws';
        $dd = $jwtHelper->resolverToken($token);
        print_r($dd);
    }
}