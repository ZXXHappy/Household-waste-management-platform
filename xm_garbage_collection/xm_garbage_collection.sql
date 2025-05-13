/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : xm_garbage_collection

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 18/12/2024 17:47:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `phone` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '超级管理员', 'http://localhost:9090/files/download/柴犬.jpg', 'ADMIN', '19999578830', 'ADMIN@ww.com');

-- ----------------------------
-- Table structure for community
-- ----------------------------
DROP TABLE IF EXISTS `community`;
CREATE TABLE `community`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '社区名称',
  `address` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '社区地址',
  `img` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '社区图片',
  `manager_id` INT(11) NULL DEFAULT NULL COMMENT '社区负责人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '社区信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of community
-- ----------------------------
INSERT INTO `community` VALUES (3, '月湖社区', '长沙市开福区月湖大道', 'http://localhost:9090/files/download/社区图片01.jpg', 3);
INSERT INTO `community` VALUES (4, '大泽湖社区', '长沙市望城区大泽湖街道', 'http://localhost:9090/files/download/社区图片02.jpg', 2);
INSERT INTO `community` VALUES (5, '桂花坪社区', '长沙市天心区桂花坪街道', 'http://localhost:9090/files/download/社区图片05.jpg', 3);
INSERT INTO `community` VALUES (6, '浏阳河社区', '长沙市开福区浏阳河街道', 'http://localhost:9090/files/download/社区图片04.jpg', 2);
INSERT INTO `community` VALUES (7, '月亮岛社区', '长沙市望城区月亮岛街道', 'http://localhost:9090/files/download/社区图片03.jpg', 3);

-- ----------------------------
-- Table structure for community_admin
-- ----------------------------
DROP TABLE IF EXISTS `community_admin`;
CREATE TABLE `community_admin`  (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `phone` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社区管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of community_admin
-- ----------------------------
INSERT INTO `community_admin` VALUES (2, 'Jack', 'jjj', '杰克', 'http://localhost:9090/files/download/男一.png', 'COMMUNITY', '10030555566', 'JACK@ww.com');
INSERT INTO `community_admin` VALUES (3, 'Rose', 'rrr', '玫瑰', 'http://localhost:9090/files/download/男二.png', 'COMMUNITY', '19988765544', 'ROSE@ww.com');

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` INT(11) NULL DEFAULT NULL COMMENT '用户id',
  `content` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '反馈问题',
  `idea` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '反馈想法',
  `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '反馈标题',
  `time` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '反馈时间',
  `reply_content` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回复内容',
  `reply_time` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回复时间',
  `status` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回复状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '反馈信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (2, 2, '积分兑换的物品没有发货', '积分兑换的物品没有发货', '积分兑换的物品没有发货', '2025-05-07 16:53:09', '我来确认一下，给你发放', '2025-05-07 16:53:30', '已回复');
INSERT INTO `feedback` VALUES (3, 3, '我的积分没到账', '我的积分没到账', '我的积分没到账', '2025-05-07 16:57:53', NULL, NULL, '待回复');

-- ----------------------------
-- Table structure for garbage_launch
-- ----------------------------
DROP TABLE IF EXISTS `garbage_launch`;
CREATE TABLE `garbage_launch`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` INT(11) NULL DEFAULT NULL COMMENT '用户id',
  `community_id` INT(11) NULL DEFAULT NULL COMMENT '社区id',
  `site_id` INT(11) NULL DEFAULT NULL COMMENT '投放点id',
  `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '垃圾类型',
  `img` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '垃圾照片',
  `time` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '投放时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '垃圾投放记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of garbage_launch
-- ----------------------------
INSERT INTO `garbage_launch` VALUES (4, 2, 7, 7, '干垃圾', 'http://localhost:9090/files/download/废报纸图片.jpg', '2025-05-06 17:21:50');
INSERT INTO `garbage_launch` VALUES (5, 3, 6, 4, '干垃圾', 'http://localhost:9090/files/download/旧衣服图片.png', '2025-05-06 17:31:28');
INSERT INTO `garbage_launch` VALUES (6, 2, 6, 4, '干垃圾', 'http://localhost:9090/files/download/有害垃圾02.jpg', '2025-05-06 17:32:00');
INSERT INTO `garbage_launch` VALUES (7, 2, 6, 4, '湿垃圾', 'http://localhost:9090/files/download/厨余垃圾01.jpg', '2025-05-07 17:39:05');
INSERT INTO `garbage_launch` VALUES (8, 2, 6, 4, '有害垃圾', 'http://localhost:9090/files/download/有害垃圾01.jpg', '2025-05-07 17:39:14');
INSERT INTO `garbage_launch` VALUES (9, 2, 6, 4, '干垃圾', 'http://localhost:9090/files/download/废报纸图片.jpg', '2025-05-07 17:39:20');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告标题',
  `content` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '公告内容',
  `time` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '今天天气真的不错', '今天天气很好!是进行垃圾回收的好日子哦！', '2025-04-18 07:51:17');
INSERT INTO `notice` VALUES (2, '积分功能维护', '由于部分用户反馈积分数量显示不正确，平台将会于今晚20:00至明早8:00进行项目维护，请大家在此期间内停止使用积分功能，很抱歉对大家造成困扰，感谢理解。', '2025-04-20 15:52:22');
INSERT INTO `notice` VALUES (3, '宣传模块内容上新啦！', '平台新增《低碳生活》宣传模块，请大家前往查阅哦！', '2025-04-25 18:52:56');

