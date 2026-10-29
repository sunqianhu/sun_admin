<?php

// 在项目根目录执行：php back/script/permission_migrate.php
// 使用 back/.env 中的连接配置，迁移前备份涉及的旧表。
if (PHP_SAPI !== 'cli') {
    exit('仅允许命令行执行');
}

chdir(dirname(__DIR__));
require 'vendor/autoload.php';

use think\App;
use think\facade\Db;

$app = new App();
$app->initialize();
$db = Db::connect();
$prefix = $db->getConfig('prefix');
$tableName = static function ($name) use ($prefix) {
    return chr(96) . str_replace(chr(96), chr(96) . chr(96), $prefix . $name) . chr(96);
};
$tables = $db->getTables();

// 为现有桌面端权限补充命名空间，已使用终端前缀的标识不重复处理。
$addDesktopPrefix = static function () use ($db) {
    $permissions = $db->name('permission')->field('id,key')->lock(true)->select()->toArray();
    $updates = [];
    foreach ($permissions as $permission) {
        $key = $permission['key'];
        if (strpos($key, 'desktop_') === 0 || strpos($key, 'mobile_') === 0
            || (strpos($key, 'api_') === 0 && $key !== 'api_token_generate')) {
            continue;
        }
        $newKey = 'desktop_' . $key;
        if (mb_strlen($newKey, 'UTF-8') > 127) {
            throw new RuntimeException('增加前缀后权限标识超过127个字符：' . $key);
        }
        $updates[] = ['id' => $permission['id'], 'key' => $newKey];
    }
    // 通过唯一索引避免覆盖同名权限；冲突时由外层事务整体回滚。
    foreach ($updates as $data) {
        $db->name('permission')->where('id', $data['id'])->update(['key' => $data['key']]);
    }
    return count($updates);
};

$oldTables = [
    'desktop_permission', 'mobile_permission',
    'role_desktop_permission', 'role_mobile_permission'
];
$newTables = ['permission', 'role_permission'];

if (!in_array($prefix . 'desktop_permission', $tables, true)
    && in_array($prefix . 'permission', $tables, true)
    && in_array($prefix . 'role_permission', $tables, true)) {
    Db::startTrans();
    try {
        $count = $addDesktopPrefix();
        Db::commit();
    } catch (Throwable $exception) {
        Db::rollback();
        throw $exception;
    }
    echo '权限已经统一，本次为' . $count . "条权限补充桌面端前缀。\n";
    exit;
}
foreach ($oldTables as $name) {
    if (!in_array($prefix . $name, $tables, true)) {
        throw new RuntimeException('缺少旧表：' . $name);
    }
}
foreach ($newTables as $name) {
    if (in_array($prefix . $name, $tables, true)) {
        throw new RuntimeException('目标表已经存在，请先处理上次未完成的迁移：' . $name);
    }
}

// 备份权限、导航和角色关联，不涉及用户密码或会话。
$backupTables = array_merge($oldTables, [
    'desktop_menu', 'desktop_route', 'role_desktop_menu', 'role_desktop_route'
]);
$source = [];
$backup = "-- 权限统一迁移前备份\nSET NAMES utf8mb4;\n";
foreach ($backupTables as $name) {
    $fullName = $tableName($name);
    $definition = $db->query('SHOW CREATE TABLE ' . $fullName)[0]['Create Table'];
    $backup .= "\nDROP TABLE IF EXISTS " . $fullName . ";\n" . $definition . ";\n";
    $source[$name] = $db->name($name)->select()->toArray();
    foreach ($source[$name] as $row) {
        $values = array_map(static function ($value) use ($db) {
            return $value === null ? 'NULL' : $db->getPdo()->quote((string) $value);
        }, array_values($row));
        $backup .= 'INSERT INTO ' . $fullName . ' VALUES (' . implode(',', $values) . ");\n";
    }
}
$backupPath = getcwd() . '/runtime/permission_before_' . date('Ymd_His') . '_' . bin2hex(random_bytes(3)) . '.sql';
if (file_put_contents($backupPath, $backup) === false) {
    throw new RuntimeException('保存迁移备份失败');
}
echo '迁移前备份：' . $backupPath . "\n";

$normalizeKey = static function ($key) {
    return preg_replace('/^system_(desktop|mobile)_permission(?=_|$)/', 'system_permission', $key);
};
$normalizeApis = static function ($value) {
    $value = preg_replace('/desktop\/system\.(desktop|mobile)\.permission\./i', 'desktop/system.permission.', $value ?? '');
    $apis = preg_split('/\r\n|\r|\n/', $value);
    $apis = array_map(static function ($api) {
        return ltrim(trim($api), '/');
    }, $apis);
    return implode("\n", array_unique(array_filter($apis, 'strlen')));
};

