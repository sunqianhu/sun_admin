/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50744
Source Host           : localhost:3306
Source Database       : sun_admin

Target Server Type    : MYSQL
Target Server Version : 50744
File Encoding         : 65001

Date: 2026-11-03 17:20:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `system_name` varchar(127) NOT NULL DEFAULT '' COMMENT '系统名称',
  `denied_ips_string` text NOT NULL COMMENT '拒绝登录ip串',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统配置';

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('1', 'sun admin', '');

-- ----------------------------
-- Table structure for data_scope
-- ----------------------------
DROP TABLE IF EXISTS `data_scope`;
CREATE TABLE `data_scope` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '权限名称',
  `key` varchar(63) NOT NULL DEFAULT '' COMMENT '权限标识',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='数据权限';

-- ----------------------------
-- Records of data_scope
-- ----------------------------
INSERT INTO `data_scope` VALUES ('1', '全局部门访问', 'global_department_access', '0');
INSERT INTO `data_scope` VALUES ('2', '全局用户访问', 'global_user_access', '3');

-- ----------------------------
-- Table structure for data_scope_policy
-- ----------------------------
DROP TABLE IF EXISTS `data_scope_policy`;
CREATE TABLE `data_scope_policy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `data_scope_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数据权限ID',
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '名称',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '策略类型',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='策略';

-- ----------------------------
-- Records of data_scope_policy
-- ----------------------------
INSERT INTO `data_scope_policy` VALUES ('1', '1', '本单位', '1', '1');
INSERT INTO `data_scope_policy` VALUES ('2', '1', '本单位及下级单位', '2', '2');
INSERT INTO `data_scope_policy` VALUES ('3', '1', '全部权限', '99', '99');
INSERT INTO `data_scope_policy` VALUES ('4', '1', '指定的单位', '98', '98');
INSERT INTO `data_scope_policy` VALUES ('5', '1', '本用户', '0', '0');
INSERT INTO `data_scope_policy` VALUES ('6', '2', '本单位', '1', '1');
INSERT INTO `data_scope_policy` VALUES ('7', '2', '本单位及下级单位', '2', '2');
INSERT INTO `data_scope_policy` VALUES ('8', '2', '指定单位', '98', '98');
INSERT INTO `data_scope_policy` VALUES ('9', '2', '全部权限', '99', '99');
INSERT INTO `data_scope_policy` VALUES ('10', '2', '本用户', '0', '0');

-- ----------------------------
-- Table structure for data_scope_policy_department
-- ----------------------------
DROP TABLE IF EXISTS `data_scope_policy_department`;
CREATE TABLE `data_scope_policy_department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `policy_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '规则ID',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '部门ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='策略的单位';

-- ----------------------------
-- Records of data_scope_policy_department
-- ----------------------------
INSERT INTO `data_scope_policy_department` VALUES ('4', '4', '3');
INSERT INTO `data_scope_policy_department` VALUES ('5', '8', '1');
INSERT INTO `data_scope_policy_department` VALUES ('6', '8', '3');

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
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '部门路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='部门';

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '0', '1', '部门1', '1', '/1');
INSERT INTO `department` VALUES ('2', '1', '2', '部门1-1', '1', '/1/2');
INSERT INTO `department` VALUES ('3', '0', '1', '部门2', '2', '/3');

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COMMENT='菜单';

-- ----------------------------
-- Records of desktop_menu
-- ----------------------------
INSERT INTO `desktop_menu` VALUES ('1', '0', '系统管理', '', 'Setting', '1', '999');
INSERT INTO `desktop_menu` VALUES ('2', '1', '用户管理', '/system/user', 'User', '1', '3');
INSERT INTO `desktop_menu` VALUES ('3', '1', '部门管理', '/system/department', 'Memo', '1', '5');
INSERT INTO `desktop_menu` VALUES ('4', '1', '角色管理', '/system/role', 'ChatSquare', '1', '7');
INSERT INTO `desktop_menu` VALUES ('5', '6', '菜单管理', '/system/desktop/menu', 'Reading', '1', '3');
INSERT INTO `desktop_menu` VALUES ('6', '1', '桌面端', '', 'Monitor', '1', '12');
INSERT INTO `desktop_menu` VALUES ('7', '6', '路由管理', '/system/desktop/route', 'Van', '1', '7');
INSERT INTO `desktop_menu` VALUES ('8', '1', '功能权限', '/system/permission', 'Lock', '1', '8');
INSERT INTO `desktop_menu` VALUES ('11', '1', '字典管理', '/system/dictionary', 'Notebook', '1', '13');
INSERT INTO `desktop_menu` VALUES ('12', '1', '系统设置', '/system/config', 'Cpu', '1', '1');
INSERT INTO `desktop_menu` VALUES ('13', '1', '登录日志', '/system/login-log', 'MapLocation', '1', '15');
INSERT INTO `desktop_menu` VALUES ('14', '1', '操作日志', '/system/operation-log', 'Mouse', '1', '17');
INSERT INTO `desktop_menu` VALUES ('15', '0', '系统首页', '/index', 'House', '1', '1');
INSERT INTO `desktop_menu` VALUES ('16', '0', '统计分析', '', 'PieChart', '1', '801');
INSERT INTO `desktop_menu` VALUES ('17', '16', '订单趋势统计', '/statistic/order-trend', 'Share', '1', '1');
INSERT INTO `desktop_menu` VALUES ('19', '0', '外部链接', 'https://www.baidu.com', 'Search', '9', '803');
INSERT INTO `desktop_menu` VALUES ('20', '1', '数据权限', '/system/data-scope', 'CopyDocument', '1', '10');
INSERT INTO `desktop_menu` VALUES ('21', '1', '会话管理', '/system/session', 'Key', '1', '14');
INSERT INTO `desktop_menu` VALUES ('22', '0', '流式请求', '/stream-fetch', 'MoonNight', '1', '805');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='路由';