-- ----------------------------
-- Table structure for popularize
-- ----------------------------
DROP TABLE IF EXISTS `popularize`;
CREATE TABLE `popularize`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `descr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简介',
  `img` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
  `thumbnail1` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小图1',
  `thumbnail2` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小图2',
  `thumbnail3` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小图3',
  `content` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '主体内容',
  `type_id` INT(11) NULL DEFAULT NULL COMMENT '分类id',
  `view_count` INT(11) NULL DEFAULT NULL COMMENT '浏览量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '宣传信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of popularize
-- ----------------------------
INSERT INTO `popularize` VALUES (18, '湿垃圾：资源还是废物？', '湿垃圾，专业术语中通常被称为厨余垃圾或有机垃圾，指的是在日常生活中产生的易腐烂的生物质废弃物。这些垃圾来源于家庭厨房、餐饮业、食品加工业等，包括但不限于食材废料、剩菜剩饭、瓜皮果核、花卉绿植、中药药渣等。湿垃圾的一个显著特点是它们富含水分和有机物质，这使得它们在自然环境中能够迅速降解。', 'http://localhost:9090/files/download/湿垃圾01.png', 'http://localhost:9090/files/download/湿垃圾02.png', 'http://localhost:9090/files/download/湿垃圾03.png', 'http://localhost:9090/files/download/干垃圾02.jpg', '<h2 style=\"text-align: start; line-height: 2.5;\">湿垃圾的分类</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">湿垃圾的范围广泛，涵盖了家庭和商业活动中产生的各类有机废弃物。具体而言，湿垃圾包括：</span></p><ul><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>食材废料</strong></span><span style=\"font-size: 16px;\">：如蔬菜根、叶，水果皮，鸡蛋壳等。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>剩余食物</strong></span><span style=\"font-size: 16px;\">：剩菜剩饭，未吃完的糕点、糖果等。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>植物残余</strong></span><span style=\"font-size: 16px;\">：花园修剪下来的枝叶，花卉凋谢后的花瓣，盆栽更换的土壤等。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>特殊有机物</strong></span><span style=\"font-size: 16px;\">：中药药渣，茶叶渣，咖啡渣等。</span></li></ul><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">值得注意的是，湿垃圾并非单纯由水分含量决定，而是基于其是否能够通过微生物作用进行生物降解。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">湿垃圾的处理</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">湿垃圾的处理方式多样，但主要围绕着资源化利用和环境友好处理的原则展开。</span></p><ol><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>堆肥化</strong></span><span style=\"font-size: 16px;\">：湿垃圾经过堆肥化处理，可以转化为优质的有机肥料，用于农业和园艺，促进土壤健康，减少化学肥料的使用。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>厌氧消化</strong></span><span style=\"font-size: 16px;\">：在缺氧条件下，湿垃圾通过厌氧菌的作用，可以产生生物气体（主要是甲烷），作为能源使用，如发电或供暖。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>生物燃料</strong></span><span style=\"font-size: 16px;\">：湿垃圾中的油脂部分可以转化为生物柴油，成为可再生的能源。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>直接降解</strong></span><span style=\"font-size: 16px;\">：在适当的环境下，湿垃圾可以自然降解，但需注意控制过程，防止产生恶臭和吸引害虫。</span></li></ol><h2 style=\"text-align: start; line-height: 2.5;\">湿垃圾的环境意义</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">湿垃圾的合理处理不仅能够减少环境污染，还能变废为宝，实现资源的循环利用。与传统的填埋或焚烧相比，堆肥化和厌氧消化等方法能够减少温室气体排放，降低对环境的负面影响。此外，有机肥料的使用还能促进土壤生态系统的恢复，增强土地的生产力。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">分类的重要性</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">正确地将湿垃圾与其他垃圾（如干垃圾、可回收物、有害垃圾）分离，是确保湿垃圾得到恰当处理的关键。分类不仅能提高资源的回收利用率，还能减少处理成本，保护环境免受污染。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">结语</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">湿垃圾的管理和利用是一个系统工程，涉及到社会的各个方面。通过提升公众的垃圾分类意识，完善收集和处理系统，我们可以将湿垃圾从一种潜在的环境负担转变为宝贵的资源，为构建绿色、可持续的社会做出贡献。</span></p>', 6, 0);
INSERT INTO `popularize` VALUES (19, '干垃圾：分类、影响与处理', '干垃圾，也被称为其他垃圾或非湿垃圾，是在生活垃圾中除了可回收物、有害垃圾和湿垃圾（即厨余垃圾）之外的其他废弃物。这类垃圾通常不易腐烂，也不易降解，主要包括但不限于餐巾纸、卫生间用纸、污损纸张、烟蒂、一次性餐具、破损的陶瓷、玻璃碎片、一次性塑料制品、尼龙制品、编织袋、防碎气泡膜等。值得注意的是，卫生纸因其遇水易溶，也被归类为干垃圾，而非可回收物。', 'http://localhost:9090/files/download/干垃圾封面.png', 'http://localhost:9090/files/download/干垃圾01.png', 'http://localhost:9090/files/download/干垃圾02.jpg', 'http://localhost:9090/files/download/干垃圾03.png', '<h2 style=\"text-align: start; line-height: 2.5;\">生活中的干垃圾示例</h2><ul><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>卫生纸</strong></span><span style=\"font-size: 16px;\">：即便未使用，也因水溶性而不被视为可回收物。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>塑料包装</strong></span><span style=\"font-size: 16px;\">：如食品包装袋、塑料膜，特别是那些已被污染的塑料制品。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>一次性用品</strong></span><span style=\"font-size: 16px;\">：如尿不湿、猫砂、狗尿垫等宠物用品。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>破损物品</strong></span><span style=\"font-size: 16px;\">：如破碎的陶瓷、玻璃碎片、无法修复的电器和电子产品。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>办公用品</strong></span><span style=\"font-size: 16px;\">：如用过的笔、橡皮、旧文件夹等。</span></li><li style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\"><strong>纺织品</strong></span><span style=\"font-size: 16px;\">：损坏的衣物、床单、毛巾等，若无法回收或再利用。</span></li></ul><h2 style=\"text-align: start; line-height: 2.5;\">干垃圾的影响</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">干垃圾的不当处理会对环境造成严重的影响。由于干垃圾不易降解，长期堆积会占用大量土地资源，导致耕地面积减少。此外，干垃圾中的某些成分，如塑料和化学品，可能会渗入土壤和水源，造成土地和水质污染。焚烧干垃圾虽然可以减少体积，但也会释放有害气体，如二噁英等，对空气质量和人体健康构成威胁。</span></p><h2 style=\"text-align: start;\">处理方法</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">干垃圾的处理方式主要包括卫生填埋、焚烧、生物降解和回收利用。其中，卫生填埋是最常见的处理方式，适用于大部分干垃圾。焚烧法可以减少垃圾量，但需要严格的污染控制措施。生物降解则主要用于可生物降解的干垃圾，如一些植物性材料。对于部分干垃圾，如金属、玻璃、某些塑料等，可以通过回收利用，减少资源浪费。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">分类重要性</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">正确分类干垃圾不仅有助于减少环境污染，还能提高资源的回收利用率。通过将干垃圾与其他类型垃圾分开，可以避免交叉污染，使可回收物得到更有效的回收，有害垃圾得到安全处置，湿垃圾得到有效利用，从而达到资源循环利用的目的。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">结语</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">干垃圾的妥善管理是实现城市可持续发展的重要一环。通过加强公众教育，提高垃圾分类意识，优化垃圾处理设施，我们可以有效减少干垃圾带来的环境负担，朝着更加绿色、健康的城市生活环境迈进。</span></p>', 6, 0);
INSERT INTO `popularize` VALUES (20, '有害垃圾：隐藏的环境与健康威胁', '在日常生活中，我们常常会遇到一些看似普通却潜藏着巨大风险的垃圾——有害垃圾。这些垃圾因其含有有毒有害物质，不仅对环境构成严重威胁，还可能对人类健康造成不可逆转的损害。本文旨在揭示有害垃圾的本质，探讨其对环境和健康的潜在影响，以及我们应当如何妥善处理它们。', 'http://localhost:9090/files/download/有害垃圾封面.jpg', 'http://localhost:9090/files/download/有害垃圾01.jpg', 'http://localhost:9090/files/download/有害垃圾02.jpg', 'http://localhost:9090/files/download/有害垃圾03.jpg', '<h2 style=\"text-align: start;\">什么是有害垃圾？</h2><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\"> &nbsp; 有害垃圾，又称危险废物，是指在日常生产和生活中产生的，对人体健康或自然环境造成直接或潜在危害的废弃物。这类垃圾包含了多种多样的物质，从家用化学品到医疗废物，从废旧电子产品到过期药品，它们共同的特点是含有毒害性、腐蚀性、易燃性、反应性或感染性等一种或多种危险特性。</span></p><h2 style=\"text-align: start;\">有害垃圾的危害</h2><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">有害垃圾对环境和人类健康的危害主要体现在以下几个方面：</span></p><ol><li style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">环境污染：有害垃圾中的有毒物质可以渗透到土壤、水源中，造成严重的水体和土壤污染。例如，废电池中的重金属（如铅、镉、汞）会慢慢渗入地下，污染地下水；废油漆和溶剂中的有机化合物则可能挥发到空气中，加剧空气污染。</span></li><li style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">生态破坏：有害物质的泄露和扩散会破坏生态系统平衡，影响动植物的正常生长和繁殖，甚至导致物种灭绝。</span></li><li style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">健康风险：有害垃圾中的有害物质，如重金属、有机污染物、放射性物质等，可通过食物链累积，最终影响人类健康，引发癌症、神经系统疾病、生殖障碍等多种健康问题。</span></li><li style=\"text-align: start;\"><span style=\"font-size: 16px;\">火灾和爆炸风险：某些有害垃圾，如易燃液体和气体，若存放不当，还可能引发火灾或爆炸事故，造成财产损失和人员伤亡。</span></li></ol><h2 style=\"text-align: start; line-height: 3;\">正确处理有害垃圾</h2><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">鉴于有害垃圾的严重危害，正确的处理方式至关重要。以下是一些基本的处理原则：</span></p><ol><li style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">分类存放：将有害垃圾与其他垃圾分开，使用专用的容器储存，避免交叉污染。</span></li><li style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">安全收集：对于破损的有害物品，如废电池，应用透明塑料袋封装，以防泄露。</span></li><li style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">专业回收：寻找专业的有害垃圾回收站点或服务，确保有害垃圾得到安全、专业的处理。</span></li><li style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">减少产生：在日常生活中尽量减少有害垃圾的产生，如使用环保型产品替代有害化学品，合理购买和使用电子产品，避免过期药品的积累。</span></li><li style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">公众教育：提高公众对有害垃圾危害的认识，推广正确的处理知识，形成良好的环保习惯。</span></li></ol><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 16px;\">有害垃圾的管理需要全社会的共同努力，从个人做起，从家庭做起，直到整个社会形成一套完善的有害垃圾管理体系。只有这样，我们才能有效减少有害垃圾带来的环境和健康风险，保护我们共同的家园。</span></p>', 6, 14);
INSERT INTO `popularize` VALUES (21, '新能源氢能：开启绿色能源新时代', '在全球范围内，随着对环境保护意识的提升和对可持续发展的追求，新能源的研发与应用成为了世界各国共同的目标。其中，氢能作为一种清洁、高效、可持续的能源载体，正逐渐展现出其独特的魅力，被广泛认为是21世纪最具潜力的新能源之一。本文将深入探讨氢能的特性、应用前景及其在推动全球能源转型中的重要作用。', 'http://localhost:9090/files/download/新能源01.jpg', 'http://localhost:9090/files/download/新能源02.jpg', 'http://localhost:9090/files/download/新能源03.png', 'http://localhost:9090/files/download/新能源04.png', '<h2 style=\"text-align: start; line-height: 2;\">氢能：终极清洁能源</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">氢能，即通过氢与氧的化学反应所释放的能量，是一种二次能源，其最大的优势在于燃烧产物仅为水，实现了真正的零碳排放，因此被誉为“终极清洁能源”。氢的能量密度高，约为汽油的三倍，酒精的3.9倍，焦炭的4.5倍，这使其在能源存储和运输方面具有显著优势。</span></p><h2 style=\"text-align: start; line-height: 2;\">制备与来源</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">氢在自然界中以化合态存在，需要通过特定的工艺将其提取。目前主要的制氢方法包括电解水、天然气重整、煤炭气化等。其中，利用可再生能源如太阳能、风能进行水电解制氢，能够实现氢的绿色生产，避免了化石燃料制氢过程中产生的二氧化碳排放，是未来氢能产业发展的重点方向。</span></p><h2 style=\"text-align: start; line-height: 2;\">应用场景</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">氢能的应用范围广泛，涵盖了交通、工业、建筑等多个领域。在交通运输方面，氢燃料电池车（FCEV）正逐步取代传统燃油车，显著降低了尾气排放，改善了空气质量。在工业生产中，氢能可以作为原料或能源，用于钢铁、化工等行业，减少碳足迹。此外，氢能还可以作为储能介质，平衡可再生能源的波动性，提高电网的稳定性和效率。</span></p><h2 style=\"text-align: start; line-height: 2;\">发展现状与挑战</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">近年来，全球多个国家和地区已将氢能纳入国家能源战略，制定了相关政策和规划，以促进氢能产业链的形成和完善。例如，兰州新区正致力于打造全产业“氢能产业园”，旨在构建一个集绿电制氢、氢储能、氢运输、氢应用和氢燃料电池制造为一体的综合性氢能产业集群。</span></p><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">然而，氢能产业的发展也面临着诸多挑战，包括高成本的制氢、储氢和输氢技术，以及缺乏成熟的基础设施和安全标准。此外，如何实现氢的规模化生产和应用，降低成本，提高效率，是氢能迈向商业化和普及化的关键。</span></p><h2 style=\"text-align: start; line-height: 2;\">展望未来</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">氢能作为新能源的代表，不仅能够推动能源结构的优化升级，还能够促进全球经济向低碳、环保的方向转变。随着技术的不断进步和政策的持续支持，氢能有望在不远的将来成为全球能源体系中的重要组成部分，引领我们进入一个更加绿色、清洁、可持续的能源新时代。</span></p><h2 style=\"text-align: start; line-height: 2;\">结语</h2><p style=\"text-align: start; line-height: 2;\"><span style=\"font-size: 16px;\">氢能的发展正处于历史的关键时刻，各国政府、企业和科研机构正在共同努力，克服技术瓶颈，完善产业链条，推动氢能市场的成熟。我们有理由相信，在不久的将来，氢能将成为人类能源消费的主要选择之一，为地球的可持续发展贡献力量。</span></p>', 5, 0);
INSERT INTO `popularize` VALUES (22, '水热液化：新兴的生物化学转化技术', '随着全球能源需求的不断增长和对环境可持续性的日益关注，寻找新型、高效的能源转换技术变得至关重要。水热液化（Hydrothermal Liquefaction, HTL）作为一种新兴的生物化学转化技术，近年来引起了科研界和产业界的广泛关注。它不仅能够将生物质转化为液态燃料，还具有高能效、低排放的特点，是实现绿色能源转型的重要手段之一。', 'http://localhost:9090/files/download/水热液化04.png', 'http://localhost:9090/files/download/水热液化03.png', 'http://localhost:9090/files/download/水热液化01.png', 'http://localhost:9090/files/download/水热液化02.jpg', '<h2 style=\"text-align: start; line-height: 2.5;\">技术原理</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">水热液化是一种在高温（通常为300°C至400°C）和高压（约20至30 MPa）条件下，利用水作为反应介质将生物质转化为生物油的过程。在这样的条件下，水进入超临界状态，具备了特殊的物理和化学性质，如低介电常数和高溶解能力，使得生物质能够快速且有效地分解。这个过程类似于地球上化石燃料形成的自然过程，但极大地缩短了所需的时间，从地质时期的数百万年压缩到了几个小时，甚至是几分钟。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">应用范围</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">水热液化技术适用于各种类型的生物质原料，包括但不限于农业废弃物、林业剩余物、食物残渣、藻类以及城市固体废物等。这些原料经过预处理后，可以被高效转化为生物油，这种生物油的性质类似于传统石油，可用于生产生物燃料，如柴油和航空煤油，同时也可作为化工原料，生产一系列高附加值的产品。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">技术优势</h2><ul><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>高效转化</strong></span><span style=\"font-size: 16px;\">：水热液化能够实现高产率的生物油转化，同时减少固体残留物的生成，提高了原料的利用率。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>环境友好</strong></span><span style=\"font-size: 16px;\">：相较于其他生物质转化技术，水热液化产生的温室气体排放较低，且废水易于处理，减少了对环境的负面影响。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>原料灵活性</strong></span><span style=\"font-size: 16px;\">：该技术可以处理多种类型的生物质原料，无需复杂的预处理步骤，降低了原料成本和加工难度。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>能源密集型产品</strong></span><span style=\"font-size: 16px;\">：生成的生物油具有较高的能量密度，可以直接替代传统化石燃料，适用于现有的炼油和运输基础设施。</span></li></ul><h2 style=\"text-align: start; line-height: 2.5;\">挑战与前景</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">尽管水热液化技术展现出了巨大的潜力，但它仍面临一些挑战，包括高昂的设备投资、过程控制的复杂性以及催化剂的选择和开发等。此外，为了实现大规模的商业化应用，还需要解决经济性和可持续性的问题，包括原料供应链的建立、生物油的精炼技术和市场接受度等。</span></p><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">然而，随着研究的深入和技术的进步，这些问题正在逐步得到解决。政府和企业的投资、政策支持以及国际合作为水热液化技术的发展提供了有力的推动力。预计在未来几年，水热液化有望成为生物质能源转换领域的一项关键技术，为构建低碳、可持续的能源体系作出重要贡献。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">结论</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">水热液化作为一种先进的生物化学转化技术，为生物质能源的高效利用开辟了新路径。它不仅能够促进能源结构的多元化，减轻对化石燃料的依赖，还有助于减少温室气体排放，对抗气候变化。随着技术的不断成熟和应用范围的扩大，水热液化将在全球能源转型中扮演越来越重要的角色，引领我们走向更加绿色、清洁的能源未来。</span></p>', 5, 0);
INSERT INTO `popularize` VALUES (23, '垃圾焚烧发电：清洁与争议并存的能源革命', '随着全球人口的不断增长和城市化进程的加速，垃圾处理成为了一个日益严峻的挑战。传统填埋方式不仅占用大量土地资源，还可能引发地下水污染等问题。在此背景下，垃圾焚烧发电作为一种新兴的废物处理和能源回收技术，逐渐吸引了人们的关注。本文将深入探讨垃圾焚烧发电的原理、优势、挑战及其未来的发展方向。', 'http://localhost:9090/files/download/垃圾焚烧发电05.png', 'http://localhost:9090/files/download/垃圾焚烧发电04.png', 'http://localhost:9090/files/download/垃圾焚烧发电03.png', 'http://localhost:9090/files/download/垃圾焚烧发电02.png', '<h2 style=\"text-align: start;\">原理与流程</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">垃圾焚烧发电的基本原理是通过高温焚烧城市固体废物，将有机物质转化为热能，再利用此热能产生蒸汽驱动涡轮发电机，从而生成电力。这一过程通常包括以下几个关键步骤：</span></p><ol><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>垃圾接收与储存</strong></span><span style=\"font-size: 16px;\">：城市固体废物被运送到处理设施，进行初步的分类和储存。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>焚烧</strong></span><span style=\"font-size: 16px;\">：废物在焚烧炉中被加热至800°C至1000°C之间，确保有机物的彻底分解。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>热能回收</strong></span><span style=\"font-size: 16px;\">：焚烧产生的高温烟气通过锅炉系统，将热量传递给水，产生蒸汽。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>发电</strong></span><span style=\"font-size: 16px;\">：蒸汽推动涡轮机旋转，涡轮机带动发电机产生电能。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>尾气处理</strong></span><span style=\"font-size: 16px;\">：烟气在排放前需经过一系列净化处理，以去除有害物质，如二恶英、重金属等。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>残渣处理</strong></span><span style=\"font-size: 16px;\">：焚烧后的残留物，如底灰和飞灰，需进一步处理，通常进行固化或填埋。</span></li></ol><h2 style=\"text-align: start;\">优势分析</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">垃圾焚烧发电技术具有显著的优势，主要包括：</span></p><ul><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>减量化</strong></span><span style=\"font-size: 16px;\">：垃圾经过高温焚烧后，体积可减少90%以上，显著减轻了后续处理的压力。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>能源回收</strong></span><span style=\"font-size: 16px;\">：将垃圾中的化学能转化为电能，实现了废物的资源化利用。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>占地节省</strong></span><span style=\"font-size: 16px;\">：相比传统填埋，焚烧设施占地面积小，更适合土地资源紧张的城市区域。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>卫生与环境效益</strong></span><span style=\"font-size: 16px;\">：减少了垃圾填埋带来的病媒生物滋生和地下水污染风险。</span></li></ul><h2 style=\"text-align: start;\">面临的挑战</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">然而，垃圾焚烧发电并非没有争议，它也面临着一些棘手的问题：</span></p><ul><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>环境污染</strong></span><span style=\"font-size: 16px;\">：虽然现代焚烧技术能够有效控制排放，但仍有可能产生二恶英等有害物质，对空气质量和人体健康构成威胁。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>高昂的成本</strong></span><span style=\"font-size: 16px;\">：建设及维护现代化的焚烧发电厂需要巨额的投资，且运营成本也不低。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>资源浪费</strong></span><span style=\"font-size: 16px;\">：焚烧过程中，一些原本可回收利用的材料可能被破坏，减少了资源的循环利用机会。</span></li></ul><h2 style=\"text-align: start; line-height: 2.5;\">未来展望</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">尽管存在争议，垃圾焚烧发电仍是城市可持续发展的重要组成部分。未来的发展趋势可能包括：</span></p><ul><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>技术创新</strong></span><span style=\"font-size: 16px;\">：研发更高效的焚烧技术和更先进的污染控制手段，以减少对环境的影响。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>政策引导</strong></span><span style=\"font-size: 16px;\">：政府应出台相关政策，鼓励垃圾分类和资源回收，提高焚烧发电的经济效益。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\"><strong>公众参与</strong></span><span style=\"font-size: 16px;\">：提升公众对垃圾焚烧发电的认知和支持度，促进社区参与和监督机制的建立。</span></li></ul><h2 style=\"text-align: start;\">结论</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">垃圾焚烧发电是一项复杂而微妙的技术，它在解决废物处理难题的同时，也带来了环境和经济方面的考量。面对未来的挑战，持续的技术创新、合理的政策制定以及广泛的公众教育将是推动这一行业健康发展的关键因素。只有综合考虑技术、经济、环境和社会多方面因素，才能真正实现垃圾焚烧发电的可持续发展，使之成为城市绿色转型的有效助力。</span></p>', 5, 0);
INSERT INTO `popularize` VALUES (24, '低碳生活：节约用电，从点滴做起', '在当今世界，随着工业化和城市化进程的加快，能源消耗急剧上升，环境问题日益严峻。电力，作为现代生活不可或缺的能源，其生产和消费过程对环境的影响不容忽视。节约用电，不仅能够减少对自然资源的过度开采，降低温室气体排放，还能有效缓解能源短缺，推动社会向低碳经济转型。本文将探讨如何在日常生活中实践节约用电，迈向低碳生活。', 'http://localhost:9090/files/download/节约用电01.png', 'http://localhost:9090/files/download/节约用电01.png', 'http://localhost:9090/files/download/节约用电02.png', 'http://localhost:9090/files/download/节约用电03.png', '<h2 style=\"text-align: start; line-height: 2.5;\">认识节约用电的重要性</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">节约用电的意义远远超过简单的经济节省。电力生产过程中，尤其是燃煤发电，会产生大量的二氧化碳和其他污染物，加剧全球变暖和环境污染。因此，减少电力需求意味着降低对化石燃料的依赖，减少温室气体排放，保护生态环境。</span></p><h2 style=\"text-align: start;\">节约用电的实践方法</h2><ol><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">智能使用家用电器：选择能效高的家电产品，如LED灯泡、节能冰箱和空调等。使用时，遵循制造商的节能建议，如将冰箱放置在阴凉通风的位置，避免频繁开关门；调节空调温度至舒适但不过低的水平。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">养成良好习惯：离开房间时记得关灯，不使用的电器及时断电，避免待机状态下的隐形耗电。充分利用自然光，减少白天的照明需求。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">利用技术辅助：安装智能插座和定时器，自动控制电器的开关，避免不必要的电力浪费。智能恒温器可以帮助优化家庭供暖和制冷系统的运行，减少能源消耗。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">提倡自然通风：在适宜的季节，优先选择开窗通风而非使用空调，既节能又健康。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">优化工作环境：在办公室和工作场所，推行双面打印，减少打印机的使用频率，下班后确保所有设备完全关闭。</span></li><li style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">教育和宣传：提升公众对节约用电重要性的认识，鼓励家人、朋友和同事共同参与节能减排行动。</span></li></ol><h2 style=\"text-align: start; line-height: 2.5;\">教育和意识提升</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">低碳生活和节约用电的实践，离不开每个人的自觉参与和持续努力。学校和社区可以组织节能知识讲座，开展节约用电主题活动，通过教育和宣传，培养下一代的环保意识和责任感。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">结语</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">节约用电是低碳生活的重要组成部分，它关乎个人的生活质量，也关系到地球的未来。通过采取上述措施，我们不仅能够减少能源消耗，降低生活成本，还能为子孙后代留下一个更加绿色、健康的居住环境。让我们从自身做起，从现在做起，共同为实现低碳生活目标而努力，让节约用电成为一种生活方式，让地球因我们的行动而更加美好。</span></p>', 4, 0);
INSERT INTO `popularize` VALUES (25, '骑行的力量：低碳生活中的绿色旋律', '在全球气候变暖的背景下，追求低碳生活方式已成为人们共同的责任与行动。骑自行车，作为一种简单却有效的低碳出行方式，不仅能够减少温室气体排放，还能促进身体健康，美化城市环境。本文将探讨骑自行车对个人健康、环境保护以及社会文化的影响，鼓励大家加入到绿色出行的行列中来。', 'http://localhost:9090/files/download/骑行照片01.png', 'http://localhost:9090/files/download/骑行照片02.png', 'http://localhost:9090/files/download/骑行照片03.png', 'http://localhost:9090/files/download/骑行照片04.png', '<h2 style=\"text-align: start; line-height: 2.5;\">自行车：低碳出行的使者</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">自行车作为一种人力驱动的交通工具，几乎不产生温室气体排放，与汽车、摩托车等机动车辆相比，其碳足迹接近于零。选择骑自行车代替驾车，可以显著减少个人碳排放量，对减缓全球气候变化做出积极贡献。据统计，如果每个人每周少开一天车，改用自行车代步，每年可减少数吨的二氧化碳排放。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">健康与快乐同行</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">骑行不仅仅是一种出行方式，更是一种生活方式的体现。定期骑自行车可以提高心肺功能，增强肌肉力量，改善心血管健康，甚至有助于控制体重和预防多种慢性疾病。此外，骑行还能带来精神上的愉悦，让人在自然中呼吸新鲜空气，享受沿途风景，缓解日常生活的压力。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">构建绿色城市</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">推广自行车出行，有助于塑造绿色、健康、宜居的城市环境。城市规划者可以通过建设自行车道、设立公共自行车租赁系统等方式，鼓励市民选择自行车作为日常出行工具。这不仅可以减少交通拥堵，降低空气污染，还能促进城市空间的合理利用，提升居民生活质量。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">文化与社区的融合</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">自行车不仅仅是交通工具，它还是连接人与人、社区与社区的纽带。越来越多的城市举办自行车节、低碳生活骑行活动，不仅促进了健康生活方式的普及，还增强了社区凝聚力，让人们在共同的目标下相互支持，共享绿色出行的乐趣。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">实践低碳生活</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">要让自行车成为日常出行的首选，需要从个人做起，培养良好的骑行习惯。无论是上下班通勤，还是周末郊游，都可以选择自行车作为出行工具。同时，政府和社会各界也应加强基础设施建设，完善自行车友好的城市规划，提供安全、便捷的骑行环境，激发更多人加入到低碳出行的行列。</span></p><h2 style=\"text-align: start; line-height: 2.5;\">结语</h2><p style=\"text-align: start; line-height: 2.5;\"><span style=\"font-size: 16px;\">骑自行车，不仅是一种低碳、健康的出行方式，更是一种对美好生活的向往和追求。让我们一起行动起来，用双脚踏出绿色的旋律，为地球的未来添上一抹清新的色彩。每一次骑行，都是对低碳生活的承诺，是对健康、环境和未来的投资。让我们携手，共创一个更加绿色、健康、和谐的明天。</span></p><p style=\"text-align: start; line-height: 2.5;\"><img src=\"http://localhost:9090/files/download/1733995849496-微信截图_20241212172707.png\" alt=\"\" data-href=\"\" style=\"width: 50%;\"></p><p style=\"text-align: start; line-height: 2.5;\"><br></p>', 4, 0);

-- ----------------------------
-- Table structure for popularize_type
-- ----------------------------
DROP TABLE IF EXISTS `popularize_type`;
CREATE TABLE `popularize_type`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类名称',
  `img` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '宣传分类信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of popularize_type
-- ----------------------------
INSERT INTO `popularize_type` VALUES (4, '低碳生活', 'http://localhost:9090/files/download/低碳生活.jpg');
INSERT INTO `popularize_type` VALUES (5, '绿色能源', 'http://localhost:9090/files/download/绿色能源.jpg');
INSERT INTO `popularize_type` VALUES (6, '垃圾分类', 'http://localhost:9090/files/download/垃圾分类.jpg');

-- ----------------------------
-- Table structure for recovery_records
-- ----------------------------
DROP TABLE IF EXISTS `recovery_records`;
CREATE TABLE `recovery_records`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` INT(11) NULL DEFAULT NULL COMMENT '用户id',
  `garbage_id` INT(11) NULL DEFAULT NULL COMMENT '可回收垃圾id',
  `community_id` INT(11) NULL DEFAULT NULL COMMENT '社区id',
  `site_id` INT(11) NULL DEFAULT NULL COMMENT '回收点id',
  `num` INT(11) NULL DEFAULT NULL COMMENT '回收数量',
  `score` INT(11) NULL DEFAULT NULL COMMENT '总计积分',
  `time` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请时间',
  `remark` VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `img` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '可回收垃圾照片',
  `status` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回收状态',
  `reject_reason` VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拒绝备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '垃圾回收记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recovery_records
