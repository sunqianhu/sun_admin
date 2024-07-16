/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : sun_admin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2024-07-16 12:33:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for api_token
-- ----------------------------
DROP TABLE IF EXISTS `api_token`;
CREATE TABLE `api_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `token` text NOT NULL COMMENT 'token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `token` (`token`(128)) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of api_token
-- ----------------------------
INSERT INTO `api_token` VALUES ('1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjM1MTk1MjAwIDE3MjExMDQyNzIifQ.m4TTbTUURTJbpvmWg3OBjFF54TP9FeV3T1BqV4UUL3U', '1752640335', '1');
INSERT INTO `api_token` VALUES ('2', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk2OTAzMjAwIDE3MjExMDQzNTcifQ.8KAvosRvudDjGb7GGAWvs92h_N3VNGR00HJUo6_LlHs', '1752640358', '1');

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `key` varchar(128) NOT NULL DEFAULT '' COMMENT '键',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='配置';

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('2', 'denied_ip_string', '');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级部门id',
  `type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '部门名称',
  `sort` int(255) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='部门';

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '0', '1', '部门1', '1');
INSERT INTO `department` VALUES ('2', '1', '2', '部门1-1', '1');
INSERT INTO `department` VALUES ('3', '0', '1', '部门2', '2');

-- ----------------------------
-- Table structure for desktop_menu
-- ----------------------------
DROP TABLE IF EXISTS `desktop_menu`;
CREATE TABLE `desktop_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级菜单id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `url` varchar(256) NOT NULL DEFAULT '' COMMENT '菜单网址',
  `icon` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `target` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '打开方式',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='菜单';

-- ----------------------------
-- Records of desktop_menu
-- ----------------------------
INSERT INTO `desktop_menu` VALUES ('1', '0', '系统管理', '', 'Setting', '1', '999');
INSERT INTO `desktop_menu` VALUES ('2', '1', '用户管理', '/system/user', 'User', '1', '3');
INSERT INTO `desktop_menu` VALUES ('3', '1', '部门管理', '/system/department', 'Memo', '1', '5');
INSERT INTO `desktop_menu` VALUES ('4', '1', '角色管理', '/system/role', 'ChatSquare', '1', '7');
INSERT INTO `desktop_menu` VALUES ('5', '6', '菜单管理', '/system/desktop/menu', 'Reading', '1', '3');
INSERT INTO `desktop_menu` VALUES ('6', '1', '桌面端', '', 'Monitor', '1', '9');
INSERT INTO `desktop_menu` VALUES ('7', '6', '路由管理', '/system/desktop/route', 'Van', '1', '1');
INSERT INTO `desktop_menu` VALUES ('8', '6', '权限管理', '/system/desktop/permission', 'Lock', '1', '5');
INSERT INTO `desktop_menu` VALUES ('9', '1', '移动端', '', 'Iphone', '1', '11');
INSERT INTO `desktop_menu` VALUES ('10', '9', '权限管理', '/system/mobile/permission', 'Lock', '1', '1');
INSERT INTO `desktop_menu` VALUES ('11', '1', '字典管理', '/system/dictionary', 'Notebook', '1', '13');
INSERT INTO `desktop_menu` VALUES ('12', '1', '系统设置', '/system/config', 'Cpu', '1', '1');
INSERT INTO `desktop_menu` VALUES ('13', '1', '登录日志', '/system/login-log', 'MapLocation', '1', '15');
INSERT INTO `desktop_menu` VALUES ('14', '1', '操作日志', '/system/operation-log', 'Mouse', '1', '17');
INSERT INTO `desktop_menu` VALUES ('15', '0', '系统首页', '/index', 'House', '1', '1');
INSERT INTO `desktop_menu` VALUES ('16', '0', '统计分析', '', 'PieChart', '1', '801');
INSERT INTO `desktop_menu` VALUES ('17', '16', '趋势统计', '/statistic/trend', 'Share', '1', '1');
INSERT INTO `desktop_menu` VALUES ('18', '16', '部门统计', '/statistic/department', 'OfficeBuilding', '1', '3');
INSERT INTO `desktop_menu` VALUES ('19', '0', '外部链接', 'https://www.baidu.com', 'Search', '9', '803');

-- ----------------------------
-- Table structure for desktop_permission
-- ----------------------------
DROP TABLE IF EXISTS `desktop_permission`;
CREATE TABLE `desktop_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `permission_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级权限id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '权限名称',
  `key` varchar(128) DEFAULT '' COMMENT '权限key',
  `api_string` varchar(1024) NOT NULL DEFAULT '' COMMENT '接口地址串',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COMMENT='权限';

-- ----------------------------
-- Records of desktop_permission
-- ----------------------------
INSERT INTO `desktop_permission` VALUES ('1', '0', '系统管理', 'system', '', '99');
INSERT INTO `desktop_permission` VALUES ('2', '1', '用户管理', 'system_user', '/desktop/system.user.Index/init\n/desktop/system.user.Index/getUsers', '3');
INSERT INTO `desktop_permission` VALUES ('3', '2', '添加用户', 'system_user_add', '/desktop/system.user.Add/init\n/desktop/system.user.Add/save', '3');
INSERT INTO `desktop_permission` VALUES ('4', '2', '修改用户', 'system_user_edit', '/desktop/system.user.Edit/init\n/desktop/system.user.Edit/save', '5');
INSERT INTO `desktop_permission` VALUES ('5', '2', '修改密码', 'system_user_edit_password', '/desktop/system.user.EditPassword/save', '7');
INSERT INTO `desktop_permission` VALUES ('6', '2', '修改状态', 'system_user_edit_status', '/desktop/system.user.Index/editStatus', '9');
INSERT INTO `desktop_permission` VALUES ('7', '2', '踢下线', 'system_user_offline', '/desktop/system.user.Index/offline', '11');
INSERT INTO `desktop_permission` VALUES ('8', '1', '系统设置', 'system_config', '/desktop/system.config.Index/init\n/desktop/system.config.Index/save', '1');
INSERT INTO `desktop_permission` VALUES ('9', '1', '部门管理', 'system_department', '/desktop/system.department.Index/init\n/desktop/system.department.Index/getDepartments', '5');
INSERT INTO `desktop_permission` VALUES ('10', '1', '角色管理', 'system_role', '/desktop/system.role.Index/init\n/desktop/system.role.Index/getRoles', '7');
INSERT INTO `desktop_permission` VALUES ('11', '1', '桌面端', 'system_desktop', '', '9');
INSERT INTO `desktop_permission` VALUES ('12', '11', '路由管理', 'system_desktop_route', '/desktop/system.desktop.route.Index/init\n/desktop/system.desktop.route.Index/getRoutes', '1');
INSERT INTO `desktop_permission` VALUES ('13', '11', '菜单管理', 'system_desktop_menu', '/desktop/system.desktop.menu.Index/init\n/desktop/system.desktop.menu.Index/getMenus', '3');
INSERT INTO `desktop_permission` VALUES ('14', '11', '权限管理', 'system_desktop_permission', '/desktop/system.desktop.permission.Index/init\n/desktop/system.desktop.permission.Index/getPermissions', '5');
INSERT INTO `desktop_permission` VALUES ('15', '1', '移动端', 'system_mobile', '', '11');
INSERT INTO `desktop_permission` VALUES ('16', '15', '权限管理', 'system_mobile_permission', '/desktop/system.mobile.permission.Index/init\n/desktop/system.mobile.permission.Index/getPermissions', '1');
INSERT INTO `desktop_permission` VALUES ('17', '1', '字典管理', 'system_dictionary', '/desktop/system.dictionary.Index/init\n/desktop/system.dictionary.Index/getDictionarys', '13');
INSERT INTO `desktop_permission` VALUES ('18', '1', '登录日志', 'system_login_log', '/desktop/system.login_log.Index/getLoginLogs', '15');
INSERT INTO `desktop_permission` VALUES ('19', '1', '操作日志', 'system_operation_log', '/desktop/system.operation_log.Index/getOperationLogs', '17');
INSERT INTO `desktop_permission` VALUES ('20', '9', '添加', 'system_department_add', '/desktop/system.department.Add/init\n/desktop/system.department.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('21', '9', '修改', 'system_department_edit', '/desktop/system.department.Edit/init\n/desktop/system.department.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('22', '9', '删除', 'system_department_delete', '/desktop/system.department.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('23', '12', '添加', 'system_desktop_route_add', '/desktop/system.desktop.route.Add/init\n/desktop/system.desktop.route.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('24', '12', '修改', 'system_desktop_route_edit', '/desktop/system.desktop.route.Edit/init\n/desktop/system.desktop.route.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('25', '12', '删除', 'system_desktop_route_delete', '/desktop/system.desktop.route.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('26', '13', '添加', 'system_desktop_menu_add', '/desktop/system.desktop.menu.Add/init\n/desktop/system.desktop.menu.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('27', '13', '修改', 'system_desktop_menu_edit', '/desktop/system.desktop.menu.Edit/init\n/desktop/system.desktop.menu.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('28', '13', '删除', 'system_desktop_menu_delete', '/desktop/system.desktop.menu.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('29', '14', '添加', 'system_desktop_permission_add', '/desktop/system.desktop.permission.Add/init\n/desktop/system.desktop.permission.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('30', '14', '修改', 'system_desktop_permission_edit', '/desktop/system.desktop.permission.Edit/init\n/desktop/system.desktop.permission.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('31', '14', '删除', 'system_desktop_permission_delete', '/desktop/system.desktop.permission.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('32', '16', '添加', 'system_mobile_permission_add', '/desktop/system.mobile.permission.Add/init\n/desktop/system.mobile.permission.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('33', '16', '修改', 'system_mobile_permission_edit', '/desktop/system.mobile.permission.Edit/init\n/desktop/system.mobile.permission.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('34', '16', '删除', 'system_mobile_permission_delete', '/desktop/system.mobile.permission.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('35', '17', '添加', 'system_dictionary_add', '/desktop/system.dictionary.Add/init\n/desktop/system.dictionary.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('36', '17', '修改', 'system_dictionary_edit', '/desktop/system.dictionary.Edit/init\n/desktop/system.dictionary.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('37', '17', '删除', 'system_dictionary_delete', '/desktop/system.dictionary.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('38', '0', '统计分析', 'statistic', '', '81');
INSERT INTO `desktop_permission` VALUES ('39', '38', '部门统计', 'statistic_department', '/desktop/statistic.department.Index/init\n/desktop/statistic.department.Index/exportExcel', '3');
INSERT INTO `desktop_permission` VALUES ('40', '38', '趋势统计', 'statistic_trend', '/desktop/statistic.trend.Index/init\n/desktop/statistic.trend.Index/exportExcel', '1');
INSERT INTO `desktop_permission` VALUES ('41', '0', '系统首页', 'index', '', '1');
INSERT INTO `desktop_permission` VALUES ('42', '10', '添加', 'system_role_add', '/desktop/system.role.Add/init\n/desktop/system.role.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('43', '10', '修改', 'system_role_edit', '/desktop/system.role.Edit/init\n/desktop/system.role.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('44', '10', '删除', 'system_role_delete', '/desktop/system.role.Index/delete', '9');

-- ----------------------------
-- Table structure for desktop_route
-- ----------------------------
DROP TABLE IF EXISTS `desktop_route`;
CREATE TABLE `desktop_route` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '路由名称',
  `key` varchar(128) DEFAULT '' COMMENT '路由标识',
  `path` varchar(256) NOT NULL DEFAULT '' COMMENT '路由路径',
  `component_path` varchar(256) NOT NULL DEFAULT '' COMMENT '组件路径',
  `layout` varchar(32) NOT NULL DEFAULT '' COMMENT '页面布局',
  `keep_alive` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '路由保活',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='路由';

-- ----------------------------
-- Records of desktop_route
-- ----------------------------
INSERT INTO `desktop_route` VALUES ('1', '用户管理', 'system_user', '/system/user', 'system/user/Index.vue', 'main', '2', '903');
INSERT INTO `desktop_route` VALUES ('2', '用户详情', 'system_user_detail', '/system/user/detail-:id', 'system/user/Detail.vue', 'blank', '2', '905');
INSERT INTO `desktop_route` VALUES ('3', '部门管理', 'system_department', '/system/department', 'system/department/Index.vue', 'main', '2', '907');
INSERT INTO `desktop_route` VALUES ('4', '角色管理', 'system_role', '/system/role', 'system/role/Index.vue', 'main', '2', '909');
INSERT INTO `desktop_route` VALUES ('5', '菜单管理', 'system_desktop_menu', '/system/desktop/menu', 'system/desktop/menu/Index.vue', 'main', '2', '911');
INSERT INTO `desktop_route` VALUES ('6', '路由管理', 'system_desktop_route', '/system/desktop/route', 'system/desktop/route/Index.vue', 'main', '2', '913');
INSERT INTO `desktop_route` VALUES ('7', '权限管理', 'system_desktop_permission', '/system/desktop/permission', 'system/desktop/permission/Index.vue', 'main', '2', '915');
INSERT INTO `desktop_route` VALUES ('8', '字典管理', 'system_dictionary', '/system/dictionary', 'system/dictionary/Index.vue', 'main', '2', '919');
INSERT INTO `desktop_route` VALUES ('9', '登录日志', 'system_login_log', '/system/login-log', 'system/login_log/Index.vue', 'main', '2', '921');
INSERT INTO `desktop_route` VALUES ('10', '操作日志', 'system_option_log', 'system/operation-log', 'system/operation_log/Index.vue', 'main', '2', '923');
INSERT INTO `desktop_route` VALUES ('11', '系统设置', 'system_config', '/system/config', 'system/config/Index.vue', 'main', '2', '901');
INSERT INTO `desktop_route` VALUES ('12', '系统首页', 'index', '/index', 'index/Index.vue', 'main', '2', '1');
INSERT INTO `desktop_route` VALUES ('13', '趋势统计', 'statistic_trend', '/statistic/trend', 'statistic/trend/Index.vue', 'main', '2', '801');
INSERT INTO `desktop_route` VALUES ('14', '部门统计', 'statistic_department', '/statistic/department', 'statistic/department/Index.vue', 'main', '2', '803');
INSERT INTO `desktop_route` VALUES ('15', '权限管理', 'system_mobile_permission', '/system/mobile/permission', 'system/mobile/permission/Index.vue', 'main', '2', '917');

-- ----------------------------
-- Table structure for desktop_token
-- ----------------------------
DROP TABLE IF EXISTS `desktop_token`;
CREATE TABLE `desktop_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `token` text NOT NULL COMMENT 'token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `token` (`token`(128)) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of desktop_token
-- ----------------------------
INSERT INTO `desktop_token` VALUES ('1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjEyMjg5ODAwIDE3MjExMDAwMDcifQ.r5ZOFSEorO4rlcCf3JozTgZp5Oik0SUv-satpbMl474', '66', '1');
INSERT INTO `desktop_token` VALUES ('2', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjAxNTk2MDAwIDE3MjExMDAwMzIifQ.w8vFN6V06wbMiHJN4nTqWvb5gDDdj42gf5aeDvR7J1g', '434', '1');
INSERT INTO `desktop_token` VALUES ('3', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjc3MzU5NzAwIDE3MjExMDAyMjYifQ.HkNLmXHriYBpEqtvwJSIMGJRqGDaH08LQNMtRxb3Rbg', '33333', '1');
INSERT INTO `desktop_token` VALUES ('4', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjYyNjE4MTAwIDE3MjExMDAyNTkifQ.JFkyDu3pGnw64o448NUA6F-01bYgQvFCkXtUIFRKZOA', '17211020', '1');
INSERT INTO `desktop_token` VALUES ('5', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQ2Nzc5NjAwIDE3MjExMDAzMzkifQ.xRhf8CAI6OioLvFZVVn2lZLWQrVDpKMW5RPt-g74Hk4', '1721103593', '1');
INSERT INTO `desktop_token` VALUES ('6', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY2NDYzMDAwIDE3MjExMDE3OTMifQ.7lLKIDqz6Px0VQuexH7ZumIpciUJYJ80Vr-9-0Diow0', '1721105933', '1');

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT '字典类型',
  `key` varchar(64) NOT NULL DEFAULT '' COMMENT '字典键',
  `value` varchar(64) NOT NULL DEFAULT '' COMMENT '字典值',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='字典';

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('4', 'desktop_route_layout', 'main', '主布局', '1');
INSERT INTO `dictionary` VALUES ('5', 'desktop_route_layout', 'blank', '空白布局', '2');
INSERT INTO `dictionary` VALUES ('7', 'department_type', '1', '类型1', '1');
INSERT INTO `dictionary` VALUES ('8', 'department_type', '2', '类型2', '2');
INSERT INTO `dictionary` VALUES ('9', 'department_type', '3', '类型3', '3');
INSERT INTO `dictionary` VALUES ('13', 'desktop_route_keep_alive', '1', '是', '1');
INSERT INTO `dictionary` VALUES ('14', 'desktop_route_keep_alive', '2', '否', '2');

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci,
  `queue` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci,
  `exception` longtext COLLATE utf8mb4_unicode_ci,
  `fail_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci,
  `attempts` tinyint(4) unsigned DEFAULT NULL,
  `reserve_time` int(11) unsigned DEFAULT NULL,
  `available_time` int(11) unsigned DEFAULT NULL,
  `create_time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue` (`queue`(191)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `ip` varchar(64) NOT NULL DEFAULT '' COMMENT '登录ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES ('1', '1', '1717647250', '127.0.0.1');
INSERT INTO `login_log` VALUES ('2', '1', '1717647272', '127.0.0.1');
INSERT INTO `login_log` VALUES ('3', '1', '1718846780', '127.0.0.1');
INSERT INTO `login_log` VALUES ('4', '1', '1718853524', '127.0.0.1');
INSERT INTO `login_log` VALUES ('5', '1', '1718853569', '127.0.0.1');
INSERT INTO `login_log` VALUES ('6', '1', '1718868474', '127.0.0.1');
INSERT INTO `login_log` VALUES ('7', '1', '1719285475', '127.0.0.1');
INSERT INTO `login_log` VALUES ('8', '1', '1719565502', '127.0.0.1');
INSERT INTO `login_log` VALUES ('9', '1', '1719565541', '127.0.0.1');
INSERT INTO `login_log` VALUES ('10', '1', '1719565678', '127.0.0.1');
INSERT INTO `login_log` VALUES ('11', '1', '1719580191', '127.0.0.1');
INSERT INTO `login_log` VALUES ('12', '1', '1719621117', '127.0.0.1');
INSERT INTO `login_log` VALUES ('13', '1', '1719667393', '127.0.0.1');
INSERT INTO `login_log` VALUES ('14', '1', '1719668272', '127.0.0.1');
INSERT INTO `login_log` VALUES ('15', '1', '1719672564', '127.0.0.1');
INSERT INTO `login_log` VALUES ('16', '1', '1719672612', '127.0.0.1');
INSERT INTO `login_log` VALUES ('17', '1', '1719713736', '127.0.0.1');
INSERT INTO `login_log` VALUES ('18', '1', '1719722883', '127.0.0.1');
INSERT INTO `login_log` VALUES ('19', '1', '1719796048', '127.0.0.1');
INSERT INTO `login_log` VALUES ('20', '1', '1721032868', '127.0.0.1');
INSERT INTO `login_log` VALUES ('21', '1', '1721035880', '127.0.0.1');
INSERT INTO `login_log` VALUES ('22', '1', '1721092762', '127.0.0.1');
INSERT INTO `login_log` VALUES ('23', '1', '1721095494', '127.0.0.1');
INSERT INTO `login_log` VALUES ('24', '1', '1721095674', '127.0.0.1');
INSERT INTO `login_log` VALUES ('25', '1', '1721099102', '127.0.0.1');
INSERT INTO `login_log` VALUES ('26', '1', '1721099107', '127.0.0.1');
INSERT INTO `login_log` VALUES ('27', '1', '1721099913', '127.0.0.1');
INSERT INTO `login_log` VALUES ('28', '1', '1721100007', '127.0.0.1');
INSERT INTO `login_log` VALUES ('29', '1', '1721100032', '127.0.0.1');
INSERT INTO `login_log` VALUES ('30', '1', '1721100226', '127.0.0.1');
INSERT INTO `login_log` VALUES ('31', '1', '1721100259', '127.0.0.1');
INSERT INTO `login_log` VALUES ('32', '1', '1721100339', '127.0.0.1');
INSERT INTO `login_log` VALUES ('33', '1', '1721101793', '127.0.0.1');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '消息标题',
  `url` varchar(128) NOT NULL DEFAULT '' COMMENT '跳转地址',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '消息时间',
  `read` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '已读',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息';

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for mobile_permission
-- ----------------------------
DROP TABLE IF EXISTS `mobile_permission`;
CREATE TABLE `mobile_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `permission_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级权限id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '权限名称',
  `key` varchar(128) DEFAULT '' COMMENT '权限key',
  `api_string` varchar(1024) NOT NULL DEFAULT '' COMMENT '接口地址串',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='权限';

-- ----------------------------
-- Records of mobile_permission
-- ----------------------------
INSERT INTO `mobile_permission` VALUES ('1', '0', '功能模块1', 'module1', 'xxx/xxx/xxx', '1');
INSERT INTO `mobile_permission` VALUES ('2', '0', '功能模块2', 'module2', 'xxx/xxx/xxx', '3');

-- ----------------------------
-- Table structure for module_token
-- ----------------------------
DROP TABLE IF EXISTS `module_token`;
CREATE TABLE `module_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `token` text NOT NULL COMMENT 'token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `token` (`token`(128)) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of module_token
-- ----------------------------

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `ip` varchar(64) NOT NULL DEFAULT '' COMMENT '操作ip',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '操作地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2216 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES ('1', '1', '1716183965', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('2', '1', '1716184081', '127.0.0.1', '/desktop/statistic.department/init');
INSERT INTO `operation_log` VALUES ('3', '1', '1716184091', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('4', '1', '1716184091', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('5', '1', '1716184095', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('6', '1', '1716184097', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('7', '1', '1716184097', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('8', '1', '1716184101', '127.0.0.1', '/desktop/system.user/detail');
INSERT INTO `operation_log` VALUES ('9', '1', '1717647290', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('10', '1', '1717647293', '127.0.0.1', '/desktop/statistic.department/init');
INSERT INTO `operation_log` VALUES ('11', '1', '1717647304', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('12', '1', '1717647305', '127.0.0.1', '/desktop/statistic.department/init');
INSERT INTO `operation_log` VALUES ('13', '1', '1717647340', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('14', '1', '1717647346', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('15', '1', '1717647348', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('16', '1', '1717647349', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('17', '1', '1717647353', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('18', '1', '1717647354', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('19', '1', '1717647510', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('20', '1', '1717647514', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('21', '1', '1717647516', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('22', '1', '1717647532', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('23', '1', '1717647536', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('24', '1', '1717647537', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('25', '1', '1717647537', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('26', '1', '1717647537', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('27', '1', '1717647539', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('28', '1', '1717647542', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('29', '1', '1717647544', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('30', '1', '1717647547', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('31', '1', '1717647549', '127.0.0.1', '/desktop/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('32', '1', '1717647551', '127.0.0.1', '/desktop/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('33', '1', '1718846798', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('34', '1', '1718846800', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('35', '1', '1718846802', '127.0.0.1', '/desktop/system.mobile.module/initadd');
INSERT INTO `operation_log` VALUES ('36', '1', '1718847506', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('37', '1', '1718847618', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('38', '1', '1718847620', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('39', '1', '1718847685', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('40', '1', '1718852515', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('41', '1', '1719285476', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('42', '1', '1719285498', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('43', '1', '1719285575', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('44', '1', '1719285577', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('45', '1', '1719285608', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('46', '1', '1719285614', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('47', '1', '1719285672', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('48', '1', '1719285679', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('49', '1', '1719285686', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('50', '1', '1719285688', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('51', '1', '1719285758', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('52', '1', '1719286081', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('53', '1', '1719286126', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('54', '1', '1719286131', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('55', '1', '1719286133', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('56', '1', '1719286142', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('57', '1', '1719286155', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('58', '1', '1719286157', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('59', '1', '1719566519', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('60', '1', '1719566543', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('61', '1', '1719566561', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('62', '1', '1719566596', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('63', '1', '1719566613', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('64', '1', '1719566675', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('65', '1', '1719566675', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('66', '1', '1719566914', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('67', '1', '1719566915', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('68', '1', '1719566916', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('69', '1', '1719566925', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('70', '1', '1719566925', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('71', '1', '1719566927', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('72', '1', '1719566932', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('73', '1', '1719566932', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('74', '1', '1719566934', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('75', '1', '1719566935', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('76', '1', '1719566935', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('77', '1', '1719566936', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('78', '1', '1719566936', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('79', '1', '1719566938', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('80', '1', '1719566955', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('81', '1', '1719566956', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('82', '1', '1719566957', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('83', '1', '1719566960', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('84', '1', '1719566960', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('85', '1', '1719566961', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('86', '1', '1719567048', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('87', '1', '1719567049', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('88', '1', '1719567050', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('89', '1', '1719567053', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('90', '1', '1719567054', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('91', '1', '1719567055', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('92', '1', '1719567056', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('93', '1', '1719567057', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('94', '1', '1719567057', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('95', '1', '1719567062', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('96', '1', '1719567062', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('97', '1', '1719567063', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('98', '1', '1719567065', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('99', '1', '1719567065', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('100', '1', '1719567068', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('101', '1', '1719567096', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('102', '1', '1719567096', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('103', '1', '1719567097', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('104', '1', '1719567276', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('105', '1', '1719567276', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('106', '1', '1719567277', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('107', '1', '1719567728', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('108', '1', '1719567792', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('109', '1', '1719567806', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('110', '1', '1719567806', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('111', '1', '1719567807', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('112', '1', '1719568266', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('113', '1', '1719568266', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('114', '1', '1719568268', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('115', '1', '1719568691', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('116', '1', '1719568716', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('117', '1', '1719568716', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('118', '1', '1719568717', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('119', '1', '1719568717', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('120', '1', '1719569078', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('121', '1', '1719569078', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('122', '1', '1719569079', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('123', '1', '1719569079', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('124', '1', '1719569120', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('125', '1', '1719569120', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('126', '1', '1719569121', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('127', '1', '1719569121', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('128', '1', '1719569159', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('129', '1', '1719569160', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('130', '1', '1719569161', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('131', '1', '1719569161', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('132', '1', '1719569215', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('133', '1', '1719569215', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('134', '1', '1719569219', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('135', '1', '1719569220', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('136', '1', '1719569251', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('137', '1', '1719569252', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('138', '1', '1719569252', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('139', '1', '1719569255', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('140', '1', '1719569259', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('141', '1', '1719569312', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('142', '1', '1719569312', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('143', '1', '1719569314', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('144', '1', '1719569314', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('145', '1', '1719569314', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('146', '1', '1719569314', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('147', '1', '1719569314', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('148', '1', '1719569321', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('149', '1', '1719569345', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('150', '1', '1719569345', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('151', '1', '1719569348', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('152', '1', '1719569348', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('153', '1', '1719569349', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('154', '1', '1719569349', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('155', '1', '1719569349', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('156', '1', '1719569349', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('157', '1', '1719569349', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('158', '1', '1719569358', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('159', '1', '1719569399', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('160', '1', '1719569399', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('161', '1', '1719569408', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('162', '1', '1719569488', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('163', '1', '1719569538', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('164', '1', '1719569569', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('165', '1', '1719569585', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('166', '1', '1719569617', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('167', '1', '1719569680', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('168', '1', '1719569701', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('169', '1', '1719569724', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('170', '1', '1719569781', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('171', '1', '1719569860', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('172', '1', '1719569873', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('173', '1', '1719569900', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('174', '1', '1719569900', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('175', '1', '1719569902', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('176', '1', '1719569902', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('177', '1', '1719569902', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('178', '1', '1719569902', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('179', '1', '1719569902', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('180', '1', '1719569975', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('181', '1', '1719569975', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('182', '1', '1719569977', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('183', '1', '1719569977', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('184', '1', '1719569977', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('185', '1', '1719569977', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('186', '1', '1719569977', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('187', '1', '1719570050', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('188', '1', '1719570050', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('189', '1', '1719570052', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('190', '1', '1719570052', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('191', '1', '1719570052', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('192', '1', '1719570052', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('193', '1', '1719570052', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('194', '1', '1719570095', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('195', '1', '1719570095', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('196', '1', '1719570096', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('197', '1', '1719570096', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('198', '1', '1719570096', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('199', '1', '1719570096', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('200', '1', '1719570096', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('201', '1', '1719570106', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('202', '1', '1719570106', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('203', '1', '1719570107', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('204', '1', '1719570107', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('205', '1', '1719570107', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('206', '1', '1719570107', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('207', '1', '1719570107', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('208', '1', '1719570149', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('209', '1', '1719570149', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('210', '1', '1719570151', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('211', '1', '1719570151', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('212', '1', '1719570151', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('213', '1', '1719570151', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('214', '1', '1719570151', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('215', '1', '1719570164', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('216', '1', '1719570197', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('217', '1', '1719570203', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('218', '1', '1719570203', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('219', '1', '1719570205', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('220', '1', '1719570215', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('221', '1', '1719570216', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('222', '1', '1719570217', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('223', '1', '1719570256', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('224', '1', '1719570262', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('225', '1', '1719570273', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('226', '1', '1719570274', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('227', '1', '1719570276', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('228', '1', '1719570309', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('229', '1', '1719570314', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('230', '1', '1719570315', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('231', '1', '1719570385', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('232', '1', '1719570395', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('233', '1', '1719570425', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('234', '1', '1719570434', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('235', '1', '1719570447', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('236', '1', '1719570447', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('237', '1', '1719570449', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('238', '1', '1719570453', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('239', '1', '1719570454', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('240', '1', '1719570501', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('241', '1', '1719570501', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('242', '1', '1719570502', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('243', '1', '1719570502', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('244', '1', '1719570502', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('245', '1', '1719570502', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('246', '1', '1719570502', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('247', '1', '1719570512', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('248', '1', '1719570512', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('249', '1', '1719570514', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('250', '1', '1719570514', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('251', '1', '1719570514', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('252', '1', '1719570514', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('253', '1', '1719570514', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('254', '1', '1719570693', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('255', '1', '1719570693', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('256', '1', '1719570707', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('257', '1', '1719570707', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('258', '1', '1719570736', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('259', '1', '1719570736', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('260', '1', '1719570736', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('261', '1', '1719570736', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('262', '1', '1719570736', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('263', '1', '1719570768', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('264', '1', '1719570768', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('265', '1', '1719570768', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('266', '1', '1719570768', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('267', '1', '1719570768', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('268', '1', '1719570952', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('269', '1', '1719570952', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('270', '1', '1719570953', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('271', '1', '1719570953', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('272', '1', '1719570953', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('273', '1', '1719570953', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('274', '1', '1719570953', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('275', '1', '1719570994', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('276', '1', '1719571100', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('277', '1', '1719571100', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('278', '1', '1719571102', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('279', '1', '1719571102', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('280', '1', '1719571102', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('281', '1', '1719571102', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('282', '1', '1719571102', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('283', '1', '1719571145', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('284', '1', '1719571147', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('285', '1', '1719571308', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('286', '1', '1719571308', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('287', '1', '1719571308', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('288', '1', '1719571308', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('289', '1', '1719571309', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('290', '1', '1719571350', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('291', '1', '1719571350', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('292', '1', '1719571351', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('293', '1', '1719571351', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('294', '1', '1719571351', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('295', '1', '1719571353', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('296', '1', '1719571353', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('297', '1', '1719571355', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('298', '1', '1719571355', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('299', '1', '1719571355', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('300', '1', '1719571355', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('301', '1', '1719571355', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('302', '1', '1719571440', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('303', '1', '1719571440', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('304', '1', '1719571442', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('305', '1', '1719571442', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('306', '1', '1719571442', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('307', '1', '1719571442', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('308', '1', '1719571442', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('309', '1', '1719571468', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('310', '1', '1719571468', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('311', '1', '1719571470', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('312', '1', '1719571470', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('313', '1', '1719571470', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('314', '1', '1719571470', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('315', '1', '1719571470', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('316', '1', '1719571616', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('317', '1', '1719571748', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('318', '1', '1719571749', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('319', '1', '1719571750', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('320', '1', '1719571750', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('321', '1', '1719571750', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('322', '1', '1719571750', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('323', '1', '1719571750', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('324', '1', '1719572168', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('325', '1', '1719572168', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('326', '1', '1719572169', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('327', '1', '1719572169', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('328', '1', '1719572259', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('329', '1', '1719572288', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('330', '1', '1719572294', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('331', '1', '1719572294', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('332', '1', '1719572295', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('333', '1', '1719572295', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('334', '1', '1719572323', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('335', '1', '1719572323', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('336', '1', '1719572325', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('337', '1', '1719572325', '127.0.0.1', '/desktop/frame/getwatermark');
INSERT INTO `operation_log` VALUES ('338', '1', '1719572396', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('339', '1', '1719572396', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('340', '1', '1719572398', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('341', '1', '1719572522', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('342', '1', '1719572523', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('343', '1', '1719572525', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('344', '1', '1719572525', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('345', '1', '1719572525', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('346', '1', '1719572525', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('347', '1', '1719572525', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('348', '1', '1719572563', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('349', '1', '1719572563', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('350', '1', '1719572565', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('351', '1', '1719572565', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('352', '1', '1719572565', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('353', '1', '1719572565', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('354', '1', '1719572565', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('355', '1', '1719572933', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('356', '1', '1719572933', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('357', '1', '1719572935', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('358', '1', '1719572935', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('359', '1', '1719572935', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('360', '1', '1719572935', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('361', '1', '1719572935', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('362', '1', '1719572943', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('363', '1', '1719572943', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('364', '1', '1719572956', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('365', '1', '1719572957', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('366', '1', '1719572958', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('367', '1', '1719572959', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('368', '1', '1719572959', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('369', '1', '1719572959', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('370', '1', '1719572959', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('371', '1', '1719573004', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('372', '1', '1719573005', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('373', '1', '1719573051', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('374', '1', '1719573051', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('375', '1', '1719573059', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('376', '1', '1719573059', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('377', '1', '1719573060', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('378', '1', '1719573060', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('379', '1', '1719573060', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('380', '1', '1719573060', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('381', '1', '1719573060', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('382', '1', '1719573088', '127.0.0.1', '/desktop/components.watermark/getwatermark');
INSERT INTO `operation_log` VALUES ('383', '1', '1719573114', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('384', '1', '1719573114', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('385', '1', '1719573116', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('386', '1', '1719573116', '127.0.0.1', '/desktop/components.watermark/getwatermark');
INSERT INTO `operation_log` VALUES ('387', '1', '1719573116', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('388', '1', '1719573116', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('389', '1', '1719573116', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('390', '1', '1719573222', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('391', '1', '1719573222', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('392', '1', '1719573222', '127.0.0.1', '/desktop/components.watermark/getwatermark');
INSERT INTO `operation_log` VALUES ('393', '1', '1719573222', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('394', '1', '1719573222', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('395', '1', '1719573227', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('396', '1', '1719573227', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('397', '1', '1719573227', '127.0.0.1', '/desktop/components.watermark/getwatermark');
INSERT INTO `operation_log` VALUES ('398', '1', '1719573227', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('399', '1', '1719573227', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('400', '1', '1719573530', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('401', '1', '1719573531', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('402', '1', '1719573573', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('403', '1', '1719573573', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('404', '1', '1719573575', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('405', '1', '1719573575', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('406', '1', '1719573575', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('407', '1', '1719573575', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('408', '1', '1719573606', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('409', '1', '1719573727', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('410', '1', '1719573728', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('411', '1', '1719573748', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('412', '1', '1719573749', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('413', '1', '1719573759', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('414', '1', '1719573759', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('415', '1', '1719573764', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('416', '1', '1719573765', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('417', '1', '1719573790', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('418', '1', '1719573790', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('419', '1', '1719573793', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('420', '1', '1719573793', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('421', '1', '1719573793', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('422', '1', '1719573793', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('423', '1', '1719573793', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('424', '1', '1719574915', '127.0.0.1', '/desktop/main.user.info/init');
INSERT INTO `operation_log` VALUES ('425', '1', '1719574923', '127.0.0.1', '/desktop/main.user.info/init');
INSERT INTO `operation_log` VALUES ('426', '1', '1719574933', '127.0.0.1', '/desktop/main.user.info/init');
INSERT INTO `operation_log` VALUES ('427', '1', '1719574965', '127.0.0.1', '/desktop/main.user.info/init');
INSERT INTO `operation_log` VALUES ('428', '1', '1719575003', '127.0.0.1', '/desktop/main.user.info/init');
INSERT INTO `operation_log` VALUES ('429', '1', '1719575035', '127.0.0.1', '/desktop/main.user.info/init');
INSERT INTO `operation_log` VALUES ('430', '1', '1719575352', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('431', '1', '1719575352', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('432', '1', '1719575354', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('433', '1', '1719575354', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('434', '1', '1719575354', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('435', '1', '1719575354', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('436', '1', '1719575354', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('437', '1', '1719580192', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('438', '1', '1719580193', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('439', '1', '1719580194', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('440', '1', '1719580194', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('441', '1', '1719580194', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('442', '1', '1719580194', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('443', '1', '1719580200', '127.0.0.1', '/desktop/main.user.info/init');
INSERT INTO `operation_log` VALUES ('444', '1', '1719580258', '127.0.0.1', '/desktop/main.user.info/getinfo');
INSERT INTO `operation_log` VALUES ('445', '1', '1719580264', '127.0.0.1', '/desktop/main.user.info/getuser');
INSERT INTO `operation_log` VALUES ('446', '1', '1719580313', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('447', '1', '1719580313', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('448', '1', '1719580319', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('449', '1', '1719580320', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('450', '1', '1719580321', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('451', '1', '1719580321', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('452', '1', '1719580321', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('453', '1', '1719580321', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('454', '1', '1719580341', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('455', '1', '1719580341', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('456', '1', '1719580406', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('457', '1', '1719580406', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('458', '1', '1719580441', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('459', '1', '1719580441', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('460', '1', '1719580443', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('461', '1', '1719580443', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('462', '1', '1719580443', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('463', '1', '1719580443', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('464', '1', '1719580493', '127.0.0.1', '/desktop/main.user.info/getinfo');
INSERT INTO `operation_log` VALUES ('465', '1', '1719580577', '127.0.0.1', '/desktop/main.user.info/getinfo');
INSERT INTO `operation_log` VALUES ('466', '1', '1719580579', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('467', '1', '1719580579', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('468', '1', '1719580587', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('469', '1', '1719580587', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('470', '1', '1719580617', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('471', '1', '1719580617', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('472', '1', '1719580619', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('473', '1', '1719580619', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('474', '1', '1719580619', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('475', '1', '1719580619', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('476', '1', '1719580705', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('477', '1', '1719580706', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('478', '1', '1719580775', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('479', '1', '1719580775', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('480', '1', '1719580778', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('481', '1', '1719580778', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('482', '1', '1719580778', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('483', '1', '1719580778', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('484', '1', '1719580790', '127.0.0.1', '/desktop/main.user.detail/getuser');
INSERT INTO `operation_log` VALUES ('485', '1', '1719580834', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('486', '1', '1719580835', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('487', '1', '1719580836', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('488', '1', '1719580836', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('489', '1', '1719580836', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('490', '1', '1719580836', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('491', '1', '1719580838', '127.0.0.1', '/desktop/main.user.detail/getuser');
INSERT INTO `operation_log` VALUES ('492', '1', '1719580868', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('493', '1', '1719580868', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('494', '1', '1719580869', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('495', '1', '1719580869', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('496', '1', '1719580869', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('497', '1', '1719580869', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('498', '1', '1719580873', '127.0.0.1', '/desktop/main.user.detail/getuser');
INSERT INTO `operation_log` VALUES ('499', '1', '1719581720', '127.0.0.1', '/desktop/main.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('500', '1', '1719581732', '127.0.0.1', '/desktop/main.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('501', '1', '1719582074', '127.0.0.1', '/desktop/main.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('502', '1', '1719582101', '127.0.0.1', '/desktop/main.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('503', '1', '1719582353', '127.0.0.1', '/desktop/main.user.editavatar/init');
INSERT INTO `operation_log` VALUES ('504', '1', '1719582372', '127.0.0.1', '/desktop/main.user.editavatar/init');
INSERT INTO `operation_log` VALUES ('505', '1', '1719582418', '127.0.0.1', '/desktop/main.user.editavatar/init');
INSERT INTO `operation_log` VALUES ('506', '1', '1719582438', '127.0.0.1', '/desktop/main.user.editavatar/init');
INSERT INTO `operation_log` VALUES ('507', '1', '1719583025', '127.0.0.1', '/desktop/main.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('508', '1', '1719583062', '127.0.0.1', '/desktop/main.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('509', '1', '1719583063', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('510', '1', '1719583102', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('511', '1', '1719583102', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('512', '1', '1719583102', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('513', '1', '1719583102', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('514', '1', '1719583118', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('515', '1', '1719583136', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('516', '1', '1719583183', '127.0.0.1', '/desktop/system.desktop.route.add/save');
INSERT INTO `operation_log` VALUES ('517', '1', '1719583184', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('518', '1', '1719583221', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('519', '1', '1719583228', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('520', '1', '1719583228', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('521', '1', '1719583234', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('522', '1', '1719583238', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('523', '1', '1719583238', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('524', '1', '1719583243', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('525', '1', '1719583247', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('526', '1', '1719583247', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('527', '1', '1719583268', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('528', '1', '1719583282', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('529', '1', '1719583282', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('530', '1', '1719583284', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('531', '1', '1719583284', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('532', '1', '1719583284', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('533', '1', '1719583284', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('534', '1', '1719583284', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('535', '1', '1719583291', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('536', '1', '1719583320', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('537', '1', '1719583321', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('538', '1', '1719583329', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('539', '1', '1719583394', '127.0.0.1', '/desktop/system.desktop.route.add/save');
INSERT INTO `operation_log` VALUES ('540', '1', '1719583395', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('541', '1', '1719583397', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('542', '1', '1719583449', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('543', '1', '1719583449', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('544', '1', '1719583450', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('545', '1', '1719583451', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('546', '1', '1719583451', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('547', '1', '1719583451', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('548', '1', '1719583451', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('549', '1', '1719583451', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('550', '1', '1719583452', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('551', '1', '1719583453', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('552', '1', '1719583453', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('553', '1', '1719583453', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('554', '1', '1719583453', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('555', '1', '1719583453', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('556', '1', '1719583457', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('557', '1', '1719583511', '127.0.0.1', '/desktop/system.desktop.route.add/save');
INSERT INTO `operation_log` VALUES ('558', '1', '1719583512', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('559', '1', '1719583521', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('560', '1', '1719583525', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('561', '1', '1719583526', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('562', '1', '1719583528', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('563', '1', '1719583532', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('564', '1', '1719583532', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('565', '1', '1719583537', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('566', '1', '1719583591', '127.0.0.1', '/desktop/system.desktop.route.add/save');
INSERT INTO `operation_log` VALUES ('567', '1', '1719583591', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('568', '1', '1719583603', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('569', '1', '1719583614', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('570', '1', '1719583630', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('571', '1', '1719583630', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('572', '1', '1719583631', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('573', '1', '1719583631', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('574', '1', '1719583631', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('575', '1', '1719583631', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('576', '1', '1719583659', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('577', '1', '1719583660', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('578', '1', '1719583662', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('579', '1', '1719583662', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('580', '1', '1719583662', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('581', '1', '1719583662', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('582', '1', '1719583678', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('583', '1', '1719583684', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('584', '1', '1719583698', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('585', '1', '1719583698', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('586', '1', '1719583701', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('587', '1', '1719583702', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('588', '1', '1719583703', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('589', '1', '1719583703', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('590', '1', '1719583703', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('591', '1', '1719583703', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('592', '1', '1719583703', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('593', '1', '1719583726', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('594', '1', '1719583862', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('595', '1', '1719584164', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('596', '1', '1719584164', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('597', '1', '1719584166', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('598', '1', '1719584166', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('599', '1', '1719584166', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('600', '1', '1719584166', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('601', '1', '1719584166', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('602', '1', '1719584169', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('603', '1', '1719584170', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('604', '1', '1719584173', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('605', '1', '1719584173', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('606', '1', '1719584173', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('607', '1', '1719584173', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('608', '1', '1719584173', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('609', '1', '1719584207', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('610', '1', '1719584208', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('611', '1', '1719584208', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('612', '1', '1719584208', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('613', '1', '1719584208', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('614', '1', '1719584385', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('615', '1', '1719584405', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('616', '1', '1719584413', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('617', '1', '1719584423', '127.0.0.1', '/desktop/system.desktop.menu.add/init');
INSERT INTO `operation_log` VALUES ('618', '1', '1719584449', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('619', '1', '1719584464', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('620', '1', '1719584526', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('621', '1', '1719584531', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('622', '1', '1719584556', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('623', '1', '1719584620', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('624', '1', '1719584620', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('625', '1', '1719584666', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('626', '1', '1719584666', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('627', '1', '1719584666', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('628', '1', '1719584666', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('629', '1', '1719584666', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('630', '1', '1719584671', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('631', '1', '1719584673', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('632', '1', '1719584695', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('633', '1', '1719584696', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('634', '1', '1719584697', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('635', '1', '1719584706', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('636', '1', '1719584706', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('637', '1', '1719584713', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('638', '1', '1719584713', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('639', '1', '1719584715', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('640', '1', '1719584715', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('641', '1', '1719584715', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('642', '1', '1719584715', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('643', '1', '1719584715', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('644', '1', '1719584779', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('645', '1', '1719584780', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('646', '1', '1719584781', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('647', '1', '1719584781', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('648', '1', '1719584781', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('649', '1', '1719584781', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('650', '1', '1719584796', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('651', '1', '1719584797', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('652', '1', '1719584798', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('653', '1', '1719584798', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('654', '1', '1719584798', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('655', '1', '1719584798', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('656', '1', '1719584823', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('657', '1', '1719584824', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('658', '1', '1719584826', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('659', '1', '1719584826', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('660', '1', '1719584826', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('661', '1', '1719584826', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('662', '1', '1719584846', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('663', '1', '1719584851', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('664', '1', '1719584916', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('665', '1', '1719585021', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('666', '1', '1719585050', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('667', '1', '1719585051', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('668', '1', '1719585053', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('669', '1', '1719585053', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('670', '1', '1719585053', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('671', '1', '1719585053', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('672', '1', '1719585053', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('673', '1', '1719585061', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('674', '1', '1719585062', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('675', '1', '1719585064', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('676', '1', '1719585064', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('677', '1', '1719585064', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('678', '1', '1719585064', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('679', '1', '1719585064', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('680', '1', '1719585089', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('681', '1', '1719585099', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('682', '1', '1719585101', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('683', '1', '1719585198', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('684', '1', '1719585198', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('685', '1', '1719585200', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('686', '1', '1719585200', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('687', '1', '1719585200', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('688', '1', '1719585200', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('689', '1', '1719585200', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('690', '1', '1719585200', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('691', '1', '1719585253', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('692', '1', '1719585253', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('693', '1', '1719585255', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('694', '1', '1719585255', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('695', '1', '1719585255', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('696', '1', '1719585255', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('697', '1', '1719585255', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('698', '1', '1719585255', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('699', '1', '1719585257', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('700', '1', '1719585273', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('701', '1', '1719585273', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('702', '1', '1719585275', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('703', '1', '1719585275', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('704', '1', '1719585275', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('705', '1', '1719585275', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('706', '1', '1719585275', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('707', '1', '1719585275', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('708', '1', '1719585323', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('709', '1', '1719585324', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('710', '1', '1719585326', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('711', '1', '1719585326', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('712', '1', '1719585326', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('713', '1', '1719585326', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('714', '1', '1719585326', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('715', '1', '1719585344', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('716', '1', '1719585457', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('717', '1', '1719585475', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('718', '1', '1719585504', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('719', '1', '1719585516', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('720', '1', '1719585516', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('721', '1', '1719585565', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('722', '1', '1719585566', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('723', '1', '1719585567', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('724', '1', '1719585568', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('725', '1', '1719585568', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('726', '1', '1719585568', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('727', '1', '1719585568', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('728', '1', '1719585568', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('729', '1', '1719585568', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('730', '1', '1719585629', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('731', '1', '1719585630', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('732', '1', '1719585633', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('733', '1', '1719585633', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('734', '1', '1719585633', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('735', '1', '1719585633', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('736', '1', '1719585633', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('737', '1', '1719585633', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('738', '1', '1719585634', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('739', '1', '1719585758', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('740', '1', '1719585759', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('741', '1', '1719585762', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('742', '1', '1719585762', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('743', '1', '1719585762', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('744', '1', '1719585762', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('745', '1', '1719585762', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('746', '1', '1719585762', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('747', '1', '1719585763', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('748', '1', '1719585782', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('749', '1', '1719586489', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('750', '1', '1719586490', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('751', '1', '1719586491', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('752', '1', '1719586547', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('753', '1', '1719621118', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('754', '1', '1719621118', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('755', '1', '1719621120', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('756', '1', '1719621120', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('757', '1', '1719621120', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('758', '1', '1719621120', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('759', '1', '1719621120', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('760', '1', '1719621130', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('761', '1', '1719621130', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('762', '1', '1719667393', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('763', '1', '1719667394', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('764', '1', '1719667395', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('765', '1', '1719667395', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('766', '1', '1719667395', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('767', '1', '1719667395', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('768', '1', '1719667395', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('769', '1', '1719667407', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('770', '1', '1719667407', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('771', '1', '1719667408', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('772', '1', '1719667408', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('773', '1', '1719667408', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('774', '1', '1719667408', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('775', '1', '1719667408', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('776', '1', '1719668168', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('777', '1', '1719668169', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('778', '1', '1719668170', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('779', '1', '1719668170', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('780', '1', '1719668170', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('781', '1', '1719668170', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('782', '1', '1719668170', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('783', '1', '1719668174', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('784', '1', '1719668174', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('785', '1', '1719668175', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('786', '1', '1719668175', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('787', '1', '1719668175', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('788', '1', '1719668175', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('789', '1', '1719668176', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('790', '1', '1719668176', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('791', '1', '1719668176', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('792', '1', '1719668177', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('793', '1', '1719668177', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('794', '1', '1719668177', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('795', '1', '1719668177', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('796', '1', '1719668177', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('797', '1', '1719668183', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('798', '1', '1719668183', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('799', '1', '1719668185', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('800', '1', '1719668185', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('801', '1', '1719668185', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('802', '1', '1719668185', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('803', '1', '1719668185', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('804', '1', '1719668193', '127.0.0.1', '/desktop/main.user.detail/getuser');
INSERT INTO `operation_log` VALUES ('805', '1', '1719668196', '127.0.0.1', '/desktop/main.user.editavatar/init');
INSERT INTO `operation_log` VALUES ('806', '1', '1719668199', '127.0.0.1', '/desktop/main.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('807', '1', '1719668199', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('808', '1', '1719668210', '127.0.0.1', '/desktop/main.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('809', '1', '1719668264', '127.0.0.1', '/desktop/main/logout');
INSERT INTO `operation_log` VALUES ('810', '1', '1719668273', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('811', '1', '1719668273', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('812', '1', '1719668274', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('813', '1', '1719668274', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('814', '1', '1719668274', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('815', '1', '1719668274', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('816', '1', '1719668274', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('817', '1', '1719669416', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('818', '1', '1719669417', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('819', '1', '1719669418', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('820', '1', '1719669418', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('821', '1', '1719669418', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('822', '1', '1719669418', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('823', '1', '1719669418', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('824', '1', '1719669421', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('825', '1', '1719669422', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('826', '1', '1719669434', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('827', '1', '1719669435', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('828', '1', '1719669437', '127.0.0.1', '/desktop/system.user.add/init');
INSERT INTO `operation_log` VALUES ('829', '1', '1719669494', '127.0.0.1', '/desktop/system.user.add/init');
INSERT INTO `operation_log` VALUES ('830', '1', '1719669563', '127.0.0.1', '/desktop/system.user.add/save');
INSERT INTO `operation_log` VALUES ('831', '1', '1719669573', '127.0.0.1', '/desktop/system.user.add/save');
INSERT INTO `operation_log` VALUES ('832', '1', '1719669726', '127.0.0.1', '/desktop/system.user.add/save');
INSERT INTO `operation_log` VALUES ('833', '1', '1719669727', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('834', '1', '1719669735', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('835', '1', '1719669736', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('836', '1', '1719669737', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('837', '1', '1719669737', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('838', '1', '1719669737', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('839', '1', '1719669737', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('840', '1', '1719669737', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('841', '1', '1719669737', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('842', '1', '1719669738', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('843', '1', '1719669819', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('844', '1', '1719669855', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('845', '1', '1719669863', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('846', '1', '1719669922', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('847', '1', '1719669944', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('848', '1', '1719669955', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('849', '1', '1719669955', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('850', '1', '1719670008', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('851', '1', '1719670008', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('852', '1', '1719670462', '127.0.0.1', '/desktop/system.user.index/editstatus');
INSERT INTO `operation_log` VALUES ('853', '1', '1719670465', '127.0.0.1', '/desktop/system.user.index/editstatus');
INSERT INTO `operation_log` VALUES ('854', '1', '1719670480', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('855', '1', '1719670480', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('856', '1', '1719670482', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('857', '1', '1719670482', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('858', '1', '1719670482', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('859', '1', '1719670482', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('860', '1', '1719670482', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('861', '1', '1719670482', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('862', '1', '1719670483', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('863', '1', '1719670548', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('864', '1', '1719670548', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('865', '1', '1719670587', '127.0.0.1', '/desktop/system.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('866', '1', '1719670609', '127.0.0.1', '/desktop/system.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('867', '1', '1719670638', '127.0.0.1', '/desktop/system.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('868', '1', '1719670646', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('869', '1', '1719670654', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('870', '1', '1719670655', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('871', '1', '1719670667', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('872', '1', '1719670674', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('873', '1', '1719670689', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('874', '1', '1719670689', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('875', '1', '1719670693', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('876', '1', '1719670695', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('877', '1', '1719670701', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('878', '1', '1719670701', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('879', '1', '1719670707', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('880', '1', '1719670708', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('881', '1', '1719670733', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('882', '1', '1719670734', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('883', '1', '1719670735', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('884', '1', '1719670735', '127.0.0.1', '/desktop/blank/getwatermark');
INSERT INTO `operation_log` VALUES ('885', '1', '1719671067', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('886', '1', '1719671067', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('887', '1', '1719671068', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('888', '1', '1719671068', '127.0.0.1', '/desktop/blank/getwatermark');
INSERT INTO `operation_log` VALUES ('889', '1', '1719671076', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('890', '1', '1719671076', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('891', '1', '1719671078', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('892', '1', '1719671078', '127.0.0.1', '/desktop/blank/getwatermark');
INSERT INTO `operation_log` VALUES ('893', '1', '1719671109', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('894', '1', '1719671109', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('895', '1', '1719671110', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('896', '1', '1719671110', '127.0.0.1', '/desktop/blank/getwatermark');
INSERT INTO `operation_log` VALUES ('897', '1', '1719671172', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('898', '1', '1719671172', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('899', '1', '1719671173', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('900', '1', '1719671173', '127.0.0.1', '/desktop/blank/getwatermark');
INSERT INTO `operation_log` VALUES ('901', '1', '1719671740', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('902', '1', '1719671740', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('903', '1', '1719671741', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('904', '1', '1719671741', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('905', '1', '1719671741', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('906', '1', '1719671741', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('907', '1', '1719671741', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('908', '1', '1719671815', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('909', '1', '1719671824', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('910', '1', '1719671871', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('911', '1', '1719671883', '127.0.0.1', '/desktop/system.dictionary.add/save');
INSERT INTO `operation_log` VALUES ('912', '1', '1719671889', '127.0.0.1', '/desktop/system.dictionary.add/save');
INSERT INTO `operation_log` VALUES ('913', '1', '1719672102', '127.0.0.1', '/desktop/system.dictionary.add/save');
INSERT INTO `operation_log` VALUES ('914', '1', '1719672102', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('915', '1', '1719672126', '127.0.0.1', '/desktop/system.dictionary.index/delete');
INSERT INTO `operation_log` VALUES ('916', '1', '1719672126', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('917', '1', '1719672196', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('918', '1', '1719672196', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('919', '1', '1719672198', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('920', '1', '1719672198', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('921', '1', '1719672198', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('922', '1', '1719672198', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('923', '1', '1719672198', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('924', '1', '1719672221', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('925', '1', '1719672239', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('926', '1', '1719672251', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('927', '1', '1719672251', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('928', '1', '1719672251', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('929', '1', '1719672251', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('930', '1', '1719672251', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('931', '1', '1719672251', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('932', '1', '1719672252', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('933', '1', '1719672252', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('934', '1', '1719672254', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('935', '1', '1719672254', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('936', '1', '1719672254', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('937', '1', '1719672254', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('938', '1', '1719672254', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('939', '1', '1719672254', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('940', '1', '1719672259', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('941', '1', '1719672259', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('942', '1', '1719672259', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('943', '1', '1719672259', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('944', '1', '1719672259', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('945', '1', '1719672259', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('946', '1', '1719672267', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('947', '1', '1719672271', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('948', '1', '1719672286', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('949', '1', '1719672287', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('950', '1', '1719672288', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('951', '1', '1719672288', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('952', '1', '1719672289', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('953', '1', '1719672290', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('954', '1', '1719672290', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('955', '1', '1719672290', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('956', '1', '1719672290', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('957', '1', '1719672290', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('958', '1', '1719672353', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('959', '1', '1719672354', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('960', '1', '1719672355', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('961', '1', '1719672355', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('962', '1', '1719672355', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('963', '1', '1719672355', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('964', '1', '1719672355', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('965', '1', '1719672400', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('966', '1', '1719672408', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('967', '1', '1719672410', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('968', '1', '1719672412', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('969', '1', '1719672413', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('970', '1', '1719672416', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('971', '1', '1719672418', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('972', '1', '1719672420', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('973', '1', '1719672420', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('974', '1', '1719672421', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('975', '1', '1719672428', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('976', '1', '1719672429', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('977', '1', '1719672429', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('978', '1', '1719672430', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('979', '1', '1719672431', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('980', '1', '1719672434', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('981', '1', '1719672437', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('982', '1', '1719672439', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('983', '1', '1719672444', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('984', '1', '1719672444', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('985', '1', '1719672444', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('986', '1', '1719672444', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('987', '1', '1719672444', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('988', '1', '1719672444', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('989', '1', '1719672455', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('990', '1', '1719672455', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('991', '1', '1719672455', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('992', '1', '1719672455', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('993', '1', '1719672455', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('994', '1', '1719672455', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('995', '1', '1719672464', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('996', '1', '1719672479', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('997', '1', '1719672486', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('998', '1', '1719672486', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('999', '1', '1719672487', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1000', '1', '1719672487', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1001', '1', '1719672487', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1002', '1', '1719672487', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1003', '1', '1719672487', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1004', '1', '1719672487', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1005', '1', '1719672492', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('1006', '1', '1719672525', '127.0.0.1', '/desktop/system.desktop.route.add/save');
INSERT INTO `operation_log` VALUES ('1007', '1', '1719672526', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1008', '1', '1719672565', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1009', '1', '1719672565', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1010', '1', '1719672566', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1011', '1', '1719672566', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1012', '1', '1719672566', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1013', '1', '1719672566', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1014', '1', '1719672566', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1015', '1', '1719672612', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1016', '1', '1719672613', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1017', '1', '1719672613', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1018', '1', '1719672613', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1019', '1', '1719672613', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1020', '1', '1719672613', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1021', '1', '1719672613', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1022', '1', '1719672624', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1023', '1', '1719672631', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1024', '1', '1719672637', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1025', '1', '1719672648', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1026', '1', '1719672670', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1027', '1', '1719672674', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1028', '1', '1719672710', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1029', '1', '1719672710', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1030', '1', '1719672714', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1031', '1', '1719672719', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1032', '1', '1719672719', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1033', '1', '1719672725', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1034', '1', '1719672726', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1035', '1', '1719672730', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1036', '1', '1719672757', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1037', '1', '1719672757', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1038', '1', '1719672764', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1039', '1', '1719672788', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1040', '1', '1719672789', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1041', '1', '1719672808', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1042', '1', '1719672811', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1043', '1', '1719672811', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1044', '1', '1719672812', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1045', '1', '1719672849', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1046', '1', '1719672849', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1047', '1', '1719672861', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1048', '1', '1719672907', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1049', '1', '1719672908', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1050', '1', '1719672915', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1051', '1', '1719672950', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1052', '1', '1719672950', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1053', '1', '1719672967', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1054', '1', '1719672989', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1055', '1', '1719672989', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1056', '1', '1719672994', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1057', '1', '1719673015', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1058', '1', '1719673015', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1059', '1', '1719673016', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1060', '1', '1719673032', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1061', '1', '1719673032', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1062', '1', '1719673034', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1063', '1', '1719673054', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1064', '1', '1719673055', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1065', '1', '1719673057', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1066', '1', '1719673078', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1067', '1', '1719673079', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1068', '1', '1719673080', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1069', '1', '1719673096', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1070', '1', '1719673097', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1071', '1', '1719673099', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1072', '1', '1719673121', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1073', '1', '1719673121', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1074', '1', '1719673124', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1075', '1', '1719673138', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1076', '1', '1719673139', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1077', '1', '1719673140', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1078', '1', '1719673165', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1079', '1', '1719673166', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1080', '1', '1719673170', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1081', '1', '1719673180', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1082', '1', '1719673190', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1083', '1', '1719673200', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1084', '1', '1719673269', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1085', '1', '1719673269', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1086', '1', '1719673270', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1087', '1', '1719673270', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1088', '1', '1719673270', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1089', '1', '1719673270', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1090', '1', '1719673270', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1091', '1', '1719673270', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1092', '1', '1719673272', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1093', '1', '1719673281', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1094', '1', '1719673329', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1095', '1', '1719673336', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1096', '1', '1719673341', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('1097', '1', '1719673361', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('1098', '1', '1719673361', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1099', '1', '1719673371', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1100', '1', '1719673373', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1101', '1', '1719673373', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1102', '1', '1719673379', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1103', '1', '1719673384', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1104', '1', '1719673406', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1105', '1', '1719673408', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1106', '1', '1719673410', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('1107', '1', '1719673416', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('1108', '1', '1719673416', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1109', '1', '1719673418', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1110', '1', '1719673418', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1111', '1', '1719673419', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1112', '1', '1719673419', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1113', '1', '1719673419', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1114', '1', '1719673419', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1115', '1', '1719673419', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1116', '1', '1719673419', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1117', '1', '1719673429', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1118', '1', '1719673432', '127.0.0.1', '/desktop/system.mobile.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1119', '1', '1719673433', '127.0.0.1', '/desktop/system.mobile.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1120', '1', '1719673434', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1121', '1', '1719673435', '127.0.0.1', '/desktop/system.mobile.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1122', '1', '1719673436', '127.0.0.1', '/desktop/system.mobile.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1123', '1', '1719673437', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1124', '1', '1719673438', '127.0.0.1', '/desktop/system.mobile.permission.add/init');
INSERT INTO `operation_log` VALUES ('1125', '1', '1719673700', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1126', '1', '1719673700', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1127', '1', '1719673701', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1128', '1', '1719673701', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1129', '1', '1719673701', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1130', '1', '1719673701', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1131', '1', '1719673701', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1132', '1', '1719673703', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1133', '1', '1719673705', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1134', '1', '1719673705', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1135', '1', '1719673707', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1136', '1', '1719673708', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1137', '1', '1719673726', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1138', '1', '1719673726', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1139', '1', '1719673726', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1140', '1', '1719673726', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1141', '1', '1719673726', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1142', '1', '1719673734', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1143', '1', '1719673734', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1144', '1', '1719673734', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1145', '1', '1719673734', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1146', '1', '1719673734', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1147', '1', '1719673750', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1148', '1', '1719673751', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1149', '1', '1719673751', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1150', '1', '1719673751', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1151', '1', '1719673751', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1152', '1', '1719673773', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1153', '1', '1719673775', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1154', '1', '1719673775', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1155', '1', '1719673775', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1156', '1', '1719673775', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1157', '1', '1719673775', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1158', '1', '1719673775', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1159', '1', '1719673776', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1160', '1', '1719673777', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1161', '1', '1719673778', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1162', '1', '1719673778', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1163', '1', '1719673778', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1164', '1', '1719673778', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1165', '1', '1719673778', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1166', '1', '1719673778', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1167', '1', '1719673782', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1168', '1', '1719673792', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1169', '1', '1719673804', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1170', '1', '1719673804', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1171', '1', '1719673807', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1172', '1', '1719673814', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1173', '1', '1719673815', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1174', '1', '1719673816', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1175', '1', '1719673818', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('1176', '1', '1719673830', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('1177', '1', '1719673830', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1178', '1', '1719673834', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1179', '1', '1719673834', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1180', '1', '1719673835', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1181', '1', '1719673835', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1182', '1', '1719673835', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1183', '1', '1719673835', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1184', '1', '1719673835', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1185', '1', '1719673835', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1186', '1', '1719673854', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1187', '1', '1719673854', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1188', '1', '1719673892', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1189', '1', '1719673892', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1190', '1', '1719673893', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1191', '1', '1719673893', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1192', '1', '1719673893', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1193', '1', '1719673893', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1194', '1', '1719673899', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1195', '1', '1719673941', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1196', '1', '1719674294', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1197', '1', '1719674295', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1198', '1', '1719674296', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1199', '1', '1719674296', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1200', '1', '1719674296', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1201', '1', '1719674296', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1202', '1', '1719674296', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1203', '1', '1719674296', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1204', '1', '1719674321', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1205', '1', '1719674323', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1206', '1', '1719674325', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1207', '1', '1719674333', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1208', '1', '1719674333', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1209', '1', '1719674336', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1210', '1', '1719674336', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1211', '1', '1719674336', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1212', '1', '1719674336', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1213', '1', '1719674336', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1214', '1', '1719674336', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1215', '1', '1719674339', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1216', '1', '1719674339', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1217', '1', '1719674340', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1218', '1', '1719674340', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1219', '1', '1719674341', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1220', '1', '1719674341', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1221', '1', '1719674341', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1222', '1', '1719674341', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1223', '1', '1719713737', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1224', '1', '1719713739', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1225', '1', '1719713753', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1226', '1', '1719713753', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1227', '1', '1719713753', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1228', '1', '1719713753', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1229', '1', '1719713753', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1230', '1', '1719713775', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1231', '1', '1719713781', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1232', '1', '1719713786', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1233', '1', '1719713792', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1234', '1', '1719713814', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1235', '1', '1719713827', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1236', '1', '1719713828', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1237', '1', '1719713835', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1238', '1', '1719713866', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1239', '1', '1719713867', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1240', '1', '1719713868', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1241', '1', '1719713893', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1242', '1', '1719713893', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1243', '1', '1719713905', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1244', '1', '1719713928', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1245', '1', '1719713929', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1246', '1', '1719713935', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1247', '1', '1719713978', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1248', '1', '1719714016', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1249', '1', '1719714016', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1250', '1', '1719714019', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1251', '1', '1719714045', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1252', '1', '1719714045', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1253', '1', '1719714047', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1254', '1', '1719714076', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1255', '1', '1719714077', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1256', '1', '1719714081', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1257', '1', '1719714103', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1258', '1', '1719714103', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1259', '1', '1719714107', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1260', '1', '1719714131', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1261', '1', '1719714131', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1262', '1', '1719714133', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1263', '1', '1719714170', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1264', '1', '1719714170', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1265', '1', '1719714171', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1266', '1', '1719714194', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1267', '1', '1719714195', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1268', '1', '1719714195', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1269', '1', '1719714228', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1270', '1', '1719714228', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1271', '1', '1719714233', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1272', '1', '1719714272', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1273', '1', '1719714273', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1274', '1', '1719714274', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1275', '1', '1719714300', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1276', '1', '1719714300', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1277', '1', '1719714301', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1278', '1', '1719714339', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1279', '1', '1719714340', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1280', '1', '1719714345', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1281', '1', '1719714368', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1282', '1', '1719714369', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1283', '1', '1719714522', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1284', '1', '1719714527', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1285', '1', '1719714547', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1286', '1', '1719714547', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1287', '1', '1719714550', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1288', '1', '1719714618', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1289', '1', '1719714618', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1290', '1', '1719714619', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1291', '1', '1719714648', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1292', '1', '1719714649', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1293', '1', '1719714650', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1294', '1', '1719714677', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1295', '1', '1719714677', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1296', '1', '1719714684', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1297', '1', '1719714700', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1298', '1', '1719714700', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1299', '1', '1719714704', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1300', '1', '1719714740', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1301', '1', '1719714741', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1302', '1', '1719714741', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1303', '1', '1719714784', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1304', '1', '1719714785', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1305', '1', '1719714787', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1306', '1', '1719714832', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1307', '1', '1719714832', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1308', '1', '1719714837', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1309', '1', '1719714843', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1310', '1', '1719714847', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1311', '1', '1719714847', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1312', '1', '1719714850', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1313', '1', '1719714861', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1314', '1', '1719714861', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1315', '1', '1719714875', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1316', '1', '1719714879', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1317', '1', '1719714879', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1318', '1', '1719714894', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1319', '1', '1719714930', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1320', '1', '1719715174', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1321', '1', '1719715174', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1322', '1', '1719715177', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1323', '1', '1719715235', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1324', '1', '1719715236', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1325', '1', '1719715238', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1326', '1', '1719715238', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1327', '1', '1719715239', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1328', '1', '1719715239', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1329', '1', '1719715239', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1330', '1', '1719715239', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1331', '1', '1719715239', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1332', '1', '1719715239', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1333', '1', '1719715241', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1334', '1', '1719715250', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1335', '1', '1719715276', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1336', '1', '1719715277', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1337', '1', '1719715280', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1338', '1', '1719715299', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1339', '1', '1719715299', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1340', '1', '1719715312', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1341', '1', '1719715313', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('1342', '1', '1719715322', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('1343', '1', '1719715322', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1344', '1', '1719715351', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1345', '1', '1719715368', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1346', '1', '1719715372', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1347', '1', '1719715376', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1348', '1', '1719715376', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1349', '1', '1719715379', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1350', '1', '1719715382', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1351', '1', '1719715383', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1352', '1', '1719715387', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1353', '1', '1719715392', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1354', '1', '1719715425', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1355', '1', '1719715425', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1356', '1', '1719715425', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1357', '1', '1719715426', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1358', '1', '1719715428', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1359', '1', '1719715429', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1360', '1', '1719715429', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1361', '1', '1719715429', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1362', '1', '1719715429', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1363', '1', '1719715429', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1364', '1', '1719715429', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1365', '1', '1719715429', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1366', '1', '1719715430', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1367', '1', '1719715430', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1368', '1', '1719715430', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1369', '1', '1719715430', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1370', '1', '1719715437', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1371', '1', '1719715437', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1372', '1', '1719715437', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1373', '1', '1719715438', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1374', '1', '1719715440', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1375', '1', '1719715440', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1376', '1', '1719715440', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1377', '1', '1719715441', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1378', '1', '1719715441', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1379', '1', '1719715441', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1380', '1', '1719715442', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1381', '1', '1719715441', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1382', '1', '1719715442', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1383', '1', '1719715442', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1384', '1', '1719715442', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1385', '1', '1719715442', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1386', '1', '1719715449', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1387', '1', '1719715449', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1388', '1', '1719715449', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1389', '1', '1719715450', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1390', '1', '1719715452', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1391', '1', '1719715452', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1392', '1', '1719715453', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1393', '1', '1719715454', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1394', '1', '1719715455', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1395', '1', '1719715455', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1396', '1', '1719715455', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1397', '1', '1719715455', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1398', '1', '1719715456', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1399', '1', '1719715456', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1400', '1', '1719715456', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1401', '1', '1719715456', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1402', '1', '1719715456', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1403', '1', '1719715456', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1404', '1', '1719715456', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1405', '1', '1719715456', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1406', '1', '1719715612', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1407', '1', '1719715642', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1408', '1', '1719715653', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1409', '1', '1719715653', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1410', '1', '1719715656', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1411', '1', '1719715671', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1412', '1', '1719715672', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1413', '1', '1719715860', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1414', '1', '1719715866', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('1415', '1', '1719715903', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('1416', '1', '1719715908', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1417', '1', '1719715910', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('1418', '1', '1719717696', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1419', '1', '1719717699', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1420', '1', '1719717701', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('1421', '1', '1719717703', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1422', '1', '1719717705', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1423', '1', '1719717706', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1424', '1', '1719717889', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('1425', '1', '1719717952', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1426', '1', '1719717952', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1427', '1', '1719718146', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1428', '1', '1719718343', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1429', '1', '1719718343', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1430', '1', '1719718344', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1431', '1', '1719718344', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1432', '1', '1719718344', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1433', '1', '1719718344', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1434', '1', '1719718344', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1435', '1', '1719718344', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1436', '1', '1719718349', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('1437', '1', '1719718352', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1438', '1', '1719718352', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1439', '1', '1719718354', '127.0.0.1', '/desktop/system.user.add/init');
INSERT INTO `operation_log` VALUES ('1440', '1', '1719718368', '127.0.0.1', '/desktop/system.user.add/save');
INSERT INTO `operation_log` VALUES ('1441', '1', '1719718369', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1442', '1', '1719718373', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('1443', '1', '1719718375', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('1444', '1', '1719718375', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1445', '1', '1719718377', '127.0.0.1', '/desktop/system.user.index/editstatus');
INSERT INTO `operation_log` VALUES ('1446', '1', '1719718378', '127.0.0.1', '/desktop/system.user.index/editstatus');
INSERT INTO `operation_log` VALUES ('1447', '1', '1719718415', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1448', '1', '1719718455', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1449', '1', '1719718456', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1450', '1', '1719718466', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1451', '1', '1719718470', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1452', '1', '1719718471', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1453', '1', '1719718473', '127.0.0.1', '/desktop/system.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('1454', '1', '1719718479', '127.0.0.1', '/desktop/system.user.index/offline');
INSERT INTO `operation_log` VALUES ('1455', '1', '1719718484', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1456', '1', '1719718486', '127.0.0.1', '/desktop/system.department.add/init');
INSERT INTO `operation_log` VALUES ('1457', '1', '1719718493', '127.0.0.1', '/desktop/system.department.add/save');
INSERT INTO `operation_log` VALUES ('1458', '1', '1719718582', '127.0.0.1', '/desktop/system.department.add/save');
INSERT INTO `operation_log` VALUES ('1459', '1', '1719718582', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1460', '1', '1719718586', '127.0.0.1', '/desktop/system.department.edit/init');
INSERT INTO `operation_log` VALUES ('1461', '1', '1719718587', '127.0.0.1', '/desktop/system.department.edit/save');
INSERT INTO `operation_log` VALUES ('1462', '1', '1719718588', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1463', '1', '1719718592', '127.0.0.1', '/desktop/system.department.index/delete');
INSERT INTO `operation_log` VALUES ('1464', '1', '1719718592', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1465', '1', '1719718596', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1466', '1', '1719718610', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1467', '1', '1719718620', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1468', '1', '1719718621', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1469', '1', '1719718626', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1470', '1', '1719718627', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1471', '1', '1719718637', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1472', '1', '1719718676', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1473', '1', '1719718676', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1474', '1', '1719718677', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1475', '1', '1719718704', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1476', '1', '1719718705', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1477', '1', '1719718705', '127.0.0.1', '/desktop/system.desktop.permission.add/init');
INSERT INTO `operation_log` VALUES ('1478', '1', '1719718741', '127.0.0.1', '/desktop/system.desktop.permission.add/save');
INSERT INTO `operation_log` VALUES ('1479', '1', '1719718742', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1480', '1', '1719718744', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1481', '1', '1719718776', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('1482', '1', '1719718781', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('1483', '1', '1719718781', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1484', '1', '1719718791', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('1485', '1', '1719718813', '127.0.0.1', '/desktop/system.role.add/save');
INSERT INTO `operation_log` VALUES ('1486', '1', '1719718813', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1487', '1', '1719719085', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1488', '1', '1719719096', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1489', '1', '1719719106', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1490', '1', '1719719117', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1491', '1', '1719719124', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1492', '1', '1719719134', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1493', '1', '1719719134', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1494', '1', '1719719139', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1495', '1', '1719719144', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1496', '1', '1719719147', '127.0.0.1', '/desktop/system.mobile.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1497', '1', '1719719198', '127.0.0.1', '/desktop/system.mobile.permission.edit/save');
INSERT INTO `operation_log` VALUES ('1498', '1', '1719719198', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1499', '1', '1719719201', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('1500', '1', '1719719204', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('1501', '1', '1719719206', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('1502', '1', '1719719667', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1503', '1', '1719719667', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1504', '1', '1719719795', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1505', '1', '1719719795', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1506', '1', '1719719816', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1507', '1', '1719719816', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1508', '1', '1719719818', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1509', '1', '1719719818', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1510', '1', '1719719818', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1511', '1', '1719719818', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1512', '1', '1719719818', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1513', '1', '1719719818', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('1514', '1', '1719720070', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1515', '1', '1719720070', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1516', '1', '1719720144', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1517', '1', '1719720145', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1518', '1', '1719720174', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1519', '1', '1719720174', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1520', '1', '1719721176', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1521', '1', '1719721176', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1522', '1', '1719721176', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1523', '1', '1719721177', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1524', '1', '1719721186', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1525', '1', '1719721187', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1526', '1', '1719721188', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1527', '1', '1719721188', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1528', '1', '1719721307', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1529', '1', '1719721307', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1530', '1', '1719721307', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1531', '1', '1719721307', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1532', '1', '1719721484', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1533', '1', '1719721485', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1534', '1', '1719721485', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1535', '1', '1719721485', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1536', '1', '1719721542', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1537', '1', '1719721542', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1538', '1', '1719721559', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1539', '1', '1719721559', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1540', '1', '1719721560', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1541', '1', '1719721560', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1542', '1', '1719721562', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1543', '1', '1719721563', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1544', '1', '1719721576', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1545', '1', '1719721576', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1546', '1', '1719721577', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1547', '1', '1719721578', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1548', '1', '1719721593', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1549', '1', '1719721593', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1550', '1', '1719721593', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1551', '1', '1719721594', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1552', '1', '1719721596', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1553', '1', '1719721596', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1554', '1', '1719721596', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1555', '1', '1719721596', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1556', '1', '1719721596', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1557', '1', '1719721596', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1558', '1', '1719721598', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1559', '1', '1719721598', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1560', '1', '1719721598', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1561', '1', '1719721598', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1562', '1', '1719721598', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1563', '1', '1719721598', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('1564', '1', '1719721605', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1565', '1', '1719721617', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1566', '1', '1719721619', '127.0.0.1', '/desktop/system.desktop.menu.add/init');
INSERT INTO `operation_log` VALUES ('1567', '1', '1719721685', '127.0.0.1', '/desktop/system.desktop.menu.add/save');
INSERT INTO `operation_log` VALUES ('1568', '1', '1719721685', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1569', '1', '1719721689', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1570', '1', '1719721690', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('1571', '1', '1719721694', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('1572', '1', '1719721695', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1573', '1', '1719721697', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1574', '1', '1719721697', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1575', '1', '1719721698', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1576', '1', '1719721698', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1577', '1', '1719721698', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1578', '1', '1719721698', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1579', '1', '1719721698', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1580', '1', '1719721698', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1581', '1', '1719722057', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1582', '1', '1719722066', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1583', '1', '1719722070', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1584', '1', '1719722070', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1585', '1', '1719722070', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1586', '1', '1719722070', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1587', '1', '1719722070', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1588', '1', '1719722070', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1589', '1', '1719722090', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1590', '1', '1719722090', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1591', '1', '1719722091', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1592', '1', '1719722091', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1593', '1', '1719722091', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1594', '1', '1719722091', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1595', '1', '1719722091', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1596', '1', '1719722092', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1597', '1', '1719722315', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1598', '1', '1719722315', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1599', '1', '1719722331', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1600', '1', '1719722331', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1601', '1', '1719722338', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1602', '1', '1719722338', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1603', '1', '1719722343', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1604', '1', '1719722343', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1605', '1', '1719722351', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1606', '1', '1719722351', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1607', '1', '1719722351', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1608', '1', '1719722351', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1609', '1', '1719722351', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1610', '1', '1719722351', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1611', '1', '1719722390', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1612', '1', '1719722390', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1613', '1', '1719722408', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1614', '1', '1719722408', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1615', '1', '1719722410', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1616', '1', '1719722410', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1617', '1', '1719722410', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1618', '1', '1719722410', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1619', '1', '1719722410', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1620', '1', '1719722410', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1621', '1', '1719722471', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1622', '1', '1719722471', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1623', '1', '1719722471', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1624', '1', '1719722472', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1625', '1', '1719722479', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1626', '1', '1719722479', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1627', '1', '1719722479', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1628', '1', '1719722480', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1629', '1', '1719722481', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1630', '1', '1719722481', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1631', '1', '1719722482', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1632', '1', '1719722482', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1633', '1', '1719722482', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1634', '1', '1719722482', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1635', '1', '1719722482', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1636', '1', '1719722482', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1637', '1', '1719722482', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1638', '1', '1719722482', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1639', '1', '1719722482', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1640', '1', '1719722482', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1641', '1', '1719722628', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('1642', '1', '1719722630', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1643', '1', '1719722640', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1644', '1', '1719722640', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1645', '1', '1719722642', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1646', '1', '1719722642', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1647', '1', '1719722642', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1648', '1', '1719722642', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1649', '1', '1719722642', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1650', '1', '1719722642', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1651', '1', '1719722656', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1652', '1', '1719722657', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1653', '1', '1719722658', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1654', '1', '1719722658', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1655', '1', '1719722658', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1656', '1', '1719722658', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1657', '1', '1719722658', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1658', '1', '1719722732', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1659', '1', '1719722732', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1660', '1', '1719722733', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1661', '1', '1719722733', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1662', '1', '1719722733', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1663', '1', '1719722733', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1664', '1', '1719722733', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1665', '1', '1719722739', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1666', '1', '1719722742', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1667', '1', '1719722742', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1668', '1', '1719722744', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1669', '1', '1719722744', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1670', '1', '1719722744', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1671', '1', '1719722744', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1672', '1', '1719722744', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1673', '1', '1719722744', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1674', '1', '1719722756', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1675', '1', '1719722756', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1676', '1', '1719722758', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1677', '1', '1719722758', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1678', '1', '1719722758', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1679', '1', '1719722758', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1680', '1', '1719722758', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1681', '1', '1719722758', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1682', '1', '1719722878', '127.0.0.1', '/desktop/main/logout');
INSERT INTO `operation_log` VALUES ('1683', '1', '1719722884', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1684', '1', '1719722884', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1685', '1', '1719722884', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1686', '1', '1719722885', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1687', '1', '1719722885', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1688', '1', '1719722885', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1689', '1', '1719722885', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1690', '1', '1719722888', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1691', '1', '1719722890', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1692', '1', '1719722892', '127.0.0.1', '/desktop/statistic.trend.index/exportexcel');
INSERT INTO `operation_log` VALUES ('1693', '1', '1719722898', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('1694', '1', '1719722900', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('1695', '1', '1719722901', '127.0.0.1', '/desktop/statistic.department.index/exportexcel');
INSERT INTO `operation_log` VALUES ('1696', '1', '1719722911', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1697', '1', '1719722912', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('1698', '1', '1719722914', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1699', '1', '1719722915', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1700', '1', '1719722918', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1701', '1', '1719722921', '127.0.0.1', '/desktop/system.user.add/init');
INSERT INTO `operation_log` VALUES ('1702', '1', '1719722937', '127.0.0.1', '/desktop/system.user.add/save');
INSERT INTO `operation_log` VALUES ('1703', '1', '1719722938', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1704', '1', '1719722945', '127.0.0.1', '/desktop/system.user.index/editstatus');
INSERT INTO `operation_log` VALUES ('1705', '1', '1719722946', '127.0.0.1', '/desktop/system.user.index/editstatus');
INSERT INTO `operation_log` VALUES ('1706', '1', '1719722947', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('1707', '1', '1719722948', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('1708', '1', '1719722949', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1709', '1', '1719722960', '127.0.0.1', '/desktop/system.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('1710', '1', '1719722968', '127.0.0.1', '/desktop/system.user.index/offline');
INSERT INTO `operation_log` VALUES ('1711', '1', '1719722970', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1712', '1', '1719722973', '127.0.0.1', '/desktop/system.department.add/init');
INSERT INTO `operation_log` VALUES ('1713', '1', '1719722981', '127.0.0.1', '/desktop/system.department.add/save');
INSERT INTO `operation_log` VALUES ('1714', '1', '1719722981', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1715', '1', '1719722983', '127.0.0.1', '/desktop/system.department.edit/init');
INSERT INTO `operation_log` VALUES ('1716', '1', '1719722984', '127.0.0.1', '/desktop/system.department.edit/save');
INSERT INTO `operation_log` VALUES ('1717', '1', '1719722985', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1718', '1', '1719722988', '127.0.0.1', '/desktop/system.department.index/delete');
INSERT INTO `operation_log` VALUES ('1719', '1', '1719722988', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1720', '1', '1719722989', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1721', '1', '1719722991', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('1722', '1', '1719722994', '127.0.0.1', '/desktop/system.role.add/save');
INSERT INTO `operation_log` VALUES ('1723', '1', '1719722994', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1724', '1', '1719722996', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('1725', '1', '1719723001', '127.0.0.1', '/desktop/system.role.edit/save');
INSERT INTO `operation_log` VALUES ('1726', '1', '1719723002', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1727', '1', '1719723034', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1728', '1', '1719723034', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1729', '1', '1719723038', '127.0.0.1', '/desktop/system.role.index/delete');
INSERT INTO `operation_log` VALUES ('1730', '1', '1719723038', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1731', '1', '1719723042', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1732', '1', '1719723046', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1733', '1', '1719723048', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1734', '1', '1719723050', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1735', '1', '1719723051', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('1736', '1', '1719723053', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('1737', '1', '1719723056', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('1738', '1', '1719723206', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1739', '1', '1719723208', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('1740', '1', '1719723212', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('1741', '1', '1719796049', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1742', '1', '1719796049', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1743', '1', '1719796051', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1744', '1', '1719796051', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1745', '1', '1719796051', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1746', '1', '1719796051', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1747', '1', '1719796051', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1748', '1', '1719796084', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1749', '1', '1719796087', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('1750', '1', '1719796092', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1751', '1', '1719796099', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1752', '1', '1719796099', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1753', '1', '1719796101', '127.0.0.1', '/desktop/system.user.add/init');
INSERT INTO `operation_log` VALUES ('1754', '1', '1719796113', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1755', '1', '1719796117', '127.0.0.1', '/desktop/system.department.add/init');
INSERT INTO `operation_log` VALUES ('1756', '1', '1719796140', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('1757', '1', '1719796186', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1758', '1', '1719796190', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('1759', '1', '1719796208', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1760', '1', '1719796263', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1761', '1', '1719796271', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1762', '1', '1719796271', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1763', '1', '1719796275', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1764', '1', '1719796275', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1765', '1', '1719796275', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1766', '1', '1719796275', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1767', '1', '1719796275', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1768', '1', '1719796275', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1769', '1', '1719796316', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1770', '1', '1719796323', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1771', '1', '1719796333', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('1772', '1', '1719796343', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1773', '1', '1719796346', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1774', '1', '1719796349', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('1775', '1', '1719796361', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('1776', '1', '1719796365', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('1777', '1', '1719796367', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('1778', '1', '1719796373', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1779', '1', '1719796374', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('1780', '1', '1719796378', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1781', '1', '1719796379', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1782', '1', '1719796397', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('1783', '1', '1719796598', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1784', '1', '1719796598', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1785', '1', '1719796599', '127.0.0.1', '/desktop/system.user.add/init');
INSERT INTO `operation_log` VALUES ('1786', '1', '1721032869', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1787', '1', '1721032870', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1788', '1', '1721032873', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1789', '1', '1721032874', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1790', '1', '1721032874', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1791', '1', '1721032874', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1792', '1', '1721032874', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1793', '1', '1721032881', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1794', '1', '1721033101', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1795', '1', '1721033113', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('1796', '1', '1721033120', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1797', '1', '1721033120', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1798', '1', '1721033129', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1799', '1', '1721033134', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1800', '1', '1721033141', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1801', '1', '1721033171', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1802', '1', '1721033193', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1803', '1', '1721033210', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1804', '1', '1721033239', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1805', '1', '1721033240', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1806', '1', '1721033242', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('1807', '1', '1721033327', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1808', '1', '1721033395', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1809', '1', '1721033400', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1810', '1', '1721033400', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1811', '1', '1721033404', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1812', '1', '1721033409', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1813', '1', '1721033410', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1814', '1', '1721033413', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1815', '1', '1721033418', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1816', '1', '1721033419', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1817', '1', '1721033424', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1818', '1', '1721033429', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1819', '1', '1721033430', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1820', '1', '1721033434', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1821', '1', '1721033439', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1822', '1', '1721033439', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1823', '1', '1721033444', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1824', '1', '1721033448', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1825', '1', '1721033449', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1826', '1', '1721033452', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1827', '1', '1721033456', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1828', '1', '1721033456', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1829', '1', '1721033459', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1830', '1', '1721033464', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1831', '1', '1721033465', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1832', '1', '1721033472', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1833', '1', '1721033477', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1834', '1', '1721033477', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1835', '1', '1721033480', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1836', '1', '1721033486', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1837', '1', '1721033487', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1838', '1', '1721033490', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1839', '1', '1721033494', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1840', '1', '1721033494', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1841', '1', '1721033498', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1842', '1', '1721033504', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1843', '1', '1721033504', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1844', '1', '1721033510', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1845', '1', '1721033518', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1846', '1', '1721033519', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1847', '1', '1721033524', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1848', '1', '1721033529', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1849', '1', '1721033530', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1850', '1', '1721033534', '127.0.0.1', '/desktop/system.desktop.route.edit/init');
INSERT INTO `operation_log` VALUES ('1851', '1', '1721033536', '127.0.0.1', '/desktop/system.desktop.route.edit/save');
INSERT INTO `operation_log` VALUES ('1852', '1', '1721033537', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('1853', '1', '1721033541', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1854', '1', '1721033546', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1855', '1', '1721033549', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1856', '1', '1721033550', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1857', '1', '1721033564', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1858', '1', '1721033569', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1859', '1', '1721033569', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1860', '1', '1721033572', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1861', '1', '1721033574', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1862', '1', '1721033575', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1863', '1', '1721033580', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1864', '1', '1721033583', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1865', '1', '1721033583', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1866', '1', '1721033587', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1867', '1', '1721033590', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1868', '1', '1721033591', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1869', '1', '1721033594', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1870', '1', '1721033597', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1871', '1', '1721033598', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1872', '1', '1721033600', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1873', '1', '1721033604', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1874', '1', '1721033604', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1875', '1', '1721033608', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1876', '1', '1721033610', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1877', '1', '1721033611', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1878', '1', '1721033612', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1879', '1', '1721033616', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1880', '1', '1721033617', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1881', '1', '1721033619', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1882', '1', '1721033622', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1883', '1', '1721033623', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1884', '1', '1721033633', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1885', '1', '1721033640', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1886', '1', '1721033644', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1887', '1', '1721033644', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1888', '1', '1721033646', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('1889', '1', '1721033650', '127.0.0.1', '/desktop/system.desktop.menu.edit/save');
INSERT INTO `operation_log` VALUES ('1890', '1', '1721033650', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1891', '1', '1721033655', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1892', '1', '1721033656', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1893', '1', '1721033657', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1894', '1', '1721033657', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1895', '1', '1721033657', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('1896', '1', '1721033657', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1897', '1', '1721033657', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1898', '1', '1721033658', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1899', '1', '1721033668', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1900', '1', '1721033673', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('1901', '1', '1721033676', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('1902', '1', '1721033724', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('1903', '1', '1721033730', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('1904', '1', '1721033743', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1905', '1', '1721033745', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('1906', '1', '1721035881', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1907', '1', '1721035881', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1908', '1', '1721035881', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1909', '1', '1721035881', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1910', '1', '1721035881', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1911', '1', '1721035883', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('1912', '1', '1721035886', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1913', '1', '1721035888', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1914', '1', '1721035888', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1915', '1', '1721035889', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('1916', '1', '1721035899', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1917', '1', '1721035900', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1918', '1', '1721035969', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1919', '1', '1721035969', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1920', '1', '1721035971', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1921', '1', '1721035971', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1922', '1', '1721035971', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1923', '1', '1721035971', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1924', '1', '1721035972', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1925', '1', '1721035972', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1926', '1', '1721035972', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1927', '1', '1721035972', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1928', '1', '1721035972', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1929', '1', '1721035972', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1930', '1', '1721035975', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1931', '1', '1721035975', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1932', '1', '1721035977', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1933', '1', '1721035977', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1934', '1', '1721035977', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1935', '1', '1721035977', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1936', '1', '1721035977', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1937', '1', '1721035977', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1938', '1', '1721035977', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1939', '1', '1721035977', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1940', '1', '1721035977', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1941', '1', '1721035980', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1942', '1', '1721035980', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1943', '1', '1721035981', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1944', '1', '1721035982', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1945', '1', '1721035982', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1946', '1', '1721035983', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1947', '1', '1721035983', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1948', '1', '1721035983', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1949', '1', '1721035983', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1950', '1', '1721035983', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1951', '1', '1721035983', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1952', '1', '1721035984', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1953', '1', '1721036003', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1954', '1', '1721036003', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1955', '1', '1721036004', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1956', '1', '1721036004', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1957', '1', '1721036004', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1958', '1', '1721036004', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1959', '1', '1721036004', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1960', '1', '1721036004', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1961', '1', '1721036005', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1962', '1', '1721036029', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1963', '1', '1721036029', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1964', '1', '1721036029', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1965', '1', '1721036029', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1966', '1', '1721036029', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1967', '1', '1721036030', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1968', '1', '1721036030', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1969', '1', '1721036045', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1970', '1', '1721036045', '127.0.0.1', '/desktop/main/init');
INSERT INTO `operation_log` VALUES ('1971', '1', '1721036045', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1972', '1', '1721036045', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1973', '1', '1721036045', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1974', '1', '1721036045', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1975', '1', '1721036046', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1976', '1', '1721036103', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1977', '1', '1721036103', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1978', '1', '1721036103', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1979', '1', '1721036103', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1980', '1', '1721036103', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1981', '1', '1721036103', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1982', '1', '1721036109', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1983', '1', '1721036109', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1984', '1', '1721036110', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1985', '1', '1721036110', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1986', '1', '1721036110', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1987', '1', '1721036110', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1988', '1', '1721036110', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1989', '1', '1721036111', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1990', '1', '1721036124', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1991', '1', '1721036124', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('1992', '1', '1721036126', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('1993', '1', '1721036126', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('1994', '1', '1721036126', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('1995', '1', '1721036126', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('1996', '1', '1721036126', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('1997', '1', '1721036126', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('1998', '1', '1721036135', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('1999', '1', '1721036135', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2000', '1', '1721036137', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2001', '1', '1721036137', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2002', '1', '1721036137', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2003', '1', '1721036137', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2004', '1', '1721036137', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2005', '1', '1721036137', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2006', '1', '1721036158', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2007', '1', '1721036158', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2008', '1', '1721036158', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2009', '1', '1721036158', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2010', '1', '1721036158', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2011', '1', '1721036159', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2012', '1', '1721036161', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2013', '1', '1721036161', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2014', '1', '1721036162', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2015', '1', '1721036162', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2016', '1', '1721036162', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2017', '1', '1721036162', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2018', '1', '1721036162', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2019', '1', '1721036163', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2020', '1', '1721036174', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2021', '1', '1721036174', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2022', '1', '1721036174', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2023', '1', '1721036174', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2024', '1', '1721036174', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2025', '1', '1721036175', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2026', '1', '1721036183', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2027', '1', '1721036184', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2028', '1', '1721036185', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2029', '1', '1721036185', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2030', '1', '1721036185', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2031', '1', '1721036185', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2032', '1', '1721036185', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2033', '1', '1721036185', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2034', '1', '1721036212', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('2035', '1', '1721036215', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('2036', '1', '1721036216', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2037', '1', '1721036217', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2038', '1', '1721036220', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('2039', '1', '1721036230', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2040', '1', '1721036233', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('2041', '1', '1721036282', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2042', '1', '1721036283', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2043', '1', '1721036284', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2044', '1', '1721036284', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2045', '1', '1721036284', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2046', '1', '1721036284', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2047', '1', '1721036284', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2048', '1', '1721036289', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('2049', '1', '1721036616', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2050', '1', '1721036616', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2051', '1', '1721036617', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('2052', '1', '1721036617', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2053', '1', '1721036617', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2054', '1', '1721036617', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2055', '1', '1721036617', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2056', '1', '1721036620', '127.0.0.1', '/desktop/system.desktop.menu.edit/init');
INSERT INTO `operation_log` VALUES ('2057', '1', '1721036623', '127.0.0.1', '/desktop/system.desktop.menu.add/init');
INSERT INTO `operation_log` VALUES ('2058', '1', '1721036626', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2059', '1', '1721036628', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2060', '1', '1721036707', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2061', '1', '1721036834', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2062', '1', '1721036839', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2063', '1', '1721036866', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2064', '1', '1721036883', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2065', '1', '1721036889', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2066', '1', '1721036970', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2067', '1', '1721037020', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2068', '1', '1721037178', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2069', '1', '1721037254', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2070', '1', '1721037809', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2071', '1', '1721037839', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2072', '1', '1721037857', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('2073', '1', '1721037858', '127.0.0.1', '/desktop/system.mobile.permission.add/init');
INSERT INTO `operation_log` VALUES ('2074', '1', '1721037877', '127.0.0.1', '/desktop/system.mobile.permission.add/init');
INSERT INTO `operation_log` VALUES ('2075', '1', '1721037881', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2076', '1', '1721037883', '127.0.0.1', '/desktop/system.role.add/init');
INSERT INTO `operation_log` VALUES ('2077', '1', '1721037886', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('2078', '1', '1721037905', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('2079', '1', '1721037930', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('2080', '1', '1721038020', '127.0.0.1', '/desktop/main.user.detail/getuser');
INSERT INTO `operation_log` VALUES ('2081', '1', '1721092763', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2082', '1', '1721092764', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2083', '1', '1721092766', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2084', '1', '1721092766', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2085', '1', '1721092766', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2086', '1', '1721092766', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2087', '1', '1721092772', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('2088', '1', '1721093388', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2089', '1', '1721093389', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2090', '1', '1721093390', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2091', '1', '1721093390', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('2092', '1', '1721093390', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2093', '1', '1721093390', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2094', '1', '1721093390', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2095', '1', '1721093506', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('2096', '1', '1721095495', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2097', '1', '1721095495', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2098', '1', '1721095496', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2099', '1', '1721095497', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2100', '1', '1721095497', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2101', '1', '1721095497', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2102', '1', '1721095502', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2103', '1', '1721095505', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('2104', '1', '1721095670', '127.0.0.1', '/desktop/main/logout');
INSERT INTO `operation_log` VALUES ('2105', '1', '1721095675', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2106', '1', '1721095676', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2107', '1', '1721095677', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2108', '1', '1721095677', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2109', '1', '1721095677', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2110', '1', '1721095677', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2111', '1', '1721095787', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2112', '1', '1721095787', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2113', '1', '1721095788', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2114', '1', '1721095788', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2115', '1', '1721095788', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2116', '1', '1721095788', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2117', '1', '1721099108', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2118', '1', '1721099108', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2119', '1', '1721099109', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2120', '1', '1721099109', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2121', '1', '1721099109', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2122', '1', '1721099109', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2123', '1', '1721099204', '127.0.0.1', '/desktop/main.user.detail/getuser');
INSERT INTO `operation_log` VALUES ('2124', '1', '1721099380', '127.0.0.1', '/desktop/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('2125', '1', '1721099380', '127.0.0.1', '/desktop/frame/getroutes');
INSERT INTO `operation_log` VALUES ('2126', '1', '1721099381', '127.0.0.1', '/desktop/main/getmenus');
INSERT INTO `operation_log` VALUES ('2127', '1', '1721099381', '127.0.0.1', '/desktop/main.message/getnoreads');
INSERT INTO `operation_log` VALUES ('2128', '1', '1721099381', '127.0.0.1', '/desktop/main/getavatar');
INSERT INTO `operation_log` VALUES ('2129', '1', '1721099381', '127.0.0.1', '/desktop/main/getwatermark');
INSERT INTO `operation_log` VALUES ('2130', '1', '1721099383', '127.0.0.1', '/desktop/main.user.detail/getuser');
INSERT INTO `operation_log` VALUES ('2131', '1', '1721099390', '127.0.0.1', '/desktop/main.user.detail/getuser');
INSERT INTO `operation_log` VALUES ('2132', '1', '1721099570', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('2133', '1', '1721099579', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('2134', '1', '1721099580', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('2135', '1', '1721099835', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('2136', '1', '1721100236', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2137', '1', '1721100236', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2138', '1', '1721100245', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2139', '1', '1721100394', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2140', '1', '1721100394', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2141', '1', '1721101576', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2142', '1', '1721101690', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('2143', '1', '1721101692', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2144', '1', '1721101695', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2145', '1', '1721101698', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('2146', '1', '1721101703', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('2147', '1', '1721101705', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('2148', '1', '1721101712', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('2149', '1', '1721101716', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('2150', '1', '1721101719', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('2151', '1', '1721101721', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('2152', '1', '1721101728', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2153', '1', '1721101728', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2154', '1', '1721101739', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('2155', '1', '1721101741', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('2156', '1', '1721101746', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('2157', '1', '1721101751', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('2158', '1', '1721101760', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('2159', '1', '1721101813', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2160', '1', '1721101813', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2161', '1', '1721101815', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('2162', '1', '1721101817', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2163', '1', '1721101819', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('2164', '1', '1721101821', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('2165', '1', '1721101823', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('2166', '1', '1721101826', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('2167', '1', '1721101828', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('2168', '1', '1721101830', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('2169', '1', '1721101832', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2170', '1', '1721101833', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2171', '1', '1721101835', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('2172', '1', '1721101847', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('2173', '1', '1721102028', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('2174', '1', '1721102215', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('2175', '1', '1721102225', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('2176', '1', '1721102264', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('2177', '1', '1721102274', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('2178', '1', '1721102295', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('2179', '1', '1721102313', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('2180', '1', '1721102315', '127.0.0.1', '/desktop/system.department.edit/init');
INSERT INTO `operation_log` VALUES ('2181', '1', '1721102348', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2182', '1', '1721102349', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('2183', '1', '1721102354', '127.0.0.1', '/desktop/system.role.edit/init');
INSERT INTO `operation_log` VALUES ('2184', '1', '1721102407', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('2185', '1', '1721102445', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('2186', '1', '1721102569', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2187', '1', '1721102571', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('2188', '1', '1721102573', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('2189', '1', '1721102583', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('2190', '1', '1721102586', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('2191', '1', '1721102588', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('2192', '1', '1721102619', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('2193', '1', '1721102623', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('2194', '1', '1721102630', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('2195', '1', '1721102706', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('2196', '1', '1721102708', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('2197', '1', '1721102710', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('2198', '1', '1721102712', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('2199', '1', '1721102714', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('2200', '1', '1721102719', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('2201', '1', '1721102744', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('2202', '1', '1721102747', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('2203', '1', '1721102751', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('2204', '1', '1721102753', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2205', '1', '1721102753', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2206', '1', '1721102754', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('2207', '1', '1721102762', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('2208', '1', '1721102766', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2209', '1', '1721102766', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('2210', '1', '1721102770', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('2211', '1', '1721102773', '127.0.0.1', '/desktop/system.config.index/save');
INSERT INTO `operation_log` VALUES ('2212', '1', '1721102778', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('2213', '1', '1721102783', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('2214', '1', '1721104133', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2215', '1', '1721104133', '127.0.0.1', '/desktop/system.user.index/getusers');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('3', '超级管理员');
INSERT INTO `role` VALUES ('4', '普通用户');

-- ----------------------------
-- Table structure for role_desktop_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_desktop_menu`;
CREATE TABLE `role_desktop_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  `menu_id` int(10) unsigned NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=333 DEFAULT CHARSET=utf8 COMMENT='角色桌面端菜单关系';

-- ----------------------------
-- Records of role_desktop_menu
-- ----------------------------
INSERT INTO `role_desktop_menu` VALUES ('306', '4', '15');
INSERT INTO `role_desktop_menu` VALUES ('307', '4', '16');
INSERT INTO `role_desktop_menu` VALUES ('308', '4', '17');
INSERT INTO `role_desktop_menu` VALUES ('309', '4', '18');
INSERT INTO `role_desktop_menu` VALUES ('310', '3', '15');
INSERT INTO `role_desktop_menu` VALUES ('311', '3', '16');
INSERT INTO `role_desktop_menu` VALUES ('312', '3', '17');
INSERT INTO `role_desktop_menu` VALUES ('313', '3', '18');
INSERT INTO `role_desktop_menu` VALUES ('314', '3', '19');
INSERT INTO `role_desktop_menu` VALUES ('315', '3', '1');
INSERT INTO `role_desktop_menu` VALUES ('316', '3', '12');
INSERT INTO `role_desktop_menu` VALUES ('317', '3', '2');
INSERT INTO `role_desktop_menu` VALUES ('318', '3', '3');
INSERT INTO `role_desktop_menu` VALUES ('319', '3', '4');
INSERT INTO `role_desktop_menu` VALUES ('320', '3', '6');
INSERT INTO `role_desktop_menu` VALUES ('321', '3', '7');
INSERT INTO `role_desktop_menu` VALUES ('322', '3', '5');
INSERT INTO `role_desktop_menu` VALUES ('323', '3', '8');
INSERT INTO `role_desktop_menu` VALUES ('324', '3', '9');
INSERT INTO `role_desktop_menu` VALUES ('325', '3', '10');
INSERT INTO `role_desktop_menu` VALUES ('326', '3', '11');
INSERT INTO `role_desktop_menu` VALUES ('327', '3', '13');
INSERT INTO `role_desktop_menu` VALUES ('328', '3', '14');
INSERT INTO `role_desktop_menu` VALUES ('329', '5', '15');
INSERT INTO `role_desktop_menu` VALUES ('330', '5', '16');
INSERT INTO `role_desktop_menu` VALUES ('331', '5', '17');
INSERT INTO `role_desktop_menu` VALUES ('332', '5', '18');

-- ----------------------------
-- Table structure for role_desktop_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_desktop_permission`;
CREATE TABLE `role_desktop_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  `permission_id` int(10) unsigned NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8 COMMENT='角色桌面端权限关系';

-- ----------------------------
-- Records of role_desktop_permission
-- ----------------------------
INSERT INTO `role_desktop_permission` VALUES ('237', '4', '41');
INSERT INTO `role_desktop_permission` VALUES ('238', '4', '38');
INSERT INTO `role_desktop_permission` VALUES ('239', '4', '40');
INSERT INTO `role_desktop_permission` VALUES ('240', '4', '39');
INSERT INTO `role_desktop_permission` VALUES ('241', '3', '41');
INSERT INTO `role_desktop_permission` VALUES ('242', '3', '38');
INSERT INTO `role_desktop_permission` VALUES ('243', '3', '40');
INSERT INTO `role_desktop_permission` VALUES ('244', '3', '39');
INSERT INTO `role_desktop_permission` VALUES ('245', '3', '1');
INSERT INTO `role_desktop_permission` VALUES ('246', '3', '8');
INSERT INTO `role_desktop_permission` VALUES ('247', '3', '2');
INSERT INTO `role_desktop_permission` VALUES ('248', '3', '3');
INSERT INTO `role_desktop_permission` VALUES ('249', '3', '4');
INSERT INTO `role_desktop_permission` VALUES ('250', '3', '5');
INSERT INTO `role_desktop_permission` VALUES ('251', '3', '6');
INSERT INTO `role_desktop_permission` VALUES ('252', '3', '7');
INSERT INTO `role_desktop_permission` VALUES ('253', '3', '9');
INSERT INTO `role_desktop_permission` VALUES ('254', '3', '20');
INSERT INTO `role_desktop_permission` VALUES ('255', '3', '21');
INSERT INTO `role_desktop_permission` VALUES ('256', '3', '22');
INSERT INTO `role_desktop_permission` VALUES ('257', '3', '10');
INSERT INTO `role_desktop_permission` VALUES ('258', '3', '42');
INSERT INTO `role_desktop_permission` VALUES ('259', '3', '43');
INSERT INTO `role_desktop_permission` VALUES ('260', '3', '44');
INSERT INTO `role_desktop_permission` VALUES ('261', '3', '11');
INSERT INTO `role_desktop_permission` VALUES ('262', '3', '12');
INSERT INTO `role_desktop_permission` VALUES ('263', '3', '23');
INSERT INTO `role_desktop_permission` VALUES ('264', '3', '24');
INSERT INTO `role_desktop_permission` VALUES ('265', '3', '25');
INSERT INTO `role_desktop_permission` VALUES ('266', '3', '13');
INSERT INTO `role_desktop_permission` VALUES ('267', '3', '26');
INSERT INTO `role_desktop_permission` VALUES ('268', '3', '27');
INSERT INTO `role_desktop_permission` VALUES ('269', '3', '28');
INSERT INTO `role_desktop_permission` VALUES ('270', '3', '14');
INSERT INTO `role_desktop_permission` VALUES ('271', '3', '29');
INSERT INTO `role_desktop_permission` VALUES ('272', '3', '30');
INSERT INTO `role_desktop_permission` VALUES ('273', '3', '31');
INSERT INTO `role_desktop_permission` VALUES ('274', '3', '15');
INSERT INTO `role_desktop_permission` VALUES ('275', '3', '16');
INSERT INTO `role_desktop_permission` VALUES ('276', '3', '32');
INSERT INTO `role_desktop_permission` VALUES ('277', '3', '33');
INSERT INTO `role_desktop_permission` VALUES ('278', '3', '34');
INSERT INTO `role_desktop_permission` VALUES ('279', '3', '17');
INSERT INTO `role_desktop_permission` VALUES ('280', '3', '35');
INSERT INTO `role_desktop_permission` VALUES ('281', '3', '36');
INSERT INTO `role_desktop_permission` VALUES ('282', '3', '37');
INSERT INTO `role_desktop_permission` VALUES ('283', '3', '18');
INSERT INTO `role_desktop_permission` VALUES ('284', '3', '19');
INSERT INTO `role_desktop_permission` VALUES ('285', '5', '1');
INSERT INTO `role_desktop_permission` VALUES ('286', '5', '8');
INSERT INTO `role_desktop_permission` VALUES ('287', '5', '2');
INSERT INTO `role_desktop_permission` VALUES ('288', '5', '3');
INSERT INTO `role_desktop_permission` VALUES ('289', '5', '4');
INSERT INTO `role_desktop_permission` VALUES ('290', '5', '5');
INSERT INTO `role_desktop_permission` VALUES ('291', '5', '6');
INSERT INTO `role_desktop_permission` VALUES ('292', '5', '7');
INSERT INTO `role_desktop_permission` VALUES ('293', '5', '9');
INSERT INTO `role_desktop_permission` VALUES ('294', '5', '20');
INSERT INTO `role_desktop_permission` VALUES ('295', '5', '21');
INSERT INTO `role_desktop_permission` VALUES ('296', '5', '22');
INSERT INTO `role_desktop_permission` VALUES ('297', '5', '10');
INSERT INTO `role_desktop_permission` VALUES ('298', '5', '42');
INSERT INTO `role_desktop_permission` VALUES ('299', '5', '43');
INSERT INTO `role_desktop_permission` VALUES ('300', '5', '44');
INSERT INTO `role_desktop_permission` VALUES ('301', '5', '11');
INSERT INTO `role_desktop_permission` VALUES ('302', '5', '12');
INSERT INTO `role_desktop_permission` VALUES ('303', '5', '23');
INSERT INTO `role_desktop_permission` VALUES ('304', '5', '24');
INSERT INTO `role_desktop_permission` VALUES ('305', '5', '25');
INSERT INTO `role_desktop_permission` VALUES ('306', '5', '13');
INSERT INTO `role_desktop_permission` VALUES ('307', '5', '26');
INSERT INTO `role_desktop_permission` VALUES ('308', '5', '27');
INSERT INTO `role_desktop_permission` VALUES ('309', '5', '28');
INSERT INTO `role_desktop_permission` VALUES ('310', '5', '14');
INSERT INTO `role_desktop_permission` VALUES ('311', '5', '29');
INSERT INTO `role_desktop_permission` VALUES ('312', '5', '30');
INSERT INTO `role_desktop_permission` VALUES ('313', '5', '31');
INSERT INTO `role_desktop_permission` VALUES ('314', '5', '15');
INSERT INTO `role_desktop_permission` VALUES ('315', '5', '16');
INSERT INTO `role_desktop_permission` VALUES ('316', '5', '32');
INSERT INTO `role_desktop_permission` VALUES ('317', '5', '33');
INSERT INTO `role_desktop_permission` VALUES ('318', '5', '34');
INSERT INTO `role_desktop_permission` VALUES ('319', '5', '17');
INSERT INTO `role_desktop_permission` VALUES ('320', '5', '35');
INSERT INTO `role_desktop_permission` VALUES ('321', '5', '36');
INSERT INTO `role_desktop_permission` VALUES ('322', '5', '37');
INSERT INTO `role_desktop_permission` VALUES ('323', '5', '18');
INSERT INTO `role_desktop_permission` VALUES ('324', '5', '19');

-- ----------------------------
-- Table structure for role_desktop_route
-- ----------------------------
DROP TABLE IF EXISTS `role_desktop_route`;
CREATE TABLE `role_desktop_route` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  `route_id` int(10) unsigned NOT NULL COMMENT '路由id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8 COMMENT='角色桌面端路由关系';

-- ----------------------------
-- Records of role_desktop_route
-- ----------------------------
INSERT INTO `role_desktop_route` VALUES ('138', '4', '12');
INSERT INTO `role_desktop_route` VALUES ('139', '4', '13');
INSERT INTO `role_desktop_route` VALUES ('140', '4', '14');
INSERT INTO `role_desktop_route` VALUES ('141', '3', '12');
INSERT INTO `role_desktop_route` VALUES ('142', '3', '13');
INSERT INTO `role_desktop_route` VALUES ('143', '3', '14');
INSERT INTO `role_desktop_route` VALUES ('144', '3', '11');
INSERT INTO `role_desktop_route` VALUES ('145', '3', '1');
INSERT INTO `role_desktop_route` VALUES ('146', '3', '2');
INSERT INTO `role_desktop_route` VALUES ('147', '3', '3');
INSERT INTO `role_desktop_route` VALUES ('148', '3', '4');
INSERT INTO `role_desktop_route` VALUES ('149', '3', '5');
INSERT INTO `role_desktop_route` VALUES ('150', '3', '6');
INSERT INTO `role_desktop_route` VALUES ('151', '3', '7');
INSERT INTO `role_desktop_route` VALUES ('152', '3', '15');
INSERT INTO `role_desktop_route` VALUES ('153', '3', '8');
INSERT INTO `role_desktop_route` VALUES ('154', '3', '9');
INSERT INTO `role_desktop_route` VALUES ('155', '3', '10');

-- ----------------------------
-- Table structure for role_mobile_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_mobile_permission`;
CREATE TABLE `role_mobile_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  `permission_id` int(10) unsigned NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='角色移动端权限关系';

-- ----------------------------
-- Records of role_mobile_permission
-- ----------------------------
INSERT INTO `role_mobile_permission` VALUES ('51', '4', '1');
INSERT INTO `role_mobile_permission` VALUES ('52', '4', '2');
INSERT INTO `role_mobile_permission` VALUES ('53', '3', '1');
INSERT INTO `role_mobile_permission` VALUES ('54', '3', '2');

-- ----------------------------
-- Table structure for runtime
-- ----------------------------
DROP TABLE IF EXISTS `runtime`;
CREATE TABLE `runtime` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `key` varchar(128) NOT NULL DEFAULT '' COMMENT '键',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='运行时';

-- ----------------------------
-- Records of runtime
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '部门id',
  `status_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态id',
  `account` varchar(64) NOT NULL DEFAULT '' COMMENT '账号',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '姓名',
  `phone` varchar(64) NOT NULL DEFAULT '' COMMENT '手机号码',
  `avatar` varchar(128) NOT NULL DEFAULT '' COMMENT '头像',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `login_ip` varchar(32) NOT NULL DEFAULT '' COMMENT '登录ip',
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '张三', '15122222222', 'avatar/2024/06/29/a3acf6bdbe87981d4595e156a3cc9f27.png', '1684989244', '1716183018', '1721101793', '127.0.0.1');
INSERT INTO `user` VALUES ('2', '1', '1', 'user', 'e10adc3949ba59abbe56e057f20f883e', '李四', '15111111111', '', '1684992552', '1703148627', '0', '');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('58', '1', '3');
INSERT INTO `user_role` VALUES ('59', '2', '4');
