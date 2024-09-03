/*
 Navicat Premium Dump SQL

 Source Server         : 本机mysql
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : go_study

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 03/09/2024 21:01:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `user_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '100' COMMENT '用户类型：(100系统用户)',
  `nickname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户头像',
  `signed` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '个人签名',
  `dashboard` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '后台首页类型',
  `status` bigint NULL DEFAULT 1 COMMENT '状态 (1正常 2停用)',
  `login_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登陆IP',
  `backend_setting` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '后台设置数据',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `super` int NOT NULL DEFAULT 2 COMMENT '是否超级管理员 (1是 2否)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `idx_admin_users_deleted_at`(`deleted_at` ASC) USING BTREE,
  INDEX `idx_admin_users_user_name`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES (1, '2024-07-11 00:00:00.000', '2024-08-19 17:25:46.000', NULL, 'superAdmin', '$2y$12$zpo8rhu.QGhb5Ty7bFTfaOYy7FfecukttS1Qn6oA2XfZ9MKTMNXJe', '100', 'superAdmin', '13888888888', 'admin@qq.com', '', '行胜于言，质胜于华。', 'statistics', 1, '127.0.0.1', '{\"mode\":\"light\",\"tag\":true,\"menuCollapse\":false,\"menuWidth\":230,\"layout\":\"classic\",\"skin\":\"mine\",\"i18n\":false,\"language\":\"zh_CN\",\"animation\":\"ma-slide-down\",\"color\":\"#165dff\",\"ws\":false}', '', 1);
INSERT INTO `admin_users` VALUES (3, '2024-09-02 10:49:13.713', '2024-09-02 10:49:13.713', '2024-09-02 10:54:09.085', '3332232', '$2a$10$ec3PR7Wqc0O0uIEgxvlpB.MBHz4vAStXJ5sOyfTVgv3kQ/spJ5Lvm', '100', '', '', '', '', '', '', 1, '', '', '', 2);
INSERT INTO `admin_users` VALUES (4, '2024-09-02 17:16:47.131', '2024-09-02 17:16:47.131', '2024-09-02 17:16:49.784', '水电费水电费', '$2a$10$V4WSM7B1.M8cbNbgzokQxOnEVMvXxmwAmpF.jmI27onJn2NOLshQ.', '100', '', '', '', '', '', '', 1, '', '', '', 2);
INSERT INTO `admin_users` VALUES (5, '2024-09-03 09:10:49.273', '2024-09-03 09:10:49.273', NULL, 'admin', '$2a$10$iQ6n2rRNw05QNJ35kHeiuuhl7h1IxfDj7e3oOEbT9l3MsXkVllTGm', '100', '', '', '', '', '', '', 1, '', '', '', 2);
INSERT INTO `admin_users` VALUES (6, '2024-09-03 12:33:29.626', '2024-09-03 12:33:29.626', NULL, 'test', '$2a$10$5XVzMvqOt42IOlPHjeLGVuDdR5TOuYeqCpGtSp8tRBpdbJJov47XC', '100', '', '', '', '', '', '', 1, '', '', '', 2);

-- ----------------------------
-- Table structure for casbin_rule
-- ----------------------------
DROP TABLE IF EXISTS `casbin_rule`;
CREATE TABLE `casbin_rule`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ptype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `v0` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `v1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `v2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `v3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `v4` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `v5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_casbin_rule`(`ptype` ASC, `v0` ASC, `v1` ASC, `v2` ASC, `v3` ASC, `v4` ASC, `v5` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of casbin_rule
-- ----------------------------
INSERT INTO `casbin_rule` VALUES (56, 'g', '5', 'admin', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (45, 'g', '6', 'test2', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (125, 'p', 'admin', '/admin/button/list', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (124, 'p', 'admin', '/admin/menu/list', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (126, 'p', 'admin', '/admin/notice', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (130, 'p', 'admin', '/admin/notice/change', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (127, 'p', 'admin', '/admin/notice/create', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (128, 'p', 'admin', '/admin/notice/delete', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (129, 'p', 'admin', '/admin/notice/export', '', '', '', '');

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由访问路径',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由name',
  `redirect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由重定向地址',
  `api` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '请求接口地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '视图文件路径',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单和面包屑对应的图标',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由标题(菜单名称)',
  `activeMenu` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '是否在菜单中隐藏,需要高亮的path',
  `isLink` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由外链时填写的访问地址',
  `isHide` smallint NOT NULL DEFAULT 2 COMMENT '是否在菜单中隐藏 (1是 2否)',
  `isFull` smallint NOT NULL DEFAULT 2 COMMENT '菜单是否全屏 (1是 2否)',
  `isAffix` smallint NOT NULL DEFAULT 1 COMMENT '菜单是否固定在标签页中 (1是 2否)',
  `isKeepAlive` smallint NOT NULL DEFAULT 2 COMMENT '当前路由是否缓存 (1是 2否)',
  `status` smallint NOT NULL DEFAULT 1 COMMENT '状态 (1正常 2停用)',
  `type` smallint NOT NULL DEFAULT 1 COMMENT '类型 (1菜单2按钮3外链4Iframe)',
  `sort` bigint NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_menus_deleted_at`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES (1, NULL, NULL, NULL, 0, '/home/index', 'home', '', '', '/home/index', 'HomeFilled', '首页', '', '', 2, 2, 1, 2, 1, 1, 99);
INSERT INTO `menus` VALUES (2, NULL, NULL, '2024-09-03 16:50:46.507', 0, '/dataScreen', 'dataScreen', '', '', '/dataScreen/index', 'Histogram', '数据大屏', '', '', 2, 1, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (3, NULL, NULL, NULL, 0, '/cms', 'cms', '/cms/notice', '', '', 'Lollipop', '内容管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (4, NULL, '2024-09-03 10:24:23.566', NULL, 3, '/cms/notice', 'notice', '', '/admin/notice', '/cms/notice/index', 'Menu', '公告管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (5, NULL, NULL, NULL, 4, '/cms/notice/detail/:id', 'noticeDetail', '', '', '/cms/notice/detail', 'Menu', '公告 详情', '/cms/notice', '', 1, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (6, NULL, '2024-09-03 10:24:58.883', NULL, 4, '', 'add', '', '/admin/notice/create', '/admin/notice/create', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (7, NULL, NULL, NULL, 4, '', 'update', '', '/admin/notice/update', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (8, NULL, NULL, NULL, 4, '', 'delete', '', '/admin/notice/delete', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (9, NULL, NULL, NULL, 4, '', 'export', '', '/admin/notice/export', '', '', '导出', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (10, NULL, NULL, NULL, 4, '', 'change', '', '/admin/notice/change', '', '', '修改状态', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (11, NULL, NULL, NULL, 4, '', 'view', '', '', '', '', '详情', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (12, NULL, '2024-09-02 15:59:39.192', NULL, 0, '/authority', 'authority', '/authority/menu', '', '', 'Lock', '权限管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (13, NULL, '2024-09-02 17:18:24.867', NULL, 12, '/authority/menu', 'menuAuthority', '', '', '/authority/menu/index', 'Menu', '菜单权限', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (30, '2024-09-02 10:35:03.467', '2024-09-02 10:35:03.467', NULL, 12, '/authority/admin_user', 'adminUser', '', '', '/authority/admin_user/index', 'Avatar', '管理员', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (31, '2024-09-02 16:10:02.983', '2024-09-02 16:10:02.983', NULL, 12, '/authority/role', 'role', '', '', '/authority/role/index', 'Stamp', '角色管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (34, '2024-09-03 10:28:22.793', '2024-09-03 10:29:17.200', NULL, 1, '', 'none', '', '/admin/menu/list', '', '', '用户菜单数据源', '', '', 1, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (35, '2024-09-03 10:28:53.299', '2024-09-03 10:29:24.284', NULL, 1, '', 'none', '', '/admin/button/list', '', '', '用户按钮数据源', '', '', 1, 2, 2, 2, 1, 1, 0);

-- ----------------------------
-- Table structure for notices
-- ----------------------------
DROP TABLE IF EXISTS `notices`;
CREATE TABLE `notices`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `type` smallint NOT NULL DEFAULT 0 COMMENT '公告类型（1通知 2公告）',
  `status` smallint NOT NULL DEFAULT 1 COMMENT '状态 (1启用 2禁用)',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '公告内容',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_notices_deleted_at`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notices
-- ----------------------------
INSERT INTO `notices` VALUES (1, '2024-08-30 09:55:59.657', '2024-08-30 10:15:43.317', '2024-09-02 10:53:13.157', '公告1111', 0, 1, '<p>公告1</p>', '');
INSERT INTO `notices` VALUES (2, '2024-08-30 10:11:10.500', '2024-09-02 16:43:15.248', '2024-09-02 17:09:33.554', '公告222', 0, 1, '<p>公告222公告222公告222公告222公告222</p>', '');
INSERT INTO `notices` VALUES (3, '2024-08-30 10:11:30.438', '2024-08-30 10:11:30.438', '2024-08-30 10:11:33.181', '哈哈哈哈', 0, 1, '<p>哈哈哈哈哈哈哈哈哈哈哈哈</p>', '');
INSERT INTO `notices` VALUES (4, '2024-08-30 10:12:53.230', '2024-08-30 10:12:53.230', '2024-08-30 10:12:56.246', '山东省', 0, 1, '<p>山东省山东省山东省</p>', '');
INSERT INTO `notices` VALUES (5, '2024-09-02 16:48:58.452', '2024-09-02 16:48:58.452', '2024-09-02 16:49:01.192', '颠三倒四多', 0, 1, '<p>是的是的</p>', '');
INSERT INTO `notices` VALUES (6, '2024-09-02 16:52:58.634', '2024-09-02 16:52:58.634', '2024-09-02 17:09:44.025', '大啊大大', 0, 1, '<p>颠三倒四多</p>', '');
INSERT INTO `notices` VALUES (7, '2024-09-02 17:09:41.514', '2024-09-02 17:09:41.514', '2024-09-02 17:10:50.537', '防守打法收到', 0, 1, '<p>防守打法收到防守打法收到防守打法收到防守打法收到防守打法收到</p>', '');
INSERT INTO `notices` VALUES (8, '2024-09-02 17:10:48.682', '2024-09-02 17:10:48.682', '2024-09-02 17:16:03.498', '4443434', 0, 1, '<p>都是</p>', '');
INSERT INTO `notices` VALUES (9, '2024-09-02 17:16:01.679', '2024-09-03 16:09:13.639', NULL, '是的是的', 0, 1, '<p>颠三倒四</p>', '');
INSERT INTO `notices` VALUES (10, '2024-09-02 17:17:11.721', '2024-09-02 17:17:11.721', '2024-09-02 17:17:13.786', '撒旦法水电费', 0, 1, '<p> &nbsp;发的范德萨发的</p>', '');
INSERT INTO `notices` VALUES (11, '2024-09-03 11:45:46.071', '2024-09-03 11:45:46.071', '2024-09-03 11:45:48.224', '是多少颠三倒四', 0, 1, '<p>但是时代大厦</p>', '');

-- ----------------------------
-- Table structure for role_menus
-- ----------------------------
DROP TABLE IF EXISTS `role_menus`;
CREATE TABLE `role_menus`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `role_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  `menu_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_menus_deleted_at`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 279 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menus
-- ----------------------------
INSERT INTO `role_menus` VALUES (1, '2024-09-03 15:08:36.527', '2024-09-03 15:08:36.527', '2024-09-03 15:25:37.773', 4, 1);
INSERT INTO `role_menus` VALUES (2, '2024-09-03 15:25:37.780', '2024-09-03 15:25:37.780', '2024-09-03 15:25:52.072', 4, 1);
INSERT INTO `role_menus` VALUES (3, '2024-09-03 15:25:52.074', '2024-09-03 15:25:52.074', '2024-09-03 15:27:12.192', 4, 1);
INSERT INTO `role_menus` VALUES (4, '2024-09-03 15:27:12.194', '2024-09-03 15:27:12.194', '2024-09-03 15:27:44.558', 4, 1);
INSERT INTO `role_menus` VALUES (5, '2024-09-03 15:27:44.576', '2024-09-03 15:27:44.576', '2024-09-03 15:28:01.480', 4, 1);
INSERT INTO `role_menus` VALUES (6, '2024-09-03 15:27:44.577', '2024-09-03 15:27:44.577', '2024-09-03 15:28:01.480', 4, 2);
INSERT INTO `role_menus` VALUES (7, '2024-09-03 15:28:01.482', '2024-09-03 15:28:01.482', '2024-09-03 15:29:06.654', 4, 1);
INSERT INTO `role_menus` VALUES (8, '2024-09-03 15:28:01.484', '2024-09-03 15:28:01.484', '2024-09-03 15:29:06.654', 4, 2);
INSERT INTO `role_menus` VALUES (9, '2024-09-03 15:28:01.485', '2024-09-03 15:28:01.485', '2024-09-03 15:29:06.654', 4, 3);
INSERT INTO `role_menus` VALUES (10, '2024-09-03 15:28:01.486', '2024-09-03 15:28:01.486', '2024-09-03 15:29:06.654', 4, 4);
INSERT INTO `role_menus` VALUES (11, '2024-09-03 15:28:01.488', '2024-09-03 15:28:01.488', '2024-09-03 15:29:06.654', 4, 5);
INSERT INTO `role_menus` VALUES (12, '2024-09-03 15:28:01.489', '2024-09-03 15:28:01.489', '2024-09-03 15:29:06.654', 4, 12);
INSERT INTO `role_menus` VALUES (13, '2024-09-03 15:28:01.490', '2024-09-03 15:28:01.490', '2024-09-03 15:29:06.654', 4, 13);
INSERT INTO `role_menus` VALUES (14, '2024-09-03 15:28:01.491', '2024-09-03 15:28:01.491', '2024-09-03 15:29:06.654', 4, 30);
INSERT INTO `role_menus` VALUES (15, '2024-09-03 15:28:01.492', '2024-09-03 15:28:01.492', '2024-09-03 15:29:06.654', 4, 31);
INSERT INTO `role_menus` VALUES (16, '2024-09-03 15:28:28.346', '2024-09-03 15:28:28.346', '2024-09-03 15:47:22.679', 1, 1);
INSERT INTO `role_menus` VALUES (17, '2024-09-03 15:28:28.348', '2024-09-03 15:28:28.348', '2024-09-03 15:47:22.679', 1, 34);
INSERT INTO `role_menus` VALUES (18, '2024-09-03 15:28:28.349', '2024-09-03 15:28:28.349', '2024-09-03 15:47:22.679', 1, 35);
INSERT INTO `role_menus` VALUES (19, '2024-09-03 15:28:28.350', '2024-09-03 15:28:28.350', '2024-09-03 15:47:22.679', 1, 2);
INSERT INTO `role_menus` VALUES (20, '2024-09-03 15:28:28.351', '2024-09-03 15:28:28.351', '2024-09-03 15:47:22.679', 1, 3);
INSERT INTO `role_menus` VALUES (21, '2024-09-03 15:28:28.352', '2024-09-03 15:28:28.352', '2024-09-03 15:47:22.679', 1, 4);
INSERT INTO `role_menus` VALUES (22, '2024-09-03 15:28:28.354', '2024-09-03 15:28:28.354', '2024-09-03 15:47:22.679', 1, 5);
INSERT INTO `role_menus` VALUES (23, '2024-09-03 15:28:28.355', '2024-09-03 15:28:28.355', '2024-09-03 15:47:22.679', 1, 12);
INSERT INTO `role_menus` VALUES (24, '2024-09-03 15:28:28.356', '2024-09-03 15:28:28.356', '2024-09-03 15:47:22.679', 1, 13);
INSERT INTO `role_menus` VALUES (25, '2024-09-03 15:28:28.357', '2024-09-03 15:28:28.357', '2024-09-03 15:47:22.679', 1, 30);
INSERT INTO `role_menus` VALUES (26, '2024-09-03 15:28:28.358', '2024-09-03 15:28:28.358', '2024-09-03 15:47:22.679', 1, 31);
INSERT INTO `role_menus` VALUES (27, '2024-09-03 15:29:06.656', '2024-09-03 15:29:06.656', '2024-09-03 15:39:10.875', 4, 1);
INSERT INTO `role_menus` VALUES (28, '2024-09-03 15:29:06.657', '2024-09-03 15:29:06.657', '2024-09-03 15:39:10.875', 4, 34);
INSERT INTO `role_menus` VALUES (29, '2024-09-03 15:29:06.658', '2024-09-03 15:29:06.658', '2024-09-03 15:39:10.875', 4, 35);
INSERT INTO `role_menus` VALUES (30, '2024-09-03 15:29:06.660', '2024-09-03 15:29:06.660', '2024-09-03 15:39:10.875', 4, 2);
INSERT INTO `role_menus` VALUES (31, '2024-09-03 15:29:06.661', '2024-09-03 15:29:06.661', '2024-09-03 15:39:10.875', 4, 3);
INSERT INTO `role_menus` VALUES (32, '2024-09-03 15:29:06.662', '2024-09-03 15:29:06.662', '2024-09-03 15:39:10.875', 4, 4);
INSERT INTO `role_menus` VALUES (33, '2024-09-03 15:29:06.663', '2024-09-03 15:29:06.663', '2024-09-03 15:39:10.875', 4, 5);
INSERT INTO `role_menus` VALUES (34, '2024-09-03 15:29:06.664', '2024-09-03 15:29:06.664', '2024-09-03 15:39:10.875', 4, 12);
INSERT INTO `role_menus` VALUES (35, '2024-09-03 15:29:06.666', '2024-09-03 15:29:06.666', '2024-09-03 15:39:10.875', 4, 13);
INSERT INTO `role_menus` VALUES (36, '2024-09-03 15:29:06.667', '2024-09-03 15:29:06.667', '2024-09-03 15:39:10.875', 4, 30);
INSERT INTO `role_menus` VALUES (37, '2024-09-03 15:29:06.668', '2024-09-03 15:29:06.668', '2024-09-03 15:39:10.875', 4, 31);
INSERT INTO `role_menus` VALUES (38, '2024-09-03 15:39:10.896', '2024-09-03 15:39:10.896', '2024-09-03 15:39:21.631', 4, 1);
INSERT INTO `role_menus` VALUES (39, '2024-09-03 15:39:10.899', '2024-09-03 15:39:10.899', '2024-09-03 15:39:21.631', 4, 34);
INSERT INTO `role_menus` VALUES (40, '2024-09-03 15:39:10.900', '2024-09-03 15:39:10.900', '2024-09-03 15:39:21.631', 4, 35);
INSERT INTO `role_menus` VALUES (41, '2024-09-03 15:39:10.901', '2024-09-03 15:39:10.901', '2024-09-03 15:39:21.631', 4, 2);
INSERT INTO `role_menus` VALUES (42, '2024-09-03 15:39:10.902', '2024-09-03 15:39:10.902', '2024-09-03 15:39:21.631', 4, 3);
INSERT INTO `role_menus` VALUES (43, '2024-09-03 15:39:10.903', '2024-09-03 15:39:10.903', '2024-09-03 15:39:21.631', 4, 4);
INSERT INTO `role_menus` VALUES (44, '2024-09-03 15:39:10.905', '2024-09-03 15:39:10.905', '2024-09-03 15:39:21.631', 4, 5);
INSERT INTO `role_menus` VALUES (45, '2024-09-03 15:39:10.906', '2024-09-03 15:39:10.906', '2024-09-03 15:39:21.631', 4, 6);
INSERT INTO `role_menus` VALUES (46, '2024-09-03 15:39:10.907', '2024-09-03 15:39:10.907', '2024-09-03 15:39:21.631', 4, 7);
INSERT INTO `role_menus` VALUES (47, '2024-09-03 15:39:10.908', '2024-09-03 15:39:10.908', '2024-09-03 15:39:21.631', 4, 8);
INSERT INTO `role_menus` VALUES (48, '2024-09-03 15:39:10.909', '2024-09-03 15:39:10.909', '2024-09-03 15:39:21.631', 4, 9);
INSERT INTO `role_menus` VALUES (49, '2024-09-03 15:39:10.911', '2024-09-03 15:39:10.911', '2024-09-03 15:39:21.631', 4, 10);
INSERT INTO `role_menus` VALUES (50, '2024-09-03 15:39:10.912', '2024-09-03 15:39:10.912', '2024-09-03 15:39:21.631', 4, 11);
INSERT INTO `role_menus` VALUES (51, '2024-09-03 15:39:10.913', '2024-09-03 15:39:10.913', '2024-09-03 15:39:21.631', 4, 12);
INSERT INTO `role_menus` VALUES (52, '2024-09-03 15:39:10.915', '2024-09-03 15:39:10.915', '2024-09-03 15:39:21.631', 4, 13);
INSERT INTO `role_menus` VALUES (53, '2024-09-03 15:39:10.916', '2024-09-03 15:39:10.916', '2024-09-03 15:39:21.631', 4, 30);
INSERT INTO `role_menus` VALUES (54, '2024-09-03 15:39:10.917', '2024-09-03 15:39:10.917', '2024-09-03 15:39:21.631', 4, 31);
INSERT INTO `role_menus` VALUES (55, '2024-09-03 15:39:21.633', '2024-09-03 15:39:21.633', NULL, 4, 1);
INSERT INTO `role_menus` VALUES (56, '2024-09-03 15:39:21.634', '2024-09-03 15:39:21.634', NULL, 4, 34);
INSERT INTO `role_menus` VALUES (57, '2024-09-03 15:39:21.635', '2024-09-03 15:39:21.635', NULL, 4, 35);
INSERT INTO `role_menus` VALUES (58, '2024-09-03 15:39:21.636', '2024-09-03 15:39:21.636', NULL, 4, 2);
INSERT INTO `role_menus` VALUES (59, '2024-09-03 15:39:21.637', '2024-09-03 15:39:21.637', NULL, 4, 3);
INSERT INTO `role_menus` VALUES (60, '2024-09-03 15:39:21.639', '2024-09-03 15:39:21.639', NULL, 4, 4);
INSERT INTO `role_menus` VALUES (61, '2024-09-03 15:39:21.640', '2024-09-03 15:39:21.640', NULL, 4, 5);
INSERT INTO `role_menus` VALUES (62, '2024-09-03 15:39:21.641', '2024-09-03 15:39:21.641', NULL, 4, 6);
INSERT INTO `role_menus` VALUES (63, '2024-09-03 15:39:21.642', '2024-09-03 15:39:21.642', NULL, 4, 7);
INSERT INTO `role_menus` VALUES (64, '2024-09-03 15:39:21.644', '2024-09-03 15:39:21.644', NULL, 4, 8);
INSERT INTO `role_menus` VALUES (65, '2024-09-03 15:39:21.645', '2024-09-03 15:39:21.645', NULL, 4, 9);
INSERT INTO `role_menus` VALUES (66, '2024-09-03 15:39:21.646', '2024-09-03 15:39:21.646', NULL, 4, 10);
INSERT INTO `role_menus` VALUES (67, '2024-09-03 15:39:21.647', '2024-09-03 15:39:21.647', NULL, 4, 11);
INSERT INTO `role_menus` VALUES (68, '2024-09-03 15:39:21.648', '2024-09-03 15:39:21.648', NULL, 4, 12);
INSERT INTO `role_menus` VALUES (69, '2024-09-03 15:39:21.649', '2024-09-03 15:39:21.649', NULL, 4, 13);
INSERT INTO `role_menus` VALUES (70, '2024-09-03 15:39:21.650', '2024-09-03 15:39:21.650', NULL, 4, 30);
INSERT INTO `role_menus` VALUES (71, '2024-09-03 15:39:21.652', '2024-09-03 15:39:21.652', NULL, 4, 31);
INSERT INTO `role_menus` VALUES (72, '2024-09-03 15:47:22.692', '2024-09-03 15:47:22.692', '2024-09-03 16:03:20.769', 1, 1);
INSERT INTO `role_menus` VALUES (73, '2024-09-03 15:47:22.694', '2024-09-03 15:47:22.694', '2024-09-03 16:03:20.769', 1, 34);
INSERT INTO `role_menus` VALUES (74, '2024-09-03 15:47:22.696', '2024-09-03 15:47:22.696', '2024-09-03 16:03:20.769', 1, 35);
INSERT INTO `role_menus` VALUES (75, '2024-09-03 15:47:22.697', '2024-09-03 15:47:22.697', '2024-09-03 16:03:20.769', 1, 2);
INSERT INTO `role_menus` VALUES (76, '2024-09-03 15:47:22.699', '2024-09-03 15:47:22.699', '2024-09-03 16:03:20.769', 1, 3);
INSERT INTO `role_menus` VALUES (77, '2024-09-03 15:47:22.700', '2024-09-03 15:47:22.700', '2024-09-03 16:03:20.769', 1, 4);
INSERT INTO `role_menus` VALUES (78, '2024-09-03 15:47:22.701', '2024-09-03 15:47:22.701', '2024-09-03 16:03:20.769', 1, 5);
INSERT INTO `role_menus` VALUES (79, '2024-09-03 15:47:22.702', '2024-09-03 15:47:22.702', '2024-09-03 16:03:20.769', 1, 6);
INSERT INTO `role_menus` VALUES (80, '2024-09-03 15:47:22.703', '2024-09-03 15:47:22.703', '2024-09-03 16:03:20.769', 1, 7);
INSERT INTO `role_menus` VALUES (81, '2024-09-03 15:47:22.704', '2024-09-03 15:47:22.704', '2024-09-03 16:03:20.769', 1, 12);
INSERT INTO `role_menus` VALUES (82, '2024-09-03 15:47:22.705', '2024-09-03 15:47:22.705', '2024-09-03 16:03:20.769', 1, 13);
INSERT INTO `role_menus` VALUES (83, '2024-09-03 15:47:22.707', '2024-09-03 15:47:22.707', '2024-09-03 16:03:20.769', 1, 30);
INSERT INTO `role_menus` VALUES (84, '2024-09-03 15:47:22.708', '2024-09-03 15:47:22.708', '2024-09-03 16:03:20.769', 1, 31);
INSERT INTO `role_menus` VALUES (85, '2024-09-03 16:03:20.782', '2024-09-03 16:03:20.782', '2024-09-03 16:04:47.726', 1, 1);
INSERT INTO `role_menus` VALUES (86, '2024-09-03 16:03:20.786', '2024-09-03 16:03:20.786', '2024-09-03 16:04:47.726', 1, 34);
INSERT INTO `role_menus` VALUES (87, '2024-09-03 16:03:20.789', '2024-09-03 16:03:20.789', '2024-09-03 16:04:47.726', 1, 35);
INSERT INTO `role_menus` VALUES (88, '2024-09-03 16:03:20.791', '2024-09-03 16:03:20.791', '2024-09-03 16:04:47.726', 1, 2);
INSERT INTO `role_menus` VALUES (89, '2024-09-03 16:03:20.792', '2024-09-03 16:03:20.792', '2024-09-03 16:04:47.726', 1, 3);
INSERT INTO `role_menus` VALUES (90, '2024-09-03 16:03:20.794', '2024-09-03 16:03:20.794', '2024-09-03 16:04:47.726', 1, 4);
INSERT INTO `role_menus` VALUES (91, '2024-09-03 16:03:20.796', '2024-09-03 16:03:20.796', '2024-09-03 16:04:47.726', 1, 5);
INSERT INTO `role_menus` VALUES (92, '2024-09-03 16:03:20.799', '2024-09-03 16:03:20.799', '2024-09-03 16:04:47.726', 1, 6);
INSERT INTO `role_menus` VALUES (93, '2024-09-03 16:03:20.801', '2024-09-03 16:03:20.801', '2024-09-03 16:04:47.726', 1, 7);
INSERT INTO `role_menus` VALUES (94, '2024-09-03 16:03:20.803', '2024-09-03 16:03:20.803', '2024-09-03 16:04:47.726', 1, 8);
INSERT INTO `role_menus` VALUES (95, '2024-09-03 16:03:20.806', '2024-09-03 16:03:20.806', '2024-09-03 16:04:47.726', 1, 9);
INSERT INTO `role_menus` VALUES (96, '2024-09-03 16:03:20.808', '2024-09-03 16:03:20.808', '2024-09-03 16:04:47.726', 1, 10);
INSERT INTO `role_menus` VALUES (97, '2024-09-03 16:03:20.810', '2024-09-03 16:03:20.810', '2024-09-03 16:04:47.726', 1, 11);
INSERT INTO `role_menus` VALUES (98, '2024-09-03 16:03:20.811', '2024-09-03 16:03:20.811', '2024-09-03 16:04:47.726', 1, 12);
INSERT INTO `role_menus` VALUES (99, '2024-09-03 16:03:20.813', '2024-09-03 16:03:20.813', '2024-09-03 16:04:47.726', 1, 13);
INSERT INTO `role_menus` VALUES (100, '2024-09-03 16:03:20.814', '2024-09-03 16:03:20.814', '2024-09-03 16:04:47.726', 1, 30);
INSERT INTO `role_menus` VALUES (101, '2024-09-03 16:03:20.815', '2024-09-03 16:03:20.815', '2024-09-03 16:04:47.726', 1, 31);
INSERT INTO `role_menus` VALUES (102, '2024-09-03 16:04:47.741', '2024-09-03 16:04:47.741', '2024-09-03 16:06:39.977', 1, 1);
INSERT INTO `role_menus` VALUES (103, '2024-09-03 16:04:47.743', '2024-09-03 16:04:47.743', '2024-09-03 16:06:39.977', 1, 34);
INSERT INTO `role_menus` VALUES (104, '2024-09-03 16:04:47.746', '2024-09-03 16:04:47.746', '2024-09-03 16:06:39.977', 1, 35);
INSERT INTO `role_menus` VALUES (105, '2024-09-03 16:04:47.748', '2024-09-03 16:04:47.748', '2024-09-03 16:06:39.977', 1, 2);
INSERT INTO `role_menus` VALUES (106, '2024-09-03 16:04:47.749', '2024-09-03 16:04:47.749', '2024-09-03 16:06:39.977', 1, 3);
INSERT INTO `role_menus` VALUES (107, '2024-09-03 16:04:47.751', '2024-09-03 16:04:47.751', '2024-09-03 16:06:39.977', 1, 4);
INSERT INTO `role_menus` VALUES (108, '2024-09-03 16:04:47.752', '2024-09-03 16:04:47.752', '2024-09-03 16:06:39.977', 1, 5);
INSERT INTO `role_menus` VALUES (109, '2024-09-03 16:04:47.755', '2024-09-03 16:04:47.755', '2024-09-03 16:06:39.977', 1, 6);
INSERT INTO `role_menus` VALUES (110, '2024-09-03 16:04:47.758', '2024-09-03 16:04:47.758', '2024-09-03 16:06:39.977', 1, 8);
INSERT INTO `role_menus` VALUES (111, '2024-09-03 16:04:47.760', '2024-09-03 16:04:47.760', '2024-09-03 16:06:39.977', 1, 9);
INSERT INTO `role_menus` VALUES (112, '2024-09-03 16:04:47.763', '2024-09-03 16:04:47.763', '2024-09-03 16:06:39.977', 1, 10);
INSERT INTO `role_menus` VALUES (113, '2024-09-03 16:04:47.764', '2024-09-03 16:04:47.764', '2024-09-03 16:06:39.977', 1, 11);
INSERT INTO `role_menus` VALUES (114, '2024-09-03 16:04:47.765', '2024-09-03 16:04:47.765', '2024-09-03 16:06:39.977', 1, 12);
INSERT INTO `role_menus` VALUES (115, '2024-09-03 16:04:47.766', '2024-09-03 16:04:47.766', '2024-09-03 16:06:39.977', 1, 13);
INSERT INTO `role_menus` VALUES (116, '2024-09-03 16:04:47.768', '2024-09-03 16:04:47.768', '2024-09-03 16:06:39.977', 1, 30);
INSERT INTO `role_menus` VALUES (117, '2024-09-03 16:04:47.769', '2024-09-03 16:04:47.769', '2024-09-03 16:06:39.977', 1, 31);
INSERT INTO `role_menus` VALUES (118, '2024-09-03 16:06:39.994', '2024-09-03 16:06:39.994', '2024-09-03 16:07:27.371', 1, 1);
INSERT INTO `role_menus` VALUES (119, '2024-09-03 16:06:39.997', '2024-09-03 16:06:39.997', '2024-09-03 16:07:27.371', 1, 34);
INSERT INTO `role_menus` VALUES (120, '2024-09-03 16:06:40.000', '2024-09-03 16:06:40.000', '2024-09-03 16:07:27.371', 1, 35);
INSERT INTO `role_menus` VALUES (121, '2024-09-03 16:06:40.002', '2024-09-03 16:06:40.002', '2024-09-03 16:07:27.371', 1, 2);
INSERT INTO `role_menus` VALUES (122, '2024-09-03 16:06:40.003', '2024-09-03 16:06:40.003', '2024-09-03 16:07:27.371', 1, 3);
INSERT INTO `role_menus` VALUES (123, '2024-09-03 16:06:40.006', '2024-09-03 16:06:40.006', '2024-09-03 16:07:27.371', 1, 4);
INSERT INTO `role_menus` VALUES (124, '2024-09-03 16:06:40.007', '2024-09-03 16:06:40.007', '2024-09-03 16:07:27.371', 1, 5);
INSERT INTO `role_menus` VALUES (125, '2024-09-03 16:06:40.009', '2024-09-03 16:06:40.009', '2024-09-03 16:07:27.371', 1, 6);
INSERT INTO `role_menus` VALUES (126, '2024-09-03 16:06:40.012', '2024-09-03 16:06:40.012', '2024-09-03 16:07:27.371', 1, 8);
INSERT INTO `role_menus` VALUES (127, '2024-09-03 16:06:40.015', '2024-09-03 16:06:40.015', '2024-09-03 16:07:27.371', 1, 9);
INSERT INTO `role_menus` VALUES (128, '2024-09-03 16:06:40.017', '2024-09-03 16:06:40.017', '2024-09-03 16:07:27.371', 1, 10);
INSERT INTO `role_menus` VALUES (129, '2024-09-03 16:06:40.019', '2024-09-03 16:06:40.019', '2024-09-03 16:07:27.371', 1, 11);
INSERT INTO `role_menus` VALUES (130, '2024-09-03 16:06:40.020', '2024-09-03 16:06:40.020', '2024-09-03 16:07:27.371', 1, 12);
INSERT INTO `role_menus` VALUES (131, '2024-09-03 16:06:40.021', '2024-09-03 16:06:40.021', '2024-09-03 16:07:27.371', 1, 13);
INSERT INTO `role_menus` VALUES (132, '2024-09-03 16:06:40.023', '2024-09-03 16:06:40.023', '2024-09-03 16:07:27.371', 1, 30);
INSERT INTO `role_menus` VALUES (133, '2024-09-03 16:06:40.024', '2024-09-03 16:06:40.024', '2024-09-03 16:07:27.371', 1, 31);
INSERT INTO `role_menus` VALUES (134, '2024-09-03 16:07:27.383', '2024-09-03 16:07:27.383', '2024-09-03 16:08:55.049', 1, 1);
INSERT INTO `role_menus` VALUES (135, '2024-09-03 16:07:27.386', '2024-09-03 16:07:27.386', '2024-09-03 16:08:55.049', 1, 34);
INSERT INTO `role_menus` VALUES (136, '2024-09-03 16:07:27.388', '2024-09-03 16:07:27.388', '2024-09-03 16:08:55.049', 1, 35);
INSERT INTO `role_menus` VALUES (137, '2024-09-03 16:07:27.390', '2024-09-03 16:07:27.390', '2024-09-03 16:08:55.049', 1, 2);
INSERT INTO `role_menus` VALUES (138, '2024-09-03 16:07:27.391', '2024-09-03 16:07:27.391', '2024-09-03 16:08:55.049', 1, 3);
INSERT INTO `role_menus` VALUES (139, '2024-09-03 16:07:27.393', '2024-09-03 16:07:27.393', '2024-09-03 16:08:55.049', 1, 4);
INSERT INTO `role_menus` VALUES (140, '2024-09-03 16:07:27.394', '2024-09-03 16:07:27.394', '2024-09-03 16:08:55.049', 1, 5);
INSERT INTO `role_menus` VALUES (141, '2024-09-03 16:07:27.396', '2024-09-03 16:07:27.396', '2024-09-03 16:08:55.049', 1, 6);
INSERT INTO `role_menus` VALUES (142, '2024-09-03 16:07:27.399', '2024-09-03 16:07:27.399', '2024-09-03 16:08:55.049', 1, 7);
INSERT INTO `role_menus` VALUES (143, '2024-09-03 16:07:27.402', '2024-09-03 16:07:27.402', '2024-09-03 16:08:55.049', 1, 8);
INSERT INTO `role_menus` VALUES (144, '2024-09-03 16:07:27.404', '2024-09-03 16:07:27.404', '2024-09-03 16:08:55.049', 1, 9);
INSERT INTO `role_menus` VALUES (145, '2024-09-03 16:07:27.406', '2024-09-03 16:07:27.406', '2024-09-03 16:08:55.049', 1, 10);
INSERT INTO `role_menus` VALUES (146, '2024-09-03 16:07:27.407', '2024-09-03 16:07:27.407', '2024-09-03 16:08:55.049', 1, 11);
INSERT INTO `role_menus` VALUES (147, '2024-09-03 16:07:27.408', '2024-09-03 16:07:27.408', '2024-09-03 16:08:55.049', 1, 12);
INSERT INTO `role_menus` VALUES (148, '2024-09-03 16:07:27.409', '2024-09-03 16:07:27.409', '2024-09-03 16:08:55.049', 1, 13);
INSERT INTO `role_menus` VALUES (149, '2024-09-03 16:07:27.411', '2024-09-03 16:07:27.411', '2024-09-03 16:08:55.049', 1, 30);
INSERT INTO `role_menus` VALUES (150, '2024-09-03 16:07:27.412', '2024-09-03 16:07:27.412', '2024-09-03 16:08:55.049', 1, 31);
INSERT INTO `role_menus` VALUES (151, '2024-09-03 16:08:55.063', '2024-09-03 16:08:55.063', '2024-09-03 16:09:10.714', 1, 1);
INSERT INTO `role_menus` VALUES (152, '2024-09-03 16:08:55.065', '2024-09-03 16:08:55.065', '2024-09-03 16:09:10.714', 1, 34);
INSERT INTO `role_menus` VALUES (153, '2024-09-03 16:08:55.068', '2024-09-03 16:08:55.068', '2024-09-03 16:09:10.714', 1, 35);
INSERT INTO `role_menus` VALUES (154, '2024-09-03 16:08:55.070', '2024-09-03 16:08:55.070', '2024-09-03 16:09:10.714', 1, 2);
INSERT INTO `role_menus` VALUES (155, '2024-09-03 16:08:55.071', '2024-09-03 16:08:55.071', '2024-09-03 16:09:10.714', 1, 3);
INSERT INTO `role_menus` VALUES (156, '2024-09-03 16:08:55.073', '2024-09-03 16:08:55.073', '2024-09-03 16:09:10.714', 1, 4);
INSERT INTO `role_menus` VALUES (157, '2024-09-03 16:08:55.074', '2024-09-03 16:08:55.074', '2024-09-03 16:09:10.714', 1, 5);
INSERT INTO `role_menus` VALUES (158, '2024-09-03 16:08:55.077', '2024-09-03 16:08:55.077', '2024-09-03 16:09:10.714', 1, 6);
INSERT INTO `role_menus` VALUES (159, '2024-09-03 16:08:55.079', '2024-09-03 16:08:55.079', '2024-09-03 16:09:10.714', 1, 8);
INSERT INTO `role_menus` VALUES (160, '2024-09-03 16:08:55.081', '2024-09-03 16:08:55.081', '2024-09-03 16:09:10.714', 1, 9);
INSERT INTO `role_menus` VALUES (161, '2024-09-03 16:08:55.083', '2024-09-03 16:08:55.083', '2024-09-03 16:09:10.714', 1, 10);
INSERT INTO `role_menus` VALUES (162, '2024-09-03 16:08:55.084', '2024-09-03 16:08:55.084', '2024-09-03 16:09:10.714', 1, 11);
INSERT INTO `role_menus` VALUES (163, '2024-09-03 16:08:55.086', '2024-09-03 16:08:55.086', '2024-09-03 16:09:10.714', 1, 12);
INSERT INTO `role_menus` VALUES (164, '2024-09-03 16:08:55.087', '2024-09-03 16:08:55.087', '2024-09-03 16:09:10.714', 1, 13);
INSERT INTO `role_menus` VALUES (165, '2024-09-03 16:08:55.088', '2024-09-03 16:08:55.088', '2024-09-03 16:09:10.714', 1, 30);
INSERT INTO `role_menus` VALUES (166, '2024-09-03 16:08:55.089', '2024-09-03 16:08:55.089', '2024-09-03 16:09:10.714', 1, 31);
INSERT INTO `role_menus` VALUES (167, '2024-09-03 16:09:10.726', '2024-09-03 16:09:10.726', '2024-09-03 16:15:20.728', 1, 1);
INSERT INTO `role_menus` VALUES (168, '2024-09-03 16:09:10.728', '2024-09-03 16:09:10.728', '2024-09-03 16:15:20.728', 1, 34);
INSERT INTO `role_menus` VALUES (169, '2024-09-03 16:09:10.731', '2024-09-03 16:09:10.731', '2024-09-03 16:15:20.728', 1, 35);
INSERT INTO `role_menus` VALUES (170, '2024-09-03 16:09:10.733', '2024-09-03 16:09:10.733', '2024-09-03 16:15:20.728', 1, 2);
INSERT INTO `role_menus` VALUES (171, '2024-09-03 16:09:10.734', '2024-09-03 16:09:10.734', '2024-09-03 16:15:20.728', 1, 3);
INSERT INTO `role_menus` VALUES (172, '2024-09-03 16:09:10.736', '2024-09-03 16:09:10.736', '2024-09-03 16:15:20.728', 1, 4);
INSERT INTO `role_menus` VALUES (173, '2024-09-03 16:09:10.738', '2024-09-03 16:09:10.738', '2024-09-03 16:15:20.728', 1, 5);
INSERT INTO `role_menus` VALUES (174, '2024-09-03 16:09:10.740', '2024-09-03 16:09:10.740', '2024-09-03 16:15:20.728', 1, 6);
INSERT INTO `role_menus` VALUES (175, '2024-09-03 16:09:10.742', '2024-09-03 16:09:10.742', '2024-09-03 16:15:20.728', 1, 7);
INSERT INTO `role_menus` VALUES (176, '2024-09-03 16:09:10.744', '2024-09-03 16:09:10.744', '2024-09-03 16:15:20.728', 1, 8);
INSERT INTO `role_menus` VALUES (177, '2024-09-03 16:09:10.746', '2024-09-03 16:09:10.746', '2024-09-03 16:15:20.728', 1, 9);
INSERT INTO `role_menus` VALUES (178, '2024-09-03 16:09:10.748', '2024-09-03 16:09:10.748', '2024-09-03 16:15:20.728', 1, 10);
INSERT INTO `role_menus` VALUES (179, '2024-09-03 16:09:10.749', '2024-09-03 16:09:10.749', '2024-09-03 16:15:20.728', 1, 11);
INSERT INTO `role_menus` VALUES (180, '2024-09-03 16:09:10.750', '2024-09-03 16:09:10.750', '2024-09-03 16:15:20.728', 1, 12);
INSERT INTO `role_menus` VALUES (181, '2024-09-03 16:09:10.751', '2024-09-03 16:09:10.751', '2024-09-03 16:15:20.728', 1, 13);
INSERT INTO `role_menus` VALUES (182, '2024-09-03 16:09:10.753', '2024-09-03 16:09:10.753', '2024-09-03 16:15:20.728', 1, 30);
INSERT INTO `role_menus` VALUES (183, '2024-09-03 16:09:10.754', '2024-09-03 16:09:10.754', '2024-09-03 16:15:20.728', 1, 31);
INSERT INTO `role_menus` VALUES (184, '2024-09-03 16:15:20.747', '2024-09-03 16:15:20.747', '2024-09-03 16:32:20.058', 1, 1);
INSERT INTO `role_menus` VALUES (185, '2024-09-03 16:15:20.751', '2024-09-03 16:15:20.751', '2024-09-03 16:32:20.058', 1, 34);
INSERT INTO `role_menus` VALUES (186, '2024-09-03 16:15:20.753', '2024-09-03 16:15:20.753', '2024-09-03 16:32:20.058', 1, 35);
INSERT INTO `role_menus` VALUES (187, '2024-09-03 16:15:20.754', '2024-09-03 16:15:20.754', '2024-09-03 16:32:20.058', 1, 2);
INSERT INTO `role_menus` VALUES (188, '2024-09-03 16:15:20.756', '2024-09-03 16:15:20.756', '2024-09-03 16:32:20.058', 1, 12);
INSERT INTO `role_menus` VALUES (189, '2024-09-03 16:15:20.757', '2024-09-03 16:15:20.757', '2024-09-03 16:32:20.058', 1, 13);
INSERT INTO `role_menus` VALUES (190, '2024-09-03 16:15:20.758', '2024-09-03 16:15:20.758', '2024-09-03 16:32:20.058', 1, 30);
INSERT INTO `role_menus` VALUES (191, '2024-09-03 16:15:20.761', '2024-09-03 16:15:20.761', '2024-09-03 16:32:20.058', 1, 31);
INSERT INTO `role_menus` VALUES (192, '2024-09-03 16:32:20.075', '2024-09-03 16:32:20.075', '2024-09-03 16:48:17.137', 1, 1);
INSERT INTO `role_menus` VALUES (193, '2024-09-03 16:32:20.078', '2024-09-03 16:32:20.078', '2024-09-03 16:48:17.137', 1, 34);
INSERT INTO `role_menus` VALUES (194, '2024-09-03 16:32:20.081', '2024-09-03 16:32:20.081', '2024-09-03 16:48:17.137', 1, 35);
INSERT INTO `role_menus` VALUES (195, '2024-09-03 16:32:20.083', '2024-09-03 16:32:20.083', '2024-09-03 16:48:17.137', 1, 2);
INSERT INTO `role_menus` VALUES (196, '2024-09-03 16:32:20.084', '2024-09-03 16:32:20.084', '2024-09-03 16:48:17.137', 1, 3);
INSERT INTO `role_menus` VALUES (197, '2024-09-03 16:32:20.087', '2024-09-03 16:32:20.087', '2024-09-03 16:48:17.137', 1, 4);
INSERT INTO `role_menus` VALUES (198, '2024-09-03 16:32:20.088', '2024-09-03 16:32:20.088', '2024-09-03 16:48:17.137', 1, 5);
INSERT INTO `role_menus` VALUES (199, '2024-09-03 16:32:20.091', '2024-09-03 16:32:20.091', '2024-09-03 16:48:17.137', 1, 7);
INSERT INTO `role_menus` VALUES (200, '2024-09-03 16:32:20.093', '2024-09-03 16:32:20.093', '2024-09-03 16:48:17.137', 1, 8);
INSERT INTO `role_menus` VALUES (201, '2024-09-03 16:32:20.095', '2024-09-03 16:32:20.095', '2024-09-03 16:48:17.137', 1, 9);
INSERT INTO `role_menus` VALUES (202, '2024-09-03 16:32:20.097', '2024-09-03 16:32:20.097', '2024-09-03 16:48:17.137', 1, 10);
INSERT INTO `role_menus` VALUES (203, '2024-09-03 16:32:20.098', '2024-09-03 16:32:20.098', '2024-09-03 16:48:17.137', 1, 11);
INSERT INTO `role_menus` VALUES (204, '2024-09-03 16:32:20.099', '2024-09-03 16:32:20.099', '2024-09-03 16:48:17.137', 1, 12);
INSERT INTO `role_menus` VALUES (205, '2024-09-03 16:32:20.101', '2024-09-03 16:32:20.101', '2024-09-03 16:48:17.137', 1, 13);
INSERT INTO `role_menus` VALUES (206, '2024-09-03 16:32:20.102', '2024-09-03 16:32:20.102', '2024-09-03 16:48:17.137', 1, 30);
INSERT INTO `role_menus` VALUES (207, '2024-09-03 16:32:20.103', '2024-09-03 16:32:20.103', '2024-09-03 16:48:17.137', 1, 31);
INSERT INTO `role_menus` VALUES (208, '2024-09-03 16:48:17.150', '2024-09-03 16:48:17.150', '2024-09-03 16:51:15.512', 1, 1);
INSERT INTO `role_menus` VALUES (209, '2024-09-03 16:48:17.153', '2024-09-03 16:48:17.153', '2024-09-03 16:51:15.512', 1, 34);
INSERT INTO `role_menus` VALUES (210, '2024-09-03 16:48:17.156', '2024-09-03 16:48:17.156', '2024-09-03 16:51:15.512', 1, 35);
INSERT INTO `role_menus` VALUES (211, '2024-09-03 16:48:17.157', '2024-09-03 16:48:17.157', '2024-09-03 16:51:15.512', 1, 2);
INSERT INTO `role_menus` VALUES (212, '2024-09-03 16:48:17.158', '2024-09-03 16:48:17.158', '2024-09-03 16:51:15.512', 1, 3);
INSERT INTO `role_menus` VALUES (213, '2024-09-03 16:48:17.162', '2024-09-03 16:48:17.162', '2024-09-03 16:51:15.512', 1, 4);
INSERT INTO `role_menus` VALUES (214, '2024-09-03 16:48:17.163', '2024-09-03 16:48:17.163', '2024-09-03 16:51:15.512', 1, 5);
INSERT INTO `role_menus` VALUES (215, '2024-09-03 16:48:17.166', '2024-09-03 16:48:17.166', '2024-09-03 16:51:15.512', 1, 7);
INSERT INTO `role_menus` VALUES (216, '2024-09-03 16:48:17.170', '2024-09-03 16:48:17.170', '2024-09-03 16:51:15.512', 1, 8);
INSERT INTO `role_menus` VALUES (217, '2024-09-03 16:48:17.173', '2024-09-03 16:48:17.173', '2024-09-03 16:51:15.512', 1, 9);
INSERT INTO `role_menus` VALUES (218, '2024-09-03 16:48:17.176', '2024-09-03 16:48:17.176', '2024-09-03 16:51:15.512', 1, 10);
INSERT INTO `role_menus` VALUES (219, '2024-09-03 16:48:17.178', '2024-09-03 16:48:17.178', '2024-09-03 16:51:15.512', 1, 11);
INSERT INTO `role_menus` VALUES (220, '2024-09-03 16:48:17.180', '2024-09-03 16:48:17.180', '2024-09-03 16:51:15.512', 1, 12);
INSERT INTO `role_menus` VALUES (221, '2024-09-03 16:48:17.181', '2024-09-03 16:48:17.181', '2024-09-03 16:51:15.512', 1, 13);
INSERT INTO `role_menus` VALUES (222, '2024-09-03 16:48:17.182', '2024-09-03 16:48:17.182', '2024-09-03 16:51:15.512', 1, 30);
INSERT INTO `role_menus` VALUES (223, '2024-09-03 16:48:17.183', '2024-09-03 16:48:17.183', '2024-09-03 16:51:15.512', 1, 31);
INSERT INTO `role_menus` VALUES (224, '2024-09-03 16:51:15.525', '2024-09-03 16:51:15.525', '2024-09-03 16:51:23.574', 1, 2);
INSERT INTO `role_menus` VALUES (225, '2024-09-03 16:51:15.527', '2024-09-03 16:51:15.527', '2024-09-03 16:51:23.574', 1, 1);
INSERT INTO `role_menus` VALUES (226, '2024-09-03 16:51:15.530', '2024-09-03 16:51:15.530', '2024-09-03 16:51:23.574', 1, 34);
INSERT INTO `role_menus` VALUES (227, '2024-09-03 16:51:15.532', '2024-09-03 16:51:15.532', '2024-09-03 16:51:23.574', 1, 35);
INSERT INTO `role_menus` VALUES (228, '2024-09-03 16:51:15.534', '2024-09-03 16:51:15.534', '2024-09-03 16:51:23.574', 1, 3);
INSERT INTO `role_menus` VALUES (229, '2024-09-03 16:51:15.537', '2024-09-03 16:51:15.537', '2024-09-03 16:51:23.574', 1, 4);
INSERT INTO `role_menus` VALUES (230, '2024-09-03 16:51:15.539', '2024-09-03 16:51:15.539', '2024-09-03 16:51:23.574', 1, 5);
INSERT INTO `role_menus` VALUES (231, '2024-09-03 16:51:15.542', '2024-09-03 16:51:15.542', '2024-09-03 16:51:23.574', 1, 6);
INSERT INTO `role_menus` VALUES (232, '2024-09-03 16:51:15.545', '2024-09-03 16:51:15.545', '2024-09-03 16:51:23.574', 1, 7);
INSERT INTO `role_menus` VALUES (233, '2024-09-03 16:51:15.548', '2024-09-03 16:51:15.548', '2024-09-03 16:51:23.574', 1, 8);
INSERT INTO `role_menus` VALUES (234, '2024-09-03 16:51:15.551', '2024-09-03 16:51:15.551', '2024-09-03 16:51:23.574', 1, 9);
INSERT INTO `role_menus` VALUES (235, '2024-09-03 16:51:15.555', '2024-09-03 16:51:15.555', '2024-09-03 16:51:23.574', 1, 10);
INSERT INTO `role_menus` VALUES (236, '2024-09-03 16:51:15.558', '2024-09-03 16:51:15.558', '2024-09-03 16:51:23.574', 1, 11);
INSERT INTO `role_menus` VALUES (237, '2024-09-03 16:51:15.560', '2024-09-03 16:51:15.560', '2024-09-03 16:51:23.574', 1, 12);
INSERT INTO `role_menus` VALUES (238, '2024-09-03 16:51:15.561', '2024-09-03 16:51:15.561', '2024-09-03 16:51:23.574', 1, 13);
INSERT INTO `role_menus` VALUES (239, '2024-09-03 16:51:15.562', '2024-09-03 16:51:15.562', '2024-09-03 16:51:23.574', 1, 30);
INSERT INTO `role_menus` VALUES (240, '2024-09-03 16:51:15.563', '2024-09-03 16:51:15.563', '2024-09-03 16:51:23.574', 1, 31);
INSERT INTO `role_menus` VALUES (241, '2024-09-03 16:51:23.586', '2024-09-03 16:51:23.586', '2024-09-03 16:57:00.306', 1, 1);
INSERT INTO `role_menus` VALUES (242, '2024-09-03 16:51:23.589', '2024-09-03 16:51:23.589', '2024-09-03 16:57:00.306', 1, 34);
INSERT INTO `role_menus` VALUES (243, '2024-09-03 16:51:23.593', '2024-09-03 16:51:23.593', '2024-09-03 16:57:00.306', 1, 35);
INSERT INTO `role_menus` VALUES (244, '2024-09-03 16:51:23.594', '2024-09-03 16:51:23.594', '2024-09-03 16:57:00.306', 1, 3);
INSERT INTO `role_menus` VALUES (245, '2024-09-03 16:51:23.597', '2024-09-03 16:51:23.597', '2024-09-03 16:57:00.306', 1, 4);
INSERT INTO `role_menus` VALUES (246, '2024-09-03 16:51:23.598', '2024-09-03 16:51:23.598', '2024-09-03 16:57:00.306', 1, 5);
INSERT INTO `role_menus` VALUES (247, '2024-09-03 16:51:23.601', '2024-09-03 16:51:23.601', '2024-09-03 16:57:00.306', 1, 6);
INSERT INTO `role_menus` VALUES (248, '2024-09-03 16:51:23.604', '2024-09-03 16:51:23.604', '2024-09-03 16:57:00.306', 1, 7);
INSERT INTO `role_menus` VALUES (249, '2024-09-03 16:51:23.608', '2024-09-03 16:51:23.608', '2024-09-03 16:57:00.306', 1, 8);
INSERT INTO `role_menus` VALUES (250, '2024-09-03 16:51:23.611', '2024-09-03 16:51:23.611', '2024-09-03 16:57:00.306', 1, 9);
INSERT INTO `role_menus` VALUES (251, '2024-09-03 16:51:23.614', '2024-09-03 16:51:23.614', '2024-09-03 16:57:00.306', 1, 10);
INSERT INTO `role_menus` VALUES (252, '2024-09-03 16:51:23.616', '2024-09-03 16:51:23.616', '2024-09-03 16:57:00.306', 1, 11);
INSERT INTO `role_menus` VALUES (253, '2024-09-03 16:51:23.617', '2024-09-03 16:51:23.617', '2024-09-03 16:57:00.306', 1, 12);
INSERT INTO `role_menus` VALUES (254, '2024-09-03 16:51:23.618', '2024-09-03 16:51:23.618', '2024-09-03 16:57:00.306', 1, 13);
INSERT INTO `role_menus` VALUES (255, '2024-09-03 16:51:23.620', '2024-09-03 16:51:23.620', '2024-09-03 16:57:00.306', 1, 30);
INSERT INTO `role_menus` VALUES (256, '2024-09-03 16:51:23.621', '2024-09-03 16:51:23.621', '2024-09-03 16:57:00.306', 1, 31);
INSERT INTO `role_menus` VALUES (257, '2024-09-03 16:57:00.322', '2024-09-03 16:57:00.322', '2024-09-03 16:58:02.062', 1, 1);
INSERT INTO `role_menus` VALUES (258, '2024-09-03 16:57:00.325', '2024-09-03 16:57:00.325', '2024-09-03 16:58:02.062', 1, 34);
INSERT INTO `role_menus` VALUES (259, '2024-09-03 16:57:00.329', '2024-09-03 16:57:00.329', '2024-09-03 16:58:02.062', 1, 35);
INSERT INTO `role_menus` VALUES (260, '2024-09-03 16:57:00.330', '2024-09-03 16:57:00.330', '2024-09-03 16:58:02.062', 1, 12);
INSERT INTO `role_menus` VALUES (261, '2024-09-03 16:57:00.332', '2024-09-03 16:57:00.332', '2024-09-03 16:58:02.062', 1, 13);
INSERT INTO `role_menus` VALUES (262, '2024-09-03 16:57:00.333', '2024-09-03 16:57:00.333', '2024-09-03 16:58:02.062', 1, 30);
INSERT INTO `role_menus` VALUES (263, '2024-09-03 16:57:00.334', '2024-09-03 16:57:00.334', '2024-09-03 16:58:02.062', 1, 31);
INSERT INTO `role_menus` VALUES (264, '2024-09-03 16:58:02.075', '2024-09-03 16:58:02.075', NULL, 1, 1);
INSERT INTO `role_menus` VALUES (265, '2024-09-03 16:58:02.079', '2024-09-03 16:58:02.079', NULL, 1, 34);
INSERT INTO `role_menus` VALUES (266, '2024-09-03 16:58:02.082', '2024-09-03 16:58:02.082', NULL, 1, 35);
INSERT INTO `role_menus` VALUES (267, '2024-09-03 16:58:02.084', '2024-09-03 16:58:02.084', NULL, 1, 3);
INSERT INTO `role_menus` VALUES (268, '2024-09-03 16:58:02.087', '2024-09-03 16:58:02.087', NULL, 1, 4);
INSERT INTO `role_menus` VALUES (269, '2024-09-03 16:58:02.089', '2024-09-03 16:58:02.089', NULL, 1, 5);
INSERT INTO `role_menus` VALUES (270, '2024-09-03 16:58:02.092', '2024-09-03 16:58:02.092', NULL, 1, 6);
INSERT INTO `role_menus` VALUES (271, '2024-09-03 16:58:02.097', '2024-09-03 16:58:02.097', NULL, 1, 8);
INSERT INTO `role_menus` VALUES (272, '2024-09-03 16:58:02.101', '2024-09-03 16:58:02.101', NULL, 1, 9);
INSERT INTO `role_menus` VALUES (273, '2024-09-03 16:58:02.107', '2024-09-03 16:58:02.107', NULL, 1, 10);
INSERT INTO `role_menus` VALUES (274, '2024-09-03 16:58:02.110', '2024-09-03 16:58:02.110', NULL, 1, 11);
INSERT INTO `role_menus` VALUES (275, '2024-09-03 16:58:02.111', '2024-09-03 16:58:02.111', NULL, 1, 12);
INSERT INTO `role_menus` VALUES (276, '2024-09-03 16:58:02.113', '2024-09-03 16:58:02.113', NULL, 1, 13);
INSERT INTO `role_menus` VALUES (277, '2024-09-03 16:58:02.114', '2024-09-03 16:58:02.114', NULL, 1, 30);
INSERT INTO `role_menus` VALUES (278, '2024-09-03 16:58:02.116', '2024-09-03 16:58:02.116', NULL, 1, 31);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色代码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_roles_code`(`code` ASC) USING BTREE,
  INDEX `idx_roles_deleted_at`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, '2024-09-03 10:32:38.239', '2024-09-03 10:32:38.239', NULL, '管理员', 'admin');
INSERT INTO `roles` VALUES (2, '2024-09-03 11:22:58.693', '2024-09-03 11:22:58.693', NULL, '测试', 'test');
INSERT INTO `roles` VALUES (4, '2024-09-03 11:23:11.209', '2024-09-03 11:23:11.209', NULL, '测试2', 'test2');

SET FOREIGN_KEY_CHECKS = 1;