-- ----------------------------
INSERT INTO `recovery_records` VALUES (17, 2, 3, 3, 3, 1, 10, '2025-05-07 10:24:00', NULL, 'http://localhost:9090/files/download/旧书图片.jpg', '通过', NULL);
INSERT INTO `recovery_records` VALUES (18, 2, 3, 3, 3, 1, 10, '2025-05-08 10:24:00', NULL, 'http://localhost:9090/files/download/旧书图片.jpg', '拒绝', '111');
INSERT INTO `recovery_records` VALUES (19, 2, 6, 7, 7, 1, 20, '2025-05-08 10:59:00', '请尽快审核！谢谢', 'http://localhost:9090/files/download/铝制易拉罐图片.jpg', '通过', NULL);
INSERT INTO `recovery_records` VALUES (20, 2, 5, 6, 4, 1, 10, '2025-05-08 11:01:12', NULL, 'http://localhost:9090/files/download/废报纸图片.jpg', '通过', NULL);
INSERT INTO `recovery_records` VALUES (21, 3, 6, 6, 4, 1, 20, '2025-05-08 16:01:08', '11', 'http://localhost:9090/files/download/铝制易拉罐图片.jpg', '通过', NULL);
INSERT INTO `recovery_records` VALUES (22, 3, 6, 6, 4, 1, 20, '2025-05-08 16:04:04', '11', 'http://localhost:9090/files/download/铝制易拉罐图片.jpg', '通过', NULL);
INSERT INTO `recovery_records` VALUES (23, 3, 5, 6, 4, 1, 10, '2025-05-10 17:01:08', NULL, 'http://localhost:9090/files/download/废报纸图片.jpg', '通过', NULL);
INSERT INTO `recovery_records` VALUES (24, 2, 3, 3, 3, 1, 10, '2025-05-10 12:45:23', NULL, 'http://localhost:9090/files/download/旧书图片.jpg', '拒绝', '222');
INSERT INTO `recovery_records` VALUES (25, 2, 3, 3, 3, 1, 10, '2025-05-10 17:21:12', NULL, 'http://localhost:9090/files/download/旧书图片.jpg', '通过', NULL);
INSERT INTO `recovery_records` VALUES (26, 3, 6, 6, 4, 1, 20, '2025-05-12 18:04:45', NULL, 'http://localhost:9090/files/download/铝制易拉罐图片.jpg', '通过', NULL);
INSERT INTO `recovery_records` VALUES (27, 2, 3, 3, 3, 1, 10, '2025-05-12 19:21:23', NULL, 'http://localhost:9090/files/download/旧书图片.jpg', '通过', NULL);

