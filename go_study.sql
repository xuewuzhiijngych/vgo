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

 Date: 10/09/2024 13:43:26
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
) ENGINE = InnoDB AUTO_INCREMENT = 286 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of casbin_rule
-- ----------------------------
INSERT INTO `casbin_rule` VALUES (56, 'g', '5', 'admin', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (45, 'g', '6', 'test2', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (273, 'p', 'admin', '/admin/admin/notice/view', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (274, 'p', 'admin', '/admin/admin_user', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (275, 'p', 'admin', '/admin/admin_user/create', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (277, 'p', 'admin', '/admin/admin_user/delete', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (278, 'p', 'admin', '/admin/admin_user/get/role', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (279, 'p', 'admin', '/admin/admin_user/set/role', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (276, 'p', 'admin', '/admin/admin_user/update', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (259, 'p', 'admin', '/admin/button/list', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (270, 'p', 'admin', '/admin/menu/create', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (272, 'p', 'admin', '/admin/menu/delete', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (258, 'p', 'admin', '/admin/menu/list', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (271, 'p', 'admin', '/admin/menu/update', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (260, 'p', 'admin', '/admin/notice', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (265, 'p', 'admin', '/admin/notice/change', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (261, 'p', 'admin', '/admin/notice/create', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (263, 'p', 'admin', '/admin/notice/delete', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (264, 'p', 'admin', '/admin/notice/export', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (262, 'p', 'admin', '/admin/notice/update', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (266, 'p', 'admin', '/admin/notice/view', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (280, 'p', 'admin', '/admin/role', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (281, 'p', 'admin', '/admin/role/create', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (283, 'p', 'admin', '/admin/role/delete', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (285, 'p', 'admin', '/admin/role/get/menu', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (284, 'p', 'admin', '/admin/role/set/menu', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (282, 'p', 'admin', '/admin/role/update', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (267, 'p', 'admin', '/admin/upload', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (268, 'p', 'admin', '/admin/upload/img', '', '', '', '');
INSERT INTO `casbin_rule` VALUES (269, 'p', 'admin', '/admin/upload/video', '', '', '', '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES (1, NULL, NULL, NULL, 0, '/home/index', 'home', '', '', '/home/index', 'HomeFilled', '首页', '', '', 2, 2, 1, 2, 1, 1, 99);
INSERT INTO `menus` VALUES (2, NULL, NULL, '2024-09-03 16:50:46.507', 0, '/dataScreen', 'dataScreen', '', '', '/dataScreen/index', 'Histogram', '数据大屏', '', '', 2, 1, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (3, NULL, NULL, NULL, 0, '/cms', 'cms', '/cms/notice', '', '', 'Lollipop', '内容管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (4, NULL, '2024-09-03 10:24:23.566', NULL, 3, '/cms/notice', 'notice', '', '/admin/notice', '/cms/notice/index', 'Menu', '公告管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (5, NULL, NULL, NULL, 4, '/cms/notice/detail/:id', 'noticeDetail', '', '', '/cms/notice/detail', 'Menu', '公告 详情', '/cms/notice', '', 1, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (6, NULL, '2024-09-03 10:24:58.883', NULL, 4, '', 'create', '', '/admin/notice/create', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (7, NULL, NULL, NULL, 4, '', 'update', '', '/admin/notice/update', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (8, NULL, NULL, NULL, 4, '', 'delete', '', '/admin/notice/delete', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (9, NULL, NULL, NULL, 4, '', 'export', '', '/admin/notice/export', '', '', '导出', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (10, NULL, NULL, NULL, 4, '', 'change', '', '/admin/notice/change', '', '', '修改状态', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (11, NULL, NULL, NULL, 4, '', 'view', '', '/admin/notice/view', '', '', '查看', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (12, NULL, '2024-09-02 15:59:39.192', NULL, 0, '/authority', 'authority', '/authority/menu', '', '', 'Lock', '权限管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (13, NULL, '2024-09-02 17:18:24.867', NULL, 12, '/authority/menu', 'menuAuthority', '', '', '/authority/menu/index', 'Menu', '菜单权限', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (30, '2024-09-02 10:35:03.467', '2024-09-02 10:35:03.467', NULL, 12, '/authority/admin_user', 'adminUser', '', '/admin/admin_user', '/authority/admin_user/index', 'Avatar', '管理员', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (31, '2024-09-02 16:10:02.983', '2024-09-02 16:10:02.983', NULL, 12, '/authority/role', 'role', '', '/admin/role', '/authority/role/index', 'Stamp', '角色管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (34, '2024-09-03 10:28:22.793', '2024-09-03 10:29:17.200', NULL, 1, '', 'none', '', '/admin/menu/list', '', '', '用户菜单数据源', '', '', 1, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (35, '2024-09-03 10:28:53.299', '2024-09-03 10:29:24.284', NULL, 1, '', 'none', '', '/admin/button/list', '', '', '用户按钮数据源', '', '', 1, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (36, NULL, '2024-09-03 10:24:58.883', NULL, 13, '', 'create', '', '/admin/menu/create', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (37, NULL, NULL, NULL, 13, '', 'update', '', '/admin/menu/update', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (38, NULL, NULL, NULL, 13, '', 'delete', '', '/admin/menu/delete', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (41, NULL, NULL, NULL, 13, '', 'view', '', '/admin/admin/notice/view', '', '', '查看', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (42, NULL, '2024-09-03 10:24:58.883', NULL, 30, '', 'create', '', '/admin/admin_user/create', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (43, NULL, NULL, NULL, 30, '', 'update', '', '/admin/admin_user/update', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (44, NULL, NULL, NULL, 30, '', 'delete', '', '/admin/admin_user/delete', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (45, NULL, NULL, NULL, 30, '', 'role', '', '/admin/admin_user/get/role', '', '', '查看角色', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (46, NULL, NULL, NULL, 30, '', 'role', '', '/admin/admin_user/set/role', '', '', '设置角色', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (47, NULL, '2024-09-03 10:24:58.883', NULL, 31, '', 'create', '', '/admin/role/create', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (48, NULL, NULL, NULL, 31, '', 'update', '', '/admin/role/update', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (49, NULL, NULL, NULL, 31, '', 'delete', '', '/admin/role/delete', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (50, NULL, NULL, NULL, 31, '', 'authority', '', '/admin/role/set/menu', '', '', '查看角色', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (51, NULL, NULL, NULL, 31, '', 'authority', '', '/admin/role/get/menu', '', '', '设置角色', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (52, NULL, '2024-09-10 09:24:24.375', NULL, 3, '/cms/upload', 'upload', '', '/admin/upload', '/cms/upload/index', 'Upload', '文件上传', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (53, NULL, '2024-09-03 10:24:58.883', NULL, 52, '', 'upload-img', '', '/admin/upload/img', '', '', '图片上传', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (54, NULL, '2024-09-03 10:24:58.883', NULL, 52, '', 'upload-video', '', '/admin/upload/video', '', '', '视频上传', '', '', 1, 2, 2, 2, 1, 2, 0);

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
INSERT INTO `notices` VALUES (9, '2024-09-02 17:16:01.679', '2024-09-09 08:53:50.063', NULL, '是的是的', 0, 1, '<p>颠三倒四</p>', '');
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
) ENGINE = InnoDB AUTO_INCREMENT = 481 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `role_menus` VALUES (264, '2024-09-03 16:58:02.075', '2024-09-03 16:58:02.075', '2024-09-04 09:56:14.748', 1, 1);
INSERT INTO `role_menus` VALUES (265, '2024-09-03 16:58:02.079', '2024-09-03 16:58:02.079', '2024-09-04 09:56:14.748', 1, 34);
INSERT INTO `role_menus` VALUES (266, '2024-09-03 16:58:02.082', '2024-09-03 16:58:02.082', '2024-09-04 09:56:14.748', 1, 35);
INSERT INTO `role_menus` VALUES (267, '2024-09-03 16:58:02.084', '2024-09-03 16:58:02.084', '2024-09-04 09:56:14.748', 1, 3);
INSERT INTO `role_menus` VALUES (268, '2024-09-03 16:58:02.087', '2024-09-03 16:58:02.087', '2024-09-04 09:56:14.748', 1, 4);
INSERT INTO `role_menus` VALUES (269, '2024-09-03 16:58:02.089', '2024-09-03 16:58:02.089', '2024-09-04 09:56:14.748', 1, 5);
INSERT INTO `role_menus` VALUES (270, '2024-09-03 16:58:02.092', '2024-09-03 16:58:02.092', '2024-09-04 09:56:14.748', 1, 6);
INSERT INTO `role_menus` VALUES (271, '2024-09-03 16:58:02.097', '2024-09-03 16:58:02.097', '2024-09-04 09:56:14.748', 1, 8);
INSERT INTO `role_menus` VALUES (272, '2024-09-03 16:58:02.101', '2024-09-03 16:58:02.101', '2024-09-04 09:56:14.748', 1, 9);
INSERT INTO `role_menus` VALUES (273, '2024-09-03 16:58:02.107', '2024-09-03 16:58:02.107', '2024-09-04 09:56:14.748', 1, 10);
INSERT INTO `role_menus` VALUES (274, '2024-09-03 16:58:02.110', '2024-09-03 16:58:02.110', '2024-09-04 09:56:14.748', 1, 11);
INSERT INTO `role_menus` VALUES (275, '2024-09-03 16:58:02.111', '2024-09-03 16:58:02.111', '2024-09-04 09:56:14.748', 1, 12);
INSERT INTO `role_menus` VALUES (276, '2024-09-03 16:58:02.113', '2024-09-03 16:58:02.113', '2024-09-04 09:56:14.748', 1, 13);
INSERT INTO `role_menus` VALUES (277, '2024-09-03 16:58:02.114', '2024-09-03 16:58:02.114', '2024-09-04 09:56:14.748', 1, 30);
INSERT INTO `role_menus` VALUES (278, '2024-09-03 16:58:02.116', '2024-09-03 16:58:02.116', '2024-09-04 09:56:14.748', 1, 31);
INSERT INTO `role_menus` VALUES (279, '2024-09-04 09:56:14.780', '2024-09-04 09:56:14.780', '2024-09-04 09:57:06.913', 1, 1);
INSERT INTO `role_menus` VALUES (280, '2024-09-04 09:56:14.785', '2024-09-04 09:56:14.785', '2024-09-04 09:57:06.913', 1, 34);
INSERT INTO `role_menus` VALUES (281, '2024-09-04 09:56:14.789', '2024-09-04 09:56:14.789', '2024-09-04 09:57:06.913', 1, 35);
INSERT INTO `role_menus` VALUES (282, '2024-09-04 09:56:14.791', '2024-09-04 09:56:14.791', '2024-09-04 09:57:06.913', 1, 3);
INSERT INTO `role_menus` VALUES (283, '2024-09-04 09:56:14.793', '2024-09-04 09:56:14.793', '2024-09-04 09:57:06.913', 1, 4);
INSERT INTO `role_menus` VALUES (284, '2024-09-04 09:56:14.795', '2024-09-04 09:56:14.795', '2024-09-04 09:57:06.913', 1, 5);
INSERT INTO `role_menus` VALUES (285, '2024-09-04 09:56:14.798', '2024-09-04 09:56:14.798', '2024-09-04 09:57:06.913', 1, 6);
INSERT INTO `role_menus` VALUES (286, '2024-09-04 09:56:14.801', '2024-09-04 09:56:14.801', '2024-09-04 09:57:06.913', 1, 7);
INSERT INTO `role_menus` VALUES (287, '2024-09-04 09:56:14.805', '2024-09-04 09:56:14.805', '2024-09-04 09:57:06.913', 1, 8);
INSERT INTO `role_menus` VALUES (288, '2024-09-04 09:56:14.808', '2024-09-04 09:56:14.808', '2024-09-04 09:57:06.913', 1, 9);
INSERT INTO `role_menus` VALUES (289, '2024-09-04 09:56:14.812', '2024-09-04 09:56:14.812', '2024-09-04 09:57:06.913', 1, 10);
INSERT INTO `role_menus` VALUES (290, '2024-09-04 09:56:14.814', '2024-09-04 09:56:14.814', '2024-09-04 09:57:06.913', 1, 11);
INSERT INTO `role_menus` VALUES (291, '2024-09-04 09:56:14.815', '2024-09-04 09:56:14.815', '2024-09-04 09:57:06.913', 1, 12);
INSERT INTO `role_menus` VALUES (292, '2024-09-04 09:56:14.816', '2024-09-04 09:56:14.816', '2024-09-04 09:57:06.913', 1, 13);
INSERT INTO `role_menus` VALUES (293, '2024-09-04 09:56:14.818', '2024-09-04 09:56:14.818', '2024-09-04 09:57:06.913', 1, 30);
INSERT INTO `role_menus` VALUES (294, '2024-09-04 09:56:14.819', '2024-09-04 09:56:14.819', '2024-09-04 09:57:06.913', 1, 31);
INSERT INTO `role_menus` VALUES (295, '2024-09-04 09:57:06.928', '2024-09-04 09:57:06.928', '2024-09-04 10:12:10.807', 1, 1);
INSERT INTO `role_menus` VALUES (296, '2024-09-04 09:57:06.931', '2024-09-04 09:57:06.931', '2024-09-04 10:12:10.807', 1, 34);
INSERT INTO `role_menus` VALUES (297, '2024-09-04 09:57:06.933', '2024-09-04 09:57:06.933', '2024-09-04 10:12:10.807', 1, 35);
INSERT INTO `role_menus` VALUES (298, '2024-09-04 09:57:06.935', '2024-09-04 09:57:06.935', '2024-09-04 10:12:10.807', 1, 3);
INSERT INTO `role_menus` VALUES (299, '2024-09-04 09:57:06.938', '2024-09-04 09:57:06.938', '2024-09-04 10:12:10.807', 1, 4);
INSERT INTO `role_menus` VALUES (300, '2024-09-04 09:57:06.940', '2024-09-04 09:57:06.940', '2024-09-04 10:12:10.807', 1, 5);
INSERT INTO `role_menus` VALUES (301, '2024-09-04 09:57:06.942', '2024-09-04 09:57:06.942', '2024-09-04 10:12:10.807', 1, 6);
INSERT INTO `role_menus` VALUES (302, '2024-09-04 09:57:06.945', '2024-09-04 09:57:06.945', '2024-09-04 10:12:10.807', 1, 7);
INSERT INTO `role_menus` VALUES (303, '2024-09-04 09:57:06.948', '2024-09-04 09:57:06.948', '2024-09-04 10:12:10.807', 1, 8);
INSERT INTO `role_menus` VALUES (304, '2024-09-04 09:57:06.951', '2024-09-04 09:57:06.951', '2024-09-04 10:12:10.807', 1, 9);
INSERT INTO `role_menus` VALUES (305, '2024-09-04 09:57:06.954', '2024-09-04 09:57:06.954', '2024-09-04 10:12:10.807', 1, 10);
INSERT INTO `role_menus` VALUES (306, '2024-09-04 09:57:06.957', '2024-09-04 09:57:06.957', '2024-09-04 10:12:10.807', 1, 11);
INSERT INTO `role_menus` VALUES (307, '2024-09-04 09:57:06.960', '2024-09-04 09:57:06.960', '2024-09-04 10:12:10.807', 1, 12);
INSERT INTO `role_menus` VALUES (308, '2024-09-04 09:57:06.961', '2024-09-04 09:57:06.961', '2024-09-04 10:12:10.807', 1, 13);
INSERT INTO `role_menus` VALUES (309, '2024-09-04 09:57:06.962', '2024-09-04 09:57:06.962', '2024-09-04 10:12:10.807', 1, 30);
INSERT INTO `role_menus` VALUES (310, '2024-09-04 09:57:06.963', '2024-09-04 09:57:06.963', '2024-09-04 10:12:10.807', 1, 31);
INSERT INTO `role_menus` VALUES (311, '2024-09-04 10:12:10.826', '2024-09-04 10:12:10.826', '2024-09-04 10:13:30.246', 1, 1);
INSERT INTO `role_menus` VALUES (312, '2024-09-04 10:12:10.829', '2024-09-04 10:12:10.829', '2024-09-04 10:13:30.246', 1, 34);
INSERT INTO `role_menus` VALUES (313, '2024-09-04 10:12:10.834', '2024-09-04 10:12:10.834', '2024-09-04 10:13:30.246', 1, 35);
INSERT INTO `role_menus` VALUES (314, '2024-09-04 10:12:10.836', '2024-09-04 10:12:10.836', '2024-09-04 10:13:30.246', 1, 3);
INSERT INTO `role_menus` VALUES (315, '2024-09-04 10:12:10.839', '2024-09-04 10:12:10.839', '2024-09-04 10:13:30.246', 1, 4);
INSERT INTO `role_menus` VALUES (316, '2024-09-04 10:12:10.841', '2024-09-04 10:12:10.841', '2024-09-04 10:13:30.246', 1, 5);
INSERT INTO `role_menus` VALUES (317, '2024-09-04 10:12:10.844', '2024-09-04 10:12:10.844', '2024-09-04 10:13:30.246', 1, 6);
INSERT INTO `role_menus` VALUES (318, '2024-09-04 10:12:10.847', '2024-09-04 10:12:10.847', '2024-09-04 10:13:30.246', 1, 7);
INSERT INTO `role_menus` VALUES (319, '2024-09-04 10:12:10.851', '2024-09-04 10:12:10.851', '2024-09-04 10:13:30.246', 1, 8);
INSERT INTO `role_menus` VALUES (320, '2024-09-04 10:12:10.856', '2024-09-04 10:12:10.856', '2024-09-04 10:13:30.246', 1, 9);
INSERT INTO `role_menus` VALUES (321, '2024-09-04 10:12:10.859', '2024-09-04 10:12:10.859', '2024-09-04 10:13:30.246', 1, 10);
INSERT INTO `role_menus` VALUES (322, '2024-09-04 10:12:10.862', '2024-09-04 10:12:10.862', '2024-09-04 10:13:30.246', 1, 11);
INSERT INTO `role_menus` VALUES (323, '2024-09-04 10:12:10.863', '2024-09-04 10:12:10.863', '2024-09-04 10:13:30.246', 1, 12);
INSERT INTO `role_menus` VALUES (324, '2024-09-04 10:12:10.865', '2024-09-04 10:12:10.865', '2024-09-04 10:13:30.246', 1, 13);
INSERT INTO `role_menus` VALUES (325, '2024-09-04 10:12:10.868', '2024-09-04 10:12:10.868', '2024-09-04 10:13:30.246', 1, 36);
INSERT INTO `role_menus` VALUES (326, '2024-09-04 10:12:10.873', '2024-09-04 10:12:10.873', '2024-09-04 10:13:30.246', 1, 37);
INSERT INTO `role_menus` VALUES (327, '2024-09-04 10:12:10.877', '2024-09-04 10:12:10.877', '2024-09-04 10:13:30.246', 1, 38);
INSERT INTO `role_menus` VALUES (328, '2024-09-04 10:12:10.881', '2024-09-04 10:12:10.881', '2024-09-04 10:13:30.246', 1, 41);
INSERT INTO `role_menus` VALUES (329, '2024-09-04 10:12:10.883', '2024-09-04 10:12:10.883', '2024-09-04 10:13:30.246', 1, 30);
INSERT INTO `role_menus` VALUES (330, '2024-09-04 10:12:10.886', '2024-09-04 10:12:10.886', '2024-09-04 10:13:30.246', 1, 42);
INSERT INTO `role_menus` VALUES (331, '2024-09-04 10:12:10.891', '2024-09-04 10:12:10.891', '2024-09-04 10:13:30.246', 1, 43);
INSERT INTO `role_menus` VALUES (332, '2024-09-04 10:12:10.894', '2024-09-04 10:12:10.894', '2024-09-04 10:13:30.246', 1, 44);
INSERT INTO `role_menus` VALUES (333, '2024-09-04 10:12:10.899', '2024-09-04 10:12:10.899', '2024-09-04 10:13:30.246', 1, 45);
INSERT INTO `role_menus` VALUES (334, '2024-09-04 10:12:10.903', '2024-09-04 10:12:10.903', '2024-09-04 10:13:30.246', 1, 46);
INSERT INTO `role_menus` VALUES (335, '2024-09-04 10:12:10.905', '2024-09-04 10:12:10.905', '2024-09-04 10:13:30.246', 1, 31);
INSERT INTO `role_menus` VALUES (336, '2024-09-04 10:12:10.908', '2024-09-04 10:12:10.908', '2024-09-04 10:13:30.246', 1, 47);
INSERT INTO `role_menus` VALUES (337, '2024-09-04 10:12:10.912', '2024-09-04 10:12:10.912', '2024-09-04 10:13:30.246', 1, 48);
INSERT INTO `role_menus` VALUES (338, '2024-09-04 10:12:10.916', '2024-09-04 10:12:10.916', '2024-09-04 10:13:30.246', 1, 49);
INSERT INTO `role_menus` VALUES (339, '2024-09-04 10:12:10.920', '2024-09-04 10:12:10.920', '2024-09-04 10:13:30.246', 1, 50);
INSERT INTO `role_menus` VALUES (340, '2024-09-04 10:12:10.925', '2024-09-04 10:12:10.925', '2024-09-04 10:13:30.246', 1, 51);
INSERT INTO `role_menus` VALUES (341, '2024-09-04 10:13:30.260', '2024-09-04 10:13:30.260', '2024-09-04 10:14:15.988', 1, 1);
INSERT INTO `role_menus` VALUES (342, '2024-09-04 10:13:30.263', '2024-09-04 10:13:30.263', '2024-09-04 10:14:15.988', 1, 34);
INSERT INTO `role_menus` VALUES (343, '2024-09-04 10:13:30.267', '2024-09-04 10:13:30.267', '2024-09-04 10:14:15.988', 1, 35);
INSERT INTO `role_menus` VALUES (344, '2024-09-04 10:13:30.269', '2024-09-04 10:13:30.269', '2024-09-04 10:14:15.988', 1, 3);
INSERT INTO `role_menus` VALUES (345, '2024-09-04 10:13:30.272', '2024-09-04 10:13:30.272', '2024-09-04 10:14:15.988', 1, 4);
INSERT INTO `role_menus` VALUES (346, '2024-09-04 10:13:30.273', '2024-09-04 10:13:30.273', '2024-09-04 10:14:15.988', 1, 5);
INSERT INTO `role_menus` VALUES (347, '2024-09-04 10:13:30.276', '2024-09-04 10:13:30.276', '2024-09-04 10:14:15.988', 1, 6);
INSERT INTO `role_menus` VALUES (348, '2024-09-04 10:13:30.280', '2024-09-04 10:13:30.280', '2024-09-04 10:14:15.988', 1, 7);
INSERT INTO `role_menus` VALUES (349, '2024-09-04 10:13:30.283', '2024-09-04 10:13:30.283', '2024-09-04 10:14:15.988', 1, 8);
INSERT INTO `role_menus` VALUES (350, '2024-09-04 10:13:30.287', '2024-09-04 10:13:30.287', '2024-09-04 10:14:15.988', 1, 9);
INSERT INTO `role_menus` VALUES (351, '2024-09-04 10:13:30.293', '2024-09-04 10:13:30.293', '2024-09-04 10:14:15.988', 1, 10);
INSERT INTO `role_menus` VALUES (352, '2024-09-04 10:13:30.297', '2024-09-04 10:13:30.297', '2024-09-04 10:14:15.988', 1, 11);
INSERT INTO `role_menus` VALUES (353, '2024-09-04 10:13:30.300', '2024-09-04 10:13:30.300', '2024-09-04 10:14:15.988', 1, 12);
INSERT INTO `role_menus` VALUES (354, '2024-09-04 10:13:30.302', '2024-09-04 10:13:30.302', '2024-09-04 10:14:15.988', 1, 13);
INSERT INTO `role_menus` VALUES (355, '2024-09-04 10:13:30.305', '2024-09-04 10:13:30.305', '2024-09-04 10:14:15.988', 1, 36);
INSERT INTO `role_menus` VALUES (356, '2024-09-04 10:13:30.309', '2024-09-04 10:13:30.309', '2024-09-04 10:14:15.988', 1, 37);
INSERT INTO `role_menus` VALUES (357, '2024-09-04 10:13:30.313', '2024-09-04 10:13:30.313', '2024-09-04 10:14:15.988', 1, 38);
INSERT INTO `role_menus` VALUES (358, '2024-09-04 10:13:30.318', '2024-09-04 10:13:30.318', '2024-09-04 10:14:15.988', 1, 41);
INSERT INTO `role_menus` VALUES (359, '2024-09-04 10:13:30.321', '2024-09-04 10:13:30.321', '2024-09-04 10:14:15.988', 1, 30);
INSERT INTO `role_menus` VALUES (360, '2024-09-04 10:13:30.324', '2024-09-04 10:13:30.324', '2024-09-04 10:14:15.988', 1, 42);
INSERT INTO `role_menus` VALUES (361, '2024-09-04 10:13:30.328', '2024-09-04 10:13:30.328', '2024-09-04 10:14:15.988', 1, 43);
INSERT INTO `role_menus` VALUES (362, '2024-09-04 10:13:30.333', '2024-09-04 10:13:30.333', '2024-09-04 10:14:15.988', 1, 44);
INSERT INTO `role_menus` VALUES (363, '2024-09-04 10:13:30.339', '2024-09-04 10:13:30.339', '2024-09-04 10:14:15.988', 1, 45);
INSERT INTO `role_menus` VALUES (364, '2024-09-04 10:13:30.344', '2024-09-04 10:13:30.344', '2024-09-04 10:14:15.988', 1, 46);
INSERT INTO `role_menus` VALUES (365, '2024-09-04 10:13:30.346', '2024-09-04 10:13:30.346', '2024-09-04 10:14:15.988', 1, 31);
INSERT INTO `role_menus` VALUES (366, '2024-09-04 10:13:30.352', '2024-09-04 10:13:30.352', '2024-09-04 10:14:15.988', 1, 47);
INSERT INTO `role_menus` VALUES (367, '2024-09-04 10:13:30.356', '2024-09-04 10:13:30.356', '2024-09-04 10:14:15.988', 1, 48);
INSERT INTO `role_menus` VALUES (368, '2024-09-04 10:13:30.360', '2024-09-04 10:13:30.360', '2024-09-04 10:14:15.988', 1, 49);
INSERT INTO `role_menus` VALUES (369, '2024-09-04 10:13:30.367', '2024-09-04 10:13:30.367', '2024-09-04 10:14:15.988', 1, 50);
INSERT INTO `role_menus` VALUES (370, '2024-09-04 10:13:30.372', '2024-09-04 10:13:30.372', '2024-09-04 10:14:15.988', 1, 51);
INSERT INTO `role_menus` VALUES (371, '2024-09-04 10:14:16.003', '2024-09-04 10:14:16.003', '2024-09-07 17:01:31.705', 1, 1);
INSERT INTO `role_menus` VALUES (372, '2024-09-04 10:14:16.006', '2024-09-04 10:14:16.006', '2024-09-07 17:01:31.705', 1, 34);
INSERT INTO `role_menus` VALUES (373, '2024-09-04 10:14:16.010', '2024-09-04 10:14:16.010', '2024-09-07 17:01:31.705', 1, 35);
INSERT INTO `role_menus` VALUES (374, '2024-09-04 10:14:16.012', '2024-09-04 10:14:16.012', '2024-09-07 17:01:31.705', 1, 3);
INSERT INTO `role_menus` VALUES (375, '2024-09-04 10:14:16.015', '2024-09-04 10:14:16.015', '2024-09-07 17:01:31.705', 1, 4);
INSERT INTO `role_menus` VALUES (376, '2024-09-04 10:14:16.017', '2024-09-04 10:14:16.017', '2024-09-07 17:01:31.705', 1, 5);
INSERT INTO `role_menus` VALUES (377, '2024-09-04 10:14:16.020', '2024-09-04 10:14:16.020', '2024-09-07 17:01:31.705', 1, 6);
INSERT INTO `role_menus` VALUES (378, '2024-09-04 10:14:16.023', '2024-09-04 10:14:16.023', '2024-09-07 17:01:31.705', 1, 7);
INSERT INTO `role_menus` VALUES (379, '2024-09-04 10:14:16.027', '2024-09-04 10:14:16.027', '2024-09-07 17:01:31.705', 1, 8);
INSERT INTO `role_menus` VALUES (380, '2024-09-04 10:14:16.031', '2024-09-04 10:14:16.031', '2024-09-07 17:01:31.705', 1, 9);
INSERT INTO `role_menus` VALUES (381, '2024-09-04 10:14:16.036', '2024-09-04 10:14:16.036', '2024-09-07 17:01:31.705', 1, 10);
INSERT INTO `role_menus` VALUES (382, '2024-09-04 10:14:16.040', '2024-09-04 10:14:16.040', '2024-09-07 17:01:31.705', 1, 11);
INSERT INTO `role_menus` VALUES (383, '2024-09-04 10:14:16.042', '2024-09-04 10:14:16.042', '2024-09-07 17:01:31.705', 1, 12);
INSERT INTO `role_menus` VALUES (384, '2024-09-04 10:14:16.044', '2024-09-04 10:14:16.044', '2024-09-07 17:01:31.705', 1, 13);
INSERT INTO `role_menus` VALUES (385, '2024-09-04 10:14:16.046', '2024-09-04 10:14:16.046', '2024-09-07 17:01:31.705', 1, 36);
INSERT INTO `role_menus` VALUES (386, '2024-09-04 10:14:16.051', '2024-09-04 10:14:16.051', '2024-09-07 17:01:31.705', 1, 37);
INSERT INTO `role_menus` VALUES (387, '2024-09-04 10:14:16.055', '2024-09-04 10:14:16.055', '2024-09-07 17:01:31.705', 1, 38);
INSERT INTO `role_menus` VALUES (388, '2024-09-04 10:14:16.058', '2024-09-04 10:14:16.058', '2024-09-07 17:01:31.705', 1, 41);
INSERT INTO `role_menus` VALUES (389, '2024-09-04 10:14:16.062', '2024-09-04 10:14:16.062', '2024-09-07 17:01:31.705', 1, 30);
INSERT INTO `role_menus` VALUES (390, '2024-09-04 10:14:16.067', '2024-09-04 10:14:16.067', '2024-09-07 17:01:31.705', 1, 42);
INSERT INTO `role_menus` VALUES (391, '2024-09-04 10:14:16.071', '2024-09-04 10:14:16.071', '2024-09-07 17:01:31.705', 1, 43);
INSERT INTO `role_menus` VALUES (392, '2024-09-04 10:14:16.075', '2024-09-04 10:14:16.075', '2024-09-07 17:01:31.705', 1, 44);
INSERT INTO `role_menus` VALUES (393, '2024-09-04 10:14:16.080', '2024-09-04 10:14:16.080', '2024-09-07 17:01:31.705', 1, 45);
INSERT INTO `role_menus` VALUES (394, '2024-09-04 10:14:16.085', '2024-09-04 10:14:16.085', '2024-09-07 17:01:31.705', 1, 46);
INSERT INTO `role_menus` VALUES (395, '2024-09-04 10:14:16.091', '2024-09-04 10:14:16.091', '2024-09-07 17:01:31.705', 1, 31);
INSERT INTO `role_menus` VALUES (396, '2024-09-04 10:14:16.096', '2024-09-04 10:14:16.096', '2024-09-07 17:01:31.705', 1, 47);
INSERT INTO `role_menus` VALUES (397, '2024-09-04 10:14:16.101', '2024-09-04 10:14:16.101', '2024-09-07 17:01:31.705', 1, 48);
INSERT INTO `role_menus` VALUES (398, '2024-09-04 10:14:16.106', '2024-09-04 10:14:16.106', '2024-09-07 17:01:31.705', 1, 49);
INSERT INTO `role_menus` VALUES (399, '2024-09-04 10:14:16.110', '2024-09-04 10:14:16.110', '2024-09-07 17:01:31.705', 1, 50);
INSERT INTO `role_menus` VALUES (400, '2024-09-04 10:14:16.117', '2024-09-04 10:14:16.117', '2024-09-07 17:01:31.705', 1, 51);
INSERT INTO `role_menus` VALUES (401, '2024-09-07 17:01:31.735', '2024-09-07 17:01:31.735', '2024-09-07 17:02:16.649', 1, 1);
INSERT INTO `role_menus` VALUES (402, '2024-09-07 17:01:31.738', '2024-09-07 17:01:31.738', '2024-09-07 17:02:16.649', 1, 34);
INSERT INTO `role_menus` VALUES (403, '2024-09-07 17:01:31.741', '2024-09-07 17:01:31.741', '2024-09-07 17:02:16.649', 1, 35);
INSERT INTO `role_menus` VALUES (404, '2024-09-07 17:01:31.742', '2024-09-07 17:01:31.742', '2024-09-07 17:02:16.649', 1, 12);
INSERT INTO `role_menus` VALUES (405, '2024-09-07 17:01:31.744', '2024-09-07 17:01:31.744', '2024-09-07 17:02:16.649', 1, 13);
INSERT INTO `role_menus` VALUES (406, '2024-09-07 17:01:31.746', '2024-09-07 17:01:31.746', '2024-09-07 17:02:16.649', 1, 36);
INSERT INTO `role_menus` VALUES (407, '2024-09-07 17:01:31.748', '2024-09-07 17:01:31.748', '2024-09-07 17:02:16.649', 1, 37);
INSERT INTO `role_menus` VALUES (408, '2024-09-07 17:01:31.751', '2024-09-07 17:01:31.751', '2024-09-07 17:02:16.649', 1, 38);
INSERT INTO `role_menus` VALUES (409, '2024-09-07 17:01:31.753', '2024-09-07 17:01:31.753', '2024-09-07 17:02:16.649', 1, 41);
INSERT INTO `role_menus` VALUES (410, '2024-09-07 17:01:31.756', '2024-09-07 17:01:31.756', '2024-09-07 17:02:16.649', 1, 30);
INSERT INTO `role_menus` VALUES (411, '2024-09-07 17:01:31.758', '2024-09-07 17:01:31.758', '2024-09-07 17:02:16.649', 1, 42);
INSERT INTO `role_menus` VALUES (412, '2024-09-07 17:01:31.761', '2024-09-07 17:01:31.761', '2024-09-07 17:02:16.649', 1, 43);
INSERT INTO `role_menus` VALUES (413, '2024-09-07 17:01:31.763', '2024-09-07 17:01:31.763', '2024-09-07 17:02:16.649', 1, 44);
INSERT INTO `role_menus` VALUES (414, '2024-09-07 17:01:31.766', '2024-09-07 17:01:31.766', '2024-09-07 17:02:16.649', 1, 45);
INSERT INTO `role_menus` VALUES (415, '2024-09-07 17:01:31.768', '2024-09-07 17:01:31.768', '2024-09-07 17:02:16.649', 1, 46);
INSERT INTO `role_menus` VALUES (416, '2024-09-07 17:01:31.770', '2024-09-07 17:01:31.770', '2024-09-07 17:02:16.649', 1, 31);
INSERT INTO `role_menus` VALUES (417, '2024-09-07 17:01:31.773', '2024-09-07 17:01:31.773', '2024-09-07 17:02:16.649', 1, 47);
INSERT INTO `role_menus` VALUES (418, '2024-09-07 17:01:31.775', '2024-09-07 17:01:31.775', '2024-09-07 17:02:16.649', 1, 48);
INSERT INTO `role_menus` VALUES (419, '2024-09-07 17:01:31.778', '2024-09-07 17:01:31.778', '2024-09-07 17:02:16.649', 1, 49);
INSERT INTO `role_menus` VALUES (420, '2024-09-07 17:01:31.781', '2024-09-07 17:01:31.781', '2024-09-07 17:02:16.649', 1, 50);
INSERT INTO `role_menus` VALUES (421, '2024-09-07 17:01:31.783', '2024-09-07 17:01:31.783', '2024-09-07 17:02:16.649', 1, 51);
INSERT INTO `role_menus` VALUES (422, '2024-09-07 17:02:16.666', '2024-09-07 17:02:16.666', '2024-09-10 11:18:28.128', 1, 1);
INSERT INTO `role_menus` VALUES (423, '2024-09-07 17:02:16.668', '2024-09-07 17:02:16.668', '2024-09-10 11:18:28.128', 1, 34);
INSERT INTO `role_menus` VALUES (424, '2024-09-07 17:02:16.671', '2024-09-07 17:02:16.671', '2024-09-10 11:18:28.128', 1, 35);
INSERT INTO `role_menus` VALUES (425, '2024-09-07 17:02:16.672', '2024-09-07 17:02:16.672', '2024-09-10 11:18:28.128', 1, 3);
INSERT INTO `role_menus` VALUES (426, '2024-09-07 17:02:16.675', '2024-09-07 17:02:16.675', '2024-09-10 11:18:28.128', 1, 4);
INSERT INTO `role_menus` VALUES (427, '2024-09-07 17:02:16.677', '2024-09-07 17:02:16.677', '2024-09-10 11:18:28.128', 1, 5);
INSERT INTO `role_menus` VALUES (428, '2024-09-07 17:02:16.681', '2024-09-07 17:02:16.681', '2024-09-10 11:18:28.128', 1, 10);
INSERT INTO `role_menus` VALUES (429, '2024-09-07 17:02:16.683', '2024-09-07 17:02:16.683', '2024-09-10 11:18:28.128', 1, 11);
INSERT INTO `role_menus` VALUES (430, '2024-09-07 17:02:16.684', '2024-09-07 17:02:16.684', '2024-09-10 11:18:28.128', 1, 12);
INSERT INTO `role_menus` VALUES (431, '2024-09-07 17:02:16.685', '2024-09-07 17:02:16.685', '2024-09-10 11:18:28.128', 1, 13);
INSERT INTO `role_menus` VALUES (432, '2024-09-07 17:02:16.688', '2024-09-07 17:02:16.688', '2024-09-10 11:18:28.128', 1, 36);
INSERT INTO `role_menus` VALUES (433, '2024-09-07 17:02:16.691', '2024-09-07 17:02:16.691', '2024-09-10 11:18:28.128', 1, 37);
INSERT INTO `role_menus` VALUES (434, '2024-09-07 17:02:16.693', '2024-09-07 17:02:16.693', '2024-09-10 11:18:28.128', 1, 38);
INSERT INTO `role_menus` VALUES (435, '2024-09-07 17:02:16.696', '2024-09-07 17:02:16.696', '2024-09-10 11:18:28.128', 1, 41);
INSERT INTO `role_menus` VALUES (436, '2024-09-07 17:02:16.698', '2024-09-07 17:02:16.698', '2024-09-10 11:18:28.128', 1, 30);
INSERT INTO `role_menus` VALUES (437, '2024-09-07 17:02:16.701', '2024-09-07 17:02:16.701', '2024-09-10 11:18:28.128', 1, 42);
INSERT INTO `role_menus` VALUES (438, '2024-09-07 17:02:16.707', '2024-09-07 17:02:16.707', '2024-09-10 11:18:28.128', 1, 43);
INSERT INTO `role_menus` VALUES (439, '2024-09-07 17:02:16.711', '2024-09-07 17:02:16.711', '2024-09-10 11:18:28.128', 1, 44);
INSERT INTO `role_menus` VALUES (440, '2024-09-07 17:02:16.715', '2024-09-07 17:02:16.715', '2024-09-10 11:18:28.128', 1, 45);
INSERT INTO `role_menus` VALUES (441, '2024-09-07 17:02:16.718', '2024-09-07 17:02:16.718', '2024-09-10 11:18:28.128', 1, 46);
INSERT INTO `role_menus` VALUES (442, '2024-09-07 17:02:16.721', '2024-09-07 17:02:16.721', '2024-09-10 11:18:28.128', 1, 31);
INSERT INTO `role_menus` VALUES (443, '2024-09-07 17:02:16.724', '2024-09-07 17:02:16.724', '2024-09-10 11:18:28.128', 1, 47);
INSERT INTO `role_menus` VALUES (444, '2024-09-07 17:02:16.727', '2024-09-07 17:02:16.727', '2024-09-10 11:18:28.128', 1, 48);
INSERT INTO `role_menus` VALUES (445, '2024-09-07 17:02:16.729', '2024-09-07 17:02:16.729', '2024-09-10 11:18:28.128', 1, 49);
INSERT INTO `role_menus` VALUES (446, '2024-09-07 17:02:16.732', '2024-09-07 17:02:16.732', '2024-09-10 11:18:28.128', 1, 50);
INSERT INTO `role_menus` VALUES (447, '2024-09-07 17:02:16.735', '2024-09-07 17:02:16.735', '2024-09-10 11:18:28.128', 1, 51);
INSERT INTO `role_menus` VALUES (448, '2024-09-10 11:18:28.150', '2024-09-10 11:18:28.150', NULL, 1, 1);
INSERT INTO `role_menus` VALUES (449, '2024-09-10 11:18:28.154', '2024-09-10 11:18:28.154', NULL, 1, 34);
INSERT INTO `role_menus` VALUES (450, '2024-09-10 11:18:28.157', '2024-09-10 11:18:28.157', NULL, 1, 35);
INSERT INTO `role_menus` VALUES (451, '2024-09-10 11:18:28.158', '2024-09-10 11:18:28.158', NULL, 1, 3);
INSERT INTO `role_menus` VALUES (452, '2024-09-10 11:18:28.160', '2024-09-10 11:18:28.160', NULL, 1, 4);
INSERT INTO `role_menus` VALUES (453, '2024-09-10 11:18:28.161', '2024-09-10 11:18:28.161', NULL, 1, 5);
INSERT INTO `role_menus` VALUES (454, '2024-09-10 11:18:28.164', '2024-09-10 11:18:28.164', NULL, 1, 6);
INSERT INTO `role_menus` VALUES (455, '2024-09-10 11:18:28.166', '2024-09-10 11:18:28.166', NULL, 1, 7);
INSERT INTO `role_menus` VALUES (456, '2024-09-10 11:18:28.168', '2024-09-10 11:18:28.168', NULL, 1, 8);
INSERT INTO `role_menus` VALUES (457, '2024-09-10 11:18:28.171', '2024-09-10 11:18:28.171', NULL, 1, 9);
INSERT INTO `role_menus` VALUES (458, '2024-09-10 11:18:28.173', '2024-09-10 11:18:28.173', NULL, 1, 10);
INSERT INTO `role_menus` VALUES (459, '2024-09-10 11:18:28.176', '2024-09-10 11:18:28.176', NULL, 1, 11);
INSERT INTO `role_menus` VALUES (460, '2024-09-10 11:18:28.178', '2024-09-10 11:18:28.178', NULL, 1, 52);
INSERT INTO `role_menus` VALUES (461, '2024-09-10 11:18:28.181', '2024-09-10 11:18:28.181', NULL, 1, 53);
INSERT INTO `role_menus` VALUES (462, '2024-09-10 11:18:28.183', '2024-09-10 11:18:28.183', NULL, 1, 54);
INSERT INTO `role_menus` VALUES (463, '2024-09-10 11:18:28.184', '2024-09-10 11:18:28.184', NULL, 1, 12);
INSERT INTO `role_menus` VALUES (464, '2024-09-10 11:18:28.185', '2024-09-10 11:18:28.185', NULL, 1, 13);
INSERT INTO `role_menus` VALUES (465, '2024-09-10 11:18:28.187', '2024-09-10 11:18:28.187', NULL, 1, 36);
INSERT INTO `role_menus` VALUES (466, '2024-09-10 11:18:28.190', '2024-09-10 11:18:28.190', NULL, 1, 37);
INSERT INTO `role_menus` VALUES (467, '2024-09-10 11:18:28.193', '2024-09-10 11:18:28.193', NULL, 1, 38);
INSERT INTO `role_menus` VALUES (468, '2024-09-10 11:18:28.196', '2024-09-10 11:18:28.196', NULL, 1, 41);
INSERT INTO `role_menus` VALUES (469, '2024-09-10 11:18:28.198', '2024-09-10 11:18:28.198', NULL, 1, 30);
INSERT INTO `role_menus` VALUES (470, '2024-09-10 11:18:28.200', '2024-09-10 11:18:28.200', NULL, 1, 42);
INSERT INTO `role_menus` VALUES (471, '2024-09-10 11:18:28.203', '2024-09-10 11:18:28.203', NULL, 1, 43);
INSERT INTO `role_menus` VALUES (472, '2024-09-10 11:18:28.206', '2024-09-10 11:18:28.206', NULL, 1, 44);
INSERT INTO `role_menus` VALUES (473, '2024-09-10 11:18:28.209', '2024-09-10 11:18:28.209', NULL, 1, 45);
INSERT INTO `role_menus` VALUES (474, '2024-09-10 11:18:28.211', '2024-09-10 11:18:28.211', NULL, 1, 46);
INSERT INTO `role_menus` VALUES (475, '2024-09-10 11:18:28.214', '2024-09-10 11:18:28.214', NULL, 1, 31);
INSERT INTO `role_menus` VALUES (476, '2024-09-10 11:18:28.216', '2024-09-10 11:18:28.216', NULL, 1, 47);
INSERT INTO `role_menus` VALUES (477, '2024-09-10 11:18:28.219', '2024-09-10 11:18:28.219', NULL, 1, 48);
INSERT INTO `role_menus` VALUES (478, '2024-09-10 11:18:28.221', '2024-09-10 11:18:28.221', NULL, 1, 49);
INSERT INTO `role_menus` VALUES (479, '2024-09-10 11:18:28.224', '2024-09-10 11:18:28.224', NULL, 1, 50);
INSERT INTO `role_menus` VALUES (480, '2024-09-10 11:18:28.227', '2024-09-10 11:18:28.227', NULL, 1, 51);

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

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机',
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `pid` bigint NOT NULL DEFAULT 0 COMMENT '父ID',
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证号码',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_users_deleted_at`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
