/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50744
Source Host           : localhost:3306
Source Database       : sun_admin

Target Server Type    : MYSQL
Target Server Version : 50744
File Encoding         : 65001

Date: 2025-05-14 15:01:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for api_session
-- ----------------------------
DROP TABLE IF EXISTS `api_session`;
CREATE TABLE `api_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `token` text NOT NULL COMMENT 'token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `token` (`token`(128)) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='会话';

-- ----------------------------
-- Records of api_session
-- ----------------------------
INSERT INTO `api_session` VALUES ('1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjM1MTk1MjAwIDE3MjExMDQyNzIifQ.m4TTbTUURTJbpvmWg3OBjFF54TP9FeV3T1BqV4UUL3U', '1752640335', '1');
INSERT INTO `api_session` VALUES ('2', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk2OTAzMjAwIDE3MjExMDQzNTcifQ.8KAvosRvudDjGb7GGAWvs92h_N3VNGR00HJUo6_LlHs', '1752640358', '1');
INSERT INTO `api_session` VALUES ('3', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjU2NTg1N30.m5OZdtkPE7DKFkjXoTiuf0G0CXhSi-nd8mNLeLKTdas', '1768101857', '1');
INSERT INTO `api_session` VALUES ('4', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJ0aW1lIjoxNzM2NTY2MDQ0fQ.IVj0B-zY2wZuoVw31lubG840owD2PQ5gQJ-LsPJOdGQ', '1768102044', '1');
INSERT INTO `api_session` VALUES ('5', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJ0aW1lIjoxNzM2NTY2MDQ4fQ.D319Tml4xlM_ILDia-5WaNXqe1YbQOPuzjteXRAvKTw', '1768102048', '1');

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `denied_ip_string` text NOT NULL COMMENT '拒绝登录ip串',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统配置';

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('1', '111.111.111.111');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级部门id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '分类',
  `name` varchar(67) NOT NULL DEFAULT '' COMMENT '部门名称',
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
  `name` varchar(67) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '菜单网址',
  `icon` varchar(31) NOT NULL DEFAULT '' COMMENT '菜单图标',
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
INSERT INTO `desktop_menu` VALUES ('17', '16', '订单趋势统计', '/statistic/order-trend', 'Share', '1', '1');
INSERT INTO `desktop_menu` VALUES ('19', '0', '外部链接', 'https://www.baidu.com', 'Search', '9', '803');

-- ----------------------------
-- Table structure for desktop_permission
-- ----------------------------
DROP TABLE IF EXISTS `desktop_permission`;
CREATE TABLE `desktop_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `permission_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级权限id',
  `name` varchar(31) NOT NULL DEFAULT '' COMMENT '权限名称',
  `key` varchar(127) DEFAULT '' COMMENT '权限key',
  `api_string` text COMMENT '接口地址串',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COMMENT='权限';

-- ----------------------------
-- Records of desktop_permission
-- ----------------------------
INSERT INTO `desktop_permission` VALUES ('1', '0', '系统管理', 'system', '', '99');
INSERT INTO `desktop_permission` VALUES ('2', '1', '用户管理', 'system_user', 'desktop/system.user.Index/init\ndesktop/system.user.Index/getUserPaginate\ndesktop/system.user.Detail/init', '3');
INSERT INTO `desktop_permission` VALUES ('3', '2', '添加用户', 'system_user_add', 'desktop/system.user.Add/init\ndesktop/system.user.Add/save', '3');
INSERT INTO `desktop_permission` VALUES ('4', '2', '修改用户', 'system_user_edit', 'desktop/system.user.Edit/init\ndesktop/system.user.Edit/save', '5');
INSERT INTO `desktop_permission` VALUES ('5', '2', '修改密码', 'system_user_edit_password', 'desktop/system.user.EditPassword/save', '7');
INSERT INTO `desktop_permission` VALUES ('6', '2', '修改状态', 'system_user_edit_status', 'desktop/system.user.Index/editStatus', '9');
INSERT INTO `desktop_permission` VALUES ('7', '2', '踢下线', 'system_user_offline', 'desktop/system.user.Index/offline', '11');
INSERT INTO `desktop_permission` VALUES ('8', '1', '系统设置', 'system_config', 'desktop/system.config.Index/init\ndesktop/system.config.Index/save', '1');
INSERT INTO `desktop_permission` VALUES ('9', '1', '部门管理', 'system_department', 'desktop/system.department.Index/getTreeDepartment', '5');
INSERT INTO `desktop_permission` VALUES ('10', '1', '角色管理', 'system_role', 'desktop/system.role.Index/init\ndesktop/system.role.Index/getRolePaginate', '7');
INSERT INTO `desktop_permission` VALUES ('11', '1', '桌面端', 'system_desktop', '', '9');
INSERT INTO `desktop_permission` VALUES ('12', '11', '路由管理', 'system_desktop_route', 'desktop/system.desktop.route.Index/init\ndesktop/system.desktop.route.Index/getRoutes', '5');
INSERT INTO `desktop_permission` VALUES ('13', '11', '菜单管理', 'system_desktop_menu', 'desktop/system.desktop.menu.Index/init\ndesktop/system.desktop.menu.Index/getTreeMenu', '1');
INSERT INTO `desktop_permission` VALUES ('14', '11', '权限管理', 'system_desktop_permission', 'desktop/system.desktop.permission.Index/init\ndesktop/system.desktop.permission.Index/getTreePermission', '3');
INSERT INTO `desktop_permission` VALUES ('15', '1', '移动端', 'system_mobile', '', '11');
INSERT INTO `desktop_permission` VALUES ('16', '15', '权限管理', 'system_mobile_permission', 'desktop/system.mobile.permission.Index/getTreePermission', '1');
INSERT INTO `desktop_permission` VALUES ('17', '1', '字典管理', 'system_dictionary', 'desktop/system.dictionary.Index/init\ndesktop/system.dictionary.Index/getDictionaryPaginate', '13');
INSERT INTO `desktop_permission` VALUES ('18', '1', '登录日志', 'system_login_log', 'desktop/system.login_log.Index/getLoginLogPaginate', '15');
INSERT INTO `desktop_permission` VALUES ('19', '1', '操作日志', 'system_operation_log', 'desktop/system.operation_log.Index/getOperationLogPaginate', '17');
INSERT INTO `desktop_permission` VALUES ('20', '9', '添加', 'system_department_add', 'desktop/system.department.Add/init\ndesktop/system.department.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('21', '9', '修改', 'system_department_edit', 'desktop/system.department.Edit/init\ndesktop/system.department.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('22', '9', '删除', 'system_department_delete', 'desktop/system.department.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('23', '12', '添加', 'system_desktop_route_add', 'desktop/system.desktop.route.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('24', '12', '修改', 'system_desktop_route_edit', 'desktop/system.desktop.route.Edit/init\ndesktop/system.desktop.route.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('25', '12', '删除', 'system_desktop_route_delete', 'desktop/system.desktop.route.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('26', '13', '添加', 'system_desktop_menu_add', 'desktop/system.desktop.menu.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('27', '13', '修改', 'system_desktop_menu_edit', 'desktop/system.desktop.menu.Edit/init\ndesktop/system.desktop.menu.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('28', '13', '删除', 'system_desktop_menu_delete', 'desktop/system.desktop.menu.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('29', '14', '添加', 'system_desktop_permission_add', 'desktop/system.desktop.permission.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('30', '14', '修改', 'system_desktop_permission_edit', 'desktop/system.desktop.permission.Edit/init\ndesktop/system.desktop.permission.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('31', '14', '删除', 'system_desktop_permission_delete', 'desktop/system.desktop.permission.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('32', '16', '添加', 'system_mobile_permission_add', 'desktop/system.mobile.permission.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('33', '16', '修改', 'system_mobile_permission_edit', 'desktop/system.mobile.permission.Edit/init\ndesktop/system.mobile.permission.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('34', '16', '删除', 'system_mobile_permission_delete', 'desktop/system.mobile.permission.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('35', '17', '添加', 'system_dictionary_add', 'desktop/system.dictionary.Add/init\ndesktop/system.dictionary.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('36', '17', '修改', 'system_dictionary_edit', 'desktop/system.dictionary.Edit/init\ndesktop/system.dictionary.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('37', '17', '删除', 'system_dictionary_delete', 'desktop/system.dictionary.Index/delete', '9');
INSERT INTO `desktop_permission` VALUES ('38', '0', '统计分析', 'statistic', '', '81');
INSERT INTO `desktop_permission` VALUES ('40', '38', '订单趋势统计', 'statistic_order_trend', 'desktop/statistic.OrderTrend/init\ndesktop/statistic.OrderTrend/exp', '1');
INSERT INTO `desktop_permission` VALUES ('41', '0', '系统首页', 'index', '', '1');
INSERT INTO `desktop_permission` VALUES ('42', '10', '添加', 'system_role_add', 'desktop/system.role.Add/init\ndesktop/system.role.Add/save', '1');
INSERT INTO `desktop_permission` VALUES ('43', '10', '修改', 'system_role_edit', 'desktop/system.role.Edit/init\ndesktop/system.role.Edit/save', '3');
INSERT INTO `desktop_permission` VALUES ('44', '10', '删除', 'system_role_delete', 'desktop/system.role.Index/delete', '9');

-- ----------------------------
-- Table structure for desktop_route
-- ----------------------------
DROP TABLE IF EXISTS `desktop_route`;
CREATE TABLE `desktop_route` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '路由名称',
  `key` varchar(127) DEFAULT '' COMMENT '路由标识',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路由路径',
  `component_path` varchar(255) NOT NULL DEFAULT '' COMMENT '组件路径',
  `layout` varchar(31) NOT NULL DEFAULT '' COMMENT '布局容器',
  `keep_alive` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '路由保活',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='路由';

-- ----------------------------
-- Records of desktop_route
-- ----------------------------
INSERT INTO `desktop_route` VALUES ('1', '用户管理', 'system_user', '/system/user', 'system/user/Index.vue', 'main', '0', '903');
INSERT INTO `desktop_route` VALUES ('2', '用户详情', 'system_user_detail', '/system/user/detail-:id', 'system/user/Detail.vue', 'blank', '0', '905');
INSERT INTO `desktop_route` VALUES ('3', '部门管理', 'system_department', '/system/department', 'system/department/Index.vue', 'main', '0', '907');
INSERT INTO `desktop_route` VALUES ('4', '角色管理', 'system_role', '/system/role', 'system/role/Index.vue', 'main', '0', '909');
INSERT INTO `desktop_route` VALUES ('5', '菜单管理', 'system_desktop_menu', '/system/desktop/menu', 'system/desktop/menu/Index.vue', 'main', '0', '911');
INSERT INTO `desktop_route` VALUES ('6', '路由管理', 'system_desktop_route', '/system/desktop/route', 'system/desktop/route/Index.vue', 'main', '0', '913');
INSERT INTO `desktop_route` VALUES ('7', '权限管理', 'system_desktop_permission', '/system/desktop/permission', 'system/desktop/permission/Index.vue', 'main', '0', '915');
INSERT INTO `desktop_route` VALUES ('8', '字典管理', 'system_dictionary', '/system/dictionary', 'system/dictionary/Index.vue', 'main', '0', '919');
INSERT INTO `desktop_route` VALUES ('9', '登录日志', 'system_login_log', '/system/login-log', 'system/login_log/Index.vue', 'main', '0', '921');
INSERT INTO `desktop_route` VALUES ('10', '操作日志', 'system_option_log', '/system/operation-log', 'system/operation_log/Index.vue', 'main', '0', '923');
INSERT INTO `desktop_route` VALUES ('11', '系统设置', 'system_config', '/system/config', 'system/config/Index.vue', 'main', '0', '901');
INSERT INTO `desktop_route` VALUES ('12', '系统首页', 'index', '/index', 'index/Index.vue', 'main', '0', '1');
INSERT INTO `desktop_route` VALUES ('13', '订单趋势统计', 'statistic_trend', '/statistic/order-trend', 'statistic/OrderTrend.vue', 'main', '0', '801');
INSERT INTO `desktop_route` VALUES ('15', '权限管理', 'system_mobile_permission', '/system/mobile/permission', 'system/mobile/permission/Index.vue', 'main', '0', '917');

-- ----------------------------
-- Table structure for desktop_session
-- ----------------------------
DROP TABLE IF EXISTS `desktop_session`;
CREATE TABLE `desktop_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `token` text NOT NULL COMMENT 'token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  PRIMARY KEY (`id`),
  KEY `token` (`token`(128)) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COMMENT='会话';