-- ----------------------------
-- Table structure for recovery_site
-- ----------------------------
DROP TABLE IF EXISTS `recovery_site`;
CREATE TABLE `recovery_site`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `community_id` INT(11) NULL DEFAULT NULL COMMENT '社区ID',
  `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '投放点名称',
  `img` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '投放点照片',
  `content` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '详情',
  `time_range` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开放时间',
  `manager_id` INT(11) NULL DEFAULT NULL COMMENT '管理员ID',
  `status` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回收点状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '垃圾回收点信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recovery_site
-- ----------------------------
INSERT INTO `recovery_site` VALUES (1, 5, '桂花坪社区1号投放点', 'http://localhost:9090/files/download/垃圾回收点01.png', '<p style=\"text-align: start; line-height: 2;\"> &nbsp;<span style=\"font-size: 19px;\">垃圾站点处理垃圾的过程通常涉及多个步骤，这些步骤旨在确保垃圾能够被安全、高效地处理，同时尽量减少对环境的影响。以下是一般垃圾站点处理垃圾的基本步骤：</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾收集：垃圾首先由家庭、商业场所等源头产生，随后通过垃圾桶、垃圾袋等形式被收集起来。城市通常会有固定的垃圾收集日，环卫工人或专门的垃圾收集车辆会定期收集垃圾。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">转运至垃圾中转站：收集的垃圾会被运送到垃圾中转站。在中转站，垃圾可能经过初步的分拣和压缩，以减少体积，便于运输。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">分类处理：在一些先进的垃圾处理设施中，垃圾会被进一步分类，比如分为可回收物、厨余垃圾、有害垃圾和其他垃圾。分类有助于提高回收利用率，减少填埋量。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾填埋：无法回收或处理的垃圾会被运送到垃圾填埋场。在填埋之前，垃圾会被压实，并在填埋场底部铺设防渗层，以防止渗滤液污染地下水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾焚烧：部分垃圾站点配备有焚烧设施，将垃圾在高温下燃烧，产生的热量可以用来发电，烟气则需经过净化处理，确保排放符合环保标准。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">堆肥处理：对于厨余垃圾等有机废弃物，可以进行堆肥处理，通过微生物分解转化为肥料。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">渗滤液处理：垃圾填埋过程中产生的渗滤液需收集并进行处理，以防止污染地下水和地表水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">资源化利用：焚烧产生的灰烬和堆肥后的残留物可以尝试进行资源化利用，如作为建筑材料的原料或土壤改良剂。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">环境监测：垃圾处理过程中，会对周围环境进行持续监测，确保处理活动不会对空气、水体和土壤造成污染。</span></p><p style=\"text-align: start;\"><br></p><p style=\"text-align: center;\"><img src=\"http://43.142.9.148:9092/files/download/1723014240589-%E5%9E%83%E5%9C%BE%E5%A4%84%E7%90%86%E6%AD%A5%E9%AA%A4.jpg\" alt=\"\" data-href=\"\" style=\"width: 100%;\"></p>', '08:30 - 17:00', 3, '运行中');
INSERT INTO `recovery_site` VALUES (2, 7, '月亮岛社区1号投放点', 'http://localhost:9090/files/download/垃圾回收点02.png', '<p style=\"text-align: start; line-height: 2;\"> &nbsp;<span style=\"font-size: 19px;\">垃圾站点处理垃圾的过程通常涉及多个步骤，这些步骤旨在确保垃圾能够被安全、高效地处理，同时尽量减少对环境的影响。以下是一般垃圾站点处理垃圾的基本步骤：</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾收集：垃圾首先由家庭、商业场所等源头产生，随后通过垃圾桶、垃圾袋等形式被收集起来。城市通常会有固定的垃圾收集日，环卫工人或专门的垃圾收集车辆会定期收集垃圾。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">转运至垃圾中转站：收集的垃圾会被运送到垃圾中转站。在中转站，垃圾可能经过初步的分拣和压缩，以减少体积，便于运输。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">分类处理：在一些先进的垃圾处理设施中，垃圾会被进一步分类，比如分为可回收物、厨余垃圾、有害垃圾和其他垃圾。分类有助于提高回收利用率，减少填埋量。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾填埋：无法回收或处理的垃圾会被运送到垃圾填埋场。在填埋之前，垃圾会被压实，并在填埋场底部铺设防渗层，以防止渗滤液污染地下水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾焚烧：部分垃圾站点配备有焚烧设施，将垃圾在高温下燃烧，产生的热量可以用来发电，烟气则需经过净化处理，确保排放符合环保标准。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">堆肥处理：对于厨余垃圾等有机废弃物，可以进行堆肥处理，通过微生物分解转化为肥料。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">渗滤液处理：垃圾填埋过程中产生的渗滤液需收集并进行处理，以防止污染地下水和地表水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">资源化利用：焚烧产生的灰烬和堆肥后的残留物可以尝试进行资源化利用，如作为建筑材料的原料或土壤改良剂。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">环境监测：垃圾处理过程中，会对周围环境进行持续监测，确保处理活动不会对空气、水体和土壤造成污染。</span></p><p style=\"text-align: start;\"><br></p><p style=\"text-align: center;\"><img src=\"http://43.142.9.148:9092/files/download/1723014240589-%E5%9E%83%E5%9C%BE%E5%A4%84%E7%90%86%E6%AD%A5%E9%AA%A4.jpg\" alt=\"\" data-href=\"\" style=\"width: 100%;\"></p>', '08:00 - 20:30', 3, '运行中');
INSERT INTO `recovery_site` VALUES (3, 3, '月湖社区1号投放点', 'http://localhost:9090/files/download/垃圾回收点03.png', '<p style=\"text-align: start; line-height: 2;\"> &nbsp;<span style=\"font-size: 19px;\">垃圾站点处理垃圾的过程通常涉及多个步骤，这些步骤旨在确保垃圾能够被安全、高效地处理，同时尽量减少对环境的影响。以下是一般垃圾站点处理垃圾的基本步骤：</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾收集：垃圾首先由家庭、商业场所等源头产生，随后通过垃圾桶、垃圾袋等形式被收集起来。城市通常会有固定的垃圾收集日，环卫工人或专门的垃圾收集车辆会定期收集垃圾。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">转运至垃圾中转站：收集的垃圾会被运送到垃圾中转站。在中转站，垃圾可能经过初步的分拣和压缩，以减少体积，便于运输。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">分类处理：在一些先进的垃圾处理设施中，垃圾会被进一步分类，比如分为可回收物、厨余垃圾、有害垃圾和其他垃圾。分类有助于提高回收利用率，减少填埋量。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾填埋：无法回收或处理的垃圾会被运送到垃圾填埋场。在填埋之前，垃圾会被压实，并在填埋场底部铺设防渗层，以防止渗滤液污染地下水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾焚烧：部分垃圾站点配备有焚烧设施，将垃圾在高温下燃烧，产生的热量可以用来发电，烟气则需经过净化处理，确保排放符合环保标准。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">堆肥处理：对于厨余垃圾等有机废弃物，可以进行堆肥处理，通过微生物分解转化为肥料。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">渗滤液处理：垃圾填埋过程中产生的渗滤液需收集并进行处理，以防止污染地下水和地表水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">资源化利用：焚烧产生的灰烬和堆肥后的残留物可以尝试进行资源化利用，如作为建筑材料的原料或土壤改良剂。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">环境监测：垃圾处理过程中，会对周围环境进行持续监测，确保处理活动不会对空气、水体和土壤造成污染。</span></p><p style=\"text-align: start;\"><br></p><p style=\"text-align: center;\"><img src=\"http://43.142.9.148:9092/files/download/1723014240589-%E5%9E%83%E5%9C%BE%E5%A4%84%E7%90%86%E6%AD%A5%E9%AA%A4.jpg\" alt=\"\" data-href=\"\" style=\"width: 100%;\"></p>', '09:00 - 21:00', 3, '运行中');
INSERT INTO `recovery_site` VALUES (4, 6, '浏阳河社区1号投放点', 'http://localhost:9090/files/download/垃圾回收点04.png', '<p style=\"text-align: start; line-height: 2;\"> &nbsp;<span style=\"font-size: 19px;\">垃圾站点处理垃圾的过程通常涉及多个步骤，这些步骤旨在确保垃圾能够被安全、高效地处理，同时尽量减少对环境的影响。以下是一般垃圾站点处理垃圾的基本步骤：</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾收集：垃圾首先由家庭、商业场所等源头产生，随后通过垃圾桶、垃圾袋等形式被收集起来。城市通常会有固定的垃圾收集日，环卫工人或专门的垃圾收集车辆会定期收集垃圾。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">转运至垃圾中转站：收集的垃圾会被运送到垃圾中转站。在中转站，垃圾可能经过初步的分拣和压缩，以减少体积，便于运输。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">分类处理：在一些先进的垃圾处理设施中，垃圾会被进一步分类，比如分为可回收物、厨余垃圾、有害垃圾和其他垃圾。分类有助于提高回收利用率，减少填埋量。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾填埋：无法回收或处理的垃圾会被运送到垃圾填埋场。在填埋之前，垃圾会被压实，并在填埋场底部铺设防渗层，以防止渗滤液污染地下水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾焚烧：部分垃圾站点配备有焚烧设施，将垃圾在高温下燃烧，产生的热量可以用来发电，烟气则需经过净化处理，确保排放符合环保标准。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">堆肥处理：对于厨余垃圾等有机废弃物，可以进行堆肥处理，通过微生物分解转化为肥料。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">渗滤液处理：垃圾填埋过程中产生的渗滤液需收集并进行处理，以防止污染地下水和地表水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">资源化利用：焚烧产生的灰烬和堆肥后的残留物可以尝试进行资源化利用，如作为建筑材料的原料或土壤改良剂。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">环境监测：垃圾处理过程中，会对周围环境进行持续监测，确保处理活动不会对空气、水体和土壤造成污染。</span></p><p style=\"text-align: start;\"><br></p><p style=\"text-align: center;\"><img src=\"http://43.142.9.148:9092/files/download/1723014240589-%E5%9E%83%E5%9C%BE%E5%A4%84%E7%90%86%E6%AD%A5%E9%AA%A4.jpg\" alt=\"\" data-href=\"\" style=\"width: 100%;\"></p>', '09:00 - 20:30', 2, '运行中');
INSERT INTO `recovery_site` VALUES (5, 4, '大泽湖社区1号投放点', 'http://localhost:9090/files/download/垃圾回收点05.png', '<p style=\"text-align: start; line-height: 2;\"> &nbsp;<span style=\"font-size: 19px;\">垃圾站点处理垃圾的过程通常涉及多个步骤，这些步骤旨在确保垃圾能够被安全、高效地处理，同时尽量减少对环境的影响。以下是一般垃圾站点处理垃圾的基本步骤：</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾收集：垃圾首先由家庭、商业场所等源头产生，随后通过垃圾桶、垃圾袋等形式被收集起来。城市通常会有固定的垃圾收集日，环卫工人或专门的垃圾收集车辆会定期收集垃圾。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">转运至垃圾中转站：收集的垃圾会被运送到垃圾中转站。在中转站，垃圾可能经过初步的分拣和压缩，以减少体积，便于运输。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">分类处理：在一些先进的垃圾处理设施中，垃圾会被进一步分类，比如分为可回收物、厨余垃圾、有害垃圾和其他垃圾。分类有助于提高回收利用率，减少填埋量。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾填埋：无法回收或处理的垃圾会被运送到垃圾填埋场。在填埋之前，垃圾会被压实，并在填埋场底部铺设防渗层，以防止渗滤液污染地下水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾焚烧：部分垃圾站点配备有焚烧设施，将垃圾在高温下燃烧，产生的热量可以用来发电，烟气则需经过净化处理，确保排放符合环保标准。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">堆肥处理：对于厨余垃圾等有机废弃物，可以进行堆肥处理，通过微生物分解转化为肥料。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">渗滤液处理：垃圾填埋过程中产生的渗滤液需收集并进行处理，以防止污染地下水和地表水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">资源化利用：焚烧产生的灰烬和堆肥后的残留物可以尝试进行资源化利用，如作为建筑材料的原料或土壤改良剂。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">环境监测：垃圾处理过程中，会对周围环境进行持续监测，确保处理活动不会对空气、水体和土壤造成污染。</span></p><p style=\"text-align: start;\"><br></p><p style=\"text-align: center;\"><img src=\"http://43.142.9.148:9092/files/download/1723014240589-%E5%9E%83%E5%9C%BE%E5%A4%84%E7%90%86%E6%AD%A5%E9%AA%A4.jpg\" alt=\"\" data-href=\"\" style=\"width: 100%;\"></p>', '08:30 - 19:30', 2, '运行中');
INSERT INTO `recovery_site` VALUES (6, 7, '月亮岛社区2号投放点', 'http://localhost:9090/files/download/垃圾回收点02.png', '<p style=\"text-align: start; line-height: 2;\"> &nbsp;<span style=\"font-size: 19px;\">垃圾站点处理垃圾的过程通常涉及多个步骤，这些步骤旨在确保垃圾能够被安全、高效地处理，同时尽量减少对环境的影响。以下是一般垃圾站点处理垃圾的基本步骤：</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾收集：垃圾首先由家庭、商业场所等源头产生，随后通过垃圾桶、垃圾袋等形式被收集起来。城市通常会有固定的垃圾收集日，环卫工人或专门的垃圾收集车辆会定期收集垃圾。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">转运至垃圾中转站：收集的垃圾会被运送到垃圾中转站。在中转站，垃圾可能经过初步的分拣和压缩，以减少体积，便于运输。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">分类处理：在一些先进的垃圾处理设施中，垃圾会被进一步分类，比如分为可回收物、厨余垃圾、有害垃圾和其他垃圾。分类有助于提高回收利用率，减少填埋量。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾填埋：无法回收或处理的垃圾会被运送到垃圾填埋场。在填埋之前，垃圾会被压实，并在填埋场底部铺设防渗层，以防止渗滤液污染地下水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾焚烧：部分垃圾站点配备有焚烧设施，将垃圾在高温下燃烧，产生的热量可以用来发电，烟气则需经过净化处理，确保排放符合环保标准。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">堆肥处理：对于厨余垃圾等有机废弃物，可以进行堆肥处理，通过微生物分解转化为肥料。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">渗滤液处理：垃圾填埋过程中产生的渗滤液需收集并进行处理，以防止污染地下水和地表水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">资源化利用：焚烧产生的灰烬和堆肥后的残留物可以尝试进行资源化利用，如作为建筑材料的原料或土壤改良剂。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">环境监测：垃圾处理过程中，会对周围环境进行持续监测，确保处理活动不会对空气、水体和土壤造成污染。</span></p><p style=\"text-align: start;\"><br></p><p style=\"text-align: center;\"><img src=\"http://43.142.9.148:9092/files/download/1723014240589-%E5%9E%83%E5%9C%BE%E5%A4%84%E7%90%86%E6%AD%A5%E9%AA%A4.jpg\" alt=\"\" data-href=\"\" style=\"width: 100%;\"></p>', '08:00 - 20:30', 3, '运行中');
INSERT INTO `recovery_site` VALUES (7, 7, '月亮岛社区3号投放点', 'http://localhost:9090/files/download/垃圾回收点02.png', '<p style=\"text-align: start; line-height: 2;\"> &nbsp;<span style=\"font-size: 19px;\">垃圾站点处理垃圾的过程通常涉及多个步骤，这些步骤旨在确保垃圾能够被安全、高效地处理，同时尽量减少对环境的影响。以下是一般垃圾站点处理垃圾的基本步骤：</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾收集：垃圾首先由家庭、商业场所等源头产生，随后通过垃圾桶、垃圾袋等形式被收集起来。城市通常会有固定的垃圾收集日，环卫工人或专门的垃圾收集车辆会定期收集垃圾。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">转运至垃圾中转站：收集的垃圾会被运送到垃圾中转站。在中转站，垃圾可能经过初步的分拣和压缩，以减少体积，便于运输。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">分类处理：在一些先进的垃圾处理设施中，垃圾会被进一步分类，比如分为可回收物、厨余垃圾、有害垃圾和其他垃圾。分类有助于提高回收利用率，减少填埋量。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾填埋：无法回收或处理的垃圾会被运送到垃圾填埋场。在填埋之前，垃圾会被压实，并在填埋场底部铺设防渗层，以防止渗滤液污染地下水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾焚烧：部分垃圾站点配备有焚烧设施，将垃圾在高温下燃烧，产生的热量可以用来发电，烟气则需经过净化处理，确保排放符合环保标准。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">堆肥处理：对于厨余垃圾等有机废弃物，可以进行堆肥处理，通过微生物分解转化为肥料。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">渗滤液处理：垃圾填埋过程中产生的渗滤液需收集并进行处理，以防止污染地下水和地表水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">资源化利用：焚烧产生的灰烬和堆肥后的残留物可以尝试进行资源化利用，如作为建筑材料的原料或土壤改良剂。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">环境监测：垃圾处理过程中，会对周围环境进行持续监测，确保处理活动不会对空气、水体和土壤造成污染。</span></p><p style=\"text-align: start;\"><br></p><p style=\"text-align: center;\"><img src=\"http://43.142.9.148:9092/files/download/1723014240589-%E5%9E%83%E5%9C%BE%E5%A4%84%E7%90%86%E6%AD%A5%E9%AA%A4.jpg\" alt=\"\" data-href=\"\" style=\"width: 100%;\"></p>', '08:30 - 20:30', 3, '运行中');
INSERT INTO `recovery_site` VALUES (8, 4, '大泽湖社区2号投放点', 'http://localhost:9090/files/download/垃圾回收点05.png', '<p style=\"text-align: start; line-height: 2;\"> &nbsp;<span style=\"font-size: 19px;\">垃圾站点处理垃圾的过程通常涉及多个步骤，这些步骤旨在确保垃圾能够被安全、高效地处理，同时尽量减少对环境的影响。以下是一般垃圾站点处理垃圾的基本步骤：</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾收集：垃圾首先由家庭、商业场所等源头产生，随后通过垃圾桶、垃圾袋等形式被收集起来。城市通常会有固定的垃圾收集日，环卫工人或专门的垃圾收集车辆会定期收集垃圾。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">转运至垃圾中转站：收集的垃圾会被运送到垃圾中转站。在中转站，垃圾可能经过初步的分拣和压缩，以减少体积，便于运输。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">分类处理：在一些先进的垃圾处理设施中，垃圾会被进一步分类，比如分为可回收物、厨余垃圾、有害垃圾和其他垃圾。分类有助于提高回收利用率，减少填埋量。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾填埋：无法回收或处理的垃圾会被运送到垃圾填埋场。在填埋之前，垃圾会被压实，并在填埋场底部铺设防渗层，以防止渗滤液污染地下水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">垃圾焚烧：部分垃圾站点配备有焚烧设施，将垃圾在高温下燃烧，产生的热量可以用来发电，烟气则需经过净化处理，确保排放符合环保标准。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">堆肥处理：对于厨余垃圾等有机废弃物，可以进行堆肥处理，通过微生物分解转化为肥料。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">渗滤液处理：垃圾填埋过程中产生的渗滤液需收集并进行处理，以防止污染地下水和地表水。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">资源化利用：焚烧产生的灰烬和堆肥后的残留物可以尝试进行资源化利用，如作为建筑材料的原料或土壤改良剂。</span></p><p style=\"text-align: start; line-height: 3;\"><span style=\"font-size: 15px;\">环境监测：垃圾处理过程中，会对周围环境进行持续监测，确保处理活动不会对空气、水体和土壤造成污染。</span></p><p style=\"text-align: start;\"><br></p><p style=\"text-align: center;\"><img src=\"http://43.142.9.148:9092/files/download/1723014240589-%E5%9E%83%E5%9C%BE%E5%A4%84%E7%90%86%E6%AD%A5%E9%AA%A4.jpg\" alt=\"\" data-href=\"\" style=\"width: 100%;\"></p>', '08:00 - 20:30', 2, '运行中');

-- ----------------------------
-- Table structure for recycle_garbage
-- ----------------------------
DROP TABLE IF EXISTS `recycle_garbage`;
CREATE TABLE `recycle_garbage`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `img` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片',
  `descr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简介',
  `points` INT(11) NULL DEFAULT NULL COMMENT '单个积分',
  `unit` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计量单位',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '可回收垃圾信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recycle_garbage
