/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50722
Source Host           : localhost:3306
Source Database       : ordering

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2020-07-08 14:48:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '奶茶专区');
INSERT INTO `category` VALUES ('2', '甜品/蛋糕');
INSERT INTO `category` VALUES ('3', '早点');
INSERT INTO `category` VALUES ('4', '午饭套餐');
INSERT INTO `category` VALUES ('5', '肉类炒菜');
INSERT INTO `category` VALUES ('6', '素菜专区');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `salt` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL COMMENT '买家地址',
  `phone` varchar(100) DEFAULT NULL COMMENT '买家联系方式',
  `status` int(11) DEFAULT '0' COMMENT '状态，0：普通用户，1：会员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', 'zc2', '46c5039e1ec11aeadb884c37e5886b7c', '029fc207d804289dcf7cfd9153b5df4b', '南京', '12345', '0');
INSERT INTO `customer` VALUES ('2', 'zc', '3144fec842a6a67abaad72eea05c7247', '50a4ea80ad81e573ceea016499e10522', '北京', '10086', '0');

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL COMMENT '商品id',
  `oid` int(11) DEFAULT NULL COMMENT '订单id',
  `cstid` int(11) DEFAULT NULL COMMENT '买家id',
  `number` int(11) DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  KEY `oid` (`oid`) USING BTREE,
  KEY `cstid` (`cstid`) USING BTREE,
  CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`oid`) REFERENCES `order_` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orderitem_ibfk_3` FOREIGN KEY (`cstid`) REFERENCES `customer` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES ('86', '1', '15', '1', '1');
INSERT INTO `orderitem` VALUES ('87', '2', '15', '1', '2');
INSERT INTO `orderitem` VALUES ('88', '1', '16', '2', '1');
INSERT INTO `orderitem` VALUES ('89', '9', '17', '2', '1');
INSERT INTO `orderitem` VALUES ('93', '1', '17', '2', '100');
INSERT INTO `orderitem` VALUES ('94', '1', null, '2', '1');

-- ----------------------------
-- Table structure for order_
-- ----------------------------
DROP TABLE IF EXISTS `order_`;
CREATE TABLE `order_` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL COMMENT '订单编号',
  `address` varchar(255) DEFAULT NULL COMMENT '买家地址',
  `status` int(255) DEFAULT '0' COMMENT '支付状态，0：未支付，1：正在发货，2：已发货，3：已收货',
  `cstid` int(8) DEFAULT NULL COMMENT '买家id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `cstid` (`cstid`) USING BTREE,
  CONSTRAINT `order__ibfk_1` FOREIGN KEY (`cstid`) REFERENCES `customer` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_
-- ----------------------------
INSERT INTO `order_` VALUES ('15', '202003201045204771', '姓名：zc,配送地址：南京,手机号：12345', '2', '1');
INSERT INTO `order_` VALUES ('16', '202003231019127699', '姓名：zc,配送地址：北京,手机号：10086', '1', '2');
INSERT INTO `order_` VALUES ('17', '202005231035576864', '姓名：zc,配送地址：北京,手机号：10086', '2', '2');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `desc_` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '删除分类', '删除分类', '');
INSERT INTO `permission` VALUES ('2', '分类列表', '查看分类列表', '');
INSERT INTO `permission` VALUES ('15', '修改分类页面', '修改分类页面', '');
INSERT INTO `permission` VALUES ('17', '添加商品分类', '添加商品分类', '');
INSERT INTO `permission` VALUES ('18', '查看管理员列表', '查看管理员列表', '');
INSERT INTO `permission` VALUES ('20', '查看角色列表', '可增删改查', '');
INSERT INTO `permission` VALUES ('21', '查看权限列表', '无', '');
INSERT INTO `permission` VALUES ('23', '修改管理员信息界面', '修改界面', '');
INSERT INTO `permission` VALUES ('24', '更新管理员信息', '无', '');
INSERT INTO `permission` VALUES ('25', '管理员删除', '删除', '');
INSERT INTO `permission` VALUES ('26', '添加管理员界面', '无', '');
INSERT INTO `permission` VALUES ('27', '添加管理员', '无', '');
INSERT INTO `permission` VALUES ('28', '商品列表', '查看商品列表', '');
INSERT INTO `permission` VALUES ('29', '添加商品', '添加上线商品', '');
INSERT INTO `permission` VALUES ('30', '删除商品', '暂无', '');
INSERT INTO `permission` VALUES ('31', '修改商品界面', '暂无', '');
INSERT INTO `permission` VALUES ('32', '更新商品', '暂无', '');
INSERT INTO `permission` VALUES ('33', '添加商品界面', '暂无', '');
INSERT INTO `permission` VALUES ('34', '商品上线', '暂无', '');
INSERT INTO `permission` VALUES ('35', '商品下线', '暂无', '');
INSERT INTO `permission` VALUES ('36', '订单发货', '暂无', '');
INSERT INTO `permission` VALUES ('37', '查看订单项', '暂无', '');
INSERT INTO `permission` VALUES ('38', '评论列表', '暂无', '');
INSERT INTO `permission` VALUES ('39', '删除评论', '暂无', '');
INSERT INTO `permission` VALUES ('40', '查看订单列表', '暂无', '');
INSERT INTO `permission` VALUES ('41', '添加权限UI', '暂无', '');
INSERT INTO `permission` VALUES ('42', '添加权限', '暂无', '');
INSERT INTO `permission` VALUES ('43', '删除权限', '暂无', '');
INSERT INTO `permission` VALUES ('44', '修改权限ui', '暂无', '');
INSERT INTO `permission` VALUES ('45', '更新权限', '暂无', '');
INSERT INTO `permission` VALUES ('46', '查看用户列表', '暂无', '');
INSERT INTO `permission` VALUES ('47', '删除角色', '暂无', '');
INSERT INTO `permission` VALUES ('48', '添加管理员UI', '暂无', '');
INSERT INTO `permission` VALUES ('49', '添加管理员', '暂未', '');
INSERT INTO `permission` VALUES ('50', '修改角色UI', '暂无', '');
INSERT INTO `permission` VALUES ('51', '修改角色', '暂无', '');
INSERT INTO `permission` VALUES ('52', '添加角色UI', '暂无', '');
INSERT INTO `permission` VALUES ('53', '添加角色', '暂无', '');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `price` float(8,2) DEFAULT NULL COMMENT '价格',
  `zan` int(8) DEFAULT NULL COMMENT '赞',
  `number` int(8) DEFAULT NULL COMMENT '销量',
  `status` int(10) DEFAULT '1' COMMENT '状态，1：上线，0：下线',
  `imageurl` varchar(100) DEFAULT NULL COMMENT '商品图片url',
  `miaoshu` varchar(200) DEFAULT '' COMMENT '商品描述',
  `cid` int(8) DEFAULT NULL COMMENT '分类id',
  `bid` bigint(11) DEFAULT NULL COMMENT '商家id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `product_ibfk_1` (`cid`) USING BTREE,
  KEY `product_ibfk_2` (`bid`) USING BTREE,
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`bid`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', '红豆布丁烧奶', '9.00', '54', '94', '1', 'images/product/1.jpg', '软糯红豆嫩布丁，鲜香甘甜，浓郁的奶香与红豆完美相融，满足感充分体现在你的唇齿和心间', '1', '1');
INSERT INTO `product` VALUES ('2', '焦糖珍奶', '10.00', '98', '103', '1', 'images/product/2.jpg', '奶茶中的经典款，用不过时，焦糖的甜珍奶的鲜，永远有人喜欢。', '1', '1');
INSERT INTO `product` VALUES ('3', '葡萄柚益菌多', '15.00', '45', '63', '1', 'images/product/3.jpg', '新鲜葡萄柚与优菌多相遇，酸甜的滋味在唇齿间流转，只需闭上眼用心品味这让人欲罢不能的清爽感。', '1', '1');
INSERT INTO `product` VALUES ('4', '芒果布丁奶绿', '13.00', '41', '43', '1', 'images/product/4.jpg', '清香可口的海南大金煌与柔滑香的甜奶布丁，层层叠加，混搭滋味，随心选择。', '1', '1');
INSERT INTO `product` VALUES ('5', '金桔柠檬茶', '18.00', '72', '168', '1', 'images/product/5.jpg', '打破传统奶盖与茶饮分离的做法，将咸奶盖与芒果冰均匀融合。芒果冰的爽滑细腻与咸奶盖的香浓完美融合，口感清甜饱满，独家特制芒砂糖将芒果本身的香甜气息发挥到极致。', '1', '1');
INSERT INTO `product` VALUES ('6', '蜂蜜柚子茶', '18.00', '74', '159', '1', 'images/product/6.jpg', '不仅是味道清香可口，更是一款有美白祛斑、嫩肤养颜功效的食品。蜂蜜中含有的L－半胱氨酸具有排毒作用，具有一定的祛斑效果。', '1', '1');
INSERT INTO `product` VALUES ('7', '巧克力水果蛋糕', '68.00', '75', '101', '1', 'images/product/7.jpg', '本店蛋糕现做现卖，由于蛋糕的特殊性，请顾客提前义雄安史预定。联系电话：12312345678', '2', '1');
INSERT INTO `product` VALUES ('8', '心心相印', '88.00', '45', '99', '1', 'images/product/8.jpg', '为了保证蛋糕的新鲜！所有商品均为顾客下单现做！为了不耽误亲们的宝贵时间，请尽量提前一小时下单！详情致电：12312345678', '2', '1');
INSERT INTO `product` VALUES ('9', '美味奶油蛋糕', '45.00', '45', '56', '1', 'images/product/9.jpg', '本店蛋糕现做现卖，请顾客朋友提前预定电话：12312345678', '2', '1');
INSERT INTO `product` VALUES ('10', '至尊奶油蛋糕', '98.00', '235', '420', '1', 'images/product/10.jpg', '本店蛋糕现做现卖，由于蛋糕的特殊性，请顾客提前2小时预定。联系电话：12312345678', '2', '1');
INSERT INTO `product` VALUES ('11', '丰盛果园', '133.00', '356', '2762', '1', 'images/product/11.jpg', '（15人餐）本店蛋糕现做现卖，请顾客提亲1小时预定，联系电话：12312345678', '2', '1');
INSERT INTO `product` VALUES ('12', '太阳花', '166.00', '124', '369', '1', 'images/product/12.jpg', '（20人餐）本店蛋糕现做现卖，请顾客提前一小时预定。联系电话：12312345678', '2', '1');
INSERT INTO `product` VALUES ('13', '初见', '105.00', '124', '234', '1', 'images/product/13.jpg', '（12餐）本店蛋糕现做现卖，请顾客提前一小时预定，联系电话：12312345678', '2', '1');
INSERT INTO `product` VALUES ('14', '香辣鸡腿堡', '5.00', '124', '254', '1', 'images/product/14.jpg', '开业特惠，豪吃不贵！限时特价商品', '3', '1');
INSERT INTO `product` VALUES ('15', '墨西哥肌肉卷', '19.00', '453', '454', '1', 'images/product/15.jpg', '里面用的是番茄酱哈', '3', '1');
INSERT INTO `product` VALUES ('16', '爆浆鸡排', '12.00', '45', '4654', '1', 'images/product/16.jpg', '香脆可口', '3', '1');
INSERT INTO `product` VALUES ('17', '椰奶芝士蛋糕', '11.00', '54', '132', '1', 'images/product/17.jpg', '该商品暂无描述', '3', '1');
INSERT INTO `product` VALUES ('18', '南瓜脆皮芝士包', '8.00', '15', '232', '1', 'images/product/18.jpg', '暂无商品信息', '3', '1');
INSERT INTO `product` VALUES ('19', '核桃布里奥斯', '23.00', '33', '323', '1', 'images/product/19.jpg', '定制设计', '3', '1');
INSERT INTO `product` VALUES ('20', '卤肉配牛丸', '45.00', '45', '555', '1', 'images/product/20.jpg', '把简单的事情做到不简单，这就是我们存在的意义。优质猪后腿肉，在浓郁的老卤的怀抱中千回百转。30余味的精选香料与肉块的完美融合。', '4', '1');
INSERT INTO `product` VALUES ('25', '雪花鸡排饭', '42.00', '444', '444', '1', 'images/product/25.jpg', '鸡腿+脆骨肠+配菜+饮料+米饭', '4', '1');
INSERT INTO `product` VALUES ('26', '劲爆麻辣牛肉饭', '35.00', '23', '43', '1', 'images/product/26.jpg', '牛排+脆骨肠+配菜+饮料+米饭', '4', '1');
INSERT INTO `product` VALUES ('27', '蜜汁牛排饭', '25.00', '34', '53', '1', 'images/product/27.jpg', '牛排+脆骨肠+配菜+饮料+米饭', '4', '1');
INSERT INTO `product` VALUES ('28', '小熊卤肉饭', '23.00', '34', '23', '1', 'images/product/28.jpg', '卤香十足，香甜可口，回味无穷，超级好吃', '4', '1');
INSERT INTO `product` VALUES ('29', '法式炸鸡饭', '23.00', '43', '65', '1', 'images/product/29.jpg', '暂无介绍', '4', '1');
INSERT INTO `product` VALUES ('30', '清蒸大闸蟹', '98.00', '456', '998', '1', 'images/product/30.jpg', '3.5重的大公蟹，肉质鲜美，淘宝都卖一百四五一只，本店只卖98', '5', '1');
INSERT INTO `product` VALUES ('31', '牛排', '70.00', '98', '564', '1', 'images/product/31.jpg', '暂无介绍', '5', '1');
INSERT INTO `product` VALUES ('32', '麻辣小煎花椒鸡肉', '20.00', '222', '666', '1', 'images/product/32.png', '', '5', '1');
INSERT INTO `product` VALUES ('33', '鱼香肉丝', '10.00', '66', '66', '1', 'images/product/33.png', '', '5', '1');
INSERT INTO `product` VALUES ('40', '油焖茄子', '12.00', '40', '200', '1', 'images/product/40.png', '', '6', '1');
INSERT INTO `product` VALUES ('41', '酸菜鱼', '25.00', '122', '222', '1', 'images/product/41.png', '', '5', '1');
INSERT INTO `product` VALUES ('42', '烤鱼', '40.00', '200', '300', '1', 'images/product/42.png', '', '5', '1');
INSERT INTO `product` VALUES ('43', '西红柿炒蛋', '9.00', '20', '30', '1', 'images/product/43.jpg', '', '6', '1');
INSERT INTO `product` VALUES ('44', '青椒土豆丝', '8.00', '20', '40', '1', 'images/product/44.png', '', '6', '1');
INSERT INTO `product` VALUES ('45', '小青菜', '6.00', '20', '40', '1', 'images/product/45.png', '', '6', '1');
INSERT INTO `product` VALUES ('46', '春卷', '5.00', '22', '33', '1', 'images/product/46.jpg', '', '3', '1');
INSERT INTO `product` VALUES ('47', '现磨豆浆', '3.00', '111', '222', '1', 'images/product/47.jpg', '', '3', '1');

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT '该用户默认给出了好评！！！' COMMENT '评论内容',
  `cstid` int(11) DEFAULT NULL COMMENT '用户id',
  `pid` int(11) DEFAULT NULL COMMENT '商品id',
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `cstid` (`cstid`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`cstid`) REFERENCES `customer` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES ('1', '该用户默认给出了好评！！！', '1', '1', '2020-03-12 13:11:55');
INSERT INTO `review` VALUES ('3', '好喝！', '2', '2', '2020-03-14 11:40:49');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `desc_` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin', '超级管理员');
INSERT INTO `role` VALUES ('2', 'productManager', '商品管理员');
INSERT INTO `role` VALUES ('3', '游客', '只能查看，不能增删改');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rid` bigint(20) DEFAULT NULL COMMENT '角色id',
  `pid` bigint(20) DEFAULT NULL COMMENT '权限id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('134', '3', '2');