// 桌面端保留原ID，移动端生成新ID。只合并旧权限管理模块的对应操作。
$permissions = [];
$idMaps = ['desktop' => [0 => 0], 'mobile' => [0 => 0]];
$usedKeys = [];
$managementIds = [];
$parents = [];
$renamedKeys = [];
$nextId = 0;
$systemId = 0;
foreach ($source['desktop_permission'] as $row) {
    $nextId = max($nextId, (int) $row['id']);
    if ($row['key'] === 'system') {
        $systemId = (int) $row['id'];
    }
}
foreach (['desktop', 'mobile'] as $terminal) {
    foreach ($source[$terminal . '_permission'] as $row) {
        $oldId = (int) $row['id'];
        $key = $normalizeKey(trim($row['key'] ?? ''));
        $apis = $normalizeApis($row['api_string']);
        $isManagement = $key === 'system_permission' || strpos($key, 'system_permission_') === 0;
        if ($isManagement && isset($managementIds[$key])) {
            $id = $managementIds[$key];
            $idMaps[$terminal][$oldId] = $id;
            $permissions[$id]['api_string'] = $normalizeApis($permissions[$id]['api_string'] . "\n" . $apis);
            continue;
        }
        $id = $terminal === 'desktop' ? $oldId : ++$nextId;
        $baseKey = $key !== '' ? $key : $terminal . '_permission_' . $oldId;
        $key = $baseKey;
        $suffix = 0;
        while (isset($usedKeys[strtolower($key)])) {
            $ending = '_' . $terminal . '_' . $oldId . ($suffix ? '_' . $suffix : '');
            $key = mb_substr($baseKey, 0, 127 - strlen($ending), 'UTF-8') . $ending;
            $suffix++;
        }
        if ($key !== $baseKey) {
            $renamedKeys[] = $baseKey . ' => ' . $key;
        }
        $row['id'] = $id;
        $row['key'] = $key;
        $row['api_string'] = $apis;
        $permissions[$id] = $row;
        $parents[$id] = [$terminal, (int) $row['permission_id']];
        $idMaps[$terminal][$oldId] = $id;
        $usedKeys[strtolower($key)] = true;
        if ($isManagement) {
            $managementIds[$key] = $id;
        }
    }
}
foreach ($parents as $id => [$terminal, $parentId]) {
    if (!isset($idMaps[$terminal][$parentId])) {
        throw new RuntimeException('权限存在无效的上级ID：' . $terminal . '/' . $parentId);
    }
    $permissions[$id]['permission_id'] = $idMaps[$terminal][$parentId];
    if ($permissions[$id]['key'] === 'system_permission') {
        $permissions[$id]['permission_id'] = $systemId;
        $permissions[$id]['name'] = '权限管理';
        $permissions[$id]['sort'] = 8;
    }
}
$rolePermissions = [];
foreach (['desktop', 'mobile'] as $terminal) {
    foreach ($source['role_' . $terminal . '_permission'] as $row) {
        if (!isset($idMaps[$terminal][$row['permission_id']])) {
            continue;
        }
        $permissionId = $idMaps[$terminal][$row['permission_id']];
        $rolePermissions[$row['role_id'] . ':' . $permissionId] = [
            'role_id' => $row['role_id'],
            'permission_id' => $permissionId
        ];
    }
}