-- ----------------------------
INSERT INTO `recycle_garbage` VALUES (3, '旧书', 'http://localhost:9090/files/download/旧书图片.jpg', '	\n不要的书都可以。', 10, '斤');
INSERT INTO `recycle_garbage` VALUES (4, '旧衣服', 'http://localhost:9090/files/download/旧衣服图片.png', '最好不要太脏。', 15, '斤');
INSERT INTO `recycle_garbage` VALUES (5, '废报纸', 'http://localhost:9090/files/download/废报纸图片.jpg', '不可以泡水，要干的。', 10, '斤');
INSERT INTO `recycle_garbage` VALUES (6, '铝制易拉罐', 'http://localhost:9090/files/download/铝制易拉罐图片.jpg', '	\n有铝制的易拉罐，啤酒、可口可乐、雪碧的铝制易拉罐都可以', 20, '斤');

-- ----------------------------
-- Table structure for score_exchange
-- ----------------------------
DROP TABLE IF EXISTS `score_exchange`;
CREATE TABLE `score_exchange`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` INT(11) NULL DEFAULT NULL COMMENT '用户id',
  `goods_id` INT(11) NULL DEFAULT NULL COMMENT '物品id',
  `num` INT(11) NULL DEFAULT NULL COMMENT '兑换物品数量',
  `score` INT(11) NULL DEFAULT NULL COMMENT '消耗总积分',
  `receive_name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收人姓名',
  `receive_phone` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收人电话',
  `receive_address` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收人地址',
  `time` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `status` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '兑换订单状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '积分兑换记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of score_exchange
