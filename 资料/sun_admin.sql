/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : sun_admin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2024-08-05 16:20:11
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
INSERT INTO `desktop_permission` VALUES ('2', '1', '用户管理', 'system_user', '/desktop/system.user.Index/init\n/desktop/system.user.Index/getUsers\n/desktop/system.user.Detail/init', '3');
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
  `container` varchar(32) NOT NULL DEFAULT '' COMMENT '布局容器',
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='token';

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
INSERT INTO `desktop_token` VALUES ('8', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk1NTQ1MDAwIDE3MjEyNjczMjkifQ.ahezvr09fBPAsNITy4Kshu_9GxjlXA4ehh80fYe3g28', '1721277641', '1');
INSERT INTO `desktop_token` VALUES ('9', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjg2MDU4NzAwIDE3MjEyNzk4OTYifQ.Umh-GXjsDna6rJ72sWiwlMkM6ukL5IT3g11HW9aozyo', '1721281749', '1');
INSERT INTO `desktop_token` VALUES ('11', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQ4NDg1MTAwIDE3MjEyODMzMDgifQ.e5I3tdSU0EqSDDkXA9op8PeJaVkxHAsFFAJbD_O9fIQ', '1721287979', '1');
INSERT INTO `desktop_token` VALUES ('12', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjkxODc3NjAwIDE3MjEzNTI2OTcifQ.pUCuyQbKeKCaDngYn85pmpWTE6JMT1BHGD9hH_I2_04', '1721354722', '1');
INSERT INTO `desktop_token` VALUES ('13', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjE5MjE1MDAwIDE3MjEzNTY4ODAifQ.9obY6ihcZLVCDKXE21FFq-Q5ZxFRrJay-KEz2s9w234', '1721358693', '1');
INSERT INTO `desktop_token` VALUES ('14', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjkxNDUwNDAwIDE3MjI4NDA0MzgifQ.bmLYqVcjlaSX4gkaj1PDiAM6VnFJrSXeGj4lkk48rX8', '1722847790', '1');

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
INSERT INTO `dictionary` VALUES ('4', 'desktop_route_container', 'main', '主容器', '1');
INSERT INTO `dictionary` VALUES ('5', 'desktop_route_container', 'blank', '空白容器', '2');
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES ('1', '1', '1721279896', '127.0.0.1');
INSERT INTO `login_log` VALUES ('2', '1', '1721281841', '127.0.0.1');
INSERT INTO `login_log` VALUES ('3', '1', '1721283308', '127.0.0.1');
INSERT INTO `login_log` VALUES ('4', '1', '1721295019', '127.0.0.1');
INSERT INTO `login_log` VALUES ('5', '1', '1721295056', '127.0.0.1');
INSERT INTO `login_log` VALUES ('6', '1', '1721295062', '127.0.0.1');
INSERT INTO `login_log` VALUES ('7', '1', '1721295119', '127.0.0.1');
INSERT INTO `login_log` VALUES ('8', '1', '1721295148', '127.0.0.1');
INSERT INTO `login_log` VALUES ('9', '1', '1721295260', '127.0.0.1');
INSERT INTO `login_log` VALUES ('10', '1', '1721295474', '127.0.0.1');
INSERT INTO `login_log` VALUES ('11', '1', '1721295550', '127.0.0.1');
INSERT INTO `login_log` VALUES ('12', '1', '1721295974', '127.0.0.1');
INSERT INTO `login_log` VALUES ('13', '1', '1721295982', '127.0.0.1');
INSERT INTO `login_log` VALUES ('14', '1', '1721296030', '127.0.0.1');
INSERT INTO `login_log` VALUES ('15', '1', '1721298728', '127.0.0.1');
INSERT INTO `login_log` VALUES ('16', '1', '1721352576', '127.0.0.1');
INSERT INTO `login_log` VALUES ('17', '1', '1721352698', '127.0.0.1');
INSERT INTO `login_log` VALUES ('18', '1', '1721354799', '127.0.0.1');
INSERT INTO `login_log` VALUES ('19', '1', '1721355327', '127.0.0.1');
INSERT INTO `login_log` VALUES ('20', '1', '1721356880', '127.0.0.1');
INSERT INTO `login_log` VALUES ('21', '1', '1721360261', '127.0.0.1');
INSERT INTO `login_log` VALUES ('22', '1', '1721360358', '127.0.0.1');
INSERT INTO `login_log` VALUES ('23', '1', '1721360399', '127.0.0.1');
INSERT INTO `login_log` VALUES ('24', '1', '1721360433', '127.0.0.1');
INSERT INTO `login_log` VALUES ('25', '1', '1721360563', '127.0.0.1');
INSERT INTO `login_log` VALUES ('26', '1', '1721360709', '127.0.0.1');
INSERT INTO `login_log` VALUES ('27', '1', '1721366120', '127.0.0.1');
INSERT INTO `login_log` VALUES ('28', '1', '1721370713', '127.0.0.1');
INSERT INTO `login_log` VALUES ('29', '1', '1721374404', '127.0.0.1');
INSERT INTO `login_log` VALUES ('30', '1', '1721375701', '127.0.0.1');
INSERT INTO `login_log` VALUES ('31', '1', '1721376659', '127.0.0.1');
INSERT INTO `login_log` VALUES ('32', '1', '1722840439', '127.0.0.1');

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
-- Table structure for mobile_token
-- ----------------------------
DROP TABLE IF EXISTS `mobile_token`;
CREATE TABLE `mobile_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `token` text NOT NULL COMMENT 'token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `token` (`token`(128)) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of mobile_token
-- ----------------------------
INSERT INTO `mobile_token` VALUES ('1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY2MTA5MzAwIDE3MjEyOTUwMTkifQ.zaU_EfFM1iWzmVsppDd1PWB5Wn8Ti21Ih7CI-VLcQFY', '1752831056', '1');
INSERT INTO `mobile_token` VALUES ('2', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjc3NDI3ODAwIDE3MjEyOTUwNTYifQ.mdRLnsBuEXMjeF0utpWpkJSScfWJ_jybqWFY2jmXL3k', '1752831062', '1');
INSERT INTO `mobile_token` VALUES ('3', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjI3NzI2NTAwIDE3MjEyOTUwNjIifQ.VFCNc6Kzj4RFSdavLOkzUZduqZ0nfhZoHmCNOXuVxh8', '1752831119', '1');
INSERT INTO `mobile_token` VALUES ('4', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjUyMjgwODAwIDE3MjEyOTUxMTkifQ.W6G867C2M_eEh1q_r5aYVCRTq2Jx4guUOW0Dw4AXTZo', '1752831147', '1');
INSERT INTO `mobile_token` VALUES ('5', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjA4MDczNTAwIDE3MjEyOTUxNDgifQ.x6ICzKUvj-ClqaFy4SFQaD5p1fHgpROoZWBbK8J8i0w', '1752831260', '1');
INSERT INTO `mobile_token` VALUES ('6', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjcyNTI0OTAwIDE3MjEyOTUyNjAifQ.o0zHk_YCy7Q3TY_Hcio5_MgAkntSeIIZND2WP_xt0_g', '1752831473', '1');
INSERT INTO `mobile_token` VALUES ('7', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjI1MDUzMDAwIDE3MjEyOTU0NzQifQ.7S7G3rVXETWorz_GYclIf4xnd9MZZe1bpYArm05FQ6k', '1752831474', '1');
INSERT INTO `mobile_token` VALUES ('8', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjU3MDc4MTAwIDE3MjEyOTU1NTAifQ.nLdajjpdrBexWZQB-CmMGfG4yv5Z3GFV6r-U_uASlVM', '1752831550', '1');
INSERT INTO `mobile_token` VALUES ('9', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjUzODc3NTAwIDE3MjEyOTU5NzQifQ.Hkpx2eCtWj30rBRi4vKVDhVjx8a29VRn66L43oBmkRw', '1752831974', '1');
INSERT INTO `mobile_token` VALUES ('10', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk4MDE2NTAwIDE3MjEyOTU5ODEifQ.oN0Uh4KhksW2fg9ZLnkYJRGc_xBzyQ8N-ng8JQjmN6U', '1752831981', '1');
INSERT INTO `mobile_token` VALUES ('11', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjE4NjE5ODAwIDE3MjEyOTYwMzAifQ.oxMZlEUzvN2gC6wtpIYMhMKBvLdC1pMASJhObPpURyQ', '1752834728', '1');
INSERT INTO `mobile_token` VALUES ('12', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjkzMzI1NzAwIDE3MjEyOTg3MjgifQ.u7XQnB9zVt9TG5IVn7yeWhuEGDhUIZMymOQJqQ9E7Gw', '1752834729', '1');
INSERT INTO `mobile_token` VALUES ('14', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjIwNzA4NjAwIDE3MjEzNTQ3OTkifQ.uCNHHviJJzX1UkYZSOjvFLMN4SKl8iNbhvCE57WgWPs', '1752891327', '1');
INSERT INTO `mobile_token` VALUES ('25', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjE0MDQ4OTAwIDE3MjEzNzU3MDEifQ.g3acVvKBpCr5UxInXjjKi7d1qfTU32C8C0zy2PLe3gA', '1752918757', '1');
INSERT INTO `mobile_token` VALUES ('26', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjIxNTkxNTAwIDE3MjEzNzY2NTkifQ.uNBGAO4lyZEL0-ARLMlvFzwZVunMjGBMHBQMEdyBz8M', '1752920285', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=868 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES ('1', '1', '1721269753', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('2', '1', '1721269753', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('3', '1', '1721269757', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('4', '1', '1721269779', '127.0.0.1', '/desktop/system.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('5', '1', '1721269804', '127.0.0.1', '/desktop/system.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('6', '1', '1721269818', '127.0.0.1', '/desktop/system.user.editpassword/save');
INSERT INTO `operation_log` VALUES ('7', '1', '1721269869', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('8', '1', '1721269869', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('9', '1', '1721269886', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('10', '1', '1721269888', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('11', '1', '1721269888', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('12', '1', '1721269890', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('13', '1', '1721269891', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('14', '1', '1721269891', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('15', '1', '1721269901', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('16', '1', '1721269904', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('17', '1', '1721269913', '127.0.0.1', '/desktop/system.desktop.permission.edit/init');
INSERT INTO `operation_log` VALUES ('18', '1', '1721269924', '127.0.0.1', '/desktop/system.desktop.permission.edit/save');
INSERT INTO `operation_log` VALUES ('19', '1', '1721269925', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('20', '1', '1721269931', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('21', '1', '1721269937', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('22', '1', '1721270022', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('23', '1', '1721270048', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('24', '1', '1721270052', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('25', '1', '1721270053', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('26', '1', '1721270055', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('27', '1', '1721270096', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('28', '1', '1721272151', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('29', '1', '1721272160', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('30', '1', '1721272163', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('31', '1', '1721272166', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('32', '1', '1721272170', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('33', '1', '1721272170', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('34', '1', '1721272172', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('35', '1', '1721272174', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('36', '1', '1721272230', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('37', '1', '1721272258', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('38', '1', '1721272265', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('39', '1', '1721273686', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('40', '1', '1721273695', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('41', '1', '1721273716', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('42', '1', '1721273731', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('43', '1', '1721273806', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('44', '1', '1721274195', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('45', '1', '1721274195', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('46', '1', '1721274200', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('47', '1', '1721274207', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('48', '1', '1721274216', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('49', '1', '1721274221', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('50', '1', '1721274304', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('51', '1', '1721274317', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('52', '1', '1721274330', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('53', '1', '1721274353', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('54', '1', '1721274365', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('55', '1', '1721274395', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('56', '1', '1721274414', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('57', '1', '1721274426', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('58', '1', '1721274427', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('59', '1', '1721274452', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('60', '1', '1721274474', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('61', '1', '1721274496', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('62', '1', '1721274533', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('63', '1', '1721274563', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('64', '1', '1721274592', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('65', '1', '1721274624', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('66', '1', '1721274634', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('67', '1', '1721274654', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('68', '1', '1721274678', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('69', '1', '1721274699', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('70', '1', '1721274805', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('71', '1', '1721274820', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('72', '1', '1721274827', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('73', '1', '1721274834', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('74', '1', '1721274846', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('75', '1', '1721274909', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('76', '1', '1721274931', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('77', '1', '1721274955', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('78', '1', '1721274964', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('79', '1', '1721274968', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('80', '1', '1721274981', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('81', '1', '1721275071', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('82', '1', '1721275124', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('83', '1', '1721275189', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('84', '1', '1721275201', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('85', '1', '1721275307', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('86', '1', '1721275335', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('87', '1', '1721275406', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('88', '1', '1721275508', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('89', '1', '1721275518', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('90', '1', '1721275559', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('91', '1', '1721275740', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('92', '1', '1721279946', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('93', '1', '1721279949', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('94', '1', '1721282083', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('95', '1', '1721282085', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('96', '1', '1721282372', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('97', '1', '1721282785', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('98', '1', '1721282889', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('99', '1', '1721282967', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('100', '1', '1721283273', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('101', '1', '1721283312', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('102', '1', '1721283317', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('103', '1', '1721283362', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('104', '1', '1721283362', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('105', '1', '1721283383', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('106', '1', '1721283384', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('107', '1', '1721283588', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('108', '1', '1721283594', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('109', '1', '1721283596', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('110', '1', '1721283597', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('111', '1', '1721283598', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('112', '1', '1721283599', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('113', '1', '1721283600', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('114', '1', '1721283603', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('115', '1', '1721283605', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('116', '1', '1721283607', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('117', '1', '1721283610', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('118', '1', '1721283612', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('119', '1', '1721283613', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('120', '1', '1721283615', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('121', '1', '1721283645', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('122', '1', '1721283652', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('123', '1', '1721283652', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('124', '1', '1721283711', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('125', '1', '1721283712', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('126', '1', '1721283826', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('127', '1', '1721283851', '127.0.0.1', '/desktop/system.user.edit/init');
INSERT INTO `operation_log` VALUES ('128', '1', '1721283854', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('129', '1', '1721283861', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('130', '1', '1721283876', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('131', '1', '1721283924', '127.0.0.1', '/desktop/system.user.edit/save');
INSERT INTO `operation_log` VALUES ('132', '1', '1721295056', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('133', '1', '1721295062', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('134', '1', '1721295119', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('135', '1', '1721295148', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('136', '1', '1721295201', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('137', '1', '1721295237', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('138', '1', '1721295250', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('139', '1', '1721295260', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('140', '1', '1721295474', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('141', '1', '1721296030', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('142', '1', '1721296038', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('143', '1', '1721296040', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('144', '1', '1721296059', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('145', '1', '1721296092', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('146', '1', '1721296100', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('147', '1', '1721296122', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('148', '1', '1721296126', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('149', '1', '1721296130', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('150', '1', '1721296144', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('151', '1', '1721296145', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('152', '1', '1721296170', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('153', '1', '1721296181', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('154', '1', '1721296184', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('155', '1', '1721296186', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('156', '1', '1721296187', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('157', '1', '1721296189', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('158', '1', '1721296220', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('159', '1', '1721296228', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('160', '1', '1721296258', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('161', '1', '1721296276', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('162', '1', '1721296290', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('163', '1', '1721296294', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('164', '1', '1721296299', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('165', '1', '1721296327', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('166', '1', '1721296331', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('167', '1', '1721296405', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('168', '1', '1721296410', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('169', '1', '1721296414', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('170', '1', '1721296424', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('171', '1', '1721296430', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('172', '1', '1721296433', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('173', '1', '1721296442', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('174', '1', '1721296454', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('175', '1', '1721296456', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('176', '1', '1721296473', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('177', '1', '1721296476', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('178', '1', '1721296604', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('179', '1', '1721296605', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('180', '1', '1721296606', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('181', '1', '1721296610', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('182', '1', '1721296612', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('183', '1', '1721296613', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('184', '1', '1721296618', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('185', '1', '1721296633', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('186', '1', '1721296636', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('187', '1', '1721296663', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('188', '1', '1721296680', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('189', '1', '1721296684', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('190', '1', '1721296691', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('191', '1', '1721296692', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('192', '1', '1721296701', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('193', '1', '1721296752', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('194', '1', '1721296771', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('195', '1', '1721296775', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('196', '1', '1721296802', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('197', '1', '1721296818', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('198', '1', '1721296821', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('199', '1', '1721296823', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('200', '1', '1721296840', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('201', '1', '1721296843', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('202', '1', '1721296847', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('203', '1', '1721296853', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('204', '1', '1721296861', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('205', '1', '1721296863', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('206', '1', '1721296871', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('207', '1', '1721296874', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('208', '1', '1721296900', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('209', '1', '1721296901', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('210', '1', '1721296906', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('211', '1', '1721296911', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('212', '1', '1721296947', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('213', '1', '1721296954', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('214', '1', '1721296955', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('215', '1', '1721296991', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('216', '1', '1721296993', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('217', '1', '1721296994', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('218', '1', '1721297003', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('219', '1', '1721297014', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('220', '1', '1721297015', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('221', '1', '1721297022', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('222', '1', '1721297029', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('223', '1', '1721297198', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('224', '1', '1721297279', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('225', '1', '1721297297', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('226', '1', '1721297299', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('227', '1', '1721297303', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('228', '1', '1721297305', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('229', '1', '1721297306', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('230', '1', '1721297308', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('231', '1', '1721297407', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('232', '1', '1721297586', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('233', '1', '1721297604', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('234', '1', '1721297612', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('235', '1', '1721297624', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('236', '1', '1721297637', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('237', '1', '1721297640', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('238', '1', '1721297643', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('239', '1', '1721297652', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('240', '1', '1721297656', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('241', '1', '1721297673', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('242', '1', '1721297685', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('243', '1', '1721297689', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('244', '1', '1721297699', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('245', '1', '1721297713', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('246', '1', '1721297738', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('247', '1', '1721297774', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('248', '1', '1721297779', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('249', '1', '1721297785', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('250', '1', '1721297790', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('251', '1', '1721297797', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('252', '1', '1721297801', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('253', '1', '1721297894', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('254', '1', '1721297900', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('255', '1', '1721297905', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('256', '1', '1721297913', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('257', '1', '1721297962', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('258', '1', '1721297976', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('259', '1', '1721297977', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('260', '1', '1721297989', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('261', '1', '1721297992', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('262', '1', '1721298028', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('263', '1', '1721298032', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('264', '1', '1721298061', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('265', '1', '1721298083', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('266', '1', '1721298089', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('267', '1', '1721298110', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('268', '1', '1721298118', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('269', '1', '1721298131', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('270', '1', '1721298133', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('271', '1', '1721298148', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('272', '1', '1721298168', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('273', '1', '1721298169', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('274', '1', '1721298185', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('275', '1', '1721298186', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('276', '1', '1721298201', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('277', '1', '1721298206', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('278', '1', '1721298208', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('279', '1', '1721298395', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('280', '1', '1721298403', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('281', '1', '1721298408', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('282', '1', '1721298420', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('283', '1', '1721298421', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('284', '1', '1721298434', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('285', '1', '1721298442', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('286', '1', '1721298466', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('287', '1', '1721298472', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('288', '1', '1721298474', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('289', '1', '1721298475', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('290', '1', '1721298484', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('291', '1', '1721298485', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('292', '1', '1721298487', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('293', '1', '1721298493', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('294', '1', '1721298504', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('295', '1', '1721298506', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('296', '1', '1721298509', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('297', '1', '1721298512', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('298', '1', '1721298522', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('299', '1', '1721298576', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('300', '1', '1721298578', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('301', '1', '1721298583', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('302', '1', '1721298602', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('303', '1', '1721298608', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('304', '1', '1721298613', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('305', '1', '1721298614', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('306', '1', '1721298616', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('307', '1', '1721298620', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('308', '1', '1721298623', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('309', '1', '1721298628', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('310', '1', '1721298631', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('311', '1', '1721298718', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('312', '1', '1721298720', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('313', '1', '1721298728', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('314', '1', '1721298729', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('315', '1', '1721352577', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('316', '1', '1721352670', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('317', '1', '1721352717', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('318', '1', '1721352718', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('319', '1', '1721352721', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('320', '1', '1721352724', '127.0.0.1', '/desktop/system.user.detail/init');
INSERT INTO `operation_log` VALUES ('321', '1', '1721352898', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('322', '1', '1721352899', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('323', '1', '1721352904', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('324', '1', '1721352905', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('325', '1', '1721352906', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('326', '1', '1721352910', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('327', '1', '1721352913', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('328', '1', '1721352913', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('329', '1', '1721352915', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('330', '1', '1721352917', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('331', '1', '1721352920', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('332', '1', '1721352922', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('333', '1', '1721352927', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('334', '1', '1721353416', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('335', '1', '1721353905', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('336', '1', '1721354323', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('337', '1', '1721354384', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('338', '1', '1721354577', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('339', '1', '1721354799', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('340', '1', '1721354810', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('341', '1', '1721354865', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('342', '1', '1721354951', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('343', '1', '1721355079', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('344', '1', '1721355079', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('345', '1', '1721355327', '127.0.0.1', '/mobile/login/login');
INSERT INTO `operation_log` VALUES ('346', '1', '1721355327', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('347', '1', '1721355362', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('348', '1', '1721355741', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('349', '1', '1721355777', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('350', '1', '1721355777', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('351', '1', '1721355780', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('352', '1', '1721355780', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('353', '1', '1721355816', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('354', '1', '1721355817', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('355', '1', '1721355863', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('356', '1', '1721355863', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('357', '1', '1721355912', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('358', '1', '1721355913', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('359', '1', '1721355913', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('360', '1', '1721355925', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('361', '1', '1721355925', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('362', '1', '1721355976', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('363', '1', '1721355976', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('364', '1', '1721356040', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('365', '1', '1721356040', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('366', '1', '1721356049', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('367', '1', '1721356049', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('368', '1', '1721356111', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('369', '1', '1721356111', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('370', '1', '1721356116', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('371', '1', '1721356116', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('372', '1', '1721356250', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('373', '1', '1721356251', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('374', '1', '1721356251', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('375', '1', '1721356251', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('376', '1', '1721356256', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('377', '1', '1721356256', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('378', '1', '1721356260', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('379', '1', '1721356260', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('380', '1', '1721356261', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('381', '1', '1721356262', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('382', '1', '1721356266', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('383', '1', '1721356266', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('384', '1', '1721356267', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('385', '1', '1721356267', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('386', '1', '1721356280', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('387', '1', '1721356280', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('388', '1', '1721356280', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('389', '1', '1721356280', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('390', '1', '1721356288', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('391', '1', '1721356288', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('392', '1', '1721356288', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('393', '1', '1721356289', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('394', '1', '1721356293', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('395', '1', '1721356293', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('396', '1', '1721356293', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('397', '1', '1721356294', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('398', '1', '1721356307', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('399', '1', '1721356307', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('400', '1', '1721356308', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('401', '1', '1721356308', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('402', '1', '1721356315', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('403', '1', '1721356315', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('404', '1', '1721356315', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('405', '1', '1721356316', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('406', '1', '1721356320', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('407', '1', '1721356320', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('408', '1', '1721356321', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('409', '1', '1721356321', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('410', '1', '1721356328', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('411', '1', '1721356328', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('412', '1', '1721356329', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('413', '1', '1721356329', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('414', '1', '1721356709', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('415', '1', '1721356710', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('416', '1', '1721356714', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('417', '1', '1721356717', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('418', '1', '1721356791', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('419', '1', '1721356792', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('420', '1', '1721356841', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('421', '1', '1721356842', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('422', '1', '1721356843', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('423', '1', '1721357011', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('424', '1', '1721357195', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('425', '1', '1721357196', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('426', '1', '1721357299', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('427', '1', '1721357299', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('428', '1', '1721357302', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('429', '1', '1721357305', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('430', '1', '1721357306', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('431', '1', '1721357410', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('432', '1', '1721357415', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('433', '1', '1721357421', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('434', '1', '1721358500', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('435', '1', '1721359840', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('436', '1', '1721359843', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('437', '1', '1721359912', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('438', '1', '1721359914', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('439', '1', '1721359984', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('440', '1', '1721359984', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('441', '1', '1721360021', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('442', '1', '1721360049', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('443', '1', '1721360066', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('444', '1', '1721360089', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('445', '1', '1721360089', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('446', '1', '1721360170', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('447', '1', '1721360235', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('448', '1', '1721360261', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('449', '1', '1721360261', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('450', '1', '1721360263', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('451', '1', '1721360285', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('452', '1', '1721360286', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('453', '1', '1721360298', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('454', '1', '1721360301', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('455', '1', '1721360331', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('456', '1', '1721360350', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('457', '1', '1721360354', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('458', '1', '1721360358', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('459', '1', '1721360358', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('460', '1', '1721360360', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('461', '1', '1721360369', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('462', '1', '1721360399', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('463', '1', '1721360400', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('464', '1', '1721360434', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('465', '1', '1721360434', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('466', '1', '1721360438', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('467', '1', '1721360457', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('468', '1', '1721360457', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('469', '1', '1721360457', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('470', '1', '1721360457', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('471', '1', '1721360458', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('472', '1', '1721360458', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('473', '1', '1721360466', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('474', '1', '1721360467', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('475', '1', '1721360467', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('476', '1', '1721360467', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('477', '1', '1721360474', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('478', '1', '1721360476', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('479', '1', '1721360479', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('480', '1', '1721360517', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('481', '1', '1721360522', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('482', '1', '1721360523', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('483', '1', '1721360542', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('484', '1', '1721360564', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('485', '1', '1721360564', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('486', '1', '1721360683', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('487', '1', '1721360686', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('488', '1', '1721360709', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('489', '1', '1721360710', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('490', '1', '1721360712', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('491', '1', '1721360733', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('492', '1', '1721366110', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('493', '1', '1721366110', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('494', '1', '1721366114', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('495', '1', '1721366118', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('496', '1', '1721366120', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('497', '1', '1721366120', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('498', '1', '1721366562', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('499', '1', '1721366563', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('500', '1', '1721366615', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('501', '1', '1721366616', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('502', '1', '1721366684', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('503', '1', '1721366685', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('504', '1', '1721366893', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('505', '1', '1721366893', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('506', '1', '1721367212', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('507', '1', '1721367216', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('508', '1', '1721367273', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('509', '1', '1721367275', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('510', '1', '1721367281', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('511', '1', '1721368067', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('512', '1', '1721368067', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('513', '1', '1721368188', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('514', '1', '1721368189', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('515', '1', '1721368291', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('516', '1', '1721368291', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('517', '1', '1721368403', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('518', '1', '1721368542', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('519', '1', '1721368543', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('520', '1', '1721368569', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('521', '1', '1721368577', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('522', '1', '1721368581', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('523', '1', '1721368586', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('524', '1', '1721368586', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('525', '1', '1721368604', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('526', '1', '1721369219', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('527', '1', '1721369220', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('528', '1', '1721369221', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('529', '1', '1721369310', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('530', '1', '1721369341', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('531', '1', '1721369342', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('532', '1', '1721369400', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('533', '1', '1721369458', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('534', '1', '1721369476', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('535', '1', '1721369485', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('536', '1', '1721369503', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('537', '1', '1721369554', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('538', '1', '1721369636', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('539', '1', '1721369653', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('540', '1', '1721369661', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('541', '1', '1721369711', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('542', '1', '1721369738', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('543', '1', '1721369849', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('544', '1', '1721369895', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('545', '1', '1721369897', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('546', '1', '1721369919', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('547', '1', '1721369925', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('548', '1', '1721369941', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('549', '1', '1721369982', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('550', '1', '1721369998', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('551', '1', '1721370008', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('552', '1', '1721370022', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('553', '1', '1721370072', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('554', '1', '1721370210', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('555', '1', '1721370217', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('556', '1', '1721370292', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('557', '1', '1721370292', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('558', '1', '1721370328', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('559', '1', '1721370353', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('560', '1', '1721370371', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('561', '1', '1721370391', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('562', '1', '1721370406', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('563', '1', '1721370493', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('564', '1', '1721370496', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('565', '1', '1721370501', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('566', '1', '1721370713', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('567', '1', '1721370714', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('568', '1', '1721370719', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('569', '1', '1721370724', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('570', '1', '1721370725', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('571', '1', '1721370826', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('572', '1', '1721370827', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('573', '1', '1721370932', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('574', '1', '1721370932', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('575', '1', '1721370949', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('576', '1', '1721370950', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('577', '1', '1721370950', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('578', '1', '1721370951', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('579', '1', '1721370960', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('580', '1', '1721370960', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('581', '1', '1721371191', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('582', '1', '1721371192', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('583', '1', '1721371211', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('584', '1', '1721371211', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('585', '1', '1721371237', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('586', '1', '1721371237', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('587', '1', '1721371253', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('588', '1', '1721371254', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('589', '1', '1721371265', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('590', '1', '1721371265', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('591', '1', '1721371278', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('592', '1', '1721371278', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('593', '1', '1721371338', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('594', '1', '1721371338', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('595', '1', '1721371352', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('596', '1', '1721371352', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('597', '1', '1721371560', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('598', '1', '1721371561', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('599', '1', '1721371668', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('600', '1', '1721371669', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('601', '1', '1721371677', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('602', '1', '1721371678', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('603', '1', '1721371832', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('604', '1', '1721371832', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('605', '1', '1721371840', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('606', '1', '1721371840', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('607', '1', '1721372042', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('608', '1', '1721372243', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('609', '1', '1721372243', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('610', '1', '1721372243', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('611', '1', '1721372263', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('612', '1', '1721372264', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('613', '1', '1721372289', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('614', '1', '1721372289', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('615', '1', '1721372293', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('616', '1', '1721372293', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('617', '1', '1721372420', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('618', '1', '1721372421', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('619', '1', '1721372492', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('620', '1', '1721372493', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('621', '1', '1721372495', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('622', '1', '1721372496', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('623', '1', '1721372503', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('624', '1', '1721372503', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('625', '1', '1721372561', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('626', '1', '1721372562', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('627', '1', '1721372610', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('628', '1', '1721372610', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('629', '1', '1721373420', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('630', '1', '1721373421', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('631', '1', '1721373442', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('632', '1', '1721373443', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('633', '1', '1721373535', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('634', '1', '1721373537', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('635', '1', '1721373921', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('636', '1', '1721373921', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('637', '1', '1721373926', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('638', '1', '1721374053', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('639', '1', '1721374054', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('640', '1', '1721374058', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('641', '1', '1721374059', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('642', '1', '1721374074', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('643', '1', '1721374074', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('644', '1', '1721374093', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('645', '1', '1721374094', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('646', '1', '1721374096', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('647', '1', '1721374111', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('648', '1', '1721374111', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('649', '1', '1721374129', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('650', '1', '1721374131', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('651', '1', '1721374170', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('652', '1', '1721374170', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('653', '1', '1721374211', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('654', '1', '1721374211', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('655', '1', '1721374223', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('656', '1', '1721374223', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('657', '1', '1721374225', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('658', '1', '1721374250', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('659', '1', '1721374251', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('660', '1', '1721374383', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('661', '1', '1721374404', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('662', '1', '1721374405', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('663', '1', '1721374409', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('664', '1', '1721374409', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('665', '1', '1721374414', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('666', '1', '1721374440', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('667', '1', '1721374440', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('668', '1', '1721374446', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('669', '1', '1721374449', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('670', '1', '1721374467', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('671', '1', '1721374468', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('672', '1', '1721374763', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('673', '1', '1721374763', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('674', '1', '1721374800', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('675', '1', '1721374801', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('676', '1', '1721374803', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('677', '1', '1721374808', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('678', '1', '1721374809', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('679', '1', '1721374810', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('680', '1', '1721374890', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('681', '1', '1721374890', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('682', '1', '1721374931', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('683', '1', '1721374991', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('684', '1', '1721374992', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('685', '1', '1721375044', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('686', '1', '1721375045', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('687', '1', '1721375072', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('688', '1', '1721375073', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('689', '1', '1721375145', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('690', '1', '1721375146', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('691', '1', '1721375175', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('692', '1', '1721375176', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('693', '1', '1721375283', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('694', '1', '1721375366', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('695', '1', '1721375369', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('696', '1', '1721375425', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('697', '1', '1721375428', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('698', '1', '1721375444', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('699', '1', '1721375445', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('700', '1', '1721375482', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('701', '1', '1721375486', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('702', '1', '1721375487', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('703', '1', '1721375489', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('704', '1', '1721375701', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('705', '1', '1721375702', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('706', '1', '1721375704', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('707', '1', '1721375734', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('708', '1', '1721375735', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('709', '1', '1721375743', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('710', '1', '1721375744', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('711', '1', '1721375758', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('712', '1', '1721375765', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('713', '1', '1721375765', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('714', '1', '1721375772', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('715', '1', '1721375773', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('716', '1', '1721375774', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('717', '1', '1721375884', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('718', '1', '1721375884', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('719', '1', '1721376063', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('720', '1', '1721376064', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('721', '1', '1721376073', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('722', '1', '1721376073', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('723', '1', '1721376117', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('724', '1', '1721376118', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('725', '1', '1721376120', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('726', '1', '1721376120', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('727', '1', '1721376196', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('728', '1', '1721376196', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('729', '1', '1721376216', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('730', '1', '1721376216', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('731', '1', '1721376276', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('732', '1', '1721376277', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('733', '1', '1721376397', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('734', '1', '1721376398', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('735', '1', '1721376428', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('736', '1', '1721376429', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('737', '1', '1721376430', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('738', '1', '1721376473', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('739', '1', '1721376474', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('740', '1', '1721376491', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('741', '1', '1721376491', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('742', '1', '1721376492', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('743', '1', '1721376562', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('744', '1', '1721376563', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('745', '1', '1721376565', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('746', '1', '1721376601', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('747', '1', '1721376601', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('748', '1', '1721376613', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('749', '1', '1721376613', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('750', '1', '1721376620', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('751', '1', '1721376656', '127.0.0.1', '/mobile/my.user.detail/logout');
INSERT INTO `operation_log` VALUES ('752', '1', '1721376659', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('753', '1', '1721376660', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('754', '1', '1721380417', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('755', '1', '1721380548', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('756', '1', '1721380586', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('757', '1', '1721380760', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('758', '1', '1721380769', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('759', '1', '1721380792', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('760', '1', '1721381082', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('761', '1', '1721381212', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('762', '1', '1721381217', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('763', '1', '1721381631', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('764', '1', '1721381653', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('765', '1', '1721381678', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('766', '1', '1721381764', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('767', '1', '1721381831', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('768', '1', '1721381967', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('769', '1', '1721382032', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('770', '1', '1721382061', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('771', '1', '1721382082', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('772', '1', '1721382137', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('773', '1', '1721382158', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('774', '1', '1721382213', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('775', '1', '1721382291', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('776', '1', '1721382622', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('777', '1', '1721382700', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('778', '1', '1721382701', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('779', '1', '1721382721', '127.0.0.1', '/mobile/frame/getpermissions');
INSERT INTO `operation_log` VALUES ('780', '1', '1721382721', '127.0.0.1', '/mobile/index/init');
INSERT INTO `operation_log` VALUES ('781', '1', '1721382724', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('782', '1', '1721382734', '127.0.0.1', '/mobile/my.user.editavatar/save');
INSERT INTO `operation_log` VALUES ('783', '1', '1721382735', '127.0.0.1', '/mobile/my.user.detail/init');
INSERT INTO `operation_log` VALUES ('784', '1', '1721382757', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('785', '1', '1721382950', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('786', '1', '1721383478', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('787', '1', '1721383553', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('788', '1', '1721384127', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('789', '1', '1721384196', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('790', '1', '1721384269', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('791', '1', '1721384285', '127.0.0.1', '/mobile/uploadfile/upload');
INSERT INTO `operation_log` VALUES ('792', '1', '1722840617', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('793', '1', '1722840622', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('794', '1', '1722840624', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('795', '1', '1722840655', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('796', '1', '1722840662', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('797', '1', '1722840712', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('798', '1', '1722841055', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('799', '1', '1722841061', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('800', '1', '1722841069', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('801', '1', '1722841078', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('802', '1', '1722841083', '127.0.0.1', '/desktop/system.dictionary.edit/init');
INSERT INTO `operation_log` VALUES ('803', '1', '1722841092', '127.0.0.1', '/desktop/system.dictionary.edit/save');
INSERT INTO `operation_log` VALUES ('804', '1', '1722841092', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('805', '1', '1722841095', '127.0.0.1', '/desktop/system.dictionary.edit/init');
INSERT INTO `operation_log` VALUES ('806', '1', '1722841099', '127.0.0.1', '/desktop/system.dictionary.edit/save');
INSERT INTO `operation_log` VALUES ('807', '1', '1722841100', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('808', '1', '1722841151', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('809', '1', '1722845544', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('810', '1', '1722845546', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('811', '1', '1722845549', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('812', '1', '1722845551', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('813', '1', '1722845551', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('814', '1', '1722845552', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('815', '1', '1722845553', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('816', '1', '1722845558', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('817', '1', '1722845559', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('818', '1', '1722845560', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('819', '1', '1722845562', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('820', '1', '1722845567', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('821', '1', '1722845571', '127.0.0.1', '/desktop/system.desktop.menu.add/init');
INSERT INTO `operation_log` VALUES ('822', '1', '1722845575', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('823', '1', '1722845577', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('824', '1', '1722845620', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('825', '1', '1722845663', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('826', '1', '1722845683', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('827', '1', '1722845684', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('828', '1', '1722845686', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('829', '1', '1722845687', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('830', '1', '1722845690', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('831', '1', '1722845692', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('832', '1', '1722845693', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('833', '1', '1722845694', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('834', '1', '1722845695', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('835', '1', '1722845696', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('836', '1', '1722845699', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('837', '1', '1722845734', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('838', '1', '1722845737', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('839', '1', '1722845739', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('840', '1', '1722845742', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('841', '1', '1722845744', '127.0.0.1', '/desktop/system.operation_log.index/getoperationlogs');
INSERT INTO `operation_log` VALUES ('842', '1', '1722845746', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('843', '1', '1722845760', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('844', '1', '1722845769', '127.0.0.1', '/desktop/system.desktop.route.add/init');
INSERT INTO `operation_log` VALUES ('845', '1', '1722845784', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('846', '1', '1722845788', '127.0.0.1', '/desktop/system.dictionary.edit/init');
INSERT INTO `operation_log` VALUES ('847', '1', '1722845794', '127.0.0.1', '/desktop/system.dictionary.edit/save');
INSERT INTO `operation_log` VALUES ('848', '1', '1722845795', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('849', '1', '1722845798', '127.0.0.1', '/desktop/system.dictionary.edit/init');
INSERT INTO `operation_log` VALUES ('850', '1', '1722845804', '127.0.0.1', '/desktop/system.dictionary.edit/save');
INSERT INTO `operation_log` VALUES ('851', '1', '1722845805', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('852', '1', '1722845850', '127.0.0.1', '/desktop/statistic.trend.index/init');
INSERT INTO `operation_log` VALUES ('853', '1', '1722845853', '127.0.0.1', '/desktop/statistic.department.index/init');
INSERT INTO `operation_log` VALUES ('854', '1', '1722845857', '127.0.0.1', '/desktop/system.config.index/init');
INSERT INTO `operation_log` VALUES ('855', '1', '1722845859', '127.0.0.1', '/desktop/system.user.index/init');
INSERT INTO `operation_log` VALUES ('856', '1', '1722845860', '127.0.0.1', '/desktop/system.user.index/getusers');
INSERT INTO `operation_log` VALUES ('857', '1', '1722845861', '127.0.0.1', '/desktop/system.department.index/getdepartments');
INSERT INTO `operation_log` VALUES ('858', '1', '1722845862', '127.0.0.1', '/desktop/system.role.index/getroles');
INSERT INTO `operation_log` VALUES ('859', '1', '1722845866', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('860', '1', '1722845875', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('861', '1', '1722845879', '127.0.0.1', '/desktop/system.mobile.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('862', '1', '1722845882', '127.0.0.1', '/desktop/system.dictionary.index/getdictionarys');
INSERT INTO `operation_log` VALUES ('863', '1', '1722845883', '127.0.0.1', '/desktop/system.login_log.index/getloginlogs');
INSERT INTO `operation_log` VALUES ('864', '1', '1722845893', '127.0.0.1', '/desktop/system.desktop.menu.index/getmenus');
INSERT INTO `operation_log` VALUES ('865', '1', '1722845905', '127.0.0.1', '/desktop/system.desktop.permission.index/getpermissions');
INSERT INTO `operation_log` VALUES ('866', '1', '1722845909', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');
INSERT INTO `operation_log` VALUES ('867', '1', '1722845990', '127.0.0.1', '/desktop/system.desktop.route.index/getroutes');

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
INSERT INTO `user` VALUES ('1', '1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '张三', '15122222222', 'avatar/2024/07/19/f7edb03c2aa8234f660eb24664aa623e.png', '1684989244', '1716183018', '1722840439', '127.0.0.1');
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
