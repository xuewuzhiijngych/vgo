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

 Date: 08/11/2024 16:13:46
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
  UNIQUE INDEX `idx_username_deletedat`(`username` ASC) USING BTREE,
  INDEX `idx_admin_users_user_name`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES (1, '2024-07-11 00:00:00.000', '2024-08-19 17:25:46.000', 'superAdmin', '$2a$10$H6/FynuF4p0BT2jd4aAEIuiY3MMIr1cPdzJKZ5iMDg4/dCPxNrHz2', '100', 'superAdmin', '13888888888', 'admin@qq.com', '', '行胜于言，质胜于华。', 'statistics', 1, '127.0.0.1', '{\"mode\":\"light\",\"tag\":true,\"menuCollapse\":false,\"menuWidth\":230,\"layout\":\"classic\",\"skin\":\"mine\",\"i18n\":false,\"language\":\"zh_CN\",\"animation\":\"ma-slide-down\",\"color\":\"#165dff\",\"ws\":false}', '', 1);

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `status` smallint NOT NULL DEFAULT 1 COMMENT '状态 (1启用 2禁用)',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '公告内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of articles
-- ----------------------------
INSERT INTO `articles` VALUES (13, '2024-10-31 16:40:40.371', '2024-11-04 14:17:37.689', '哈哈哈哈1', 1, '<p>哈哈哈哈哈哈哈哈哈哈哈哈1</p>');
INSERT INTO `articles` VALUES (14, '2024-10-31 16:41:04.846', '2024-11-04 15:54:49.416', '哈哈哈哈2哈哈哈哈2', 1, '<p>哈哈哈哈2哈哈哈哈2哈哈哈哈2哈哈哈哈2哈哈哈哈2</p>');

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
) ENGINE = InnoDB AUTO_INCREMENT = 371 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of casbin_rule
-- ----------------------------
INSERT INTO `casbin_rule` VALUES (370, 'p', 'admin', '/backend/buttons', 'GET', '', '', '');
INSERT INTO `casbin_rule` VALUES (369, 'p', 'admin', '/backend/menus', 'GET', '', '', '');

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由访问路径',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由name',
  `redirect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由重定向地址',
  `api` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '请求接口地址',
  `act` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求方式',
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES (1, NULL, '2024-11-04 14:07:32.892', 0, '/home/index', 'home', '', '', 'GET', '/home/index', 'HomeFilled', '首页', '', '', 2, 2, 1, 2, 1, 1, 99);
INSERT INTO `menus` VALUES (3, NULL, NULL, 0, '/cms', 'cms', '/cms/notice', '', '', '', 'Lollipop', '内容管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (4, NULL, '2024-11-04 11:32:35.063', 3, '/cms/notice', 'notice', '', '/backend/notices', 'GET', '/cms/notice/index', 'Menu', '公告管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (5, NULL, NULL, 4, '/cms/notice/detail/:id', 'noticeDetail', '', '', '', '/cms/notice/detail', 'Menu', '公告 详情', '/cms/notice', '', 1, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (6, NULL, '2024-11-04 11:31:44.123', 4, '', 'create', '', '/backend/notices', 'POST', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (7, NULL, '2024-11-04 11:33:44.041', 4, '', 'update', '', '/backend/notices', 'PUT', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (8, NULL, '2024-11-04 11:33:47.909', 4, '', 'delete', '', '/backend/notices', 'DELETE', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (10, NULL, '2024-11-04 11:40:03.682', 4, '', 'change', '', '/backend/notices/change', 'POST', '', '', '修改状态', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (12, NULL, '2024-09-02 15:59:39.192', 0, '/authority', 'authority', '/authority/menu', '', '', '', 'Lock', '权限管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (13, NULL, '2024-09-02 17:18:24.867', 12, '/authority/menu', 'menuAuthority', '', '', '', '/authority/menu/index', 'Menu', '菜单权限', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (30, '2024-09-02 10:35:03.467', '2024-11-04 11:46:41.797', 12, '/authority/admin_user', 'adminUser', '', '/backend/users', 'GET', '/authority/admin_user/index', 'Avatar', '管理员', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (31, '2024-09-02 16:10:02.983', '2024-11-04 11:45:03.431', 12, '/authority/role', 'role', '', '/backend/roles', 'GET', '/authority/role/index', 'Stamp', '角色管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (34, '2024-09-03 10:28:22.793', '2024-11-04 11:31:23.293', 1, '', 'none', '', '/backend/menus', 'GET', '', '', '用户菜单数据源', '', '', 1, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (35, '2024-09-03 10:28:53.299', '2024-11-04 11:31:26.915', 1, '', 'none', '', '/backend/buttons', 'GET', '', '', '用户按钮数据源', '', '', 1, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (36, NULL, '2024-11-04 11:46:53.547', 13, '', 'create', '', '/backend/menus', 'POST', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (37, NULL, '2024-11-04 11:48:18.520', 13, '', 'update', '', '/backend/menus', 'PUT', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (38, NULL, '2024-11-04 11:48:21.419', 13, '', 'delete', '', '/backend/menus', 'DELETE', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (42, NULL, '2024-11-04 11:46:38.651', 30, '', 'create', '', '/backend/users', 'POST', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (43, NULL, '2024-11-04 11:46:35.643', 30, '', 'update', '', '/backend/users', 'PUT', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (44, NULL, '2024-11-04 11:46:32.784', 30, '', 'delete', '', '/backend/users', 'DELETE', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (45, NULL, '2024-11-04 11:46:28.277', 30, '', 'role', '', '/backend/users/get/role', 'POST', '', '', '查看角色', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (46, NULL, '2024-11-04 11:46:25.212', 30, '', 'role', '', '/backend/users/set/role', 'POST', '', '', '设置角色', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (47, NULL, '2024-11-04 11:45:09.579', 31, '', 'create', '', '/backend/roles', 'POST', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (48, NULL, '2024-11-04 13:07:14.315', 31, '', 'update', '', '/backend/roles', 'PUT', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (49, NULL, '2024-11-04 13:07:18.462', 31, '', 'delete', '', '/backend/roles', 'DELETE', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (50, NULL, '2024-11-04 11:46:02.201', 31, '', 'authority', '', '/backend/roles/set/menu', 'POST', '', '', '查看角色', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (51, NULL, '2024-11-04 11:46:05.540', 31, '', 'authority', '', '/backend/roles/get/menu', 'POST', '', '', '设置角色', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (52, NULL, '2024-11-04 11:34:18.637', 3, '/cms/upload', 'upload', '', '', '', '/cms/upload/index', 'Upload', '文件上传', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (53, NULL, '2024-11-04 14:13:59.287', 52, '', 'upload-img', '', '/backend/upload/local/img', 'POST', '', '', '图片上传', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (54, NULL, '2024-11-04 14:14:07.684', 52, '', 'upload-video', '', '/backend/upload/local/video', 'POST', '', '', '视频上传', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (55, '2024-10-31 16:31:36.808', '2024-11-04 11:35:23.780', 3, '/cms/article', 'article', '', '/backend/articles', 'GET', '/cms/article/index', 'Burger', '文章示例', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (56, NULL, '2024-11-04 11:35:27.869', 55, '', 'create', '', '/backend/articles', 'POST', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (57, NULL, '2024-11-04 11:35:38.638', 55, '', 'update', '', '/backend/articles', 'PUT', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (58, NULL, '2024-11-04 11:35:42.685', 55, '', 'delete', '', '/backend/articles', 'DELETE', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (60, NULL, '2024-11-04 14:14:50.351', 55, '', 'change', '', '/backend/articles/change', 'POST', '', '', '修改状态', '', '', 1, 2, 2, 2, 1, 2, 0);

-- ----------------------------
-- Table structure for notices
-- ----------------------------
DROP TABLE IF EXISTS `notices`;
CREATE TABLE `notices`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `status` smallint NOT NULL DEFAULT 1 COMMENT '状态 (1启用 2禁用)',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '公告内容',
  `deleted_at` bigint UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `udx_title`(`title` ASC, `deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notices