-- ----------------------------
INSERT INTO `score_exchange` VALUES (3, 2, 5, 1, 30, '小蓝', '10933338890', '长沙市开福区央视大厦', '2025-05-07 15:46:37', '已取消');
INSERT INTO `score_exchange` VALUES (4, 2, 5, 1, 30, '1', '1', '1', '2025-05-07 15:54:32', '已取消');
INSERT INTO `score_exchange` VALUES (5, 2, 5, 1, 30, '小蓝', '10933338890', '长沙市望城区体育馆', '2025-05-07 15:55:53', '已签收');
INSERT INTO `score_exchange` VALUES (6, 3, 5, 1, 30, '小粉', '18887776666', '湘潭市市雨湖区香袋大学', '2025-05-07 16:05:07', '待派送');

-- ----------------------------
-- Table structure for score_goods
-- ----------------------------
DROP TABLE IF EXISTS `score_goods`;
CREATE TABLE `score_goods`  (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物品名称',
  `descr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简介',
  `img` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面图片',
  `num` INT(11) NULL DEFAULT NULL COMMENT '剩余可兑换数量',
  `unit` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计量单位',
  `score` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单个积分',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '积分可兑换物品信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of score_goods
-- ----------------------------
INSERT INTO `score_goods` VALUES (1, '不锈钢材质的垃圾桶', '不锈钢材质的垃圾桶，它们都带有脚踏式开盖设计，易于清洁，耐用抗腐蚀。', 'http://localhost:9090/files/download/高级垃圾桶.jpg', 100, '个', '100');
INSERT INTO `score_goods` VALUES (2, '牙刷', '每10个积分可以兑换1个牙刷，都是独立包装，干净卫生。', 'http://localhost:9090/files/download/牙刷图片.jpg', 100, '个', '50');
INSERT INTO `score_goods` VALUES (3, '垃圾袋', '每包垃圾袋有大约50个，手提式，丢垃圾不弄脏手，都是质量过关的，很好用', 'http://localhost:9090/files/download/垃圾袋图片.jpg', 1, '包', '100');
INSERT INTO `score_goods` VALUES (4, '纸杯', '一次性纸杯，家庭必备', 'http://localhost:9090/files/download/纸杯.png', 1000, '打', '50');
INSERT INTO `score_goods` VALUES (5, '一次性纸巾', '一次性纸巾，家庭常备', 'http://localhost:9090/files/download/一次性纸巾.png', 98, '包', '30');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `phone` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `score` INT(11) NULL DEFAULT NULL COMMENT '积分余额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '普通用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (2, 'blue', 'bbb', '小蓝', 'http://localhost:9090/files/download/4.png', 'USER', '10933338890', NULL, 10);
INSERT INTO `user` VALUES (3, 'pink', 'ppp', '小粉', 'http://localhost:9090/files/download/5.png', 'USER', '18887776666', NULL, 10);
INSERT INTO `user` VALUES (6, 'yellow', 'yyy', '小黄', NULL, 'USER', NULL, NULL, 0);
INSERT INTO `user` VALUES (7, 'green', 'ggg', '小绿', 'http://localhost:9090/files/download/9.png', 'USER', NULL, NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