INSERT INTO `role_permission` VALUES ('135', '3', '18');
INSERT INTO `role_permission` VALUES ('136', '3', '20');
INSERT INTO `role_permission` VALUES ('137', '3', '21');
INSERT INTO `role_permission` VALUES ('138', '3', '28');
INSERT INTO `role_permission` VALUES ('139', '3', '37');
INSERT INTO `role_permission` VALUES ('140', '3', '38');
INSERT INTO `role_permission` VALUES ('141', '3', '40');
INSERT INTO `role_permission` VALUES ('346', '1', '53');
INSERT INTO `role_permission` VALUES ('347', '1', '52');
INSERT INTO `role_permission` VALUES ('348', '1', '51');
INSERT INTO `role_permission` VALUES ('349', '1', '50');
INSERT INTO `role_permission` VALUES ('350', '1', '49');
INSERT INTO `role_permission` VALUES ('351', '1', '48');
INSERT INTO `role_permission` VALUES ('352', '1', '47');
INSERT INTO `role_permission` VALUES ('353', '1', '46');
INSERT INTO `role_permission` VALUES ('354', '1', '45');
INSERT INTO `role_permission` VALUES ('355', '1', '44');
INSERT INTO `role_permission` VALUES ('356', '1', '43');
INSERT INTO `role_permission` VALUES ('357', '1', '42');
INSERT INTO `role_permission` VALUES ('358', '1', '41');
INSERT INTO `role_permission` VALUES ('359', '1', '40');
INSERT INTO `role_permission` VALUES ('360', '1', '39');
INSERT INTO `role_permission` VALUES ('361', '1', '38');
INSERT INTO `role_permission` VALUES ('362', '1', '37');
INSERT INTO `role_permission` VALUES ('363', '1', '36');
INSERT INTO `role_permission` VALUES ('364', '1', '35');
INSERT INTO `role_permission` VALUES ('365', '1', '34');
INSERT INTO `role_permission` VALUES ('366', '1', '33');
INSERT INTO `role_permission` VALUES ('367', '1', '32');
INSERT INTO `role_permission` VALUES ('368', '1', '31');
INSERT INTO `role_permission` VALUES ('369', '1', '30');
INSERT INTO `role_permission` VALUES ('370', '1', '29');
INSERT INTO `role_permission` VALUES ('371', '1', '28');
INSERT INTO `role_permission` VALUES ('372', '1', '27');
INSERT INTO `role_permission` VALUES ('373', '1', '26');
INSERT INTO `role_permission` VALUES ('374', '1', '25');
INSERT INTO `role_permission` VALUES ('375', '1', '24');
INSERT INTO `role_permission` VALUES ('376', '1', '23');
INSERT INTO `role_permission` VALUES ('377', '1', '21');
INSERT INTO `role_permission` VALUES ('378', '1', '20');
INSERT INTO `role_permission` VALUES ('379', '1', '18');
INSERT INTO `role_permission` VALUES ('380', '1', '17');
INSERT INTO `role_permission` VALUES ('381', '1', '15');
INSERT INTO `role_permission` VALUES ('382', '1', '2');
INSERT INTO `role_permission` VALUES ('383', '1', '1');
INSERT INTO `role_permission` VALUES ('384', '2', '40');
INSERT INTO `role_permission` VALUES ('385', '2', '38');
INSERT INTO `role_permission` VALUES ('386', '2', '37');
INSERT INTO `role_permission` VALUES ('387', '2', '36');
INSERT INTO `role_permission` VALUES ('388', '2', '35');
INSERT INTO `role_permission` VALUES ('389', '2', '34');
INSERT INTO `role_permission` VALUES ('390', '2', '33');
INSERT INTO `role_permission` VALUES ('391', '2', '32');
INSERT INTO `role_permission` VALUES ('392', '2', '31');
INSERT INTO `role_permission` VALUES ('393', '2', '30');
INSERT INTO `role_permission` VALUES ('394', '2', '29');
INSERT INTO `role_permission` VALUES ('395', '2', '28');
INSERT INTO `role_permission` VALUES ('396', '2', '17');
INSERT INTO `role_permission` VALUES ('397', '2', '15');
INSERT INTO `role_permission` VALUES ('398', '2', '2');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '管理员姓名',
  `password` varchar(100) DEFAULT NULL COMMENT '管理员密码',
  `salt` varchar(100) DEFAULT NULL,
  `status` int(10) DEFAULT NULL COMMENT '状态，1：启用，0：停用',
  `address` varchar(100) DEFAULT '暂无' COMMENT '商家管理员地址',
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'zc', '4594ffee94ba05e2caa2f4a2d2871ffb', '7f1981d8c5d76575e0ab5de85a24ac72', '1', '南京', '10086');
INSERT INTO `user` VALUES ('2', '啊啊啊', 'dafe2800ff4d716c04062ba50047bc2d', 'ce405c0e3eadfc22b7dc64d386015d4d', '1', '北京', '12580');
INSERT INTO `user` VALUES ('4', 'zc1', '0d436e3078772f557725ac1ed3c74e2b', '80289e2276328fc967b04a937132dfb7', '1', '', '');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `rid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('7', '4', '1');
INSERT INTO `user_role` VALUES ('8', '4', '2');
INSERT INTO `user_role` VALUES ('9', '1', '1');
INSERT INTO `user_role` VALUES ('10', '1', '2');
INSERT INTO `user_role` VALUES ('11', '2', '2');

-- ----------------------------
-- Table structure for zixun
-- ----------------------------
DROP TABLE IF EXISTS `zixun`;
CREATE TABLE `zixun` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) DEFAULT NULL COMMENT '资讯内容',
  `cstid` int(11) DEFAULT NULL COMMENT '客户id',
  `status` int(255) DEFAULT '0' COMMENT '审核状态，1：通过，0：未通过;',
  `fabudate` datetime DEFAULT NULL COMMENT '发布时间;',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of zixun
-- ----------------------------
