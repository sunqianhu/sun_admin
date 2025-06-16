<?php
return [
    'root_path'=>env('FILE_ROOT_PATH', app()->getRootPath() . 'public/storage/'), // 根目录
    'access_prefix'=>env('FILE_ACCESS_PREFIX', '/api/storage/') // 访问前缀
];