-- ----------------------------
INSERT INTO `notices` VALUES (1, '2024-11-04 14:42:30.404', '2024-11-04 14:42:30.404', '111', 1, '<p>111111111</p>', 1730702636);
INSERT INTO `notices` VALUES (5, '2024-11-04 14:43:59.083', '2024-11-04 15:55:33.405', '333333333', 1, '<p>333333333333333</p>', 0);

-- ----------------------------
-- Table structure for role_menus
-- ----------------------------
DROP TABLE IF EXISTS `role_menus`;
CREATE TABLE `role_menus`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `role_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  `menu_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1262 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menus
-- ----------------------------
INSERT INTO `role_menus` VALUES (1259, '2024-11-04 17:01:47.346', '2024-11-04 17:01:47.346', 10, 1);
INSERT INTO `role_menus` VALUES (1260, '2024-11-04 17:01:47.351', '2024-11-04 17:01:47.351', 10, 34);
INSERT INTO `role_menus` VALUES (1261, '2024-11-04 17:01:47.355', '2024-11-04 17:01:47.355', 10, 35);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色代码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_roles_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (10, '2024-11-04 15:57:19.174', '2024-11-04 15:57:19.174', '管理员', 'admin');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机',
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `pid` bigint NOT NULL DEFAULT 0 COMMENT '父ID',
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证号码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
