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

 Date: 30/08/2024 16:32:42
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
  `user_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '100' COMMENT '用户类型：(100系统用户)',
  `nickname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `signed` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '个人签名',
  `dashboard` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '后台首页类型',
  `status` bigint NOT NULL DEFAULT 1 COMMENT '状态 (1正常 2停用)',
  `login_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '最后登陆IP',
  `backend_setting` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '后台设置数据',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `idx_admin_users_deleted_at`(`deleted_at` ASC) USING BTREE,
  INDEX `idx_admin_users_user_name`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES (1, '2024-07-11 00:00:00.000', '2024-08-19 17:25:46.000', NULL, 'superAdmin', '$2y$12$zpo8rhu.QGhb5Ty7bFTfaOYy7FfecukttS1Qn6oA2XfZ9MKTMNXJe', '100', 'superAdmin', '13888888888', 'admin@qq.com', '', '行胜于言，质胜于华。', 'statistics', 1, '127.0.0.1', '2024-07-11 00:00:00.000', '{\"mode\":\"light\",\"tag\":true,\"menuCollapse\":false,\"menuWidth\":230,\"layout\":\"classic\",\"skin\":\"mine\",\"i18n\":false,\"language\":\"zh_CN\",\"animation\":\"ma-slide-down\",\"color\":\"#165dff\",\"ws\":false}', '');

-- ----------------------------
-- Table structure for card_logs
-- ----------------------------
DROP TABLE IF EXISTS `card_logs`;
CREATE TABLE `card_logs`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `card_id` int NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of card_logs
-- ----------------------------
INSERT INTO `card_logs` VALUES (1, '卡1aaaaaa', 1, 0, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `card_logs` VALUES (2, '卡1aaaaaa', 1, 1, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `card_logs` VALUES (5, '卡2bbbbbb', 2, 1, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `card_logs` VALUES (6, '卡2bbbbbb', 2, 0, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);

-- ----------------------------
-- Table structure for info_cards
-- ----------------------------
DROP TABLE IF EXISTS `info_cards`;
CREATE TABLE `info_cards`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `info_id` int NULL DEFAULT NULL,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of info_cards
-- ----------------------------
INSERT INTO `info_cards` VALUES (1, '卡1', 1, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `info_cards` VALUES (2, '卡2', 2, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);

-- ----------------------------
-- Table structure for info_logs
-- ----------------------------
DROP TABLE IF EXISTS `info_logs`;
CREATE TABLE `info_logs`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `info_id` int NULL DEFAULT NULL,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of info_logs
-- ----------------------------
INSERT INTO `info_logs` VALUES (1, '10', 1, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `info_logs` VALUES (2, '66', 1, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `info_logs` VALUES (3, '20', 1, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `info_logs` VALUES (4, '52', 2, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);

-- ----------------------------
-- Table structure for infos
-- ----------------------------
DROP TABLE IF EXISTS `infos`;
CREATE TABLE `infos`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `age` int NOT NULL DEFAULT 0,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of infos
-- ----------------------------
INSERT INTO `infos` VALUES (1, '哈哈哈', 10, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `infos` VALUES (2, 'hhhh', 66, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `infos` VALUES (3, '哈哈哈33333', 20, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);
INSERT INTO `infos` VALUES (4, 'hhhh4444444', 52, '2024-08-09 15:22:44.000', '2024-08-09 15:22:44.000', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES (1, NULL, NULL, NULL, 0, '/home/index', 'home', '', '/home/index', 'HomeFilled', '首页', '', '', 2, 2, 1, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (2, NULL, NULL, NULL, 0, '/dataScreen', 'dataScreen', '', '/dataScreen/index', 'Histogram', '数据大屏', '', '', 2, 1, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (13, NULL, NULL, NULL, 0, '/cms', 'cms', '/cms/notice', '', 'Lollipop', '内容管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (14, NULL, NULL, NULL, 13, '/cms/notice', 'notice', '', '/cms/notice/index', 'Menu', '公告管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (15, NULL, NULL, NULL, 14, '/cms/notice/detail/:id', 'noticeDetail', '', '/cms/notice/detail', 'Menu', '公告 详情', '/cms/notice', '', 1, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (16, NULL, NULL, NULL, 14, '', 'add', '', '', '', '添加', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (17, NULL, NULL, NULL, 14, '', 'edit', '', '', '', '编辑', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (18, NULL, NULL, NULL, 14, '', 'delete', '', '', '', '删除', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (20, NULL, NULL, NULL, 14, '', 'export', '', '', '', '导出', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (22, NULL, NULL, NULL, 14, '', 'status', '', '', '', '修改状态', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (23, NULL, NULL, NULL, 14, '', 'view', '', '', '', '详情', '', '', 1, 2, 2, 2, 1, 2, 0);
INSERT INTO `menus` VALUES (24, NULL, NULL, NULL, 0, '/authority', 'authority', '/authority/menu', '', 'Lock', '权限管理', '', '', 2, 2, 2, 2, 1, 1, 0);
INSERT INTO `menus` VALUES (25, NULL, NULL, NULL, 24, '/authority/menu', 'menuAuthority', '', '/authority/menu/index', 'Menu', '菜单权限', '', '', 2, 2, 2, 2, 1, 1, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notices
-- ----------------------------
INSERT INTO `notices` VALUES (1, '2024-08-30 09:55:59.657', '2024-08-30 10:15:43.317', NULL, '公告1111', 0, 1, '<p>公告1</p>', '');
INSERT INTO `notices` VALUES (2, '2024-08-30 10:11:10.500', '2024-08-30 16:12:40.549', NULL, '公告222', 0, 1, '<p>公告222公告222公告222公告222公告222</p>', '');
INSERT INTO `notices` VALUES (3, '2024-08-30 10:11:30.438', '2024-08-30 10:11:30.438', '2024-08-30 10:11:33.181', '哈哈哈哈', 0, 1, '<p>哈哈哈哈哈哈哈哈哈哈哈哈</p>', '');
INSERT INTO `notices` VALUES (4, '2024-08-30 10:12:53.230', '2024-08-30 10:12:53.230', '2024-08-30 10:12:56.246', '山东省', 0, 1, '<p>山东省山东省山东省</p>', '');

-- ----------------------------
-- Table structure for product_orders
-- ----------------------------
DROP TABLE IF EXISTS `product_orders`;
CREATE TABLE `product_orders`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1.买入2.卖出',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1.已报2.部分完成3.已完成4已撤',
  `order_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '单号',
  `price` decimal(11, 2) NOT NULL COMMENT '价格',
  `num` int NOT NULL DEFAULT 0 COMMENT '委托数量',
  `success_num` int NOT NULL DEFAULT 0 COMMENT '成交数量',
  `surplus_num` int NULL DEFAULT NULL COMMENT '剩余数量',
  `revoke_num` int NOT NULL DEFAULT 0 COMMENT '撤回数量',
  `queue_handle_num` int NULL DEFAULT 0 COMMENT '处理次数',
  `success_handle_num` int NULL DEFAULT 0 COMMENT '成功交易次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_sn`(`order_sn` ASC) USING BTREE,
  INDEX `idx_type`(`order_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 501 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '买入卖出单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_orders
-- ----------------------------
INSERT INTO `product_orders` VALUES (1, 1, 1, '6884202304012229001767', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (2, 2, 1, '6825202304012229135426', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (3, 1, 1, '6740202304012229297122', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (4, 2, 1, '6345202304012232391890', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (5, 1, 1, '6677202304012237193663', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (6, 2, 1, '6954202304012237273984', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (7, 1, 1, '6633202304020744126995', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (8, 2, 1, '6710202304020744321649', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (9, 1, 1, '1256357202304021846532233', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (10, 1, 1, '1937700202304021954060963', 49.81, 1004, 0, 1004, 0, 0, 0);
INSERT INTO `product_orders` VALUES (11, 1, 1, '6385202304022107094206', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (12, 2, 1, '6213202304022107188728', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (13, 2, 1, '1403202304022108493491', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (14, 1, 1, '672202304022109157937', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (15, 2, 1, '6749202304022110239539', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (16, 1, 1, '1330202304022110401818', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (17, 1, 1, '36154202304030900444805', 49.81, 817, 0, 817, 0, 0, 0);
INSERT INTO `product_orders` VALUES (18, 1, 1, '766541202304030901229024', 49.81, 2046, 0, 2046, 0, 0, 0);
INSERT INTO `product_orders` VALUES (19, 1, 1, '1672301202304030901335769', 49.81, 415, 0, 415, 0, 0, 0);
INSERT INTO `product_orders` VALUES (20, 1, 1, '35330202304030903311937', 49.81, 1004, 0, 1004, 0, 0, 0);
INSERT INTO `product_orders` VALUES (21, 1, 1, '40577202304030904215857', 49.81, 2046, 0, 2046, 0, 0, 0);
INSERT INTO `product_orders` VALUES (22, 1, 1, '720852202304030904340276', 49.81, 1004, 0, 1004, 0, 0, 0);
INSERT INTO `product_orders` VALUES (23, 1, 1, '958630202304030905063206', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (24, 1, 1, '1366885202304030905119281', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (25, 1, 1, '1078277202304030906001446', 49.81, 1004, 0, 1004, 0, 0, 0);
INSERT INTO `product_orders` VALUES (26, 1, 1, '1093181202304030906032431', 49.81, 170, 0, 170, 0, 0, 0);
INSERT INTO `product_orders` VALUES (27, 1, 1, '41100202304030906131855', 49.81, 562, 0, 562, 0, 0, 0);
INSERT INTO `product_orders` VALUES (28, 1, 1, '1120562202304030906163876', 49.81, 102, 0, 102, 0, 0, 0);
INSERT INTO `product_orders` VALUES (29, 1, 1, '1109699202304030906268782', 49.81, 1004, 0, 1004, 0, 0, 0);
INSERT INTO `product_orders` VALUES (30, 1, 1, '56822202304030906392905', 49.81, 1207, 0, 1207, 0, 0, 0);
INSERT INTO `product_orders` VALUES (31, 1, 1, '136436202304030906442369', 49.81, 160, 0, 160, 0, 0, 0);
INSERT INTO `product_orders` VALUES (32, 1, 1, '1036583202304030907111054', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (33, 1, 1, '2193489202304030907310633', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (34, 1, 1, '664688202304030907356423', 49.81, 108, 0, 108, 0, 0, 0);
INSERT INTO `product_orders` VALUES (35, 1, 1, '1704596202304030907438952', 49.81, 2008, 0, 2008, 0, 0, 0);
INSERT INTO `product_orders` VALUES (36, 1, 1, '41769202304030907508690', 49.81, 201, 0, 201, 0, 0, 0);
INSERT INTO `product_orders` VALUES (37, 1, 1, '1014369202304030907528520', 49.81, 111, 0, 111, 0, 0, 0);
INSERT INTO `product_orders` VALUES (38, 1, 1, '1439497202304030907576257', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (39, 1, 1, '1885652202304030908422509', 49.81, 602, 0, 602, 0, 0, 0);
INSERT INTO `product_orders` VALUES (40, 1, 1, '1681353202304030909104210', 49.81, 1606, 0, 1606, 0, 0, 0);
INSERT INTO `product_orders` VALUES (41, 1, 1, '1590736202304030909189626', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (42, 1, 1, '948774202304030909499254', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (43, 1, 1, '1933732202304030910092470', 49.81, 194, 0, 194, 0, 0, 0);
INSERT INTO `product_orders` VALUES (44, 1, 1, '1305682202304030910156817', 49.81, 2017, 0, 2017, 0, 0, 0);
INSERT INTO `product_orders` VALUES (45, 1, 1, '1842488202304030910342355', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (46, 1, 1, '1120583202304030910548467', 49.81, 102, 0, 102, 0, 0, 0);
INSERT INTO `product_orders` VALUES (47, 1, 1, '154040202304030911204691', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (48, 1, 1, '1715594202304030911387808', 49.81, 1205, 0, 1205, 0, 0, 0);
INSERT INTO `product_orders` VALUES (49, 1, 1, '1044200202304030911415224', 49.81, 602, 0, 602, 0, 0, 0);
INSERT INTO `product_orders` VALUES (50, 1, 1, '654973202304030911528550', 49.81, 109, 0, 109, 0, 0, 0);
INSERT INTO `product_orders` VALUES (51, 1, 1, '1750940202304030911558487', 49.81, 249, 0, 249, 0, 0, 0);
INSERT INTO `product_orders` VALUES (52, 1, 1, '13285202304030912522458', 49.81, 602, 0, 602, 0, 0, 0);
INSERT INTO `product_orders` VALUES (53, 1, 1, '2053854202304030913038243', 49.81, 215, 0, 215, 0, 0, 0);
INSERT INTO `product_orders` VALUES (54, 1, 1, '883178202304030913071233', 49.81, 2017, 0, 2017, 0, 0, 0);
INSERT INTO `product_orders` VALUES (55, 1, 1, '34986202304030913079498', 49.81, 402, 0, 402, 0, 0, 0);
INSERT INTO `product_orders` VALUES (56, 1, 1, '245882202304030914365099', 49.81, 323, 0, 323, 0, 0, 0);
INSERT INTO `product_orders` VALUES (57, 1, 1, '948587202304030914464353', 49.81, 102, 0, 102, 0, 0, 0);
INSERT INTO `product_orders` VALUES (58, 1, 1, '695310202304030914588270', 49.81, 139, 0, 139, 0, 0, 0);
INSERT INTO `product_orders` VALUES (59, 1, 1, '744571202304030915153272', 49.81, 1068, 0, 1068, 0, 0, 0);
INSERT INTO `product_orders` VALUES (60, 1, 1, '1890890202304030915210163', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (61, 1, 1, '892767202304030915226468', 49.81, 1405, 0, 1405, 0, 0, 0);
INSERT INTO `product_orders` VALUES (62, 1, 1, '635198202304030915267298', 49.81, 723, 0, 723, 0, 0, 0);
INSERT INTO `product_orders` VALUES (63, 1, 1, '2185410202304030915325479', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (64, 1, 1, '930359202304030915580425', 49.81, 120, 0, 120, 0, 0, 0);
INSERT INTO `product_orders` VALUES (65, 1, 1, '2442584202304030916005342', 49.81, 109, 0, 109, 0, 0, 0);
INSERT INTO `product_orders` VALUES (66, 1, 1, '901959202304030916057189', 49.81, 431, 0, 431, 0, 0, 0);
INSERT INTO `product_orders` VALUES (67, 1, 1, '1656494202304030916221325', 49.81, 2008, 0, 2008, 0, 0, 0);
INSERT INTO `product_orders` VALUES (68, 1, 1, '1624724202304030916471598', 49.81, 484, 0, 484, 0, 0, 0);
INSERT INTO `product_orders` VALUES (69, 1, 1, '44526202304030916492394', 49.81, 1079, 0, 1079, 0, 0, 0);
INSERT INTO `product_orders` VALUES (70, 1, 1, '1181269202304030916557095', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (71, 1, 1, '2126676202304030916561931', 49.81, 1021, 0, 1021, 0, 0, 0);
INSERT INTO `product_orders` VALUES (72, 1, 1, '899421202304030917066652', 49.81, 1004, 0, 1004, 0, 0, 0);
INSERT INTO `product_orders` VALUES (73, 1, 1, '1818118202304030917581970', 49.81, 863, 0, 863, 0, 0, 0);
INSERT INTO `product_orders` VALUES (74, 1, 1, '20606202304030918259531', 49.81, 133, 0, 133, 0, 0, 0);
INSERT INTO `product_orders` VALUES (75, 1, 1, '2869517202304030918402780', 49.81, 120, 0, 120, 0, 0, 0);
INSERT INTO `product_orders` VALUES (76, 1, 1, '1581606202304030918534685', 49.81, 1004, 0, 1004, 0, 0, 0);
INSERT INTO `product_orders` VALUES (77, 1, 1, '948629202304030918597191', 49.81, 102, 0, 102, 0, 0, 0);
INSERT INTO `product_orders` VALUES (78, 1, 1, '1058481202304030919215938', 49.81, 101, 0, 101, 0, 0, 0);
INSERT INTO `product_orders` VALUES (79, 1, 1, '1636510202304030919572278', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (80, 1, 1, '2194346202304030920413285', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (81, 1, 1, '2140660202304030920487361', 49.81, 210, 0, 210, 0, 0, 0);
INSERT INTO `product_orders` VALUES (82, 1, 1, '1483903202304030920548214', 49.81, 1406, 0, 1406, 0, 0, 0);
INSERT INTO `product_orders` VALUES (83, 1, 1, '690194202304030921177315', 49.81, 204, 0, 204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (84, 1, 1, '16088202304030921475257', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (85, 1, 1, '1068132202304030922154976', 49.81, 1606, 0, 1606, 0, 0, 0);
INSERT INTO `product_orders` VALUES (86, 1, 1, '769636202304030923236948', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (87, 1, 1, '1386348202304030923394344', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (88, 1, 1, '1640952202304030923437295', 49.81, 1225, 0, 1225, 0, 0, 0);
INSERT INTO `product_orders` VALUES (89, 1, 1, '206872202304030923557671', 49.81, 448, 0, 448, 0, 0, 0);
INSERT INTO `product_orders` VALUES (90, 1, 1, '1623743202304030924187201', 49.81, 2008, 0, 2008, 0, 0, 0);
INSERT INTO `product_orders` VALUES (91, 1, 1, '2583965202304030924415242', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (92, 1, 1, '728953202304030925386848', 49.81, 1034, 0, 1034, 0, 0, 0);
INSERT INTO `product_orders` VALUES (93, 1, 1, '78619202304030925444341', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (94, 1, 1, '1088539202304030926107254', 49.81, 340, 0, 340, 0, 0, 0);
INSERT INTO `product_orders` VALUES (95, 1, 1, '1084694202304030926298021', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (96, 1, 1, '2353921202304030926536411', 49.81, 2007, 0, 2007, 0, 0, 0);
INSERT INTO `product_orders` VALUES (97, 1, 1, '776507202304030926584316', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (98, 1, 1, '2061279202304030927170935', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (99, 1, 1, '861285202304030928118268', 49.81, 146, 0, 146, 0, 0, 0);
INSERT INTO `product_orders` VALUES (100, 1, 1, '2832533202304030928133848', 49.81, 217, 0, 217, 0, 0, 0);
INSERT INTO `product_orders` VALUES (101, 1, 1, '1859252202304030929068527', 49.81, 308, 0, 308, 0, 0, 0);
INSERT INTO `product_orders` VALUES (102, 1, 1, '75280202304030929081724', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (103, 1, 1, '1218403202304030929223134', 49.81, 602, 0, 602, 0, 0, 0);
INSERT INTO `product_orders` VALUES (104, 1, 1, '2079447202304030929306343', 49.81, 263, 0, 263, 0, 0, 0);
INSERT INTO `product_orders` VALUES (105, 1, 1, '779746202304030930506339', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (106, 1, 1, '1129874202304030930576979', 49.81, 328, 0, 328, 0, 0, 0);
INSERT INTO `product_orders` VALUES (107, 1, 1, '2024188202304030931506811', 49.81, 504, 0, 504, 0, 0, 0);
INSERT INTO `product_orders` VALUES (108, 1, 1, '706480202304030932385129', 49.81, 211, 0, 211, 0, 0, 0);
INSERT INTO `product_orders` VALUES (109, 1, 1, '1248153202304030933203773', 49.81, 803, 0, 803, 0, 0, 0);
INSERT INTO `product_orders` VALUES (110, 1, 1, '2851776202304030933302464', 49.81, 1021, 0, 1021, 0, 0, 0);
INSERT INTO `product_orders` VALUES (111, 1, 1, '1744429202304030933484827', 49.81, 167, 0, 167, 0, 0, 0);
INSERT INTO `product_orders` VALUES (112, 1, 1, '632635202304030934512889', 49.81, 1041, 0, 1041, 0, 0, 0);
INSERT INTO `product_orders` VALUES (113, 1, 1, '61258202304030935228796', 49.81, 104, 0, 104, 0, 0, 0);
INSERT INTO `product_orders` VALUES (114, 1, 1, '1139228202304030935231158', 49.81, 2007, 0, 2007, 0, 0, 0);
INSERT INTO `product_orders` VALUES (115, 1, 1, '827555202304030935244346', 49.81, 1010, 0, 1010, 0, 0, 0);
INSERT INTO `product_orders` VALUES (116, 1, 1, '2739102202304030936137404', 49.81, 1204, 0, 1204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (117, 1, 1, '778469202304030938118168', 49.81, 1206, 0, 1206, 0, 0, 0);
INSERT INTO `product_orders` VALUES (118, 1, 1, '76222202304030938224185', 49.81, 505, 0, 505, 0, 0, 0);
INSERT INTO `product_orders` VALUES (119, 1, 1, '965262202304030938357545', 49.81, 215, 0, 215, 0, 0, 0);
INSERT INTO `product_orders` VALUES (120, 1, 1, '634415202304030939235486', 49.81, 110, 0, 110, 0, 0, 0);
INSERT INTO `product_orders` VALUES (121, 1, 1, '2372107202304030939364209', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (122, 1, 1, '772338202304030940059788', 49.81, 107, 0, 107, 0, 0, 0);
INSERT INTO `product_orders` VALUES (123, 1, 1, '1842613202304030941258252', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (124, 1, 1, '778634202304030941290084', 49.81, 121, 0, 121, 0, 0, 0);
INSERT INTO `product_orders` VALUES (125, 1, 1, '723945202304030941408388', 49.81, 390, 0, 390, 0, 0, 0);
INSERT INTO `product_orders` VALUES (126, 1, 1, '2755939202304030941531831', 49.81, 2001, 0, 2001, 0, 0, 0);
INSERT INTO `product_orders` VALUES (127, 1, 1, '782837202304030942119146', 49.81, 1256, 0, 1256, 0, 0, 0);
INSERT INTO `product_orders` VALUES (128, 1, 1, '1445211202304030942249173', 49.81, 408, 0, 408, 0, 0, 0);
INSERT INTO `product_orders` VALUES (129, 1, 1, '2712995202304030942556763', 49.81, 633, 0, 633, 0, 0, 0);
INSERT INTO `product_orders` VALUES (130, 1, 1, '645899202304030944004559', 49.81, 204, 0, 204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (131, 1, 1, '1408783202304030946425106', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (132, 1, 1, '2806956202304030948006479', 49.81, 118, 0, 118, 0, 0, 0);
INSERT INTO `product_orders` VALUES (133, 1, 1, '1368796202304030948447282', 49.81, 665, 0, 665, 0, 0, 0);
INSERT INTO `product_orders` VALUES (134, 1, 1, '923560202304030948467829', 49.81, 480, 0, 480, 0, 0, 0);
INSERT INTO `product_orders` VALUES (135, 1, 1, '100871202304030948592069', 49.81, 1061, 0, 1061, 0, 0, 0);
INSERT INTO `product_orders` VALUES (136, 1, 1, '2401572202304030949239325', 49.81, 2007, 0, 2007, 0, 0, 0);
INSERT INTO `product_orders` VALUES (137, 1, 1, '1261810202304030949276060', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (138, 1, 1, '2224687202304030952094667', 49.81, 239, 0, 239, 0, 0, 0);
INSERT INTO `product_orders` VALUES (139, 1, 1, '1895737202304030952351366', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (140, 1, 1, '1326967202304030953015268', 49.81, 160, 0, 160, 0, 0, 0);
INSERT INTO `product_orders` VALUES (141, 1, 1, '640270202304030953149348', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (142, 1, 1, '1485904202304030953151056', 49.81, 1807, 0, 1807, 0, 0, 0);
INSERT INTO `product_orders` VALUES (143, 1, 1, '1224970202304030953355688', 49.81, 2007, 0, 2007, 0, 0, 0);
INSERT INTO `product_orders` VALUES (144, 1, 1, '840657202304030954148983', 49.81, 205, 0, 205, 0, 0, 0);
INSERT INTO `product_orders` VALUES (145, 1, 1, '906208202304030954396892', 49.81, 402, 0, 402, 0, 0, 0);
INSERT INTO `product_orders` VALUES (146, 1, 1, '1895607202304030954495626', 49.81, 1993, 0, 1993, 0, 0, 0);
INSERT INTO `product_orders` VALUES (147, 1, 1, '2131767202304030955350083', 49.81, 394, 0, 394, 0, 0, 0);
INSERT INTO `product_orders` VALUES (148, 1, 1, '659329202304030956054210', 49.81, 212, 0, 212, 0, 0, 0);
INSERT INTO `product_orders` VALUES (149, 1, 1, '158344202304030956541427', 49.81, 680, 0, 680, 0, 0, 0);
INSERT INTO `product_orders` VALUES (150, 1, 1, '95693202304030957289443', 49.81, 1004, 0, 1004, 0, 0, 0);
INSERT INTO `product_orders` VALUES (151, 1, 1, '16421202304030957557774', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (152, 1, 1, '2346627202304030958396641', 49.81, 602, 0, 602, 0, 0, 0);
INSERT INTO `product_orders` VALUES (153, 1, 1, '884993202304030959597479', 49.81, 120, 0, 120, 0, 0, 0);
INSERT INTO `product_orders` VALUES (154, 1, 1, '71780202304031000280426', 49.81, 118, 0, 118, 0, 0, 0);
INSERT INTO `product_orders` VALUES (155, 1, 1, '2102384202304031001060297', 49.81, 431, 0, 431, 0, 0, 0);
INSERT INTO `product_orders` VALUES (156, 1, 1, '8746202304031001145514', 49.81, 310, 0, 310, 0, 0, 0);
INSERT INTO `product_orders` VALUES (157, 1, 1, '936481202304031001441250', 49.81, 402, 0, 402, 0, 0, 0);
INSERT INTO `product_orders` VALUES (158, 1, 1, '805236202304031002423011', 49.81, 1021, 0, 1021, 0, 0, 0);
INSERT INTO `product_orders` VALUES (159, 1, 1, '2913587202304031002424237', 49.81, 204, 0, 204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (160, 1, 1, '931810202304031003004264', 49.81, 402, 0, 402, 0, 0, 0);
INSERT INTO `product_orders` VALUES (161, 1, 1, '1531250202304031003129867', 49.81, 129, 0, 129, 0, 0, 0);
INSERT INTO `product_orders` VALUES (162, 1, 1, '271721202304031003529418', 49.81, 420, 0, 420, 0, 0, 0);
INSERT INTO `product_orders` VALUES (163, 1, 1, '666601202304031004073823', 49.81, 240, 0, 240, 0, 0, 0);
INSERT INTO `product_orders` VALUES (164, 1, 1, '2115416202304031004229997', 49.81, 429, 0, 429, 0, 0, 0);
INSERT INTO `product_orders` VALUES (165, 1, 1, '1952619202304031005011233', 49.81, 381, 0, 381, 0, 0, 0);
INSERT INTO `product_orders` VALUES (166, 1, 1, '23940202304031005037367', 49.81, 1079, 0, 1079, 0, 0, 0);
INSERT INTO `product_orders` VALUES (167, 1, 1, '1041342202304031005049673', 49.81, 466, 0, 466, 0, 0, 0);
INSERT INTO `product_orders` VALUES (168, 1, 1, '2482343202304031005053809', 49.81, 600, 0, 600, 0, 0, 0);
INSERT INTO `product_orders` VALUES (169, 1, 1, '1670877202304031005141295', 49.81, 803, 0, 803, 0, 0, 0);
INSERT INTO `product_orders` VALUES (170, 1, 1, '1578190202304031005347852', 49.81, 408, 0, 408, 0, 0, 0);
INSERT INTO `product_orders` VALUES (171, 1, 1, '1571933202304031005591868', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (172, 1, 1, '937527202304031008048810', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (173, 1, 1, '842341202304031009035790', 49.81, 239, 0, 239, 0, 0, 0);
INSERT INTO `product_orders` VALUES (174, 1, 1, '1266727202304031009412768', 49.81, 465, 0, 465, 0, 0, 0);
INSERT INTO `product_orders` VALUES (175, 1, 1, '1456460202304031010445184', 49.81, 425, 0, 425, 0, 0, 0);
INSERT INTO `product_orders` VALUES (176, 1, 1, '960589202304031010512043', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (177, 1, 1, '1517347202304031011078750', 49.81, 117, 0, 117, 0, 0, 0);
INSERT INTO `product_orders` VALUES (178, 1, 1, '804367202304031012117727', 49.81, 104, 0, 104, 0, 0, 0);
INSERT INTO `product_orders` VALUES (179, 1, 1, '995477202304031013011295', 49.81, 1907, 0, 1907, 0, 0, 0);
INSERT INTO `product_orders` VALUES (180, 1, 1, '2497378202304031013113988', 49.81, 1273, 0, 1273, 0, 0, 0);
INSERT INTO `product_orders` VALUES (181, 1, 1, '244989202304031013448952', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (182, 1, 1, '2449829202304031014267167', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (183, 1, 1, '2124927202304031014317137', 49.81, 429, 0, 429, 0, 0, 0);
INSERT INTO `product_orders` VALUES (184, 1, 1, '1411149202304031016116877', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (185, 1, 1, '1117366202304031017024845', 49.81, 161, 0, 161, 0, 0, 0);
INSERT INTO `product_orders` VALUES (186, 1, 1, '30909202304031017449978', 49.81, 501, 0, 501, 0, 0, 0);
INSERT INTO `product_orders` VALUES (187, 1, 1, '693754202304031018461617', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (188, 1, 1, '30995202304031019018917', 49.81, 502, 0, 502, 0, 0, 0);
INSERT INTO `product_orders` VALUES (189, 1, 1, '2016277202304031021378572', 49.81, 714, 0, 714, 0, 0, 0);
INSERT INTO `product_orders` VALUES (190, 1, 1, '2058664202304031023278063', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (191, 1, 1, '876160202304031023447978', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (192, 1, 1, '2278961202304031025423795', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (193, 1, 1, '1331704202304031026117486', 49.81, 408, 0, 408, 0, 0, 0);
INSERT INTO `product_orders` VALUES (194, 1, 1, '2278912202304031027067607', 49.81, 2007, 0, 2007, 0, 0, 0);
INSERT INTO `product_orders` VALUES (195, 1, 1, '951997202304031028425078', 49.81, 510, 0, 510, 0, 0, 0);
INSERT INTO `product_orders` VALUES (196, 1, 1, '125697202304031029249799', 49.81, 184, 0, 184, 0, 0, 0);
INSERT INTO `product_orders` VALUES (197, 1, 1, '1155649202304031030330452', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (198, 1, 1, '1171984202304031031297306', 49.81, 620, 0, 620, 0, 0, 0);
INSERT INTO `product_orders` VALUES (199, 1, 1, '2317517202304031032093651', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (200, 1, 1, '1312242202304031032322568', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (201, 1, 1, '653177202304031032323451', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (202, 1, 1, '2266908202304031032426154', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (203, 1, 1, '2077716202304031032444648', 49.81, 1065, 0, 1065, 0, 0, 0);
INSERT INTO `product_orders` VALUES (204, 1, 1, '2162534202304031033152168', 49.81, 37, 0, 37, 0, 0, 0);
INSERT INTO `product_orders` VALUES (205, 1, 1, '2264229202304031033267750', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (206, 1, 1, '6396202304031033287290', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (207, 1, 1, '1921811202304031034545035', 49.81, 120, 0, 120, 0, 0, 0);
INSERT INTO `product_orders` VALUES (208, 1, 1, '12428202304031034570473', 49.81, 1254, 0, 1254, 0, 0, 0);
INSERT INTO `product_orders` VALUES (209, 1, 1, '1312317202304031035057805', 49.81, 201, 0, 201, 0, 0, 0);
INSERT INTO `product_orders` VALUES (210, 1, 1, '79459202304031035424207', 49.81, 26, 0, 26, 0, 0, 0);
INSERT INTO `product_orders` VALUES (211, 1, 1, '1148810202304031035562185', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (212, 1, 1, '1959717202304031037456973', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (213, 1, 1, '1516152202304031038087895', 49.81, 254, 0, 254, 0, 0, 0);
INSERT INTO `product_orders` VALUES (214, 1, 1, '2543472202304031038140614', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (215, 1, 1, '191929202304031038155934', 49.81, 420, 0, 420, 0, 0, 0);
INSERT INTO `product_orders` VALUES (216, 1, 1, '1312318202304031038220273', 49.81, 201, 0, 201, 0, 0, 0);
INSERT INTO `product_orders` VALUES (217, 1, 1, '2054456202304031038365283', 49.81, 28, 0, 28, 0, 0, 0);
INSERT INTO `product_orders` VALUES (218, 1, 1, '815808202304031038412090', 49.81, 31, 0, 31, 0, 0, 0);
INSERT INTO `product_orders` VALUES (219, 1, 1, '724418202304031038565856', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (220, 1, 1, '967737202304031039227094', 49.81, 22, 0, 22, 0, 0, 0);
INSERT INTO `product_orders` VALUES (221, 1, 1, '1932748202304031040093706', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (222, 1, 1, '106027202304031040211102', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (223, 1, 1, '1245202304031040233987', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (224, 1, 1, '212571202304031040543048', 49.81, 109, 0, 109, 0, 0, 0);
INSERT INTO `product_orders` VALUES (225, 1, 1, '1086584202304031041548527', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (226, 1, 1, '2046789202304031042064545', 49.81, 104, 0, 104, 0, 0, 0);
INSERT INTO `product_orders` VALUES (227, 1, 1, '1149739202304031042398310', 49.81, 211, 0, 211, 0, 0, 0);
INSERT INTO `product_orders` VALUES (228, 1, 1, '799773202304031043067626', 49.81, 291, 0, 291, 0, 0, 0);
INSERT INTO `product_orders` VALUES (229, 1, 1, '2048203202304031044354762', 49.81, 28, 0, 28, 0, 0, 0);
INSERT INTO `product_orders` VALUES (230, 1, 1, '1467382202304031044424109', 49.81, 109, 0, 109, 0, 0, 0);
INSERT INTO `product_orders` VALUES (231, 1, 1, '1795530202304031044455873', 49.81, 72, 0, 72, 0, 0, 0);
INSERT INTO `product_orders` VALUES (232, 1, 1, '832303202304031045095351', 49.81, 85, 0, 85, 0, 0, 0);
INSERT INTO `product_orders` VALUES (233, 1, 1, '2426909202304031045379798', 49.81, 81, 0, 81, 0, 0, 0);
INSERT INTO `product_orders` VALUES (234, 1, 1, '826419202304031046002346', 49.81, 258, 0, 258, 0, 0, 0);
INSERT INTO `product_orders` VALUES (235, 1, 1, '1556939202304031046143606', 49.81, 39, 0, 39, 0, 0, 0);
INSERT INTO `product_orders` VALUES (236, 1, 1, '2548679202304031046247140', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (237, 1, 1, '661520202304031046327218', 49.81, 233, 0, 233, 0, 0, 0);
INSERT INTO `product_orders` VALUES (238, 1, 1, '1106248202304031046371468', 49.81, 637, 0, 637, 0, 0, 0);
INSERT INTO `product_orders` VALUES (239, 1, 1, '685550202304031047125838', 49.81, 49, 0, 49, 0, 0, 0);
INSERT INTO `product_orders` VALUES (240, 1, 1, '2757678202304031047559812', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (241, 1, 1, '677306202304031048408315', 49.81, 232, 0, 232, 0, 0, 0);
INSERT INTO `product_orders` VALUES (242, 1, 1, '656817202304031049009465', 49.81, 51, 0, 51, 0, 0, 0);
INSERT INTO `product_orders` VALUES (243, 1, 1, '1455928202304031049217513', 49.81, 62, 0, 62, 0, 0, 0);
INSERT INTO `product_orders` VALUES (244, 1, 1, '1380550202304031050051821', 49.81, 34, 0, 34, 0, 0, 0);
INSERT INTO `product_orders` VALUES (245, 1, 1, '1882570202304031050087642', 49.81, 64, 0, 64, 0, 0, 0);
INSERT INTO `product_orders` VALUES (246, 1, 1, '71618202304031050217154', 49.81, 44, 0, 44, 0, 0, 0);
INSERT INTO `product_orders` VALUES (247, 1, 1, '1912501202304031051086577', 49.81, 462, 0, 462, 0, 0, 0);
INSERT INTO `product_orders` VALUES (248, 1, 1, '1930860202304031051125341', 49.81, 1005, 0, 1005, 0, 0, 0);
INSERT INTO `product_orders` VALUES (249, 1, 1, '759488202304031051361223', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (250, 1, 1, '1457830202304031052087965', 49.81, 241, 0, 241, 0, 0, 0);
INSERT INTO `product_orders` VALUES (251, 1, 1, '670286202304031052193391', 49.81, 48, 0, 48, 0, 0, 0);
INSERT INTO `product_orders` VALUES (252, 1, 1, '2108805202304031052233348', 49.81, 38, 0, 38, 0, 0, 0);
INSERT INTO `product_orders` VALUES (253, 1, 1, '996761202304031052423324', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (254, 1, 1, '1786263202304031054030269', 49.81, 26, 0, 26, 0, 0, 0);
INSERT INTO `product_orders` VALUES (255, 1, 1, '72988202304031054106008', 49.81, 30, 0, 30, 0, 0, 0);
INSERT INTO `product_orders` VALUES (256, 1, 1, '1699976202304031054141862', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (257, 1, 1, '2244990202304031054176212', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (258, 1, 1, '900954202304031054421334', 49.81, 23, 0, 23, 0, 0, 0);
INSERT INTO `product_orders` VALUES (259, 1, 1, '1963158202304031055568703', 49.81, 125, 0, 125, 0, 0, 0);
INSERT INTO `product_orders` VALUES (260, 1, 1, '1316235202304031056173026', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (261, 1, 1, '2630191202304031056268914', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (262, 1, 1, '329202304031056458825', 49.81, 25, 0, 25, 0, 0, 0);
INSERT INTO `product_orders` VALUES (263, 1, 1, '685726202304031056454499', 49.81, 52, 0, 52, 0, 0, 0);
INSERT INTO `product_orders` VALUES (264, 1, 1, '1963694202304031056476107', 49.81, 12, 0, 12, 0, 0, 0);
INSERT INTO `product_orders` VALUES (265, 1, 1, '2056960202304031057051679', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (266, 1, 1, '1671962202304031057142037', 49.81, 523, 0, 523, 0, 0, 0);
INSERT INTO `product_orders` VALUES (267, 1, 1, '715927202304031057405897', 49.81, 36, 0, 36, 0, 0, 0);
INSERT INTO `product_orders` VALUES (268, 1, 1, '2069403202304031058090113', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (269, 1, 1, '2818227202304031058595562', 49.81, 27, 0, 27, 0, 0, 0);
INSERT INTO `product_orders` VALUES (270, 1, 1, '896468202304031059156677', 49.81, 30, 0, 30, 0, 0, 0);
INSERT INTO `product_orders` VALUES (271, 1, 1, '2134971202304031059305209', 49.81, 22, 0, 22, 0, 0, 0);
INSERT INTO `product_orders` VALUES (272, 1, 1, '675291202304031059329283', 49.81, 80, 0, 80, 0, 0, 0);
INSERT INTO `product_orders` VALUES (273, 1, 1, '1361791202304031100058429', 49.81, 145, 0, 145, 0, 0, 0);
INSERT INTO `product_orders` VALUES (274, 1, 1, '2801696202304031101020746', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (275, 1, 1, '1815154202304031101220776', 49.81, 27, 0, 27, 0, 0, 0);
INSERT INTO `product_orders` VALUES (276, 1, 1, '740230202304031101232584', 49.81, 400, 0, 400, 0, 0, 0);
INSERT INTO `product_orders` VALUES (277, 1, 1, '957454202304031101358963', 49.81, 26, 0, 26, 0, 0, 0);
INSERT INTO `product_orders` VALUES (278, 1, 1, '3919202304031101554519', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (279, 1, 1, '1296495202304031102481995', 49.81, 32, 0, 32, 0, 0, 0);
INSERT INTO `product_orders` VALUES (280, 1, 1, '2803507202304031103396577', 49.81, 45, 0, 45, 0, 0, 0);
INSERT INTO `product_orders` VALUES (281, 1, 1, '2396218202304031104012407', 49.81, 27, 0, 27, 0, 0, 0);
INSERT INTO `product_orders` VALUES (282, 1, 1, '2768381202304031104368187', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (283, 1, 1, '1509426202304031104523131', 49.81, 501, 0, 501, 0, 0, 0);
INSERT INTO `product_orders` VALUES (284, 1, 1, '2225532202304031104579229', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (285, 1, 1, '81202304031104597157', 49.81, 201, 0, 201, 0, 0, 0);
INSERT INTO `product_orders` VALUES (286, 1, 1, '1481531202304031105217293', 49.81, 18, 0, 18, 0, 0, 0);
INSERT INTO `product_orders` VALUES (287, 1, 1, '1077526202304031105358493', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (288, 1, 1, '2161618202304031105561159', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (289, 1, 1, '699160202304031106102761', 49.81, 44, 0, 44, 0, 0, 0);
INSERT INTO `product_orders` VALUES (290, 1, 1, '2281785202304031106105614', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (291, 1, 1, '1073423202304031106182714', 49.81, 43, 0, 43, 0, 0, 0);
INSERT INTO `product_orders` VALUES (292, 1, 1, '631642202304031106565601', 49.81, 41, 0, 41, 0, 0, 0);
INSERT INTO `product_orders` VALUES (293, 1, 1, '1980816202304031107016470', 49.81, 23, 0, 23, 0, 0, 0);
INSERT INTO `product_orders` VALUES (294, 1, 1, '691973202304031107179423', 49.81, 44, 0, 44, 0, 0, 0);
INSERT INTO `product_orders` VALUES (295, 1, 1, '71243202304031107342623', 49.81, 22, 0, 22, 0, 0, 0);
INSERT INTO `product_orders` VALUES (296, 1, 1, '1700692202304031107384959', 49.81, 160, 0, 160, 0, 0, 0);
INSERT INTO `product_orders` VALUES (297, 1, 1, '2800917202304031107567394', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (298, 1, 1, '14257202304031108180755', 49.81, 201, 0, 201, 0, 0, 0);
INSERT INTO `product_orders` VALUES (299, 1, 1, '2123231202304031108281743', 49.81, 1102, 0, 1102, 0, 0, 0);
INSERT INTO `product_orders` VALUES (300, 1, 1, '1570135202304031110162345', 49.81, 23, 0, 23, 0, 0, 0);
INSERT INTO `product_orders` VALUES (301, 1, 1, '650608202304031110189552', 49.81, 48, 0, 48, 0, 0, 0);
INSERT INTO `product_orders` VALUES (302, 1, 1, '1711258202304031110444960', 49.81, 201, 0, 201, 0, 0, 0);
INSERT INTO `product_orders` VALUES (303, 1, 1, '2029826202304031110450993', 49.81, 216, 0, 216, 0, 0, 0);
INSERT INTO `product_orders` VALUES (304, 1, 1, '2951637202304031112064753', 49.81, 60, 0, 60, 0, 0, 0);
INSERT INTO `product_orders` VALUES (305, 1, 1, '2636352202304031112531073', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (306, 1, 1, '1276403202304031114116086', 49.81, 816, 0, 816, 0, 0, 0);
INSERT INTO `product_orders` VALUES (307, 1, 1, '2210811202304031114152835', 49.81, 1053, 0, 1053, 0, 0, 0);
INSERT INTO `product_orders` VALUES (308, 1, 1, '2667695202304031114208991', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (309, 1, 1, '1420609202304031114225431', 49.81, 46, 0, 46, 0, 0, 0);
INSERT INTO `product_orders` VALUES (310, 1, 1, '1207541202304031114378409', 49.81, 1224, 0, 1224, 0, 0, 0);
INSERT INTO `product_orders` VALUES (311, 1, 1, '979918202304031115467329', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (312, 1, 1, '2001741202304031116250393', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (313, 1, 1, '2277649202304031116366260', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (314, 1, 1, '2880367202304031116429598', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (315, 1, 1, '2092281202304031116592987', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (316, 1, 1, '87119202304031117359699', 49.81, 50, 0, 50, 0, 0, 0);
INSERT INTO `product_orders` VALUES (317, 1, 1, '2798129202304031117435596', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (318, 1, 1, '2408715202304031117511485', 49.81, 22, 0, 22, 0, 0, 0);
INSERT INTO `product_orders` VALUES (319, 1, 1, '2092558202304031118188705', 49.81, 204, 0, 204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (320, 1, 1, '803870202304031118236382', 49.81, 101, 0, 101, 0, 0, 0);
INSERT INTO `product_orders` VALUES (321, 1, 1, '2080769202304031119012034', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (322, 1, 1, '1182452202304031119333704', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (323, 1, 1, '2374473202304031119444042', 49.81, 43, 0, 43, 0, 0, 0);
INSERT INTO `product_orders` VALUES (324, 1, 1, '2084384202304031119582133', 49.81, 43, 0, 43, 0, 0, 0);
INSERT INTO `product_orders` VALUES (325, 1, 1, '2581316202304031120447222', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (326, 1, 1, '2555784202304031121249755', 49.81, 1004, 0, 1004, 0, 0, 0);
INSERT INTO `product_orders` VALUES (327, 1, 1, '2802187202304031122275969', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (328, 1, 1, '152975202304031122464912', 49.81, 216, 0, 216, 0, 0, 0);
INSERT INTO `product_orders` VALUES (329, 1, 1, '1255245202304031123385213', 49.81, 30, 0, 30, 0, 0, 0);
INSERT INTO `product_orders` VALUES (330, 1, 1, '2527170202304031124070718', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (331, 1, 1, '2834130202304031124235414', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (332, 1, 1, '1267138202304031125043574', 49.81, 201, 0, 201, 0, 0, 0);
INSERT INTO `product_orders` VALUES (333, 1, 1, '2756395202304031125280399', 49.81, 612, 0, 612, 0, 0, 0);
INSERT INTO `product_orders` VALUES (334, 1, 1, '254923202304031125445716', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (335, 1, 1, '2180496202304031126281639', 49.81, 602, 0, 602, 0, 0, 0);
INSERT INTO `product_orders` VALUES (336, 1, 1, '51180202304031126536622', 49.81, 23, 0, 23, 0, 0, 0);
INSERT INTO `product_orders` VALUES (337, 1, 1, '1104918202304031126583438', 49.81, 2043, 0, 2043, 0, 0, 0);
INSERT INTO `product_orders` VALUES (338, 1, 1, '2814588202304031128588844', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (339, 1, 1, '1227177202304031130373093', 49.81, 816, 0, 816, 0, 0, 0);
INSERT INTO `product_orders` VALUES (340, 1, 1, '2884828202304031301207463', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (341, 1, 1, '2941712202304031301472032', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (342, 1, 1, '1919505202304031301534652', 49.81, 201, 0, 201, 0, 0, 0);
INSERT INTO `product_orders` VALUES (343, 1, 1, '1223326202304031302508489', 49.81, 22, 0, 22, 0, 0, 0);
INSERT INTO `product_orders` VALUES (344, 1, 1, '2934774202304031303473149', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (345, 1, 1, '914209202304031304180353', 49.81, 31, 0, 31, 0, 0, 0);
INSERT INTO `product_orders` VALUES (346, 1, 1, '1553599202304031305086823', 49.81, 30, 0, 30, 0, 0, 0);
INSERT INTO `product_orders` VALUES (347, 1, 1, '781305202304031305116324', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (348, 1, 1, '1069959202304031305520690', 49.81, 44, 0, 44, 0, 0, 0);
INSERT INTO `product_orders` VALUES (349, 1, 1, '2409188202304031306028437', 49.81, 2007, 0, 2007, 0, 0, 0);
INSERT INTO `product_orders` VALUES (350, 1, 1, '50229202304031306064707', 49.81, 2043, 0, 2043, 0, 0, 0);
INSERT INTO `product_orders` VALUES (351, 1, 1, '2454626202304031306169710', 49.81, 22, 0, 22, 0, 0, 0);
INSERT INTO `product_orders` VALUES (352, 1, 1, '17337202304031306171465', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (353, 1, 1, '231338202304031306234454', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (354, 1, 1, '2113999202304031306267802', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (355, 1, 1, '2665167202304031306321557', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (356, 1, 1, '669759202304031306405752', 49.81, 26, 0, 26, 0, 0, 0);
INSERT INTO `product_orders` VALUES (357, 1, 1, '2038880202304031306433627', 49.81, 42, 0, 42, 0, 0, 0);
INSERT INTO `product_orders` VALUES (358, 1, 1, '1473965202304031306563299', 49.81, 47, 0, 47, 0, 0, 0);
INSERT INTO `product_orders` VALUES (359, 1, 1, '1942945202304031306595959', 49.81, 209, 0, 209, 0, 0, 0);
INSERT INTO `product_orders` VALUES (360, 1, 1, '24118202304031307092986', 49.81, 1606, 0, 1606, 0, 0, 0);
INSERT INTO `product_orders` VALUES (361, 1, 1, '2031947202304031307290813', 49.81, 25, 0, 25, 0, 0, 0);
INSERT INTO `product_orders` VALUES (362, 1, 1, '1232238202304031307436371', 49.81, 204, 0, 204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (363, 1, 1, '2170669202304031307440715', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (364, 1, 1, '850990202304031307569011', 49.81, 25, 0, 25, 0, 0, 0);
INSERT INTO `product_orders` VALUES (365, 1, 1, '159532202304031307573707', 49.81, 211, 0, 211, 0, 0, 0);
INSERT INTO `product_orders` VALUES (366, 1, 1, '817732202304031308244241', 49.81, 25, 0, 25, 0, 0, 0);
INSERT INTO `product_orders` VALUES (367, 1, 1, '2389350202304031308459296', 49.81, 204, 0, 204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (368, 1, 1, '2683187202304031309023385', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (369, 1, 1, '2663692202304031309223787', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (370, 1, 1, '879129202304031309265773', 49.81, 82, 0, 82, 0, 0, 0);
INSERT INTO `product_orders` VALUES (371, 1, 1, '2870465202304031309405085', 49.81, 240, 0, 240, 0, 0, 0);
INSERT INTO `product_orders` VALUES (372, 1, 1, '1464289202304031309430689', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (373, 1, 1, '806147202304031309440735', 49.81, 23, 0, 23, 0, 0, 0);
INSERT INTO `product_orders` VALUES (374, 1, 1, '1824137202304031310252572', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (375, 1, 1, '2742256202304031310329577', 49.81, 55, 0, 55, 0, 0, 0);
INSERT INTO `product_orders` VALUES (376, 1, 1, '275346202304031310331991', 49.81, 106, 0, 106, 0, 0, 0);
INSERT INTO `product_orders` VALUES (377, 1, 1, '692211202304031310423514', 49.81, 1205, 0, 1205, 0, 0, 0);
INSERT INTO `product_orders` VALUES (378, 1, 1, '2155954202304031311126052', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (379, 1, 1, '264871202304031311164710', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (380, 1, 1, '116063202304031311215463', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (381, 1, 1, '2200550202304031311342267', 49.81, 110, 0, 110, 0, 0, 0);
INSERT INTO `product_orders` VALUES (382, 1, 1, '2965268202304031311596727', 49.81, 1840, 0, 1840, 0, 0, 0);
INSERT INTO `product_orders` VALUES (383, 1, 1, '1874515202304031312142799', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (384, 1, 1, '1388637202304031312416368', 49.81, 1206, 0, 1206, 0, 0, 0);
INSERT INTO `product_orders` VALUES (385, 1, 1, '958237202304031312571492', 49.81, 602, 0, 602, 0, 0, 0);
INSERT INTO `product_orders` VALUES (386, 1, 1, '2370473202304031313266057', 49.81, 92, 0, 92, 0, 0, 0);
INSERT INTO `product_orders` VALUES (387, 1, 1, '2105411202304031313433968', 49.81, 67, 0, 67, 0, 0, 0);
INSERT INTO `product_orders` VALUES (388, 1, 1, '2859878202304031314277453', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (389, 1, 1, '86782202304031314321308', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (390, 1, 1, '966556202304031315042008', 49.81, 1205, 0, 1205, 0, 0, 0);
INSERT INTO `product_orders` VALUES (391, 1, 1, '867350202304031316416267', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (392, 1, 1, '1029610202304031317386834', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (393, 1, 1, '2965764202304031317457359', 49.81, 1806, 0, 1806, 0, 0, 0);
INSERT INTO `product_orders` VALUES (394, 1, 1, '90324202304031317511726', 49.81, 604, 0, 604, 0, 0, 0);
INSERT INTO `product_orders` VALUES (395, 1, 1, '2776546202304031317577957', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (396, 1, 1, '1269972202304031318006546', 49.81, 63, 0, 63, 0, 0, 0);
INSERT INTO `product_orders` VALUES (397, 1, 1, '2744195202304031318015770', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (398, 1, 1, '777649202304031318235236', 49.81, 52, 0, 52, 0, 0, 0);
INSERT INTO `product_orders` VALUES (399, 1, 1, '1022592202304031318521595', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (400, 1, 1, '2542828202304031319279673', 49.81, 204, 0, 204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (401, 1, 1, '2430892202304031319323743', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (402, 1, 1, '1625939202304031319446378', 49.81, 103, 0, 103, 0, 0, 0);
INSERT INTO `product_orders` VALUES (403, 1, 1, '1004534202304031319505502', 49.81, 44, 0, 44, 0, 0, 0);
INSERT INTO `product_orders` VALUES (404, 1, 1, '1504927202304031320480122', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (405, 1, 1, '1693828202304031321298651', 49.81, 102, 0, 102, 0, 0, 0);
INSERT INTO `product_orders` VALUES (406, 1, 1, '781846202304031321334767', 49.81, 482, 0, 482, 0, 0, 0);
INSERT INTO `product_orders` VALUES (407, 1, 1, '1209296202304031322278086', 49.81, 1405, 0, 1405, 0, 0, 0);
INSERT INTO `product_orders` VALUES (408, 1, 1, '2746635202304031322421716', 49.81, 47, 0, 47, 0, 0, 0);
INSERT INTO `product_orders` VALUES (409, 1, 1, '2101265202304031322525678', 49.81, 23, 0, 23, 0, 0, 0);
INSERT INTO `product_orders` VALUES (410, 1, 1, '1798456202304031322587120', 49.81, 602, 0, 602, 0, 0, 0);
INSERT INTO `product_orders` VALUES (411, 1, 1, '1518376202304031323161443', 49.81, 604, 0, 604, 0, 0, 0);
INSERT INTO `product_orders` VALUES (412, 1, 1, '1695945202304031323191013', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (413, 1, 1, '670610202304031323245717', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (414, 1, 1, '2821951202304031324021107', 49.81, 100, 0, 100, 0, 0, 0);
INSERT INTO `product_orders` VALUES (415, 1, 1, '93675202304031324032763', 49.81, 402, 0, 402, 0, 0, 0);
INSERT INTO `product_orders` VALUES (416, 1, 1, '154513202304031324245436', 49.81, 132, 0, 132, 0, 0, 0);
INSERT INTO `product_orders` VALUES (417, 1, 1, '2196393202304031324322138', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (418, 1, 1, '739881202304031325265761', 49.81, 88, 0, 88, 0, 0, 0);
INSERT INTO `product_orders` VALUES (419, 1, 1, '1342493202304031325464893', 49.81, 411, 0, 411, 0, 0, 0);
INSERT INTO `product_orders` VALUES (420, 1, 1, '2048726202304031325546990', 49.81, 40, 0, 40, 0, 0, 0);
INSERT INTO `product_orders` VALUES (421, 1, 1, '1908881202304031326023546', 49.81, 42, 0, 42, 0, 0, 0);
INSERT INTO `product_orders` VALUES (422, 1, 1, '182052202304031326303725', 49.81, 318, 0, 318, 0, 0, 0);
INSERT INTO `product_orders` VALUES (423, 1, 1, '1579301202304031326346340', 49.81, 647, 0, 647, 0, 0, 0);
INSERT INTO `product_orders` VALUES (424, 1, 1, '749102202304031327294743', 49.81, 22, 0, 22, 0, 0, 0);
INSERT INTO `product_orders` VALUES (425, 1, 1, '1562971202304031327379581', 49.81, 1782, 0, 1782, 0, 0, 0);
INSERT INTO `product_orders` VALUES (426, 1, 1, '1740763202304031328130464', 49.81, 41, 0, 41, 0, 0, 0);
INSERT INTO `product_orders` VALUES (427, 1, 1, '768995202304031328237850', 49.81, 24, 0, 24, 0, 0, 0);
INSERT INTO `product_orders` VALUES (428, 1, 1, '2183415202304031328564709', 49.81, 21, 0, 21, 0, 0, 0);
INSERT INTO `product_orders` VALUES (429, 1, 1, '1806845202304031330227862', 49.81, 103, 0, 103, 0, 0, 0);
INSERT INTO `product_orders` VALUES (430, 1, 1, '712725202304031330538997', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (431, 1, 1, '740750202304031331187796', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (432, 1, 1, '2187836202304031331460213', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (433, 1, 1, '1435499202304031332580537', 49.81, 2007, 0, 2007, 0, 0, 0);
INSERT INTO `product_orders` VALUES (434, 1, 1, '1100563202304031333220756', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (435, 1, 1, '1300854202304031333506366', 49.81, 116, 0, 116, 0, 0, 0);
INSERT INTO `product_orders` VALUES (436, 1, 1, '663551202304031334107959', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (437, 1, 1, '2237990202304031334361043', 49.81, 240, 0, 240, 0, 0, 0);
INSERT INTO `product_orders` VALUES (438, 1, 1, '2785523202304031334428942', 49.81, 401, 0, 401, 0, 0, 0);
INSERT INTO `product_orders` VALUES (439, 1, 1, '2358194202304031335023195', 49.81, 2007, 0, 2007, 0, 0, 0);
INSERT INTO `product_orders` VALUES (440, 1, 1, '1825481202304031335183967', 49.81, 204, 0, 204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (441, 1, 1, '969483202304031335305577', 49.81, 2007, 0, 2007, 0, 0, 0);
INSERT INTO `product_orders` VALUES (442, 1, 1, '1135834202304031336004878', 49.81, 602, 0, 602, 0, 0, 0);
INSERT INTO `product_orders` VALUES (443, 1, 1, '709129202304031336293027', 49.81, 1204, 0, 1204, 0, 0, 0);
INSERT INTO `product_orders` VALUES (444, 1, 1, '1870476202304031337274223', 49.81, 651, 0, 651, 0, 0, 0);
INSERT INTO `product_orders` VALUES (445, 1, 1, '1760230202304031337434738', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (446, 1, 1, '2247234202304031337454212', 49.81, 31, 0, 31, 0, 0, 0);
INSERT INTO `product_orders` VALUES (447, 1, 1, '991629202304031338024887', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (448, 1, 1, '765197202304031338162751', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (449, 1, 1, '1202258202304031338179652', 49.81, 711, 0, 711, 0, 0, 0);
INSERT INTO `product_orders` VALUES (450, 1, 1, '1110660202304031338515124', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (451, 1, 1, '1058905202304031339031586', 49.81, 102, 0, 102, 0, 0, 0);
INSERT INTO `product_orders` VALUES (452, 1, 1, '1760129202304031340290007', 49.81, 20, 0, 20, 0, 0, 0);
INSERT INTO `product_orders` VALUES (453, 1, 1, '1653674202304031340392181', 49.81, 26, 0, 26, 0, 0, 0);
INSERT INTO `product_orders` VALUES (454, 1, 1, '2195536202304031340490498', 49.81, 19, 0, 19, 0, 0, 0);
INSERT INTO `product_orders` VALUES (455, 1, 1, '778668202304031340513958', 49.81, 1206, 0, 1206, 0, 0, 0);
INSERT INTO `product_orders` VALUES (456, 1, 1, '1707136202304031341132332', 49.81, 200, 0, 200, 0, 0, 0);
INSERT INTO `product_orders` VALUES (457, 1, 1, '20988202304031341185197', 49.81, 409, 0, 409, 0, 0, 0);
INSERT INTO `product_orders` VALUES (458, 1, 1, '1561673202304031341287833', 49.81, 22, 0, 22, 0, 0, 0);
INSERT INTO `product_orders` VALUES (459, 1, 1, '214823202304031342054269', 49.81, 1184, 0, 1184, 0, 0, 0);
INSERT INTO `product_orders` VALUES (460, 1, 1, '2254336202304031342119032', 49.81, 31, 0, 31, 0, 0, 0);
INSERT INTO `product_orders` VALUES (461, 1, 1, '1326593202304031342228102', 49.81, 160, 0, 160, 0, 0, 0);
INSERT INTO `product_orders` VALUES (462, 1, 1, '893415202304031342485409', 49.81, 803, 0, 803, 0, 0, 0);
INSERT INTO `product_orders` VALUES (463, 1, 1, '1660403202304031343051580', 49.81, 1003, 0, 1003, 0, 0, 0);
INSERT INTO `product_orders` VALUES (464, 1, 1, '991176202304031343085559', 49.81, 208, 0, 208, 0, 0, 0);
INSERT INTO `product_orders` VALUES (465, 1, 1, '1538810202304031343490318', 49.81, 36, 0, 36, 0, 0, 0);
INSERT INTO `product_orders` VALUES (466, 2, 1, '1716202304210956081869', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (467, 1, 1, '1130202304211003267535', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (468, 1, 1, '6676202305271430125219', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (469, 2, 1, '6380202305271430158166', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (470, 1, 1, '543202308181444168757', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (471, 1, 1, '576202308181444582421', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (472, 1, 1, '2979805202308280033159190', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (473, 1, 1, '2979670202308280033465236', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (474, 1, 1, '2979588202308290242127686', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (475, 1, 1, '5533202308291659244189', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (476, 1, 1, '2980951202309101632456728', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (477, 1, 1, '2980366202309101635173618', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (478, 1, 1, '1998202309110904301975', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (479, 2, 1, '1669202309110904451367', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (480, 1, 1, '164202309120859267369', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (481, 1, 1, '1910202309120905563276', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (482, 2, 1, '1196202309120906132019', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (483, 1, 1, '1271202309120925445435', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (484, 2, 1, '1703202309120925479623', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (485, 1, 1, '1985202309120929425926', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (486, 2, 1, '1486202309120929455866', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (487, 1, 1, '1914202309120930144504', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (488, 2, 1, '1474202309120930173523', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (489, 1, 1, '1609202309120930558074', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (490, 2, 1, '1491202309120930589389', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (491, 1, 1, '1846202309120931183091', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (492, 2, 1, '1104202309120931204722', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (493, 1, 1, '1984202309120941001996', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (494, 2, 1, '130202309120941021999', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (495, 1, 1, '1658202309131040428577', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (496, 2, 1, '1768202309131040458312', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (497, 1, 1, '2977222202309132333055008', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (498, 2, 1, '2976807202309132339485493', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (499, 1, 1, '2975958202309132345337149', 49.81, 10, 0, 10, 0, 0, 0);
INSERT INTO `product_orders` VALUES (500, 2, 1, '2974379202309132348137292', 49.81, 10, 0, 10, 0, 0, 0);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '产品名',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态:1-上架，2-下架',
  `stock` bigint NOT NULL DEFAULT 0 COMMENT '库存',
  `price` decimal(10, 2) NOT NULL COMMENT '价格',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_products_deleted_at`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, '2024-08-26 16:37:56.737', '2024-08-26 16:44:19.283', NULL, '产品1', 1, 10, 88.00);