$createdTables = [];
$committed = false;
try {
    $keyColumn = chr(96) . 'key' . chr(96);
    $db->execute('CREATE TABLE ' . $tableName('permission') . ' (
        id int unsigned NOT NULL AUTO_INCREMENT,
        permission_id int unsigned NOT NULL DEFAULT 0 COMMENT \'上级权限id\',
        name varchar(31) NOT NULL DEFAULT \'\' COMMENT \'权限名称\',
        ' . $keyColumn . ' varchar(127) NOT NULL DEFAULT \'\' COMMENT \'权限标识\',
        api_string text COMMENT \'接口地址串\',
        sort int unsigned NOT NULL DEFAULT 0 COMMENT \'排序\',
        PRIMARY KEY (id),
        UNIQUE KEY permission_key (' . $keyColumn . '),
        KEY permission_id (permission_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=\'全站权限\'');
    $createdTables[] = 'permission';
    $db->execute('CREATE TABLE ' . $tableName('role_permission') . ' (
        id int unsigned NOT NULL AUTO_INCREMENT,
        role_id int unsigned NOT NULL COMMENT \'角色id\',
        permission_id int unsigned NOT NULL COMMENT \'权限id\',
        PRIMARY KEY (id),
        UNIQUE KEY role_permission (role_id, permission_id),
        KEY permission_id (permission_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=\'角色权限关系\'');
    $createdTables[] = 'role_permission';

    Db::startTrans();
    $db->name('permission')->insertAll(array_values($permissions));
    if ($rolePermissions) {
        $db->name('role_permission')->insertAll(array_values($rolePermissions));
    }

    // 合并权限管理菜单和路由，并迁移原来的角色导航授权。
    foreach ([
        ['desktop_menu', 'menu_id', 'url', 'role_desktop_menu'],
        ['desktop_route', 'route_id', 'path', 'role_desktop_route']
    ] as [$name, $relationField, $pathField, $relationTable]) {
        $rows = $source[$name];
        $oldPaths = ['/system/desktop/permission', '/system/mobile/permission'];
        $candidates = array_values(array_filter($rows, static function ($row) use ($pathField, $oldPaths) {
            return in_array($row[$pathField], array_merge(['/system/permission'], $oldPaths), true);
        }));
        if (!$candidates) {
            continue;
        }
        $target = $candidates[0];
        $updates = [$pathField => '/system/permission', 'name' => '权限管理'];
        if ($name === 'desktop_menu') {
            // 从“桌面端”分组提升至其上级“系统管理”。
            foreach ($rows as $row) {
                if ((int) $row['id'] === (int) $target['menu_id']) {
                    if (in_array($row['name'], ['桌面端', '移动端'], true)) {
                        $updates['menu_id'] = $row['menu_id'];
                    }
                    break;
                }
            }
            $updates['sort'] = 8;
        } else {
            $updates['key'] = 'system_permission';
            $updates['component_path'] = 'system/permission/Index.vue';
        }
        $db->name($name)->where('id', $target['id'])->update($updates);
        $candidateIds = array_column($candidates, 'id');
        $relations = [];
        foreach ($source[$relationTable] as $relation) {
            $id = in_array($relation[$relationField], $candidateIds) ? $target['id'] : $relation[$relationField];
            $relations[$relation['role_id'] . ':' . $id] = [
                'role_id' => $relation['role_id'],
                $relationField => $id
            ];
        }
        $db->name($relationTable)->where('id', '>', 0)->delete();
        if ($relations) {
            $db->name($relationTable)->insertAll(array_values($relations));
        }
        foreach ($candidates as $candidate) {
            if ($candidate['id'] == $target['id']) {
                continue;
            }
            if ($name === 'desktop_menu') {
                $db->name($name)->where('menu_id', $candidate['id'])->update(['menu_id' => $target['id']]);
            }
            $db->name($name)->where('id', $candidate['id'])->delete();
        }
    }

    // 清理因旧移动端权限管理入口移除而留下的空分组。
    $mobileGroup = $db->name('permission')->where('key', 'system_mobile')->find();
    if ($mobileGroup && empty($mobileGroup['api_string'])
        && !$db->name('permission')->where('permission_id', $mobileGroup['id'])->count()) {
        $db->name('role_permission')->where('permission_id', $mobileGroup['id'])->delete();
        $db->name('permission')->where('id', $mobileGroup['id'])->delete();
    }
    foreach ($db->name('desktop_menu')->where('name', '移动端')->where('url', '')->select() as $group) {
        if (!$db->name('desktop_menu')->where('menu_id', $group['id'])->count()) {
            $db->name('role_desktop_menu')->where('menu_id', $group['id'])->delete();
            $db->name('desktop_menu')->where('id', $group['id'])->delete();
        }
    }
    $addDesktopPrefix();
    Db::commit();
    $committed = true;

    // 新表和导航提交成功后，移除旧权限表。备份可用于恢复。
    $db->execute('DROP TABLE ' . implode(', ', array_map($tableName, $oldTables)));
} catch (Throwable $exception) {
    if (!$committed) {
        Db::rollback();
        foreach (array_reverse($createdTables) as $name) {
            $db->execute('DROP TABLE IF EXISTS ' . $tableName($name));
        }
    }
    throw $exception;
}

echo "权限、角色授权、菜单和路由迁移完成。\n";
foreach ($renamedKeys as $key) {
    echo '保留同名业务权限并调整冲突标识：' . $key . "\n";
}
