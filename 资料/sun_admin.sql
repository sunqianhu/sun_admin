/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : sun_admin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2024-05-20 13:43:03
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='部门';

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '0', '1', '部门1', '1');
INSERT INTO `department` VALUES ('2', '1', '2', '部门1-1', '1');
INSERT INTO `department` VALUES ('3', '0', '1', '部门2', '2');

-- ----------------------------
-- Table structure for desktop_module
-- ----------------------------
DROP TABLE IF EXISTS `desktop_module`;
CREATE TABLE `desktop_module` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `module_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级模块id',
  `type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模块类型id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '模块名称',
  `key` varchar(128) DEFAULT '' COMMENT '模块key',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路由路径',
  `component` varchar(255) NOT NULL DEFAULT '' COMMENT '组件路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '网址',
  `icon` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `api` varchar(1024) NOT NULL DEFAULT '' COMMENT '接口地址',
  `layout` varchar(32) NOT NULL DEFAULT '' COMMENT '页面布局',
  `keep_alive` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '保活',
  `show` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '菜单显示',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(32) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COMMENT='模块';

-- ----------------------------
-- Records of desktop_module
-- ----------------------------
INSERT INTO `desktop_module` VALUES ('1', '0', '1', '系统管理', 'system', '', '', '', 'Setting', '', '', '2', '1', '99', '');
INSERT INTO `desktop_module` VALUES ('2', '1', '2', '用户管理', 'system_user', '/system/user', 'system/user/Index.vue', '', 'User', 'desktop/system.User/initIndex\ndesktop/system.User/getIndexUsers', 'main', '2', '1', '3', '');
INSERT INTO `desktop_module` VALUES ('3', '2', '3', '添加', 'system_user_add', '', '', '', '', 'desktop/system.User/initAdd\ndesktop/system.User/saveAdd', '', '2', '1', '1', '');
INSERT INTO `desktop_module` VALUES ('4', '2', '3', '修改', 'system_user_edit', '', '', '', '', 'desktop/system.User/initEdit\ndesktop/system.User/saveEdit', '', '2', '1', '2', '');
INSERT INTO `desktop_module` VALUES ('5', '1', '2', '部门管理', 'system_department', '/system/department', 'system/department/Index.vue', '', 'Memo', 'desktop/system.Department/getIndexDepartments', 'main', '2', '1', '5', '');
INSERT INTO `desktop_module` VALUES ('6', '2', '3', '修改状态', 'system_user_edit_status', '', '', '', '', 'desktop/system.User/editStatus', '', '2', '1', '3', '');
INSERT INTO `desktop_module` VALUES ('7', '2', '3', '修改密码', 'system_user_edit_password', '', '', '', '', 'desktop/system.User/editPassword', '', '2', '1', '5', '');
INSERT INTO `desktop_module` VALUES ('8', '5', '3', '添加', 'system_department_add', '', '', '', '', 'desktop/system.Department/initAdd\ndesktop/system.Department/saveAdd', '', '2', '1', '1', '');
INSERT INTO `desktop_module` VALUES ('9', '5', '3', '修改', 'system_department_edit', '', '', '', '', 'desktop/system.Department/initEdit\ndesktop/system.Department/saveEdit', '', '2', '1', '1', '');
INSERT INTO `desktop_module` VALUES ('10', '5', '3', '删除', 'system_department_delete', '', '', '', '', 'desktop/system.Department/delete', '', '2', '1', '3', '');
INSERT INTO `desktop_module` VALUES ('11', '1', '2', '角色管理', 'system_role', '/system/role', 'system/role/Index.vue', '', 'ChatSquare', 'desktop/system.Role/getIndexRoles', 'main', '2', '1', '7', '');
INSERT INTO `desktop_module` VALUES ('12', '11', '3', '添加', 'system_role_add', '', '', '', '', 'desktop/system.Role/initAdd\ndesktop/system.Role/saveAdd', '', '2', '1', '1', '');
INSERT INTO `desktop_module` VALUES ('13', '11', '3', '修改', 'system_role_edit', '', '', '', '', 'desktop/system.Role/initEdit\ndesktop/system.Role/saveEdit', '', '2', '1', '2', '');
INSERT INTO `desktop_module` VALUES ('14', '11', '3', '删除', 'system_role_delete', '', '', '', '', 'desktop/system.Role/delete', '', '2', '1', '3', '');
INSERT INTO `desktop_module` VALUES ('15', '1', '2', '桌面端模块管理', 'system_desktop_module', '/system/desktop/module', 'system/desktop/module/Index.vue', '', 'Reading', 'desktop/system.desktop.module/getindexmodules', 'main', '2', '1', '9', '');
INSERT INTO `desktop_module` VALUES ('16', '15', '3', '添加', 'system_desktop_module_add', '', '', '', '', 'desktop/system.desktop.Module/initAdd\ndesktop/system.desktop.Module/saveAdd', '', '2', '1', '1', '');
INSERT INTO `desktop_module` VALUES ('17', '15', '3', '修改', 'system_desktop_module_edit', '', '', '', '', 'desktop/system.desktop.Module/initEdit\ndesktop/system.desktop.Module/saveEdit', '', '2', '1', '2', '');
INSERT INTO `desktop_module` VALUES ('18', '15', '3', '删除', 'system_menu_delete', '', '', '', '', 'desktop/system.desktop.Module/delete', '', '2', '1', '3', '');
INSERT INTO `desktop_module` VALUES ('19', '1', '2', '字典管理', 'system_dictionary', '/system/dictionary', 'system/dictionary/Index.vue', '', 'Document', 'desktop/system.Dictionary/getIndexDictionarys', 'main', '2', '1', '11', '');
INSERT INTO `desktop_module` VALUES ('20', '19', '3', '添加', 'system_dictionary_add', '', '', '', '', 'desktop/system.Dictionary/saveAdd', '', '2', '1', '1', '');
INSERT INTO `desktop_module` VALUES ('21', '19', '3', '修改', 'system_dictionary_edit', '', '', '', '', 'desktop/system.Dictionary/initEdit\ndesktop/system.Dictionary/saveEdit', '', '2', '1', '2', '');
INSERT INTO `desktop_module` VALUES ('22', '19', '3', '删除', 'system_dictionary_delete', '', '', '', '', 'desktop/system.Dictionary/delete', '', '2', '1', '3', '');
INSERT INTO `desktop_module` VALUES ('23', '0', '2', '首页', 'index', '/index', 'Index.vue', '', 'House', '', 'main', '2', '1', '0', '');
INSERT INTO `desktop_module` VALUES ('26', '2', '3', '踢下线', 'system_user_offline', '', '', '', '', 'desktop/system.User/offLine', '', '2', '1', '5', '');
INSERT INTO `desktop_module` VALUES ('27', '1', '2', '登录日志', 'system_login_log', '/system/login-log', 'system/login_log/Index.vue', '', 'MapLocation', 'desktop/system.LoginLog/getIndexLoginLogs', 'main', '2', '1', '13', '');
INSERT INTO `desktop_module` VALUES ('28', '1', '2', '操作日志', 'system_operation_log', '/system/operation-log', 'system/operation_log/Index.vue', '', 'Mouse', 'desktop/system.OperationLog/getIndexOperationLogs', 'main', '2', '1', '15', '');
INSERT INTO `desktop_module` VALUES ('29', '2', '2', '用户详情', 'system_user_detail', '/system/user/:id', 'system/user/Detail.vue', '', '', 'desktop/system.user/detail', 'blank', '2', '2', '3', '');
INSERT INTO `desktop_module` VALUES ('30', '0', '4', '外部链接', 'baidu', '', '', 'https://www.baidu.com', 'ChatSquare', '', '', '2', '1', '3', '新窗口');
INSERT INTO `desktop_module` VALUES ('31', '1', '2', '系统设置', 'system_config', '/system/config', 'system/config/Index.vue', '', 'Cpu', 'desktop/system.Config/init\ndesktop/system.Config/save', 'main', '2', '1', '1', '');
INSERT INTO `desktop_module` VALUES ('32', '0', '1', '统计分析', 'statistic', '', '', '', 'PieChart', '', '', '2', '1', '2', '');
INSERT INTO `desktop_module` VALUES ('33', '32', '2', '趋势统计', 'statistic_trend', '/statistic/trend', 'statistic/Trend.vue', '', 'Share', 'desktop/statistic.Trend/init\ndesktop/statistic.Trend/exportExcel', 'main', '2', '1', '1', '');
INSERT INTO `desktop_module` VALUES ('34', '32', '2', '部门统计', 'statistic_department', '/statistic/department', 'statistic/Department.vue', '', 'OfficeBuilding', 'desktop/statistic.Department/init\ndesktop/statistic.Department/exportExcel', 'main', '2', '1', '3', '');
INSERT INTO `desktop_module` VALUES ('35', '1', '2', '移动端模块管理', 'system_mobile_module', '/system/mobile/module', 'system/mobile/module/Index.vue', '', 'Iphone', 'desktop/system.mobile.module/getIndexModules', 'main', '2', '1', '10', '');
INSERT INTO `desktop_module` VALUES ('36', '35', '3', '添加', 'system_mobile_module_add', '', '', '', '', 'desktop/system.mobile.Module/initAdd\ndesktop/system.mobile.Module/saveAdd', '', '2', '1', '1', '');
INSERT INTO `desktop_module` VALUES ('37', '35', '3', '修改', 'system_mobile_module_edit', '', '', '', '', 'desktop/system.mobile.Module/initEdit\ndesktop/system.mobile.Module/saveEdit', '', '2', '1', '3', '');
INSERT INTO `desktop_module` VALUES ('38', '35', '3', '删除', 'system_mobile_module_delete', '', '', '', '', 'desktop/system.mobile.Module/delete', '', '2', '1', '5', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COMMENT='token';

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
INSERT INTO `desktop_token` VALUES ('48', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjM2ODcwNTAwIDE3MTM1MTU2NTUifQ.jiDE79glBnyMJ8mATonzCKsQXYdl26rhq0vfuAN2xVY', '1713544456', '1');
INSERT INTO `desktop_token` VALUES ('49', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjkyOTYzMzAwIDE3MTM1MTU2NjYifQ.xVKyJQQ1UAl4_Viv_5M6TU9zllYXPlM1gGXoGr3eU0U', '1713544467', '1');
INSERT INTO `desktop_token` VALUES ('50', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjg5MTM3OTAwIDE3MTM1MTU3MTAifQ.m1Y_NXijpkIMfCIxLWa-1KVyoujok6pWc4E0kIw31TQ', '1713544511', '1');
INSERT INTO `desktop_token` VALUES ('51', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY3MjI4MTAwIDE3MTM1MTU5MDUifQ.xycuNoSt49VJTryP60vdogfJZRfM6wwUZRoNVLc0LRQ', '1713544706', '1');
INSERT INTO `desktop_token` VALUES ('52', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjUxOTg5MDAwIDE3MTM1MTYwODQifQ.tnofIeN90fJf2cOhZ78r0an0wyAxj23Y6ig-DCct19A', '1713544884', '1');
INSERT INTO `desktop_token` VALUES ('53', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQyNDcxNjAwIDE3MTM1MTYxMDMifQ.HaIx6t8K7GaKAI27wOhL5TlEcvMq4kCgnMoNxITgisc', '1713546771', '1');
INSERT INTO `desktop_token` VALUES ('54', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQyMDQ0MTAwIDE3MTQzNTg5NTMifQ.unDXDgas54VynrHmFecNua3CSZ3q-h8CHnaPOe_IswU', '1714389276', '1');
INSERT INTO `desktop_token` VALUES ('55', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjg3MzcyNzAwIDE3MTQ0NDc0NjgifQ.gamO0qokRHfEKVtERbmq_-8e9mPEaX7dm--NEe96gXc', '1714476270', '1');
INSERT INTO `desktop_token` VALUES ('56', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQ5NDk5NjAwIDE3MTQ0NDc1NDEifQ.uV7RsyjKgJeKZDFr07zyVTYHJH3JdcxiD6PAeH89NuY', '1714489649', '1');
INSERT INTO `desktop_token` VALUES ('57', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjM4MjgyMDAwIDE3MTQ1NzI1ODcifQ.1xRmyc2Yi7K9ylnDPF2hK3ZFHU2VqxcwYRwYPFOqEew', '1714601388', '1');
INSERT INTO `desktop_token` VALUES ('58', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjg2ODI1ODAwIDE3MTQ1NzI2MTMifQ.eYOjBnPTx9uo44bqa5Dy0Sw46JpwzM5VRmQnd9sjb8Q', '1714601414', '1');
INSERT INTO `desktop_token` VALUES ('59', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjkzODUyMzAwIDE3MTQ1NzI2MjcifQ.AZwkev3RiitDb06JG47K9tn13fhgdRoHzl0DOExngPg', '1714601428', '1');
INSERT INTO `desktop_token` VALUES ('60', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjQ2NTk4MjAwIDE3MTQ1NzQ3NjcifQ.JnJ-RhfRAO1cNd4eVTwvj4nKEzEMSk2hbRsxrUxEP2M', '1714603568', '1');
INSERT INTO `desktop_token` VALUES ('61', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjI1NDI1MTAwIDE3MTQ1NzQ4MjkifQ.JlcPPVlgAmWSuCMroUJMIanOgNXQS69h5ZxsSro4ahM', '1714604452', '1');
INSERT INTO `desktop_token` VALUES ('62', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjIwODMxMzAwIDE3MTQ2MzM3NTMifQ.cCRIIVDce3AHfFlQAeZDAoSq8FOAdhxe1VyXPQ5ajY4', '1714692338', '1');
INSERT INTO `desktop_token` VALUES ('63', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY4Njk0NDAwIDE3MTYxNzk4MTkifQ.731SxEsxZFdJuxzTXACcSgYW3eaC0gmXR3ZEh3Eudag', '1716208620', '1');
INSERT INTO `desktop_token` VALUES ('64', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjU2MTgwNTAwIDE3MTYxNzk4MzgifQ.BEryTxGQdLxZcvfZ-HahSDmnCZ8lUB8jCS4x-krJlUo', '1716212418', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='字典';

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('1', 'desktop_module_type', '1', '目录', '1');
INSERT INTO `dictionary` VALUES ('2', 'desktop_module_type', '2', '页面', '2');
INSERT INTO `dictionary` VALUES ('3', 'desktop_module_type', '3', '按钮', '3');
INSERT INTO `dictionary` VALUES ('4', 'desktop_module_layout', 'main', '主布局', '1');
INSERT INTO `dictionary` VALUES ('5', 'desktop_module_layout', 'blank', '空白布局', '2');
INSERT INTO `dictionary` VALUES ('6', 'desktop_module_type', '4', '外部链接', '4');
INSERT INTO `dictionary` VALUES ('7', 'department_type', '1', '类型1', '1');
INSERT INTO `dictionary` VALUES ('8', 'department_type', '2', '类型2', '2');
INSERT INTO `dictionary` VALUES ('9', 'department_type', '3', '类型3', '3');
INSERT INTO `dictionary` VALUES ('10', 'mobile_module_type', '1', '目录', '1');
INSERT INTO `dictionary` VALUES ('11', 'mobile_module_type', '2', '页面', '2');
INSERT INTO `dictionary` VALUES ('12', 'mobile_module_type', '3', '按钮', '3');

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
-- Table structure for mobile_module
-- ----------------------------
DROP TABLE IF EXISTS `mobile_module`;
CREATE TABLE `mobile_module` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `module_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模块id',
  `type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模块类型id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '模块名称',
  `key` varchar(128) DEFAULT '' COMMENT '模块key',
  `api` varchar(1024) NOT NULL DEFAULT '' COMMENT '接口地址',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(32) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='模块';

-- ----------------------------
-- Records of mobile_module
-- ----------------------------
INSERT INTO `mobile_module` VALUES ('1', '0', '1', '统计分析', 'statistic', '', '1', '');
INSERT INTO `mobile_module` VALUES ('2', '1', '2', '趋势统计', 'statistic_trend', 'mobile/statistic.Trend/init\nmobile/statistic.Trend/exportExcel', '1', '');
INSERT INTO `mobile_module` VALUES ('3', '1', '2', '部门统计', 'statistic_department', 'mobile/statistic.Department/init\nmobile/statistic.Department/exportExcel', '1', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级用户');
INSERT INTO `role` VALUES ('2', '普通角色');

-- ----------------------------
-- Table structure for role_desktop_module
-- ----------------------------
DROP TABLE IF EXISTS `role_desktop_module`;
CREATE TABLE `role_desktop_module` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  `module_id` int(10) unsigned NOT NULL COMMENT '模块id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8 COMMENT='角色模块关系';

-- ----------------------------
-- Records of role_desktop_module
-- ----------------------------
INSERT INTO `role_desktop_module` VALUES ('264', '1', '23');
INSERT INTO `role_desktop_module` VALUES ('265', '1', '30');
INSERT INTO `role_desktop_module` VALUES ('266', '1', '1');
INSERT INTO `role_desktop_module` VALUES ('267', '1', '31');
INSERT INTO `role_desktop_module` VALUES ('268', '1', '2');
INSERT INTO `role_desktop_module` VALUES ('269', '1', '3');
INSERT INTO `role_desktop_module` VALUES ('270', '1', '4');
INSERT INTO `role_desktop_module` VALUES ('271', '1', '6');
INSERT INTO `role_desktop_module` VALUES ('272', '1', '29');
INSERT INTO `role_desktop_module` VALUES ('273', '1', '26');
INSERT INTO `role_desktop_module` VALUES ('274', '1', '7');
INSERT INTO `role_desktop_module` VALUES ('275', '1', '5');
INSERT INTO `role_desktop_module` VALUES ('276', '1', '9');
INSERT INTO `role_desktop_module` VALUES ('277', '1', '8');
INSERT INTO `role_desktop_module` VALUES ('278', '1', '10');
INSERT INTO `role_desktop_module` VALUES ('279', '1', '11');
INSERT INTO `role_desktop_module` VALUES ('280', '1', '12');
INSERT INTO `role_desktop_module` VALUES ('281', '1', '13');
INSERT INTO `role_desktop_module` VALUES ('282', '1', '14');
INSERT INTO `role_desktop_module` VALUES ('283', '1', '15');
INSERT INTO `role_desktop_module` VALUES ('284', '1', '16');
INSERT INTO `role_desktop_module` VALUES ('285', '1', '17');
INSERT INTO `role_desktop_module` VALUES ('286', '1', '18');
INSERT INTO `role_desktop_module` VALUES ('287', '1', '19');
INSERT INTO `role_desktop_module` VALUES ('288', '1', '20');
INSERT INTO `role_desktop_module` VALUES ('289', '1', '21');
INSERT INTO `role_desktop_module` VALUES ('290', '1', '22');
INSERT INTO `role_desktop_module` VALUES ('291', '1', '27');
INSERT INTO `role_desktop_module` VALUES ('292', '1', '28');
INSERT INTO `role_desktop_module` VALUES ('297', '1', '32');
INSERT INTO `role_desktop_module` VALUES ('298', '1', '33');
INSERT INTO `role_desktop_module` VALUES ('299', '1', '34');
INSERT INTO `role_desktop_module` VALUES ('300', '2', '23');
INSERT INTO `role_desktop_module` VALUES ('301', '2', '32');
INSERT INTO `role_desktop_module` VALUES ('302', '2', '33');
INSERT INTO `role_desktop_module` VALUES ('303', '2', '34');
INSERT INTO `role_desktop_module` VALUES ('304', '2', '30');
INSERT INTO `role_desktop_module` VALUES ('305', '1', '35');
INSERT INTO `role_desktop_module` VALUES ('306', '1', '36');
INSERT INTO `role_desktop_module` VALUES ('307', '1', '37');
INSERT INTO `role_desktop_module` VALUES ('308', '1', '38');

-- ----------------------------
-- Table structure for role_mobile_module
-- ----------------------------
DROP TABLE IF EXISTS `role_mobile_module`;
CREATE TABLE `role_mobile_module` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  `module_id` int(10) unsigned NOT NULL COMMENT '模块id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='角色模块关系';

-- ----------------------------
-- Records of role_mobile_module
-- ----------------------------
INSERT INTO `role_mobile_module` VALUES ('5', '1', '1');
INSERT INTO `role_mobile_module` VALUES ('6', '1', '2');
INSERT INTO `role_mobile_module` VALUES ('7', '1', '3');
INSERT INTO `role_mobile_module` VALUES ('8', '2', '1');
INSERT INTO `role_mobile_module` VALUES ('9', '2', '2');
INSERT INTO `role_mobile_module` VALUES ('10', '2', '3');

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
INSERT INTO `user` VALUES ('1', '1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '张三', '15122222222', '', '1684989244', '1716183018', '1716179838', '127.0.0.1');
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('46', '1', '1');
INSERT INTO `user_role` VALUES ('47', '1', '2');
INSERT INTO `user_role` VALUES ('50', '2', '2');
