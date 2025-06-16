<?php

return [
    // 默认磁盘
    'default' => 'public',
    // 磁盘列表
    'disks'   => [
        'local'  => [
            'type' => 'local',
            'root' => app()->getRuntimePath() . 'storage',
        ],
        'public' => [
            // 磁盘类型
            'type'       => 'local',
            // 磁盘路径
            'root'       => env('FILE_ROOT_PATH', app()->getRootPath() . 'public/storage/'),
            // 磁盘路径对应的外部URL路径
            'url'        => env('FILE_ACCESS_PREFIX', '/api/storage/'),
            // 可见性
            'visibility' => 'public',
        ],
        // 更多的磁盘配置信息
    ]
];