INSERT INTO `products` VALUES (2, '2024-08-26 16:38:14.947', '2024-08-26 16:38:14.947', NULL, '产品2', 1, 900, 9.99);
INSERT INTO `products` VALUES (3, '2024-08-26 16:46:49.702', '2024-08-26 16:46:49.702', '2024-08-26 16:47:02.757', '产品3', 1, 900, 9.99);
INSERT INTO `products` VALUES (4, '2024-08-26 16:46:52.977', '2024-08-26 16:46:52.977', NULL, '产品4', 1, 900, 9.99);
INSERT INTO `products` VALUES (5, '2024-08-26 16:46:55.108', '2024-08-27 17:55:53.722', NULL, '产品1', 1, 10, 88.00);
INSERT INTO `products` VALUES (6, '2024-08-26 16:53:29.787', '2024-08-26 16:53:29.787', NULL, '产品6', 1, 900, 9.99);
INSERT INTO `products` VALUES (7, '2024-08-26 16:53:34.929', '2024-08-26 16:53:34.929', NULL, '产品7', 1, 900, 9.99);
INSERT INTO `products` VALUES (8, '2024-08-27 17:13:12.073', '2024-08-27 17:13:12.073', NULL, '产品5', 1, 900, 9.99);
INSERT INTO `products` VALUES (9, '2024-08-27 17:56:03.935', '2024-08-27 17:56:03.935', NULL, '产品1', 1, 10, 88.00);
INSERT INTO `products` VALUES (10, '2024-08-27 17:56:09.749', '2024-08-27 17:56:09.749', NULL, '产品100', 1, 10, 88.00);
INSERT INTO `products` VALUES (11, '2024-08-27 17:56:38.377', '2024-08-27 17:56:38.377', NULL, '产品100', 1, 10, 88.00);
INSERT INTO `products` VALUES (12, '2024-08-27 17:56:43.361', '2024-08-27 17:56:43.361', '2024-08-27 17:57:16.490', '产品100山东省', 1, 10, 88.00);

SET FOREIGN_KEY_CHECKS = 1;
