/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : sun_admin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2024-07-18 09:57:20
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
INSERT INTO `desktop_menu` VALUES ('7', '6', '路由管理', '/system/desktop/route', 'Van', '1', '7');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of desktop_token
-- ----------------------------
INSERT INTO `desktop_token` VALUES ('1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjEyMjg5ODAwIDE3MjExMDAwMDcifQ.r5ZOFSEorO4rlcCf3JozTgZp5Oik0SUv-satpbMl474', '66', '1');
INSERT INTO `desktop_token` VALUES ('2', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjAxNTk2MDAwIDE3MjExMDAwMzIifQ.w8vFN6V06wbMiHJN4nTqWvb5gDDdj42gf5aeDvR7J1g', '434', '1');
INSERT INTO `desktop_token` VALUES ('3', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjc3MzU5NzAwIDE3MjExMDAyMjYifQ.HkNLmXHriYBpEqtvwJSIMGJRqGDaH08LQNMtRxb3Rbg', '33333', '1');
INSERT INTO `desktop_token` VALUES ('4', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjYyNjE4MTAwIDE3MjExMDAyNTkifQ.JFkyDu3pGnw64o448NUA6F-01bYgQvFCkXtUIFRKZOA', '17211020', '1');
INSERT INTO `desktop_token` VALUES ('5', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQ2Nzc5NjAwIDE3MjExMDAzMzkifQ.xRhf8CAI6OioLvFZVVn2lZLWQrVDpKMW5RPt-g74Hk4', '1721103593', '1');
INSERT INTO `desktop_token` VALUES ('6', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY2NDYzMDAwIDE3MjExMDE3OTMifQ.7lLKIDqz6Px0VQuexH7ZumIpciUJYJ80Vr-9-0Diow0', '1721105933', '1');
INSERT INTO `desktop_token` VALUES ('7', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk5MDIzODAwIDE3MjExMDY4OTgifQ.MbS-7b0TZG9G7XngZxQ95W7HpOZA3pJNJibwhABfCzY', '1721108700', '1');
INSERT INTO `desktop_token` VALUES ('8', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk1NTQ1MDAwIDE3MjEyNjczMjkifQ.ahezvr09fBPAsNITy4Kshu_9GxjlXA4ehh80fYe3g28', '1721269605', '1');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

-- ----------------------------
-- Records of login_log
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Records of operation_log
-- ----------------------------

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
INSERT INTO `user` VALUES ('1', '1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '张三', '15122222222', 'avatar/2024/06/29/a3acf6bdbe87981d4595e156a3cc9f27.png', '1684989244', '1716183018', '1721267330', '127.0.0.1');
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