-- ----------------------------
-- Records of desktop_session
-- ----------------------------
INSERT INTO `desktop_session` VALUES ('1', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjEyMjg5ODAwIDE3MjExMDAwMDcifQ.r5ZOFSEorO4rlcCf3JozTgZp5Oik0SUv-satpbMl474', '66');
INSERT INTO `desktop_session` VALUES ('2', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjAxNTk2MDAwIDE3MjExMDAwMzIifQ.w8vFN6V06wbMiHJN4nTqWvb5gDDdj42gf5aeDvR7J1g', '434');
INSERT INTO `desktop_session` VALUES ('3', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjc3MzU5NzAwIDE3MjExMDAyMjYifQ.HkNLmXHriYBpEqtvwJSIMGJRqGDaH08LQNMtRxb3Rbg', '33333');
INSERT INTO `desktop_session` VALUES ('4', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjYyNjE4MTAwIDE3MjExMDAyNTkifQ.JFkyDu3pGnw64o448NUA6F-01bYgQvFCkXtUIFRKZOA', '17211020');
INSERT INTO `desktop_session` VALUES ('5', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQ2Nzc5NjAwIDE3MjExMDAzMzkifQ.xRhf8CAI6OioLvFZVVn2lZLWQrVDpKMW5RPt-g74Hk4', '1721103593');
INSERT INTO `desktop_session` VALUES ('6', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY2NDYzMDAwIDE3MjExMDE3OTMifQ.7lLKIDqz6Px0VQuexH7ZumIpciUJYJ80Vr-9-0Diow0', '1721105933');
INSERT INTO `desktop_session` VALUES ('7', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk5MDIzODAwIDE3MjExMDY4OTgifQ.MbS-7b0TZG9G7XngZxQ95W7HpOZA3pJNJibwhABfCzY', '1721108700');
INSERT INTO `desktop_session` VALUES ('8', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk1NTQ1MDAwIDE3MjEyNjczMjkifQ.ahezvr09fBPAsNITy4Kshu_9GxjlXA4ehh80fYe3g28', '1721277641');
INSERT INTO `desktop_session` VALUES ('9', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjg2MDU4NzAwIDE3MjEyNzk4OTYifQ.Umh-GXjsDna6rJ72sWiwlMkM6ukL5IT3g11HW9aozyo', '1721281749');
INSERT INTO `desktop_session` VALUES ('11', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQ4NDg1MTAwIDE3MjEyODMzMDgifQ.e5I3tdSU0EqSDDkXA9op8PeJaVkxHAsFFAJbD_O9fIQ', '1721287979');
INSERT INTO `desktop_session` VALUES ('12', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjkxODc3NjAwIDE3MjEzNTI2OTcifQ.pUCuyQbKeKCaDngYn85pmpWTE6JMT1BHGD9hH_I2_04', '1721354722');
INSERT INTO `desktop_session` VALUES ('13', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjE5MjE1MDAwIDE3MjEzNTY4ODAifQ.9obY6ihcZLVCDKXE21FFq-Q5ZxFRrJay-KEz2s9w234', '1721358693');
INSERT INTO `desktop_session` VALUES ('15', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjA2Mzg3MjAwIDE3MjI4NTIxNjkifQ.ZT4Y4SU8oGcmbIwoEUYXpLJmW_NkzVItBqhwHgcAcSc', '1722854076');
INSERT INTO `desktop_session` VALUES ('16', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjIzMDIxNDAwIDE3MjI5OTk0MDkifQ.AZfYGaSEB6AfV6VGpsysGrwRP-33hkcRH5kkTAe7I1w', '1723001324');
INSERT INTO `desktop_session` VALUES ('17', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjE4MTE3ODAwIDE3MjI5OTk1MjQifQ.Po4TRIHHNkRtiiYLcqWUWfJ7O-eYqveLuCqCubY5h4k', '1723002212');
INSERT INTO `desktop_session` VALUES ('20', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjg0NjAwOTAwIDE3MjMwMDM0MzYifQ.c9h77ylywbz-eCdRjT-QnWOVzHX-WC7y68e8vSTdVsI', '1723005648');
INSERT INTO `desktop_session` VALUES ('21', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjA2MzA5NjAwIDE3MjMwMDgzOTQifQ.b64SEd_2wuoVcYfHN3gGrmbuUjgzLUR0U-26D9c9y1E', '1723010407');
INSERT INTO `desktop_session` VALUES ('23', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjg4MzA1NTAwIDE3MjMwMTY5MzYifQ.XH19YHklQ8pp9SopA8MgbgR9URpZ4pAD0R5RWcDC6h0', '1723018892');
INSERT INTO `desktop_session` VALUES ('24', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjgzNjAxMzAwIDE3MjMwMTkzMzgifQ.nKONPUnhR__oIKiAjg0lDSDT_52-cWk6p93IfPy_JOM', '1723027184');
INSERT INTO `desktop_session` VALUES ('30', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjE5Mzc1NjAwIDE3MjMwODUyNTMifQ.253Ls1h1r0ZQMp8hET-QsEIyRDva2iF8NWrj2lOWFO8', '1723087626');
INSERT INTO `desktop_session` VALUES ('31', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjE0MDY0NzAwIDE3MjMwOTY2NDMifQ.mgr9FrwEDFq5Y1faCHScy9k7kdfzvTkGpHSE2LDpcKE', '1723098459');
INSERT INTO `desktop_session` VALUES ('32', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjU2NDMzODAwIDE3MjMwOTY3MjIifQ.06ek53t3_RnUjFjY6qjqMgcLhbSF0wlyZ4DxQtD7fEs', '1723098525');
INSERT INTO `desktop_session` VALUES ('33', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjU2NTY0MDAwIDE3MjMwOTY3ODAifQ.PJb5ooTvdJrUKQQDh9Ijs5wn3bv_wUju-d6m3S36M78', '1723098583');
INSERT INTO `desktop_session` VALUES ('34', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjcyMjgzNTAwIDE3MjMwOTY4NDEifQ.DoVvOgwfnrKag0quXgB0LBaMn6rYkZhKTelj7biM6Pw', '1723098644');
INSERT INTO `desktop_session` VALUES ('35', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjcyODk1MDAwIDE3MjQ4MzAxNjEifQ.nFrrTeKgWw3rBSHtBkrNUb11fk4KzOdJSqCsQYlDuLk', '1724832053');
INSERT INTO `desktop_session` VALUES ('36', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjc5Mjg0NjAwIDE3MjQ4MzIyODgifQ.mxlTpYaNpJ-vBbj575sv9APr41Q0R8WGyd4kbdLxLr4', '1724834572');
INSERT INTO `desktop_session` VALUES ('37', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjM2MjA3MDAwIDE3MjU1MTk1MzMifQ.ik07D5FHDZa9hM-5tpDC2sHrmKWCZcwyboqLhSUMH24', '1725522019');
INSERT INTO `desktop_session` VALUES ('38', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjgyNjkxMzAwIDE3MjU1MjIzODkifQ.sDeIIdT_ORu90TkCbf2yBW_jI3hqFVQjhhcQg2kXDkM', '1725524363');
INSERT INTO `desktop_session` VALUES ('39', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk3OTQ0ODAwIDE3Mjg2MzA1ODMifQ.KB6si4eFDVQLNkPqVe2YTYq-7scRQ9fvey3b8EAA0mc', '1728633113');
INSERT INTO `desktop_session` VALUES ('40', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjMwNzg2NzAwIDE3Mjg2MzMxNDYifQ.zrV4LqFfsAgXHC76wSY_aahdkM73fe5mT4pyPsJ0cuI', '1728635144');
INSERT INTO `desktop_session` VALUES ('41', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjA1NDAyMX0.iQhk06OMVXfszXm2c8164RZRn3TDd8dBGxlD62SzB8E', '1736055821');
INSERT INTO `desktop_session` VALUES ('42', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjA1NDA4MH0.SlqsPPIjJsLbQE5diOauMq5ZUtVG_FYamD0JxwHTuTo', '1736055880');
INSERT INTO `desktop_session` VALUES ('43', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjA1NDA5Mn0.iiagMWGU8tEFKaHvLzdeU12G3vuEn6K3fV49WCUK49U', '1736055894');
INSERT INTO `desktop_session` VALUES ('44', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjA1NTk1M30.eWL1CPSIyHmuQ9Xe95VoV6gXE1HiqLCeW6Is16hzFt8', '1736058285');
INSERT INTO `desktop_session` VALUES ('45', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjA1NjUzMX0.2zgs5tfPa1FTXklTgcUo0OpbF06ysY00g95Lg7kFI8E', '1736058333');
INSERT INTO `desktop_session` VALUES ('46', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjA1NzA1NX0.dxdhgnYUN5a2HnDJ6QraXD_oQqhhXsvbKXAaxI_i5Og', '1736058856');
INSERT INTO `desktop_session` VALUES ('47', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjA1NzExOX0.QmvxyxTMyYVmTplpwZDEKc_A8mzpxozk2hxKAf2VGfk', '1736058921');
INSERT INTO `desktop_session` VALUES ('48', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjA1NzE4M30.SBPhgj2I5DPhPwO2YDAo8WVqfyUMnlhwiFjIwD0eJNM', '1736061891');
INSERT INTO `desktop_session` VALUES ('49', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjA2NTU1MX0.TWc7qzapjsw-Weicp-JJqHvfKady7p4fN1aaTmFoT1s', '1736067602');
INSERT INTO `desktop_session` VALUES ('50', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjU2ODYwNH0.LefAB22QpuQS9jRwZvi6qPpT0CYjCRJI7pjUnTA-izc', '1736577395');
INSERT INTO `desktop_session` VALUES ('51', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjU5Mjk2M30.FepQNTT2ufxBNhN5jotWG33C3juP7kxOKwumW1LH3lg', '1736595841');
INSERT INTO `desktop_session` VALUES ('52', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjU5NjIyMn0.PThtRP9ukiJzyEjVbG8brT9foah4dTRb3PbrLH-2S_c', '1736614110');
INSERT INTO `desktop_session` VALUES ('53', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjczMTEwM30.Leybr8z2c_oSMa7n8t4PD8m1bGDONdIoQCV5YZcuyXg', '1736734495');
INSERT INTO `desktop_session` VALUES ('54', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjc0MzU2MX0.pnDgsOgYQqba3Q8rrlVsiAHycw3_S6r6Tnpg6SvjRMU', '1736748187');
INSERT INTO `desktop_session` VALUES ('55', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjc0OTE4Mn0.75PtbbvJkqf0Y5u7_NyNGWmwqdddOV2u6Di7tpx99rg', '1736751898');
INSERT INTO `desktop_session` VALUES ('56', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNjc1Mzg1MX0.Cj2m4x7UFca4zld5aVUsVRwAfaQWEvg9jEqP-9e8kgI', '1736757502');
INSERT INTO `desktop_session` VALUES ('57', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNzE4MjQ1OH0.pl-Sl4dbeFsGNMMbGADxwHcaLocW3BuKt6qbI797Naw', '1737184265');
INSERT INTO `desktop_session` VALUES ('58', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNzE4ODUzMH0.nQkja_qah_3GQDDI74Mfe70H7VmUmFjRHH2NVtlwzBk', '1737193034');
INSERT INTO `desktop_session` VALUES ('59', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNzE5NTA2N30._ui0xAtokprAutoXxh3cnVzPieT_3_16ZcQA-BM23XY', '1737203468');
INSERT INTO `desktop_session` VALUES ('60', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNzM0MzkzNH0.K8QUnRjfJpxHz7LfAJrEX8XXe97hjYYBXvbtalfK0t0', '1737346067');
INSERT INTO `desktop_session` VALUES ('61', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczOTg0ODQ2OH0.nEIWq71J_Z1ZZGOjtjb5rQKM7rp5UfTX8x3YvHAJo8g', '1739853613');
INSERT INTO `desktop_session` VALUES ('62', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0MDAzNDcxNn0.4gFT5VyrWw-J4lCehBpJ6RQr2qBM3cr-QkV91uqHLHQ', '1740036555');
INSERT INTO `desktop_session` VALUES ('63', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0MDAzNzEyOH0.DD15j5hp9--noHi92QCjqdIIGO0dNV_XuBI0RefW4vg', '1740042241');
INSERT INTO `desktop_session` VALUES ('64', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0MDQ3MjE4MH0.iwvMQHbPQu22sCgGzLJjOM8nmljw-ihhMNtOYi7YjWg', '1740473994');
INSERT INTO `desktop_session` VALUES ('65', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0MDU2MzEwMX0.UcE9EvMC43Wp4u4YBWleYQxPtW-iAuqsNvVgcU9PC1c', '1740568122');
INSERT INTO `desktop_session` VALUES ('66', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0MDU2NjMxOH0.8mkL8rtIZ9ECJhpqu-Mx_gtJ7ax8yZIf4ndEmHyFcBA', '1740568118');
INSERT INTO `desktop_session` VALUES ('67', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0MDU2NjMyMn0.7exLxJSVtD6jZf7UkZjYU42zdSEMsssWKAQI9aid4qY', '1740569996');
INSERT INTO `desktop_session` VALUES ('68', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0MDYyOTc4MH0.4PRyrPqUTzW338JWzYhTEv6NsbKnlSQtS2F15ARxuyk', '1740631580');
INSERT INTO `desktop_session` VALUES ('69', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0MDYyOTc4Nn0.O3w5FSCIwW3AIVbW41PS2kyLTKJH158kjH6oczb-tdA', '1740632189');
INSERT INTO `desktop_session` VALUES ('70', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0MDcyNzQwMX0.9J2BI0_pzZ5kio4hLtABdH9KKndgtNGO5Mc_ATLwk-g', '1740732137');
INSERT INTO `desktop_session` VALUES ('71', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0NDEwNzc3N30.9cSRkUaD29XQpwtCmKc8rvqkYe0VKahXeS0eGPF8L-4', '1744110166');
INSERT INTO `desktop_session` VALUES ('72', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0NDE4MzUyOX0.l36R-QPgFlC4fsiiRqvyCOiEqkwgFlKjstkUhk8HnRM', '1744185486');
INSERT INTO `desktop_session` VALUES ('73', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0NDE5MjE2NX0.n5QeN_S6ig6gOq4xfqZhHHHkpJkW5SeGrfO7Yyy6moU', '1744195811');
INSERT INTO `desktop_session` VALUES ('74', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0NTQ2NDYzMX0.B7NiH-GQQ9C7lcUVQGWpaECZ8tpetyyRNgcGvl6cuLA', '1745467708');
INSERT INTO `desktop_session` VALUES ('75', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTc0NTc0MjE1OH0.UBk6kr3kHTgawHm7z_haJ0_yZ14vHYVsxxvcQa0hNWM', '1745746091');
INSERT INTO `desktop_session` VALUES ('76', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzQ1NzQ4OTM3fQ.eZrMYd7QIK58ci2awM6OZToejqgAzoJuTSMA54ULl10', '1745750737');
INSERT INTO `desktop_session` VALUES ('77', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzQ1NzQ4OTk3fQ.SzkZt5pdNJJIReqCwi1MD4jSscjHLbYRcEo7gW9WqkQ', '1745750797');
INSERT INTO `desktop_session` VALUES ('78', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzQ1NzQ5MDk2fQ.7AaSt93Ek-6mw2YYXP84DMaIkLPAb43BLdjaMgyzBgQ', '1745750896');
INSERT INTO `desktop_session` VALUES ('79', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzQ1ODA1NzcyfQ.T_iU49a55NJ8rfN_OqVwW0Y3BVIAw5DP_Q540WCQtIw', '1745807572');
INSERT INTO `desktop_session` VALUES ('80', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzQ1ODA4MDc5fQ.mKQKtK4uotk2wZKbdUOxEIq1ku3mjSZFYadJ5DcqJvA', '1745809879');
INSERT INTO `desktop_session` VALUES ('81', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzQ1ODM2OTM1fQ.Jamnbwm0_pclnkAdFLW-Q6oIkqvB2ExSLD4TJaPCQPU', '1745838735');
INSERT INTO `desktop_session` VALUES ('82', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzQ3MjA0MTMwfQ.667WzdsBmcZ4LbCqwCusTHPgtinFDF4GXI5Tc1IjGXY', '1747207730');
INSERT INTO `desktop_session` VALUES ('83', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzQ3MjA0MTM5fQ.xaNIBDlegSfjke4Ch7WjXjrXsU0kbx3XCSjtOMX4c4k', '1747207740');
INSERT INTO `desktop_session` VALUES ('84', '1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzQ3MjA0NjkwfQ.xN5DBkqMLEwofTOIbmm3pITpD1xAZl9u6HuETI710GY', '1747208290');

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` varchar(63) NOT NULL DEFAULT '' COMMENT '字典类型',
  `key` varchar(63) NOT NULL DEFAULT '' COMMENT '字典键',
  `value` varchar(63) NOT NULL DEFAULT '' COMMENT '字典值',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='字典';

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('4', 'desktop_route_layout', 'main', '主布局', '1');
INSERT INTO `dictionary` VALUES ('5', 'desktop_route_layout', 'blank', '空白布局', '3');
INSERT INTO `dictionary` VALUES ('7', 'department_type', '0', '类型1', '0');
INSERT INTO `dictionary` VALUES ('8', 'department_type', '1', '类型2', '1');
INSERT INTO `dictionary` VALUES ('9', 'department_type', '2', '类型3', '2');
INSERT INTO `dictionary` VALUES ('13', 'desktop_route_keep_alive', '1', '是', '1');
INSERT INTO `dictionary` VALUES ('14', 'desktop_route_keep_alive', '0', '否', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of jobs
-- ----------------------------
INSERT INTO `jobs` VALUES ('1', 'message', '{\"job\":\"app\\\\job\\\\Message\",\"maxTries\":null,\"timeout\":null,\"data\":{\"type\":\"read\",\"data\":{\"type\":\"all_read\",\"user_id\":1}}}', '0', null, '1747205590', '1747205590');
INSERT INTO `jobs` VALUES ('2', 'message', '{\"job\":\"app\\\\job\\\\Message\",\"maxTries\":null,\"timeout\":null,\"data\":{\"type\":\"read\",\"data\":{\"type\":\"all_read\",\"user_id\":1}}}', '0', null, '1747205594', '1747205594');

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `ip` varchar(31) NOT NULL DEFAULT '' COMMENT '登录ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

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
INSERT INTO `login_log` VALUES ('33', '1', '1722852169', '127.0.0.1');
INSERT INTO `login_log` VALUES ('34', '1', '1722999409', '127.0.0.1');
INSERT INTO `login_log` VALUES ('35', '1', '1722999524', '127.0.0.1');
INSERT INTO `login_log` VALUES ('36', '1', '1723002721', '127.0.0.1');
INSERT INTO `login_log` VALUES ('37', '1', '1723003404', '127.0.0.1');
INSERT INTO `login_log` VALUES ('38', '1', '1723003436', '127.0.0.1');
INSERT INTO `login_log` VALUES ('39', '1', '1723008394', '127.0.0.1');
INSERT INTO `login_log` VALUES ('40', '1', '1723008607', '127.0.0.1');
INSERT INTO `login_log` VALUES ('41', '1', '1723016937', '127.0.0.1');
INSERT INTO `login_log` VALUES ('42', '1', '1723019338', '127.0.0.1');
INSERT INTO `login_log` VALUES ('43', '1', '1723078746', '127.0.0.1');
INSERT INTO `login_log` VALUES ('44', '1', '1723082071', '127.0.0.1');
INSERT INTO `login_log` VALUES ('45', '1', '1723083591', '127.0.0.1');
INSERT INTO `login_log` VALUES ('46', '1', '1723084076', '127.0.0.1');
INSERT INTO `login_log` VALUES ('47', '1', '1723084544', '127.0.0.1');
INSERT INTO `login_log` VALUES ('48', '1', '1723085253', '127.0.0.1');
INSERT INTO `login_log` VALUES ('49', '1', '1723096643', '127.0.0.1');
INSERT INTO `login_log` VALUES ('50', '1', '1723096722', '127.0.0.1');
INSERT INTO `login_log` VALUES ('51', '1', '1723096780', '127.0.0.1');
INSERT INTO `login_log` VALUES ('52', '1', '1723096841', '127.0.0.1');
INSERT INTO `login_log` VALUES ('53', '1', '1724830161', '127.0.0.1');
INSERT INTO `login_log` VALUES ('54', '1', '1724832288', '127.0.0.1');
INSERT INTO `login_log` VALUES ('55', '1', '1725519533', '127.0.0.1');
INSERT INTO `login_log` VALUES ('56', '1', '1725522390', '127.0.0.1');
INSERT INTO `login_log` VALUES ('57', '1', '1728630587', '127.0.0.1');
INSERT INTO `login_log` VALUES ('58', '1', '1728633146', '127.0.0.1');
INSERT INTO `login_log` VALUES ('59', '1', '1736054080', '127.0.0.1');
INSERT INTO `login_log` VALUES ('60', '1', '1736054092', '127.0.0.1');
INSERT INTO `login_log` VALUES ('61', '1', '1736055953', '127.0.0.1');
INSERT INTO `login_log` VALUES ('62', '1', '1736056531', '127.0.0.1');
INSERT INTO `login_log` VALUES ('63', '1', '1736057055', '127.0.0.1');
INSERT INTO `login_log` VALUES ('64', '1', '1736057119', '127.0.0.1');
INSERT INTO `login_log` VALUES ('65', '1', '1736057183', '127.0.0.1');
INSERT INTO `login_log` VALUES ('66', '1', '1736065551', '127.0.0.1');
INSERT INTO `login_log` VALUES ('67', '1', '1736568604', '127.0.0.1');
INSERT INTO `login_log` VALUES ('68', '1', '1736592964', '127.0.0.1');
INSERT INTO `login_log` VALUES ('69', '1', '1736596222', '127.0.0.1');
INSERT INTO `login_log` VALUES ('70', '1', '1736731103', '127.0.0.1');
INSERT INTO `login_log` VALUES ('71', '1', '1736743561', '127.0.0.1');
INSERT INTO `login_log` VALUES ('72', '1', '1736749182', '127.0.0.1');
INSERT INTO `login_log` VALUES ('73', '1', '1736753852', '127.0.0.1');
INSERT INTO `login_log` VALUES ('74', '1', '1737182458', '127.0.0.1');
INSERT INTO `login_log` VALUES ('75', '1', '1737188530', '127.0.0.1');
INSERT INTO `login_log` VALUES ('76', '1', '1737195067', '127.0.0.1');
INSERT INTO `login_log` VALUES ('77', '1', '1737343934', '127.0.0.1');
INSERT INTO `login_log` VALUES ('78', '1', '1737356550', '127.0.0.1');
INSERT INTO `login_log` VALUES ('79', '1', '1737356555', '127.0.0.1');
INSERT INTO `login_log` VALUES ('80', '1', '1737356700', '127.0.0.1');
INSERT INTO `login_log` VALUES ('81', '1', '1737356719', '127.0.0.1');
INSERT INTO `login_log` VALUES ('82', '1', '1737359169', '127.0.0.1');
INSERT INTO `login_log` VALUES ('83', '1', '1737359282', '127.0.0.1');
INSERT INTO `login_log` VALUES ('84', '1', '1739848469', '127.0.0.1');
INSERT INTO `login_log` VALUES ('85', '1', '1740034716', '172.18.0.2');
INSERT INTO `login_log` VALUES ('86', '1', '1740037129', '172.18.0.2');
INSERT INTO `login_log` VALUES ('87', '1', '1740472180', '172.18.0.2');
INSERT INTO `login_log` VALUES ('88', '1', '1740563101', '172.18.0.2');
INSERT INTO `login_log` VALUES ('89', '1', '1740566318', '172.18.0.2');
INSERT INTO `login_log` VALUES ('90', '1', '1740566322', '172.18.0.2');
INSERT INTO `login_log` VALUES ('91', '1', '1740629780', '172.18.0.2');
INSERT INTO `login_log` VALUES ('92', '1', '1740629786', '172.18.0.2');
INSERT INTO `login_log` VALUES ('93', '1', '1740727401', '127.0.0.1');
INSERT INTO `login_log` VALUES ('94', '1', '1744107778', '127.0.0.1');
INSERT INTO `login_log` VALUES ('95', '1', '1744183529', '127.0.0.1');
INSERT INTO `login_log` VALUES ('96', '1', '1744192165', '127.0.0.1');
INSERT INTO `login_log` VALUES ('97', '1', '1745464632', '127.0.0.1');
INSERT INTO `login_log` VALUES ('98', '1', '1745742158', '127.0.0.1');
INSERT INTO `login_log` VALUES ('99', '1', '1745748937', '127.0.0.1');
INSERT INTO `login_log` VALUES ('100', '1', '1745748997', '127.0.0.1');
INSERT INTO `login_log` VALUES ('101', '1', '1745749096', '127.0.0.1');
INSERT INTO `login_log` VALUES ('102', '1', '1745805772', '127.0.0.1');
INSERT INTO `login_log` VALUES ('103', '1', '1745808080', '127.0.0.1');
INSERT INTO `login_log` VALUES ('104', '1', '1745836935', '127.0.0.1');
INSERT INTO `login_log` VALUES ('105', '1', '1747204130', '127.0.0.1');
INSERT INTO `login_log` VALUES ('106', '1', '1747204140', '127.0.0.1');
INSERT INTO `login_log` VALUES ('107', '1', '1747204690', '127.0.0.1');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(63) NOT NULL DEFAULT '' COMMENT '消息标题',
  `content` varchar(127) NOT NULL DEFAULT '' COMMENT '消息内容',
  `url` varchar(127) NOT NULL DEFAULT '' COMMENT '桌面端url',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '消息时间',
  `is_read` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否已读',
  `read_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '阅读时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `is_read` (`is_read`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='系统消息';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '1', '标题', '内容', 'https:/www.baidu.com', '1737189131', '1', '1747205594');
INSERT INTO `message` VALUES ('2', '1', '标题', '内容', 'https:/www.baidu.com', '1737189150', '1', '1747205594');
INSERT INTO `message` VALUES ('3', '1', '标题', '内容', 'https:/www.baidu.com', '1737189193', '1', '1747205594');
INSERT INTO `message` VALUES ('4', '1', '标题', '内容', 'https:/www.baidu.com', '1737189194', '1', '1747205594');
INSERT INTO `message` VALUES ('5', '1', '标题', '内容', 'https:/www.baidu.com', '1737189230', '1', '1747205594');
INSERT INTO `message` VALUES ('6', '1', '标题', '内容', 'https:/www.baidu.com', '1737189235', '1', '1747205594');
INSERT INTO `message` VALUES ('7', '1', '标题', '内容', 'https:/www.baidu.com', '1737189285', '1', '1747205594');
INSERT INTO `message` VALUES ('8', '1', '标题', '内容', 'https:/www.baidu.com', '1737189301', '1', '1747205594');
INSERT INTO `message` VALUES ('9', '1', '标题', '内容', 'https:/www.baidu.com', '1737189301', '1', '1747205594');
INSERT INTO `message` VALUES ('10', '1', '标题', '内容', 'https:/www.baidu.com', '1737189301', '1', '1747205594');
INSERT INTO `message` VALUES ('11', '1', '标题', '内容', 'https:/www.baidu.com', '1737189307', '1', '1747205594');
INSERT INTO `message` VALUES ('12', '1', '标题', '内容', 'https:/www.baidu.com', '1737189371', '1', '1747205594');
INSERT INTO `message` VALUES ('13', '1', '标题', '内容', 'https:/www.baidu.com', '1737189428', '1', '1747205594');
INSERT INTO `message` VALUES ('14', '1', '标题', '内容', 'https:/www.baidu.com', '1737191011', '1', '1747205594');
INSERT INTO `message` VALUES ('15', '1', '标题', '内容', 'https:/www.baidu.com', '1737191015', '1', '1747205594');
INSERT INTO `message` VALUES ('16', '1', '标题', '内容', 'https:/www.baidu.com', '1737191063', '1', '1747205594');
INSERT INTO `message` VALUES ('17', '1', '标题', '内容', 'https:/www.baidu.com', '1737195121', '1', '1747205594');
INSERT INTO `message` VALUES ('18', '1', '标题', '内容', 'https:/www.baidu.com', '1737195154', '1', '1747205594');
INSERT INTO `message` VALUES ('19', '1', '标题', '内容', 'https:/www.baidu.com', '1737195166', '1', '1747205594');
INSERT INTO `message` VALUES ('20', '1', '标题', '内容', 'https:/www.baidu.com', '1737195528', '1', '1747205594');
INSERT INTO `message` VALUES ('21', '1', '标题', '内容', 'https:/www.baidu.com', '1737195649', '1', '1747205594');
INSERT INTO `message` VALUES ('22', '1', '标题', '内容', 'https:/www.baidu.com', '1737195670', '1', '1747205594');
INSERT INTO `message` VALUES ('23', '1', '你的B站2024年度报告来啦', '珍贵的回忆已经为你打包完毕！今年你登录B站多少天？谁成为了你的最爱？戳链接回顾2024，查收UP主送来的惊喜彩蛋', 'https:/www.baidu.com', '1737196101', '1', '1747205594');
INSERT INTO `message` VALUES ('24', '1', '你的B站2024年度报告来啦', '珍贵的回忆已经为你打包完毕！今年你登录B站多少天？谁成为了你的最爱？戳链接回顾2024，查收UP主送来的惊喜彩蛋', 'https:/www.baidu.com', '1737196183', '1', '1747205594');

-- ----------------------------
-- Table structure for mobile_permission
-- ----------------------------
DROP TABLE IF EXISTS `mobile_permission`;
CREATE TABLE `mobile_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `permission_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级权限id',
  `name` varchar(31) NOT NULL DEFAULT '' COMMENT '权限名称',
  `key` varchar(127) DEFAULT '' COMMENT '权限key',
  `api_string` text COMMENT '接口地址串',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='权限';

-- ----------------------------
-- Records of mobile_permission
-- ----------------------------
INSERT INTO `mobile_permission` VALUES ('1', '0', '功能模块1', 'module1', 'xxx/xxx/xxx', '1');
INSERT INTO `mobile_permission` VALUES ('2', '0', '功能模块2', 'module2', 'xxx/xxx/xxx', '3');

-- ----------------------------
-- Table structure for mobile_session
-- ----------------------------
DROP TABLE IF EXISTS `mobile_session`;
CREATE TABLE `mobile_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `token` text NOT NULL COMMENT 'token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `token` (`token`(128)) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='会话';

-- ----------------------------
-- Records of mobile_session
-- ----------------------------
INSERT INTO `mobile_session` VALUES ('1', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY2MTA5MzAwIDE3MjEyOTUwMTkifQ.zaU_EfFM1iWzmVsppDd1PWB5Wn8Ti21Ih7CI-VLcQFY', '1752831056', '1');
INSERT INTO `mobile_session` VALUES ('2', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjc3NDI3ODAwIDE3MjEyOTUwNTYifQ.mdRLnsBuEXMjeF0utpWpkJSScfWJ_jybqWFY2jmXL3k', '1752831062', '1');
INSERT INTO `mobile_session` VALUES ('3', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjI3NzI2NTAwIDE3MjEyOTUwNjIifQ.VFCNc6Kzj4RFSdavLOkzUZduqZ0nfhZoHmCNOXuVxh8', '1752831119', '1');
INSERT INTO `mobile_session` VALUES ('4', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjUyMjgwODAwIDE3MjEyOTUxMTkifQ.W6G867C2M_eEh1q_r5aYVCRTq2Jx4guUOW0Dw4AXTZo', '1752831147', '1');
INSERT INTO `mobile_session` VALUES ('5', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjA4MDczNTAwIDE3MjEyOTUxNDgifQ.x6ICzKUvj-ClqaFy4SFQaD5p1fHgpROoZWBbK8J8i0w', '1752831260', '1');
INSERT INTO `mobile_session` VALUES ('6', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjcyNTI0OTAwIDE3MjEyOTUyNjAifQ.o0zHk_YCy7Q3TY_Hcio5_MgAkntSeIIZND2WP_xt0_g', '1752831473', '1');
INSERT INTO `mobile_session` VALUES ('7', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjI1MDUzMDAwIDE3MjEyOTU0NzQifQ.7S7G3rVXETWorz_GYclIf4xnd9MZZe1bpYArm05FQ6k', '1752831474', '1');
INSERT INTO `mobile_session` VALUES ('8', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjU3MDc4MTAwIDE3MjEyOTU1NTAifQ.nLdajjpdrBexWZQB-CmMGfG4yv5Z3GFV6r-U_uASlVM', '1752831550', '1');
INSERT INTO `mobile_session` VALUES ('9', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjUzODc3NTAwIDE3MjEyOTU5NzQifQ.Hkpx2eCtWj30rBRi4vKVDhVjx8a29VRn66L43oBmkRw', '1752831974', '1');
INSERT INTO `mobile_session` VALUES ('10', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk4MDE2NTAwIDE3MjEyOTU5ODEifQ.oN0Uh4KhksW2fg9ZLnkYJRGc_xBzyQ8N-ng8JQjmN6U', '1752831981', '1');
INSERT INTO `mobile_session` VALUES ('11', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjE4NjE5ODAwIDE3MjEyOTYwMzAifQ.oxMZlEUzvN2gC6wtpIYMhMKBvLdC1pMASJhObPpURyQ', '1752834728', '1');
INSERT INTO `mobile_session` VALUES ('12', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjkzMzI1NzAwIDE3MjEyOTg3MjgifQ.u7XQnB9zVt9TG5IVn7yeWhuEGDhUIZMymOQJqQ9E7Gw', '1752834729', '1');
INSERT INTO `mobile_session` VALUES ('14', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjIwNzA4NjAwIDE3MjEzNTQ3OTkifQ.uCNHHviJJzX1UkYZSOjvFLMN4SKl8iNbhvCE57WgWPs', '1752891327', '1');
INSERT INTO `mobile_session` VALUES ('25', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjE0MDQ4OTAwIDE3MjEzNzU3MDEifQ.g3acVvKBpCr5UxInXjjKi7d1qfTU32C8C0zy2PLe3gA', '1752918757', '1');
INSERT INTO `mobile_session` VALUES ('26', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjIxNTkxNTAwIDE3MjEzNzY2NTkifQ.uNBGAO4lyZEL0-ARLMlvFzwZVunMjGBMHBQMEdyBz8M', '1752920285', '1');
INSERT INTO `mobile_session` VALUES ('27', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNzM1NjU1MH0.MYI6Uiz4zwF1KqxrHskKxxCj2aJ7P-81lmgGc7n24f4', '1739948550', '1');
INSERT INTO `mobile_session` VALUES ('28', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNzM1NjU1NX0.HcK_Rrd8YyNfQlS6IGI4T1OegbA74VE64QGO6eXG3xQ', '1739948700', '1');
INSERT INTO `mobile_session` VALUES ('29', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNzM1NjcwMH0.j0zIWsDge3vQMNTyRnmhqIeM_GX0toLehIaFslTXCFM', '1739948719', '1');
INSERT INTO `mobile_session` VALUES ('32', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidGltZSI6MTczNzM1OTI4Mn0.4qW3qZgsFBXei3xh89SHPpkvK589jzPw4e_ra46LRJg', '1739955557', '1');

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `api` varchar(255) NOT NULL DEFAULT '' COMMENT '接口',
  `ip` varchar(31) NOT NULL DEFAULT '' COMMENT '操作ip',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2424 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES ('1', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721269753');
INSERT INTO `operation_log` VALUES ('2', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721269753');
INSERT INTO `operation_log` VALUES ('3', '1', '/desktop/system.user.edit/init', '127.0.0.1', '1721269757');
INSERT INTO `operation_log` VALUES ('4', '1', '/desktop/system.user.editpassword/save', '127.0.0.1', '1721269779');
INSERT INTO `operation_log` VALUES ('5', '1', '/desktop/system.user.editpassword/save', '127.0.0.1', '1721269804');
INSERT INTO `operation_log` VALUES ('6', '1', '/desktop/system.user.editpassword/save', '127.0.0.1', '1721269818');
INSERT INTO `operation_log` VALUES ('7', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721269869');
INSERT INTO `operation_log` VALUES ('8', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721269869');
INSERT INTO `operation_log` VALUES ('9', '1', '/desktop/system.config.index/init', '127.0.0.1', '1721269886');
INSERT INTO `operation_log` VALUES ('10', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721269888');
INSERT INTO `operation_log` VALUES ('11', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721269888');
INSERT INTO `operation_log` VALUES ('12', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1721269890');
INSERT INTO `operation_log` VALUES ('13', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721269891');
INSERT INTO `operation_log` VALUES ('14', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721269891');
INSERT INTO `operation_log` VALUES ('15', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1721269901');
INSERT INTO `operation_log` VALUES ('16', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1721269904');
INSERT INTO `operation_log` VALUES ('17', '1', '/desktop/system.desktop.permission.edit/init', '127.0.0.1', '1721269913');
INSERT INTO `operation_log` VALUES ('18', '1', '/desktop/system.desktop.permission.edit/save', '127.0.0.1', '1721269924');
INSERT INTO `operation_log` VALUES ('19', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1721269925');
INSERT INTO `operation_log` VALUES ('20', '1', '/desktop/system.user.detail/init', '127.0.0.1', '1721269931');
INSERT INTO `operation_log` VALUES ('21', '1', '/desktop/system.user.detail/init', '127.0.0.1', '1721269937');
INSERT INTO `operation_log` VALUES ('22', '1', '/desktop/system.user.detail/init', '127.0.0.1', '1721270022');
INSERT INTO `operation_log` VALUES ('23', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721270048');
INSERT INTO `operation_log` VALUES ('24', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1721270052');
INSERT INTO `operation_log` VALUES ('25', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1721270053');
INSERT INTO `operation_log` VALUES ('26', '1', '/desktop/system.login_log.index/getloginlogs', '127.0.0.1', '1721270055');
INSERT INTO `operation_log` VALUES ('27', '1', '/desktop/system.operation_log.index/getoperationlogs', '127.0.0.1', '1721270096');
INSERT INTO `operation_log` VALUES ('28', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721272151');
INSERT INTO `operation_log` VALUES ('29', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721272160');
INSERT INTO `operation_log` VALUES ('30', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1721272163');
INSERT INTO `operation_log` VALUES ('31', '1', '/desktop/system.config.index/init', '127.0.0.1', '1721272166');
INSERT INTO `operation_log` VALUES ('32', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721272170');
INSERT INTO `operation_log` VALUES ('33', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721272170');
INSERT INTO `operation_log` VALUES ('34', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1721272172');
INSERT INTO `operation_log` VALUES ('35', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1721272174');
INSERT INTO `operation_log` VALUES ('36', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1721272230');
INSERT INTO `operation_log` VALUES ('37', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1721272258');
INSERT INTO `operation_log` VALUES ('38', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1721272265');
INSERT INTO `operation_log` VALUES ('39', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721273686');
INSERT INTO `operation_log` VALUES ('40', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1721273695');
INSERT INTO `operation_log` VALUES ('41', '1', '/desktop/system.config.index/init', '127.0.0.1', '1721273716');
INSERT INTO `operation_log` VALUES ('42', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721273731');
INSERT INTO `operation_log` VALUES ('43', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721273806');
INSERT INTO `operation_log` VALUES ('44', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274195');
INSERT INTO `operation_log` VALUES ('45', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274195');
INSERT INTO `operation_log` VALUES ('46', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274200');
INSERT INTO `operation_log` VALUES ('47', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274207');
INSERT INTO `operation_log` VALUES ('48', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274216');
INSERT INTO `operation_log` VALUES ('49', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274221');
INSERT INTO `operation_log` VALUES ('50', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274304');
INSERT INTO `operation_log` VALUES ('51', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274317');
INSERT INTO `operation_log` VALUES ('52', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274330');
INSERT INTO `operation_log` VALUES ('53', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274353');
INSERT INTO `operation_log` VALUES ('54', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274365');
INSERT INTO `operation_log` VALUES ('55', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274395');
INSERT INTO `operation_log` VALUES ('56', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274414');
INSERT INTO `operation_log` VALUES ('57', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274426');
INSERT INTO `operation_log` VALUES ('58', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274427');
INSERT INTO `operation_log` VALUES ('59', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274452');
INSERT INTO `operation_log` VALUES ('60', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274474');
INSERT INTO `operation_log` VALUES ('61', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274496');
INSERT INTO `operation_log` VALUES ('62', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274533');
INSERT INTO `operation_log` VALUES ('63', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274563');
INSERT INTO `operation_log` VALUES ('64', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274592');
INSERT INTO `operation_log` VALUES ('65', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274624');
INSERT INTO `operation_log` VALUES ('66', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274634');
INSERT INTO `operation_log` VALUES ('67', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274654');
INSERT INTO `operation_log` VALUES ('68', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274678');
INSERT INTO `operation_log` VALUES ('69', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274699');
INSERT INTO `operation_log` VALUES ('70', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274805');
INSERT INTO `operation_log` VALUES ('71', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274820');
INSERT INTO `operation_log` VALUES ('72', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274827');
INSERT INTO `operation_log` VALUES ('73', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274834');
INSERT INTO `operation_log` VALUES ('74', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274846');
INSERT INTO `operation_log` VALUES ('75', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274909');
INSERT INTO `operation_log` VALUES ('76', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274931');
INSERT INTO `operation_log` VALUES ('77', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274955');
INSERT INTO `operation_log` VALUES ('78', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274964');
INSERT INTO `operation_log` VALUES ('79', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274968');
INSERT INTO `operation_log` VALUES ('80', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721274981');
INSERT INTO `operation_log` VALUES ('81', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275071');
INSERT INTO `operation_log` VALUES ('82', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275124');
INSERT INTO `operation_log` VALUES ('83', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275189');
INSERT INTO `operation_log` VALUES ('84', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275201');
INSERT INTO `operation_log` VALUES ('85', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275307');
INSERT INTO `operation_log` VALUES ('86', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275335');
INSERT INTO `operation_log` VALUES ('87', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275406');
INSERT INTO `operation_log` VALUES ('88', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275508');
INSERT INTO `operation_log` VALUES ('89', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275518');
INSERT INTO `operation_log` VALUES ('90', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275559');
INSERT INTO `operation_log` VALUES ('91', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721275740');
INSERT INTO `operation_log` VALUES ('92', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721279946');
INSERT INTO `operation_log` VALUES ('93', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1721279949');
INSERT INTO `operation_log` VALUES ('94', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721282083');
INSERT INTO `operation_log` VALUES ('95', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1721282085');
INSERT INTO `operation_log` VALUES ('96', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721282372');
INSERT INTO `operation_log` VALUES ('97', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721282785');
INSERT INTO `operation_log` VALUES ('98', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721282889');
INSERT INTO `operation_log` VALUES ('99', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721282967');
INSERT INTO `operation_log` VALUES ('100', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721283273');
INSERT INTO `operation_log` VALUES ('101', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721283312');
INSERT INTO `operation_log` VALUES ('102', '1', '/desktop/system.config.index/init', '127.0.0.1', '1721283317');
INSERT INTO `operation_log` VALUES ('103', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721283362');
INSERT INTO `operation_log` VALUES ('104', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721283362');
INSERT INTO `operation_log` VALUES ('105', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721283383');
INSERT INTO `operation_log` VALUES ('106', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721283384');
INSERT INTO `operation_log` VALUES ('107', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721283588');
INSERT INTO `operation_log` VALUES ('108', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1721283594');
INSERT INTO `operation_log` VALUES ('109', '1', '/desktop/system.config.index/init', '127.0.0.1', '1721283596');
INSERT INTO `operation_log` VALUES ('110', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721283597');
INSERT INTO `operation_log` VALUES ('111', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721283598');
INSERT INTO `operation_log` VALUES ('112', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1721283599');
INSERT INTO `operation_log` VALUES ('113', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1721283600');
INSERT INTO `operation_log` VALUES ('114', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1721283603');
INSERT INTO `operation_log` VALUES ('115', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1721283605');
INSERT INTO `operation_log` VALUES ('116', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1721283607');
INSERT INTO `operation_log` VALUES ('117', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1721283610');
INSERT INTO `operation_log` VALUES ('118', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1721283612');
INSERT INTO `operation_log` VALUES ('119', '1', '/desktop/system.login_log.index/getloginlogs', '127.0.0.1', '1721283613');
INSERT INTO `operation_log` VALUES ('120', '1', '/desktop/system.operation_log.index/getoperationlogs', '127.0.0.1', '1721283615');
INSERT INTO `operation_log` VALUES ('121', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1721283645');
INSERT INTO `operation_log` VALUES ('122', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721283652');
INSERT INTO `operation_log` VALUES ('123', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721283652');
INSERT INTO `operation_log` VALUES ('124', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721283711');
INSERT INTO `operation_log` VALUES ('125', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721283712');
INSERT INTO `operation_log` VALUES ('126', '1', '/desktop/system.user.edit/init', '127.0.0.1', '1721283826');
INSERT INTO `operation_log` VALUES ('127', '1', '/desktop/system.user.edit/init', '127.0.0.1', '1721283851');
INSERT INTO `operation_log` VALUES ('128', '1', '/desktop/system.user.edit/save', '127.0.0.1', '1721283854');
INSERT INTO `operation_log` VALUES ('129', '1', '/desktop/system.user.edit/save', '127.0.0.1', '1721283861');
INSERT INTO `operation_log` VALUES ('130', '1', '/desktop/system.user.edit/save', '127.0.0.1', '1721283876');
INSERT INTO `operation_log` VALUES ('131', '1', '/desktop/system.user.edit/save', '127.0.0.1', '1721283924');
INSERT INTO `operation_log` VALUES ('132', '1', '/mobile/login/login', '127.0.0.1', '1721295056');
INSERT INTO `operation_log` VALUES ('133', '1', '/mobile/login/login', '127.0.0.1', '1721295062');
INSERT INTO `operation_log` VALUES ('134', '1', '/mobile/login/login', '127.0.0.1', '1721295119');
INSERT INTO `operation_log` VALUES ('135', '1', '/mobile/login/login', '127.0.0.1', '1721295148');
INSERT INTO `operation_log` VALUES ('136', '1', '/mobile/login/login', '127.0.0.1', '1721295201');
INSERT INTO `operation_log` VALUES ('137', '1', '/mobile/login/login', '127.0.0.1', '1721295237');
INSERT INTO `operation_log` VALUES ('138', '1', '/mobile/login/login', '127.0.0.1', '1721295250');
INSERT INTO `operation_log` VALUES ('139', '1', '/mobile/login/login', '127.0.0.1', '1721295260');
INSERT INTO `operation_log` VALUES ('140', '1', '/mobile/login/login', '127.0.0.1', '1721295474');
INSERT INTO `operation_log` VALUES ('141', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296030');
INSERT INTO `operation_log` VALUES ('142', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296038');
INSERT INTO `operation_log` VALUES ('143', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296040');
INSERT INTO `operation_log` VALUES ('144', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296059');
INSERT INTO `operation_log` VALUES ('145', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296092');
INSERT INTO `operation_log` VALUES ('146', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296100');
INSERT INTO `operation_log` VALUES ('147', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296122');
INSERT INTO `operation_log` VALUES ('148', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296126');
INSERT INTO `operation_log` VALUES ('149', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296130');
INSERT INTO `operation_log` VALUES ('150', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296144');
INSERT INTO `operation_log` VALUES ('151', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296145');
INSERT INTO `operation_log` VALUES ('152', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296170');
INSERT INTO `operation_log` VALUES ('153', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296181');
INSERT INTO `operation_log` VALUES ('154', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296184');
INSERT INTO `operation_log` VALUES ('155', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296186');
INSERT INTO `operation_log` VALUES ('156', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296187');
INSERT INTO `operation_log` VALUES ('157', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296189');
INSERT INTO `operation_log` VALUES ('158', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296220');
INSERT INTO `operation_log` VALUES ('159', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296228');
INSERT INTO `operation_log` VALUES ('160', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296258');
INSERT INTO `operation_log` VALUES ('161', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296276');
INSERT INTO `operation_log` VALUES ('162', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296290');
INSERT INTO `operation_log` VALUES ('163', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296294');
INSERT INTO `operation_log` VALUES ('164', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296299');
INSERT INTO `operation_log` VALUES ('165', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296327');
INSERT INTO `operation_log` VALUES ('166', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296331');
INSERT INTO `operation_log` VALUES ('167', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296405');
INSERT INTO `operation_log` VALUES ('168', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296410');
INSERT INTO `operation_log` VALUES ('169', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296414');
INSERT INTO `operation_log` VALUES ('170', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296424');
INSERT INTO `operation_log` VALUES ('171', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296430');
INSERT INTO `operation_log` VALUES ('172', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296433');
INSERT INTO `operation_log` VALUES ('173', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296442');
INSERT INTO `operation_log` VALUES ('174', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296454');
INSERT INTO `operation_log` VALUES ('175', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296456');
INSERT INTO `operation_log` VALUES ('176', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296473');
INSERT INTO `operation_log` VALUES ('177', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296476');
INSERT INTO `operation_log` VALUES ('178', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296604');
INSERT INTO `operation_log` VALUES ('179', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296605');
INSERT INTO `operation_log` VALUES ('180', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296606');
INSERT INTO `operation_log` VALUES ('181', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296610');
INSERT INTO `operation_log` VALUES ('182', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296612');
INSERT INTO `operation_log` VALUES ('183', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296613');
INSERT INTO `operation_log` VALUES ('184', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296618');
INSERT INTO `operation_log` VALUES ('185', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296633');
INSERT INTO `operation_log` VALUES ('186', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296636');
INSERT INTO `operation_log` VALUES ('187', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296663');
INSERT INTO `operation_log` VALUES ('188', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296680');
INSERT INTO `operation_log` VALUES ('189', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296684');
INSERT INTO `operation_log` VALUES ('190', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296691');
INSERT INTO `operation_log` VALUES ('191', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296692');
INSERT INTO `operation_log` VALUES ('192', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296701');
INSERT INTO `operation_log` VALUES ('193', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296752');
INSERT INTO `operation_log` VALUES ('194', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296771');
INSERT INTO `operation_log` VALUES ('195', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296775');
INSERT INTO `operation_log` VALUES ('196', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296802');
INSERT INTO `operation_log` VALUES ('197', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296818');
INSERT INTO `operation_log` VALUES ('198', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296821');
INSERT INTO `operation_log` VALUES ('199', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296823');
INSERT INTO `operation_log` VALUES ('200', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296840');
INSERT INTO `operation_log` VALUES ('201', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296843');
INSERT INTO `operation_log` VALUES ('202', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296847');
INSERT INTO `operation_log` VALUES ('203', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296853');
INSERT INTO `operation_log` VALUES ('204', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296861');
INSERT INTO `operation_log` VALUES ('205', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296863');
INSERT INTO `operation_log` VALUES ('206', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296871');
INSERT INTO `operation_log` VALUES ('207', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296874');
INSERT INTO `operation_log` VALUES ('208', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296900');
INSERT INTO `operation_log` VALUES ('209', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296901');
INSERT INTO `operation_log` VALUES ('210', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296906');
INSERT INTO `operation_log` VALUES ('211', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296911');
INSERT INTO `operation_log` VALUES ('212', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296947');
INSERT INTO `operation_log` VALUES ('213', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296954');
INSERT INTO `operation_log` VALUES ('214', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296955');
INSERT INTO `operation_log` VALUES ('215', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296991');
INSERT INTO `operation_log` VALUES ('216', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296993');
INSERT INTO `operation_log` VALUES ('217', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721296994');
INSERT INTO `operation_log` VALUES ('218', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297003');
INSERT INTO `operation_log` VALUES ('219', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297014');
INSERT INTO `operation_log` VALUES ('220', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297015');
INSERT INTO `operation_log` VALUES ('221', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297022');
INSERT INTO `operation_log` VALUES ('222', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297029');
INSERT INTO `operation_log` VALUES ('223', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297198');
INSERT INTO `operation_log` VALUES ('224', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297279');
INSERT INTO `operation_log` VALUES ('225', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297297');
INSERT INTO `operation_log` VALUES ('226', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297299');
INSERT INTO `operation_log` VALUES ('227', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297303');
INSERT INTO `operation_log` VALUES ('228', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297305');
INSERT INTO `operation_log` VALUES ('229', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297306');
INSERT INTO `operation_log` VALUES ('230', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297308');
INSERT INTO `operation_log` VALUES ('231', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297407');
INSERT INTO `operation_log` VALUES ('232', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297586');
INSERT INTO `operation_log` VALUES ('233', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297604');
INSERT INTO `operation_log` VALUES ('234', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297612');
INSERT INTO `operation_log` VALUES ('235', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297624');
INSERT INTO `operation_log` VALUES ('236', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297637');
INSERT INTO `operation_log` VALUES ('237', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297640');
INSERT INTO `operation_log` VALUES ('238', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297643');
INSERT INTO `operation_log` VALUES ('239', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297652');
INSERT INTO `operation_log` VALUES ('240', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297656');
INSERT INTO `operation_log` VALUES ('241', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297673');
INSERT INTO `operation_log` VALUES ('242', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297685');
INSERT INTO `operation_log` VALUES ('243', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297689');
INSERT INTO `operation_log` VALUES ('244', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297699');
INSERT INTO `operation_log` VALUES ('245', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297713');
INSERT INTO `operation_log` VALUES ('246', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297738');
INSERT INTO `operation_log` VALUES ('247', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297774');
INSERT INTO `operation_log` VALUES ('248', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297779');
INSERT INTO `operation_log` VALUES ('249', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297785');
INSERT INTO `operation_log` VALUES ('250', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297790');
INSERT INTO `operation_log` VALUES ('251', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297797');
INSERT INTO `operation_log` VALUES ('252', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297801');
INSERT INTO `operation_log` VALUES ('253', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297894');
INSERT INTO `operation_log` VALUES ('254', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297900');
INSERT INTO `operation_log` VALUES ('255', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297905');
INSERT INTO `operation_log` VALUES ('256', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297913');
INSERT INTO `operation_log` VALUES ('257', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297962');
INSERT INTO `operation_log` VALUES ('258', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297976');
INSERT INTO `operation_log` VALUES ('259', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297977');
INSERT INTO `operation_log` VALUES ('260', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297989');
INSERT INTO `operation_log` VALUES ('261', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721297992');
INSERT INTO `operation_log` VALUES ('262', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298028');
INSERT INTO `operation_log` VALUES ('263', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298032');
INSERT INTO `operation_log` VALUES ('264', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298061');
INSERT INTO `operation_log` VALUES ('265', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298083');
INSERT INTO `operation_log` VALUES ('266', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298089');
INSERT INTO `operation_log` VALUES ('267', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298110');
INSERT INTO `operation_log` VALUES ('268', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298118');
INSERT INTO `operation_log` VALUES ('269', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298131');
INSERT INTO `operation_log` VALUES ('270', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298133');
INSERT INTO `operation_log` VALUES ('271', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298148');
INSERT INTO `operation_log` VALUES ('272', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298168');
INSERT INTO `operation_log` VALUES ('273', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298169');
INSERT INTO `operation_log` VALUES ('274', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298185');
INSERT INTO `operation_log` VALUES ('275', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298186');
INSERT INTO `operation_log` VALUES ('276', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298201');
INSERT INTO `operation_log` VALUES ('277', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298206');
INSERT INTO `operation_log` VALUES ('278', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298208');
INSERT INTO `operation_log` VALUES ('279', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298395');
INSERT INTO `operation_log` VALUES ('280', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298403');
INSERT INTO `operation_log` VALUES ('281', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298408');
INSERT INTO `operation_log` VALUES ('282', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298420');
INSERT INTO `operation_log` VALUES ('283', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298421');
INSERT INTO `operation_log` VALUES ('284', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298434');
INSERT INTO `operation_log` VALUES ('285', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298442');
INSERT INTO `operation_log` VALUES ('286', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298466');
INSERT INTO `operation_log` VALUES ('287', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298472');
INSERT INTO `operation_log` VALUES ('288', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298474');
INSERT INTO `operation_log` VALUES ('289', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298475');
INSERT INTO `operation_log` VALUES ('290', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298484');
INSERT INTO `operation_log` VALUES ('291', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298485');
INSERT INTO `operation_log` VALUES ('292', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298487');
INSERT INTO `operation_log` VALUES ('293', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298493');
INSERT INTO `operation_log` VALUES ('294', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298504');
INSERT INTO `operation_log` VALUES ('295', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298506');
INSERT INTO `operation_log` VALUES ('296', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298509');
INSERT INTO `operation_log` VALUES ('297', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298512');
INSERT INTO `operation_log` VALUES ('298', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298522');
INSERT INTO `operation_log` VALUES ('299', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298576');
INSERT INTO `operation_log` VALUES ('300', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298578');
INSERT INTO `operation_log` VALUES ('301', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298583');
INSERT INTO `operation_log` VALUES ('302', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298602');
INSERT INTO `operation_log` VALUES ('303', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298608');
INSERT INTO `operation_log` VALUES ('304', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298613');
INSERT INTO `operation_log` VALUES ('305', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298614');
INSERT INTO `operation_log` VALUES ('306', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298616');
INSERT INTO `operation_log` VALUES ('307', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298620');
INSERT INTO `operation_log` VALUES ('308', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298623');
INSERT INTO `operation_log` VALUES ('309', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298628');
INSERT INTO `operation_log` VALUES ('310', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298631');
INSERT INTO `operation_log` VALUES ('311', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298718');
INSERT INTO `operation_log` VALUES ('312', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298720');
INSERT INTO `operation_log` VALUES ('313', '1', '/mobile/login/login', '127.0.0.1', '1721298728');
INSERT INTO `operation_log` VALUES ('314', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721298729');
INSERT INTO `operation_log` VALUES ('315', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721352577');
INSERT INTO `operation_log` VALUES ('316', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721352670');
INSERT INTO `operation_log` VALUES ('317', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721352717');
INSERT INTO `operation_log` VALUES ('318', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721352718');
INSERT INTO `operation_log` VALUES ('319', '1', '/desktop/system.user.detail/init', '127.0.0.1', '1721352721');
INSERT INTO `operation_log` VALUES ('320', '1', '/desktop/system.user.detail/init', '127.0.0.1', '1721352724');
INSERT INTO `operation_log` VALUES ('321', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1721352898');
INSERT INTO `operation_log` VALUES ('322', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1721352899');
INSERT INTO `operation_log` VALUES ('323', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721352904');
INSERT INTO `operation_log` VALUES ('324', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721352905');
INSERT INTO `operation_log` VALUES ('325', '1', '/desktop/system.config.index/init', '127.0.0.1', '1721352906');
INSERT INTO `operation_log` VALUES ('326', '1', '/desktop/system.config.index/init', '127.0.0.1', '1721352910');
INSERT INTO `operation_log` VALUES ('327', '1', '/desktop/system.user.index/init', '127.0.0.1', '1721352913');
INSERT INTO `operation_log` VALUES ('328', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1721352913');
INSERT INTO `operation_log` VALUES ('329', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1721352915');
INSERT INTO `operation_log` VALUES ('330', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1721352917');
INSERT INTO `operation_log` VALUES ('331', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1721352920');
INSERT INTO `operation_log` VALUES ('332', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1721352922');
INSERT INTO `operation_log` VALUES ('333', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721352927');
INSERT INTO `operation_log` VALUES ('334', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721353416');
INSERT INTO `operation_log` VALUES ('335', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721353905');
INSERT INTO `operation_log` VALUES ('336', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721354323');
INSERT INTO `operation_log` VALUES ('337', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721354384');
INSERT INTO `operation_log` VALUES ('338', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721354577');
INSERT INTO `operation_log` VALUES ('339', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721354799');
INSERT INTO `operation_log` VALUES ('340', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721354810');
INSERT INTO `operation_log` VALUES ('341', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721354865');
INSERT INTO `operation_log` VALUES ('342', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721354951');
INSERT INTO `operation_log` VALUES ('343', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355079');
INSERT INTO `operation_log` VALUES ('344', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355079');
INSERT INTO `operation_log` VALUES ('345', '1', '/mobile/login/login', '127.0.0.1', '1721355327');
INSERT INTO `operation_log` VALUES ('346', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355327');
INSERT INTO `operation_log` VALUES ('347', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355362');
INSERT INTO `operation_log` VALUES ('348', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355741');
INSERT INTO `operation_log` VALUES ('349', '1', '/mobile/index/init', '127.0.0.1', '1721355777');
INSERT INTO `operation_log` VALUES ('350', '1', '/mobile/index/init', '127.0.0.1', '1721355777');
INSERT INTO `operation_log` VALUES ('351', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355780');
INSERT INTO `operation_log` VALUES ('352', '1', '/mobile/index/init', '127.0.0.1', '1721355780');
INSERT INTO `operation_log` VALUES ('353', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355816');
INSERT INTO `operation_log` VALUES ('354', '1', '/mobile/index/init', '127.0.0.1', '1721355817');
INSERT INTO `operation_log` VALUES ('355', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355863');
INSERT INTO `operation_log` VALUES ('356', '1', '/mobile/index/init', '127.0.0.1', '1721355863');
INSERT INTO `operation_log` VALUES ('357', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355912');
INSERT INTO `operation_log` VALUES ('358', '1', '/mobile/index/init', '127.0.0.1', '1721355913');
INSERT INTO `operation_log` VALUES ('359', '1', '/mobile/index/init', '127.0.0.1', '1721355913');
INSERT INTO `operation_log` VALUES ('360', '1', '/mobile/index/init', '127.0.0.1', '1721355925');
INSERT INTO `operation_log` VALUES ('361', '1', '/mobile/index/init', '127.0.0.1', '1721355925');
INSERT INTO `operation_log` VALUES ('362', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721355976');
INSERT INTO `operation_log` VALUES ('363', '1', '/mobile/index/init', '127.0.0.1', '1721355976');
INSERT INTO `operation_log` VALUES ('364', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356040');
INSERT INTO `operation_log` VALUES ('365', '1', '/mobile/index/init', '127.0.0.1', '1721356040');
INSERT INTO `operation_log` VALUES ('366', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356049');
INSERT INTO `operation_log` VALUES ('367', '1', '/mobile/index/init', '127.0.0.1', '1721356049');
INSERT INTO `operation_log` VALUES ('368', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356111');
INSERT INTO `operation_log` VALUES ('369', '1', '/mobile/index/init', '127.0.0.1', '1721356111');
INSERT INTO `operation_log` VALUES ('370', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356116');
INSERT INTO `operation_log` VALUES ('371', '1', '/mobile/index/init', '127.0.0.1', '1721356116');
INSERT INTO `operation_log` VALUES ('372', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356250');
INSERT INTO `operation_log` VALUES ('373', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356251');
INSERT INTO `operation_log` VALUES ('374', '1', '/mobile/index/init', '127.0.0.1', '1721356251');
INSERT INTO `operation_log` VALUES ('375', '1', '/mobile/index/init', '127.0.0.1', '1721356251');
INSERT INTO `operation_log` VALUES ('376', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356256');
INSERT INTO `operation_log` VALUES ('377', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356256');
INSERT INTO `operation_log` VALUES ('378', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356260');
INSERT INTO `operation_log` VALUES ('379', '1', '/mobile/index/init', '127.0.0.1', '1721356260');
INSERT INTO `operation_log` VALUES ('380', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356261');
INSERT INTO `operation_log` VALUES ('381', '1', '/mobile/index/init', '127.0.0.1', '1721356262');
INSERT INTO `operation_log` VALUES ('382', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356266');
INSERT INTO `operation_log` VALUES ('383', '1', '/mobile/index/init', '127.0.0.1', '1721356266');
INSERT INTO `operation_log` VALUES ('384', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356267');
INSERT INTO `operation_log` VALUES ('385', '1', '/mobile/index/init', '127.0.0.1', '1721356267');
INSERT INTO `operation_log` VALUES ('386', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356280');
INSERT INTO `operation_log` VALUES ('387', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356280');
INSERT INTO `operation_log` VALUES ('388', '1', '/mobile/index/init', '127.0.0.1', '1721356280');
INSERT INTO `operation_log` VALUES ('389', '1', '/mobile/index/init', '127.0.0.1', '1721356280');
INSERT INTO `operation_log` VALUES ('390', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356288');
INSERT INTO `operation_log` VALUES ('391', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356288');
INSERT INTO `operation_log` VALUES ('392', '1', '/mobile/index/init', '127.0.0.1', '1721356288');
INSERT INTO `operation_log` VALUES ('393', '1', '/mobile/index/init', '127.0.0.1', '1721356289');
INSERT INTO `operation_log` VALUES ('394', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356293');
INSERT INTO `operation_log` VALUES ('395', '1', '/mobile/index/init', '127.0.0.1', '1721356293');
INSERT INTO `operation_log` VALUES ('396', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356293');
INSERT INTO `operation_log` VALUES ('397', '1', '/mobile/index/init', '127.0.0.1', '1721356294');
INSERT INTO `operation_log` VALUES ('398', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356307');
INSERT INTO `operation_log` VALUES ('399', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356307');
INSERT INTO `operation_log` VALUES ('400', '1', '/mobile/index/init', '127.0.0.1', '1721356308');
INSERT INTO `operation_log` VALUES ('401', '1', '/mobile/index/init', '127.0.0.1', '1721356308');
INSERT INTO `operation_log` VALUES ('402', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356315');
INSERT INTO `operation_log` VALUES ('403', '1', '/mobile/index/init', '127.0.0.1', '1721356315');
INSERT INTO `operation_log` VALUES ('404', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356315');
INSERT INTO `operation_log` VALUES ('405', '1', '/mobile/index/init', '127.0.0.1', '1721356316');
INSERT INTO `operation_log` VALUES ('406', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356320');
INSERT INTO `operation_log` VALUES ('407', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356320');
INSERT INTO `operation_log` VALUES ('408', '1', '/mobile/index/init', '127.0.0.1', '1721356321');
INSERT INTO `operation_log` VALUES ('409', '1', '/mobile/index/init', '127.0.0.1', '1721356321');
INSERT INTO `operation_log` VALUES ('410', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356328');
INSERT INTO `operation_log` VALUES ('411', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356328');
INSERT INTO `operation_log` VALUES ('412', '1', '/mobile/index/init', '127.0.0.1', '1721356329');
INSERT INTO `operation_log` VALUES ('413', '1', '/mobile/index/init', '127.0.0.1', '1721356329');
INSERT INTO `operation_log` VALUES ('414', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356709');
INSERT INTO `operation_log` VALUES ('415', '1', '/mobile/index/init', '127.0.0.1', '1721356710');
INSERT INTO `operation_log` VALUES ('416', '1', '/mobile/index/init', '127.0.0.1', '1721356714');
INSERT INTO `operation_log` VALUES ('417', '1', '/mobile/index/init', '127.0.0.1', '1721356717');
INSERT INTO `operation_log` VALUES ('418', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356791');
INSERT INTO `operation_log` VALUES ('419', '1', '/mobile/index/init', '127.0.0.1', '1721356792');
INSERT INTO `operation_log` VALUES ('420', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356841');
INSERT INTO `operation_log` VALUES ('421', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721356842');
INSERT INTO `operation_log` VALUES ('422', '1', '/mobile/index/init', '127.0.0.1', '1721356843');
INSERT INTO `operation_log` VALUES ('423', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721357011');
INSERT INTO `operation_log` VALUES ('424', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721357195');
INSERT INTO `operation_log` VALUES ('425', '1', '/mobile/index/init', '127.0.0.1', '1721357196');
INSERT INTO `operation_log` VALUES ('426', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721357299');
INSERT INTO `operation_log` VALUES ('427', '1', '/mobile/index/init', '127.0.0.1', '1721357299');
INSERT INTO `operation_log` VALUES ('428', '1', '/mobile/index/init', '127.0.0.1', '1721357302');
INSERT INTO `operation_log` VALUES ('429', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721357305');
INSERT INTO `operation_log` VALUES ('430', '1', '/mobile/index/init', '127.0.0.1', '1721357306');
INSERT INTO `operation_log` VALUES ('431', '1', '/mobile/index/init', '127.0.0.1', '1721357410');
INSERT INTO `operation_log` VALUES ('432', '1', '/mobile/index/init', '127.0.0.1', '1721357415');
INSERT INTO `operation_log` VALUES ('433', '1', '/mobile/index/init', '127.0.0.1', '1721357421');
INSERT INTO `operation_log` VALUES ('434', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721358500');
INSERT INTO `operation_log` VALUES ('435', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721359840');
INSERT INTO `operation_log` VALUES ('436', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721359843');
INSERT INTO `operation_log` VALUES ('437', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721359912');
INSERT INTO `operation_log` VALUES ('438', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721359914');
INSERT INTO `operation_log` VALUES ('439', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721359984');
INSERT INTO `operation_log` VALUES ('440', '1', '/mobile/index/init', '127.0.0.1', '1721359984');
INSERT INTO `operation_log` VALUES ('441', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360021');
INSERT INTO `operation_log` VALUES ('442', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360049');
INSERT INTO `operation_log` VALUES ('443', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360066');
INSERT INTO `operation_log` VALUES ('444', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360089');
INSERT INTO `operation_log` VALUES ('445', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360089');
INSERT INTO `operation_log` VALUES ('446', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721360170');
INSERT INTO `operation_log` VALUES ('447', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721360235');
INSERT INTO `operation_log` VALUES ('448', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360261');
INSERT INTO `operation_log` VALUES ('449', '1', '/mobile/index/init', '127.0.0.1', '1721360261');
INSERT INTO `operation_log` VALUES ('450', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360263');
INSERT INTO `operation_log` VALUES ('451', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360285');
INSERT INTO `operation_log` VALUES ('452', '1', '/mobile/index/init', '127.0.0.1', '1721360286');
INSERT INTO `operation_log` VALUES ('453', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360298');
INSERT INTO `operation_log` VALUES ('454', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721360301');
INSERT INTO `operation_log` VALUES ('455', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360331');
INSERT INTO `operation_log` VALUES ('456', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360350');
INSERT INTO `operation_log` VALUES ('457', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721360354');
INSERT INTO `operation_log` VALUES ('458', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360358');
INSERT INTO `operation_log` VALUES ('459', '1', '/mobile/index/init', '127.0.0.1', '1721360358');
INSERT INTO `operation_log` VALUES ('460', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360360');
INSERT INTO `operation_log` VALUES ('461', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721360369');
INSERT INTO `operation_log` VALUES ('462', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360399');
INSERT INTO `operation_log` VALUES ('463', '1', '/mobile/index/init', '127.0.0.1', '1721360400');
INSERT INTO `operation_log` VALUES ('464', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360434');
INSERT INTO `operation_log` VALUES ('465', '1', '/mobile/index/init', '127.0.0.1', '1721360434');
INSERT INTO `operation_log` VALUES ('466', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360438');
INSERT INTO `operation_log` VALUES ('467', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360457');
INSERT INTO `operation_log` VALUES ('468', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360457');
INSERT INTO `operation_log` VALUES ('469', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360457');
INSERT INTO `operation_log` VALUES ('470', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360457');
INSERT INTO `operation_log` VALUES ('471', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360458');
INSERT INTO `operation_log` VALUES ('472', '1', '/mobile/index/init', '127.0.0.1', '1721360458');
INSERT INTO `operation_log` VALUES ('473', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360466');
INSERT INTO `operation_log` VALUES ('474', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360467');
INSERT INTO `operation_log` VALUES ('475', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360467');
INSERT INTO `operation_log` VALUES ('476', '1', '/mobile/index/init', '127.0.0.1', '1721360467');
INSERT INTO `operation_log` VALUES ('477', '1', '/mobile/index/init', '127.0.0.1', '1721360474');
INSERT INTO `operation_log` VALUES ('478', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360476');
INSERT INTO `operation_log` VALUES ('479', '1', '/mobile/index/init', '127.0.0.1', '1721360479');
INSERT INTO `operation_log` VALUES ('480', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360517');
INSERT INTO `operation_log` VALUES ('481', '1', '/mobile/index/init', '127.0.0.1', '1721360522');
INSERT INTO `operation_log` VALUES ('482', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360523');
INSERT INTO `operation_log` VALUES ('483', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721360542');
INSERT INTO `operation_log` VALUES ('484', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360564');
INSERT INTO `operation_log` VALUES ('485', '1', '/mobile/index/init', '127.0.0.1', '1721360564');
INSERT INTO `operation_log` VALUES ('486', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360683');
INSERT INTO `operation_log` VALUES ('487', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721360686');
INSERT INTO `operation_log` VALUES ('488', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721360709');
INSERT INTO `operation_log` VALUES ('489', '1', '/mobile/index/init', '127.0.0.1', '1721360710');
INSERT INTO `operation_log` VALUES ('490', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721360712');
INSERT INTO `operation_log` VALUES ('491', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721360733');
INSERT INTO `operation_log` VALUES ('492', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721366110');
INSERT INTO `operation_log` VALUES ('493', '1', '/mobile/index/init', '127.0.0.1', '1721366110');
INSERT INTO `operation_log` VALUES ('494', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721366114');
INSERT INTO `operation_log` VALUES ('495', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721366118');
INSERT INTO `operation_log` VALUES ('496', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721366120');
INSERT INTO `operation_log` VALUES ('497', '1', '/mobile/index/init', '127.0.0.1', '1721366120');
INSERT INTO `operation_log` VALUES ('498', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721366562');
INSERT INTO `operation_log` VALUES ('499', '1', '/mobile/index/init', '127.0.0.1', '1721366563');
INSERT INTO `operation_log` VALUES ('500', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721366615');
INSERT INTO `operation_log` VALUES ('501', '1', '/mobile/index/init', '127.0.0.1', '1721366616');
INSERT INTO `operation_log` VALUES ('502', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721366684');
INSERT INTO `operation_log` VALUES ('503', '1', '/mobile/index/init', '127.0.0.1', '1721366685');
INSERT INTO `operation_log` VALUES ('504', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721366893');
INSERT INTO `operation_log` VALUES ('505', '1', '/mobile/index/init', '127.0.0.1', '1721366893');
INSERT INTO `operation_log` VALUES ('506', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721367212');
INSERT INTO `operation_log` VALUES ('507', '1', '/mobile/index/init', '127.0.0.1', '1721367216');
INSERT INTO `operation_log` VALUES ('508', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721367273');
INSERT INTO `operation_log` VALUES ('509', '1', '/mobile/index/init', '127.0.0.1', '1721367275');
INSERT INTO `operation_log` VALUES ('510', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721367281');
INSERT INTO `operation_log` VALUES ('511', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721368067');
INSERT INTO `operation_log` VALUES ('512', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368067');
INSERT INTO `operation_log` VALUES ('513', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721368188');
INSERT INTO `operation_log` VALUES ('514', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368189');
INSERT INTO `operation_log` VALUES ('515', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721368291');
INSERT INTO `operation_log` VALUES ('516', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368291');
INSERT INTO `operation_log` VALUES ('517', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368403');
INSERT INTO `operation_log` VALUES ('518', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721368542');
INSERT INTO `operation_log` VALUES ('519', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368543');
INSERT INTO `operation_log` VALUES ('520', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368569');
INSERT INTO `operation_log` VALUES ('521', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368577');
INSERT INTO `operation_log` VALUES ('522', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368581');
INSERT INTO `operation_log` VALUES ('523', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721368586');
INSERT INTO `operation_log` VALUES ('524', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368586');
INSERT INTO `operation_log` VALUES ('525', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721368604');
INSERT INTO `operation_log` VALUES ('526', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369219');
INSERT INTO `operation_log` VALUES ('527', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721369220');
INSERT INTO `operation_log` VALUES ('528', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369221');
INSERT INTO `operation_log` VALUES ('529', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721369310');
INSERT INTO `operation_log` VALUES ('530', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721369341');
INSERT INTO `operation_log` VALUES ('531', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369342');
INSERT INTO `operation_log` VALUES ('532', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369400');
INSERT INTO `operation_log` VALUES ('533', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369458');
INSERT INTO `operation_log` VALUES ('534', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369476');
INSERT INTO `operation_log` VALUES ('535', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369485');
INSERT INTO `operation_log` VALUES ('536', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369503');
INSERT INTO `operation_log` VALUES ('537', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369554');
INSERT INTO `operation_log` VALUES ('538', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369636');
INSERT INTO `operation_log` VALUES ('539', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369653');
INSERT INTO `operation_log` VALUES ('540', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369661');
INSERT INTO `operation_log` VALUES ('541', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369711');
INSERT INTO `operation_log` VALUES ('542', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369738');
INSERT INTO `operation_log` VALUES ('543', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369849');
INSERT INTO `operation_log` VALUES ('544', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369895');
INSERT INTO `operation_log` VALUES ('545', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369897');
INSERT INTO `operation_log` VALUES ('546', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369919');
INSERT INTO `operation_log` VALUES ('547', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369925');
INSERT INTO `operation_log` VALUES ('548', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369941');
INSERT INTO `operation_log` VALUES ('549', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369982');
INSERT INTO `operation_log` VALUES ('550', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721369998');
INSERT INTO `operation_log` VALUES ('551', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370008');
INSERT INTO `operation_log` VALUES ('552', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370022');
INSERT INTO `operation_log` VALUES ('553', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370072');
INSERT INTO `operation_log` VALUES ('554', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370210');
INSERT INTO `operation_log` VALUES ('555', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370217');
INSERT INTO `operation_log` VALUES ('556', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721370292');
INSERT INTO `operation_log` VALUES ('557', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370292');
INSERT INTO `operation_log` VALUES ('558', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370328');
INSERT INTO `operation_log` VALUES ('559', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370353');
INSERT INTO `operation_log` VALUES ('560', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370371');
INSERT INTO `operation_log` VALUES ('561', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370391');
INSERT INTO `operation_log` VALUES ('562', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721370406');
INSERT INTO `operation_log` VALUES ('563', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370493');
INSERT INTO `operation_log` VALUES ('564', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370496');
INSERT INTO `operation_log` VALUES ('565', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370501');
INSERT INTO `operation_log` VALUES ('566', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721370713');
INSERT INTO `operation_log` VALUES ('567', '1', '/mobile/index/init', '127.0.0.1', '1721370714');
INSERT INTO `operation_log` VALUES ('568', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370719');
INSERT INTO `operation_log` VALUES ('569', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721370724');
INSERT INTO `operation_log` VALUES ('570', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370725');
INSERT INTO `operation_log` VALUES ('571', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370826');
INSERT INTO `operation_log` VALUES ('572', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370827');
INSERT INTO `operation_log` VALUES ('573', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721370932');
INSERT INTO `operation_log` VALUES ('574', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370932');
INSERT INTO `operation_log` VALUES ('575', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721370949');
INSERT INTO `operation_log` VALUES ('576', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370950');
INSERT INTO `operation_log` VALUES ('577', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721370950');
INSERT INTO `operation_log` VALUES ('578', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370951');
INSERT INTO `operation_log` VALUES ('579', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721370960');
INSERT INTO `operation_log` VALUES ('580', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721370960');
INSERT INTO `operation_log` VALUES ('581', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721371191');
INSERT INTO `operation_log` VALUES ('582', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371192');
INSERT INTO `operation_log` VALUES ('583', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721371211');
INSERT INTO `operation_log` VALUES ('584', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371211');
INSERT INTO `operation_log` VALUES ('585', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721371237');
INSERT INTO `operation_log` VALUES ('586', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371237');
INSERT INTO `operation_log` VALUES ('587', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721371253');
INSERT INTO `operation_log` VALUES ('588', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371254');
INSERT INTO `operation_log` VALUES ('589', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721371265');
INSERT INTO `operation_log` VALUES ('590', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371265');
INSERT INTO `operation_log` VALUES ('591', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721371278');
INSERT INTO `operation_log` VALUES ('592', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371278');
INSERT INTO `operation_log` VALUES ('593', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371338');
INSERT INTO `operation_log` VALUES ('594', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371338');
INSERT INTO `operation_log` VALUES ('595', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371352');
INSERT INTO `operation_log` VALUES ('596', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371352');
INSERT INTO `operation_log` VALUES ('597', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371560');
INSERT INTO `operation_log` VALUES ('598', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371561');
INSERT INTO `operation_log` VALUES ('599', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371668');
INSERT INTO `operation_log` VALUES ('600', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371669');
INSERT INTO `operation_log` VALUES ('601', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371677');
INSERT INTO `operation_log` VALUES ('602', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371678');
INSERT INTO `operation_log` VALUES ('603', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371832');
INSERT INTO `operation_log` VALUES ('604', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371832');
INSERT INTO `operation_log` VALUES ('605', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371840');
INSERT INTO `operation_log` VALUES ('606', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721371840');
INSERT INTO `operation_log` VALUES ('607', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372042');
INSERT INTO `operation_log` VALUES ('608', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372243');
INSERT INTO `operation_log` VALUES ('609', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721372243');
INSERT INTO `operation_log` VALUES ('610', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721372243');
INSERT INTO `operation_log` VALUES ('611', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372263');
INSERT INTO `operation_log` VALUES ('612', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372264');
INSERT INTO `operation_log` VALUES ('613', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372289');
INSERT INTO `operation_log` VALUES ('614', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372289');
INSERT INTO `operation_log` VALUES ('615', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372293');
INSERT INTO `operation_log` VALUES ('616', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372293');
INSERT INTO `operation_log` VALUES ('617', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372420');
INSERT INTO `operation_log` VALUES ('618', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721372421');
INSERT INTO `operation_log` VALUES ('619', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372492');
INSERT INTO `operation_log` VALUES ('620', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721372493');
INSERT INTO `operation_log` VALUES ('621', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372495');
INSERT INTO `operation_log` VALUES ('622', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721372496');
INSERT INTO `operation_log` VALUES ('623', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372503');
INSERT INTO `operation_log` VALUES ('624', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721372503');
INSERT INTO `operation_log` VALUES ('625', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372561');
INSERT INTO `operation_log` VALUES ('626', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721372562');
INSERT INTO `operation_log` VALUES ('627', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721372610');
INSERT INTO `operation_log` VALUES ('628', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721372610');
INSERT INTO `operation_log` VALUES ('629', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721373420');
INSERT INTO `operation_log` VALUES ('630', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721373421');
INSERT INTO `operation_log` VALUES ('631', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721373442');
INSERT INTO `operation_log` VALUES ('632', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721373443');
INSERT INTO `operation_log` VALUES ('633', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721373535');
INSERT INTO `operation_log` VALUES ('634', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721373537');
INSERT INTO `operation_log` VALUES ('635', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721373921');
INSERT INTO `operation_log` VALUES ('636', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721373921');
INSERT INTO `operation_log` VALUES ('637', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721373926');
INSERT INTO `operation_log` VALUES ('638', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721374053');
INSERT INTO `operation_log` VALUES ('639', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374054');
INSERT INTO `operation_log` VALUES ('640', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374058');
INSERT INTO `operation_log` VALUES ('641', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374059');
INSERT INTO `operation_log` VALUES ('642', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374074');
INSERT INTO `operation_log` VALUES ('643', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374074');
INSERT INTO `operation_log` VALUES ('644', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721374093');
INSERT INTO `operation_log` VALUES ('645', '1', '/mobile/index/init', '127.0.0.1', '1721374094');
INSERT INTO `operation_log` VALUES ('646', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374096');
INSERT INTO `operation_log` VALUES ('647', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374111');
INSERT INTO `operation_log` VALUES ('648', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374111');
INSERT INTO `operation_log` VALUES ('649', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374129');
INSERT INTO `operation_log` VALUES ('650', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374131');
INSERT INTO `operation_log` VALUES ('651', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374170');
INSERT INTO `operation_log` VALUES ('652', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374170');
INSERT INTO `operation_log` VALUES ('653', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374211');
INSERT INTO `operation_log` VALUES ('654', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374211');
INSERT INTO `operation_log` VALUES ('655', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721374223');
INSERT INTO `operation_log` VALUES ('656', '1', '/mobile/index/init', '127.0.0.1', '1721374223');
INSERT INTO `operation_log` VALUES ('657', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374225');
INSERT INTO `operation_log` VALUES ('658', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374250');
INSERT INTO `operation_log` VALUES ('659', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374251');
INSERT INTO `operation_log` VALUES ('660', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721374383');
INSERT INTO `operation_log` VALUES ('661', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721374404');
INSERT INTO `operation_log` VALUES ('662', '1', '/mobile/index/init', '127.0.0.1', '1721374405');
INSERT INTO `operation_log` VALUES ('663', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721374409');
INSERT INTO `operation_log` VALUES ('664', '1', '/mobile/index/init', '127.0.0.1', '1721374409');
INSERT INTO `operation_log` VALUES ('665', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374414');
INSERT INTO `operation_log` VALUES ('666', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374440');
INSERT INTO `operation_log` VALUES ('667', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374440');
INSERT INTO `operation_log` VALUES ('668', '1', '/mobile/index/init', '127.0.0.1', '1721374446');
INSERT INTO `operation_log` VALUES ('669', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374449');
INSERT INTO `operation_log` VALUES ('670', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374467');
INSERT INTO `operation_log` VALUES ('671', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374468');
INSERT INTO `operation_log` VALUES ('672', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721374763');
INSERT INTO `operation_log` VALUES ('673', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374763');
INSERT INTO `operation_log` VALUES ('674', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721374800');
INSERT INTO `operation_log` VALUES ('675', '1', '/mobile/index/init', '127.0.0.1', '1721374801');
INSERT INTO `operation_log` VALUES ('676', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374803');
INSERT INTO `operation_log` VALUES ('677', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721374808');
INSERT INTO `operation_log` VALUES ('678', '1', '/mobile/index/init', '127.0.0.1', '1721374809');
INSERT INTO `operation_log` VALUES ('679', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374810');
INSERT INTO `operation_log` VALUES ('680', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721374890');
INSERT INTO `operation_log` VALUES ('681', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721374890');
INSERT INTO `operation_log` VALUES ('682', '1', '/mobile/index/init', '127.0.0.1', '1721374931');
INSERT INTO `operation_log` VALUES ('683', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721374991');
INSERT INTO `operation_log` VALUES ('684', '1', '/mobile/index/init', '127.0.0.1', '1721374992');
INSERT INTO `operation_log` VALUES ('685', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375044');
INSERT INTO `operation_log` VALUES ('686', '1', '/mobile/index/init', '127.0.0.1', '1721375045');
INSERT INTO `operation_log` VALUES ('687', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375072');
INSERT INTO `operation_log` VALUES ('688', '1', '/mobile/index/init', '127.0.0.1', '1721375073');
INSERT INTO `operation_log` VALUES ('689', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375145');
INSERT INTO `operation_log` VALUES ('690', '1', '/mobile/index/init', '127.0.0.1', '1721375146');
INSERT INTO `operation_log` VALUES ('691', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375175');
INSERT INTO `operation_log` VALUES ('692', '1', '/mobile/index/init', '127.0.0.1', '1721375176');
INSERT INTO `operation_log` VALUES ('693', '1', '/mobile/index/init', '127.0.0.1', '1721375283');
INSERT INTO `operation_log` VALUES ('694', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375366');
INSERT INTO `operation_log` VALUES ('695', '1', '/mobile/index/init', '127.0.0.1', '1721375369');
INSERT INTO `operation_log` VALUES ('696', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375425');
INSERT INTO `operation_log` VALUES ('697', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721375428');
INSERT INTO `operation_log` VALUES ('698', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375444');
INSERT INTO `operation_log` VALUES ('699', '1', '/mobile/index/init', '127.0.0.1', '1721375445');
INSERT INTO `operation_log` VALUES ('700', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375482');
INSERT INTO `operation_log` VALUES ('701', '1', '/mobile/index/init', '127.0.0.1', '1721375486');
INSERT INTO `operation_log` VALUES ('702', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375487');
INSERT INTO `operation_log` VALUES ('703', '1', '/mobile/index/init', '127.0.0.1', '1721375489');
INSERT INTO `operation_log` VALUES ('704', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375701');
INSERT INTO `operation_log` VALUES ('705', '1', '/mobile/index/init', '127.0.0.1', '1721375702');
INSERT INTO `operation_log` VALUES ('706', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375704');
INSERT INTO `operation_log` VALUES ('707', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375734');
INSERT INTO `operation_log` VALUES ('708', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375735');
INSERT INTO `operation_log` VALUES ('709', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375743');
INSERT INTO `operation_log` VALUES ('710', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375744');
INSERT INTO `operation_log` VALUES ('711', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375758');
INSERT INTO `operation_log` VALUES ('712', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375765');
INSERT INTO `operation_log` VALUES ('713', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375765');
INSERT INTO `operation_log` VALUES ('714', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375772');
INSERT INTO `operation_log` VALUES ('715', '1', '/mobile/index/init', '127.0.0.1', '1721375773');
INSERT INTO `operation_log` VALUES ('716', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375774');
INSERT INTO `operation_log` VALUES ('717', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721375884');
INSERT INTO `operation_log` VALUES ('718', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721375884');
INSERT INTO `operation_log` VALUES ('719', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376063');
INSERT INTO `operation_log` VALUES ('720', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376064');
INSERT INTO `operation_log` VALUES ('721', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376073');
INSERT INTO `operation_log` VALUES ('722', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376073');
INSERT INTO `operation_log` VALUES ('723', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376117');
INSERT INTO `operation_log` VALUES ('724', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376118');
INSERT INTO `operation_log` VALUES ('725', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376120');
INSERT INTO `operation_log` VALUES ('726', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376120');
INSERT INTO `operation_log` VALUES ('727', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376196');
INSERT INTO `operation_log` VALUES ('728', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376196');
INSERT INTO `operation_log` VALUES ('729', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376216');
INSERT INTO `operation_log` VALUES ('730', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376216');
INSERT INTO `operation_log` VALUES ('731', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721376276');
INSERT INTO `operation_log` VALUES ('732', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376277');
INSERT INTO `operation_log` VALUES ('733', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376397');
INSERT INTO `operation_log` VALUES ('734', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376398');
INSERT INTO `operation_log` VALUES ('735', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376428');
INSERT INTO `operation_log` VALUES ('736', '1', '/mobile/index/init', '127.0.0.1', '1721376429');
INSERT INTO `operation_log` VALUES ('737', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376430');
INSERT INTO `operation_log` VALUES ('738', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376473');
INSERT INTO `operation_log` VALUES ('739', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376474');
INSERT INTO `operation_log` VALUES ('740', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376491');
INSERT INTO `operation_log` VALUES ('741', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376491');
INSERT INTO `operation_log` VALUES ('742', '1', '/mobile/index/init', '127.0.0.1', '1721376492');
INSERT INTO `operation_log` VALUES ('743', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376562');
INSERT INTO `operation_log` VALUES ('744', '1', '/mobile/index/init', '127.0.0.1', '1721376563');
INSERT INTO `operation_log` VALUES ('745', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376565');
INSERT INTO `operation_log` VALUES ('746', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721376601');
INSERT INTO `operation_log` VALUES ('747', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376601');
INSERT INTO `operation_log` VALUES ('748', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376613');
INSERT INTO `operation_log` VALUES ('749', '1', '/mobile/index/init', '127.0.0.1', '1721376613');
INSERT INTO `operation_log` VALUES ('750', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721376620');
INSERT INTO `operation_log` VALUES ('751', '1', '/mobile/my.user.detail/logout', '127.0.0.1', '1721376656');
INSERT INTO `operation_log` VALUES ('752', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721376659');
INSERT INTO `operation_log` VALUES ('753', '1', '/mobile/index/init', '127.0.0.1', '1721376660');
INSERT INTO `operation_log` VALUES ('754', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721380417');
INSERT INTO `operation_log` VALUES ('755', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721380548');
INSERT INTO `operation_log` VALUES ('756', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721380586');
INSERT INTO `operation_log` VALUES ('757', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721380760');
INSERT INTO `operation_log` VALUES ('758', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721380769');
INSERT INTO `operation_log` VALUES ('759', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721380792');
INSERT INTO `operation_log` VALUES ('760', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721381082');
INSERT INTO `operation_log` VALUES ('761', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721381212');
INSERT INTO `operation_log` VALUES ('762', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721381217');
INSERT INTO `operation_log` VALUES ('763', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721381631');
INSERT INTO `operation_log` VALUES ('764', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721381653');
INSERT INTO `operation_log` VALUES ('765', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721381678');
INSERT INTO `operation_log` VALUES ('766', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721381764');
INSERT INTO `operation_log` VALUES ('767', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721381831');
INSERT INTO `operation_log` VALUES ('768', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721381967');
INSERT INTO `operation_log` VALUES ('769', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382032');
INSERT INTO `operation_log` VALUES ('770', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382061');
INSERT INTO `operation_log` VALUES ('771', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382082');
INSERT INTO `operation_log` VALUES ('772', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382137');
INSERT INTO `operation_log` VALUES ('773', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382158');
INSERT INTO `operation_log` VALUES ('774', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382213');
INSERT INTO `operation_log` VALUES ('775', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382291');
INSERT INTO `operation_log` VALUES ('776', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382622');
INSERT INTO `operation_log` VALUES ('777', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721382700');
INSERT INTO `operation_log` VALUES ('778', '1', '/mobile/index/init', '127.0.0.1', '1721382701');
INSERT INTO `operation_log` VALUES ('779', '1', '/mobile/frame/getpermissions', '127.0.0.1', '1721382721');
INSERT INTO `operation_log` VALUES ('780', '1', '/mobile/index/init', '127.0.0.1', '1721382721');
INSERT INTO `operation_log` VALUES ('781', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721382724');
INSERT INTO `operation_log` VALUES ('782', '1', '/mobile/my.user.editavatar/save', '127.0.0.1', '1721382734');
INSERT INTO `operation_log` VALUES ('783', '1', '/mobile/my.user.detail/init', '127.0.0.1', '1721382735');
INSERT INTO `operation_log` VALUES ('784', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382757');
INSERT INTO `operation_log` VALUES ('785', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721382950');
INSERT INTO `operation_log` VALUES ('786', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721383478');
INSERT INTO `operation_log` VALUES ('787', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721383553');
INSERT INTO `operation_log` VALUES ('788', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721384127');
INSERT INTO `operation_log` VALUES ('789', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721384196');
INSERT INTO `operation_log` VALUES ('790', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721384269');
INSERT INTO `operation_log` VALUES ('791', '1', '/mobile/uploadfile/upload', '127.0.0.1', '1721384285');
INSERT INTO `operation_log` VALUES ('792', '1', '/desktop/system.config.index/init', '127.0.0.1', '1722840617');
INSERT INTO `operation_log` VALUES ('793', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1722840622');
INSERT INTO `operation_log` VALUES ('794', '1', '/desktop/system.desktop.route.add/init', '127.0.0.1', '1722840624');
INSERT INTO `operation_log` VALUES ('795', '1', '/desktop/system.desktop.route.add/init', '127.0.0.1', '1722840655');
INSERT INTO `operation_log` VALUES ('796', '1', '/desktop/system.desktop.route.add/init', '127.0.0.1', '1722840662');
INSERT INTO `operation_log` VALUES ('797', '1', '/desktop/system.desktop.route.add/init', '127.0.0.1', '1722840712');
INSERT INTO `operation_log` VALUES ('798', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1722841055');
INSERT INTO `operation_log` VALUES ('799', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1722841061');
INSERT INTO `operation_log` VALUES ('800', '1', '/desktop/system.desktop.route.add/init', '127.0.0.1', '1722841069');
INSERT INTO `operation_log` VALUES ('801', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1722841078');
INSERT INTO `operation_log` VALUES ('802', '1', '/desktop/system.dictionary.edit/init', '127.0.0.1', '1722841083');
INSERT INTO `operation_log` VALUES ('803', '1', '/desktop/system.dictionary.edit/save', '127.0.0.1', '1722841092');
INSERT INTO `operation_log` VALUES ('804', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1722841092');
INSERT INTO `operation_log` VALUES ('805', '1', '/desktop/system.dictionary.edit/init', '127.0.0.1', '1722841095');
INSERT INTO `operation_log` VALUES ('806', '1', '/desktop/system.dictionary.edit/save', '127.0.0.1', '1722841099');
INSERT INTO `operation_log` VALUES ('807', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1722841100');
INSERT INTO `operation_log` VALUES ('808', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1722841151');
INSERT INTO `operation_log` VALUES ('809', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1722845544');
INSERT INTO `operation_log` VALUES ('810', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1722845546');
INSERT INTO `operation_log` VALUES ('811', '1', '/desktop/system.config.index/init', '127.0.0.1', '1722845549');
INSERT INTO `operation_log` VALUES ('812', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722845551');
INSERT INTO `operation_log` VALUES ('813', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722845551');
INSERT INTO `operation_log` VALUES ('814', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1722845552');
INSERT INTO `operation_log` VALUES ('815', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1722845553');
INSERT INTO `operation_log` VALUES ('816', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1722845558');
INSERT INTO `operation_log` VALUES ('817', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1722845559');
INSERT INTO `operation_log` VALUES ('818', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1722845560');
INSERT INTO `operation_log` VALUES ('819', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1722845562');
INSERT INTO `operation_log` VALUES ('820', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1722845567');
INSERT INTO `operation_log` VALUES ('821', '1', '/desktop/system.desktop.menu.add/init', '127.0.0.1', '1722845571');
INSERT INTO `operation_log` VALUES ('822', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1722845575');
INSERT INTO `operation_log` VALUES ('823', '1', '/desktop/system.desktop.route.add/init', '127.0.0.1', '1722845577');
INSERT INTO `operation_log` VALUES ('824', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1722845620');
INSERT INTO `operation_log` VALUES ('825', '1', '/desktop/system.config.index/init', '127.0.0.1', '1722845663');
INSERT INTO `operation_log` VALUES ('826', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1722845683');
INSERT INTO `operation_log` VALUES ('827', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1722845684');
INSERT INTO `operation_log` VALUES ('828', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1722845686');
INSERT INTO `operation_log` VALUES ('829', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1722845687');
INSERT INTO `operation_log` VALUES ('830', '1', '/desktop/system.config.index/init', '127.0.0.1', '1722845690');
INSERT INTO `operation_log` VALUES ('831', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1722845692');
INSERT INTO `operation_log` VALUES ('832', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722845693');
INSERT INTO `operation_log` VALUES ('833', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722845694');
INSERT INTO `operation_log` VALUES ('834', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1722845695');
INSERT INTO `operation_log` VALUES ('835', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1722845696');
INSERT INTO `operation_log` VALUES ('836', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1722845699');
INSERT INTO `operation_log` VALUES ('837', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1722845734');
INSERT INTO `operation_log` VALUES ('838', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1722845737');
INSERT INTO `operation_log` VALUES ('839', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1722845739');
INSERT INTO `operation_log` VALUES ('840', '1', '/desktop/system.login_log.index/getloginlogs', '127.0.0.1', '1722845742');
INSERT INTO `operation_log` VALUES ('841', '1', '/desktop/system.operation_log.index/getoperationlogs', '127.0.0.1', '1722845744');
INSERT INTO `operation_log` VALUES ('842', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1722845746');
INSERT INTO `operation_log` VALUES ('843', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1722845760');
INSERT INTO `operation_log` VALUES ('844', '1', '/desktop/system.desktop.route.add/init', '127.0.0.1', '1722845769');
INSERT INTO `operation_log` VALUES ('845', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1722845784');
INSERT INTO `operation_log` VALUES ('846', '1', '/desktop/system.dictionary.edit/init', '127.0.0.1', '1722845788');
INSERT INTO `operation_log` VALUES ('847', '1', '/desktop/system.dictionary.edit/save', '127.0.0.1', '1722845794');
INSERT INTO `operation_log` VALUES ('848', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1722845795');
INSERT INTO `operation_log` VALUES ('849', '1', '/desktop/system.dictionary.edit/init', '127.0.0.1', '1722845798');
INSERT INTO `operation_log` VALUES ('850', '1', '/desktop/system.dictionary.edit/save', '127.0.0.1', '1722845804');
INSERT INTO `operation_log` VALUES ('851', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1722845805');
INSERT INTO `operation_log` VALUES ('852', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1722845850');
INSERT INTO `operation_log` VALUES ('853', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1722845853');
INSERT INTO `operation_log` VALUES ('854', '1', '/desktop/system.config.index/init', '127.0.0.1', '1722845857');
INSERT INTO `operation_log` VALUES ('855', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722845859');
INSERT INTO `operation_log` VALUES ('856', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722845860');
INSERT INTO `operation_log` VALUES ('857', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1722845861');
INSERT INTO `operation_log` VALUES ('858', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1722845862');
INSERT INTO `operation_log` VALUES ('859', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1722845866');
INSERT INTO `operation_log` VALUES ('860', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1722845875');
INSERT INTO `operation_log` VALUES ('861', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1722845879');
INSERT INTO `operation_log` VALUES ('862', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1722845882');
INSERT INTO `operation_log` VALUES ('863', '1', '/desktop/system.login_log.index/getloginlogs', '127.0.0.1', '1722845883');
INSERT INTO `operation_log` VALUES ('864', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1722845893');
INSERT INTO `operation_log` VALUES ('865', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1722845905');
INSERT INTO `operation_log` VALUES ('866', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1722845909');
INSERT INTO `operation_log` VALUES ('867', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1722845990');
INSERT INTO `operation_log` VALUES ('868', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1722847557');
INSERT INTO `operation_log` VALUES ('869', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1722847563');
INSERT INTO `operation_log` VALUES ('870', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1722847569');
INSERT INTO `operation_log` VALUES ('871', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1722847576');
INSERT INTO `operation_log` VALUES ('872', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1722847584');
INSERT INTO `operation_log` VALUES ('873', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1722847609');
INSERT INTO `operation_log` VALUES ('874', '1', '/desktop/system.config.index/init', '127.0.0.1', '1722847615');
INSERT INTO `operation_log` VALUES ('875', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722847618');
INSERT INTO `operation_log` VALUES ('876', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722847619');
INSERT INTO `operation_log` VALUES ('877', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1722847622');
INSERT INTO `operation_log` VALUES ('878', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1722847632');
INSERT INTO `operation_log` VALUES ('879', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1722847636');
INSERT INTO `operation_log` VALUES ('880', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1722847638');
INSERT INTO `operation_log` VALUES ('881', '1', '/desktop/system.desktop.route.add/init', '127.0.0.1', '1722847642');
INSERT INTO `operation_log` VALUES ('882', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1722848046');
INSERT INTO `operation_log` VALUES ('883', '1', '/desktop/system.role.edit/init', '127.0.0.1', '1722848048');
INSERT INTO `operation_log` VALUES ('884', '1', '/desktop/system.role.edit/init', '127.0.0.1', '1722848138');
INSERT INTO `operation_log` VALUES ('885', '1', '/desktop/system.role.edit/init', '127.0.0.1', '1722848146');
INSERT INTO `operation_log` VALUES ('886', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722849283');
INSERT INTO `operation_log` VALUES ('887', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722849284');
INSERT INTO `operation_log` VALUES ('888', '1', '/desktop/system.user.edit/init', '127.0.0.1', '1722849435');
INSERT INTO `operation_log` VALUES ('889', '1', '/desktop/system.user.detail/init', '127.0.0.1', '1722849445');
INSERT INTO `operation_log` VALUES ('890', '1', '/desktop/system.user.detail/init', '127.0.0.1', '1722849466');
INSERT INTO `operation_log` VALUES ('891', '1', '/desktop/system.user.detail/init', '127.0.0.1', '1722849589');
INSERT INTO `operation_log` VALUES ('892', '1', '/desktop/system.config.index/init', '127.0.0.1', '1722849719');
INSERT INTO `operation_log` VALUES ('893', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722849722');
INSERT INTO `operation_log` VALUES ('894', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722849723');
INSERT INTO `operation_log` VALUES ('895', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722850902');
INSERT INTO `operation_log` VALUES ('896', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722850903');
INSERT INTO `operation_log` VALUES ('897', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722851039');
INSERT INTO `operation_log` VALUES ('898', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722851040');
INSERT INTO `operation_log` VALUES ('899', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722851129');
INSERT INTO `operation_log` VALUES ('900', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722851130');
INSERT INTO `operation_log` VALUES ('901', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722851199');
INSERT INTO `operation_log` VALUES ('902', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722851199');
INSERT INTO `operation_log` VALUES ('903', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722851256');
INSERT INTO `operation_log` VALUES ('904', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722851256');
INSERT INTO `operation_log` VALUES ('905', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722851700');
INSERT INTO `operation_log` VALUES ('906', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722851700');
INSERT INTO `operation_log` VALUES ('907', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722851705');
INSERT INTO `operation_log` VALUES ('908', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722851705');
INSERT INTO `operation_log` VALUES ('909', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722851902');
INSERT INTO `operation_log` VALUES ('910', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722851903');
INSERT INTO `operation_log` VALUES ('911', '1', '/desktop/system.user.index/init', '127.0.0.1', '1722852088');
INSERT INTO `operation_log` VALUES ('912', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1722852089');
INSERT INTO `operation_log` VALUES ('913', '1', '/desktop/system.config.index/init', '127.0.0.1', '1723000011');
INSERT INTO `operation_log` VALUES ('914', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723000109');
INSERT INTO `operation_log` VALUES ('915', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723000116');
INSERT INTO `operation_log` VALUES ('916', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723000194');
INSERT INTO `operation_log` VALUES ('917', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723000202');
INSERT INTO `operation_log` VALUES ('918', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723000241');
INSERT INTO `operation_log` VALUES ('919', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1723000245');
INSERT INTO `operation_log` VALUES ('920', '1', '/desktop/system.dictionary.edit/init', '127.0.0.1', '1723000248');
INSERT INTO `operation_log` VALUES ('921', '1', '/desktop/system.dictionary.edit/save', '127.0.0.1', '1723000273');
INSERT INTO `operation_log` VALUES ('922', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1723000273');
INSERT INTO `operation_log` VALUES ('923', '1', '/desktop/system.dictionary.edit/init', '127.0.0.1', '1723000277');
INSERT INTO `operation_log` VALUES ('924', '1', '/desktop/system.dictionary.edit/save', '127.0.0.1', '1723000283');
INSERT INTO `operation_log` VALUES ('925', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1723000284');
INSERT INTO `operation_log` VALUES ('926', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723000288');
INSERT INTO `operation_log` VALUES ('927', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723000413');
INSERT INTO `operation_log` VALUES ('928', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723002731');
INSERT INTO `operation_log` VALUES ('929', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723002807');
INSERT INTO `operation_log` VALUES ('930', '1', '/desktop/system.desktop.menu.add/init', '127.0.0.1', '1723002906');
INSERT INTO `operation_log` VALUES ('931', '1', '/desktop/system.desktop.menu.edit/init', '127.0.0.1', '1723002916');
INSERT INTO `operation_log` VALUES ('932', '1', '/desktop/system.desktop.menu.edit/init', '127.0.0.1', '1723002921');
INSERT INTO `operation_log` VALUES ('933', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723002944');
INSERT INTO `operation_log` VALUES ('934', '1', '/desktop/system.desktop.route.edit/init', '127.0.0.1', '1723002985');
INSERT INTO `operation_log` VALUES ('935', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723003152');
INSERT INTO `operation_log` VALUES ('936', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723003835');
INSERT INTO `operation_log` VALUES ('937', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723003836');
INSERT INTO `operation_log` VALUES ('938', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723003839');
INSERT INTO `operation_log` VALUES ('939', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1723003841');
INSERT INTO `operation_log` VALUES ('940', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723003844');
INSERT INTO `operation_log` VALUES ('941', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1723003847');
INSERT INTO `operation_log` VALUES ('942', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723003848');
INSERT INTO `operation_log` VALUES ('943', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1723008872');
INSERT INTO `operation_log` VALUES ('944', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1723009167');
INSERT INTO `operation_log` VALUES ('945', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1723009181');
INSERT INTO `operation_log` VALUES ('946', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723009197');
INSERT INTO `operation_log` VALUES ('947', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1723009206');
INSERT INTO `operation_log` VALUES ('948', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723009210');
INSERT INTO `operation_log` VALUES ('949', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723010783');
INSERT INTO `operation_log` VALUES ('950', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723010849');
INSERT INTO `operation_log` VALUES ('951', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723011289');
INSERT INTO `operation_log` VALUES ('952', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723011389');
INSERT INTO `operation_log` VALUES ('953', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723011398');
INSERT INTO `operation_log` VALUES ('954', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723011667');
INSERT INTO `operation_log` VALUES ('955', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723011670');
INSERT INTO `operation_log` VALUES ('956', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723011674');
INSERT INTO `operation_log` VALUES ('957', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723013181');
INSERT INTO `operation_log` VALUES ('958', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723013548');
INSERT INTO `operation_log` VALUES ('959', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723014278');
INSERT INTO `operation_log` VALUES ('960', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723014401');
INSERT INTO `operation_log` VALUES ('961', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723015806');
INSERT INTO `operation_log` VALUES ('962', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723015941');
INSERT INTO `operation_log` VALUES ('963', '1', '/desktop/system.config.index/init', '127.0.0.1', '1723016884');
INSERT INTO `operation_log` VALUES ('964', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1723016950');
INSERT INTO `operation_log` VALUES ('965', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1723016953');
INSERT INTO `operation_log` VALUES ('966', '1', '/desktop/system.config.index/init', '127.0.0.1', '1723016956');
INSERT INTO `operation_log` VALUES ('967', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723016957');
INSERT INTO `operation_log` VALUES ('968', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723016958');
INSERT INTO `operation_log` VALUES ('969', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1723016959');
INSERT INTO `operation_log` VALUES ('970', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1723016960');
INSERT INTO `operation_log` VALUES ('971', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723016963');
INSERT INTO `operation_log` VALUES ('972', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1723016964');
INSERT INTO `operation_log` VALUES ('973', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723016966');
INSERT INTO `operation_log` VALUES ('974', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1723016968');
INSERT INTO `operation_log` VALUES ('975', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1723016970');
INSERT INTO `operation_log` VALUES ('976', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723016973');
INSERT INTO `operation_log` VALUES ('977', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1723016976');
INSERT INTO `operation_log` VALUES ('978', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723016989');
INSERT INTO `operation_log` VALUES ('979', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1723017070');
INSERT INTO `operation_log` VALUES ('980', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723017072');
INSERT INTO `operation_log` VALUES ('981', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723017076');
INSERT INTO `operation_log` VALUES ('982', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723017076');
INSERT INTO `operation_log` VALUES ('983', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1723017080');
INSERT INTO `operation_log` VALUES ('984', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1723017082');
INSERT INTO `operation_log` VALUES ('985', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1723017089');
INSERT INTO `operation_log` VALUES ('986', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1723017092');
INSERT INTO `operation_log` VALUES ('987', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723025384');
INSERT INTO `operation_log` VALUES ('988', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723025384');
INSERT INTO `operation_log` VALUES ('989', '1', '/desktop/system.config.index/init', '127.0.0.1', '1723079763');
INSERT INTO `operation_log` VALUES ('990', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723079766');
INSERT INTO `operation_log` VALUES ('991', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723079766');
INSERT INTO `operation_log` VALUES ('992', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723079778');
INSERT INTO `operation_log` VALUES ('993', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723079779');
INSERT INTO `operation_log` VALUES ('994', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723080060');
INSERT INTO `operation_log` VALUES ('995', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723080060');
INSERT INTO `operation_log` VALUES ('996', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723080181');
INSERT INTO `operation_log` VALUES ('997', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723080182');
INSERT INTO `operation_log` VALUES ('998', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723080983');
INSERT INTO `operation_log` VALUES ('999', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723080984');
INSERT INTO `operation_log` VALUES ('1000', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723080988');
INSERT INTO `operation_log` VALUES ('1001', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723080989');
INSERT INTO `operation_log` VALUES ('1002', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723081041');
INSERT INTO `operation_log` VALUES ('1003', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723081042');
INSERT INTO `operation_log` VALUES ('1004', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723081145');
INSERT INTO `operation_log` VALUES ('1005', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723081145');
INSERT INTO `operation_log` VALUES ('1006', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723081191');
INSERT INTO `operation_log` VALUES ('1007', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723081192');
INSERT INTO `operation_log` VALUES ('1008', '1', '/desktop/system.login_log.index/getloginlogs', '127.0.0.1', '1723081195');
INSERT INTO `operation_log` VALUES ('1009', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723081200');
INSERT INTO `operation_log` VALUES ('1010', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723081200');
INSERT INTO `operation_log` VALUES ('1011', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723081241');
INSERT INTO `operation_log` VALUES ('1012', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723081241');
INSERT INTO `operation_log` VALUES ('1013', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723081277');
INSERT INTO `operation_log` VALUES ('1014', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723081277');
INSERT INTO `operation_log` VALUES ('1015', '1', '/desktop/system.user.detail/init', '127.0.0.1', '1723081288');
INSERT INTO `operation_log` VALUES ('1016', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1723081338');
INSERT INTO `operation_log` VALUES ('1017', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1723081341');
INSERT INTO `operation_log` VALUES ('1018', '1', '/desktop/system.config.index/init', '127.0.0.1', '1723081344');
INSERT INTO `operation_log` VALUES ('1019', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723081346');
INSERT INTO `operation_log` VALUES ('1020', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723081346');
INSERT INTO `operation_log` VALUES ('1021', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1723081356');
INSERT INTO `operation_log` VALUES ('1022', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1723081358');
INSERT INTO `operation_log` VALUES ('1023', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1723081361');
INSERT INTO `operation_log` VALUES ('1024', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1723081363');
INSERT INTO `operation_log` VALUES ('1025', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1723081365');
INSERT INTO `operation_log` VALUES ('1026', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1723081367');
INSERT INTO `operation_log` VALUES ('1027', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1723085305');
INSERT INTO `operation_log` VALUES ('1028', '1', '/desktop/system.config.index/init', '127.0.0.1', '1723085309');
INSERT INTO `operation_log` VALUES ('1029', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723085345');
INSERT INTO `operation_log` VALUES ('1030', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723085346');
INSERT INTO `operation_log` VALUES ('1031', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1723085552');
INSERT INTO `operation_log` VALUES ('1032', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1723085582');
INSERT INTO `operation_log` VALUES ('1033', '1', '/desktop/system.config.index/init', '127.0.0.1', '1723085586');
INSERT INTO `operation_log` VALUES ('1034', '1', '/desktop/system.user.index/init', '127.0.0.1', '1723085817');
INSERT INTO `operation_log` VALUES ('1035', '1', '/desktop/system.user.index/getusers', '127.0.0.1', '1723085817');
INSERT INTO `operation_log` VALUES ('1036', '1', '/desktop/system.department.index/getdepartments', '127.0.0.1', '1723085819');
INSERT INTO `operation_log` VALUES ('1037', '1', '/desktop/system.role.index/getroles', '127.0.0.1', '1723085822');
INSERT INTO `operation_log` VALUES ('1038', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1723085825');
INSERT INTO `operation_log` VALUES ('1039', '1', '/desktop/system.dictionary.index/getdictionarys', '127.0.0.1', '1723085826');
INSERT INTO `operation_log` VALUES ('1040', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1724830177');
INSERT INTO `operation_log` VALUES ('1041', '1', '/desktop/statistic.department.index/exportexcel', '127.0.0.1', '1724830187');
INSERT INTO `operation_log` VALUES ('1042', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1724830197');
INSERT INTO `operation_log` VALUES ('1043', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1724830201');
INSERT INTO `operation_log` VALUES ('1044', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1724830216');
INSERT INTO `operation_log` VALUES ('1045', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1724830217');
INSERT INTO `operation_log` VALUES ('1046', '1', '/desktop/statistic.department.index/exportexcel', '127.0.0.1', '1724830253');
INSERT INTO `operation_log` VALUES ('1047', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1724832294');
INSERT INTO `operation_log` VALUES ('1048', '1', '/desktop/statistic.department.index/exportexcel', '127.0.0.1', '1724832311');
INSERT INTO `operation_log` VALUES ('1049', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1724832359');
INSERT INTO `operation_log` VALUES ('1050', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1724832773');
INSERT INTO `operation_log` VALUES ('1051', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1725519542');
INSERT INTO `operation_log` VALUES ('1052', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1725519702');
INSERT INTO `operation_log` VALUES ('1053', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1725519815');
INSERT INTO `operation_log` VALUES ('1054', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1725520219');
INSERT INTO `operation_log` VALUES ('1055', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1725522399');
INSERT INTO `operation_log` VALUES ('1056', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1725522406');
INSERT INTO `operation_log` VALUES ('1057', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1725522421');
INSERT INTO `operation_log` VALUES ('1058', '1', '/desktop/statistic.department.index/init', '127.0.0.1', '1725522502');
INSERT INTO `operation_log` VALUES ('1059', '1', '/desktop/statistic.trend.index/init', '127.0.0.1', '1725522563');
INSERT INTO `operation_log` VALUES ('1060', '1', '/desktop/frame.message/getnoreadmessages', '127.0.0.1', '1728630590');
INSERT INTO `operation_log` VALUES ('1061', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1728630590');
INSERT INTO `operation_log` VALUES ('1062', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1728630590');
INSERT INTO `operation_log` VALUES ('1063', '1', '/desktop/frame/getroutes', '127.0.0.1', '1728630591');
INSERT INTO `operation_log` VALUES ('1064', '1', '/desktop/layouts.side/getavatar', '127.0.0.1', '1728630593');
INSERT INTO `operation_log` VALUES ('1065', '1', '/desktop/layouts.side/getmenus', '127.0.0.1', '1728630593');
INSERT INTO `operation_log` VALUES ('1066', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1728630764');
INSERT INTO `operation_log` VALUES ('1067', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1728630771');
INSERT INTO `operation_log` VALUES ('1068', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1728630777');
INSERT INTO `operation_log` VALUES ('1069', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1728630785');
INSERT INTO `operation_log` VALUES ('1070', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1728630789');
INSERT INTO `operation_log` VALUES ('1071', '1', '/desktop/system.mobile.permission.edit/init', '127.0.0.1', '1728630791');
INSERT INTO `operation_log` VALUES ('1072', '1', '/desktop/system.mobile.permission.add/init', '127.0.0.1', '1728630793');
INSERT INTO `operation_log` VALUES ('1073', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1728631181');
INSERT INTO `operation_log` VALUES ('1074', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1728631189');
INSERT INTO `operation_log` VALUES ('1075', '1', '/desktop/system.desktop.route.index/getroutes', '127.0.0.1', '1728631197');
INSERT INTO `operation_log` VALUES ('1076', '1', '/desktop/system.mobile.permission.index/getpermissions', '127.0.0.1', '1728631209');
INSERT INTO `operation_log` VALUES ('1077', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1728631259');
INSERT INTO `operation_log` VALUES ('1078', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1728631262');
INSERT INTO `operation_log` VALUES ('1079', '1', '/desktop/system.desktop.permission.edit/init', '127.0.0.1', '1728631273');
INSERT INTO `operation_log` VALUES ('1080', '1', '/desktop/system.desktop.menu.index/getmenus', '127.0.0.1', '1728631307');
INSERT INTO `operation_log` VALUES ('1081', '1', '/desktop/system.desktop.menu.edit/init', '127.0.0.1', '1728631313');
INSERT INTO `operation_log` VALUES ('1082', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1728633147');
INSERT INTO `operation_log` VALUES ('1083', '1', '/desktop/frame.message/getnoreadmessages', '127.0.0.1', '1728633147');
INSERT INTO `operation_log` VALUES ('1084', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1728633147');
INSERT INTO `operation_log` VALUES ('1085', '1', '/desktop/frame/getroutes', '127.0.0.1', '1728633147');
INSERT INTO `operation_log` VALUES ('1086', '1', '/desktop/layouts.side/getavatar', '127.0.0.1', '1728633148');
INSERT INTO `operation_log` VALUES ('1087', '1', '/desktop/layouts.side/getmenus', '127.0.0.1', '1728633148');
INSERT INTO `operation_log` VALUES ('1088', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1728633152');
INSERT INTO `operation_log` VALUES ('1089', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1728633152');
INSERT INTO `operation_log` VALUES ('1090', '1', '/desktop/frame.message/getnoreadmessages', '127.0.0.1', '1728633152');
INSERT INTO `operation_log` VALUES ('1091', '1', '/desktop/frame/getroutes', '127.0.0.1', '1728633153');
INSERT INTO `operation_log` VALUES ('1092', '1', '/desktop/layouts.side/getmenus', '127.0.0.1', '1728633153');
INSERT INTO `operation_log` VALUES ('1093', '1', '/desktop/layouts.side/getavatar', '127.0.0.1', '1728633153');
INSERT INTO `operation_log` VALUES ('1094', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1728633159');
INSERT INTO `operation_log` VALUES ('1095', '1', '/desktop/frame.message/getnoreadmessages', '127.0.0.1', '1728633159');
INSERT INTO `operation_log` VALUES ('1096', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1728633159');
INSERT INTO `operation_log` VALUES ('1097', '1', '/desktop/frame/getroutes', '127.0.0.1', '1728633160');
INSERT INTO `operation_log` VALUES ('1098', '1', '/desktop/layouts.side/getmenus', '127.0.0.1', '1728633163');
INSERT INTO `operation_log` VALUES ('1099', '1', '/desktop/layouts.side/getavatar', '127.0.0.1', '1728633163');
INSERT INTO `operation_log` VALUES ('1100', '1', '/desktop/system.desktop.permission.index/getpermissions', '127.0.0.1', '1728633170');
INSERT INTO `operation_log` VALUES ('1101', '1', '/desktop/system.desktop.permission.edit/init', '127.0.0.1', '1728633182');
INSERT INTO `operation_log` VALUES ('1102', '1', '/desktop/system.desktop.permission.edit/init', '127.0.0.1', '1728633285');
INSERT INTO `operation_log` VALUES ('1103', '1', '/desktop/system.desktop.permission.edit/init', '127.0.0.1', '1728633344');
INSERT INTO `operation_log` VALUES ('1104', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057057');
INSERT INTO `operation_log` VALUES ('1105', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057121');
INSERT INTO `operation_log` VALUES ('1106', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057121');
INSERT INTO `operation_log` VALUES ('1107', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057185');
INSERT INTO `operation_log` VALUES ('1108', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057185');
INSERT INTO `operation_log` VALUES ('1109', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057197');
INSERT INTO `operation_log` VALUES ('1110', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057197');
INSERT INTO `operation_log` VALUES ('1111', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057223');
INSERT INTO `operation_log` VALUES ('1112', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057224');
INSERT INTO `operation_log` VALUES ('1113', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057226');
INSERT INTO `operation_log` VALUES ('1114', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057226');
INSERT INTO `operation_log` VALUES ('1115', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057275');
INSERT INTO `operation_log` VALUES ('1116', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057276');
INSERT INTO `operation_log` VALUES ('1117', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057281');
INSERT INTO `operation_log` VALUES ('1118', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057282');
INSERT INTO `operation_log` VALUES ('1119', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057320');
INSERT INTO `operation_log` VALUES ('1120', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057320');
INSERT INTO `operation_log` VALUES ('1121', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057356');
INSERT INTO `operation_log` VALUES ('1122', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057356');
INSERT INTO `operation_log` VALUES ('1123', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057577');
INSERT INTO `operation_log` VALUES ('1124', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057577');
INSERT INTO `operation_log` VALUES ('1125', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736057578');
INSERT INTO `operation_log` VALUES ('1126', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057582');
INSERT INTO `operation_log` VALUES ('1127', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736057582');
INSERT INTO `operation_log` VALUES ('1128', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057583');
INSERT INTO `operation_log` VALUES ('1129', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057665');
INSERT INTO `operation_log` VALUES ('1130', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736057665');
INSERT INTO `operation_log` VALUES ('1131', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057665');
INSERT INTO `operation_log` VALUES ('1132', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057687');
INSERT INTO `operation_log` VALUES ('1133', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736057687');
INSERT INTO `operation_log` VALUES ('1134', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057688');
INSERT INTO `operation_log` VALUES ('1135', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736057749');
INSERT INTO `operation_log` VALUES ('1136', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057749');
INSERT INTO `operation_log` VALUES ('1137', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057749');
INSERT INTO `operation_log` VALUES ('1138', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057882');
INSERT INTO `operation_log` VALUES ('1139', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736057882');
INSERT INTO `operation_log` VALUES ('1140', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057883');
INSERT INTO `operation_log` VALUES ('1141', '1', '/desktop/layouts.side/getavatar', '127.0.0.1', '1736057884');
INSERT INTO `operation_log` VALUES ('1142', '1', '/desktop/layouts.side/getmenus', '127.0.0.1', '1736057884');
INSERT INTO `operation_log` VALUES ('1143', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736057894');
INSERT INTO `operation_log` VALUES ('1144', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736057894');
INSERT INTO `operation_log` VALUES ('1145', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736057895');
INSERT INTO `operation_log` VALUES ('1146', '1', '/desktop/layouts.side/getmenus', '127.0.0.1', '1736057895');
INSERT INTO `operation_log` VALUES ('1147', '1', '/desktop/layouts.side/getavatar', '127.0.0.1', '1736057895');
INSERT INTO `operation_log` VALUES ('1148', '1', '/desktop/layouts.side.user.detail/getuser', '127.0.0.1', '1736057923');
INSERT INTO `operation_log` VALUES ('1149', '1', '/desktop/layouts.side.user.detail/getuser', '127.0.0.1', '1736057931');
INSERT INTO `operation_log` VALUES ('1150', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736058548');
INSERT INTO `operation_log` VALUES ('1151', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736058548');
INSERT INTO `operation_log` VALUES ('1152', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736058549');
INSERT INTO `operation_log` VALUES ('1153', '1', '/desktop/layouts.side/getmenus', '127.0.0.1', '1736058550');
INSERT INTO `operation_log` VALUES ('1154', '1', '/desktop/layouts.side/getavatar', '127.0.0.1', '1736058550');
INSERT INTO `operation_log` VALUES ('1155', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736058563');
INSERT INTO `operation_log` VALUES ('1156', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736058563');
INSERT INTO `operation_log` VALUES ('1157', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736058563');
INSERT INTO `operation_log` VALUES ('1158', '1', '/desktop/layouts.side/getavatar', '127.0.0.1', '1736058565');
INSERT INTO `operation_log` VALUES ('1159', '1', '/desktop/layouts.side/getmenus', '127.0.0.1', '1736058565');
INSERT INTO `operation_log` VALUES ('1160', '1', '/desktop/layouts.side.user.detail/getuser', '127.0.0.1', '1736058579');
INSERT INTO `operation_log` VALUES ('1161', '1', '/desktop/layouts.side.user.editavatar/init', '127.0.0.1', '1736058583');
INSERT INTO `operation_log` VALUES ('1162', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736058655');
INSERT INTO `operation_log` VALUES ('1163', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736058655');
INSERT INTO `operation_log` VALUES ('1164', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736058655');
INSERT INTO `operation_log` VALUES ('1165', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736058681');
INSERT INTO `operation_log` VALUES ('1166', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736058692');
INSERT INTO `operation_log` VALUES ('1167', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736058806');
INSERT INTO `operation_log` VALUES ('1168', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736058806');
INSERT INTO `operation_log` VALUES ('1169', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736058807');
INSERT INTO `operation_log` VALUES ('1170', '1', '/desktop/frame/getwatermark', '127.0.0.1', '1736060090');
INSERT INTO `operation_log` VALUES ('1171', '1', '/desktop/frame/getpermissions', '127.0.0.1', '1736060090');
INSERT INTO `operation_log` VALUES ('1172', '1', '/desktop/frame/getroutes', '127.0.0.1', '1736060091');
INSERT INTO `operation_log` VALUES ('1173', '1', '/desktop/system.config.index/init', '127.0.0.1', '1736065795');
INSERT INTO `operation_log` VALUES ('1174', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736596565');
INSERT INTO `operation_log` VALUES ('1175', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736596577');
INSERT INTO `operation_log` VALUES ('1176', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736598143');
INSERT INTO `operation_log` VALUES ('1177', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736598365');
INSERT INTO `operation_log` VALUES ('1178', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736599204');
INSERT INTO `operation_log` VALUES ('1179', '1', '/desktop/system.config.Index/save', '127.0.0.1', '1736599215');
INSERT INTO `operation_log` VALUES ('1180', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736599235');
INSERT INTO `operation_log` VALUES ('1181', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736599248');
INSERT INTO `operation_log` VALUES ('1182', '1', '/desktop/system.user.Index/getUsers', '127.0.0.1', '1736599248');
INSERT INTO `operation_log` VALUES ('1183', '1', '/desktop/system.operation_log.Index/getOperationLogs', '127.0.0.1', '1736599301');
INSERT INTO `operation_log` VALUES ('1184', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736599305');
INSERT INTO `operation_log` VALUES ('1185', '1', '/desktop/system.user.Index/getUsers', '127.0.0.1', '1736599307');
INSERT INTO `operation_log` VALUES ('1186', '1', '/desktop/system.operation_log.Index/getOperationLogs', '127.0.0.1', '1736599344');
INSERT INTO `operation_log` VALUES ('1187', '1', '/desktop/system.operation_log.Index/getOperationLogs', '127.0.0.1', '1736599366');
INSERT INTO `operation_log` VALUES ('1188', '1', '/desktop/system.operation_log.Index/getOperationLogs', '127.0.0.1', '1736599853');
INSERT INTO `operation_log` VALUES ('1189', '1', '/desktop/system.desktop.permission.Index/getPermissions', '127.0.0.1', '1736600201');
INSERT INTO `operation_log` VALUES ('1190', '1', '/desktop/system.desktop.permission.Index/getPermissions', '127.0.0.1', '1736600320');
INSERT INTO `operation_log` VALUES ('1191', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736600332');
INSERT INTO `operation_log` VALUES ('1192', '1', '/desktop/system.desktop.permission.Index/getPermissions', '127.0.0.1', '1736601215');
INSERT INTO `operation_log` VALUES ('1193', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601315');
INSERT INTO `operation_log` VALUES ('1194', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601331');
INSERT INTO `operation_log` VALUES ('1195', '1', '/desktop/system.desktop.permission.Index/getPermissions', '127.0.0.1', '1736601331');
INSERT INTO `operation_log` VALUES ('1196', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601361');
INSERT INTO `operation_log` VALUES ('1197', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601381');
INSERT INTO `operation_log` VALUES ('1198', '1', '/desktop/system.desktop.permission.Index/getPermissions', '127.0.0.1', '1736601382');
INSERT INTO `operation_log` VALUES ('1199', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601384');
INSERT INTO `operation_log` VALUES ('1200', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601388');
INSERT INTO `operation_log` VALUES ('1201', '1', '/desktop/system.desktop.permission.Index/getPermissions', '127.0.0.1', '1736601388');
INSERT INTO `operation_log` VALUES ('1202', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601392');
INSERT INTO `operation_log` VALUES ('1203', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601396');
INSERT INTO `operation_log` VALUES ('1204', '1', '/desktop/system.desktop.permission.Index/getPermissions', '127.0.0.1', '1736601397');
INSERT INTO `operation_log` VALUES ('1205', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601401');
INSERT INTO `operation_log` VALUES ('1206', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601406');
INSERT INTO `operation_log` VALUES ('1207', '1', '/desktop/system.desktop.permission.Index/getPermissions', '127.0.0.1', '1736601406');
INSERT INTO `operation_log` VALUES ('1208', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601409');
INSERT INTO `operation_log` VALUES ('1209', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601413');
INSERT INTO `operation_log` VALUES ('1210', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601418');
INSERT INTO `operation_log` VALUES ('1211', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601422');
INSERT INTO `operation_log` VALUES ('1212', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601425');
INSERT INTO `operation_log` VALUES ('1213', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601430');
INSERT INTO `operation_log` VALUES ('1214', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601434');
INSERT INTO `operation_log` VALUES ('1215', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601438');
INSERT INTO `operation_log` VALUES ('1216', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601441');
INSERT INTO `operation_log` VALUES ('1217', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601445');
INSERT INTO `operation_log` VALUES ('1218', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601447');
INSERT INTO `operation_log` VALUES ('1219', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601451');
INSERT INTO `operation_log` VALUES ('1220', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601628');
INSERT INTO `operation_log` VALUES ('1221', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736601632');
INSERT INTO `operation_log` VALUES ('1222', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736601657');
INSERT INTO `operation_log` VALUES ('1223', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736601773');
INSERT INTO `operation_log` VALUES ('1224', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1736601787');
INSERT INTO `operation_log` VALUES ('1225', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736601913');
INSERT INTO `operation_log` VALUES ('1226', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736601919');
INSERT INTO `operation_log` VALUES ('1227', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1736601944');
INSERT INTO `operation_log` VALUES ('1228', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736602279');
INSERT INTO `operation_log` VALUES ('1229', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736602286');
INSERT INTO `operation_log` VALUES ('1230', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736602343');
INSERT INTO `operation_log` VALUES ('1231', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736602395');
INSERT INTO `operation_log` VALUES ('1232', '1', '/desktop/system.mobile.permission.Index/getPermissionPaginate', '127.0.0.1', '1736602455');
INSERT INTO `operation_log` VALUES ('1233', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736602690');
INSERT INTO `operation_log` VALUES ('1234', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736602697');
INSERT INTO `operation_log` VALUES ('1235', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736602704');
INSERT INTO `operation_log` VALUES ('1236', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736602719');
INSERT INTO `operation_log` VALUES ('1237', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736602719');
INSERT INTO `operation_log` VALUES ('1238', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736602730');
INSERT INTO `operation_log` VALUES ('1239', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736602736');
INSERT INTO `operation_log` VALUES ('1240', '1', '/desktop/system.mobile.permission.Edit/init', '127.0.0.1', '1736602738');
INSERT INTO `operation_log` VALUES ('1241', '1', '/desktop/system.mobile.permission.Edit/init', '127.0.0.1', '1736602987');
INSERT INTO `operation_log` VALUES ('1242', '1', '/desktop/system.mobile.permission.Edit/save', '127.0.0.1', '1736602989');
INSERT INTO `operation_log` VALUES ('1243', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736602989');
INSERT INTO `operation_log` VALUES ('1244', '1', '/desktop/system.mobile.permission.Edit/init', '127.0.0.1', '1736602990');
INSERT INTO `operation_log` VALUES ('1245', '1', '/desktop/system.mobile.permission.Edit/save', '127.0.0.1', '1736602992');
INSERT INTO `operation_log` VALUES ('1246', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736602992');
INSERT INTO `operation_log` VALUES ('1247', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736602999');
INSERT INTO `operation_log` VALUES ('1248', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736603128');
INSERT INTO `operation_log` VALUES ('1249', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736603143');
INSERT INTO `operation_log` VALUES ('1250', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736603158');
INSERT INTO `operation_log` VALUES ('1251', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736603159');
INSERT INTO `operation_log` VALUES ('1252', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736603166');
INSERT INTO `operation_log` VALUES ('1253', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736603169');
INSERT INTO `operation_log` VALUES ('1254', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736603170');
INSERT INTO `operation_log` VALUES ('1255', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736603174');
INSERT INTO `operation_log` VALUES ('1256', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736603177');
INSERT INTO `operation_log` VALUES ('1257', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736603177');
INSERT INTO `operation_log` VALUES ('1258', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736603180');
INSERT INTO `operation_log` VALUES ('1259', '1', '/desktop/system.desktop.route.Add/init', '127.0.0.1', '1736603668');
INSERT INTO `operation_log` VALUES ('1260', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1736603678');
INSERT INTO `operation_log` VALUES ('1261', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1736603698');
INSERT INTO `operation_log` VALUES ('1262', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736603997');
INSERT INTO `operation_log` VALUES ('1263', '1', '/desktop/system.desktop.route.Add/init', '127.0.0.1', '1736603998');
INSERT INTO `operation_log` VALUES ('1264', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1736604003');
INSERT INTO `operation_log` VALUES ('1265', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736604302');
INSERT INTO `operation_log` VALUES ('1266', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736604310');
INSERT INTO `operation_log` VALUES ('1267', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736604318');
INSERT INTO `operation_log` VALUES ('1268', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736604318');
INSERT INTO `operation_log` VALUES ('1269', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736604321');
INSERT INTO `operation_log` VALUES ('1270', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736604326');
INSERT INTO `operation_log` VALUES ('1271', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736604326');
INSERT INTO `operation_log` VALUES ('1272', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736604332');
INSERT INTO `operation_log` VALUES ('1273', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736604337');
INSERT INTO `operation_log` VALUES ('1274', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736604337');
INSERT INTO `operation_log` VALUES ('1275', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736604343');
INSERT INTO `operation_log` VALUES ('1276', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736604349');
INSERT INTO `operation_log` VALUES ('1277', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736604349');
INSERT INTO `operation_log` VALUES ('1278', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736604353');
INSERT INTO `operation_log` VALUES ('1279', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736604358');
INSERT INTO `operation_log` VALUES ('1280', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1736604361');
INSERT INTO `operation_log` VALUES ('1281', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1736604368');
INSERT INTO `operation_log` VALUES ('1282', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736604433');
INSERT INTO `operation_log` VALUES ('1283', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736604451');
INSERT INTO `operation_log` VALUES ('1284', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736604486');
INSERT INTO `operation_log` VALUES ('1285', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1736604489');
INSERT INTO `operation_log` VALUES ('1286', '1', '/desktop/system.desktop.menu.Edit/save', '127.0.0.1', '1736604493');
INSERT INTO `operation_log` VALUES ('1287', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736604493');
INSERT INTO `operation_log` VALUES ('1288', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736605133');
INSERT INTO `operation_log` VALUES ('1289', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736605139');
INSERT INTO `operation_log` VALUES ('1290', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736605151');
INSERT INTO `operation_log` VALUES ('1291', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736605152');
INSERT INTO `operation_log` VALUES ('1292', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736605156');
INSERT INTO `operation_log` VALUES ('1293', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736605160');
INSERT INTO `operation_log` VALUES ('1294', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736605197');
INSERT INTO `operation_log` VALUES ('1295', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736605210');
INSERT INTO `operation_log` VALUES ('1296', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736605226');
INSERT INTO `operation_log` VALUES ('1297', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736605295');
INSERT INTO `operation_log` VALUES ('1298', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736605411');
INSERT INTO `operation_log` VALUES ('1299', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736605447');
INSERT INTO `operation_log` VALUES ('1300', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736605529');
INSERT INTO `operation_log` VALUES ('1301', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736605553');
INSERT INTO `operation_log` VALUES ('1302', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736605556');
INSERT INTO `operation_log` VALUES ('1303', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736605606');
INSERT INTO `operation_log` VALUES ('1304', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736605715');
INSERT INTO `operation_log` VALUES ('1305', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736605918');
INSERT INTO `operation_log` VALUES ('1306', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736605988');
INSERT INTO `operation_log` VALUES ('1307', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736606025');
INSERT INTO `operation_log` VALUES ('1308', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736606026');
INSERT INTO `operation_log` VALUES ('1309', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736606040');
INSERT INTO `operation_log` VALUES ('1310', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736606071');
INSERT INTO `operation_log` VALUES ('1311', '1', '/desktop/system.user.Index/init', '127.0.0.1', '1736606407');
INSERT INTO `operation_log` VALUES ('1312', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736606425');
INSERT INTO `operation_log` VALUES ('1313', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736606432');
INSERT INTO `operation_log` VALUES ('1314', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736606550');
INSERT INTO `operation_log` VALUES ('1315', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736606641');
INSERT INTO `operation_log` VALUES ('1316', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736606645');
INSERT INTO `operation_log` VALUES ('1317', '1', '/desktop/system.user.Add/init', '127.0.0.1', '1736606769');
INSERT INTO `operation_log` VALUES ('1318', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736606820');
INSERT INTO `operation_log` VALUES ('1319', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736606908');
INSERT INTO `operation_log` VALUES ('1320', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736606941');
INSERT INTO `operation_log` VALUES ('1321', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736607132');
INSERT INTO `operation_log` VALUES ('1322', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1736607181');
INSERT INTO `operation_log` VALUES ('1323', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1736607182');
INSERT INTO `operation_log` VALUES ('1324', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607184');
INSERT INTO `operation_log` VALUES ('1325', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607189');
INSERT INTO `operation_log` VALUES ('1326', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607192');
INSERT INTO `operation_log` VALUES ('1327', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607199');
INSERT INTO `operation_log` VALUES ('1328', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607207');
INSERT INTO `operation_log` VALUES ('1329', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607278');
INSERT INTO `operation_log` VALUES ('1330', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607282');
INSERT INTO `operation_log` VALUES ('1331', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607315');
INSERT INTO `operation_log` VALUES ('1332', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607329');
INSERT INTO `operation_log` VALUES ('1333', '1', '/desktop/system.user.Edit/save', '127.0.0.1', '1736607333');
INSERT INTO `operation_log` VALUES ('1334', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736607333');
INSERT INTO `operation_log` VALUES ('1335', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607335');
INSERT INTO `operation_log` VALUES ('1336', '1', '/desktop/system.user.Edit/save', '127.0.0.1', '1736607340');
INSERT INTO `operation_log` VALUES ('1337', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736607340');
INSERT INTO `operation_log` VALUES ('1338', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736607342');
INSERT INTO `operation_log` VALUES ('1339', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736607489');
INSERT INTO `operation_log` VALUES ('1340', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736607491');
INSERT INTO `operation_log` VALUES ('1341', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736607496');
INSERT INTO `operation_log` VALUES ('1342', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736607499');
INSERT INTO `operation_log` VALUES ('1343', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736607501');
INSERT INTO `operation_log` VALUES ('1344', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736607504');
INSERT INTO `operation_log` VALUES ('1345', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736607869');
INSERT INTO `operation_log` VALUES ('1346', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736607955');
INSERT INTO `operation_log` VALUES ('1347', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736607977');
INSERT INTO `operation_log` VALUES ('1348', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736608029');
INSERT INTO `operation_log` VALUES ('1349', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736608075');
INSERT INTO `operation_log` VALUES ('1350', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736608095');
INSERT INTO `operation_log` VALUES ('1351', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736608163');
INSERT INTO `operation_log` VALUES ('1352', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736608281');
INSERT INTO `operation_log` VALUES ('1353', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736608779');
INSERT INTO `operation_log` VALUES ('1354', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736608787');
INSERT INTO `operation_log` VALUES ('1355', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736608791');
INSERT INTO `operation_log` VALUES ('1356', '1', '/desktop/system.role.Add/save', '127.0.0.1', '1736608808');
INSERT INTO `operation_log` VALUES ('1357', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736608809');
INSERT INTO `operation_log` VALUES ('1358', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1736608812');
INSERT INTO `operation_log` VALUES ('1359', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1736608828');
INSERT INTO `operation_log` VALUES ('1360', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736608828');
INSERT INTO `operation_log` VALUES ('1361', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1736608830');
INSERT INTO `operation_log` VALUES ('1362', '1', '/desktop/system.role.Index/delete', '127.0.0.1', '1736608837');
INSERT INTO `operation_log` VALUES ('1363', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736608837');
INSERT INTO `operation_log` VALUES ('1364', '1', '/desktop/statistic.trend.Index/init', '127.0.0.1', '1736609092');
INSERT INTO `operation_log` VALUES ('1365', '1', '/desktop/statistic.trend.Index/init', '127.0.0.1', '1736609168');
INSERT INTO `operation_log` VALUES ('1366', '1', '/desktop/statistic.department.Index/init', '127.0.0.1', '1736609199');
INSERT INTO `operation_log` VALUES ('1367', '1', '/desktop/statistic.department.Index/init', '127.0.0.1', '1736609261');
INSERT INTO `operation_log` VALUES ('1368', '1', '/desktop/statistic.department.Index/init', '127.0.0.1', '1736609414');
INSERT INTO `operation_log` VALUES ('1369', '1', '/desktop/statistic.trend.Index/init', '127.0.0.1', '1736609643');
INSERT INTO `operation_log` VALUES ('1370', '1', '/desktop/statistic.department.Index/init', '127.0.0.1', '1736609646');
INSERT INTO `operation_log` VALUES ('1371', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736609651');
INSERT INTO `operation_log` VALUES ('1372', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736609652');
INSERT INTO `operation_log` VALUES ('1373', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736609654');
INSERT INTO `operation_log` VALUES ('1374', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736609656');
INSERT INTO `operation_log` VALUES ('1375', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736609659');
INSERT INTO `operation_log` VALUES ('1376', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736609661');
INSERT INTO `operation_log` VALUES ('1377', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736609663');
INSERT INTO `operation_log` VALUES ('1378', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736609667');
INSERT INTO `operation_log` VALUES ('1379', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736609668');
INSERT INTO `operation_log` VALUES ('1380', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1736609669');
INSERT INTO `operation_log` VALUES ('1381', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736609714');
INSERT INTO `operation_log` VALUES ('1382', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736609716');
INSERT INTO `operation_log` VALUES ('1383', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736609718');
INSERT INTO `operation_log` VALUES ('1384', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736609722');
INSERT INTO `operation_log` VALUES ('1385', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736609786');
INSERT INTO `operation_log` VALUES ('1386', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736609794');
INSERT INTO `operation_log` VALUES ('1387', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736609806');
INSERT INTO `operation_log` VALUES ('1388', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736609819');
INSERT INTO `operation_log` VALUES ('1389', '1', '/desktop/system.desktop.permission.Index/delete', '127.0.0.1', '1736609827');
INSERT INTO `operation_log` VALUES ('1390', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736609827');
INSERT INTO `operation_log` VALUES ('1391', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736609829');
INSERT INTO `operation_log` VALUES ('1392', '1', '/desktop/system.desktop.permission.Edit/save', '127.0.0.1', '1736609869');
INSERT INTO `operation_log` VALUES ('1393', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736609870');
INSERT INTO `operation_log` VALUES ('1394', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736609871');
INSERT INTO `operation_log` VALUES ('1395', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1736609873');
INSERT INTO `operation_log` VALUES ('1396', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1736609878');
INSERT INTO `operation_log` VALUES ('1397', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736609879');
INSERT INTO `operation_log` VALUES ('1398', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1736609881');
INSERT INTO `operation_log` VALUES ('1399', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1736609898');
INSERT INTO `operation_log` VALUES ('1400', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736609898');
INSERT INTO `operation_log` VALUES ('1401', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736609900');
INSERT INTO `operation_log` VALUES ('1402', '1', '/desktop/system.desktop.route.Index/delete', '127.0.0.1', '1736609906');
INSERT INTO `operation_log` VALUES ('1403', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736609907');
INSERT INTO `operation_log` VALUES ('1404', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1736609909');
INSERT INTO `operation_log` VALUES ('1405', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1736609915');
INSERT INTO `operation_log` VALUES ('1406', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1736610007');
INSERT INTO `operation_log` VALUES ('1407', '1', '/desktop/system.desktop.route.Edit/save', '127.0.0.1', '1736610036');
INSERT INTO `operation_log` VALUES ('1408', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736610036');
INSERT INTO `operation_log` VALUES ('1409', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736610044');
INSERT INTO `operation_log` VALUES ('1410', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736610045');
INSERT INTO `operation_log` VALUES ('1411', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1736610047');
INSERT INTO `operation_log` VALUES ('1412', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1736610051');
INSERT INTO `operation_log` VALUES ('1413', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736610052');
INSERT INTO `operation_log` VALUES ('1414', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736610055');
INSERT INTO `operation_log` VALUES ('1415', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736610065');
INSERT INTO `operation_log` VALUES ('1416', '1', '/desktop/system.desktop.menu.Index/delete', '127.0.0.1', '1736610075');
INSERT INTO `operation_log` VALUES ('1417', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736610075');
INSERT INTO `operation_log` VALUES ('1418', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1736610078');
INSERT INTO `operation_log` VALUES ('1419', '1', '/desktop/system.desktop.menu.Edit/save', '127.0.0.1', '1736610090');
INSERT INTO `operation_log` VALUES ('1420', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736610091');
INSERT INTO `operation_log` VALUES ('1421', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736610097');
INSERT INTO `operation_log` VALUES ('1422', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736610101');
INSERT INTO `operation_log` VALUES ('1423', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1736610102');
INSERT INTO `operation_log` VALUES ('1424', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1736610104');
INSERT INTO `operation_log` VALUES ('1425', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736610104');
INSERT INTO `operation_log` VALUES ('1426', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1736610105');
INSERT INTO `operation_log` VALUES ('1427', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1736610108');
INSERT INTO `operation_log` VALUES ('1428', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736610109');
INSERT INTO `operation_log` VALUES ('1429', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736610114');
INSERT INTO `operation_log` VALUES ('1430', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736610944');
INSERT INTO `operation_log` VALUES ('1431', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736610959');
INSERT INTO `operation_log` VALUES ('1432', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736610973');
INSERT INTO `operation_log` VALUES ('1433', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611013');
INSERT INTO `operation_log` VALUES ('1434', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611051');
INSERT INTO `operation_log` VALUES ('1435', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611062');
INSERT INTO `operation_log` VALUES ('1436', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611083');
INSERT INTO `operation_log` VALUES ('1437', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611134');
INSERT INTO `operation_log` VALUES ('1438', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611192');
INSERT INTO `operation_log` VALUES ('1439', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611195');
INSERT INTO `operation_log` VALUES ('1440', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611343');
INSERT INTO `operation_log` VALUES ('1441', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611343');
INSERT INTO `operation_log` VALUES ('1442', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611357');
INSERT INTO `operation_log` VALUES ('1443', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736611374');
INSERT INTO `operation_log` VALUES ('1444', '1', '/desktop/statistic.OrderTrend/exp', '127.0.0.1', '1736612070');
INSERT INTO `operation_log` VALUES ('1445', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736612139');
INSERT INTO `operation_log` VALUES ('1446', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736612145');
INSERT INTO `operation_log` VALUES ('1447', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736612147');
INSERT INTO `operation_log` VALUES ('1448', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736612148');
INSERT INTO `operation_log` VALUES ('1449', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736612149');
INSERT INTO `operation_log` VALUES ('1450', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736612152');
INSERT INTO `operation_log` VALUES ('1451', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736612154');
INSERT INTO `operation_log` VALUES ('1452', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736612155');
INSERT INTO `operation_log` VALUES ('1453', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736612159');
INSERT INTO `operation_log` VALUES ('1454', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736612161');
INSERT INTO `operation_log` VALUES ('1455', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1736612162');
INSERT INTO `operation_log` VALUES ('1456', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736612166');
INSERT INTO `operation_log` VALUES ('1457', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736612307');
INSERT INTO `operation_log` VALUES ('1458', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736612308');
INSERT INTO `operation_log` VALUES ('1459', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1736612309');
INSERT INTO `operation_log` VALUES ('1460', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1736612310');
INSERT INTO `operation_log` VALUES ('1461', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736731651');
INSERT INTO `operation_log` VALUES ('1462', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736731653');
INSERT INTO `operation_log` VALUES ('1463', '1', '/desktop/statistic.OrderTrend/exp', '127.0.0.1', '1736731656');
INSERT INTO `operation_log` VALUES ('1464', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736731677');
INSERT INTO `operation_log` VALUES ('1465', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736731681');
INSERT INTO `operation_log` VALUES ('1466', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736731690');
INSERT INTO `operation_log` VALUES ('1467', '1', '/desktop/system.config.Index/save', '127.0.0.1', '1736731699');
INSERT INTO `operation_log` VALUES ('1468', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736731702');
INSERT INTO `operation_log` VALUES ('1469', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736731704');
INSERT INTO `operation_log` VALUES ('1470', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736731746');
INSERT INTO `operation_log` VALUES ('1471', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736731751');
INSERT INTO `operation_log` VALUES ('1472', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1736731757');
INSERT INTO `operation_log` VALUES ('1473', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1736731795');
INSERT INTO `operation_log` VALUES ('1474', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736745194');
INSERT INTO `operation_log` VALUES ('1475', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736745197');
INSERT INTO `operation_log` VALUES ('1476', '1', '/desktop/statistic.OrderTrend/exp', '127.0.0.1', '1736745198');
INSERT INTO `operation_log` VALUES ('1477', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736745202');
INSERT INTO `operation_log` VALUES ('1478', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736745234');
INSERT INTO `operation_log` VALUES ('1479', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1736745354');
INSERT INTO `operation_log` VALUES ('1480', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1736745356');
INSERT INTO `operation_log` VALUES ('1481', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1736745357');
INSERT INTO `operation_log` VALUES ('1482', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1736745358');
INSERT INTO `operation_log` VALUES ('1483', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736745361');
INSERT INTO `operation_log` VALUES ('1484', '1', '/desktop/system.user.Edit/save', '127.0.0.1', '1736745402');
INSERT INTO `operation_log` VALUES ('1485', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736745403');
INSERT INTO `operation_log` VALUES ('1486', '1', '/desktop/system.user.EditPassword/save', '127.0.0.1', '1736745420');
INSERT INTO `operation_log` VALUES ('1487', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1736745425');
INSERT INTO `operation_log` VALUES ('1488', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1736745447');
INSERT INTO `operation_log` VALUES ('1489', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1736745484');
INSERT INTO `operation_log` VALUES ('1490', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1736745518');
INSERT INTO `operation_log` VALUES ('1491', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1736745561');
INSERT INTO `operation_log` VALUES ('1492', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1736745616');
INSERT INTO `operation_log` VALUES ('1493', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1736745660');
INSERT INTO `operation_log` VALUES ('1494', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1736745665');
INSERT INTO `operation_log` VALUES ('1495', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1736745716');
INSERT INTO `operation_log` VALUES ('1496', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1736745722');
INSERT INTO `operation_log` VALUES ('1497', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736745726');
INSERT INTO `operation_log` VALUES ('1498', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736745734');
INSERT INTO `operation_log` VALUES ('1499', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736745747');
INSERT INTO `operation_log` VALUES ('1500', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736745778');
INSERT INTO `operation_log` VALUES ('1501', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736745913');
INSERT INTO `operation_log` VALUES ('1502', '1', '/desktop/system.department.Add/save', '127.0.0.1', '1736746013');
INSERT INTO `operation_log` VALUES ('1503', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736746013');
INSERT INTO `operation_log` VALUES ('1504', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736746016');
INSERT INTO `operation_log` VALUES ('1505', '1', '/desktop/system.department.Edit/save', '127.0.0.1', '1736746018');
INSERT INTO `operation_log` VALUES ('1506', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736746018');
INSERT INTO `operation_log` VALUES ('1507', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736746069');
INSERT INTO `operation_log` VALUES ('1508', '1', '/desktop/system.department.Edit/save', '127.0.0.1', '1736746070');
INSERT INTO `operation_log` VALUES ('1509', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736746070');
INSERT INTO `operation_log` VALUES ('1510', '1', '/desktop/system.department.Index/delete', '127.0.0.1', '1736746073');
INSERT INTO `operation_log` VALUES ('1511', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736746073');
INSERT INTO `operation_log` VALUES ('1512', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736746120');
INSERT INTO `operation_log` VALUES ('1513', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736746124');
INSERT INTO `operation_log` VALUES ('1514', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736746126');
INSERT INTO `operation_log` VALUES ('1515', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736746154');
INSERT INTO `operation_log` VALUES ('1516', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736746163');
INSERT INTO `operation_log` VALUES ('1517', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736746173');
INSERT INTO `operation_log` VALUES ('1518', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736746176');
INSERT INTO `operation_log` VALUES ('1519', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736746182');
INSERT INTO `operation_log` VALUES ('1520', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736746186');
INSERT INTO `operation_log` VALUES ('1521', '1', '/desktop/system.role.Add/save', '127.0.0.1', '1736746385');
INSERT INTO `operation_log` VALUES ('1522', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736746385');
INSERT INTO `operation_log` VALUES ('1523', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1736746387');
INSERT INTO `operation_log` VALUES ('1524', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736749236');
INSERT INTO `operation_log` VALUES ('1525', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736749276');
INSERT INTO `operation_log` VALUES ('1526', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736749308');
INSERT INTO `operation_log` VALUES ('1527', '1', '/desktop/system.desktop.menu.Add/save', '127.0.0.1', '1736749325');
INSERT INTO `operation_log` VALUES ('1528', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736749326');
INSERT INTO `operation_log` VALUES ('1529', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1736749338');
INSERT INTO `operation_log` VALUES ('1530', '1', '/desktop/system.desktop.menu.Edit/save', '127.0.0.1', '1736749342');
INSERT INTO `operation_log` VALUES ('1531', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736749342');
INSERT INTO `operation_log` VALUES ('1532', '1', '/desktop/system.desktop.menu.Index/delete', '127.0.0.1', '1736749345');
INSERT INTO `operation_log` VALUES ('1533', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736749346');
INSERT INTO `operation_log` VALUES ('1534', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736749377');
INSERT INTO `operation_log` VALUES ('1535', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736749437');
INSERT INTO `operation_log` VALUES ('1536', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736749447');
INSERT INTO `operation_log` VALUES ('1537', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736749528');
INSERT INTO `operation_log` VALUES ('1538', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736749602');
INSERT INTO `operation_log` VALUES ('1539', '1', '/desktop/system.desktop.route.Add/save', '127.0.0.1', '1736749609');
INSERT INTO `operation_log` VALUES ('1540', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736749609');
INSERT INTO `operation_log` VALUES ('1541', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1736749611');
INSERT INTO `operation_log` VALUES ('1542', '1', '/desktop/system.desktop.route.Edit/save', '127.0.0.1', '1736749614');
INSERT INTO `operation_log` VALUES ('1543', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736749614');
INSERT INTO `operation_log` VALUES ('1544', '1', '/desktop/system.desktop.route.Index/delete', '127.0.0.1', '1736749616');
INSERT INTO `operation_log` VALUES ('1545', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736749617');
INSERT INTO `operation_log` VALUES ('1546', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736749637');
INSERT INTO `operation_log` VALUES ('1547', '1', '/desktop/system.dictionary.Add/save', '127.0.0.1', '1736749643');
INSERT INTO `operation_log` VALUES ('1548', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736749643');
INSERT INTO `operation_log` VALUES ('1549', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1736749645');
INSERT INTO `operation_log` VALUES ('1550', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1736749649');
INSERT INTO `operation_log` VALUES ('1551', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1736749650');
INSERT INTO `operation_log` VALUES ('1552', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736749650');
INSERT INTO `operation_log` VALUES ('1553', '1', '/desktop/system.dictionary.Index/delete', '127.0.0.1', '1736749654');
INSERT INTO `operation_log` VALUES ('1554', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736749654');
INSERT INTO `operation_log` VALUES ('1555', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1736749703');
INSERT INTO `operation_log` VALUES ('1556', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1736749704');
INSERT INTO `operation_log` VALUES ('1557', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736749705');
INSERT INTO `operation_log` VALUES ('1558', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1736749711');
INSERT INTO `operation_log` VALUES ('1559', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1736749716');
INSERT INTO `operation_log` VALUES ('1560', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736749808');
INSERT INTO `operation_log` VALUES ('1561', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736749817');
INSERT INTO `operation_log` VALUES ('1562', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736749919');
INSERT INTO `operation_log` VALUES ('1563', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736749946');
INSERT INTO `operation_log` VALUES ('1564', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736749966');
INSERT INTO `operation_log` VALUES ('1565', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736749980');
INSERT INTO `operation_log` VALUES ('1566', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736750016');
INSERT INTO `operation_log` VALUES ('1567', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736750023');
INSERT INTO `operation_log` VALUES ('1568', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736750030');
INSERT INTO `operation_log` VALUES ('1569', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736750052');
INSERT INTO `operation_log` VALUES ('1570', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736750099');
INSERT INTO `operation_log` VALUES ('1571', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736754455');
INSERT INTO `operation_log` VALUES ('1572', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736754459');
INSERT INTO `operation_log` VALUES ('1573', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736754461');
INSERT INTO `operation_log` VALUES ('1574', '1', '/desktop/system.config.Index/save', '127.0.0.1', '1736754462');
INSERT INTO `operation_log` VALUES ('1575', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736754464');
INSERT INTO `operation_log` VALUES ('1576', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736754500');
INSERT INTO `operation_log` VALUES ('1577', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736754755');
INSERT INTO `operation_log` VALUES ('1578', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736754854');
INSERT INTO `operation_log` VALUES ('1579', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736754859');
INSERT INTO `operation_log` VALUES ('1580', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736754872');
INSERT INTO `operation_log` VALUES ('1581', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736754898');
INSERT INTO `operation_log` VALUES ('1582', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1736754902');
INSERT INTO `operation_log` VALUES ('1583', '1', '/desktop/system.user.Edit/save', '127.0.0.1', '1736754903');
INSERT INTO `operation_log` VALUES ('1584', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736754904');
INSERT INTO `operation_log` VALUES ('1585', '1', '/desktop/system.user.Index/offLine', '127.0.0.1', '1736754912');
INSERT INTO `operation_log` VALUES ('1586', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736754917');
INSERT INTO `operation_log` VALUES ('1587', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736754947');
INSERT INTO `operation_log` VALUES ('1588', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736754951');
INSERT INTO `operation_log` VALUES ('1589', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736754974');
INSERT INTO `operation_log` VALUES ('1590', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736754977');
INSERT INTO `operation_log` VALUES ('1591', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736754999');
INSERT INTO `operation_log` VALUES ('1592', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1736755016');
INSERT INTO `operation_log` VALUES ('1593', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736755021');
INSERT INTO `operation_log` VALUES ('1594', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1736755022');
INSERT INTO `operation_log` VALUES ('1595', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1736755025');
INSERT INTO `operation_log` VALUES ('1596', '1', '/desktop/system.role.Index/delete', '127.0.0.1', '1736755222');
INSERT INTO `operation_log` VALUES ('1597', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736755223');
INSERT INTO `operation_log` VALUES ('1598', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1736755228');
INSERT INTO `operation_log` VALUES ('1599', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1736755232');
INSERT INTO `operation_log` VALUES ('1600', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736755234');
INSERT INTO `operation_log` VALUES ('1601', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1736755237');
INSERT INTO `operation_log` VALUES ('1602', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736755239');
INSERT INTO `operation_log` VALUES ('1603', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1736755266');
INSERT INTO `operation_log` VALUES ('1604', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1736755269');
INSERT INTO `operation_log` VALUES ('1605', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736755273');
INSERT INTO `operation_log` VALUES ('1606', '1', '/desktop/system.mobile.permission.Edit/init', '127.0.0.1', '1736755276');
INSERT INTO `operation_log` VALUES ('1607', '1', '/desktop/system.mobile.permission.Edit/init', '127.0.0.1', '1736755278');
INSERT INTO `operation_log` VALUES ('1608', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736755280');
INSERT INTO `operation_log` VALUES ('1609', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1736755283');
INSERT INTO `operation_log` VALUES ('1610', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1736755284');
INSERT INTO `operation_log` VALUES ('1611', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1736755286');
INSERT INTO `operation_log` VALUES ('1612', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1736755289');
INSERT INTO `operation_log` VALUES ('1613', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1736755379');
INSERT INTO `operation_log` VALUES ('1614', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1736755382');
INSERT INTO `operation_log` VALUES ('1615', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736755389');
INSERT INTO `operation_log` VALUES ('1616', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736755390');
INSERT INTO `operation_log` VALUES ('1617', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736755393');
INSERT INTO `operation_log` VALUES ('1618', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736755547');
INSERT INTO `operation_log` VALUES ('1619', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1736755611');
INSERT INTO `operation_log` VALUES ('1620', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736755614');
INSERT INTO `operation_log` VALUES ('1621', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736755636');
INSERT INTO `operation_log` VALUES ('1622', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736755642');
INSERT INTO `operation_log` VALUES ('1623', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736755643');
INSERT INTO `operation_log` VALUES ('1624', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736755644');
INSERT INTO `operation_log` VALUES ('1625', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736755645');
INSERT INTO `operation_log` VALUES ('1626', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1736755649');
INSERT INTO `operation_log` VALUES ('1627', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736755650');
INSERT INTO `operation_log` VALUES ('1628', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1736755672');
INSERT INTO `operation_log` VALUES ('1629', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1736755674');
INSERT INTO `operation_log` VALUES ('1630', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736755675');
INSERT INTO `operation_log` VALUES ('1631', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1736755698');
INSERT INTO `operation_log` VALUES ('1632', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1736755700');
INSERT INTO `operation_log` VALUES ('1633', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1736755702');
INSERT INTO `operation_log` VALUES ('1634', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737189164');
INSERT INTO `operation_log` VALUES ('1635', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737189363');
INSERT INTO `operation_log` VALUES ('1636', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737189836');
INSERT INTO `operation_log` VALUES ('1637', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737189845');
INSERT INTO `operation_log` VALUES ('1638', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737190072');
INSERT INTO `operation_log` VALUES ('1639', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737190351');
INSERT INTO `operation_log` VALUES ('1640', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737190582');
INSERT INTO `operation_log` VALUES ('1641', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737190799');
INSERT INTO `operation_log` VALUES ('1642', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737190888');
INSERT INTO `operation_log` VALUES ('1643', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737190933');
INSERT INTO `operation_log` VALUES ('1644', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737190999');
INSERT INTO `operation_log` VALUES ('1645', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737191167');
INSERT INTO `operation_log` VALUES ('1646', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737191197');
INSERT INTO `operation_log` VALUES ('1647', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737191234');
INSERT INTO `operation_log` VALUES ('1648', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1737196887');
INSERT INTO `operation_log` VALUES ('1649', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1737196897');
INSERT INTO `operation_log` VALUES ('1650', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1737196913');
INSERT INTO `operation_log` VALUES ('1651', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737196916');
INSERT INTO `operation_log` VALUES ('1652', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737196923');
INSERT INTO `operation_log` VALUES ('1653', '1', '/desktop/system.desktop.route.Add/save', '127.0.0.1', '1737197130');
INSERT INTO `operation_log` VALUES ('1654', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197131');
INSERT INTO `operation_log` VALUES ('1655', '1', '/desktop/system.desktop.route.Index/delete', '127.0.0.1', '1737197152');
INSERT INTO `operation_log` VALUES ('1656', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197152');
INSERT INTO `operation_log` VALUES ('1657', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197235');
INSERT INTO `operation_log` VALUES ('1658', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197235');
INSERT INTO `operation_log` VALUES ('1659', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197243');
INSERT INTO `operation_log` VALUES ('1660', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197244');
INSERT INTO `operation_log` VALUES ('1661', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197251');
INSERT INTO `operation_log` VALUES ('1662', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197258');
INSERT INTO `operation_log` VALUES ('1663', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197307');
INSERT INTO `operation_log` VALUES ('1664', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197313');
INSERT INTO `operation_log` VALUES ('1665', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197456');
INSERT INTO `operation_log` VALUES ('1666', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197466');
INSERT INTO `operation_log` VALUES ('1667', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737197500');
INSERT INTO `operation_log` VALUES ('1668', '1', '/desktop/system.desktop.route.Add/save', '127.0.0.1', '1737197652');
INSERT INTO `operation_log` VALUES ('1669', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737197652');
INSERT INTO `operation_log` VALUES ('1670', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737197655');
INSERT INTO `operation_log` VALUES ('1671', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1737197657');
INSERT INTO `operation_log` VALUES ('1672', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1737197662');
INSERT INTO `operation_log` VALUES ('1673', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737197663');
INSERT INTO `operation_log` VALUES ('1674', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1737197665');
INSERT INTO `operation_log` VALUES ('1675', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1737197690');
INSERT INTO `operation_log` VALUES ('1676', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737197691');
INSERT INTO `operation_log` VALUES ('1677', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737198251');
INSERT INTO `operation_log` VALUES ('1678', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737198257');
INSERT INTO `operation_log` VALUES ('1679', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737198260');
INSERT INTO `operation_log` VALUES ('1680', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737198285');
INSERT INTO `operation_log` VALUES ('1681', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1737198289');
INSERT INTO `operation_log` VALUES ('1682', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1737198303');
INSERT INTO `operation_log` VALUES ('1683', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737198304');
INSERT INTO `operation_log` VALUES ('1684', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737198308');
INSERT INTO `operation_log` VALUES ('1685', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198415');
INSERT INTO `operation_log` VALUES ('1686', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1737198423');
INSERT INTO `operation_log` VALUES ('1687', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1737198428');
INSERT INTO `operation_log` VALUES ('1688', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198429');
INSERT INTO `operation_log` VALUES ('1689', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1737198431');
INSERT INTO `operation_log` VALUES ('1690', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1737198439');
INSERT INTO `operation_log` VALUES ('1691', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198439');
INSERT INTO `operation_log` VALUES ('1692', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1737198442');
INSERT INTO `operation_log` VALUES ('1693', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1737198446');
INSERT INTO `operation_log` VALUES ('1694', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198446');
INSERT INTO `operation_log` VALUES ('1695', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1737198597');
INSERT INTO `operation_log` VALUES ('1696', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1737198601');
INSERT INTO `operation_log` VALUES ('1697', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198602');
INSERT INTO `operation_log` VALUES ('1698', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1737198604');
INSERT INTO `operation_log` VALUES ('1699', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1737198611');
INSERT INTO `operation_log` VALUES ('1700', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198612');
INSERT INTO `operation_log` VALUES ('1701', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1737198614');
INSERT INTO `operation_log` VALUES ('1702', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1737198618');
INSERT INTO `operation_log` VALUES ('1703', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198619');
INSERT INTO `operation_log` VALUES ('1704', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1737198641');
INSERT INTO `operation_log` VALUES ('1705', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1737198647');
INSERT INTO `operation_log` VALUES ('1706', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1737198652');
INSERT INTO `operation_log` VALUES ('1707', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198653');
INSERT INTO `operation_log` VALUES ('1708', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198800');
INSERT INTO `operation_log` VALUES ('1709', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198850');
INSERT INTO `operation_log` VALUES ('1710', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198885');
INSERT INTO `operation_log` VALUES ('1711', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737198904');
INSERT INTO `operation_log` VALUES ('1712', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737199062');
INSERT INTO `operation_log` VALUES ('1713', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199067');
INSERT INTO `operation_log` VALUES ('1714', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1737199071');
INSERT INTO `operation_log` VALUES ('1715', '1', '/desktop/system.desktop.route.Edit/save', '127.0.0.1', '1737199080');
INSERT INTO `operation_log` VALUES ('1716', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199080');
INSERT INTO `operation_log` VALUES ('1717', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1737199085');
INSERT INTO `operation_log` VALUES ('1718', '1', '/desktop/system.desktop.route.Edit/save', '127.0.0.1', '1737199126');
INSERT INTO `operation_log` VALUES ('1719', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199126');
INSERT INTO `operation_log` VALUES ('1720', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1737199128');
INSERT INTO `operation_log` VALUES ('1721', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737199129');
INSERT INTO `operation_log` VALUES ('1722', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1737199131');
INSERT INTO `operation_log` VALUES ('1723', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1737199135');
INSERT INTO `operation_log` VALUES ('1724', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737199136');
INSERT INTO `operation_log` VALUES ('1725', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737199353');
INSERT INTO `operation_log` VALUES ('1726', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199362');
INSERT INTO `operation_log` VALUES ('1727', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1737199370');
INSERT INTO `operation_log` VALUES ('1728', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1737199395');
INSERT INTO `operation_log` VALUES ('1729', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1737199400');
INSERT INTO `operation_log` VALUES ('1730', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199408');
INSERT INTO `operation_log` VALUES ('1731', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1737199411');
INSERT INTO `operation_log` VALUES ('1732', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1737199417');
INSERT INTO `operation_log` VALUES ('1733', '1', '/desktop/system.desktop.route.Edit/save', '127.0.0.1', '1737199457');
INSERT INTO `operation_log` VALUES ('1734', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199457');
INSERT INTO `operation_log` VALUES ('1735', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199465');
INSERT INTO `operation_log` VALUES ('1736', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199515');
INSERT INTO `operation_log` VALUES ('1737', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199516');
INSERT INTO `operation_log` VALUES ('1738', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199531');
INSERT INTO `operation_log` VALUES ('1739', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737199532');
INSERT INTO `operation_log` VALUES ('1740', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1737201149');
INSERT INTO `operation_log` VALUES ('1741', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737201154');
INSERT INTO `operation_log` VALUES ('1742', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1737201156');
INSERT INTO `operation_log` VALUES ('1743', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737201395');
INSERT INTO `operation_log` VALUES ('1744', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737201397');
INSERT INTO `operation_log` VALUES ('1745', '1', '/desktop/system.desktop.route.Index/delete', '127.0.0.1', '1737201402');
INSERT INTO `operation_log` VALUES ('1746', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737201403');
INSERT INTO `operation_log` VALUES ('1747', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737201406');
INSERT INTO `operation_log` VALUES ('1748', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1737201410');
INSERT INTO `operation_log` VALUES ('1749', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1737201412');
INSERT INTO `operation_log` VALUES ('1750', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737201412');
INSERT INTO `operation_log` VALUES ('1751', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1737201413');
INSERT INTO `operation_log` VALUES ('1752', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1737201414');
INSERT INTO `operation_log` VALUES ('1753', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737201415');
INSERT INTO `operation_log` VALUES ('1754', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737201421');
INSERT INTO `operation_log` VALUES ('1755', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737201564');
INSERT INTO `operation_log` VALUES ('1756', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1737201586');
INSERT INTO `operation_log` VALUES ('1757', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737201592');
INSERT INTO `operation_log` VALUES ('1758', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1737201593');
INSERT INTO `operation_log` VALUES ('1759', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737201663');
INSERT INTO `operation_log` VALUES ('1760', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1737201664');
INSERT INTO `operation_log` VALUES ('1761', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1737201666');
INSERT INTO `operation_log` VALUES ('1762', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737201668');
INSERT INTO `operation_log` VALUES ('1763', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1737343956');
INSERT INTO `operation_log` VALUES ('1764', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1737344212');
INSERT INTO `operation_log` VALUES ('1765', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1737344216');
INSERT INTO `operation_log` VALUES ('1766', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1737344218');
INSERT INTO `operation_log` VALUES ('1767', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1737344221');
INSERT INTO `operation_log` VALUES ('1768', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1737344223');
INSERT INTO `operation_log` VALUES ('1769', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1737344225');
INSERT INTO `operation_log` VALUES ('1770', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1737344227');
INSERT INTO `operation_log` VALUES ('1771', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1737344229');
INSERT INTO `operation_log` VALUES ('1772', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1737344231');
INSERT INTO `operation_log` VALUES ('1773', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1737344233');
INSERT INTO `operation_log` VALUES ('1774', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1737344257');
INSERT INTO `operation_log` VALUES ('1775', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1737344263');
INSERT INTO `operation_log` VALUES ('1776', '1', '/desktop/system.user.Index/getUserPaginate', '172.18.0.2', '1740034743');
INSERT INTO `operation_log` VALUES ('1777', '1', '/desktop/system.department.Index/getTreeDepartment', '172.18.0.2', '1740034745');
INSERT INTO `operation_log` VALUES ('1778', '1', '/desktop/system.role.Index/getRolePaginate', '172.18.0.2', '1740034749');
INSERT INTO `operation_log` VALUES ('1779', '1', '/desktop/system.config.Index/init', '172.18.0.2', '1740034750');
INSERT INTO `operation_log` VALUES ('1780', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '172.18.0.2', '1740034753');
INSERT INTO `operation_log` VALUES ('1781', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '172.18.0.2', '1740034755');
INSERT INTO `operation_log` VALUES ('1782', '1', '/desktop/system.config.Index/init', '172.18.0.2', '1740040351');
INSERT INTO `operation_log` VALUES ('1783', '1', '/desktop/system.config.Index/save', '172.18.0.2', '1740040354');
INSERT INTO `operation_log` VALUES ('1784', '1', '/desktop/system.role.Index/getRolePaginate', '172.18.0.2', '1740040358');
INSERT INTO `operation_log` VALUES ('1785', '1', '/desktop/system.role.Edit/init', '172.18.0.2', '1740040363');
INSERT INTO `operation_log` VALUES ('1786', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '172.18.0.2', '1740040368');
INSERT INTO `operation_log` VALUES ('1787', '1', '/desktop/system.dictionary.Edit/init', '172.18.0.2', '1740040370');
INSERT INTO `operation_log` VALUES ('1788', '1', '/desktop/system.dictionary.Edit/save', '172.18.0.2', '1740040372');
INSERT INTO `operation_log` VALUES ('1789', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '172.18.0.2', '1740040373');
INSERT INTO `operation_log` VALUES ('1790', '1', '/desktop/system.config.Index/init', '172.18.0.2', '1740040425');
INSERT INTO `operation_log` VALUES ('1791', '1', '/desktop/system.user.Index/getUserPaginate', '172.18.0.2', '1740040429');
INSERT INTO `operation_log` VALUES ('1792', '1', '/desktop/system.department.Index/getTreeDepartment', '172.18.0.2', '1740040441');
INSERT INTO `operation_log` VALUES ('1793', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740727578');
INSERT INTO `operation_log` VALUES ('1794', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740727742');
INSERT INTO `operation_log` VALUES ('1795', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740727776');
INSERT INTO `operation_log` VALUES ('1796', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740727782');
INSERT INTO `operation_log` VALUES ('1797', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740727802');
INSERT INTO `operation_log` VALUES ('1798', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740727849');
INSERT INTO `operation_log` VALUES ('1799', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740727859');
INSERT INTO `operation_log` VALUES ('1800', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728174');
INSERT INTO `operation_log` VALUES ('1801', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728178');
INSERT INTO `operation_log` VALUES ('1802', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728188');
INSERT INTO `operation_log` VALUES ('1803', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728211');
INSERT INTO `operation_log` VALUES ('1804', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728264');
INSERT INTO `operation_log` VALUES ('1805', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728278');
INSERT INTO `operation_log` VALUES ('1806', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728366');
INSERT INTO `operation_log` VALUES ('1807', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728366');
INSERT INTO `operation_log` VALUES ('1808', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728386');
INSERT INTO `operation_log` VALUES ('1809', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728393');
INSERT INTO `operation_log` VALUES ('1810', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728581');
INSERT INTO `operation_log` VALUES ('1811', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728586');
INSERT INTO `operation_log` VALUES ('1812', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728596');
INSERT INTO `operation_log` VALUES ('1813', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728816');
INSERT INTO `operation_log` VALUES ('1814', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728940');
INSERT INTO `operation_log` VALUES ('1815', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728978');
INSERT INTO `operation_log` VALUES ('1816', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740728984');
INSERT INTO `operation_log` VALUES ('1817', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729035');
INSERT INTO `operation_log` VALUES ('1818', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729043');
INSERT INTO `operation_log` VALUES ('1819', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729073');
INSERT INTO `operation_log` VALUES ('1820', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729111');
INSERT INTO `operation_log` VALUES ('1821', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729167');
INSERT INTO `operation_log` VALUES ('1822', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729176');
INSERT INTO `operation_log` VALUES ('1823', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729183');
INSERT INTO `operation_log` VALUES ('1824', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729199');
INSERT INTO `operation_log` VALUES ('1825', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729205');
INSERT INTO `operation_log` VALUES ('1826', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729230');
INSERT INTO `operation_log` VALUES ('1827', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729235');
INSERT INTO `operation_log` VALUES ('1828', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729236');
INSERT INTO `operation_log` VALUES ('1829', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729240');
INSERT INTO `operation_log` VALUES ('1830', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729254');
INSERT INTO `operation_log` VALUES ('1831', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729342');
INSERT INTO `operation_log` VALUES ('1832', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729350');
INSERT INTO `operation_log` VALUES ('1833', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729356');
INSERT INTO `operation_log` VALUES ('1834', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729393');
INSERT INTO `operation_log` VALUES ('1835', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729424');
INSERT INTO `operation_log` VALUES ('1836', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740729499');
INSERT INTO `operation_log` VALUES ('1837', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740730330');
INSERT INTO `operation_log` VALUES ('1838', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1740730337');
INSERT INTO `operation_log` VALUES ('1839', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1744108301');
INSERT INTO `operation_log` VALUES ('1840', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1744108304');
INSERT INTO `operation_log` VALUES ('1841', '1', '/desktop/statistic.OrderTrend/exp', '127.0.0.1', '1744108306');
INSERT INTO `operation_log` VALUES ('1842', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1744108317');
INSERT INTO `operation_log` VALUES ('1843', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1744108320');
INSERT INTO `operation_log` VALUES ('1844', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1744108325');
INSERT INTO `operation_log` VALUES ('1845', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1744108326');
INSERT INTO `operation_log` VALUES ('1846', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1744108328');
INSERT INTO `operation_log` VALUES ('1847', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1744108332');
INSERT INTO `operation_log` VALUES ('1848', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1744108336');
INSERT INTO `operation_log` VALUES ('1849', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1744108340');
INSERT INTO `operation_log` VALUES ('1850', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1744108343');
INSERT INTO `operation_log` VALUES ('1851', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1744108348');
INSERT INTO `operation_log` VALUES ('1852', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1744108351');
INSERT INTO `operation_log` VALUES ('1853', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1744108354');
INSERT INTO `operation_log` VALUES ('1854', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1744108356');
INSERT INTO `operation_log` VALUES ('1855', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1744108358');
INSERT INTO `operation_log` VALUES ('1856', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1744108360');
INSERT INTO `operation_log` VALUES ('1857', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1744108362');
INSERT INTO `operation_log` VALUES ('1858', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1744108363');
INSERT INTO `operation_log` VALUES ('1859', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1744108365');
INSERT INTO `operation_log` VALUES ('1860', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1744108366');
INSERT INTO `operation_log` VALUES ('1861', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1744192180');
INSERT INTO `operation_log` VALUES ('1862', '1', '/desktop/statistic.OrderTrend/exp', '127.0.0.1', '1744192182');
INSERT INTO `operation_log` VALUES ('1863', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1744192191');
INSERT INTO `operation_log` VALUES ('1864', '1', '/desktop/system.config.Index/save', '127.0.0.1', '1744192194');
INSERT INTO `operation_log` VALUES ('1865', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1744192198');
INSERT INTO `operation_log` VALUES ('1866', '1', '/desktop/system.config.Index/save', '127.0.0.1', '1744192248');
INSERT INTO `operation_log` VALUES ('1867', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1744192277');
INSERT INTO `operation_log` VALUES ('1868', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1744192279');
INSERT INTO `operation_log` VALUES ('1869', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1744192316');
INSERT INTO `operation_log` VALUES ('1870', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1744192334');
INSERT INTO `operation_log` VALUES ('1871', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1744192367');
INSERT INTO `operation_log` VALUES ('1872', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1744192475');
INSERT INTO `operation_log` VALUES ('1873', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1744192481');
INSERT INTO `operation_log` VALUES ('1874', '1', '/desktop/system.user.Add/save', '127.0.0.1', '1744192532');
INSERT INTO `operation_log` VALUES ('1875', '1', '/desktop/system.user.Add/save', '127.0.0.1', '1744192540');
INSERT INTO `operation_log` VALUES ('1876', '1', '/desktop/system.user.Add/save', '127.0.0.1', '1744192548');
INSERT INTO `operation_log` VALUES ('1877', '1', '/desktop/system.user.Add/save', '127.0.0.1', '1744192575');
INSERT INTO `operation_log` VALUES ('1878', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1744192577');
INSERT INTO `operation_log` VALUES ('1879', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1744192581');
INSERT INTO `operation_log` VALUES ('1880', '1', '/desktop/system.user.Edit/save', '127.0.0.1', '1744192585');
INSERT INTO `operation_log` VALUES ('1881', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1744192586');
INSERT INTO `operation_log` VALUES ('1882', '1', '/desktop/system.user.Edit/init', '127.0.0.1', '1744192588');
INSERT INTO `operation_log` VALUES ('1883', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1744192591');
INSERT INTO `operation_log` VALUES ('1884', '1', '/desktop/system.user.Index/editStatus', '127.0.0.1', '1744192592');
INSERT INTO `operation_log` VALUES ('1885', '1', '/desktop/system.user.EditPassword/save', '127.0.0.1', '1744192604');
INSERT INTO `operation_log` VALUES ('1886', '1', '/desktop/system.user.EditPassword/save', '127.0.0.1', '1744192615');
INSERT INTO `operation_log` VALUES ('1887', '1', '/desktop/system.user.EditPassword/save', '127.0.0.1', '1744192645');
INSERT INTO `operation_log` VALUES ('1888', '1', '/desktop/system.user.EditPassword/save', '127.0.0.1', '1744192717');
INSERT INTO `operation_log` VALUES ('1889', '1', '/desktop/system.user.Index/offLine', '127.0.0.1', '1744192723');
INSERT INTO `operation_log` VALUES ('1890', '1', '/desktop/system.user.Index/offLine', '127.0.0.1', '1744192779');
INSERT INTO `operation_log` VALUES ('1891', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1744192785');
INSERT INTO `operation_log` VALUES ('1892', '1', '/desktop/system.department.Add/save', '127.0.0.1', '1744192793');
INSERT INTO `operation_log` VALUES ('1893', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1744192793');
INSERT INTO `operation_log` VALUES ('1894', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1744192795');
INSERT INTO `operation_log` VALUES ('1895', '1', '/desktop/system.department.Edit/save', '127.0.0.1', '1744192798');
INSERT INTO `operation_log` VALUES ('1896', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1744192798');
INSERT INTO `operation_log` VALUES ('1897', '1', '/desktop/system.department.Index/delete', '127.0.0.1', '1744192801');
INSERT INTO `operation_log` VALUES ('1898', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1744192801');
INSERT INTO `operation_log` VALUES ('1899', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1744192803');
INSERT INTO `operation_log` VALUES ('1900', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1744192804');
INSERT INTO `operation_log` VALUES ('1901', '1', '/desktop/system.role.Add/save', '127.0.0.1', '1744192813');
INSERT INTO `operation_log` VALUES ('1902', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1744192814');
INSERT INTO `operation_log` VALUES ('1903', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1744192815');
INSERT INTO `operation_log` VALUES ('1904', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1744192824');
INSERT INTO `operation_log` VALUES ('1905', '1', '/desktop/system.role.Edit/init', '127.0.0.1', '1744192999');
INSERT INTO `operation_log` VALUES ('1906', '1', '/desktop/system.role.Edit/save', '127.0.0.1', '1744193006');
INSERT INTO `operation_log` VALUES ('1907', '1', '/desktop/system.role.Index/delete', '127.0.0.1', '1744193883');
INSERT INTO `operation_log` VALUES ('1908', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1744193883');
INSERT INTO `operation_log` VALUES ('1909', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1744193887');
INSERT INTO `operation_log` VALUES ('1910', '1', '/desktop/system.desktop.menu.Add/save', '127.0.0.1', '1744193894');
INSERT INTO `operation_log` VALUES ('1911', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1744193894');
INSERT INTO `operation_log` VALUES ('1912', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1744193896');
INSERT INTO `operation_log` VALUES ('1913', '1', '/desktop/system.desktop.menu.Edit/save', '127.0.0.1', '1744193897');
INSERT INTO `operation_log` VALUES ('1914', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1744193898');
INSERT INTO `operation_log` VALUES ('1915', '1', '/desktop/system.desktop.menu.Index/delete', '127.0.0.1', '1744193900');
INSERT INTO `operation_log` VALUES ('1916', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1744193900');
INSERT INTO `operation_log` VALUES ('1917', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1744193902');
INSERT INTO `operation_log` VALUES ('1918', '1', '/desktop/system.desktop.permission.Add/save', '127.0.0.1', '1744193913');
INSERT INTO `operation_log` VALUES ('1919', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1744193914');
INSERT INTO `operation_log` VALUES ('1920', '1', '/desktop/system.desktop.permission.Index/delete', '127.0.0.1', '1744193916');
INSERT INTO `operation_log` VALUES ('1921', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1744193916');
INSERT INTO `operation_log` VALUES ('1922', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1744193918');
INSERT INTO `operation_log` VALUES ('1923', '1', '/desktop/system.desktop.route.Add/save', '127.0.0.1', '1744193932');
INSERT INTO `operation_log` VALUES ('1924', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1744193932');
INSERT INTO `operation_log` VALUES ('1925', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1744193937');
INSERT INTO `operation_log` VALUES ('1926', '1', '/desktop/system.desktop.route.Index/delete', '127.0.0.1', '1744193940');
INSERT INTO `operation_log` VALUES ('1927', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1744193941');
INSERT INTO `operation_log` VALUES ('1928', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1744193983');
INSERT INTO `operation_log` VALUES ('1929', '1', '/desktop/system.mobile.permission.Add/save', '127.0.0.1', '1744193989');
INSERT INTO `operation_log` VALUES ('1930', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1744193989');
INSERT INTO `operation_log` VALUES ('1931', '1', '/desktop/system.mobile.permission.Edit/init', '127.0.0.1', '1744193991');
INSERT INTO `operation_log` VALUES ('1932', '1', '/desktop/system.mobile.permission.Edit/save', '127.0.0.1', '1744193993');
INSERT INTO `operation_log` VALUES ('1933', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1744193993');
INSERT INTO `operation_log` VALUES ('1934', '1', '/desktop/system.mobile.permission.Index/delete', '127.0.0.1', '1744193995');
INSERT INTO `operation_log` VALUES ('1935', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1744193995');
INSERT INTO `operation_log` VALUES ('1936', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1744193997');
INSERT INTO `operation_log` VALUES ('1937', '1', '/desktop/system.dictionary.Add/save', '127.0.0.1', '1744194003');
INSERT INTO `operation_log` VALUES ('1938', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1744194003');
INSERT INTO `operation_log` VALUES ('1939', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1744194005');
INSERT INTO `operation_log` VALUES ('1940', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1744194006');
INSERT INTO `operation_log` VALUES ('1941', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1744194007');
INSERT INTO `operation_log` VALUES ('1942', '1', '/desktop/system.dictionary.Index/delete', '127.0.0.1', '1744194009');
INSERT INTO `operation_log` VALUES ('1943', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1744194009');
INSERT INTO `operation_log` VALUES ('1944', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1744194010');
INSERT INTO `operation_log` VALUES ('1945', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1744194012');
INSERT INTO `operation_log` VALUES ('1946', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465206');
INSERT INTO `operation_log` VALUES ('1947', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465229');
INSERT INTO `operation_log` VALUES ('1948', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465234');
INSERT INTO `operation_log` VALUES ('1949', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465295');
INSERT INTO `operation_log` VALUES ('1950', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465430');
INSERT INTO `operation_log` VALUES ('1951', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465436');
INSERT INTO `operation_log` VALUES ('1952', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465446');
INSERT INTO `operation_log` VALUES ('1953', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465461');
INSERT INTO `operation_log` VALUES ('1954', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465472');
INSERT INTO `operation_log` VALUES ('1955', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465478');
INSERT INTO `operation_log` VALUES ('1956', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465501');
INSERT INTO `operation_log` VALUES ('1957', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465513');
INSERT INTO `operation_log` VALUES ('1958', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465515');
INSERT INTO `operation_log` VALUES ('1959', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465529');
INSERT INTO `operation_log` VALUES ('1960', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465621');
INSERT INTO `operation_log` VALUES ('1961', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465905');
INSERT INTO `operation_log` VALUES ('1962', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745465908');
INSERT INTO `operation_log` VALUES ('1963', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745744032');
INSERT INTO `operation_log` VALUES ('1964', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745744038');
INSERT INTO `operation_log` VALUES ('1965', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745744081');
INSERT INTO `operation_log` VALUES ('1966', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1745744131');
INSERT INTO `operation_log` VALUES ('1967', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745749086');
INSERT INTO `operation_log` VALUES ('1968', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745749097');
INSERT INTO `operation_log` VALUES ('1969', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745749098');
INSERT INTO `operation_log` VALUES ('1970', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745749102');
INSERT INTO `operation_log` VALUES ('1971', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745749102');
INSERT INTO `operation_log` VALUES ('1972', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745749103');
INSERT INTO `operation_log` VALUES ('1973', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745749103');
INSERT INTO `operation_log` VALUES ('1974', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745749115');
INSERT INTO `operation_log` VALUES ('1975', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745749154');
INSERT INTO `operation_log` VALUES ('1976', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1745749167');
INSERT INTO `operation_log` VALUES ('1977', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745749170');
INSERT INTO `operation_log` VALUES ('1978', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745749170');
INSERT INTO `operation_log` VALUES ('1979', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745749171');
INSERT INTO `operation_log` VALUES ('1980', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745749179');
INSERT INTO `operation_log` VALUES ('1981', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745749179');
INSERT INTO `operation_log` VALUES ('1982', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745749180');
INSERT INTO `operation_log` VALUES ('1983', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745749180');
INSERT INTO `operation_log` VALUES ('1984', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745749180');
INSERT INTO `operation_log` VALUES ('1985', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745749180');
INSERT INTO `operation_log` VALUES ('1986', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745749180');
INSERT INTO `operation_log` VALUES ('1987', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745749181');
INSERT INTO `operation_log` VALUES ('1988', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745749181');
INSERT INTO `operation_log` VALUES ('1989', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1745749212');
INSERT INTO `operation_log` VALUES ('1990', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745749214');
INSERT INTO `operation_log` VALUES ('1991', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745749214');
INSERT INTO `operation_log` VALUES ('1992', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745749214');
INSERT INTO `operation_log` VALUES ('1993', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745749243');
INSERT INTO `operation_log` VALUES ('1994', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745749243');
INSERT INTO `operation_log` VALUES ('1995', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745749245');
INSERT INTO `operation_log` VALUES ('1996', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745749245');
INSERT INTO `operation_log` VALUES ('1997', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745749245');
INSERT INTO `operation_log` VALUES ('1998', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745749245');
INSERT INTO `operation_log` VALUES ('1999', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745749245');
INSERT INTO `operation_log` VALUES ('2000', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745749245');
INSERT INTO `operation_log` VALUES ('2001', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745749245');
INSERT INTO `operation_log` VALUES ('2002', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1745749298');
INSERT INTO `operation_log` VALUES ('2003', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1745749301');
INSERT INTO `operation_log` VALUES ('2004', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1745749304');
INSERT INTO `operation_log` VALUES ('2005', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1745749306');
INSERT INTO `operation_log` VALUES ('2006', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1745749307');
INSERT INTO `operation_log` VALUES ('2007', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1745749309');
INSERT INTO `operation_log` VALUES ('2008', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745749337');
INSERT INTO `operation_log` VALUES ('2009', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745749339');
INSERT INTO `operation_log` VALUES ('2010', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745749340');
INSERT INTO `operation_log` VALUES ('2011', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745749342');
INSERT INTO `operation_log` VALUES ('2012', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745749342');
INSERT INTO `operation_log` VALUES ('2013', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745749342');
INSERT INTO `operation_log` VALUES ('2014', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745749342');
INSERT INTO `operation_log` VALUES ('2015', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745749342');
INSERT INTO `operation_log` VALUES ('2016', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745749371');
INSERT INTO `operation_log` VALUES ('2017', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1745749373');
INSERT INTO `operation_log` VALUES ('2018', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745749384');
INSERT INTO `operation_log` VALUES ('2019', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745749394');
INSERT INTO `operation_log` VALUES ('2020', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745749396');
INSERT INTO `operation_log` VALUES ('2021', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745749396');
INSERT INTO `operation_log` VALUES ('2022', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745749396');
INSERT INTO `operation_log` VALUES ('2023', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745749462');
INSERT INTO `operation_log` VALUES ('2024', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745749462');
INSERT INTO `operation_log` VALUES ('2025', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745749462');
INSERT INTO `operation_log` VALUES ('2026', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745749462');
INSERT INTO `operation_log` VALUES ('2027', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745749462');
INSERT INTO `operation_log` VALUES ('2028', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745749462');
INSERT INTO `operation_log` VALUES ('2029', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745749463');
INSERT INTO `operation_log` VALUES ('2030', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1745749481');
INSERT INTO `operation_log` VALUES ('2031', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1745749482');
INSERT INTO `operation_log` VALUES ('2032', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1745749485');
INSERT INTO `operation_log` VALUES ('2033', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745749487');
INSERT INTO `operation_log` VALUES ('2034', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745749488');
INSERT INTO `operation_log` VALUES ('2035', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1745749489');
INSERT INTO `operation_log` VALUES ('2036', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1745749490');
INSERT INTO `operation_log` VALUES ('2037', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1745749492');
INSERT INTO `operation_log` VALUES ('2038', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745749493');
INSERT INTO `operation_log` VALUES ('2039', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745749493');
INSERT INTO `operation_log` VALUES ('2040', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745749493');
INSERT INTO `operation_log` VALUES ('2041', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1745749495');
INSERT INTO `operation_log` VALUES ('2042', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745749519');
INSERT INTO `operation_log` VALUES ('2043', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1745749530');
INSERT INTO `operation_log` VALUES ('2044', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745749531');
INSERT INTO `operation_log` VALUES ('2045', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745749531');
INSERT INTO `operation_log` VALUES ('2046', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745749532');
INSERT INTO `operation_log` VALUES ('2047', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1745749533');
INSERT INTO `operation_log` VALUES ('2048', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1745749534');
INSERT INTO `operation_log` VALUES ('2049', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1745749535');
INSERT INTO `operation_log` VALUES ('2050', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1745749538');
INSERT INTO `operation_log` VALUES ('2051', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1745749539');
INSERT INTO `operation_log` VALUES ('2052', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1745749541');
INSERT INTO `operation_log` VALUES ('2053', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745749542');
INSERT INTO `operation_log` VALUES ('2054', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745749542');
INSERT INTO `operation_log` VALUES ('2055', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745805772');
INSERT INTO `operation_log` VALUES ('2056', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745805773');
INSERT INTO `operation_log` VALUES ('2057', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745805776');
INSERT INTO `operation_log` VALUES ('2058', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745805776');
INSERT INTO `operation_log` VALUES ('2059', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745805776');
INSERT INTO `operation_log` VALUES ('2060', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745805776');
INSERT INTO `operation_log` VALUES ('2061', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745805792');
INSERT INTO `operation_log` VALUES ('2062', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1745805801');
INSERT INTO `operation_log` VALUES ('2063', '1', '/desktop/system.config.Index/save', '127.0.0.1', '1745805812');
INSERT INTO `operation_log` VALUES ('2064', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745805815');
INSERT INTO `operation_log` VALUES ('2065', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745805815');
INSERT INTO `operation_log` VALUES ('2066', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745805815');
INSERT INTO `operation_log` VALUES ('2067', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1745805824');
INSERT INTO `operation_log` VALUES ('2068', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1745805826');
INSERT INTO `operation_log` VALUES ('2069', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1745805829');
INSERT INTO `operation_log` VALUES ('2070', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1745805831');
INSERT INTO `operation_log` VALUES ('2071', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1745805832');
INSERT INTO `operation_log` VALUES ('2072', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1745805844');
INSERT INTO `operation_log` VALUES ('2073', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745805846');
INSERT INTO `operation_log` VALUES ('2074', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745805871');
INSERT INTO `operation_log` VALUES ('2075', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745806403');
INSERT INTO `operation_log` VALUES ('2076', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745806403');
INSERT INTO `operation_log` VALUES ('2077', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745806404');
INSERT INTO `operation_log` VALUES ('2078', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745806404');
INSERT INTO `operation_log` VALUES ('2079', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745806404');
INSERT INTO `operation_log` VALUES ('2080', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745806404');
INSERT INTO `operation_log` VALUES ('2081', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745806404');
INSERT INTO `operation_log` VALUES ('2082', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745806407');
INSERT INTO `operation_log` VALUES ('2083', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745806449');
INSERT INTO `operation_log` VALUES ('2084', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745806449');
INSERT INTO `operation_log` VALUES ('2085', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745806450');
INSERT INTO `operation_log` VALUES ('2086', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745806450');
INSERT INTO `operation_log` VALUES ('2087', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745806450');
INSERT INTO `operation_log` VALUES ('2088', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745806451');
INSERT INTO `operation_log` VALUES ('2089', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745806451');
INSERT INTO `operation_log` VALUES ('2090', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745806458');
INSERT INTO `operation_log` VALUES ('2091', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745807472');
INSERT INTO `operation_log` VALUES ('2092', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745807472');
INSERT INTO `operation_log` VALUES ('2093', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745807474');
INSERT INTO `operation_log` VALUES ('2094', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745807474');
INSERT INTO `operation_log` VALUES ('2095', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745807474');
INSERT INTO `operation_log` VALUES ('2096', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745807474');
INSERT INTO `operation_log` VALUES ('2097', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745807474');
INSERT INTO `operation_log` VALUES ('2098', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745807478');
INSERT INTO `operation_log` VALUES ('2099', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745807479');
INSERT INTO `operation_log` VALUES ('2100', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745807482');
INSERT INTO `operation_log` VALUES ('2101', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745807482');
INSERT INTO `operation_log` VALUES ('2102', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745807482');
INSERT INTO `operation_log` VALUES ('2103', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745807482');
INSERT INTO `operation_log` VALUES ('2104', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745807482');
INSERT INTO `operation_log` VALUES ('2105', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745808081');
INSERT INTO `operation_log` VALUES ('2106', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745808081');
INSERT INTO `operation_log` VALUES ('2107', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745808084');
INSERT INTO `operation_log` VALUES ('2108', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745808084');
INSERT INTO `operation_log` VALUES ('2109', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745808084');
INSERT INTO `operation_log` VALUES ('2110', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745808084');
INSERT INTO `operation_log` VALUES ('2111', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745808095');
INSERT INTO `operation_log` VALUES ('2112', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808098');
INSERT INTO `operation_log` VALUES ('2113', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808146');
INSERT INTO `operation_log` VALUES ('2114', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808157');
INSERT INTO `operation_log` VALUES ('2115', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808179');
INSERT INTO `operation_log` VALUES ('2116', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808193');
INSERT INTO `operation_log` VALUES ('2117', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808203');
INSERT INTO `operation_log` VALUES ('2118', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808217');
INSERT INTO `operation_log` VALUES ('2119', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808225');
INSERT INTO `operation_log` VALUES ('2120', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808236');
INSERT INTO `operation_log` VALUES ('2121', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808286');
INSERT INTO `operation_log` VALUES ('2122', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1745808295');
INSERT INTO `operation_log` VALUES ('2123', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745808295');
INSERT INTO `operation_log` VALUES ('2124', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808385');
INSERT INTO `operation_log` VALUES ('2125', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1745808389');
INSERT INTO `operation_log` VALUES ('2126', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745808389');
INSERT INTO `operation_log` VALUES ('2127', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1745808390');
INSERT INTO `operation_log` VALUES ('2128', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1745808393');
INSERT INTO `operation_log` VALUES ('2129', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1745808393');
INSERT INTO `operation_log` VALUES ('2130', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745808401');
INSERT INTO `operation_log` VALUES ('2131', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745808591');
INSERT INTO `operation_log` VALUES ('2132', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745808604');
INSERT INTO `operation_log` VALUES ('2133', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745808650');
INSERT INTO `operation_log` VALUES ('2134', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745808685');
INSERT INTO `operation_log` VALUES ('2135', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745808755');
INSERT INTO `operation_log` VALUES ('2136', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745808763');
INSERT INTO `operation_log` VALUES ('2137', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745808766');
INSERT INTO `operation_log` VALUES ('2138', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745808776');
INSERT INTO `operation_log` VALUES ('2139', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1745808783');
INSERT INTO `operation_log` VALUES ('2140', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745808801');
INSERT INTO `operation_log` VALUES ('2141', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745808843');
INSERT INTO `operation_log` VALUES ('2142', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745808885');
INSERT INTO `operation_log` VALUES ('2143', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745808886');
INSERT INTO `operation_log` VALUES ('2144', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745808887');
INSERT INTO `operation_log` VALUES ('2145', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745808887');
INSERT INTO `operation_log` VALUES ('2146', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745808887');
INSERT INTO `operation_log` VALUES ('2147', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745808887');
INSERT INTO `operation_log` VALUES ('2148', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1745808887');
INSERT INTO `operation_log` VALUES ('2149', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745808888');
INSERT INTO `operation_log` VALUES ('2150', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1745808906');
INSERT INTO `operation_log` VALUES ('2151', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745808985');
INSERT INTO `operation_log` VALUES ('2152', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745808985');
INSERT INTO `operation_log` VALUES ('2153', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745808988');
INSERT INTO `operation_log` VALUES ('2154', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745808988');
INSERT INTO `operation_log` VALUES ('2155', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809001');
INSERT INTO `operation_log` VALUES ('2156', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745809001');
INSERT INTO `operation_log` VALUES ('2157', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745809003');
INSERT INTO `operation_log` VALUES ('2158', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745809003');
INSERT INTO `operation_log` VALUES ('2159', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745809003');
INSERT INTO `operation_log` VALUES ('2160', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745809004');
INSERT INTO `operation_log` VALUES ('2161', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809005');
INSERT INTO `operation_log` VALUES ('2162', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745809005');
INSERT INTO `operation_log` VALUES ('2163', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745809006');
INSERT INTO `operation_log` VALUES ('2164', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745809006');
INSERT INTO `operation_log` VALUES ('2165', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745809006');
INSERT INTO `operation_log` VALUES ('2166', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745809006');
INSERT INTO `operation_log` VALUES ('2167', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745809006');
INSERT INTO `operation_log` VALUES ('2168', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809006');
INSERT INTO `operation_log` VALUES ('2169', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745809016');
INSERT INTO `operation_log` VALUES ('2170', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745809016');
INSERT INTO `operation_log` VALUES ('2171', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809017');
INSERT INTO `operation_log` VALUES ('2172', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745809017');
INSERT INTO `operation_log` VALUES ('2173', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745809024');
INSERT INTO `operation_log` VALUES ('2174', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745809024');
INSERT INTO `operation_log` VALUES ('2175', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809025');
INSERT INTO `operation_log` VALUES ('2176', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745809025');
INSERT INTO `operation_log` VALUES ('2177', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745809083');
INSERT INTO `operation_log` VALUES ('2178', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745809084');
INSERT INTO `operation_log` VALUES ('2179', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809084');
INSERT INTO `operation_log` VALUES ('2180', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745809084');
INSERT INTO `operation_log` VALUES ('2181', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745809108');
INSERT INTO `operation_log` VALUES ('2182', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745809108');
INSERT INTO `operation_log` VALUES ('2183', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809109');
INSERT INTO `operation_log` VALUES ('2184', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745809109');
INSERT INTO `operation_log` VALUES ('2185', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745809139');
INSERT INTO `operation_log` VALUES ('2186', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745809165');
INSERT INTO `operation_log` VALUES ('2187', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745809167');
INSERT INTO `operation_log` VALUES ('2188', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745809168');
INSERT INTO `operation_log` VALUES ('2189', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809168');
INSERT INTO `operation_log` VALUES ('2190', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745809168');
INSERT INTO `operation_log` VALUES ('2191', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745809189');
INSERT INTO `operation_log` VALUES ('2192', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745809189');
INSERT INTO `operation_log` VALUES ('2193', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745809190');
INSERT INTO `operation_log` VALUES ('2194', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745809190');
INSERT INTO `operation_log` VALUES ('2195', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745809190');
INSERT INTO `operation_log` VALUES ('2196', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745809190');
INSERT INTO `operation_log` VALUES ('2197', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809190');
INSERT INTO `operation_log` VALUES ('2198', '1', '/desktop/system.login_log.Index/getLoginLogPaginate', '127.0.0.1', '1745809190');
INSERT INTO `operation_log` VALUES ('2199', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745809204');
INSERT INTO `operation_log` VALUES ('2200', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745809204');
INSERT INTO `operation_log` VALUES ('2201', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745809205');
INSERT INTO `operation_log` VALUES ('2202', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745809205');
INSERT INTO `operation_log` VALUES ('2203', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745809205');
INSERT INTO `operation_log` VALUES ('2204', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745809205');
INSERT INTO `operation_log` VALUES ('2205', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745809205');
INSERT INTO `operation_log` VALUES ('2206', '1', '/desktop/system.operation_log.Index/getOperationLogPaginate', '127.0.0.1', '1745809205');
INSERT INTO `operation_log` VALUES ('2207', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745836936');
INSERT INTO `operation_log` VALUES ('2208', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745836936');
INSERT INTO `operation_log` VALUES ('2209', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745836937');
INSERT INTO `operation_log` VALUES ('2210', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745836937');
INSERT INTO `operation_log` VALUES ('2211', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745836937');
INSERT INTO `operation_log` VALUES ('2212', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745836937');
INSERT INTO `operation_log` VALUES ('2213', '1', '/desktop/statistic.OrderTrend/init', '127.0.0.1', '1745837037');
INSERT INTO `operation_log` VALUES ('2214', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1745837039');
INSERT INTO `operation_log` VALUES ('2215', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745837040');
INSERT INTO `operation_log` VALUES ('2216', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1745837040');
INSERT INTO `operation_log` VALUES ('2217', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745837042');
INSERT INTO `operation_log` VALUES ('2218', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745837043');
INSERT INTO `operation_log` VALUES ('2219', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745837043');
INSERT INTO `operation_log` VALUES ('2220', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745837043');
INSERT INTO `operation_log` VALUES ('2221', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745837046');
INSERT INTO `operation_log` VALUES ('2222', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745837047');
INSERT INTO `operation_log` VALUES ('2223', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745837047');
INSERT INTO `operation_log` VALUES ('2224', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745837047');
INSERT INTO `operation_log` VALUES ('2225', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745837079');
INSERT INTO `operation_log` VALUES ('2226', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745837091');
INSERT INTO `operation_log` VALUES ('2227', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745837104');
INSERT INTO `operation_log` VALUES ('2228', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745837114');
INSERT INTO `operation_log` VALUES ('2229', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745837115');
INSERT INTO `operation_log` VALUES ('2230', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745837115');
INSERT INTO `operation_log` VALUES ('2231', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745837115');
INSERT INTO `operation_log` VALUES ('2232', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745837140');
INSERT INTO `operation_log` VALUES ('2233', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745837140');
INSERT INTO `operation_log` VALUES ('2234', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745837140');
INSERT INTO `operation_log` VALUES ('2235', '1', '/desktop/system.user.Detail/init', '127.0.0.1', '1745837140');
INSERT INTO `operation_log` VALUES ('2236', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1745812261');
INSERT INTO `operation_log` VALUES ('2237', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745814378');
INSERT INTO `operation_log` VALUES ('2238', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745814380');
INSERT INTO `operation_log` VALUES ('2239', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745814384');
INSERT INTO `operation_log` VALUES ('2240', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745814422');
INSERT INTO `operation_log` VALUES ('2241', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745819166');
INSERT INTO `operation_log` VALUES ('2242', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1745819233');
INSERT INTO `operation_log` VALUES ('2243', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745819234');
INSERT INTO `operation_log` VALUES ('2244', '1', '/desktop/components.department.TypeSelect/getTypes', '127.0.0.1', '1745819234');
INSERT INTO `operation_log` VALUES ('2245', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1745819242');
INSERT INTO `operation_log` VALUES ('2246', '1', '/desktop/system.department.Edit/init', '127.0.0.1', '1745819243');
INSERT INTO `operation_log` VALUES ('2247', '1', '/desktop/components.department.TypeSelect/getTypes', '127.0.0.1', '1745819243');
INSERT INTO `operation_log` VALUES ('2248', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1745819248');
INSERT INTO `operation_log` VALUES ('2249', '1', '/desktop/components.desktop.treeMenuSelect/getTreeMenu', '127.0.0.1', '1745819249');
INSERT INTO `operation_log` VALUES ('2250', '1', '/desktop/components.desktop.treeMenuSelect/getTreeMenu', '127.0.0.1', '1745819256');
INSERT INTO `operation_log` VALUES ('2251', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1745819256');
INSERT INTO `operation_log` VALUES ('2252', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1745819260');
INSERT INTO `operation_log` VALUES ('2253', '1', '/desktop/components.desktop.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819265');
INSERT INTO `operation_log` VALUES ('2254', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1745819265');
INSERT INTO `operation_log` VALUES ('2255', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1745819337');
INSERT INTO `operation_log` VALUES ('2256', '1', '/desktop/components.desktop.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819337');
INSERT INTO `operation_log` VALUES ('2257', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1745819408');
INSERT INTO `operation_log` VALUES ('2258', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1745819409');
INSERT INTO `operation_log` VALUES ('2259', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1745819410');
INSERT INTO `operation_log` VALUES ('2260', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1745819410');
INSERT INTO `operation_log` VALUES ('2261', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1745819410');
INSERT INTO `operation_log` VALUES ('2262', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1745819410');
INSERT INTO `operation_log` VALUES ('2263', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1745819410');
INSERT INTO `operation_log` VALUES ('2264', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1745819436');
INSERT INTO `operation_log` VALUES ('2265', '1', '/desktop/components.mobile.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819437');
INSERT INTO `operation_log` VALUES ('2266', '1', '/desktop/components.mobile.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819441');
INSERT INTO `operation_log` VALUES ('2267', '1', '/desktop/system.mobile.permission.Edit/init', '127.0.0.1', '1745819441');
INSERT INTO `operation_log` VALUES ('2268', '1', '/desktop/components.mobile.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819505');
INSERT INTO `operation_log` VALUES ('2269', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1745819508');
INSERT INTO `operation_log` VALUES ('2270', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1745819510');
INSERT INTO `operation_log` VALUES ('2271', '1', '/desktop/components.desktop.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819511');
INSERT INTO `operation_log` VALUES ('2272', '1', '/desktop/system.desktop.menu.Index/getTreeMenu', '127.0.0.1', '1745819799');
INSERT INTO `operation_log` VALUES ('2273', '1', '/desktop/components.desktop.treeMenuSelect/getTreeMenu', '127.0.0.1', '1745819803');
INSERT INTO `operation_log` VALUES ('2274', '1', '/desktop/components.desktop.treeMenuSelect/getTreeMenu', '127.0.0.1', '1745819807');
INSERT INTO `operation_log` VALUES ('2275', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1745819807');
INSERT INTO `operation_log` VALUES ('2276', '1', '/desktop/components.desktop.treeMenuSelect/getTreeMenu', '127.0.0.1', '1745819810');
INSERT INTO `operation_log` VALUES ('2277', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1745819810');
INSERT INTO `operation_log` VALUES ('2278', '1', '/desktop/components.desktop.treeMenuSelect/getTreeMenu', '127.0.0.1', '1745819812');
INSERT INTO `operation_log` VALUES ('2279', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1745819813');
INSERT INTO `operation_log` VALUES ('2280', '1', '/desktop/components.desktop.treeMenuSelect/getTreeMenu', '127.0.0.1', '1745819815');
INSERT INTO `operation_log` VALUES ('2281', '1', '/desktop/system.desktop.menu.Edit/init', '127.0.0.1', '1745819815');
INSERT INTO `operation_log` VALUES ('2282', '1', '/desktop/components.desktop.treeMenuSelect/getTreeMenu', '127.0.0.1', '1745819818');
INSERT INTO `operation_log` VALUES ('2283', '1', '/desktop/system.desktop.permission.Index/getTreePermission', '127.0.0.1', '1745819820');
INSERT INTO `operation_log` VALUES ('2284', '1', '/desktop/components.desktop.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819821');
INSERT INTO `operation_log` VALUES ('2285', '1', '/desktop/components.desktop.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819825');
INSERT INTO `operation_log` VALUES ('2286', '1', '/desktop/system.desktop.permission.Edit/init', '127.0.0.1', '1745819825');
INSERT INTO `operation_log` VALUES ('2287', '1', '/desktop/system.desktop.route.Index/getRoutes', '127.0.0.1', '1745819829');
INSERT INTO `operation_log` VALUES ('2288', '1', '/desktop/components.desktop.route.LayoutSelect/getLayouts', '127.0.0.1', '1745819831');
INSERT INTO `operation_log` VALUES ('2289', '1', '/desktop/components.desktop.route.LayoutSelect/getLayouts', '127.0.0.1', '1745819833');
INSERT INTO `operation_log` VALUES ('2290', '1', '/desktop/system.desktop.route.Edit/init', '127.0.0.1', '1745819833');
INSERT INTO `operation_log` VALUES ('2291', '1', '/desktop/system.mobile.permission.Index/getTreePermission', '127.0.0.1', '1745819838');
INSERT INTO `operation_log` VALUES ('2292', '1', '/desktop/components.mobile.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819839');
INSERT INTO `operation_log` VALUES ('2293', '1', '/desktop/components.mobile.treePermissionSelect/getTreePermission', '127.0.0.1', '1745819842');
INSERT INTO `operation_log` VALUES ('2294', '1', '/desktop/system.mobile.permission.Edit/init', '127.0.0.1', '1745819842');
INSERT INTO `operation_log` VALUES ('2295', '1', '/desktop/system.role.Index/getRolePaginate', '127.0.0.1', '1745819847');
INSERT INTO `operation_log` VALUES ('2296', '1', '/desktop/system.role.Add/init', '127.0.0.1', '1745819848');
INSERT INTO `operation_log` VALUES ('2297', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204131');
INSERT INTO `operation_log` VALUES ('2298', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204141');
INSERT INTO `operation_log` VALUES ('2299', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204406');
INSERT INTO `operation_log` VALUES ('2300', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204619');
INSERT INTO `operation_log` VALUES ('2301', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204676');
INSERT INTO `operation_log` VALUES ('2302', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204691');
INSERT INTO `operation_log` VALUES ('2303', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747204691');
INSERT INTO `operation_log` VALUES ('2304', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204729');
INSERT INTO `operation_log` VALUES ('2305', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747204729');
INSERT INTO `operation_log` VALUES ('2306', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747204730');
INSERT INTO `operation_log` VALUES ('2307', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747204730');
INSERT INTO `operation_log` VALUES ('2308', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747204730');
INSERT INTO `operation_log` VALUES ('2309', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747204730');
INSERT INTO `operation_log` VALUES ('2310', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204917');
INSERT INTO `operation_log` VALUES ('2311', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747204917');
INSERT INTO `operation_log` VALUES ('2312', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747204918');
INSERT INTO `operation_log` VALUES ('2313', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747204919');
INSERT INTO `operation_log` VALUES ('2314', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747204919');
INSERT INTO `operation_log` VALUES ('2315', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747204919');
INSERT INTO `operation_log` VALUES ('2316', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204934');
INSERT INTO `operation_log` VALUES ('2317', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747204934');
INSERT INTO `operation_log` VALUES ('2318', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747204936');
INSERT INTO `operation_log` VALUES ('2319', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747204936');
INSERT INTO `operation_log` VALUES ('2320', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747204936');
INSERT INTO `operation_log` VALUES ('2321', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747204936');
INSERT INTO `operation_log` VALUES ('2322', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204956');
INSERT INTO `operation_log` VALUES ('2323', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747204956');
INSERT INTO `operation_log` VALUES ('2324', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747204958');
INSERT INTO `operation_log` VALUES ('2325', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747204958');
INSERT INTO `operation_log` VALUES ('2326', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747204958');
INSERT INTO `operation_log` VALUES ('2327', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747204958');
INSERT INTO `operation_log` VALUES ('2328', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747204987');
INSERT INTO `operation_log` VALUES ('2329', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747204988');
INSERT INTO `operation_log` VALUES ('2330', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747204989');
INSERT INTO `operation_log` VALUES ('2331', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747204990');
INSERT INTO `operation_log` VALUES ('2332', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747204990');
INSERT INTO `operation_log` VALUES ('2333', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747204990');
INSERT INTO `operation_log` VALUES ('2334', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205006');
INSERT INTO `operation_log` VALUES ('2335', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205007');
INSERT INTO `operation_log` VALUES ('2336', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747205009');
INSERT INTO `operation_log` VALUES ('2337', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747205009');
INSERT INTO `operation_log` VALUES ('2338', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747205009');
INSERT INTO `operation_log` VALUES ('2339', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747205010');
INSERT INTO `operation_log` VALUES ('2340', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1747205013');
INSERT INTO `operation_log` VALUES ('2341', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205027');
INSERT INTO `operation_log` VALUES ('2342', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205027');
INSERT INTO `operation_log` VALUES ('2343', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205029');
INSERT INTO `operation_log` VALUES ('2344', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205029');
INSERT INTO `operation_log` VALUES ('2345', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747205029');
INSERT INTO `operation_log` VALUES ('2346', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747205030');
INSERT INTO `operation_log` VALUES ('2347', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747205030');
INSERT INTO `operation_log` VALUES ('2348', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1747205030');
INSERT INTO `operation_log` VALUES ('2349', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747205030');
INSERT INTO `operation_log` VALUES ('2350', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205539');
INSERT INTO `operation_log` VALUES ('2351', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205540');
INSERT INTO `operation_log` VALUES ('2352', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1747205540');
INSERT INTO `operation_log` VALUES ('2353', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205543');
INSERT INTO `operation_log` VALUES ('2354', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205543');
INSERT INTO `operation_log` VALUES ('2355', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1747205543');
INSERT INTO `operation_log` VALUES ('2356', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205555');
INSERT INTO `operation_log` VALUES ('2357', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205555');
INSERT INTO `operation_log` VALUES ('2358', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1747205556');
INSERT INTO `operation_log` VALUES ('2359', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1747205560');
INSERT INTO `operation_log` VALUES ('2360', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1747205574');
INSERT INTO `operation_log` VALUES ('2361', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1747205574');
INSERT INTO `operation_log` VALUES ('2362', '1', '/desktop/system.dictionary.Edit/init', '127.0.0.1', '1747205576');
INSERT INTO `operation_log` VALUES ('2363', '1', '/desktop/system.dictionary.Edit/save', '127.0.0.1', '1747205578');
INSERT INTO `operation_log` VALUES ('2364', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1747205579');
INSERT INTO `operation_log` VALUES ('2365', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205584');
INSERT INTO `operation_log` VALUES ('2366', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205584');
INSERT INTO `operation_log` VALUES ('2367', '1', '/desktop/system.dictionary.Index/getDictionaryPaginate', '127.0.0.1', '1747205585');
INSERT INTO `operation_log` VALUES ('2368', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205588');
INSERT INTO `operation_log` VALUES ('2369', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205588');
INSERT INTO `operation_log` VALUES ('2370', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747205590');
INSERT INTO `operation_log` VALUES ('2371', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747205590');
INSERT INTO `operation_log` VALUES ('2372', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747205590');
INSERT INTO `operation_log` VALUES ('2373', '1', '/desktop/system.message.Index/getMessagePaginate', '127.0.0.1', '1747205590');
INSERT INTO `operation_log` VALUES ('2374', '1', '/desktop/system.message.Index/setAllRead', '127.0.0.1', '1747205590');
INSERT INTO `operation_log` VALUES ('2375', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747205590');
INSERT INTO `operation_log` VALUES ('2376', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205592');
INSERT INTO `operation_log` VALUES ('2377', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205593');
INSERT INTO `operation_log` VALUES ('2378', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747205593');
INSERT INTO `operation_log` VALUES ('2379', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747205593');
INSERT INTO `operation_log` VALUES ('2380', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747205593');
INSERT INTO `operation_log` VALUES ('2381', '1', '/desktop/system.message.Index/getMessagePaginate', '127.0.0.1', '1747205593');
INSERT INTO `operation_log` VALUES ('2382', '1', '/desktop/system.message.Index/setAllRead', '127.0.0.1', '1747205594');
INSERT INTO `operation_log` VALUES ('2383', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747205594');
INSERT INTO `operation_log` VALUES ('2384', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205632');
INSERT INTO `operation_log` VALUES ('2385', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205633');
INSERT INTO `operation_log` VALUES ('2386', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747205633');
INSERT INTO `operation_log` VALUES ('2387', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747205633');
INSERT INTO `operation_log` VALUES ('2388', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747205634');
INSERT INTO `operation_log` VALUES ('2389', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747205634');
INSERT INTO `operation_log` VALUES ('2390', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747205656');
INSERT INTO `operation_log` VALUES ('2391', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747205656');
INSERT INTO `operation_log` VALUES ('2392', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747206017');
INSERT INTO `operation_log` VALUES ('2393', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747206017');
INSERT INTO `operation_log` VALUES ('2394', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747206019');
INSERT INTO `operation_log` VALUES ('2395', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747206019');
INSERT INTO `operation_log` VALUES ('2396', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747206021');
INSERT INTO `operation_log` VALUES ('2397', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747206021');
INSERT INTO `operation_log` VALUES ('2398', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747206024');
INSERT INTO `operation_log` VALUES ('2399', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747206024');
INSERT INTO `operation_log` VALUES ('2400', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747206066');
INSERT INTO `operation_log` VALUES ('2401', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747206066');
INSERT INTO `operation_log` VALUES ('2402', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747206067');
INSERT INTO `operation_log` VALUES ('2403', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747206067');
INSERT INTO `operation_log` VALUES ('2404', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747206067');
INSERT INTO `operation_log` VALUES ('2405', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747206067');
INSERT INTO `operation_log` VALUES ('2406', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747206078');
INSERT INTO `operation_log` VALUES ('2407', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747206078');
INSERT INTO `operation_log` VALUES ('2408', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747206079');
INSERT INTO `operation_log` VALUES ('2409', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747206079');
INSERT INTO `operation_log` VALUES ('2410', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747206079');
INSERT INTO `operation_log` VALUES ('2411', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747206079');
INSERT INTO `operation_log` VALUES ('2412', '1', '/desktop/system.config.Index/init', '127.0.0.1', '1747206081');
INSERT INTO `operation_log` VALUES ('2413', '1', '/desktop/components.TreeDepartmentSelect/getTreeDepartment', '127.0.0.1', '1747206083');
INSERT INTO `operation_log` VALUES ('2414', '1', '/desktop/components.roleSelect/getRoles', '127.0.0.1', '1747206083');
INSERT INTO `operation_log` VALUES ('2415', '1', '/desktop/system.user.Index/getUserPaginate', '127.0.0.1', '1747206083');
INSERT INTO `operation_log` VALUES ('2416', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1747206085');
INSERT INTO `operation_log` VALUES ('2417', '1', '/desktop/frame/getPermissions', '127.0.0.1', '1747206092');
INSERT INTO `operation_log` VALUES ('2418', '1', '/desktop/frame/getRoutes', '127.0.0.1', '1747206092');
INSERT INTO `operation_log` VALUES ('2419', '1', '/desktop/layouts.Side/getTreeMenu', '127.0.0.1', '1747206093');
INSERT INTO `operation_log` VALUES ('2420', '1', '/desktop/layouts.side.MessageNavigation/getNoReadCount', '127.0.0.1', '1747206093');
INSERT INTO `operation_log` VALUES ('2421', '1', '/desktop/layouts.Side/getAvatar', '127.0.0.1', '1747206093');
INSERT INTO `operation_log` VALUES ('2422', '1', '/desktop/system.department.Index/getTreeDepartment', '127.0.0.1', '1747206094');
INSERT INTO `operation_log` VALUES ('2423', '1', '/desktop/Frame/getWatermark', '127.0.0.1', '1747206094');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '名称',
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
) ENGINE=InnoDB AUTO_INCREMENT=493 DEFAULT CHARSET=utf8 COMMENT='角色桌面端菜单关系';

-- ----------------------------
-- Records of role_desktop_menu
-- ----------------------------
INSERT INTO `role_desktop_menu` VALUES ('472', '4', '15');
INSERT INTO `role_desktop_menu` VALUES ('473', '4', '16');
INSERT INTO `role_desktop_menu` VALUES ('474', '4', '17');
INSERT INTO `role_desktop_menu` VALUES ('475', '3', '15');
INSERT INTO `role_desktop_menu` VALUES ('476', '3', '16');
INSERT INTO `role_desktop_menu` VALUES ('477', '3', '17');
INSERT INTO `role_desktop_menu` VALUES ('478', '3', '19');
INSERT INTO `role_desktop_menu` VALUES ('479', '3', '1');
INSERT INTO `role_desktop_menu` VALUES ('480', '3', '12');
INSERT INTO `role_desktop_menu` VALUES ('481', '3', '2');
INSERT INTO `role_desktop_menu` VALUES ('482', '3', '3');
INSERT INTO `role_desktop_menu` VALUES ('483', '3', '4');
INSERT INTO `role_desktop_menu` VALUES ('484', '3', '6');
INSERT INTO `role_desktop_menu` VALUES ('485', '3', '7');
INSERT INTO `role_desktop_menu` VALUES ('486', '3', '5');
INSERT INTO `role_desktop_menu` VALUES ('487', '3', '8');
INSERT INTO `role_desktop_menu` VALUES ('488', '3', '9');
INSERT INTO `role_desktop_menu` VALUES ('489', '3', '10');
INSERT INTO `role_desktop_menu` VALUES ('490', '3', '11');
INSERT INTO `role_desktop_menu` VALUES ('491', '3', '13');
INSERT INTO `role_desktop_menu` VALUES ('492', '3', '14');

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
) ENGINE=InnoDB AUTO_INCREMENT=683 DEFAULT CHARSET=utf8 COMMENT='角色桌面端权限关系';

-- ----------------------------
-- Records of role_desktop_permission
-- ----------------------------
INSERT INTO `role_desktop_permission` VALUES ('637', '4', '41');
INSERT INTO `role_desktop_permission` VALUES ('638', '4', '38');
INSERT INTO `role_desktop_permission` VALUES ('639', '4', '40');
INSERT INTO `role_desktop_permission` VALUES ('640', '3', '41');
INSERT INTO `role_desktop_permission` VALUES ('641', '3', '38');
INSERT INTO `role_desktop_permission` VALUES ('642', '3', '40');
INSERT INTO `role_desktop_permission` VALUES ('643', '3', '1');
INSERT INTO `role_desktop_permission` VALUES ('644', '3', '8');
INSERT INTO `role_desktop_permission` VALUES ('645', '3', '2');
INSERT INTO `role_desktop_permission` VALUES ('646', '3', '3');
INSERT INTO `role_desktop_permission` VALUES ('647', '3', '4');
INSERT INTO `role_desktop_permission` VALUES ('648', '3', '5');
INSERT INTO `role_desktop_permission` VALUES ('649', '3', '6');
INSERT INTO `role_desktop_permission` VALUES ('650', '3', '7');
INSERT INTO `role_desktop_permission` VALUES ('651', '3', '9');
INSERT INTO `role_desktop_permission` VALUES ('652', '3', '20');
INSERT INTO `role_desktop_permission` VALUES ('653', '3', '21');
INSERT INTO `role_desktop_permission` VALUES ('654', '3', '22');
INSERT INTO `role_desktop_permission` VALUES ('655', '3', '10');
INSERT INTO `role_desktop_permission` VALUES ('656', '3', '42');
INSERT INTO `role_desktop_permission` VALUES ('657', '3', '43');
INSERT INTO `role_desktop_permission` VALUES ('658', '3', '44');
INSERT INTO `role_desktop_permission` VALUES ('659', '3', '11');
INSERT INTO `role_desktop_permission` VALUES ('660', '3', '12');
INSERT INTO `role_desktop_permission` VALUES ('661', '3', '23');
INSERT INTO `role_desktop_permission` VALUES ('662', '3', '24');
INSERT INTO `role_desktop_permission` VALUES ('663', '3', '25');
INSERT INTO `role_desktop_permission` VALUES ('664', '3', '13');
INSERT INTO `role_desktop_permission` VALUES ('665', '3', '26');
INSERT INTO `role_desktop_permission` VALUES ('666', '3', '27');
INSERT INTO `role_desktop_permission` VALUES ('667', '3', '28');
INSERT INTO `role_desktop_permission` VALUES ('668', '3', '14');
INSERT INTO `role_desktop_permission` VALUES ('669', '3', '29');
INSERT INTO `role_desktop_permission` VALUES ('670', '3', '30');
INSERT INTO `role_desktop_permission` VALUES ('671', '3', '31');
INSERT INTO `role_desktop_permission` VALUES ('672', '3', '15');
INSERT INTO `role_desktop_permission` VALUES ('673', '3', '16');
INSERT INTO `role_desktop_permission` VALUES ('674', '3', '32');
INSERT INTO `role_desktop_permission` VALUES ('675', '3', '33');
INSERT INTO `role_desktop_permission` VALUES ('676', '3', '34');
INSERT INTO `role_desktop_permission` VALUES ('677', '3', '17');
INSERT INTO `role_desktop_permission` VALUES ('678', '3', '35');
INSERT INTO `role_desktop_permission` VALUES ('679', '3', '36');
INSERT INTO `role_desktop_permission` VALUES ('680', '3', '37');
INSERT INTO `role_desktop_permission` VALUES ('681', '3', '18');
INSERT INTO `role_desktop_permission` VALUES ('682', '3', '19');

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
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8 COMMENT='角色桌面端路由关系';

-- ----------------------------
-- Records of role_desktop_route
-- ----------------------------
INSERT INTO `role_desktop_route` VALUES ('257', '4', '12');
INSERT INTO `role_desktop_route` VALUES ('258', '4', '13');
INSERT INTO `role_desktop_route` VALUES ('259', '3', '12');
INSERT INTO `role_desktop_route` VALUES ('260', '3', '13');
INSERT INTO `role_desktop_route` VALUES ('261', '3', '11');
INSERT INTO `role_desktop_route` VALUES ('262', '3', '1');
INSERT INTO `role_desktop_route` VALUES ('263', '3', '2');
INSERT INTO `role_desktop_route` VALUES ('264', '3', '3');
INSERT INTO `role_desktop_route` VALUES ('265', '3', '4');
INSERT INTO `role_desktop_route` VALUES ('266', '3', '5');
INSERT INTO `role_desktop_route` VALUES ('267', '3', '6');
INSERT INTO `role_desktop_route` VALUES ('268', '3', '7');
INSERT INTO `role_desktop_route` VALUES ('269', '3', '15');
INSERT INTO `role_desktop_route` VALUES ('270', '3', '8');
INSERT INTO `role_desktop_route` VALUES ('271', '3', '9');
INSERT INTO `role_desktop_route` VALUES ('272', '3', '10');

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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='角色移动端权限关系';

-- ----------------------------
-- Records of role_mobile_permission
-- ----------------------------
INSERT INTO `role_mobile_permission` VALUES ('76', '4', '1');
INSERT INTO `role_mobile_permission` VALUES ('77', '4', '2');
INSERT INTO `role_mobile_permission` VALUES ('78', '3', '1');
INSERT INTO `role_mobile_permission` VALUES ('79', '3', '2');

-- ----------------------------
-- Table structure for runtime
-- ----------------------------
DROP TABLE IF EXISTS `runtime`;
CREATE TABLE `runtime` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `key` varchar(127) NOT NULL DEFAULT '' COMMENT '键',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='运行时';

-- ----------------------------
-- Records of runtime
-- ----------------------------
INSERT INTO `runtime` VALUES ('1', 'key1', 'value2');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '部门id',
  `account` varchar(63) NOT NULL DEFAULT '' COMMENT '账号',
  `password` varchar(63) NOT NULL DEFAULT '' COMMENT '密码',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '姓名',
  `phone` varchar(63) NOT NULL DEFAULT '' COMMENT '手机号码',
  `avatar` varchar(127) NOT NULL DEFAULT '' COMMENT '头像',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `last_login_ip` varchar(31) NOT NULL DEFAULT '' COMMENT '登录ip',
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='管理用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '张三', '15122222222', 'avatar/2025/04/08/a6748e0fd20912cad64355baf91e8ce8.png', '1684989244', '1716183018', '1747204690', '127.0.0.1');
INSERT INTO `user` VALUES ('2', '1', 'user', 'e10adc3949ba59abbe56e057f20f883e', '1', '李四', '15111111111', '', '1684992552', '1703148627', '0', '');
INSERT INTO `user` VALUES ('3', '1', 'test1', 'ea7d67381ace4fcd68e90985645aa69d', '1', 'test1', '15108273575', '', '0', '0', '0', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('64', '1', '3');
INSERT INTO `user_role` VALUES ('65', '2', '4');
INSERT INTO `user_role` VALUES ('67', '3', '3');
INSERT INTO `user_role` VALUES ('68', '3', '4');
