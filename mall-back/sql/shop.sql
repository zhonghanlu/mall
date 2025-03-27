/*
 Navicat Premium Data Transfer

 Source Server         : mysql8.3
 Source Server Type    : MySQL
 Source Server Version : 80300 (8.3.0)
 Source Host           : localhost:3307
 Source Schema         : shop

 Target Server Type    : MySQL
 Target Server Version : 80300 (8.3.0)
 File Encoding         : 65001

 Date: 21/02/2025 17:51:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'shop_logistics', '物流信息表', NULL, NULL, 'ShopLogistics', 'crud', 'element-plus', 'com.ruoyi.system', 'system', 'logistics', '物流信息', 'baq', '0', '/', '{\"parentMenuId\":2004}', 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55', '物流信息表');
INSERT INTO `gen_table` VALUES (2, 'shop_order', '订单信息', NULL, NULL, 'ShopOrder', 'crud', 'element-plus', 'com.ruoyi.system', 'system', 'order', '订单信息', 'baq', '0', '/', '{\"parentMenuId\":2004}', 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02', NULL);
INSERT INTO `gen_table` VALUES (3, 'shop_product_label', '', NULL, NULL, 'ShopProductLabel', 'crud', '', 'com.ruoyi.system', 'system', 'label', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2025-02-17 14:43:20', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (4, 'shop_order_product', '', NULL, NULL, 'ShopOrderProduct', 'crud', '', 'com.ruoyi.system', 'system', 'product', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2025-02-18 15:07:03', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', '主键id', 'bigint', 'Long', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (2, 1, 'order_id', '关联订单id', 'bigint', 'Long', 'orderId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (3, 1, 'logistics_name', '物流名称', 'varchar(255)', 'String', 'logisticsName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (4, 1, 'logistics_time', '配送时间', 'datetime', 'Date', 'logisticsTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (5, 1, 'logistics_price', '配送价格', 'bigint', 'Long', 'logisticsPrice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (6, 1, 'del_flag', '删除标识', 'char(1)', 'String', 'delFlag', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (7, 1, 'create_by', '创建人', 'varchar(255)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (8, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (9, 1, 'update_by', '修改人', 'varchar(255)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (10, 1, 'update_time', '修改时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:38:55');
INSERT INTO `gen_table_column` VALUES (11, 2, 'id', '主键id', 'bigint', 'Long', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (12, 2, 'place_order_name', '下单人姓名', 'varchar(100)', 'String', 'placeOrderName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (13, 2, 'order_status', '订单状态', 'int', 'Long', 'orderStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 3, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (14, 2, 'order_address', '订单地址', 'text', 'String', 'orderAddress', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (15, 2, 'order_phone', '订单电话', 'varchar(100)', 'String', 'orderPhone', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (16, 2, 'order_time', '订单时间', 'datetime', 'Date', 'orderTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (17, 2, 'del_flag', '删除标识', 'char(1)', 'String', 'delFlag', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (18, 2, 'create_by', '创建人', 'varchar(255)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (19, 2, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (20, 2, 'update_by', '修改人', 'varchar(255)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (21, 2, 'update_time', '修改时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2025-02-17 13:36:51', '', '2025-02-17 13:39:02');
INSERT INTO `gen_table_column` VALUES (22, 3, 'id', '主键id', 'bigint', 'Long', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-17 14:43:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (23, 3, 'label_id', '标签id', 'bigint', 'Long', 'labelId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-02-17 14:43:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (24, 3, 'product_id', '商品id', 'bigint', 'Long', 'productId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-02-17 14:43:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (25, 4, 'id', '主键id', 'bigint', 'Long', 'id', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-18 15:07:03', '', NULL);
INSERT INTO `gen_table_column` VALUES (26, 4, 'product_id', '商品id', 'bigint', 'Long', 'productId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-02-18 15:07:03', '', NULL);
INSERT INTO `gen_table_column` VALUES (27, 4, 'order_id', '订单id', 'bigint', 'Long', 'orderId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-02-18 15:07:03', '', NULL);

-- ----------------------------
-- Table structure for shop_category
-- ----------------------------
DROP TABLE IF EXISTS `shop_category`;
CREATE TABLE `shop_category`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_category
-- ----------------------------
INSERT INTO `shop_category` VALUES (1663201664040992, '数码');
INSERT INTO `shop_category` VALUES (1663201672429600, '母婴');
INSERT INTO `shop_category` VALUES (1663201695498272, '情趣');
INSERT INTO `shop_category` VALUES (1663657192718368, '测试 A');
INSERT INTO `shop_category` VALUES (1663657215787040, '测试 B');
INSERT INTO `shop_category` VALUES (1663657228369952, '测试 C');

-- ----------------------------
-- Table structure for shop_label
-- ----------------------------
DROP TABLE IF EXISTS `shop_label`;
CREATE TABLE `shop_label`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `label_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_label
-- ----------------------------
INSERT INTO `shop_label` VALUES (1663202349809696, '科技');
INSERT INTO `shop_label` VALUES (1663202366586912, '电子');
INSERT INTO `shop_label` VALUES (1663202383364128, '婴儿');
INSERT INTO `shop_label` VALUES (1663657245147168, '测试 A');
INSERT INTO `shop_label` VALUES (1663657257730080, '测试 B');

-- ----------------------------
-- Table structure for shop_logistics
-- ----------------------------
DROP TABLE IF EXISTS `shop_logistics`;
CREATE TABLE `shop_logistics`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `order_id` bigint NULL DEFAULT NULL COMMENT '关联订单id',
  `logistics_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流名称',
  `logistics_time` datetime NULL DEFAULT NULL COMMENT '配送时间',
  `logistics_price` bigint NULL DEFAULT NULL COMMENT '配送价格',
  `logistics_status` int NULL DEFAULT NULL COMMENT '发货状态',
  `logistics_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '配送地址',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除标识',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_logistics
-- ----------------------------
INSERT INTO `shop_logistics` VALUES (1663410982879264, 1663223707205664, '顺丰', '2025-02-18 00:00:00', 22, 3, '江苏省徐州市', '0', NULL, NULL, NULL, '2025-02-18 14:52:09');
INSERT INTO `shop_logistics` VALUES (1663411175817248, 1663386502823968, '顺丰', '2025-02-18 14:44:18', 5, 3, '江苏省徐州市沛县', '0', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for shop_order
-- ----------------------------
DROP TABLE IF EXISTS `shop_order`;
CREATE TABLE `shop_order`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `place_order_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下单人姓名',
  `order_status` int NULL DEFAULT NULL COMMENT '订单状态',
  `order_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '订单地址',
  `order_phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单电话',
  `order_time` datetime NULL DEFAULT NULL COMMENT '订单时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除标识',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_order
-- ----------------------------
INSERT INTO `shop_order` VALUES (1663223707205664, '123', 4, '123', '123123', '2025-02-05 00:00:00', '0', NULL, '2025-02-17 13:54:26', NULL, '2025-02-17 13:54:35');
INSERT INTO `shop_order` VALUES (1663386502823968, '222', 4, '222', '2222', '2025-02-21 00:00:00', '0', NULL, '2025-02-18 11:28:14', NULL, '2025-02-18 14:05:48');
INSERT INTO `shop_order` VALUES (1663796730921024, '若依', 0, '', '15888888888', '2025-02-20 17:48:25', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663796902887488, '若依', 0, '', '15888888888', '2025-02-20 17:49:48', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663797085339712, '若依', 0, '', '15888888888', '2025-02-20 17:51:15', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663914039312448, '若依', 0, '', '15888888888', '2025-02-21 09:20:43', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663914039312512, '若依', 0, '', '15888888888', '2025-02-21 09:20:43', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663914056089664, '若依', 0, '', '15888888888', '2025-02-21 09:20:50', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663914563600448, '若依', 0, '', '15888888888', '2025-02-21 09:24:52', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663955153977408, '若依', 0, '', '15888888888', '2025-02-21 14:47:27', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663957177729088, '若依', 0, '', '15888888888', '2025-02-21 15:03:32', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663957282586688, '若依', 0, '', '15888888888', '2025-02-21 15:04:23', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663957576187968, '若依', 0, '', '15888888888', '2025-02-21 15:06:43', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663958138224704, '若依', 0, '', '15888888888', '2025-02-21 15:11:11', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663958150807616, '若依', 0, '', '15888888888', '2025-02-21 15:11:16', '0', NULL, NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663962336723008, '柏安琪', 0, '', '15888888888', '2025-02-21 15:44:33', '0', '1', NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663968051462208, '柏安琪', 0, '', '15888888888', '2025-02-21 16:29:57', '0', '1', NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663973011226688, '柏安琪', 0, '', '15888888888', '2025-02-21 17:09:23', '0', '1', NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663975123058752, '柏安琪', 0, '', '15888888888', '2025-02-21 17:26:10', '0', '1', NULL, NULL, NULL);
INSERT INTO `shop_order` VALUES (1663978178609216, '柏安琪', 0, '', '15888888888', '2025-02-21 17:50:26', '0', '1', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for shop_order_product
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_product`;
CREATE TABLE `shop_order_product`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `product_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单id',
  `quantity` bigint NULL DEFAULT NULL COMMENT '商品数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_order_product
-- ----------------------------
INSERT INTO `shop_order_product` VALUES (1, 1663242589962272, 1663223707205664, 1);
INSERT INTO `shop_order_product` VALUES (2, 1663248101277728, 1663223707205664, 1);
INSERT INTO `shop_order_product` VALUES (3, 1663385993216032, 1663223707205664, 1);
INSERT INTO `shop_order_product` VALUES (1663796730920992, 1663242589962272, 1663796730921024, 1);
INSERT INTO `shop_order_product` VALUES (1663796902887456, 1663248101277711, 1663796902887488, 1);
INSERT INTO `shop_order_product` VALUES (1663797085339680, 1663385993216032, 1663797085339712, 1);
INSERT INTO `shop_order_product` VALUES (1663914039312416, 1663242589962272, 1663914039312448, 1);
INSERT INTO `shop_order_product` VALUES (1663914039312480, 1663242589962272, 1663914039312512, 1);
INSERT INTO `shop_order_product` VALUES (1663914056089632, 1663242589962272, 1663914056089664, 1);
INSERT INTO `shop_order_product` VALUES (1663914563600416, 1663242589962272, 1663914563600448, 1);
INSERT INTO `shop_order_product` VALUES (1663955153977376, 1663242589962272, 1663955153977408, 1);
INSERT INTO `shop_order_product` VALUES (1663957177729056, 1663242589962272, 1663957177729088, 1);
INSERT INTO `shop_order_product` VALUES (1663957282586656, 1663242589962272, 1663957282586688, 1);
INSERT INTO `shop_order_product` VALUES (1663957576187936, 1663242589962272, 1663957576187968, 1);
INSERT INTO `shop_order_product` VALUES (1663958138224672, 1663242589962272, 1663958138224704, 1);
INSERT INTO `shop_order_product` VALUES (1663958150807584, 1663385993216032, 1663958150807616, 2);
INSERT INTO `shop_order_product` VALUES (1663962336722976, 1663385993216032, 1663962336723008, 1);
INSERT INTO `shop_order_product` VALUES (1663968051462176, 1663385993216032, 1663968051462208, 1);
INSERT INTO `shop_order_product` VALUES (1663973011226656, 1663385993216032, 1663973011226688, 1);
INSERT INTO `shop_order_product` VALUES (1663975123058720, 1663385993216032, 1663975123058752, 1);
INSERT INTO `shop_order_product` VALUES (1663978178609184, 1663385993216032, 1663978178609216, 1);

-- ----------------------------
-- Table structure for shop_product_label
-- ----------------------------
DROP TABLE IF EXISTS `shop_product_label`;
CREATE TABLE `shop_product_label`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `label_id` bigint NULL DEFAULT NULL COMMENT '标签id',
  `product_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_product_label
-- ----------------------------
INSERT INTO `shop_product_label` VALUES (1663231632343104, 1663202349809696, 1663231632343072);
INSERT INTO `shop_product_label` VALUES (1663231632343136, 1663202366586912, 1663231632343072);
INSERT INTO `shop_product_label` VALUES (1663231632343168, 1663202383364128, 1663231632343072);
INSERT INTO `shop_product_label` VALUES (1663231898681376, 1663202366586912, 1663231844155424);
INSERT INTO `shop_product_label` VALUES (1663233681260608, 1663202349809696, 1663233681260576);
INSERT INTO `shop_product_label` VALUES (1663233681260640, 1663202366586912, 1663233681260576);
INSERT INTO `shop_product_label` VALUES (1663233681260672, 1663202383364128, 1663233681260576);
INSERT INTO `shop_product_label` VALUES (1663644293136416, 1663202383364128, 1663242589962272);
INSERT INTO `shop_product_label` VALUES (1663644293136448, 1663202366586912, 1663242589962272);
INSERT INTO `shop_product_label` VALUES (1663644324593696, 1663202349809696, 1663248101277728);
INSERT INTO `shop_product_label` VALUES (1663644343468064, 1663202349809696, 1663385993216032);
INSERT INTO `shop_product_label` VALUES (1663644343468096, 1663202366586912, 1663385993216032);

-- ----------------------------
-- Table structure for shop_sku_spu_product
-- ----------------------------
DROP TABLE IF EXISTS `shop_sku_spu_product`;
CREATE TABLE `shop_sku_spu_product`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `file_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `category_id` bigint NULL DEFAULT NULL COMMENT '分类id',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名',
  `product_price` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品价格',
  `product_actual_price` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品实际价格',
  `product_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品状态',
  `product_inventory` int NULL DEFAULT NULL COMMENT '商品库存',
  `product_intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品简介',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除标识',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_sku_spu_product
-- ----------------------------
INSERT INTO `shop_sku_spu_product` VALUES (1663242589962272, '联想拯救者', '/profile/upload/2025/02/19/lxzjz_20250219213655A001.png', 1663201664040992, '数码', '6999', '5888', '1', 0, '性能强悍，游戏本；畅爽游戏', '0', NULL, '2025-02-17 16:24:30', NULL, '2025-02-19 21:36:57', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277711, '跳蛋', '/profile/upload/2025/02/19/lxzjz_20250219221051A005.png', 1663201695498272, '情趣', '9888', '7555', '0', 2, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 22:10:53', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277712, '跳蛋', '/profile/upload/2025/02/19/iphone1_20250219221236A006.png', 1663201695498272, '情趣', '9888', '7555', '0', 123, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 22:12:38', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277713, '光影精灵', '/profile/upload/2025/02/19/ps5_20250219213710A003.jpg', 1663201695498272, '情趣', '9888', '7555', '0', 123, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 21:37:12', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277714, '光影精灵5', '/profile/upload/2025/02/19/iphone2_20250219221243A007.png', 1663201695498272, '情趣', '9888', '7555', '0', 123, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 22:12:44', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277721, '惠普笔记本', '/profile/upload/2025/02/19/ps5_20250219213710A003.jpg', 1663201695498272, '情趣', '7888', '3555', '0', 123, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 21:37:12', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277722, 'iphone 13 Pro Max', '/profile/upload/2025/02/19/ps5_20250219213710A003.jpg', 1663201695498272, '情趣', '9888', '7555', '0', 123, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 21:37:12', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277723, 'iphone 14 Pro Max', '/profile/upload/2025/02/19/lxzjz_20250219221256A008.png', 1663201695498272, '情趣', '9888', '7555', '0', 123, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 22:12:58', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277724, 'iphone 15 Pro Max', '/profile/upload/2025/02/19/ps5_20250219213710A003.jpg', 1663201695498272, '情趣', '9888', '7555', '0', 123, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 21:37:12', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277725, 'iphone 16 Pro Max', '/profile/upload/2025/02/19/ps5_20250219213710A003.jpg', 1663201695498272, '情趣', '9888', '7555', '0', 123, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 21:37:12', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663248101277728, '小宠物', '/profile/upload/2025/02/19/ps5_20250219213710A003.jpg', 1663201695498272, '情趣', '788', '355', '0', 123, NULL, '0', NULL, '2025-02-17 17:08:18', NULL, '2025-02-19 21:37:12', NULL);
INSERT INTO `shop_sku_spu_product` VALUES (1663385993216032, '大疆pocket3', '/profile/upload/2025/02/19/dj_20250219213720A004.jpg', 1663201664040992, '数码', '3999', '2899', '1', 2, '防抖神器', '0', NULL, '2025-02-18 11:24:11', NULL, '2025-02-19 21:37:21', NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-02-17 10:28:11', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-02-17 10:28:11', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-02-17 10:28:11', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-02-17 10:28:11', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2025-02-17 10:28:11', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-02-17 10:28:11', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-02-17 10:28:11', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 239 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 10:27:12');
INSERT INTO `sys_logininfor` VALUES (231, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '验证码已失效', '2025-02-20 13:15:30');
INSERT INTO `sys_logininfor` VALUES (232, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 13:15:35');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 16:55:48');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 09:20:14');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 11:12:40');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 11:12:44');
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 13:06:20');
INSERT INTO `sys_logininfor` VALUES (238, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 14:47:18');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2020 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-02-17 10:28:11', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-02-17 10:28:11', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-02-17 10:28:11', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-02-17 10:28:11', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-02-17 10:28:11', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-02-17 10:28:11', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-02-17 10:28:11', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-02-17 10:28:11', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-02-17 10:28:11', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-02-17 10:28:11', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-02-17 10:28:11', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-02-17 10:28:11', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-02-17 10:28:11', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-02-17 10:28:11', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-02-17 10:28:11', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-02-17 10:28:11', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-02-17 10:28:11', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-02-17 10:28:11', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-02-17 10:28:11', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-02-17 10:28:11', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-02-17 10:28:11', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-02-17 10:28:11', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-02-17 10:28:11', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '商城管理', 0, 4, 'shop', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'shopping', 'admin', '2025-02-17 10:48:57', 'admin', '2025-02-17 11:32:09', '');
INSERT INTO `sys_menu` VALUES (2001, '分类管理', 2000, 1, 'category', 'shop/category/index', NULL, '', 1, 0, 'C', '0', '0', 'system:category:list', 'tree', 'admin', '2025-02-17 10:50:42', 'admin', '2025-02-17 10:55:37', '');
INSERT INTO `sys_menu` VALUES (2002, '标签管理', 2000, 2, 'label', 'shop/label/index', NULL, '', 1, 0, 'C', '0', '0', 'system:label:list', 'icon', 'admin', '2025-02-17 10:51:39', 'admin', '2025-02-17 10:55:44', '');
INSERT INTO `sys_menu` VALUES (2003, '商品管理', 2000, 3, 'product', 'shop/product/index', NULL, '', 1, 0, 'C', '0', '0', 'system:product:list', 'star', 'admin', '2025-02-17 10:52:33', 'admin', '2025-02-17 10:55:51', '');
INSERT INTO `sys_menu` VALUES (2004, '订单管理', 0, 5, 'merchant', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'money', 'admin', '2025-02-17 11:31:54', 'admin', '2025-02-18 13:19:54', '');
INSERT INTO `sys_menu` VALUES (2005, '订单信息', 2004, 1, 'order', 'merchant/order/index', NULL, '', 1, 0, 'C', '0', '0', 'merchant:order:list', 'list', 'admin', '2025-02-17 11:33:31', 'admin', '2025-02-18 13:20:11', '');
INSERT INTO `sys_menu` VALUES (2006, '物流信息', 2004, 2, 'logistics', 'merchant/logistics/index', NULL, '', 1, 0, 'C', '0', '0', 'merchant:logistics:list', 'nested', 'admin', '2025-02-17 11:35:22', 'admin', '2025-02-18 13:20:15', '');
INSERT INTO `sys_menu` VALUES (2007, '接单管理', 0, 6, 'delivery', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'number', 'admin', '2025-02-17 11:37:19', 'admin', '2025-02-18 13:19:21', '');
INSERT INTO `sys_menu` VALUES (2008, '接单信息', 2007, 1, 'take', 'delivery/take/index', NULL, '', 1, 0, 'C', '0', '0', 'delivery:take:list', 'online', 'admin', '2025-02-17 11:38:10', 'admin', '2025-02-18 13:19:41', '');
INSERT INTO `sys_menu` VALUES (2009, '地图信息', 2007, 2, 'map', 'delivery/take/map', NULL, '', 1, 0, 'C', '1', '0', '', 'guide', 'admin', '2025-02-18 16:45:17', 'admin', '2025-02-18 22:12:21', '');
INSERT INTO `sys_menu` VALUES (2019, 'mall', 0, 7, 'mall', 'mall/index', NULL, '', 1, 0, 'C', '0', '0', '', 'example', 'admin', '2025-02-19 21:11:35', 'admin', '2025-02-19 21:12:04', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-02-17 10:28:11', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-02-17 10:28:11', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 317 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (294, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'shopOrderProductList\' not found. Available parameters are [arg0, collection, list]', '2025-02-20 17:46:53', 7007);
INSERT INTO `sys_oper_log` VALUES (295, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663796730921024}', 0, NULL, '2025-02-20 17:48:25', 164);
INSERT INTO `sys_oper_log` VALUES (296, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663248101277711,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663796902887488}', 0, NULL, '2025-02-20 17:49:47', 28);
INSERT INTO `sys_oper_log` VALUES (297, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663385993216032,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663797085339712}', 0, NULL, '2025-02-20 17:51:14', 15);
INSERT INTO `sys_oper_log` VALUES (298, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663914039312512}', 0, NULL, '2025-02-21 09:20:42', 96);
INSERT INTO `sys_oper_log` VALUES (299, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663914039312448}', 0, NULL, '2025-02-21 09:20:42', 13302);
INSERT INTO `sys_oper_log` VALUES (300, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663914056089664}', 0, NULL, '2025-02-21 09:20:50', 24);
INSERT INTO `sys_oper_log` VALUES (301, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663914563600448}', 0, NULL, '2025-02-21 09:24:52', 111);
INSERT INTO `sys_oper_log` VALUES (302, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663955153977408}', 0, NULL, '2025-02-21 14:47:27', 100);
INSERT INTO `sys_oper_log` VALUES (303, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663957177729088}', 0, NULL, '2025-02-21 15:03:32', 166);
INSERT INTO `sys_oper_log` VALUES (304, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663957282586688}', 0, NULL, '2025-02-21 15:04:22', 43);
INSERT INTO `sys_oper_log` VALUES (305, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663957576187968}', 0, NULL, '2025-02-21 15:06:42', 23);
INSERT INTO `sys_oper_log` VALUES (306, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663958138224704}', 0, NULL, '2025-02-21 15:11:10', 28);
INSERT INTO `sys_oper_log` VALUES (307, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663385993216032,\"quantity\":2}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663958150807616}', 0, NULL, '2025-02-21 15:11:16', 30);
INSERT INTO `sys_oper_log` VALUES (308, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"柏安琪\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-21 15:32:06', 50);
INSERT INTO `sys_oper_log` VALUES (309, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663385993216032,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663962336723008}', 0, NULL, '2025-02-21 15:44:32', 58);
INSERT INTO `sys_oper_log` VALUES (310, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663385993216032,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663968051462208}', 0, NULL, '2025-02-21 16:29:57', 14);
INSERT INTO `sys_oper_log` VALUES (311, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', NULL, 1, '库存不足', '2025-02-21 17:09:16', 20);
INSERT INTO `sys_oper_log` VALUES (312, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663385993216032,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663973011226688}', 0, NULL, '2025-02-21 17:09:22', 21);
INSERT INTO `sys_oper_log` VALUES (313, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', NULL, 1, '库存不足', '2025-02-21 17:26:04', 6);
INSERT INTO `sys_oper_log` VALUES (314, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663385993216032,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663975123058752}', 0, NULL, '2025-02-21 17:26:10', 9);
INSERT INTO `sys_oper_log` VALUES (315, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663242589962272,\"quantity\":1}]}', NULL, 1, '库存不足', '2025-02-21 17:50:23', 5);
INSERT INTO `sys_oper_log` VALUES (316, '订单信息', 1, 'com.ruoyi.web.controller.system.ShopOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/order', '127.0.0.1', '内网IP', '{\"productDTOList\":[{\"productId\":1663385993216032,\"quantity\":1}]}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1663978178609216}', 0, NULL, '2025-02-21 17:50:26', 13);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-02-17 10:28:11', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-02-17 10:28:11', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-02-17 10:28:11', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (100, '商家', '*', 1, '1', 1, 1, '0', '0', 'admin', '2025-02-17 11:26:07', '', NULL, NULL);
INSERT INTO `sys_role` VALUES (101, '商城用户', 'mall', 0, '1', 1, 1, '0', '2', 'admin', '2025-02-19 14:00:36', '', NULL, NULL);
INSERT INTO `sys_role` VALUES (102, '商城普通用户', 'mall', 0, '1', 1, 1, '0', '2', 'admin', '2025-02-19 16:37:28', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (100, 2000);
INSERT INTO `sys_role_menu` VALUES (100, 2001);
INSERT INTO `sys_role_menu` VALUES (100, 2002);
INSERT INTO `sys_role_menu` VALUES (100, 2003);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '柏安琪', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-02-21 13:06:21', 'admin', '2025-02-17 10:28:11', '', '2025-02-21 15:32:06', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-02-17 10:28:11', 'admin', '2025-02-17 10:28:11', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, NULL, 'test01', '商家A', '00', '', '', '0', '', '$2a$10$Dfk5V.b0iPt.hQ.5K0z/Rew/dbSdNRaTUkTfjCc9UcaPOo5VSpkrC', '0', '0', '127.0.0.1', '2025-02-17 11:28:03', 'admin', '2025-02-17 11:27:18', '', '2025-02-17 11:28:02', NULL);
INSERT INTO `sys_user` VALUES (101, NULL, '123', 'Aaa', '00', '', '', '0', '', '$2a$10$RJw/RFgXmlhpES2FabMxB.RoDpOhAyRxP0CNDSzNQ.XRHq.Z1Vef2', '0', '0', '', NULL, 'admin', '2025-02-19 13:39:26', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (102, NULL, 'abc', 'abc', '00', '', '', '0', '', '$2a$10$WzuMkZQwhOFRivcTmL2C..adKmr/IMoymUUjMiY4LcgYOfixh1F7K', '0', '0', '127.0.0.1', '2025-02-19 23:38:47', '', '2025-02-19 14:02:12', '', '2025-02-19 23:38:46', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 100);

SET FOREIGN_KEY_CHECKS = 1;
