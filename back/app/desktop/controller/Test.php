<?php

namespace app\desktop\controller;

use app\service\JwtService;

class Test
{
    public function index()
    {
        $jwtService = new JwtService();
        $token = $jwtService->generateToken(333);
        $token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzU1MDYzMTQ3fQ.0xLIBSbHR8zLIlATR-SyK0fA85MO0dForejuIXsW-ws';
        $dd = $jwtService->resolverToken($token);
        print_r($dd);
    }
}