/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : sun_admin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2024-06-28 19:45:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `key` varchar(128) NOT NULL DEFAULT '' COMMENT '键',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='配置';

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('1', 'version', '2.0.2');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='菜单';

-- ----------------------------
-- Records of desktop_menu
-- ----------------------------
INSERT INTO `desktop_menu` VALUES ('1', '0', '系统管理', '', 'Setting', '0', '99');
INSERT INTO `desktop_menu` VALUES ('2', '1', '用户管理', '/system/user', 'User', '0', '1');
INSERT INTO `desktop_menu` VALUES ('3', '1', '部门管理', '/system/department', 'Memo', '0', '3');
INSERT INTO `desktop_menu` VALUES ('4', '1', '角色管理', '/system/role', 'ChatSquare', '0', '5');
INSERT INTO `desktop_menu` VALUES ('5', '6', '菜单管理', '/system/desktop/menu', 'Reading', '0', '3');
INSERT INTO `desktop_menu` VALUES ('6', '1', '桌面端', '', 'Monitor', '0', '8');
INSERT INTO `desktop_menu` VALUES ('7', '6', '路由管理', '/system/desktop/route', 'Van', '0', '1');
INSERT INTO `desktop_menu` VALUES ('8', '6', '权限管理', '/system/desktop/permission', 'Lock', '0', '5');
INSERT INTO `desktop_menu` VALUES ('9', '1', '移动端', '', 'Iphone', '0', '9');
INSERT INTO `desktop_menu` VALUES ('10', '9', '权限管理', '/system/mobile/permission', 'Lock', '0', '1');
INSERT INTO `desktop_menu` VALUES ('11', '1', '字典管理', '/system/dictionary', 'Notebook', '0', '11');
INSERT INTO `desktop_menu` VALUES ('12', '1', '系统设置', '/system/config', 'Cpu', '0', '0');
INSERT INTO `desktop_menu` VALUES ('13', '1', '登录日志', '/system/login-log', 'MapLocation', '0', '13');
INSERT INTO `desktop_menu` VALUES ('14', '1', '操作日志', '/system/operation-log', 'Mouse', '0', '15');
INSERT INTO `desktop_menu` VALUES ('15', '0', '系统首页', '/index', 'House', '0', '1');
INSERT INTO `desktop_menu` VALUES ('16', '0', '统计分析', '', 'PieChart', '0', '3');
INSERT INTO `desktop_menu` VALUES ('17', '16', '趋势统计', '/statistic/trend', 'Share', '0', '1');
INSERT INTO `desktop_menu` VALUES ('18', '16', '部门统计', '/statistic/department', 'OfficeBuilding', '0', '3');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='权限';

-- ----------------------------
-- Records of desktop_permission
-- ----------------------------
INSERT INTO `desktop_permission` VALUES ('1', '0', '系统管理', 'system', '', '99');
INSERT INTO `desktop_permission` VALUES ('2', '1', '用户管理', 'system_user', 'desktop/system.user.Index/init\ndesktop/system.user.Index/getUsers', '1');
INSERT INTO `desktop_permission` VALUES ('3', '2', '添加用户', 'system_user_add', 'desktop/system.user.Add/init\ndesktop/system.user.Add/save', '3');
INSERT INTO `desktop_permission` VALUES ('4', '2', '修改用户', 'system_user_edit', 'desktop/system.user.Edit/init\ndesktop/system.user.Edit/save', '5');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='路由';

