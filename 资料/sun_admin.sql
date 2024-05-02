/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : sun_admin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2024-05-02 23:21:23
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
INSERT INTO `config` VALUES ('1', 'version', '2.0.0');

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COMMENT='模块';

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
INSERT INTO `desktop_module` VALUES ('27', '1', '2', '登录日志', 'system_login_log', '/system/login-log', 'system/login-log/Index.vue', '', 'MapLocation', 'desktop/system.LoginLog/getIndexLoginLogs', 'main', '2', '1', '13', '');
INSERT INTO `desktop_module` VALUES ('28', '1', '2', '操作日志', 'system_operation_log', '/system/operation-log', 'system/operation-log/Index.vue', '', 'Mouse', 'desktop/system.OperationLog/getIndexOperationLogs', 'main', '2', '1', '15', '');
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COMMENT='token';

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
INSERT INTO `desktop_token` VALUES ('62', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjIwODMxMzAwIDE3MTQ2MzM3NTMifQ.cCRIIVDce3AHfFlQAeZDAoSq8FOAdhxe1VyXPQ5ajY4', '1714692066', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES ('1', '1', '1704425432', '127.0.0.1');
INSERT INTO `login_log` VALUES ('2', '1', '1704680564', '127.0.0.1');
INSERT INTO `login_log` VALUES ('3', '1', '1705907520', '127.0.0.1');
INSERT INTO `login_log` VALUES ('4', '1', '1705907582', '127.0.0.1');
INSERT INTO `login_log` VALUES ('5', '1', '1705907599', '127.0.0.1');
INSERT INTO `login_log` VALUES ('6', '1', '1706066872', '127.0.0.1');
INSERT INTO `login_log` VALUES ('7', '1', '1706066945', '127.0.0.1');
INSERT INTO `login_log` VALUES ('8', '1', '1706067117', '127.0.0.1');
INSERT INTO `login_log` VALUES ('9', '1', '1706234571', '127.0.0.1');
INSERT INTO `login_log` VALUES ('10', '1', '1706234582', '127.0.0.1');
INSERT INTO `login_log` VALUES ('11', '1', '1706239367', '127.0.0.1');
INSERT INTO `login_log` VALUES ('12', '1', '1706329395', '127.0.0.1');
INSERT INTO `login_log` VALUES ('13', '1', '1706332776', '127.0.0.1');
INSERT INTO `login_log` VALUES ('14', '1', '1706333128', '127.0.0.1');
INSERT INTO `login_log` VALUES ('15', '1', '1706333468', '127.0.0.1');
INSERT INTO `login_log` VALUES ('16', '1', '1706333537', '127.0.0.1');
INSERT INTO `login_log` VALUES ('17', '1', '1706333672', '127.0.0.1');
INSERT INTO `login_log` VALUES ('18', '1', '1706334952', '127.0.0.1');
INSERT INTO `login_log` VALUES ('19', '1', '1706335044', '127.0.0.1');
INSERT INTO `login_log` VALUES ('20', '1', '1706666113', '127.0.0.1');
INSERT INTO `login_log` VALUES ('21', '1', '1711100180', '127.0.0.1');
INSERT INTO `login_log` VALUES ('22', '1', '1712892799', '127.0.0.1');
INSERT INTO `login_log` VALUES ('23', '1', '1713515655', '127.0.0.1');
INSERT INTO `login_log` VALUES ('24', '1', '1713515667', '127.0.0.1');
INSERT INTO `login_log` VALUES ('25', '1', '1713515711', '127.0.0.1');
INSERT INTO `login_log` VALUES ('26', '1', '1713515905', '127.0.0.1');
INSERT INTO `login_log` VALUES ('27', '1', '1713516084', '127.0.0.1');
INSERT INTO `login_log` VALUES ('28', '1', '1713516103', '127.0.0.1');
INSERT INTO `login_log` VALUES ('29', '1', '1714358953', '127.0.0.1');
INSERT INTO `login_log` VALUES ('30', '1', '1714447469', '127.0.0.1');
INSERT INTO `login_log` VALUES ('31', '1', '1714447541', '127.0.0.1');
INSERT INTO `login_log` VALUES ('32', '1', '1714572587', '127.0.0.1');
INSERT INTO `login_log` VALUES ('33', '1', '1714572614', '127.0.0.1');
INSERT INTO `login_log` VALUES ('34', '1', '1714572628', '127.0.0.1');
INSERT INTO `login_log` VALUES ('35', '1', '1714574767', '127.0.0.1');
INSERT INTO `login_log` VALUES ('36', '1', '1714574829', '127.0.0.1');
INSERT INTO `login_log` VALUES ('37', '1', '1714633753', '127.0.0.1');

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
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 COMMENT='消息';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '10', '消息标题', '/system/user', '1685957225', '1');
INSERT INTO `message` VALUES ('2', '11', '消息标题', '/system/user', '1685957225', '0');
INSERT INTO `message` VALUES ('3', '10', '消息标题', '/system/user', '1685957362', '1');
INSERT INTO `message` VALUES ('4', '11', '消息标题', '/system/user', '1685957362', '0');
INSERT INTO `message` VALUES ('5', '10', '消息标题', '/system/user', '1685957574', '1');
INSERT INTO `message` VALUES ('6', '11', '消息标题', '/system/user', '1685957574', '0');
INSERT INTO `message` VALUES ('7', '10', '消息标题', '/system/user', '1685957591', '1');
INSERT INTO `message` VALUES ('8', '11', '消息标题', '/system/user', '1685957591', '0');
INSERT INTO `message` VALUES ('9', '10', '消息标题', '/system/user', '1685957637', '1');
INSERT INTO `message` VALUES ('10', '11', '消息标题', '/system/user', '1685957637', '0');
INSERT INTO `message` VALUES ('11', '10', '消息标题', '/system/user', '1685957661', '1');
INSERT INTO `message` VALUES ('12', '11', '消息标题', '/system/user', '1685957661', '0');
INSERT INTO `message` VALUES ('13', '10', '消息标题', '/system/user', '1685957678', '1');
INSERT INTO `message` VALUES ('14', '11', '消息标题', '/system/user', '1685957678', '0');
INSERT INTO `message` VALUES ('15', '10', '消息标题', '/system/user', '1685957822', '1');
INSERT INTO `message` VALUES ('16', '11', '消息标题', '/system/user', '1685957822', '0');
INSERT INTO `message` VALUES ('17', '10', '消息标题', '/system/user', '1685957857', '1');
INSERT INTO `message` VALUES ('18', '11', '消息标题', '/system/user', '1685957857', '0');
INSERT INTO `message` VALUES ('19', '10', '消息标题', '/system/user', '1685957902', '1');
INSERT INTO `message` VALUES ('20', '11', '消息标题', '/system/user', '1685957902', '0');
INSERT INTO `message` VALUES ('21', '10', '消息标题', '/system/user', '1685957931', '1');
INSERT INTO `message` VALUES ('22', '11', '消息标题', '/system/user', '1685957931', '0');
INSERT INTO `message` VALUES ('23', '10', '消息标题', '/system/user', '1685958400', '1');
INSERT INTO `message` VALUES ('24', '11', '消息标题', '/system/user', '1685958400', '0');
INSERT INTO `message` VALUES ('25', '10', '消息标题', '/system/user', '1685958403', '1');
INSERT INTO `message` VALUES ('26', '11', '消息标题', '/system/user', '1685958403', '0');
INSERT INTO `message` VALUES ('27', '10', '消息标题', '/system/user', '1685958535', '1');
INSERT INTO `message` VALUES ('28', '11', '消息标题', '/system/user', '1685958535', '0');
INSERT INTO `message` VALUES ('29', '10', '消息标题', '/system/user', '1685958550', '1');
INSERT INTO `message` VALUES ('30', '11', '消息标题', '/system/user', '1685958550', '0');
INSERT INTO `message` VALUES ('31', '10', '消息标题', '/system/user', '1685958552', '1');
INSERT INTO `message` VALUES ('32', '11', '消息标题', '/system/user', '1685958553', '0');
INSERT INTO `message` VALUES ('33', '10', '消息标题', '/system/user', '1685958555', '1');
INSERT INTO `message` VALUES ('34', '11', '消息标题', '/system/user', '1685958555', '0');
INSERT INTO `message` VALUES ('35', '10', '消息标题', '/system/user', '1685958557', '1');
INSERT INTO `message` VALUES ('36', '11', '消息标题', '/system/user', '1685958557', '0');
INSERT INTO `message` VALUES ('37', '10', '消息标题', '/system/user', '1685958561', '1');
INSERT INTO `message` VALUES ('38', '11', '消息标题', '/system/user', '1685958562', '0');
INSERT INTO `message` VALUES ('39', '10', '消息标题', '/system/user', '1685958656', '1');
INSERT INTO `message` VALUES ('40', '11', '消息标题', '/system/user', '1685958656', '0');
INSERT INTO `message` VALUES ('41', '10', '消息标题', '/system/user', '1685958664', '1');
INSERT INTO `message` VALUES ('42', '11', '消息标题', '/system/user', '1685958665', '0');
INSERT INTO `message` VALUES ('43', '10', '消息标题', '/system/user', '1685958679', '1');
INSERT INTO `message` VALUES ('44', '11', '消息标题', '/system/user', '1685958680', '0');
INSERT INTO `message` VALUES ('45', '10', '消息标题', '/system/user', '1685958697', '1');
INSERT INTO `message` VALUES ('46', '11', '消息标题', '/system/user', '1685958697', '0');
INSERT INTO `message` VALUES ('47', '10', '消息标题', '/system/user', '1685958751', '1');
INSERT INTO `message` VALUES ('48', '11', '消息标题', '/system/user', '1685958751', '0');
INSERT INTO `message` VALUES ('49', '10', '消息标题', '/system/user', '1685958773', '1');
INSERT INTO `message` VALUES ('50', '11', '消息标题', '/system/user', '1685958773', '0');
INSERT INTO `message` VALUES ('51', '10', '消息标题', '/system/user', '1685958775', '1');
INSERT INTO `message` VALUES ('52', '11', '消息标题', '/system/user', '1685958775', '0');
INSERT INTO `message` VALUES ('53', '10', '消息标题', '/system/user', '1685958775', '1');
INSERT INTO `message` VALUES ('54', '11', '消息标题', '/system/user', '1685958775', '0');
INSERT INTO `message` VALUES ('55', '10', '消息标题', '/system/user', '1685958775', '1');
INSERT INTO `message` VALUES ('56', '11', '消息标题', '/system/user', '1685958775', '0');
INSERT INTO `message` VALUES ('57', '10', '消息标题', '/system/user', '1685958775', '1');
INSERT INTO `message` VALUES ('58', '11', '消息标题', '/system/user', '1685958775', '0');
INSERT INTO `message` VALUES ('59', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('60', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('61', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('62', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('63', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('64', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('65', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('66', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('67', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('68', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('69', '10', '消息标题', '/system/user', '1685958783', '1');
INSERT INTO `message` VALUES ('70', '11', '消息标题', '/system/user', '1685958783', '0');
INSERT INTO `message` VALUES ('71', '10', '消息标题', '/system/user', '1685959087', '1');
INSERT INTO `message` VALUES ('72', '11', '消息标题', '/system/user', '1685959087', '0');
INSERT INTO `message` VALUES ('73', '10', '消息标题', '/system/user', '1686013370', '1');
INSERT INTO `message` VALUES ('74', '11', '消息标题', '/system/user', '1686013370', '0');
INSERT INTO `message` VALUES ('75', '10', '消息标题', '/system/user', '1686032055', '1');
INSERT INTO `message` VALUES ('76', '11', '消息标题', '/system/user', '1686032055', '0');
INSERT INTO `message` VALUES ('77', '10', '消息标题', '/system/user', '1686032060', '1');
INSERT INTO `message` VALUES ('78', '11', '消息标题', '/system/user', '1686032060', '0');
INSERT INTO `message` VALUES ('79', '10', '消息提醒标题', '/admin/system/loginLog', '1686121349', '1');
INSERT INTO `message` VALUES ('80', '11', '消息提醒标题', '/admin/system/loginLog', '1686121349', '0');
INSERT INTO `message` VALUES ('81', '10', '消息提醒标题', '/system/loginLog', '1686121586', '1');
INSERT INTO `message` VALUES ('82', '11', '消息提醒标题', '/system/loginLog', '1686121587', '0');
INSERT INTO `message` VALUES ('83', '10', '消息提醒标题', '/system/user', '1686121587', '1');
INSERT INTO `message` VALUES ('84', '11', '消息提醒标题', '/system/user', '1686121587', '0');
INSERT INTO `message` VALUES ('85', '10', '消息提醒标题', '/system/loginLog', '1686121657', '1');
INSERT INTO `message` VALUES ('86', '11', '消息提醒标题', '/system/loginLog', '1686121657', '0');
INSERT INTO `message` VALUES ('87', '10', '消息提醒标题', '/system/user', '1686121657', '1');
INSERT INTO `message` VALUES ('88', '11', '消息提醒标题', '/system/user', '1686121657', '0');
INSERT INTO `message` VALUES ('89', '10', '消息提醒标题', '/system/loginLog', '1686295402', '1');
INSERT INTO `message` VALUES ('90', '11', '消息提醒标题', '/system/loginLog', '1686295402', '0');
INSERT INTO `message` VALUES ('91', '10', '标题1694497219', '/user', '1694497220', '1');
INSERT INTO `message` VALUES ('92', '11', '标题1694497219', '/user', '1694497220', '0');
INSERT INTO `message` VALUES ('93', '10', '标题1694497229', '/user', '1694497230', '1');
INSERT INTO `message` VALUES ('94', '11', '标题1694497229', '/user', '1694497230', '0');
INSERT INTO `message` VALUES ('95', '10', '标题1694497265', '/user', '1694497265', '1');
INSERT INTO `message` VALUES ('96', '11', '标题1694497265', '/user', '1694497265', '0');
INSERT INTO `message` VALUES ('97', '10', '标题1694497267', '/user', '1694497267', '1');
INSERT INTO `message` VALUES ('98', '11', '标题1694497267', '/user', '1694497267', '0');
INSERT INTO `message` VALUES ('99', '10', '标题1694497268', '/user', '1694497268', '1');
INSERT INTO `message` VALUES ('100', '11', '标题1694497268', '/user', '1694497268', '0');
INSERT INTO `message` VALUES ('101', '10', '标题1694497269', '/user', '1694497269', '1');
INSERT INTO `message` VALUES ('102', '11', '标题1694497269', '/user', '1694497269', '0');
INSERT INTO `message` VALUES ('103', '10', '标题1694497270', '/user', '1694497270', '1');
INSERT INTO `message` VALUES ('104', '11', '标题1694497270', '/user', '1694497270', '0');
INSERT INTO `message` VALUES ('105', '10', '标题1694497270', '/user', '1694497270', '1');
INSERT INTO `message` VALUES ('106', '11', '标题1694497270', '/user', '1694497270', '0');
INSERT INTO `message` VALUES ('107', '10', '标题1694497271', '/user', '1694497271', '1');
INSERT INTO `message` VALUES ('108', '11', '标题1694497271', '/user', '1694497271', '0');
INSERT INTO `message` VALUES ('109', '10', '标题1694497272', '/user', '1694497272', '1');
INSERT INTO `message` VALUES ('110', '11', '标题1694497272', '/user', '1694497272', '0');
INSERT INTO `message` VALUES ('111', '10', '标题1694497273', '/user', '1694497273', '1');
INSERT INTO `message` VALUES ('112', '11', '标题1694497273', '/user', '1694497273', '0');
INSERT INTO `message` VALUES ('113', '10', '标题1694497273', '/user', '1694497273', '1');
INSERT INTO `message` VALUES ('114', '11', '标题1694497273', '/user', '1694497273', '0');
INSERT INTO `message` VALUES ('115', '10', '标题1694497273', '/user', '1694497273', '1');
INSERT INTO `message` VALUES ('116', '11', '标题1694497273', '/user', '1694497273', '0');
INSERT INTO `message` VALUES ('117', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('118', '11', '标题1694497274', '/user', '1694497274', '0');
INSERT INTO `message` VALUES ('119', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('120', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('121', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('122', '11', '标题1694497274', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('123', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('124', '11', '标题1694497274', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('125', '11', '标题1694497274', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('126', '11', '标题1694497274', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('127', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('128', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('129', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('130', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('131', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('132', '11', '标题1694497275', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('133', '11', '标题1694497275', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('134', '11', '标题1694497275', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('135', '11', '标题1694497275', '/user', '1694497276', '0');
INSERT INTO `message` VALUES ('136', '11', '标题1694497275', '/user', '1694497276', '0');
INSERT INTO `message` VALUES ('137', '10', '标题1694497276', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('138', '10', '标题1694497275', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('139', '10', '标题1694497275', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('140', '10', '标题1694497275', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('141', '10', '标题1694497275', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('142', '10', '标题1694497276', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('143', '10', '标题1694497276', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('144', '10', '标题1694497276', '/user', '1694497277', '1');
INSERT INTO `message` VALUES ('145', '11', '标题1694497276', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('146', '11', '标题1694497275', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('147', '11', '标题1694497275', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('148', '11', '标题1694497276', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('149', '11', '标题1694497275', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('150', '11', '标题1694497275', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('151', '11', '标题1694497276', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('152', '11', '标题1694497276', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('153', '10', '标题1694497277', '/user', '1694497277', '1');
INSERT INTO `message` VALUES ('154', '11', '标题1694497277', '/user', '1694497278', '0');
INSERT INTO `message` VALUES ('155', '10', '标题1694497280', '/user', '1694497280', '1');
INSERT INTO `message` VALUES ('156', '11', '标题1694497280', '/user', '1694497280', '0');
INSERT INTO `message` VALUES ('157', '10', '标题1694497281', '/user', '1694497281', '1');
INSERT INTO `message` VALUES ('158', '11', '标题1694497281', '/user', '1694497281', '0');
INSERT INTO `message` VALUES ('159', '10', '标题1694497282', '/user', '1694497282', '1');
INSERT INTO `message` VALUES ('160', '11', '标题1694497282', '/user', '1694497283', '0');
INSERT INTO `message` VALUES ('161', '10', '标题1694497283', '/user', '1694497283', '1');
INSERT INTO `message` VALUES ('162', '11', '标题1694497283', '/user', '1694497283', '0');
INSERT INTO `message` VALUES ('163', '10', '消息标题1694836600', '/login-log', '1694836600', '1');
INSERT INTO `message` VALUES ('164', '11', '消息标题1694836600', '/login-log', '1694836600', '0');
INSERT INTO `message` VALUES ('165', '10', '消息标题1694836609', '/login-log', '1694836609', '1');
INSERT INTO `message` VALUES ('166', '11', '消息标题1694836609', '/login-log', '1694836609', '0');
INSERT INTO `message` VALUES ('167', '10', '消息标题1694840058', '/login-log', '1694840058', '1');
INSERT INTO `message` VALUES ('168', '11', '消息标题1694840058', '/login-log', '1694840058', '0');
INSERT INTO `message` VALUES ('169', '10', '消息标题1694840065', '/login-log', '1694840065', '1');
INSERT INTO `message` VALUES ('170', '11', '消息标题1694840065', '/login-log', '1694840065', '0');
INSERT INTO `message` VALUES ('171', '10', '消息标题1694840066', '/login-log', '1694840066', '1');
INSERT INTO `message` VALUES ('172', '11', '消息标题1694840066', '/login-log', '1694840067', '0');
INSERT INTO `message` VALUES ('173', '10', '消息标题1694840073', '/login-log', '1694840073', '1');
INSERT INTO `message` VALUES ('174', '11', '消息标题1694840073', '/login-log', '1694840073', '0');
INSERT INTO `message` VALUES ('175', '10', '消息标题1694840767', '/login-log', '1694840767', '1');
INSERT INTO `message` VALUES ('176', '11', '消息标题1694840767', '/login-log', '1694840767', '0');
INSERT INTO `message` VALUES ('177', '10', '消息标题1694840773', '/login-log', '1694840773', '1');
INSERT INTO `message` VALUES ('178', '11', '消息标题1694840773', '/login-log', '1694840773', '0');
INSERT INTO `message` VALUES ('179', '10', '消息标题1694840775', '/login-log', '1694840775', '1');
INSERT INTO `message` VALUES ('180', '11', '消息标题1694840775', '/login-log', '1694840775', '0');
INSERT INTO `message` VALUES ('181', '10', '消息标题1695436293', '/login-log', '1695436293', '1');
INSERT INTO `message` VALUES ('182', '11', '消息标题1695436293', '/login-log', '1695436293', '0');
INSERT INTO `message` VALUES ('183', '10', '消息标题1695436656', '/login-log', '1695436656', '1');
INSERT INTO `message` VALUES ('184', '11', '消息标题1695436656', '/login-log', '1695436656', '0');
INSERT INTO `message` VALUES ('185', '10', '消息标题1695436661', '/login-log', '1695436661', '1');
INSERT INTO `message` VALUES ('186', '11', '消息标题1695436661', '/login-log', '1695436661', '0');
INSERT INTO `message` VALUES ('187', '10', '消息标题1695436662', '/login-log', '1695436662', '1');
INSERT INTO `message` VALUES ('188', '11', '消息标题1695436662', '/login-log', '1695436663', '0');
INSERT INTO `message` VALUES ('189', '10', '消息标题1695436663', '/login-log', '1695436664', '1');
INSERT INTO `message` VALUES ('190', '11', '消息标题1695436663', '/login-log', '1695436664', '0');
INSERT INTO `message` VALUES ('191', '10', '消息标题1695436665', '/login-log', '1695436665', '1');
INSERT INTO `message` VALUES ('192', '11', '消息标题1695436665', '/login-log', '1695436665', '0');
INSERT INTO `message` VALUES ('193', '10', '消息标题1695436666', '/login-log', '1695436666', '1');
INSERT INTO `message` VALUES ('194', '11', '消息标题1695436666', '/login-log', '1695436666', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=734 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES ('1', '1', '1704425442', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('2', '1', '1704425444', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('3', '1', '1704425445', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('4', '1', '1704425446', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('5', '1', '1704425448', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('6', '1', '1704425450', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('7', '1', '1704425453', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('8', '1', '1704425455', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('9', '1', '1704425458', '127.0.0.1', '/manage/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('10', '1', '1704680601', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('11', '1', '1704680607', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('12', '1', '1704680607', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('13', '1', '1704680611', '127.0.0.1', '/manage/system.user/initadd');
INSERT INTO `operation_log` VALUES ('14', '1', '1704680614', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('15', '1', '1704680617', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('16', '1', '1704680619', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('17', '1', '1704680621', '127.0.0.1', '/manage/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('18', '1', '1704680628', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('19', '1', '1704680632', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('20', '1', '1704680665', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('21', '1', '1704680666', '127.0.0.1', '/manage/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('22', '1', '1704680668', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('23', '1', '1704680854', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('24', '1', '1704680854', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('25', '1', '1705907601', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('26', '1', '1706066876', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('27', '1', '1706066894', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('28', '1', '1706066921', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('29', '1', '1706066948', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('30', '1', '1706067119', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('31', '1', '1706234585', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('32', '1', '1706234591', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('33', '1', '1706234594', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('34', '1', '1706234606', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('35', '1', '1706234610', '127.0.0.1', '/manage/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('36', '1', '1706234670', '127.0.0.1', '/manage/system.menu/saveadd');
INSERT INTO `operation_log` VALUES ('37', '1', '1706234671', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('38', '1', '1706234674', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('39', '1', '1706234678', '127.0.0.1', '/manage/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('40', '1', '1706234729', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('41', '1', '1706234872', '127.0.0.1', '/manage/system.menu/saveadd');
INSERT INTO `operation_log` VALUES ('42', '1', '1706234872', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('43', '1', '1706234881', '127.0.0.1', '/manage/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('44', '1', '1706234995', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('45', '1', '1706234998', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('46', '1', '1706235013', '127.0.0.1', '/manage/system.menu/saveadd');
INSERT INTO `operation_log` VALUES ('47', '1', '1706235013', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('48', '1', '1706235028', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('49', '1', '1706235028', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('50', '1', '1706235036', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('51', '1', '1706235044', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('52', '1', '1706235046', '127.0.0.1', '/manage/system.role/initedit');
INSERT INTO `operation_log` VALUES ('53', '1', '1706235049', '127.0.0.1', '/manage/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('54', '1', '1706235049', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('55', '1', '1706235052', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('56', '1', '1706235064', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('57', '1', '1706235067', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('58', '1', '1706235080', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('59', '1', '1706235081', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('60', '1', '1706235084', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('61', '1', '1706235143', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('62', '1', '1706235154', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('63', '1', '1706235172', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('64', '1', '1706235321', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('65', '1', '1706235330', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('66', '1', '1706235330', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('67', '1', '1706235352', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('68', '1', '1706235373', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('69', '1', '1706235376', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('70', '1', '1706235388', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('71', '1', '1706235389', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('72', '1', '1706235636', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('73', '1', '1706235747', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('74', '1', '1706235754', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('75', '1', '1706235754', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('76', '1', '1706235772', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('77', '1', '1706235788', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('78', '1', '1706235789', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('79', '1', '1706235793', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('80', '1', '1706235856', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('81', '1', '1706235858', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('82', '1', '1706235881', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('83', '1', '1706235955', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('84', '1', '1706236384', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('85', '1', '1706236386', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('86', '1', '1706236391', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('87', '1', '1706236400', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('88', '1', '1706236400', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('89', '1', '1706236405', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('90', '1', '1706236413', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('91', '1', '1706236413', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('92', '1', '1706236416', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('93', '1', '1706236434', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('94', '1', '1706236442', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('95', '1', '1706236442', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('96', '1', '1706236446', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('97', '1', '1706236483', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('98', '1', '1706236509', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('99', '1', '1706236542', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('100', '1', '1706236577', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('101', '1', '1706236612', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('102', '1', '1706236612', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('103', '1', '1706236616', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('104', '1', '1706236636', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('105', '1', '1706236637', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('106', '1', '1706236639', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('107', '1', '1706236660', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('108', '1', '1706236664', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('109', '1', '1706236676', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('110', '1', '1706236715', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('111', '1', '1706236724', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('112', '1', '1706236975', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('113', '1', '1706237009', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('114', '1', '1706237014', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('115', '1', '1706237015', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('116', '1', '1706237018', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('117', '1', '1706237039', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('118', '1', '1706237044', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('119', '1', '1706237058', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('120', '1', '1706237059', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('121', '1', '1706237080', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('122', '1', '1706237081', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('123', '1', '1706237086', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('124', '1', '1706237103', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('125', '1', '1706237122', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('126', '1', '1706237236', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('127', '1', '1706237497', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('128', '1', '1706237509', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('129', '1', '1706237517', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('130', '1', '1706237520', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('131', '1', '1706237522', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('132', '1', '1706237524', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('133', '1', '1706237888', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('134', '1', '1706237903', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('135', '1', '1706237983', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('136', '1', '1706237988', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('137', '1', '1706238020', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('138', '1', '1706238020', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('139', '1', '1706238519', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('140', '1', '1706238520', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('141', '1', '1706238779', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('142', '1', '1706238829', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('143', '1', '1706238864', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('144', '1', '1706238912', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('145', '1', '1706238950', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('146', '1', '1706238954', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('147', '1', '1706238978', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('148', '1', '1706239026', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('149', '1', '1706239038', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('150', '1', '1706239057', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('151', '1', '1706239097', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('152', '1', '1706239103', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('153', '1', '1706239112', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('154', '1', '1706239120', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('155', '1', '1706239165', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('156', '1', '1706239173', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('157', '1', '1706239173', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('158', '1', '1706239210', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('159', '1', '1706239211', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('160', '1', '1706239221', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('161', '1', '1706239222', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('162', '1', '1706239235', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('163', '1', '1706239235', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('164', '1', '1706239278', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('165', '1', '1706239279', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('166', '1', '1706239280', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('167', '1', '1706239282', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('168', '1', '1706239285', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('169', '1', '1706239286', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('170', '1', '1706239296', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('171', '1', '1706239296', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('172', '1', '1706239369', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('173', '1', '1706239382', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('174', '1', '1706239412', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('175', '1', '1706239420', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('176', '1', '1706239451', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('177', '1', '1706239467', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('178', '1', '1706239511', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('179', '1', '1706239513', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('180', '1', '1706239515', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('181', '1', '1706239520', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('182', '1', '1706239527', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('183', '1', '1706239570', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('184', '1', '1706239573', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('185', '1', '1706239578', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('186', '1', '1706239593', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('187', '1', '1706239594', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('188', '1', '1706239598', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('189', '1', '1706239656', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('190', '1', '1706240621', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('191', '1', '1706240626', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('192', '1', '1706240663', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('193', '1', '1706240861', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('194', '1', '1706240971', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('195', '1', '1706241060', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('196', '1', '1706241096', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('197', '1', '1706241197', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('198', '1', '1706241200', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('199', '1', '1706241201', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('200', '1', '1706241298', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('201', '1', '1706241303', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('202', '1', '1706241306', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('203', '1', '1706241311', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('204', '1', '1706241347', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('205', '1', '1706241348', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('206', '1', '1706241363', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('207', '1', '1706241364', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('208', '1', '1706329634', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('209', '1', '1706329767', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('210', '1', '1706329883', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('211', '1', '1706329925', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('212', '1', '1706330019', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('213', '1', '1706330034', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('214', '1', '1706330046', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('215', '1', '1706332788', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('216', '1', '1706332790', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('217', '1', '1706332793', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('218', '1', '1706332795', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('219', '1', '1706332795', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('220', '1', '1706332797', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('221', '1', '1706332800', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('222', '1', '1706332803', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('223', '1', '1706332805', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('224', '1', '1706332808', '127.0.0.1', '/manage/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('225', '1', '1706333133', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('226', '1', '1706333135', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('227', '1', '1706333139', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('228', '1', '1706333140', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('229', '1', '1706333140', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('230', '1', '1706333142', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('231', '1', '1706333144', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('232', '1', '1706333149', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('233', '1', '1706333564', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('234', '1', '1706333602', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('235', '1', '1706333612', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('236', '1', '1706333613', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('237', '1', '1706333627', '127.0.0.1', '/manage/system.user/initadd');
INSERT INTO `operation_log` VALUES ('238', '1', '1706333731', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('239', '1', '1706333731', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('240', '1', '1706333742', '127.0.0.1', '/manage/system.user/initadd');
INSERT INTO `operation_log` VALUES ('241', '1', '1706333766', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('242', '1', '1706333778', '127.0.0.1', '/manage/system.department/initadd');
INSERT INTO `operation_log` VALUES ('243', '1', '1706333790', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('244', '1', '1706333799', '127.0.0.1', '/manage/system.role/initadd');
INSERT INTO `operation_log` VALUES ('245', '1', '1706333823', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('246', '1', '1706333830', '127.0.0.1', '/manage/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('247', '1', '1706333849', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('248', '1', '1706333877', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('249', '1', '1706333900', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('250', '1', '1706333905', '127.0.0.1', '/manage/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('251', '1', '1706333934', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('252', '1', '1706333952', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('253', '1', '1706335083', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('254', '1', '1706335084', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('255', '1', '1706335119', '127.0.0.1', '/manage/system.user/initadd');
INSERT INTO `operation_log` VALUES ('256', '1', '1706335146', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('257', '1', '1706335156', '127.0.0.1', '/manage/system.department/initadd');
INSERT INTO `operation_log` VALUES ('258', '1', '1711100240', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('259', '1', '1711100271', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('260', '1', '1711100663', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('261', '1', '1711100846', '127.0.0.1', '/manage/system.config/save');
INSERT INTO `operation_log` VALUES ('262', '1', '1711100853', '127.0.0.1', '/manage/system.config/save');
INSERT INTO `operation_log` VALUES ('263', '1', '1711100872', '127.0.0.1', '/manage/system.config/save');
INSERT INTO `operation_log` VALUES ('264', '1', '1711100902', '127.0.0.1', '/manage/system.config/save');
INSERT INTO `operation_log` VALUES ('265', '1', '1711100905', '127.0.0.1', '/manage/system.config/save');
INSERT INTO `operation_log` VALUES ('266', '1', '1711100929', '127.0.0.1', '/manage/system.config/save');
INSERT INTO `operation_log` VALUES ('267', '1', '1711100962', '127.0.0.1', '/manage/system.config/save');
INSERT INTO `operation_log` VALUES ('268', '1', '1711100967', '127.0.0.1', '/manage/system.config/save');
INSERT INTO `operation_log` VALUES ('269', '1', '1711100972', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('270', '1', '1711101047', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('271', '1', '1711101466', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('272', '1', '1711101471', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('273', '1', '1711101472', '127.0.0.1', '/manage/system.config/save');
INSERT INTO `operation_log` VALUES ('274', '1', '1711101489', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('275', '1', '1711101490', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('276', '1', '1711101493', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('277', '1', '1711101494', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('278', '1', '1711101494', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('279', '1', '1711101581', '127.0.0.1', '/manage/system.user/initadd');
INSERT INTO `operation_log` VALUES ('280', '1', '1711101588', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('281', '1', '1711101597', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('282', '1', '1711101599', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('283', '1', '1711101599', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('284', '1', '1711101600', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('285', '1', '1711101601', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('286', '1', '1711101602', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('287', '1', '1711101603', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('288', '1', '1711101607', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('289', '1', '1711101610', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('290', '1', '1713516214', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('291', '1', '1713516223', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('292', '1', '1713516229', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('293', '1', '1713516231', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('294', '1', '1713516862', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('295', '1', '1713516866', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('296', '1', '1713516868', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('297', '1', '1713517342', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('298', '1', '1713517345', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('299', '1', '1713517347', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('300', '1', '1713517349', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('301', '1', '1713517354', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('302', '1', '1713517368', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('303', '1', '1713517368', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('304', '1', '1713517371', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('305', '1', '1713517377', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('306', '1', '1713517377', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('307', '1', '1713517384', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('308', '1', '1713517388', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('309', '1', '1713517396', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('310', '1', '1713517403', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('311', '1', '1713517406', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('312', '1', '1713517409', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('313', '1', '1713517410', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('314', '1', '1713517425', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('315', '1', '1713517434', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('316', '1', '1713517435', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('317', '1', '1713517438', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('318', '1', '1713517452', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('319', '1', '1713517452', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('320', '1', '1713517487', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('321', '1', '1713517492', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('322', '1', '1713517494', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('323', '1', '1713517496', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('324', '1', '1713517502', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('325', '1', '1713517510', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('326', '1', '1713517512', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('327', '1', '1713517512', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('328', '1', '1713517514', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('329', '1', '1713517515', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('330', '1', '1713517516', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('331', '1', '1713517518', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('332', '1', '1713517519', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('333', '1', '1713517520', '127.0.0.1', '/manage/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('334', '1', '1713517527', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('335', '1', '1713517530', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('336', '1', '1713517551', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('337', '1', '1713517553', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('338', '1', '1713517559', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('339', '1', '1713517561', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('340', '1', '1713517561', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('341', '1', '1713517563', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('342', '1', '1713517564', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('343', '1', '1713517570', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('344', '1', '1713517573', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('345', '1', '1713517684', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('346', '1', '1713517945', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('347', '1', '1713517960', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('348', '1', '1713517966', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('349', '1', '1713517968', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('350', '1', '1713517968', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('351', '1', '1713517970', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('352', '1', '1713517971', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('353', '1', '1714358962', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('354', '1', '1714358967', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('355', '1', '1714359031', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('356', '1', '1714359031', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('357', '1', '1714359034', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('358', '1', '1714359042', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('359', '1', '1714359042', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('360', '1', '1714359044', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('361', '1', '1714359070', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('362', '1', '1714359070', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('363', '1', '1714359078', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('364', '1', '1714359087', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('365', '1', '1714359087', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('366', '1', '1714359184', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('367', '1', '1714359190', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('368', '1', '1714359195', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('369', '1', '1714359216', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('370', '1', '1714359219', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('371', '1', '1714359236', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('372', '1', '1714359237', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('373', '1', '1714359239', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('374', '1', '1714359261', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('375', '1', '1714359261', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('376', '1', '1714359266', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('377', '1', '1714359269', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('378', '1', '1714359269', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('379', '1', '1714359271', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('380', '1', '1714359277', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('381', '1', '1714359278', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('382', '1', '1714359279', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('383', '1', '1714359287', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('384', '1', '1714359287', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('385', '1', '1714359297', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('386', '1', '1714359355', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('387', '1', '1714359448', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('388', '1', '1714359460', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('389', '1', '1714359488', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('390', '1', '1714359713', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('391', '1', '1714359733', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('392', '1', '1714360160', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('393', '1', '1714360450', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('394', '1', '1714360457', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('395', '1', '1714360466', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('396', '1', '1714360467', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('397', '1', '1714360468', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('398', '1', '1714360470', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('399', '1', '1714360472', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('400', '1', '1714360473', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('401', '1', '1714360476', '127.0.0.1', '/manage/statistic.department/exportexcel');
INSERT INTO `operation_log` VALUES ('402', '1', '1714447715', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('403', '1', '1714447718', '127.0.0.1', '/desktop/statistic.department/init');
INSERT INTO `operation_log` VALUES ('404', '1', '1714447723', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('405', '1', '1714447792', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('406', '1', '1714447795', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('407', '1', '1714447795', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('408', '1', '1714447797', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('409', '1', '1714447802', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('410', '1', '1714447804', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('411', '1', '1714447806', '127.0.0.1', '/desktop/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('412', '1', '1714447808', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('413', '1', '1714447834', '127.0.0.1', '/desktop/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('414', '1', '1714447836', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('415', '1', '1714447838', '127.0.0.1', '/desktop/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('416', '1', '1714447838', '127.0.0.1', '/desktop/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('417', '1', '1714447840', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('418', '1', '1714447925', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('419', '1', '1714447926', '127.0.0.1', '/desktop/statistic.department/init');
INSERT INTO `operation_log` VALUES ('420', '1', '1714447928', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('421', '1', '1714447930', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('422', '1', '1714447930', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('423', '1', '1714447930', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('424', '1', '1714448097', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('425', '1', '1714448099', '127.0.0.1', '/desktop/statistic.department/init');
INSERT INTO `operation_log` VALUES ('426', '1', '1714448103', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('427', '1', '1714448130', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('428', '1', '1714448140', '127.0.0.1', '/desktop/statistic.department/init');
INSERT INTO `operation_log` VALUES ('429', '1', '1714448156', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('430', '1', '1714448403', '127.0.0.1', '/desktop/system.config/save');
INSERT INTO `operation_log` VALUES ('431', '1', '1714448507', '127.0.0.1', '/desktop/system.config/save');
INSERT INTO `operation_log` VALUES ('432', '1', '1714448664', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('433', '1', '1714448664', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('434', '1', '1714448668', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('435', '1', '1714448669', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('436', '1', '1714448669', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('437', '1', '1714460450', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('438', '1', '1714460450', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('439', '1', '1714460450', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('440', '1', '1714460451', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('441', '1', '1714460458', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('442', '1', '1714460463', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('443', '1', '1714460746', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('444', '1', '1714460773', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('445', '1', '1714460776', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('446', '1', '1714460811', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('447', '1', '1714460813', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('448', '1', '1714460849', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('449', '1', '1714575652', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('450', '1', '1714633807', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('451', '1', '1714633818', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('452', '1', '1714633826', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('453', '1', '1714634095', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('454', '1', '1714634096', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('455', '1', '1714634103', '127.0.0.1', '/desktop/system.dictionary/initedit');
INSERT INTO `operation_log` VALUES ('456', '1', '1714634117', '127.0.0.1', '/desktop/system.dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('457', '1', '1714634117', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('458', '1', '1714634122', '127.0.0.1', '/desktop/system.dictionary/initedit');
INSERT INTO `operation_log` VALUES ('459', '1', '1714634152', '127.0.0.1', '/desktop/system.dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('460', '1', '1714634153', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('461', '1', '1714634163', '127.0.0.1', '/desktop/system.dictionary/initedit');
INSERT INTO `operation_log` VALUES ('462', '1', '1714634165', '127.0.0.1', '/desktop/system.dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('463', '1', '1714634166', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('464', '1', '1714634178', '127.0.0.1', '/desktop/system.dictionary/initedit');
INSERT INTO `operation_log` VALUES ('465', '1', '1714634184', '127.0.0.1', '/desktop/system.dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('466', '1', '1714634185', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('467', '1', '1714634187', '127.0.0.1', '/desktop/system.dictionary/initedit');
INSERT INTO `operation_log` VALUES ('468', '1', '1714634190', '127.0.0.1', '/desktop/system.dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('469', '1', '1714634191', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('470', '1', '1714634194', '127.0.0.1', '/desktop/system.dictionary/initedit');
INSERT INTO `operation_log` VALUES ('471', '1', '1714634199', '127.0.0.1', '/desktop/system.dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('472', '1', '1714634200', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('473', '1', '1714634202', '127.0.0.1', '/desktop/system.dictionary/initedit');
INSERT INTO `operation_log` VALUES ('474', '1', '1714634205', '127.0.0.1', '/desktop/system.dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('475', '1', '1714634205', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('476', '1', '1714634208', '127.0.0.1', '/desktop/system.dictionary/initedit');
INSERT INTO `operation_log` VALUES ('477', '1', '1714634210', '127.0.0.1', '/desktop/system.dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('478', '1', '1714634211', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('479', '1', '1714634213', '127.0.0.1', '/desktop/system.dictionary/initedit');
INSERT INTO `operation_log` VALUES ('480', '1', '1714634215', '127.0.0.1', '/desktop/system.dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('481', '1', '1714634215', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('482', '1', '1714634248', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('483', '1', '1714634256', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('484', '1', '1714634298', '127.0.0.1', '/desktop/system.desktop.module/saveedit');
INSERT INTO `operation_log` VALUES ('485', '1', '1714634299', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('486', '1', '1714634303', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('487', '1', '1714634339', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('488', '1', '1714634344', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('489', '1', '1714634485', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('490', '1', '1714634493', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('491', '1', '1714634503', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('492', '1', '1714634654', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('493', '1', '1714634678', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('494', '1', '1714634684', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('495', '1', '1714634688', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('496', '1', '1714634696', '127.0.0.1', '/desktop/system.desktop.module/saveadd');
INSERT INTO `operation_log` VALUES ('497', '1', '1714634696', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('498', '1', '1714634700', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('499', '1', '1714634715', '127.0.0.1', '/desktop/system.desktop.module/saveedit');
INSERT INTO `operation_log` VALUES ('500', '1', '1714634715', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('501', '1', '1714634720', '127.0.0.1', '/desktop/system.desktop.module/delete');
INSERT INTO `operation_log` VALUES ('502', '1', '1714634720', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('503', '1', '1714634877', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('504', '1', '1714634908', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('505', '1', '1714635546', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('506', '1', '1714635630', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('507', '1', '1714635717', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('508', '1', '1714635734', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('509', '1', '1714635848', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('510', '1', '1714635954', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('511', '1', '1714635958', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('512', '1', '1714635989', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('513', '1', '1714635992', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('514', '1', '1714635995', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('515', '1', '1714636046', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('516', '1', '1714636049', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('517', '1', '1714636071', '127.0.0.1', '/desktop/system.role/saveadd');
INSERT INTO `operation_log` VALUES ('518', '1', '1714636072', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('519', '1', '1714636555', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('520', '1', '1714636622', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('521', '1', '1714636622', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('522', '1', '1714636624', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('523', '1', '1714636655', '127.0.0.1', '/desktop/system.role/delete');
INSERT INTO `operation_log` VALUES ('524', '1', '1714636656', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('525', '1', '1714636679', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('526', '1', '1714636679', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('527', '1', '1714636681', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('528', '1', '1714636682', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('529', '1', '1714636682', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('530', '1', '1714656307', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('531', '1', '1714656332', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('532', '1', '1714656335', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('533', '1', '1714656496', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('534', '1', '1714656499', '127.0.0.1', '/desktop/statistic.department/init');
INSERT INTO `operation_log` VALUES ('535', '1', '1714656507', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('536', '1', '1714656510', '127.0.0.1', '/desktop/statistic.department/init');
INSERT INTO `operation_log` VALUES ('537', '1', '1714656512', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('538', '1', '1714656514', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('539', '1', '1714656514', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('540', '1', '1714656516', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('541', '1', '1714656517', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('542', '1', '1714656518', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('543', '1', '1714656528', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('544', '1', '1714656578', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('545', '1', '1714656664', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('546', '1', '1714656664', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('547', '1', '1714656666', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('548', '1', '1714656687', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('549', '1', '1714656688', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('550', '1', '1714656691', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('551', '1', '1714656694', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('552', '1', '1714656697', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('553', '1', '1714656702', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('554', '1', '1714656713', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('555', '1', '1714656715', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('556', '1', '1714656723', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('557', '1', '1714656804', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('558', '1', '1714656804', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('559', '1', '1714656806', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('560', '1', '1714656807', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('561', '1', '1714656809', '127.0.0.1', '/desktop/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('562', '1', '1714656829', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('563', '1', '1714656907', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('564', '1', '1714656909', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('565', '1', '1714656952', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('566', '1', '1714656955', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('567', '1', '1714656955', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('568', '1', '1714656957', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('569', '1', '1714656960', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('570', '1', '1714656961', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('571', '1', '1714656963', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('572', '1', '1714656971', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('573', '1', '1714656972', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('574', '1', '1714656989', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('575', '1', '1714656992', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('576', '1', '1714657001', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('577', '1', '1714657203', '127.0.0.1', '/desktop/system.desktop.module/saveadd');
INSERT INTO `operation_log` VALUES ('578', '1', '1714657203', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('579', '1', '1714657206', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('580', '1', '1714657208', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('581', '1', '1714657224', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('582', '1', '1714657227', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('583', '1', '1714657278', '127.0.0.1', '/desktop/system.desktop.module/saveadd');
INSERT INTO `operation_log` VALUES ('584', '1', '1714657278', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('585', '1', '1714657279', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('586', '1', '1714657284', '127.0.0.1', '/desktop/system.desktop.module/saveedit');
INSERT INTO `operation_log` VALUES ('587', '1', '1714657285', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('588', '1', '1714657287', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('589', '1', '1714657291', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('590', '1', '1714657297', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('591', '1', '1714657365', '127.0.0.1', '/desktop/system.desktop.module/saveedit');
INSERT INTO `operation_log` VALUES ('592', '1', '1714657365', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('593', '1', '1714657376', '127.0.0.1', '/desktop/system.desktop.module/saveadd');
INSERT INTO `operation_log` VALUES ('594', '1', '1714657376', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('595', '1', '1714657379', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('596', '1', '1714657394', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('597', '1', '1714657434', '127.0.0.1', '/desktop/system.desktop.module/saveadd');
INSERT INTO `operation_log` VALUES ('598', '1', '1714657435', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('599', '1', '1714657436', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('600', '1', '1714657439', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('601', '1', '1714657446', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('602', '1', '1714657447', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('603', '1', '1714657452', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('604', '1', '1714657456', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('605', '1', '1714657462', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('606', '1', '1714657523', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('607', '1', '1714657531', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('608', '1', '1714657599', '127.0.0.1', '/desktop/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('609', '1', '1714657601', '127.0.0.1', '/desktop/system.config/init');
INSERT INTO `operation_log` VALUES ('610', '1', '1714657605', '127.0.0.1', '/desktop/system.user/initindex');
INSERT INTO `operation_log` VALUES ('611', '1', '1714657605', '127.0.0.1', '/desktop/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('612', '1', '1714657612', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('613', '1', '1714658209', '127.0.0.1', '/desktop/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('614', '1', '1714658272', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('615', '1', '1714658290', '127.0.0.1', '/desktop/system.dictionary/saveadd');
INSERT INTO `operation_log` VALUES ('616', '1', '1714658291', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('617', '1', '1714658300', '127.0.0.1', '/desktop/system.dictionary/saveadd');
INSERT INTO `operation_log` VALUES ('618', '1', '1714658301', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('619', '1', '1714658315', '127.0.0.1', '/desktop/system.dictionary/saveadd');
INSERT INTO `operation_log` VALUES ('620', '1', '1714658316', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('621', '1', '1714658407', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('622', '1', '1714658462', '127.0.0.1', '/desktop/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('623', '1', '1714658717', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('624', '1', '1714658720', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('625', '1', '1714658888', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('626', '1', '1714658993', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('627', '1', '1714658999', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('628', '1', '1714659003', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('629', '1', '1714659004', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('630', '1', '1714659030', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('631', '1', '1714659040', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('632', '1', '1714659132', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('633', '1', '1714659139', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('634', '1', '1714659142', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('635', '1', '1714659337', '127.0.0.1', '/desktop/system.desktop.module/initadd');
INSERT INTO `operation_log` VALUES ('636', '1', '1714659355', '127.0.0.1', '/desktop/system.mobile.module/initadd');
INSERT INTO `operation_log` VALUES ('637', '1', '1714659446', '127.0.0.1', '/desktop/system.mobile.module/initadd');
INSERT INTO `operation_log` VALUES ('638', '1', '1714659483', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('639', '1', '1714659485', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('640', '1', '1714659488', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('641', '1', '1714659490', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('642', '1', '1714659498', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('643', '1', '1714659520', '127.0.0.1', '/desktop/system.desktop.module/saveedit');
INSERT INTO `operation_log` VALUES ('644', '1', '1714659521', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('645', '1', '1714659535', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('646', '1', '1714659537', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('647', '1', '1714659545', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('648', '1', '1714659548', '127.0.0.1', '/desktop/system.mobile.module/initadd');
INSERT INTO `operation_log` VALUES ('649', '1', '1714659562', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('650', '1', '1714659567', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('651', '1', '1714659569', '127.0.0.1', '/desktop/system.mobile.module/initadd');
INSERT INTO `operation_log` VALUES ('652', '1', '1714659596', '127.0.0.1', '/desktop/system.mobile.module/saveadd');
INSERT INTO `operation_log` VALUES ('653', '1', '1714659609', '127.0.0.1', '/desktop/system.mobile.module/saveadd');
INSERT INTO `operation_log` VALUES ('654', '1', '1714659625', '127.0.0.1', '/desktop/system.mobile.module/saveadd');
INSERT INTO `operation_log` VALUES ('655', '1', '1714659625', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('656', '1', '1714659639', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('657', '1', '1714659644', '127.0.0.1', '/desktop/system.mobile.module/initadd');
INSERT INTO `operation_log` VALUES ('658', '1', '1714659687', '127.0.0.1', '/desktop/system.mobile.module/saveadd');
INSERT INTO `operation_log` VALUES ('659', '1', '1714659687', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('660', '1', '1714659690', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('661', '1', '1714659813', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('662', '1', '1714659814', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('663', '1', '1714659986', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('664', '1', '1714659988', '127.0.0.1', '/desktop/system.mobile.module/initedit');
INSERT INTO `operation_log` VALUES ('665', '1', '1714659997', '127.0.0.1', '/desktop/system.mobile.module/initedit');
INSERT INTO `operation_log` VALUES ('666', '1', '1714660028', '127.0.0.1', '/desktop/system.mobile.module/initedit');
INSERT INTO `operation_log` VALUES ('667', '1', '1714660073', '127.0.0.1', '/desktop/system.mobile.module/saveedit');
INSERT INTO `operation_log` VALUES ('668', '1', '1714660073', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('669', '1', '1714660138', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('670', '1', '1714660145', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('671', '1', '1714660148', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('672', '1', '1714660486', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('673', '1', '1714660528', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('674', '1', '1714660533', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('675', '1', '1714660541', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('676', '1', '1714660635', '127.0.0.1', '/desktop/system.role/initadd');
INSERT INTO `operation_log` VALUES ('677', '1', '1714660644', '127.0.0.1', '/desktop/system.role/saveadd');
INSERT INTO `operation_log` VALUES ('678', '1', '1714660645', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('679', '1', '1714660647', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('680', '1', '1714660973', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('681', '1', '1714661015', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('682', '1', '1714661029', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('683', '1', '1714661033', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('684', '1', '1714661039', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('685', '1', '1714661045', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('686', '1', '1714661056', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('687', '1', '1714661063', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('688', '1', '1714661070', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('689', '1', '1714661077', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('690', '1', '1714661107', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('691', '1', '1714661114', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('692', '1', '1714661149', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('693', '1', '1714661181', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('694', '1', '1714661193', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('695', '1', '1714661209', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('696', '1', '1714661246', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('697', '1', '1714661253', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('698', '1', '1714661265', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('699', '1', '1714661285', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('700', '1', '1714661399', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('701', '1', '1714661399', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('702', '1', '1714661402', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('703', '1', '1714661408', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('704', '1', '1714661412', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('705', '1', '1714661413', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('706', '1', '1714661415', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('707', '1', '1714661428', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('708', '1', '1714661431', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('709', '1', '1714661433', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('710', '1', '1714661516', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('711', '1', '1714661522', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('712', '1', '1714661525', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('713', '1', '1714661525', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('714', '1', '1714661612', '127.0.0.1', '/desktop/system.role/delete');
INSERT INTO `operation_log` VALUES ('715', '1', '1714661612', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('716', '1', '1714661636', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('717', '1', '1714661652', '127.0.0.1', '/desktop/system.mobile.module/initadd');
INSERT INTO `operation_log` VALUES ('718', '1', '1714661666', '127.0.0.1', '/desktop/system.desktop.module/initedit');
INSERT INTO `operation_log` VALUES ('719', '1', '1714661681', '127.0.0.1', '/desktop/system.mobile.module/saveadd');
INSERT INTO `operation_log` VALUES ('720', '1', '1714661682', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('721', '1', '1714661684', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('722', '1', '1714661686', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('723', '1', '1714661690', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('724', '1', '1714661691', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('725', '1', '1714661693', '127.0.0.1', '/desktop/system.role/initedit');
INSERT INTO `operation_log` VALUES ('726', '1', '1714661697', '127.0.0.1', '/desktop/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('727', '1', '1714661698', '127.0.0.1', '/desktop/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('728', '1', '1714661793', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('729', '1', '1714662141', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('730', '1', '1714662142', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('731', '1', '1714662485', '127.0.0.1', '/desktop/system.mobile.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('732', '1', '1714663266', '127.0.0.1', '/desktop/system.desktop.module/getindexmodules');
INSERT INTO `operation_log` VALUES ('733', '1', '1714663266', '127.0.0.1', '/desktop/system.role/getindexroles');

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
) ENGINE=InnoDB AUTO_INCREMENT=378 DEFAULT CHARSET=utf8 COMMENT='角色模块关系';

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='角色模块关系';

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='运行时';

-- ----------------------------
-- Records of runtime
-- ----------------------------
INSERT INTO `runtime` VALUES ('1', 'version', '1.0.0');

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
INSERT INTO `user` VALUES ('1', '1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '张三', '15122222222', '', '1684989244', '1687667332', '1714633753', '127.0.0.1');
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
INSERT INTO `user_role` VALUES ('46', '1', '1');
INSERT INTO `user_role` VALUES ('47', '1', '2');
INSERT INTO `user_role` VALUES ('50', '2', '2');