-- ----------------------------
-- Records of desktop_route
-- ----------------------------
INSERT INTO `desktop_route` VALUES ('1', '用户管理', 'system_user', '/system/user', 'system/user/Index.vue', 'main', '0', '903');
INSERT INTO `desktop_route` VALUES ('2', '用户详情', 'system_user_detail', '/system/user/detail-:id', 'system/user/Detail.vue', 'blank', '0', '905');
INSERT INTO `desktop_route` VALUES ('3', '部门管理', 'system_department', '/system/department', 'system/department/Index.vue', 'main', '0', '907');
INSERT INTO `desktop_route` VALUES ('4', '角色管理', 'system_role', '/system/role', 'system/role/Index.vue', 'main', '0', '909');
INSERT INTO `desktop_route` VALUES ('5', '菜单管理', 'system_desktop_menu', '/system/desktop/menu', 'system/desktop/menu/Index.vue', 'main', '0', '911');
INSERT INTO `desktop_route` VALUES ('6', '路由管理', 'system_desktop_route', '/system/desktop/route', 'system/desktop/route/Index.vue', 'main', '0', '913');
INSERT INTO `desktop_route` VALUES ('7', '权限管理', 'system_permission', '/system/permission', 'system/permission/Index.vue', 'main', '0', '915');
INSERT INTO `desktop_route` VALUES ('8', '字典管理', 'system_dictionary', '/system/dictionary', 'system/dictionary/Index.vue', 'main', '0', '919');
INSERT INTO `desktop_route` VALUES ('9', '登录日志', 'system_login_log', '/system/login-log', 'system/login_log/Index.vue', 'main', '0', '921');
INSERT INTO `desktop_route` VALUES ('10', '操作日志', 'system_option_log', '/system/operation-log', 'system/operation_log/Index.vue', 'main', '0', '923');
INSERT INTO `desktop_route` VALUES ('11', '系统设置', 'system_config', '/system/config', 'system/config/Index.vue', 'main', '0', '901');
INSERT INTO `desktop_route` VALUES ('12', '系统首页', 'index', '/index', 'index/Index.vue', 'main', '0', '1');
INSERT INTO `desktop_route` VALUES ('13', '订单趋势统计', 'statistic_trend', '/statistic/order-trend', 'statistic/OrderTrend.vue', 'main', '0', '801');
INSERT INTO `desktop_route` VALUES ('16', '数据权限', 'system_data_scope', '/system/data-scope', 'system/data_scope/Index.vue', 'main', '0', '918');
INSERT INTO `desktop_route` VALUES ('17', '会话管理', 'session', '/system/session', 'system/session/Index.vue', 'main', '0', '920');
INSERT INTO `desktop_route` VALUES ('18', '流式提取', 'stream_fetch', '/stream-fetch', 'stream_fetch/Index.vue', 'main', '0', '803');

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COMMENT='字典';

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
INSERT INTO `dictionary` VALUES ('15', 'terminal', '0', '桌面端', '0');
INSERT INTO `dictionary` VALUES ('16', 'terminal', '1', '移动端', '1');
INSERT INTO `dictionary` VALUES ('17', 'terminal', '2', 'API接口', '2');
INSERT INTO `dictionary` VALUES ('18', 'data_scope_policy_type', '1', '本单位', '1');
INSERT INTO `dictionary` VALUES ('19', 'data_scope_policy_type', '2', '本单位及下级单位', '2');
INSERT INTO `dictionary` VALUES ('20', 'data_scope_policy_type', '99', '全部权限', '99');
INSERT INTO `dictionary` VALUES ('21', 'data_scope_policy_type', '98', '指定的单位', '98');
INSERT INTO `dictionary` VALUES ('22', 'data_scope_policy_type', '0', '本用户', '0');
INSERT INTO `dictionary` VALUES ('23', 'response_business_code', '0', '成功', '0');
INSERT INTO `dictionary` VALUES ('24', 'response_business_code', '1', '失败', '1');
INSERT INTO `dictionary` VALUES ('25', 'response_business_code', '2', '登录认证失败', '2');

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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '部门ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `terminal` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '终端',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `ip` varchar(31) NOT NULL DEFAULT '' COMMENT '登录ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES ('1', '1', '1', '0', '1793677281', '127.0.0.1');
INSERT INTO `login_log` VALUES ('2', '1', '1', '0', '1793680340', '127.0.0.1');
INSERT INTO `login_log` VALUES ('3', '1', '1', '0', '1793686914', '127.0.0.1');
INSERT INTO `login_log` VALUES ('4', '1', '1', '0', '1793696540', '127.0.0.1');

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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COMMENT='系统消息';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '1', '标题', '内容', 'https:/www.baidu.com', '1737189131', '1', '1793693787');
INSERT INTO `message` VALUES ('2', '1', '标题', '内容', 'https:/www.baidu.com', '1737189150', '1', '1793693787');
INSERT INTO `message` VALUES ('3', '1', '标题', '内容', 'https:/www.baidu.com', '1737189193', '1', '1793693787');
INSERT INTO `message` VALUES ('4', '1', '标题', '内容', 'https:/www.baidu.com', '1737189194', '1', '1793693787');
INSERT INTO `message` VALUES ('5', '1', '标题', '内容', 'https:/www.baidu.com', '1737189230', '1', '1793693787');
INSERT INTO `message` VALUES ('6', '1', '标题', '内容', 'https:/www.baidu.com', '1737189235', '1', '1793693787');
INSERT INTO `message` VALUES ('7', '1', '标题', '内容', 'https:/www.baidu.com', '1737189285', '1', '1793693787');
INSERT INTO `message` VALUES ('8', '1', '标题', '内容', 'https:/www.baidu.com', '1737189301', '1', '1793693787');
INSERT INTO `message` VALUES ('9', '1', '标题', '内容', 'https:/www.baidu.com', '1737189301', '1', '1793693787');
INSERT INTO `message` VALUES ('10', '1', '标题', '内容', 'https:/www.baidu.com', '1737189301', '1', '1793693787');
INSERT INTO `message` VALUES ('11', '1', '标题', '内容', 'https:/www.baidu.com', '1737189307', '1', '1793693787');
INSERT INTO `message` VALUES ('12', '1', '标题', '内容', 'https:/www.baidu.com', '1737189371', '1', '1793693787');
INSERT INTO `message` VALUES ('13', '1', '标题', '内容', 'https:/www.baidu.com', '1737189428', '1', '1793693787');
INSERT INTO `message` VALUES ('14', '1', '标题', '内容', 'https:/www.baidu.com', '1737191011', '1', '1793693787');
INSERT INTO `message` VALUES ('15', '1', '标题', '内容', 'https:/www.baidu.com', '1737191015', '1', '1793693787');
INSERT INTO `message` VALUES ('16', '1', '标题', '内容', 'https:/www.baidu.com', '1737191063', '1', '1793693787');
INSERT INTO `message` VALUES ('17', '1', '标题', '内容', 'https:/www.baidu.com', '1737195121', '1', '1793693787');
INSERT INTO `message` VALUES ('18', '1', '标题', '内容', 'https:/www.baidu.com', '1737195154', '1', '1793693787');
INSERT INTO `message` VALUES ('19', '1', '标题', '内容', 'https:/www.baidu.com', '1737195166', '1', '1793693787');
INSERT INTO `message` VALUES ('20', '1', '标题', '内容', 'https:/www.baidu.com', '1737195528', '1', '1793693787');
INSERT INTO `message` VALUES ('21', '1', '标题', '内容', 'https:/www.baidu.com', '1737195649', '1', '1793693787');
INSERT INTO `message` VALUES ('22', '1', '标题', '内容', 'https:/www.baidu.com', '1737195670', '1', '1793693787');
INSERT INTO `message` VALUES ('23', '1', '你的B站2024年度报告来啦', '珍贵的回忆已经为你打包完毕！今年你登录B站多少天？谁成为了你的最爱？戳链接回顾2024，查收UP主送来的惊喜彩蛋', 'https:/www.baidu.com', '1737196101', '1', '1793693787');
INSERT INTO `message` VALUES ('24', '1', '你的B站2024年度报告来啦', '珍贵的回忆已经为你打包完毕！今年你登录B站多少天？谁成为了你的最爱？戳链接回顾2024，查收UP主送来的惊喜彩蛋', 'https:/www.baidu.com', '1737196183', '1', '1793693787');
INSERT INTO `message` VALUES ('25', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793691818', '1', '1793693787');
INSERT INTO `message` VALUES ('26', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793691856', '1', '1793693787');
INSERT INTO `message` VALUES ('27', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793691936', '1', '1793693787');
INSERT INTO `message` VALUES ('28', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793692135', '1', '1793693787');
INSERT INTO `message` VALUES ('29', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793692145', '1', '1793693787');
INSERT INTO `message` VALUES ('30', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793692163', '1', '1793693787');
INSERT INTO `message` VALUES ('31', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793692231', '1', '1793693787');
INSERT INTO `message` VALUES ('32', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793692252', '1', '1793693787');
INSERT INTO `message` VALUES ('33', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793692253', '1', '1793693787');
INSERT INTO `message` VALUES ('34', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693583', '1', '1793693787');
INSERT INTO `message` VALUES ('35', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693597', '1', '1793693787');
INSERT INTO `message` VALUES ('36', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693599', '1', '1793693787');
INSERT INTO `message` VALUES ('37', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693600', '1', '1793693787');
INSERT INTO `message` VALUES ('38', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693602', '1', '1793693787');
INSERT INTO `message` VALUES ('39', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693603', '1', '1793693787');
INSERT INTO `message` VALUES ('40', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693604', '1', '1793693787');
INSERT INTO `message` VALUES ('41', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693605', '1', '1793693787');
INSERT INTO `message` VALUES ('42', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693606', '1', '1793693787');
INSERT INTO `message` VALUES ('43', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693608', '1', '1793693787');
INSERT INTO `message` VALUES ('44', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693609', '1', '1793693787');
INSERT INTO `message` VALUES ('45', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693622', '1', '1793693787');
INSERT INTO `message` VALUES ('46', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693623', '1', '1793693787');
INSERT INTO `message` VALUES ('47', '1', '测试消息标题', '测试消息内容', 'https://www.baidu.com', '1793693623', '1', '1793693787');

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '部门ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `session_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会话ID',
  `terminal` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '终端',
  `api` varchar(255) NOT NULL DEFAULT '' COMMENT '接口',
  `request_method` varchar(15) NOT NULL DEFAULT '' COMMENT '请求方法',
  `request_content` longtext COMMENT '请求内容',
  `response_http_code` int(10) unsigned DEFAULT NULL COMMENT 'HTTP状态码',
  `response_business_code` int(10) unsigned DEFAULT NULL COMMENT '业务码',
  `response_content` longtext COMMENT '响应内容',
  `duration` int(10) unsigned DEFAULT NULL COMMENT '处理耗时（毫秒）',
  `ip` varchar(31) NOT NULL DEFAULT '' COMMENT '操作ip',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `time` (`time`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Records of operation_log
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级权限id',
  `name` varchar(31) NOT NULL DEFAULT '' COMMENT '权限名称',
  `key` varchar(127) NOT NULL DEFAULT '' COMMENT '权限标识',
  `apis_string` text COMMENT '接口地址串',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_key` (`key`),
  KEY `permission_id` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COMMENT='全站权限';

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '0', '系统管理', 'system', '', '999');
INSERT INTO `permission` VALUES ('2', '1', '用户管理', 'system_user', 'desktop/system.user.Index/init\ndesktop/system.user.Index/getPaginate\ndesktop/system.user.Detail/init', '3');
INSERT INTO `permission` VALUES ('3', '2', '添加用户', 'system_user_add', 'desktop/system.user.Add/init\ndesktop/system.user.Add/save', '3');
INSERT INTO `permission` VALUES ('4', '2', '修改用户', 'system_user_edit', 'desktop/system.user.Edit/init\ndesktop/system.user.Edit/save', '5');
INSERT INTO `permission` VALUES ('5', '2', '修改密码', 'system_user_edit_password', 'desktop/system.user.PasswordEdit/save', '7');
INSERT INTO `permission` VALUES ('6', '2', '修改状态', 'system_user_edit_status', 'desktop/system.user.Index/editStatus', '9');
INSERT INTO `permission` VALUES ('7', '2', '踢桌面端下线', 'system_user_desktop_offline', 'desktop/system.user.Index/desktopOffline', '11');
INSERT INTO `permission` VALUES ('8', '1', '系统设置', 'system_config', 'desktop/system.config.Index/init\ndesktop/system.config.Index/save', '1');
INSERT INTO `permission` VALUES ('9', '1', '部门管理', 'system_department', 'desktop/system.department.Index/getTreeDepartment', '5');
INSERT INTO `permission` VALUES ('10', '1', '角色管理', 'system_role', 'desktop/system.role.Index/init\ndesktop/system.role.Index/getPaginate', '7');
INSERT INTO `permission` VALUES ('11', '1', '桌面端', 'system_desktop', '', '9');
INSERT INTO `permission` VALUES ('12', '11', '路由管理', 'system_desktop_route', 'desktop/system.desktop.route.Index/init\ndesktop/system.desktop.route.Index/getRoutes', '5');
INSERT INTO `permission` VALUES ('13', '11', '菜单管理', 'system_desktop_menu', 'desktop/system.desktop.menu.Index/init\ndesktop/system.desktop.menu.Index/getTreeMenu', '1');
INSERT INTO `permission` VALUES ('14', '1', '权限管理', 'system_permission', 'desktop/system.permission.Index/init\ndesktop/system.permission.Index/getTreePermission', '8');
INSERT INTO `permission` VALUES ('17', '1', '字典管理', 'system_dictionary', 'desktop/system.dictionary.Index/init\ndesktop/system.dictionary.Index/getPaginate', '13');
INSERT INTO `permission` VALUES ('18', '1', '登录日志', 'system_login_log', 'desktop/system.login_log.Index/getPaginate', '15');
INSERT INTO `permission` VALUES ('19', '1', '操作日志', 'system_operation_log', 'desktop/system.operation_log.Index/getPaginate\ndesktop/system.operation_log.Detail/init\ndesktop/system.operation_log.TimeRangeDelete/save', '17');
INSERT INTO `permission` VALUES ('20', '9', '添加', 'system_department_add', 'desktop/system.department.Add/init\ndesktop/system.department.Add/save', '1');
INSERT INTO `permission` VALUES ('21', '9', '修改', 'system_department_edit', 'desktop/system.department.Edit/init\ndesktop/system.department.Edit/save', '3');
INSERT INTO `permission` VALUES ('22', '9', '删除', 'system_department_delete', 'desktop/system.department.Index/delete', '9');
INSERT INTO `permission` VALUES ('23', '12', '添加', 'system_desktop_route_add', 'desktop/system.desktop.route.Add/save', '1');
INSERT INTO `permission` VALUES ('24', '12', '修改', 'system_desktop_route_edit', 'desktop/system.desktop.route.Edit/init\ndesktop/system.desktop.route.Edit/save', '3');
INSERT INTO `permission` VALUES ('25', '12', '删除', 'system_desktop_route_delete', 'desktop/system.desktop.route.Index/delete', '9');
INSERT INTO `permission` VALUES ('26', '13', '添加', 'system_desktop_menu_add', 'desktop/system.desktop.menu.Add/save', '1');
INSERT INTO `permission` VALUES ('27', '13', '修改', 'system_desktop_menu_edit', 'desktop/system.desktop.menu.Edit/init\ndesktop/system.desktop.menu.Edit/save', '3');
INSERT INTO `permission` VALUES ('28', '13', '删除', 'system_desktop_menu_delete', 'desktop/system.desktop.menu.Index/delete', '9');
INSERT INTO `permission` VALUES ('29', '14', '添加', 'system_permission_add', 'desktop/system.permission.Add/save', '1');
INSERT INTO `permission` VALUES ('30', '14', '修改', 'system_permission_edit', 'desktop/system.permission.Edit/init\ndesktop/system.permission.Edit/save', '3');
INSERT INTO `permission` VALUES ('31', '14', '删除', 'system_permission_delete', 'desktop/system.permission.Index/delete', '9');
INSERT INTO `permission` VALUES ('35', '17', '添加', 'system_dictionary_add', 'desktop/system.dictionary.Add/init\ndesktop/system.dictionary.Add/save', '1');
INSERT INTO `permission` VALUES ('36', '17', '修改', 'system_dictionary_edit', 'desktop/system.dictionary.Edit/init\ndesktop/system.dictionary.Edit/save', '3');
INSERT INTO `permission` VALUES ('37', '17', '删除', 'system_dictionary_delete', 'desktop/system.dictionary.Index/delete', '9');
INSERT INTO `permission` VALUES ('38', '0', '统计分析', 'statistic', '', '801');
INSERT INTO `permission` VALUES ('40', '38', '订单趋势统计', 'statistic_order_trend', 'desktop/statistic.OrderTrend/init\ndesktop/statistic.OrderTrend/exp', '1');
INSERT INTO `permission` VALUES ('41', '0', '系统首页', 'index', '', '1');
INSERT INTO `permission` VALUES ('42', '10', '添加', 'system_role_add', 'desktop/system.role.Add/init\ndesktop/system.role.Add/save', '1');
INSERT INTO `permission` VALUES ('43', '10', '修改', 'system_role_edit', 'desktop/system.role.Edit/init\ndesktop/system.role.Edit/save', '3');
INSERT INTO `permission` VALUES ('44', '10', '删除', 'system_role_delete', 'desktop/system.role.Index/delete', '9');
INSERT INTO `permission` VALUES ('45', '1', '数据权限', 'system_data_scope', 'desktop/system.data_scope.Index/getPaginate\ndesktop/system.data_scope.Index/delete\ndesktop/system.data_scope.Add/save\ndesktop/system.data_scope.Edit/init\ndesktop/system.data_scope.Edit/save\ndesktop/system.data_scope.policy.Index/getPolicies\ndesktop/system.data_scope.policy.Index/delete\ndesktop/system.data_scope.policy.Add/save\ndesktop/system.data_scope.policy.Edit/init\ndesktop/system.data_scope.policy.Edit/save\ndesktop/system.data_scope.policy.TreeDepartmentSelect/getTreeDepartment', '12');
INSERT INTO `permission` VALUES ('46', '1', '会话管理', 'session', 'desktop/system.session.Index/getPaginate', '14');
INSERT INTO `permission` VALUES ('47', '10', '修改数据权限', 'system_role_data_scope_edit', 'desktop/system.role.DataScopeEdit/init\ndesktop/system.role.DataScopeEdit/save', '5');
INSERT INTO `permission` VALUES ('48', '0', '流式请求', 'stream_fetch', 'desktop/stream_fetch.Index/fetch', '803');
INSERT INTO `permission` VALUES ('51', '2', '踢移动端下线', 'system_user_mobile_offline', 'desktop/system.user.Index/mobileOffline', '13');
INSERT INTO `permission` VALUES ('52', '2', '踢API端下线', 'system_user_api_offline', 'desktop/system.user.Index/apiOffline', '15');
INSERT INTO `permission` VALUES ('53', '46', '添加会话', 'session_add', 'desktop/system.session.Add/save', '1');
INSERT INTO `permission` VALUES ('55', '46', '会话续期', 'session_renew', 'desktop/system.session.Renew/init\ndesktop/system.session.Renew/save', '3');
INSERT INTO `permission` VALUES ('56', '46', '删除会话', 'session_delete', 'desktop/system.session.Index/delete\ndesktop/system.session.Index/deleteExpired', '5');

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
-- Table structure for role_data_scope_policy
-- ----------------------------
DROP TABLE IF EXISTS `role_data_scope_policy`;
CREATE TABLE `role_data_scope_policy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `data_scope_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数据权限ID',
  `policy_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '规则ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COMMENT='角色数据权限和数据权限规则关系';

-- ----------------------------
-- Records of role_data_scope_policy
-- ----------------------------
INSERT INTO `role_data_scope_policy` VALUES ('18', '4', '1', '5');
INSERT INTO `role_data_scope_policy` VALUES ('19', '4', '2', '10');
INSERT INTO `role_data_scope_policy` VALUES ('22', '3', '1', '3');
INSERT INTO `role_data_scope_policy` VALUES ('23', '3', '2', '9');

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
) ENGINE=InnoDB AUTO_INCREMENT=642 DEFAULT CHARSET=utf8 COMMENT='角色桌面端菜单关系';

-- ----------------------------
-- Records of role_desktop_menu
-- ----------------------------
INSERT INTO `role_desktop_menu` VALUES ('619', '3', '22');
INSERT INTO `role_desktop_menu` VALUES ('620', '3', '21');
INSERT INTO `role_desktop_menu` VALUES ('621', '3', '20');
INSERT INTO `role_desktop_menu` VALUES ('622', '3', '19');
INSERT INTO `role_desktop_menu` VALUES ('623', '3', '17');
INSERT INTO `role_desktop_menu` VALUES ('624', '3', '16');
INSERT INTO `role_desktop_menu` VALUES ('625', '3', '15');
INSERT INTO `role_desktop_menu` VALUES ('626', '3', '14');
INSERT INTO `role_desktop_menu` VALUES ('627', '3', '13');
INSERT INTO `role_desktop_menu` VALUES ('628', '3', '12');
INSERT INTO `role_desktop_menu` VALUES ('629', '3', '11');
INSERT INTO `role_desktop_menu` VALUES ('630', '3', '8');
INSERT INTO `role_desktop_menu` VALUES ('632', '3', '7');
INSERT INTO `role_desktop_menu` VALUES ('633', '3', '6');
INSERT INTO `role_desktop_menu` VALUES ('634', '3', '5');
INSERT INTO `role_desktop_menu` VALUES ('635', '3', '4');
INSERT INTO `role_desktop_menu` VALUES ('636', '3', '3');
INSERT INTO `role_desktop_menu` VALUES ('637', '3', '2');
INSERT INTO `role_desktop_menu` VALUES ('638', '3', '1');
INSERT INTO `role_desktop_menu` VALUES ('639', '4', '17');
INSERT INTO `role_desktop_menu` VALUES ('640', '4', '16');
INSERT INTO `role_desktop_menu` VALUES ('641', '4', '15');

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
) ENGINE=InnoDB AUTO_INCREMENT=392 DEFAULT CHARSET=utf8 COMMENT='角色桌面端路由关系';

-- ----------------------------
-- Records of role_desktop_route
-- ----------------------------
INSERT INTO `role_desktop_route` VALUES ('374', '3', '18');
INSERT INTO `role_desktop_route` VALUES ('375', '3', '17');
INSERT INTO `role_desktop_route` VALUES ('376', '3', '16');
INSERT INTO `role_desktop_route` VALUES ('377', '3', '7');
INSERT INTO `role_desktop_route` VALUES ('378', '3', '13');
INSERT INTO `role_desktop_route` VALUES ('379', '3', '12');
INSERT INTO `role_desktop_route` VALUES ('380', '3', '11');
INSERT INTO `role_desktop_route` VALUES ('381', '3', '10');
INSERT INTO `role_desktop_route` VALUES ('382', '3', '9');
INSERT INTO `role_desktop_route` VALUES ('383', '3', '8');
INSERT INTO `role_desktop_route` VALUES ('384', '3', '6');
INSERT INTO `role_desktop_route` VALUES ('385', '3', '5');
INSERT INTO `role_desktop_route` VALUES ('386', '3', '4');
INSERT INTO `role_desktop_route` VALUES ('387', '3', '3');
INSERT INTO `role_desktop_route` VALUES ('388', '3', '2');
INSERT INTO `role_desktop_route` VALUES ('389', '3', '1');
INSERT INTO `role_desktop_route` VALUES ('390', '4', '13');
INSERT INTO `role_desktop_route` VALUES ('391', '4', '12');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  `permission_id` int(10) unsigned NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_permission` (`role_id`,`permission_id`),
  KEY `permission_id` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COMMENT='角色权限关系';

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('43', '3', '1');
INSERT INTO `role_permission` VALUES ('42', '3', '2');
INSERT INTO `role_permission` VALUES ('41', '3', '3');
INSERT INTO `role_permission` VALUES ('40', '3', '4');
INSERT INTO `role_permission` VALUES ('39', '3', '5');
INSERT INTO `role_permission` VALUES ('38', '3', '6');
INSERT INTO `role_permission` VALUES ('37', '3', '7');
INSERT INTO `role_permission` VALUES ('36', '3', '8');
INSERT INTO `role_permission` VALUES ('35', '3', '9');
INSERT INTO `role_permission` VALUES ('34', '3', '10');
INSERT INTO `role_permission` VALUES ('33', '3', '11');
INSERT INTO `role_permission` VALUES ('32', '3', '12');
INSERT INTO `role_permission` VALUES ('31', '3', '13');
INSERT INTO `role_permission` VALUES ('29', '3', '14');
INSERT INTO `role_permission` VALUES ('28', '3', '17');
INSERT INTO `role_permission` VALUES ('27', '3', '18');
INSERT INTO `role_permission` VALUES ('26', '3', '19');
INSERT INTO `role_permission` VALUES ('25', '3', '20');
INSERT INTO `role_permission` VALUES ('24', '3', '21');
INSERT INTO `role_permission` VALUES ('23', '3', '22');
INSERT INTO `role_permission` VALUES ('22', '3', '23');
INSERT INTO `role_permission` VALUES ('21', '3', '24');
INSERT INTO `role_permission` VALUES ('20', '3', '25');
INSERT INTO `role_permission` VALUES ('19', '3', '26');
INSERT INTO `role_permission` VALUES ('18', '3', '27');
INSERT INTO `role_permission` VALUES ('17', '3', '28');
INSERT INTO `role_permission` VALUES ('16', '3', '29');
INSERT INTO `role_permission` VALUES ('15', '3', '30');
INSERT INTO `role_permission` VALUES ('14', '3', '31');
INSERT INTO `role_permission` VALUES ('13', '3', '35');
INSERT INTO `role_permission` VALUES ('12', '3', '36');
INSERT INTO `role_permission` VALUES ('11', '3', '37');
INSERT INTO `role_permission` VALUES ('10', '3', '38');
INSERT INTO `role_permission` VALUES ('9', '3', '40');
INSERT INTO `role_permission` VALUES ('8', '3', '41');
INSERT INTO `role_permission` VALUES ('7', '3', '42');
INSERT INTO `role_permission` VALUES ('6', '3', '43');
INSERT INTO `role_permission` VALUES ('5', '3', '44');
INSERT INTO `role_permission` VALUES ('4', '3', '45');
INSERT INTO `role_permission` VALUES ('3', '3', '46');
INSERT INTO `role_permission` VALUES ('2', '3', '47');
INSERT INTO `role_permission` VALUES ('1', '3', '48');
INSERT INTO `role_permission` VALUES ('51', '3', '51');
INSERT INTO `role_permission` VALUES ('52', '3', '52');
INSERT INTO `role_permission` VALUES ('53', '3', '53');
INSERT INTO `role_permission` VALUES ('55', '3', '55');
INSERT INTO `role_permission` VALUES ('56', '3', '56');
INSERT INTO `role_permission` VALUES ('57', '3', '57');
INSERT INTO `role_permission` VALUES ('59', '3', '59');
INSERT INTO `role_permission` VALUES ('46', '4', '38');
INSERT INTO `role_permission` VALUES ('45', '4', '40');
INSERT INTO `role_permission` VALUES ('44', '4', '41');

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
-- Table structure for session
-- ----------------------------
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '会话ID',
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '名称',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `terminal` tinyint(3) unsigned NOT NULL COMMENT '终端：0桌面端，1移动端，2API端',
  `token` varchar(512) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT '令牌',
  `expire_time` int(10) unsigned NOT NULL COMMENT '到期时间',
  `add_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `terminal_token` (`terminal`,`token`),
  KEY `user_id_terminal` (`user_id`,`terminal`),
  KEY `expire_time` (`expire_time`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='会话';

-- ----------------------------
-- Records of session
-- ----------------------------
INSERT INTO `session` VALUES ('5', '桌面端登录', '1', '0', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzkzNjc3MjgxfQ.mb43J2oB6kfHACYPr4gfFDBDtlvYcsyBLKQsEHjLu8c', '1793679082', '1793677281', '');
INSERT INTO `session` VALUES ('6', '桌面端登录', '1', '0', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzkzNjgwMzQwfQ.0TG0a-qqkhQOJ2uVUAN220AB5OFIsLzbRSTI5o7L_Qg', '1793682142', '1793680340', '');
INSERT INTO `session` VALUES ('8', '桌面端登录', '1', '0', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ0aW1lIjoxNzkzNjk2NTQwfQ.2xBI5CxfASJnWSHfYqZaTUxUEGjk2LdHWETBqXkLDWA', '1793699368', '1793696540', '');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '部门id',
  `account` varchar(63) NOT NULL DEFAULT '' COMMENT '账号',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '密码',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '姓名',
  `phone` varchar(63) NOT NULL DEFAULT '' COMMENT '手机号码',
  `avatar` varchar(127) NOT NULL DEFAULT '' COMMENT '头像',
  `big_avatar` varchar(127) NOT NULL DEFAULT '' COMMENT '大头像',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `last_login_ip` varchar(31) NOT NULL DEFAULT '' COMMENT '登录ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`),
  KEY `department_id` (`department_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='管理用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1', 'admin', '$2y$10$Eu3xsqx0L6N1sa265OIxi.EZ3Lfj3bRrm4CoZrd964BOZuGLzbaw2', '1', '张三', '15122222222', 'avatar/2026/11/03/3802aca9dbbcdea2999d0c9a1bd0f122.png', 'big_avatar/2026/11/03/2e95271424930fd2067fba2faa70d9c0.png', '1684989244', '1716183018', '1793696540', '127.0.0.1');
INSERT INTO `user` VALUES ('2', '1', 'user', '$2y$10$UgRQ5ZbLVVqALwcUTvboGeSMn8OCIG7B9DCMBmm.Rlj0rbfrinR1K', '1', '李四', '15111111111', '', '', '1684992552', '1703148627', '0', '');
INSERT INTO `user` VALUES ('3', '1', 'test1', '$2y$10$KGf9vZaH9DB5XvMS82WUgeGDlSL3IlmeEi6AuVshFshmOqq6Cay6i', '1', 'test1', '15108273575', '', '', '0', '0', '0', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('69', '3', '4');
INSERT INTO `user_role` VALUES ('70', '3', '3');
INSERT INTO `user_role` VALUES ('72', '2', '4');
INSERT INTO `user_role` VALUES ('75', '1', '3');