-- ----------------------------
-- Records of desktop_route
-- ----------------------------
INSERT INTO `desktop_route` VALUES ('1', '用户管理', 'system_user', '/system/user', 'system/user/Index.vue', 'main', '2', '501');
INSERT INTO `desktop_route` VALUES ('2', '用户详情', 'system_user_detail', '/system/user/detail-:id', 'system/user/Detail.vue', 'blank', '2', '502');
INSERT INTO `desktop_route` VALUES ('3', '部门管理', 'system_department', '/system/department', 'system/department/Index.vue', 'main', '2', '511');
INSERT INTO `desktop_route` VALUES ('4', '角色管理', 'system_role', '/system/role', 'system/role/Index.vue', 'main', '2', '521');
INSERT INTO `desktop_route` VALUES ('5', '菜单管理', 'system_desktop_menu', '/system/desktop/menu', 'system/desktop/menu/Index.vue', 'main', '2', '531');
INSERT INTO `desktop_route` VALUES ('6', '路由管理', 'system_desktop_route', '/system/desktop/route', 'system/desktop/route/Index.vue', 'main', '2', '541');
INSERT INTO `desktop_route` VALUES ('7', '权限管理', 'system_desktop_permission', '/system/desktop/permission', '/system/desktop/permission/Index.vue', 'main', '2', '551');
INSERT INTO `desktop_route` VALUES ('8', '字典管理', 'system_dictionary', '/system/dictionary', 'system/dictionary/Index.vue', 'main', '2', '561');
INSERT INTO `desktop_route` VALUES ('9', '登录日志', 'system_login_log', '/system/login-log', 'system/login_log/Index.vue', 'main', '2', '571');
INSERT INTO `desktop_route` VALUES ('10', '操作日志', 'system_option_log', '/system/option-log', 'system/option_log/Index.vue', 'main', '2', '581');

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
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of desktop_token
-- ----------------------------
INSERT INTO `desktop_token` VALUES ('34', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC42MDA0MDMwMCAxNzAzMjE1OTU0In0.hCtCWoJvF5UJ_OX2yYvozYIM-tUGYyLbbWHcDkm4_R8', '1703226008', '10');
INSERT INTO `desktop_token` VALUES ('35', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43NzY1MjMwMCAxNzAzMjI2NzQ0In0.o1NW6DuKKk6PRjnpGlGJrjmofBDQQdedmHLOGyHZ4vI', '1703235581', '10');
INSERT INTO `desktop_token` VALUES ('36', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43OTgzNzYwMCAxNzAzNDg1MjQzIn0.owdRQGm9nQQIH3LF4HCFes1GuoxjMhZ090ym3mXTV9s', '1703496265', '10');
INSERT INTO `desktop_token` VALUES ('37', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4yMzAxOTgwMCAxNzAzNTYxMTE5In0.yMAPpSgE43MQ2VNMJm4qM3560E19d5CJvqC-SFb45Q8', '1703568404', '10');
INSERT INTO `desktop_token` VALUES ('38', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC40Mjc1NTAwMCAxNzAzNTcwMzkxIn0.mwnHb0RhHhIWOQzt94-cpxuM5jliZ754_xOVA2e_xR0', '1703584727', '10');
INSERT INTO `desktop_token` VALUES ('39', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC44Mzg0NTYwMCAxNzAzNTc4MTExIn0.ZcYF9H3xXtI5V9TKq-8XOeSa76wBg_TM1GKnUt47HUA', '1703585312', '10');
INSERT INTO `desktop_token` VALUES ('40', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC41ODYyNDgwMCAxNzAzNTc4MTU4In0.fA36XuiF1BW8F5HGaPJS6CYpIRWQKohzACPwduBti7k', '1703585359', '10');
INSERT INTO `desktop_token` VALUES ('41', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4xNzM3NTYwMCAxNzAzNTc4MTk2In0.Y8aS9mz7wCq6gWEi-S5UcnmWw5hKWOIGrr_ewrDtsQI', '1703585396', '10');
INSERT INTO `desktop_token` VALUES ('42', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4xNzQ0MDMwMCAxNzAzNTc4MjA3In0.VjQ5HRcjKYo8gfzH6NoN9DneAE8cFLAPtTLzMaC-TBg', '1703593928', '10');
INSERT INTO `desktop_token` VALUES ('43', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC41OTg5NjEwMCAxNzAzNjM5MzA4In0.uHjXcyEhttgy0V9hDYUS1QykJarzgKSke3J7-nmg99o', '1703657085', '10');
INSERT INTO `desktop_token` VALUES ('44', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43NTk5MTcwMCAxNzAzNzI2NjU0In0.8Fy4Wiw_M13SgOUrIHlRtOEEg_zv4VbcnXy9x1MkRpg', '1703733855', '10');
INSERT INTO `desktop_token` VALUES ('45', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43MzI5NzYwMCAxNzAzNzI3MDg3In0.q7FPU2dFfb_0gnQtn0LsmEn5mEok7ga997gZEPM200U', '1703735267', '10');
INSERT INTO `desktop_token` VALUES ('46', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43NDQxNTgwMCAxNzA0NDE3NDQ1In0.AwVM6Ry1x22wCJMOcPYmSYUE_GdP7cDReXKau3jBI4Y', '1704424647', '10');
INSERT INTO `desktop_token` VALUES ('47', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC41NDAyNjUwMCAxNzA0NDE3NDY5In0.4lHwTZ41SoQeIE8_7h81YL9EwgiYjnKerwiONFkjL88', '1704453986', '10');
INSERT INTO `desktop_token` VALUES ('69', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjM2MTIxODAwIDE3MTg4NTM1NjkifQ.gIpbfvZ0iehqxBm19ra0Nuxh5MRaSeO2cXacX92N7T8', '1718882371', '1');
INSERT INTO `desktop_token` VALUES ('70', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjkzOTYxNjAwIDE3MTg4NjgwMTIifQ.XflUDUW80FeDQ0GZOo7X4TZWe4RJ6MLyxgSSBWaKAuw', '1718875212', '1');
INSERT INTO `desktop_token` VALUES ('71', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQ4MTg2MzAwIDE3MTg4NjgyNTUifQ.cgtj5t-K77nNQh5EGyI3tBNq3mP16LSraT9XJACTYSU', '1718875455', '1');
INSERT INTO `desktop_token` VALUES ('72', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk3Njc3NzAwIDE3MTg4NjgyNzcifQ.BVi1lnPyc-XDVXfqPxpIVPFC72RKRFxeZZOB5ns41pA', '1718875477', '1');
INSERT INTO `desktop_token` VALUES ('73', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQ5OTM5MjAwIDE3MTg4NjgzMDcifQ.fbRTFWFPg72cQmdcgYr0PYKEiRZ9i0S4_qhwE0BJZ-A', '1718875507', '1');
INSERT INTO `desktop_token` VALUES ('74', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjk4OTY2MTAwIDE3MTg4Njg0NzMifQ.166CQ3JZBeW-6oE6ZeJXpRY7PyyrUfrjPGGbB7oGoTE', '1718899579', '1');
INSERT INTO `desktop_token` VALUES ('75', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjg0NTMzMTAwIDE3MTkyODU0NzUifQ.RzT8zilBoY5wQPJ3BX6dKfTciBHMIOKVdZpJpJqMSzg', '1719288332', '1');
INSERT INTO `desktop_token` VALUES ('76', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY4MTIxNjAwIDE3MTk1NjU1MDIifQ.cWaKCjeqMl2RlFDduFZnnWC5YkOfVJLC9W7xSrZPoos', '1719572702', '1');
INSERT INTO `desktop_token` VALUES ('77', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjUwOTg3MDAwIDE3MTk1NjU1NDEifQ.X_WxbWUAa0bX89VW_qWOvuRCCR55ZhfL3jwKIomOmUo', '1719572741', '1');
INSERT INTO `desktop_token` VALUES ('78', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjYxNzU4NzAwIDE3MTk1NjU2NzgifQ.hPlVM1hwxHAx2VnCq5LL76BvcxUQQ4BMEVBANyhIu1Q', '1719576835', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

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
) ENGINE=InnoDB AUTO_INCREMENT=430 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

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

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('3', '角色1');

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
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 COMMENT='角色桌面端菜单关系';

-- ----------------------------
-- Records of role_desktop_menu
-- ----------------------------
INSERT INTO `role_desktop_menu` VALUES ('144', '3', '15');
INSERT INTO `role_desktop_menu` VALUES ('145', '3', '16');
INSERT INTO `role_desktop_menu` VALUES ('146', '3', '17');
INSERT INTO `role_desktop_menu` VALUES ('147', '3', '18');
INSERT INTO `role_desktop_menu` VALUES ('148', '3', '1');
INSERT INTO `role_desktop_menu` VALUES ('149', '3', '12');
INSERT INTO `role_desktop_menu` VALUES ('150', '3', '2');
INSERT INTO `role_desktop_menu` VALUES ('151', '3', '3');
INSERT INTO `role_desktop_menu` VALUES ('152', '3', '4');
INSERT INTO `role_desktop_menu` VALUES ('153', '3', '6');
INSERT INTO `role_desktop_menu` VALUES ('154', '3', '7');
INSERT INTO `role_desktop_menu` VALUES ('155', '3', '5');
INSERT INTO `role_desktop_menu` VALUES ('156', '3', '8');
INSERT INTO `role_desktop_menu` VALUES ('157', '3', '9');
INSERT INTO `role_desktop_menu` VALUES ('158', '3', '10');
INSERT INTO `role_desktop_menu` VALUES ('159', '3', '11');
INSERT INTO `role_desktop_menu` VALUES ('160', '3', '13');
INSERT INTO `role_desktop_menu` VALUES ('161', '3', '14');

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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='角色桌面端权限关系';

-- ----------------------------
-- Records of role_desktop_permission
-- ----------------------------
INSERT INTO `role_desktop_permission` VALUES ('79', '3', '1');
INSERT INTO `role_desktop_permission` VALUES ('80', '3', '2');
INSERT INTO `role_desktop_permission` VALUES ('81', '3', '3');
INSERT INTO `role_desktop_permission` VALUES ('82', '3', '4');

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='角色桌面端路由关系';

-- ----------------------------
-- Records of role_desktop_route
-- ----------------------------
INSERT INTO `role_desktop_route` VALUES ('11', '3', '1');
INSERT INTO `role_desktop_route` VALUES ('12', '3', '2');
INSERT INTO `role_desktop_route` VALUES ('13', '3', '3');
INSERT INTO `role_desktop_route` VALUES ('14', '3', '4');
INSERT INTO `role_desktop_route` VALUES ('15', '3', '5');
INSERT INTO `role_desktop_route` VALUES ('16', '3', '6');
INSERT INTO `role_desktop_route` VALUES ('17', '3', '7');
INSERT INTO `role_desktop_route` VALUES ('18', '3', '8');
INSERT INTO `role_desktop_route` VALUES ('19', '3', '9');
INSERT INTO `role_desktop_route` VALUES ('20', '3', '10');

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='角色移动端权限关系';

-- ----------------------------
-- Records of role_mobile_permission
-- ----------------------------
INSERT INTO `role_mobile_permission` VALUES ('33', '3', '1');
INSERT INTO `role_mobile_permission` VALUES ('34', '3', '2');

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
INSERT INTO `user` VALUES ('1', '1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '张三', '15122222222', '', '1684989244', '1716183018', '1719565678', '127.0.0.1');
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('46', '1', '3');
INSERT INTO `user_role` VALUES ('47', '1', '3');
INSERT INTO `user_role` VALUES ('50', '2', '3');
