<?php

return [
    'root_path' => env('SITE_ROOT_PATH', app()->getRootPath() . 'public/'), //根目录
    'access_prefix'=>env('SITE_ACCESS_PREFIX', '/api/') //访问前缀
];