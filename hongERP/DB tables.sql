# Host: 127.0.0.1  (Version: 5.5.47)
# Date: 2018-04-14 15:50:24
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "hzg_action"
#

DROP TABLE IF EXISTS `hzg_action`;
CREATE TABLE `hzg_action` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `entity` varchar(32) DEFAULT NULL COMMENT '业务类型实体：stockInOut 入库出库，product：商品，returnProduct：退货，changeProduct：换货，order：定单，purchase：采购等',
  `entityId` int(11) DEFAULT NULL COMMENT '业务类型实体id：退货单id，换货单id，订单id，采购id等',
  `type` int(2) DEFAULT NULL COMMENT '入库出库操作类型: 0:打印商品条码，1:打印出库单，2:打印快递单, 21:生成快递单，3:打印入库单，4:入库，5:出库。商品操作类型: 0:上架商品，1:下架商品。退货操作类型：3:销售确认可退，31:销售确认不可退，4：销售总监确认可退，41：销售总监确认不可退，5：仓储确认可退，51：仓储确认不可退，6：财务确认已收到修补货物款项。订单操作类型:0:取消订单，1:确认订单已支付，2:财务审核通过自助单, 3:确认预订单订金已支付。采购单操作类型：0:确认预订单订金已支付。用户操作类型：0：修改密码',
  `inputDate` datetime DEFAULT NULL COMMENT '操作时间',
  `inputerId` int(11) DEFAULT NULL COMMENT '操作人id',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=609 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='操作记录表';

#
# Structure for table "hzg_article"
#

DROP TABLE IF EXISTS `hzg_article`;
CREATE TABLE `hzg_article` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章Id',
  `cateId` int(11) unsigned DEFAULT NULL COMMENT '分类Id',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `imageUrl` varchar(100) DEFAULT NULL COMMENT '封面图',
  `content` text COMMENT '内容',
  `shortContent` varchar(150) DEFAULT NULL COMMENT '摘要',
  `position` int(1) DEFAULT NULL COMMENT '推荐位（1:首页，2:焦点图，3:栏目推荐等）',
  `hits` int(11) unsigned DEFAULT NULL COMMENT '阅读量',
  `authorId` int(3) unsigned DEFAULT NULL COMMENT '发布人Id',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  `state` int(1) unsigned DEFAULT NULL COMMENT '状态（0:保存/1:发布/2:删除）',
  `seoTitle` varchar(80) DEFAULT NULL COMMENT '文章优化标题',
  `seoKeyword` varchar(80) DEFAULT NULL COMMENT '文章优化关键词',
  `seoDesc` varchar(100) DEFAULT NULL COMMENT '文章优化描述',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='文章表';

#
# Structure for table "hzg_article_cate"
#

DROP TABLE IF EXISTS `hzg_article_cate`;
CREATE TABLE `hzg_article_cate` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章分类Id',
  `parentId` int(11) unsigned DEFAULT NULL COMMENT '文章父类id',
  `name` varchar(20) DEFAULT NULL COMMENT '文章分类名称',
  `nickname` varchar(20) DEFAULT NULL COMMENT '分类名称简写',
  `articleTitle` varchar(50) DEFAULT NULL COMMENT '文章分类优化标题',
  `articleKeyword` varchar(50) DEFAULT NULL COMMENT '文章分类优化关键词',
  `articleDesc` varchar(100) DEFAULT NULL COMMENT '文章分类优化描述',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='文章分类表';

#
# Structure for table "hzg_article_tag"
#

DROP TABLE IF EXISTS `hzg_article_tag`;
CREATE TABLE `hzg_article_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `name` varchar(16) DEFAULT NULL COMMENT '标签名称',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='标签表';

#
# Structure for table "hzg_articletag_relation"
#

DROP TABLE IF EXISTS `hzg_articletag_relation`;
CREATE TABLE `hzg_articletag_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章标签关联id',
  `articleId` int(11) DEFAULT NULL COMMENT '文章id',
  `tagId` int(11) DEFAULT NULL COMMENT '标签id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='文章标签关联表';

#
# Structure for table "hzg_borrowproduct"
#

DROP TABLE IF EXISTS `hzg_borrowproduct`;
CREATE TABLE `hzg_borrowproduct` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '借货单号',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:保存，1:申请，2:完成， 3:取消，4:已还，5:部分已还',
  `describes` varchar(60) DEFAULT NULL COMMENT '描述',
  `borrowerId` int(11) DEFAULT NULL COMMENT '借货人id',
  `chargerId` int(11) DEFAULT NULL COMMENT '出借人id',
  `date` datetime DEFAULT NULL COMMENT '借货时间',
  `inputDate` datetime DEFAULT NULL COMMENT '记录生成时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='借货表';

#
# Structure for table "hzg_borrowproduct_detail"
#

DROP TABLE IF EXISTS `hzg_borrowproduct_detail`;
CREATE TABLE `hzg_borrowproduct_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编码',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '单位,如：件、只、双、条、枚、副、克、克拉',
  `borrowProductId` int(11) DEFAULT NULL COMMENT '借货单id',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:已借，1:已还，2:部分已还',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='借货表明细';

#
# Structure for table "hzg_borrowproduct_detail_product"
#

DROP TABLE IF EXISTS `hzg_borrowproduct_detail_product`;
CREATE TABLE `hzg_borrowproduct_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowProductDetailId` int(11) DEFAULT NULL COMMENT '借货单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='借货明细对应商品表';

#
# Structure for table "hzg_borrowproduct_return"
#

DROP TABLE IF EXISTS `hzg_borrowproduct_return`;
CREATE TABLE `hzg_borrowproduct_return` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '还货单号',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:保存，1:申请，2:完成， 3:取消',
  `describes` varchar(60) DEFAULT NULL COMMENT '描述',
  `returnerId` int(11) DEFAULT NULL COMMENT '还货人id',
  `chargerId` int(11) DEFAULT NULL COMMENT '收货人id',
  `date` datetime DEFAULT NULL COMMENT '还货时间',
  `inputDate` datetime DEFAULT NULL COMMENT '记录生成时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='还货表';

#
# Structure for table "hzg_borrowproduct_return_detail"
#

DROP TABLE IF EXISTS `hzg_borrowproduct_return_detail`;
CREATE TABLE `hzg_borrowproduct_return_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编码',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '单位,如：件、只、双、条、枚、副、克、克拉',
  `borrowDetailId` int(11) NOT NULL DEFAULT '0' COMMENT '对应借货明细id',
  `borrowProductReturnId` int(11) NOT NULL DEFAULT '0' COMMENT '还货单id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='还货表明细';

#
# Structure for table "hzg_borrowproduct_return_detail_product"
#

DROP TABLE IF EXISTS `hzg_borrowproduct_return_detail_product`;
CREATE TABLE `hzg_borrowproduct_return_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowProductReturnDetailId` int(11) DEFAULT NULL COMMENT '还货单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='还货明细对应商品表';

#
# Structure for table "hzg_changeproduct"
#

DROP TABLE IF EXISTS `hzg_changeproduct`;
CREATE TABLE `hzg_changeproduct` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '换货单号',
  `entity` varchar(32) DEFAULT NULL COMMENT '业务类型实体：order：定单，purchase：采购等',
  `entityId` int(11) DEFAULT NULL COMMENT '业务类型实体id：订单id，采购id等',
  `entityNo` varchar(32) DEFAULT NULL COMMENT '业务实体编号',
  `amount` varchar(32) DEFAULT NULL COMMENT '换货差价，换货差价 =想要换货品的金额 - 客户货品金额',
  `reason` varchar(60) DEFAULT NULL COMMENT '换货原因',
  `userId` int(11) DEFAULT NULL COMMENT '换货人id',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:申请，1:已换，2:取消，3:销售确认要退商品可退，31:销售确认要退商品不可退，4：销售总监确认要退商品可退，41：销售总监确认要退商品不可退，5：仓储确认要退商品可退，51：仓储确认要退商品不可退',
  `date` datetime DEFAULT NULL COMMENT '换货时间',
  `inputDate` datetime DEFAULT NULL COMMENT '换货申请时间',
  `fee` varchar(32) DEFAULT NULL COMMENT '换货费',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='换货表';

#
# Structure for table "hzg_changeproduct_detail"
#

DROP TABLE IF EXISTS `hzg_changeproduct_detail`;
CREATE TABLE `hzg_changeproduct_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `changeProductId` int(11) DEFAULT NULL COMMENT '换货单id',
  `type` int(1) DEFAULT NULL COMMENT '商品在换货中的类别，0:客户想要换的商品，1：客户已有的商品',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品no',
  `price` varchar(32) DEFAULT NULL COMMENT '换货单价，加密价格后的字符串',
  `quantity` float(8,2) DEFAULT NULL COMMENT '换货数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '换货单位,如：件、只、双、条、枚、副、克、克拉',
  `amount` varchar(32) DEFAULT NULL COMMENT '商品金额',
  `state` int(1) DEFAULT NULL COMMENT '要换商品(type=0)状态：0:未换货，1:已换货，2:不能换货。要退商品(type=1)状态：0:未退货，1:已退货，2:不能退货',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='换货明细表';

#
# Structure for table "hzg_changeproduct_detail_product"
#

DROP TABLE IF EXISTS `hzg_changeproduct_detail_product`;
CREATE TABLE `hzg_changeproduct_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `changeProductDetailId` int(11) DEFAULT NULL COMMENT '换货单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='换货明细对应商品表';

#
# Structure for table "hzg_config"
#

DROP TABLE IF EXISTS `hzg_config`;
CREATE TABLE `hzg_config` (
  `Id` int(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置主键ID',
  `configName` varchar(50) DEFAULT NULL COMMENT '配置名称',
  `configNic` varchar(50) DEFAULT NULL COMMENT '配置名称简写',
  `configValue` varchar(50) DEFAULT NULL COMMENT '配置值',
  `state` int(1) unsigned NOT NULL COMMENT '状态（0：正常；1：禁用）',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网站配置表';

#
# Structure for table "hzg_customer"
#

DROP TABLE IF EXISTS `hzg_customer`;
CREATE TABLE `hzg_customer` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `phone` varchar(64) DEFAULT NULL COMMENT '加密后的联系电话号码、手机号码',
  `mobile` varchar(64) DEFAULT NULL COMMENT '加密后的手机号',
  `address` varchar(256) DEFAULT NULL COMMENT '加密后的住址',
  `gender` varchar(6) DEFAULT NULL COMMENT '性别：男、女',
  `birthday` varchar(32) DEFAULT NULL COMMENT '加密后的出生日期，格式:yyyy-MM-dd',
  `email` varchar(128) DEFAULT NULL COMMENT '加密后的email 地址',
  `creType` varchar(10) DEFAULT NULL COMMENT '证件类型:身份证，护照等',
  `creNo` varchar(128) DEFAULT NULL COMMENT '加密后的证件号',
  `photoUrl` varchar(30) DEFAULT NULL COMMENT '照片地址',
  `position` varchar(16) DEFAULT NULL COMMENT '职位',
  `hirer` varchar(30) DEFAULT NULL COMMENT '工作单位',
  `jobType` varchar(16) DEFAULT NULL COMMENT '工作性质，如：人才招聘，财务决算',
  `otherContact` varchar(40) DEFAULT NULL COMMENT '其他联系方式',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  `degreeId` int(11) DEFAULT NULL COMMENT '客户级别id',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `creTypeNo` (`creType`,`creNo`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='客户';

#
# Structure for table "hzg_customer_degree"
#

DROP TABLE IF EXISTS `hzg_customer_degree`;
CREATE TABLE `hzg_customer_degree` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `loyalty` int(3) DEFAULT NULL COMMENT '忠诚度',
  `credit` int(3) DEFAULT NULL COMMENT '信用度',
  `level` varchar(12) DEFAULT NULL COMMENT '客户级别，如：VIP，normal，senior等',
  `spendAmount` varchar(32) DEFAULT NULL COMMENT '消费额',
  `spendCount` int(3) DEFAULT NULL COMMENT '消费次数',
  `spendPoints` int(8) DEFAULT NULL COMMENT '消费积分',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='客户级别表';

#
# Structure for table "hzg_customer_express"
#

DROP TABLE IF EXISTS `hzg_customer_express`;
CREATE TABLE `hzg_customer_express` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(60) DEFAULT NULL COMMENT '邮寄地址',
  `city` varchar(16) DEFAULT NULL COMMENT '城市',
  `province` varchar(16) DEFAULT NULL COMMENT '省份',
  `country` varchar(16) DEFAULT NULL COMMENT '国家',
  `customerId` int(11) DEFAULT NULL COMMENT '客户id',
  `receiver` varchar(20) DEFAULT NULL COMMENT '收货人姓名',
  `phone` varchar(16) DEFAULT NULL COMMENT '联系电话、手机号',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机号',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:有效，1:无效',
  `postCode` varchar(7) DEFAULT NULL COMMENT '邮编',
  `defaultUse` varchar(1) DEFAULT NULL COMMENT '是否默认使用，Y：是，N:否',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='客户收货地址表';

#
# Structure for table "hzg_customer_user"
#

DROP TABLE IF EXISTS `hzg_customer_user`;
CREATE TABLE `hzg_customer_user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) DEFAULT NULL COMMENT '客户id',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:再用，1:注销',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) DEFAULT NULL COMMENT 'md5加密后的密码',
  `nickname` varchar(30) DEFAULT NULL COMMENT '昵称',
  `email` varchar(30) DEFAULT NULL COMMENT 'email地址',
  `lastLoginDate` datetime DEFAULT NULL COMMENT '最近登录时间',
  `onlineTime` int(7) DEFAULT NULL COMMENT '在线时长，单位：分钟',
  `loginCount` int(5) DEFAULT NULL COMMENT '登录次数',
  `clickCount` int(7) DEFAULT NULL COMMENT '点击次数',
  `describes` varchar(60) DEFAULT NULL COMMENT '用户备注',
  `points` int(8) DEFAULT NULL COMMENT '用户积分',
  `inputDate` datetime DEFAULT NULL COMMENT '退货申请时间',
  PRIMARY KEY (`Id`),
  KEY `customerId` (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户表';

#
# Structure for table "hzg_customer_user_point"
#

DROP TABLE IF EXISTS `hzg_customer_user_point`;
CREATE TABLE `hzg_customer_user_point` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '积分Id',
  `userId` int(11) DEFAULT NULL COMMENT '用户Id',
  `points` int(5) DEFAULT NULL COMMENT '积分。积分为正，表示获取积分；为负，表示使用积分',
  `date` datetime DEFAULT NULL COMMENT '产生时间',
  `state` int(1) DEFAULT NULL COMMENT '状态（可用/不可用）',
  `describes` varchar(60) DEFAULT NULL COMMENT '积分获取、使用描述',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户单笔积分记录表';

#
# Structure for table "hzg_express_deliver"
#

DROP TABLE IF EXISTS `hzg_express_deliver`;
CREATE TABLE `hzg_express_deliver` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `deliver` varchar(20) DEFAULT NULL COMMENT '承运人，,如：顺丰快递',
  `type` varchar(16) DEFAULT NULL COMMENT '快递类型，如：顺丰标快',
  `date` datetime DEFAULT NULL COMMENT '快递发送时间',
  `sender` varchar(20) DEFAULT NULL COMMENT '发件人',
  `senderAddress` varchar(60) DEFAULT NULL COMMENT '发件人所在地址',
  `senderCity` varchar(16) DEFAULT NULL COMMENT '发件人所在城市',
  `senderProvince` varchar(16) DEFAULT NULL COMMENT '发件人所在省份',
  `senderCountry` varchar(16) DEFAULT NULL COMMENT '发件人所在国家',
  `senderPostCode` varchar(7) DEFAULT NULL COMMENT '发件人所在地区邮编',
  `senderCompany` varchar(30) DEFAULT NULL COMMENT '发件人所在公司',
  `senderTel` varchar(20) DEFAULT NULL COMMENT '发件人电话',
  `senderMobile` varchar(20) DEFAULT NULL COMMENT '发件人手机',
  `receiver` varchar(20) DEFAULT NULL COMMENT '收件人',
  `receiverAddress` varchar(60) DEFAULT NULL COMMENT '收件人所在地址',
  `receiverCity` varchar(16) DEFAULT NULL COMMENT '收件人所在城市',
  `receiverProvince` varchar(16) DEFAULT NULL COMMENT '收件人所在省份',
  `receiverCountry` varchar(16) DEFAULT NULL COMMENT '收件人所在国家',
  `receiverPostCode` varchar(7) DEFAULT NULL COMMENT '收件人所在地区邮编',
  `receiverCompany` varchar(30) DEFAULT NULL COMMENT '收件人所在公司',
  `receiverTel` varchar(20) DEFAULT NULL COMMENT '收件人电话',
  `receiverMobile` varchar(20) DEFAULT NULL COMMENT '收件人手机',
  `state` int(1) DEFAULT NULL COMMENT '快递状态，0:发送中，1：发送完成，2：发送失败',
  `fee` float(6,2) DEFAULT NULL COMMENT '快递费用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `inputDate` datetime DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8 COMMENT='快递单表';

#
# Structure for table "hzg_express_deliver_detail"
#

DROP TABLE IF EXISTS `hzg_express_deliver_detail`;
CREATE TABLE `hzg_express_deliver_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `expressNo` varchar(32) DEFAULT NULL COMMENT '供快递企业使用的快递单号',
  `productNo` varchar(16) DEFAULT NULL COMMENT '快递货物对应商品no',
  `quantity` float(8,2) DEFAULT NULL COMMENT '货物数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '货物单位',
  `weight` float(9,2) DEFAULT NULL COMMENT '货物重量,单位 kg',
  `price` varchar(32) DEFAULT NULL COMMENT '货物单价',
  `state` int(1) DEFAULT NULL COMMENT '快递状态，0:未发送，1：已发送， 2：已收货，3：收货失败',
  `expressDeliverId` int(11) DEFAULT NULL COMMENT '快递单id',
  `mailNo` varchar(64) DEFAULT NULL COMMENT '快递公司内部使用的快递运单号',
  `insure` varchar(32) DEFAULT NULL COMMENT '货物保价',
  `setting` varchar(2) DEFAULT NULL COMMENT '顺丰丰桥配置信息 key',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='快递单表详情单';

#
# Structure for table "hzg_express_deliver_detail_product"
#

DROP TABLE IF EXISTS `hzg_express_deliver_detail_product`;
CREATE TABLE `hzg_express_deliver_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `expressDeliverDetailId` int(11) DEFAULT NULL COMMENT '快递明细id',
  `productId` int(11) DEFAULT NULL COMMENT '关联商品id',
  PRIMARY KEY (`Id`),
  KEY `purchaseId` (`expressDeliverDetailId`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购明细表';

#
# Structure for table "hzg_finance_banksubject_extend"
#

DROP TABLE IF EXISTS `hzg_finance_banksubject_extend`;
CREATE TABLE `hzg_finance_banksubject_extend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` int(11) DEFAULT NULL COMMENT '账户id',
  `subjectId` int(11) DEFAULT NULL COMMENT '科目id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='银行科目扩展表';

#
# Structure for table "hzg_finance_doctype"
#

DROP TABLE IF EXISTS `hzg_finance_doctype`;
CREATE TABLE `hzg_finance_doctype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) DEFAULT NULL COMMENT '单据类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

#
# Data for table "hzg_finance_doctype"
#
insert  into `hzg_finance_doctype`(`id`,`name`) values (1,'采购单'),(2,'入库单'),(3,'销售订单'),(4,'出库单'),(5,'付款单'),(6,'收款单'),(7,'形态转换单'),(8,'报损出库单');

#
# Structure for table "hzg_finance_doctypesubject_relation"
#

DROP TABLE IF EXISTS `hzg_finance_doctypesubject_relation`;
CREATE TABLE `hzg_finance_doctypesubject_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `subjectId` int(11) DEFAULT NULL COMMENT '科目id',
  `direction` int(1) DEFAULT NULL COMMENT '余额方向(1:借方，2:贷方)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

#
# Data for table "hzg_finance_doctypesubject_relation"
#
insert  into `hzg_finance_doctypesubject_relation`(`id`,`doctypeId`,`subjectId`,`direction`) values (1,1,43,1),(2,1,51,2),(3,2,71,1),(4,2,43,2),(5,5,51,1),(6,5,33,2),(7,3,73,1),(8,3,74,2),(9,4,75,1),(10,4,71,2),(11,6,41,1),(12,6,73,2),(13,7,71,1),(14,7,71,2),(15,7,77,2),(16,8,78,1),(17,8,71,2);

#
# Structure for table "hzg_finance_form_capitalflowmeter"
#

DROP TABLE IF EXISTS `hzg_finance_form_capitalflowmeter`;
CREATE TABLE `hzg_finance_form_capitalflowmeter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` int(11) DEFAULT NULL COMMENT '账户id',
  `date` datetime DEFAULT NULL COMMENT '单据日期',
  `docTypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `no` varchar(32) DEFAULT NULL COMMENT '单据编号',
  `beginning` varchar(32) DEFAULT NULL COMMENT '期初余额',
  `income` varchar(32) DEFAULT NULL COMMENT '收入金额',
  `spending` varchar(32) DEFAULT NULL COMMENT '支出金额',
  `ending` varchar(32) DEFAULT NULL COMMENT '期末余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='资金流水表';

/*Table structure for table `hzg_finance_form_customercontact` */

DROP TABLE IF EXISTS `hzg_finance_form_customercontact`;

CREATE TABLE `hzg_finance_form_customercontact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) DEFAULT NULL COMMENT '客户id',
  `date` datetime DEFAULT NULL COMMENT '单据日期',
  `docTypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `no` varchar(32) DEFAULT NULL COMMENT '单据编号',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编号',
  `productName` varchar(16) DEFAULT NULL COMMENT '商品名称',
  `unit` varchar(8) DEFAULT NULL COMMENT '计量单位',
  `quantity` float(8,2) DEFAULT NULL COMMENT '数量',
  `unitPrice` varchar(32) DEFAULT NULL COMMENT '单价',
  `beginning` varchar(32) DEFAULT NULL COMMENT '期初余额',
  `receivable` varchar(32) DEFAULT NULL COMMENT '应收金额',
  `received` varchar(32) DEFAULT NULL COMMENT '已收金额',
  `remainder` varchar(32) DEFAULT NULL COMMENT '应收余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='客户往来对账表';

#
# Structure for table "hzg_finance_form_grossprofit"
#

DROP TABLE IF EXISTS `hzg_finance_form_grossprofit`;
CREATE TABLE `hzg_finance_form_grossprofit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL COMMENT '销售日期',
  `no` varchar(16) DEFAULT NULL COMMENT '销售订单号',
  `businessType` varchar(16) DEFAULT NULL COMMENT '业务类型',
  `chartMakerId` int(11) DEFAULT NULL COMMENT '业务员id',
  `customerId` int(11) DEFAULT NULL COMMENT '客户id',
  `unit` varchar(8) DEFAULT NULL COMMENT '计量单位',
  `typeId` int(11) DEFAULT NULL COMMENT '商品分类id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编号',
  `productName` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `quantity` float(8,2) DEFAULT NULL COMMENT '数量',
  `unitPrice` varchar(32) DEFAULT NULL COMMENT '单价',
  `discount` varchar(32) DEFAULT NULL COMMENT '折扣',
  `saleAmount` varchar(32) DEFAULT NULL COMMENT '销售金额',
  `cost` varchar(32) DEFAULT NULL COMMENT '成本金额',
  `grossProfit` varchar(32) DEFAULT NULL COMMENT '毛利',
  `grossProfitRate` varchar(16) DEFAULT NULL COMMENT '毛利率',
  `processIncome` varchar(32) DEFAULT NULL COMMENT '加工费收入',
  `processCost` varchar(32) DEFAULT NULL COMMENT '加工费成本',
  `processGrossProfit` varchar(32) DEFAULT NULL COMMENT '加工毛利',
  `processGrossProfitRate` varchar(16) DEFAULT NULL COMMENT '加工毛利率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='销售毛利分析表';

#
# Structure for table "hzg_finance_form_inoutdetail"
#

DROP TABLE IF EXISTS `hzg_finance_form_inoutdetail`;
CREATE TABLE `hzg_finance_form_inoutdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeId` int(11) DEFAULT NULL COMMENT '商品分类id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编号',
  `productName` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `unit` varchar(8) DEFAULT NULL COMMENT '计量单位',
  `date` datetime DEFAULT NULL COMMENT '单据日期',
  `docTypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `no` varchar(16) DEFAULT NULL COMMENT '单据编号',
  `beginQuantity` float(8,2) DEFAULT NULL COMMENT '期初数量',
  `beginUnitPrice` varchar(32) DEFAULT NULL COMMENT '期初单价',
  `beginAmount` varchar(32) DEFAULT NULL COMMENT '期初金额',
  `inQuantity` float(8,2) DEFAULT NULL COMMENT '本期收入数量',
  `inUnitPrice` varchar(32) DEFAULT NULL COMMENT '本期收入单价',
  `inAmount` varchar(32) DEFAULT NULL COMMENT '本期收入金额',
  `outQuantity` float(8,2) DEFAULT NULL COMMENT '本期发出数量',
  `outUnitPrice` varchar(32) DEFAULT NULL COMMENT '本期发出单价',
  `outAmount` varchar(32) DEFAULT NULL COMMENT '本期发出金额',
  `endQuantity` float(8,2) DEFAULT NULL COMMENT '结存数量',
  `endUnitPrice` varchar(32) DEFAULT NULL COMMENT '结存单价',
  `endAmount` varchar(32) DEFAULT NULL COMMENT '结存金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='进销存明细账表';

#
# Structure for table "hzg_finance_form_suppliercontact"
#

/*Table structure for table `hzg_finance_form_suppliercontact` */

DROP TABLE IF EXISTS `hzg_finance_form_suppliercontact`;

CREATE TABLE `hzg_finance_form_suppliercontact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplierId` int(11) DEFAULT NULL COMMENT '供应商id',
  `date` datetime DEFAULT NULL COMMENT '单据日期',
  `docTypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `no` varchar(32) DEFAULT NULL COMMENT '单据编号',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编号',
  `productName` varchar(16) DEFAULT NULL COMMENT '商品名称',
  `unit` varchar(8) DEFAULT NULL COMMENT '计量单位',
  `quantity` float(8,2) DEFAULT NULL COMMENT '数量',
  `unitPrice` varchar(32) DEFAULT NULL COMMENT '单价',
  `beginning` varchar(32) DEFAULT NULL COMMENT '期初余额',
  `payable` varchar(32) DEFAULT NULL COMMENT '应付金额',
  `paid` varchar(32) DEFAULT NULL COMMENT '已付金额',
  `remainder` varchar(32) DEFAULT NULL COMMENT '应付余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='供应商往来对账表';

#
# Structure for table "hzg_finance_purchasesubject_extend"
#

DROP TABLE IF EXISTS `hzg_finance_purchasesubject_extend`;
CREATE TABLE `hzg_finance_purchasesubject_extend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplierId` int(11) DEFAULT NULL COMMENT '供应商id',
  `subjectId` int(11) DEFAULT NULL COMMENT '科目id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

#
# Structure for table "hzg_finance_subject"
#

DROP TABLE IF EXISTS `hzg_finance_subject`;
CREATE TABLE `hzg_finance_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '科目编码',
  `codeRule` varchar(16) DEFAULT NULL COMMENT '编码规则(4-2-2-2-2)',
  `categoryId` int(11) DEFAULT NULL COMMENT '科目类别ID',
  `name` varchar(20) DEFAULT NULL COMMENT '科目名称',
  `type` int(1) DEFAULT NULL COMMENT '科目类型(1:资产类,2:负债类,3:所有者权益类,4:成本类,5:损益类,6:共同类)',
  `direction` int(1) DEFAULT NULL COMMENT '余额方向(1:借方，2:贷方)',
  `accountItems` varchar(20) DEFAULT NULL COMMENT '辅助核算项(1:部门,2:个人,3:供应商,4:客户,5:项目)',
  `state` int(1) DEFAULT NULL COMMENT '状态(0:在用,1:停用)',
  `info` int(1) DEFAULT NULL COMMENT '填制凭证时录入结算信息(0:是,1:否)',
  `paperFormat` int(1) DEFAULT NULL COMMENT '账面格式(1:金额式,2:数量金额式)',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='科目表';

#
# Data for table "hzg_finance_subject"
#

insert  into `hzg_finance_subject`(`id`,`no`,`codeRule`,`categoryId`,`name`,`type`,`direction`,`accountItems`,`state`,`info`,`paperFormat`,`inputDate`) values (31,'1002','4-2-2-2-2',2,'银行存款',1,1,NULL,0,0,1,'2017-12-07 16:20:04'),(32,'100201','4-2-2-2-2',1,'工商银行2464',1,1,'[3]',1,1,1,'2017-12-07 16:24:25'),(33,'100202','4-2-2-2-2',2,'招商银行3573',1,1,NULL,0,0,1,'2017-12-07 16:29:47'),(37,'100203','4-2-2-2-2',1,'招商银行3523',3,1,'[3]',0,0,1,'2017-12-09 09:48:08'),(38,'100204','4-2-2-2-2',2,'招商银行4555',1,1,'[1, 3, 5]',0,0,2,'2017-12-09 10:06:46'),(39,'100205','4-2-2-2-2',1,'招商银行6635',5,1,'[1, 3]',0,1,2,'2017-12-09 10:12:46'),(40,'10020301','4-2-2-2-2',2,'昆明招商银行',1,1,'[3]',0,0,1,'2017-12-09 10:14:25'),(41,'100206','4-2-2-2-2',1,'工商银行2434',1,1,NULL,1,0,1,'2017-12-09 10:15:40'),(42,'100208','4-2-2-2-2',3,'招商银行4314',1,1,'[3]',0,0,1,'2017-12-14 10:31:26'),(43,'1401','4-2-2-2-2',6,'材料采购',1,1,NULL,0,0,1,'2017-12-22 11:46:44'),(44,'140101','4-2-2-2-2',6,'宝石采购',1,1,'[3]',0,0,1,'2017-12-22 11:47:31'),(45,'140102','4-2-2-2-2',6,'蜜蜡采购',1,1,'[3]',0,0,1,'2017-12-25 13:44:22'),(46,'100209','4-2-2-2-2',2,'rgfgf',1,1,'[4]',0,1,1,'2018-01-05 09:12:15'),(47,'100210','4-2-2-2-2',2,'招商银行4236',1,1,'[2, 3, 4]',0,0,1,'2018-01-11 17:44:00'),(48,'100211','4-2-2-2-2',2,'招商银行3525',1,1,'[1, 2, 3]',0,0,1,'2018-01-11 17:44:56'),(49,'100213','4-2-2-2-2',2,'招商银行4251',1,1,NULL,0,0,1,'2018-03-01 15:08:50'),(51,'2202','4-2-2-2-2',7,'应付账款',2,2,'[3]',0,1,1,'1970-01-01 08:00:00'),(71,'1405','4-2-2-2-2',5,'库存商品',1,1,NULL,0,1,1,'2018-03-15 15:27:43'),(73,'1122','4-2-2-2-2',8,'应收账款',1,1,'[4]',0,1,1,'2018-03-15 15:32:16'),(74,'5001','4-2-2-2-2',9,'主营业务收入',5,2,NULL,0,1,1,'2018-03-15 15:33:13'),(75,'5401','4-2-2-2-2',9,'主营业务成本',5,1,NULL,0,1,1,'2018-03-15 15:35:25'),(76,'5601','4-2-2-2-2',9,'销售费用',5,1,NULL,0,1,1,'2018-03-15 15:43:40'),(77,'560112','4-2-2-2-2',9,'加工费/修补费',5,1,NULL,0,1,1,'2018-03-15 15:44:03'),(78,'5711','4-2-2-2-2',10,'营业外支出',5,1,NULL,0,1,1,'2018-03-15 15:45:52');


#
# Structure for table "hzg_finance_subject_category"
#

DROP TABLE IF EXISTS `hzg_finance_subject_category`;
CREATE TABLE `hzg_finance_subject_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL COMMENT '科目类别名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='科目类别表';

#
# Data for table "hzg_finance_subject_category"
#
insert  into `hzg_finance_subject_category`(`id`,`name`) values (1,'现金科目'),(2,'银行科目'),(3,'进项税科目'),(4,'销项税科目'),(5,'存货科目'),(6,'采购科目'),(7,'应付科目'),(8,'应收科目'),(9,'销售科目'),(10,'费用科目');

#
# Structure for table "hzg_finance_subject_relate"
#

DROP TABLE IF EXISTS `hzg_finance_subject_relate`;
CREATE TABLE `hzg_finance_subject_relate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '科目扩展id',
  `categoryId` int(11) DEFAULT NULL COMMENT '科目类别id',
  `entity` varchar(16) DEFAULT NULL COMMENT '关联实体',
  `field` varchar(16) DEFAULT NULL COMMENT '关联字段',
  `fieldName` varchar(10) DEFAULT NULL COMMENT '关联字段中文名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "hzg_finance_subject_relate"
#
insert  into `hzg_finance_subject_relate`(`id`,`categoryId`,`entity`,`field`,`fieldName`) values (1,2,'account','name','账号名称'),(2,6,'supplier','name','供应商名称'),(3,6,'supplier','address','供应商地址');

#
# Structure for table "hzg_finance_vocher_category"
#

DROP TABLE IF EXISTS `hzg_finance_vocher_category`;
CREATE TABLE `hzg_finance_vocher_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vocherWord` varchar(10) DEFAULT NULL COMMENT '凭证字',
  `name` varchar(16) DEFAULT NULL COMMENT '凭证类别名称',
  `limitType` varchar(16) DEFAULT NULL COMMENT '限制类型',
  `limitSubject` varchar(16) DEFAULT NULL COMMENT '限制科目',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='凭证类型';

#
# Structure for table "hzg_finance_voucher"
#

DROP TABLE IF EXISTS `hzg_finance_voucher`;
CREATE TABLE `hzg_finance_voucher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) DEFAULT NULL COMMENT '凭证类别ID',
  `no` varchar(10) DEFAULT NULL COMMENT '凭证编号',
  `makeDate` datetime DEFAULT NULL COMMENT '制单日期',
  `attachDocumentNum` int(4) DEFAULT NULL COMMENT '附单据数',
  `bookkeeperId` int(11) DEFAULT NULL COMMENT '记账人ID',
  `auditorId` int(11) DEFAULT NULL COMMENT '审核人ID',
  `cashierId` int(11) DEFAULT NULL COMMENT '出纳ID',
  `chartMakerId` int(11) DEFAULT NULL COMMENT '制单人ID',
  `printTimes` int(4) DEFAULT NULL COMMENT '打印次数',
  `totalCapital` varchar(30) DEFAULT NULL COMMENT '大写合计',
  `debit` float(10,2) DEFAULT NULL COMMENT '借方合计',
  `credit` float(10,2) DEFAULT NULL COMMENT '贷方合计',
  `state` int(1) DEFAULT NULL COMMENT '状态(0:保存,1:审核)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='凭证';

#
# Structure for table "hzg_finance_voucher_category"
#

DROP TABLE IF EXISTS `hzg_finance_voucher_category`;
CREATE TABLE `hzg_finance_voucher_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voucherWord` varchar(10) DEFAULT NULL COMMENT '凭证字',
  `name` varchar(16) DEFAULT NULL COMMENT '凭证类别名称',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='凭证类别';

#
# Structure for table "hzg_finance_voucher_detail"
#

DROP TABLE IF EXISTS `hzg_finance_voucher_detail`;
CREATE TABLE `hzg_finance_voucher_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voucherId` int(11) DEFAULT NULL COMMENT '凭证ID',
  `voucherItemId` int(11) DEFAULT NULL COMMENT '凭证条目ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='凭证明细';

#
# Structure for table "hzg_finance_voucher_item"
#

DROP TABLE IF EXISTS `hzg_finance_voucher_item`;
CREATE TABLE `hzg_finance_voucher_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `summary` varchar(60) DEFAULT NULL COMMENT '摘要',
  `assistant` varchar(30) DEFAULT NULL COMMENT '辅助项',
  `debit` float(8,2) DEFAULT NULL COMMENT '借方',
  `credit` float(8,2) DEFAULT NULL COMMENT '贷方',
  `subjectId` int(11) DEFAULT NULL COMMENT '科目ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='采购凭证条目';

#
# Structure for table "hzg_finance_voucher_itemsource"
#

DROP TABLE IF EXISTS `hzg_finance_voucher_itemsource`;
CREATE TABLE `hzg_finance_voucher_itemsource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '凭证条目来源id',
  `voucherId` int(11) DEFAULT NULL COMMENT '凭证id',
  `chartMakerId` int(11) DEFAULT NULL COMMENT '制单人id',
  `date` datetime DEFAULT NULL COMMENT '单据日期',
  `warehouseId` int(11) DEFAULT NULL COMMENT '仓库id',
  `doctypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `businessType` varchar(16) DEFAULT NULL COMMENT '业务类型',
  `docNo` varchar(32) DEFAULT NULL COMMENT '单据编号',
  `contactUnit` varchar(30) DEFAULT NULL COMMENT '往来单位名称',
  `amount` varchar(32) DEFAULT NULL COMMENT '金额',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `extend` varchar(32) DEFAULT NULL COMMENT '扩展字段',
  `state` int(1) DEFAULT NULL COMMENT '状态(0:已生成,1:未生成)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

#
# Structure for table "hzg_finance_voucher_itemsource_detail"
#

DROP TABLE IF EXISTS `hzg_finance_voucher_itemsource_detail`;
CREATE TABLE `hzg_finance_voucher_itemsource_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemsourceId` int(11) DEFAULT NULL COMMENT '凭证条目来源id',
  `entity` varchar(32) DEFAULT NULL COMMENT '条件实体,如:商品类型:productType，支付方式:payType等',
  `entityId` int(11) DEFAULT NULL COMMENT '商品分类id,支付方式id等',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

#
# Structure for table "hzg_job"
#

DROP TABLE IF EXISTS `hzg_job`;
CREATE TABLE `hzg_job` (
  `Id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `jobName` varchar(80) NOT NULL COMMENT '岗位名称',
  `jobTotal` smallint(1) NOT NULL COMMENT '招聘数量',
  `jobDuty` text NOT NULL COMMENT '岗位职责',
  `jobRequest` text NOT NULL COMMENT '任职要求',
  `jobRound` char(22) NOT NULL COMMENT '招聘周期',
  `jobTreatment` varchar(12) NOT NULL COMMENT '薪资待遇',
  `jobTime` datetime NOT NULL COMMENT '发布时间',
  `jobPlace` varchar(10) NOT NULL COMMENT '工作地点',
  `jobClass` varchar(10) NOT NULL COMMENT '职位类别',
  `jobCost` varchar(100) NOT NULL COMMENT '福利待遇',
  `jobQQ` char(9) NOT NULL COMMENT 'QQ',
  `jobEmail` char(16) NOT NULL COMMENT '邮箱',
  `jobTel` char(13) NOT NULL COMMENT '联系电话',
  `jobRead` int(5) NOT NULL DEFAULT '0' COMMENT '浏览量',
  `state` int(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态（0：未发布；1：发布）',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招聘表';

#
# Structure for table "hzg_keyword"
#

DROP TABLE IF EXISTS `hzg_keyword`;
CREATE TABLE `hzg_keyword` (
  `Id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '关键词ID',
  `keyword` varchar(40) DEFAULT NULL COMMENT '关键词',
  `keywordUrl` varchar(100) DEFAULT NULL COMMENT '关键词链接',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='锚文本关键词表';

#
# Structure for table "hzg_money_account"
#

DROP TABLE IF EXISTS `hzg_money_account`;
CREATE TABLE `hzg_money_account` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(25) DEFAULT NULL COMMENT '账户',
  `bank` varchar(30) DEFAULT NULL COMMENT '账户所属银行',
  `owner` int(11) DEFAULT NULL COMMENT '开户人',
  `branch` varchar(30) DEFAULT NULL COMMENT '开户行',
  `amount` float(11,2) DEFAULT NULL COMMENT '账户金额',
  `inputDate` datetime DEFAULT NULL COMMENT '注册时间',
  `name` varchar(32) DEFAULT NULL COMMENT '账号名称',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='银行账号';

#
# Structure for table "hzg_money_pay"
#

DROP TABLE IF EXISTS `hzg_money_pay`;
CREATE TABLE `hzg_money_pay` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(32) DEFAULT NULL COMMENT '支付编号',
  `entity` varchar(32) DEFAULT NULL COMMENT '单据类型，如：顾客订单:order，采购单:purchase等',
  `entityId` int(11) DEFAULT NULL COMMENT '订单id、预订单id，采购单id等',
  `entityNo` varchar(16) DEFAULT NULL COMMENT '单据编号',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:未支付，1:已支付，2:支付失败',
  `amount` float(11,2) DEFAULT NULL COMMENT '支付金额',
  `settleAmount` float(11,2) DEFAULT NULL COMMENT '清算金额',
  `payDate` datetime DEFAULT NULL COMMENT '支付时间',
  `payType` int(1) DEFAULT NULL COMMENT '支付类型：0:现金，1:网上支付，2:扫码支付，3:汇款, 4:转账，5：其他, 6:付宝转账, 7:微信转账',
  `payAccount` varchar(25) DEFAULT NULL COMMENT '支付账号',
  `payBranch` varchar(30) DEFAULT NULL COMMENT '支付开户行',
  `payBank` varchar(20) DEFAULT NULL COMMENT '支付银行',
  `bankBillNo` varchar(30) DEFAULT NULL COMMENT '银行返回交易流水号',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  `receiptAccount` varchar(25) DEFAULT NULL COMMENT '收款账号',
  `receiptBranch` varchar(30) DEFAULT NULL COMMENT '收款开户行',
  `receiptBank` varchar(20) DEFAULT NULL COMMENT '收款银行',
  `inputDate` datetime DEFAULT NULL COMMENT '支付记录生成时间',
  `balanceType` int(1) DEFAULT NULL COMMENT '收支类型：0:收入，1:支出',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `no` (`no`),
  KEY `userId` (`userId`),
  KEY `entityId` (`entityId`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8 COMMENT='支付记录';

#
# Structure for table "hzg_money_refund"
#

DROP TABLE IF EXISTS `hzg_money_refund`;
CREATE TABLE `hzg_money_refund` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(32) DEFAULT NULL COMMENT '退款编号, 为了符合支付宝退款批次号格式要求，格式需是yyyyMMddHHmmss+数字或者字母',
  `payId` int(11) NOT NULL DEFAULT '0' COMMENT '支付id',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:未退，1:已退，2:退款失败',
  `amount` float(8,2) DEFAULT NULL COMMENT '退款金额',
  `refundDate` datetime DEFAULT NULL COMMENT '退款时间',
  `bankBillNo` varchar(30) DEFAULT NULL COMMENT '银行返回交易流水号',
  `payBank` varchar(15) DEFAULT NULL COMMENT '收款银行',
  `refundBank` varchar(15) DEFAULT NULL COMMENT '退款银行',
  `inputDate` datetime DEFAULT NULL COMMENT '退款记录生成时间',
  `entity` varchar(32) DEFAULT NULL COMMENT '单据类型：returnProduct:退货，stockInDepositCaiwu:押金入库',
  `entityId` int(11) DEFAULT NULL COMMENT '单据id',
  `entityNo` varchar(16) DEFAULT NULL COMMENT '单据编号',
  `balanceType` int(1) DEFAULT NULL COMMENT '收支类型：0:支出，1:收入',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='退款';

#
# Structure for table "hzg_order"
#

DROP TABLE IF EXISTS `hzg_order`;
CREATE TABLE `hzg_order` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '订单号',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:未支付，1:已支付，2:取消，3：已退款， 4:财务确认已支付， 5：部分退款',
  `type` int(1) DEFAULT NULL COMMENT '订单类型，0:自助下单，1:代下单，2:私人订制，3:预定，4:代下单加工，5:换货订单',
  `amount` varchar(32) DEFAULT NULL COMMENT '订单总金额',
  `discount` varchar(32) DEFAULT NULL COMMENT '折扣',
  `payAmount` varchar(32) DEFAULT NULL COMMENT '实际支付金额',
  `date` datetime DEFAULT NULL COMMENT '下单时间',
  `userId` int(11) DEFAULT NULL COMMENT '订单所有者id',
  `salerId` int(11) DEFAULT NULL COMMENT '销售人id',
  `describes` varchar(256) DEFAULT NULL COMMENT '备注',
  `soldDate` datetime DEFAULT NULL COMMENT '商品销售完成时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `no` (`no`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 COMMENT='订单';

#
# Structure for table "hzg_order_book"
#

DROP TABLE IF EXISTS `hzg_order_book`;
CREATE TABLE `hzg_order_book` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `deposit` varchar(32) DEFAULT NULL COMMENT '订金',
  `payDate` datetime DEFAULT NULL COMMENT '预付订金时间',
  `state` int(1) DEFAULT NULL COMMENT '状态，0：未支付，1：支付完成，2:取消',
  `orderId` int(11) DEFAULT NULL COMMENT '订单id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='预订单';

#
# Structure for table "hzg_order_detail"
#

DROP TABLE IF EXISTS `hzg_order_detail`;
CREATE TABLE `hzg_order_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) DEFAULT NULL COMMENT '订单id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品no',
  `productPrice` varchar(32) DEFAULT NULL COMMENT '商品售价，加密价格后的字符串',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:未售，1:已售，2:预定',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量',
  `unit` varchar(6) DEFAULT NULL COMMENT '计量单位',
  `amount` varchar(32) DEFAULT NULL COMMENT '总价',
  `discount` varchar(32) DEFAULT NULL COMMENT '折扣',
  `payAmount` varchar(32) DEFAULT NULL COMMENT '实际支付总价',
  `expressId` int(11) DEFAULT NULL COMMENT '客户收件信息id',
  `expressDate` datetime DEFAULT NULL COMMENT '发货时间',
  `date` datetime DEFAULT NULL COMMENT '订单明细生成时间',
  `priceChangeId` int(11) DEFAULT NULL COMMENT '价格变动码id',
  PRIMARY KEY (`Id`),
  KEY `orderId` (`orderId`),
  KEY `productNo` (`productNo`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 COMMENT='订单商品明细';

#
# Structure for table "hzg_order_detail_product"
#

DROP TABLE IF EXISTS `hzg_order_detail_product`;
CREATE TABLE `hzg_order_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderDetailId` int(11) DEFAULT NULL COMMENT '订单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '关联商品id',
  PRIMARY KEY (`Id`),
  KEY `orderDetailId` (`orderDetailId`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单明细对应商品列表';

#
# Structure for table "hzg_order_gift"
#

DROP TABLE IF EXISTS `hzg_order_gift`;
CREATE TABLE `hzg_order_gift` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) DEFAULT NULL COMMENT '订单id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '赠品no(商品no)',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量',
  `unit` varchar(6) DEFAULT NULL COMMENT '计量单位',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='销售赠品';

#
# Structure for table "hzg_order_gift_product"
#

DROP TABLE IF EXISTS `hzg_order_gift_product`;
CREATE TABLE `hzg_order_gift_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderGiftId` int(11) DEFAULT NULL COMMENT '订单赠品id',
  `productId` int(11) DEFAULT NULL COMMENT '关联商品id',
  PRIMARY KEY (`Id`),
  KEY `orderGiftId` (`orderGiftId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单赠品对应商品列表';

#
# Structure for table "hzg_order_private"
#

DROP TABLE IF EXISTS `hzg_order_private`;
CREATE TABLE `hzg_order_private` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(1) DEFAULT NULL COMMENT '类型：0：商品加工，1：私人订制',
  `orderDetailId` int(11) DEFAULT NULL COMMENT '订单明细id',
  `describes` varchar(255) DEFAULT NULL COMMENT '商品加工，私人订制描述',
  `authorizerId` int(11) DEFAULT NULL COMMENT '费用核准记录表id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='商品加工，私人订制表';

#
# Structure for table "hzg_order_private_acc"
#

DROP TABLE IF EXISTS `hzg_order_private_acc`;
CREATE TABLE `hzg_order_private_acc` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productNo` varchar(16) DEFAULT NULL COMMENT '配饰no（商品no）',
  `quantity` float(6,2) DEFAULT NULL COMMENT '配饰数量',
  `unit` varchar(6) DEFAULT NULL COMMENT '计量单位',
  `privateId` int(11) DEFAULT NULL COMMENT '私人订制id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='私人订制配饰';

#
# Structure for table "hzg_order_private_acc_product"
#

DROP TABLE IF EXISTS `hzg_order_private_acc_product`;
CREATE TABLE `hzg_order_private_acc_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderPrivateAccId` int(11) DEFAULT NULL COMMENT '订单私人订制配饰id',
  `productId` int(11) DEFAULT NULL COMMENT '关联商品id',
  PRIMARY KEY (`Id`),
  KEY `orderPrivateAccId` (`orderPrivateAccId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单私人订制配饰对应商品列表';

#
# Structure for table "hzg_order_private_authorize"
#

DROP TABLE IF EXISTS `hzg_order_private_authorize`;
CREATE TABLE `hzg_order_private_authorize` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` varchar(32) DEFAULT NULL COMMENT '核定金额',
  `describes` varchar(255) DEFAULT NULL COMMENT '核定金额描述',
  `userId` int(11) DEFAULT NULL COMMENT '核定金额人id，即后台用户id',
  `date` datetime DEFAULT NULL COMMENT '核定金额时间',
  PRIMARY KEY (`Id`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品加工，私人订制表金额核定';

#
# Structure for table "hzg_order_receivedapply"
#

DROP TABLE IF EXISTS `hzg_order_receivedapply`;
CREATE TABLE `hzg_order_receivedapply` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderDetailId` int(11) DEFAULT NULL COMMENT '订单明细id',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  `describe` varchar(60) DEFAULT NULL COMMENT '为收货描述',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:申诉申请，1:申诉成功, 2:申诉失败',
  `inputDate` datetime DEFAULT NULL COMMENT '申诉提交时间',
  `successDate` datetime DEFAULT NULL COMMENT '申诉成功时间',
  `expressCompany` varchar(30) DEFAULT NULL COMMENT '快递公司',
  `expressNo` varchar(30) DEFAULT NULL COMMENT '快递单号',
  `type` varchar(11) DEFAULT NULL COMMENT '用户接受货物错误类型,notReceived:未收到货物，errReceived:接受到错误货物',
  PRIMARY KEY (`Id`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收货错误申诉单';

#
# Structure for table "hzg_product"
#

DROP TABLE IF EXISTS `hzg_product`;
CREATE TABLE `hzg_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '商品编号',
  `name` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `typeId` int(11) DEFAULT NULL COMMENT '商品种类ID',
  `certificate` varchar(60) DEFAULT NULL COMMENT '证书信息',
  `price` varchar(32) DEFAULT NULL COMMENT '市场价，加密价格后的字符串',
  `fatePrice` varchar(32) DEFAULT NULL COMMENT '结缘价，加密价格后的字符串',
  `feature` varchar(6) DEFAULT NULL COMMENT '特性：如：定制、加工等',
  `state` int(2) DEFAULT NULL COMMENT '状态，0:采购，10:采购审核通过，11:采购完成，1:入库，12:部分入库，2:出库，21：部分出库，3:在售，4:已售，41:部分已售，5:无效, 6:编辑状态,7:多媒体文件已上传,8:已发货,81:部分发货，82:申请采购退货，83：采购退货完成，84：部分申请采购退货，85：部分采购退货完成，86:申请修补， 87：已修补，9:申请退货，91:已退货，92:申请换货，93:已换货,94:部分申请退货，95:部分已退货，96:部分申请换货，97:部分已换货，98:换货申请退货，99:换货部分申请退货',
  `supplierId` int(11) DEFAULT NULL COMMENT '供货商ID',
  `describeId` int(11) DEFAULT NULL COMMENT '商品描述表ID',
  `costPrice` varchar(32) DEFAULT NULL COMMENT '采购成本价，加密价格后的字符串',
  `unitPrice` varchar(32) DEFAULT NULL COMMENT '单价(采购成本价/采购数量*记录单位)，加密价格后的字符串',
  `useType` varchar(12) DEFAULT NULL COMMENT '用途类型,product：商品，acc：配饰，materials：加工材料',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=1069 DEFAULT CHARSET=utf8 COMMENT='商品信息';

/*Table structure for table `hzg_product_check` */

DROP TABLE IF EXISTS `hzg_product_check`;

CREATE TABLE `hzg_product_check` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `checkDate` datetime DEFAULT NULL COMMENT '盘点日期',
  `checkNo` varchar(16) DEFAULT NULL COMMENT '盘点单据编号',
  `warehouseId` int(11) DEFAULT NULL COMMENT '盘点仓库id',
  `deptId` int(11) DEFAULT NULL COMMENT '盘点部门id',
  `quantity` float(8,2) DEFAULT NULL COMMENT '盈亏数量',
  `amount` varchar(32) DEFAULT NULL COMMENT '盈亏金额',
  `chartMakerId` int(11) DEFAULT NULL COMMENT '制单人id',
  `companyId` int(11) DEFAULT NULL COMMENT '盘点公司id',
  `remark` varchar(150) DEFAULT NULL COMMENT '备注',
  `state` int(1) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品盘点';

/*Table structure for table `hzg_product_check_detail` */

DROP TABLE IF EXISTS `hzg_product_check_detail`;

CREATE TABLE `hzg_product_check_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  `checkId` int(11) DEFAULT NULL COMMENT '盘点单id',
  `itemNo` varchar(16) DEFAULT NULL COMMENT '存货编号',
  `itemName` varchar(30) DEFAULT NULL COMMENT '存货名称',
  `checkQuantity` float(8,2) DEFAULT NULL COMMENT '盘点数量',
  `checkAmount` varchar(32) DEFAULT NULL COMMENT '盘点金额',
  `paperQuantity` float(8,2) DEFAULT NULL COMMENT '账面数量',
  `paperAmount` varchar(32) DEFAULT NULL COMMENT '账面金额',
  `unit` varchar(6) DEFAULT NULL COMMENT '计量单位',
  `unitPrice` varchar(32) DEFAULT NULL COMMENT '单价',
  `quantity` float(8,2) DEFAULT NULL COMMENT '盈亏数量, <0表示该商品少了',
  `amount` varchar(32) DEFAULT NULL COMMENT '盈亏金额',
  PRIMARY KEY (`Id`),
  KEY `checkId` (`checkId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品盘点明细表';

#
# Structure for table "hzg_product_count"
#

DROP TABLE IF EXISTS `hzg_product_count`;
CREATE TABLE `hzg_product_count` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  `count` varchar(4) DEFAULT NULL COMMENT '次数',
  `type` varchar(4) DEFAULT NULL COMMENT '类别：退货，换货',
  PRIMARY KEY (`Id`),
  KEY `productId` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品退换货次数表';

#
# Structure for table "hzg_product_damage"
#

DROP TABLE IF EXISTS `hzg_product_damage`;
CREATE TABLE `hzg_product_damage` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  `inputDate` datetime DEFAULT NULL COMMENT '报损记录提交时间',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:申请，1:确认损坏，2:确认没损坏',
  `describe` varchar(120) DEFAULT NULL COMMENT '损坏描述',
  `successDate` datetime DEFAULT NULL COMMENT '确认损坏时间',
  `applyUserId` int(11) DEFAULT NULL COMMENT '申请人',
  PRIMARY KEY (`Id`),
  KEY `productId` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品报损单';

#
# Structure for table "hzg_product_describe"
#

DROP TABLE IF EXISTS `hzg_product_describe`;
CREATE TABLE `hzg_product_describe` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `state` int(1) DEFAULT NULL COMMENT '状态，0:未启用，1：启用',
  `describes` varchar(256) DEFAULT NULL COMMENT '软文描述',
  `imageParentDirPath` varchar(30) DEFAULT NULL COMMENT '图片父文件夹地址',
  `videoParentDirPath` varchar(30) DEFAULT NULL COMMENT '视频父文件夹地址',
  `photographerId` int(11) DEFAULT NULL COMMENT '摄影人id',
  `editorId` int(11) DEFAULT NULL COMMENT '编辑id',
  `date` datetime DEFAULT NULL COMMENT '编辑时间',
  `seoTitle` varchar(80) DEFAULT NULL COMMENT '商品优化标题',
  `seoKeyword` varchar(80) DEFAULT NULL COMMENT '商品优化关键词',
  `seoDesc` varchar(100) DEFAULT NULL COMMENT '商品优化描述',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=352 DEFAULT CHARSET=utf8 COMMENT='商品描述';

#
# Structure for table "hzg_product_norelate"
#

DROP TABLE IF EXISTS `hzg_product_norelate`;
CREATE TABLE `hzg_product_norelate` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `newNo` varchar(15) DEFAULT NULL COMMENT '新编码',
  `oldNo` varchar(15) DEFAULT NULL COMMENT '旧编码',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新旧编码关联表';

#
# Structure for table "hzg_product_own_property"
#

DROP TABLE IF EXISTS `hzg_product_own_property`;
CREATE TABLE `hzg_product_own_property` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  `propertyId` int(11) DEFAULT NULL COMMENT '属性id',
  `name` varchar(10) DEFAULT NULL COMMENT '属性名',
  `value` varchar(40) DEFAULT NULL COMMENT '属性值',
  PRIMARY KEY (`Id`),
  KEY `productId` (`productId`),
  KEY `propertyId` (`propertyId`)
) ENGINE=InnoDB AUTO_INCREMENT=9482 DEFAULT CHARSET=utf8 COMMENT='商品属性表';

#
# Structure for table "hzg_product_price_change"
#

DROP TABLE IF EXISTS `hzg_product_price_change`;
CREATE TABLE `hzg_product_price_change` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(12) DEFAULT NULL COMMENT '价格变动码',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品no',
  `price` varchar(32) DEFAULT NULL COMMENT '变动后的销售价格',
  `state` int(1) DEFAULT NULL COMMENT '状态，0：申请，1：可用, 2：保存, 3：已用',
  `isAudit` varchar(255) DEFAULT NULL COMMENT '是否需要审批，Y：需要，N：不需要',
  `userId` int(11) DEFAULT NULL COMMENT '申请变动的人员id',
  `date` datetime DEFAULT NULL COMMENT '变动时间',
  `inputdate` datetime DEFAULT NULL COMMENT '申请时间',
  `prePrice` varchar(32) DEFAULT NULL COMMENT '商品原销售价格',
  PRIMARY KEY (`Id`),
  KEY `productNo` (`productNo`),
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='商品销售价格变动表';

#
# Structure for table "hzg_product_property"
#

DROP TABLE IF EXISTS `hzg_product_property`;
CREATE TABLE `hzg_product_property` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL COMMENT '属性名称',
  `value` varchar(40) DEFAULT NULL COMMENT '属性值',
  `parentId` int(11) DEFAULT NULL COMMENT '父属性id',
  PRIMARY KEY (`Id`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=664 DEFAULT CHARSET=utf8 COMMENT='商品属性表';

#
# Data for table "hzg_product_property"
#

INSERT INTO `hzg_product_property` (`Id`,`name`,`value`,`parentId`) VALUES (1,'镶嵌材质','18K',NULL),(2,'镶嵌材质','14K',NULL),(3,'镶嵌材质','9K',NULL),(4,'种水','玻璃种',NULL),(5,'种水','高冰种',NULL),(6,'种水','冰种',NULL),(7,'种水','糯冰种',NULL),(8,'种水','糯种',NULL),(9,'种水','豆种',NULL),(10,'种水','花青种',NULL),(11,'种水','干青种',NULL),(12,'种水','油青种',NULL),(13,'颜色','无色',NULL),(14,'颜色','白色',NULL),(15,'颜色','浅绿',NULL),(16,'颜色','阳绿',NULL),(17,'颜色','翠绿',NULL),(18,'颜色','深绿',NULL),(19,'颜色','暗绿',NULL),(20,'颜色','蓝绿',NULL),(21,'颜色','蓝水',NULL),(22,'颜色','灰绿',NULL),(23,'颜色','紫罗兰',NULL),(24,'颜色','红翡',NULL),(25,'颜色','黄翡',NULL),(26,'颜色','俏色',NULL),(27,'颜色','多宝',NULL),(28,'颜色','飘花',NULL),(29,'颜色','福绿寿',NULL),(30,'颜色','无',NULL),(31,'种类','翡翠',NULL),(32,'种类','墨翠',NULL),(33,'题材','刻面',NULL),(35,'题材','光面',NULL),(36,'题材','单圈',NULL),(37,'题材','多圈',NULL),(38,'题材','观音',NULL),(39,'题材','关羽',NULL),(40,'题材','弥勒佛',NULL),(41,'题材','大日如来（阿弥陀佛、释迦牟尼佛）',NULL),(42,'题材','大势至',NULL),(43,'题材','普贤',NULL),(44,'题材','地藏王',NULL),(45,'题材','虚空藏',NULL),(46,'题材','不动明王',NULL),(47,'题材','一念之间（半魔半佛）',NULL),(48,'题材','千手观音',NULL),(49,'题材','罗汉',NULL),(50,'题材','子鼠',NULL),(51,'题材','丑牛',NULL),(52,'题材','寅虎',NULL),(53,'题材','卯兔',NULL),(54,'题材','辰龙',NULL),(55,'题材','巳蛇',NULL),(56,'题材','午马',NULL),(57,'题材','未羊',NULL),(58,'题材','申猴',NULL),(59,'题材','酉鸡',NULL),(60,'题材','戌狗',NULL),(61,'题材','亥猪',NULL),(62,'题材','福瓜',NULL),(63,'题材','福豆',NULL),(64,'题材','金枝玉叶（叶子）',NULL),(65,'题材','花开富贵（牡丹）',NULL),(66,'题材','凤凰（吉祥）',NULL),(67,'题材','麒麟（辟邪、吉祥）',NULL),(68,'题材','招财进宝（金蟾）',NULL),(69,'题材','貔貅（财富）',NULL),(70,'题材','龙龟（荣归）',NULL),(71,'题材','囚牛（立于琴头）',NULL),(72,'题材','睚眦（喜好刀剑）',NULL),(73,'题材','蒲牢（立于钟上）',NULL),(74,'题材','狻猊（立于香炉）',NULL),(75,'题材','狴犴（立于衙门）',NULL),(76,'题材','饕餮（立于食盒）',NULL),(77,'题材','螭吻（立于殿脊带鱼尾）',NULL),(78,'题材','椒图（带螺蚌的龙）',NULL),(79,'题材','福寿双全（蝙蝠或桃、铜钱、狐狸、佛手）',NULL),(80,'题材','福禄寿喜（蝙蝠、鹿、桃、喜）',NULL),(81,'题材','福禄寿（蝙蝠、鹿、桃）',NULL),(82,'题材','福从天降（蝙蝠、小孩、南瓜）',NULL),(83,'题材','福禄（葫芦）',NULL),(84,'题材','终身有福（钟和蝙蝠）',NULL),(85,'题材','五福临门（五只蝙蝠）',NULL),(86,'题材','流云百福（云和蝙蝠）',NULL),(87,'题材','福在眼前（蝙蝠和铜钱）',NULL),(88,'题材','洪福齐天（蝙蝠、猴子和桃）',NULL),(89,'题材','喜上眉梢（喜鹊）',NULL),(90,'题材','三阳开泰（三只羊）',NULL),(91,'题材','如意（林芝）',NULL),(92,'题材','弯弯顺（虾）',NULL),(93,'题材','平安扣',NULL),(94,'题材','丹凤朝阳（凤凰、牡丹、太阳、梧桐树）',NULL),(95,'题材','龙凤呈祥（龙和凤）',NULL),(96,'题材','喜从天降（蜘蛛网和蜘蛛）',NULL),(97,'题材','知足常乐（蜘蛛）',NULL),(98,'题材','寿桃',NULL),(99,'题材','禅悟',NULL),(100,'题材','鱼跃龙门',NULL),(101,'题材','金玉满堂（金鱼）',NULL),(102,'题材','年年有余（荷叶和鱼）',NULL),(103,'题材','一鸣惊人（蝉）',NULL),(104,'题材','大展宏图（鹰）',NULL),(105,'题材','英雄斗志（鹰、熊）',NULL),(106,'题材','长寿龟',NULL),(107,'题材','龙马精神（龙和马）',NULL),(108,'题材','一品当朝（鹤）',NULL),(109,'题材','松鹤延年（松和鹤）',NULL),(110,'题材','钟馗',NULL),(111,'题材','达摩',NULL),(112,'题材','狮子',NULL),(113,'题材','虎虎生威（虎）',NULL),(114,'题材','财神（赵公明）',NULL),(115,'题材','黄财神（藏传佛教）',NULL),(116,'题材','大黑天（藏传佛教）',NULL),(117,'题材','绿度母（藏传佛教）',NULL),(118,'题材','官上加官（公鸡、鸡冠花）',NULL),(119,'题材','高官厚禄（鸡和鹿）',NULL),(120,'题材','加官授禄（鹿）',NULL),(121,'题材','路路顺利（两只鹿）',NULL),(122,'题材','鹤鹿回春（鹤和鹿）',NULL),(123,'题材','封侯挂印（猴和印章）',NULL),(124,'题材','辈辈封侯（大猴背小猴）',NULL),(125,'题材','马上封侯（马和猴）',NULL),(126,'题材','长命富贵（如意锁）',NULL),(127,'题材','望子成龙（一大一小动物）',NULL),(128,'题材','平安如意（瓶子、鹌鹑）',NULL),(129,'题材','事事如意（柿子和如意）',NULL),(130,'题材','二龙戏珠',NULL),(131,'题材','万象升平（象和瓶）',NULL),(132,'题材','吉祥如意（云、象、林芝、雄鸡）',NULL),(133,'题材','必定如意（笔）',NULL),(134,'题材','连升三级（三只鸡或三叉戟）',NULL),(135,'题材','嫦娥奔月',NULL),(136,'题材','四海升平（海水、四个小孩、瓶子）',NULL),(137,'题材','多子多福（许多果实、石榴、葡萄、莲子、花生、玉米）',NULL),(138,'题材','八仙过海',NULL),(139,'题材','独占鳌头（鳖）',NULL),(140,'题材','琴棋书画',NULL),(141,'题材','伯牙摔琴（人物、琴、墓碑）',NULL),(142,'题材','天女散花（仙女、花）',NULL),(143,'题材','踏雪寻梅（老人、风雪、梅花、骑驴）',NULL),(144,'题材','鹤寿龟龌（鹤和龟）',NULL),(145,'题材','百财（白菜）',NULL),(146,'题材','红红火火（辣椒）',NULL),(147,'题材','长寿（茄子、桃）',NULL),(148,'题材','岁岁平安（麦穗）',NULL),(149,'题材','节节高升（竹子）',NULL),(150,'题材','佳偶天成（莲藕）',NULL),(151,'题材','聪明伶俐（菱角）',NULL),(152,'题材','傲骨长存（梅花）',NULL),(153,'题材','百年好合（百合）',NULL),(154,'题材','品性高洁（兰花）',NULL),(155,'题材','辟邪进宝（海螺、葫芦）',NULL),(156,'题材','甲天下（蝎子、甲虫）',NULL),(157,'题材','蝴蝶（爱情）',NULL),(158,'题材','五子登科（五只小鸡）',NULL),(159,'题材','天鹅（忠诚、高贵、纯洁）',NULL),(160,'题材','八方来财（螃蟹）',NULL),(161,'题材','壁虎（庇护、必得幸福）',NULL),(162,'题材','百鸟嘲凤（百鸟图）',NULL),(163,'题材','欢欢喜喜（獾）',NULL),(164,'题材','后羿射日',NULL),(165,'题材','女娲补天',NULL),(166,'题材','寿星',NULL),(167,'题材','老子',NULL),(168,'题材','孔子',NULL),(169,'题材','侍女（胸怀博大）',NULL),(170,'题材','天使',NULL),(171,'题材','渔翁得利',NULL),(172,'题材','刘海戏金蟾',NULL),(173,'题材','福星高照（三位老神仙）',NULL),(174,'题材','群仙祝寿（多位仙人手持礼物）',NULL),(175,'题材','把把胡（茶壶）',NULL),(176,'题材','青云直上（风筝）',NULL),(177,'题材','一路平安（鹭鸶、瓶、鹌鹑）',NULL),(178,'题材','一路富贵（鹭鸶和牡丹）',NULL),(179,'题材','一路联科（鹭鸶、荷叶、桂圆）',NULL),(180,'题材','堂上双白（海棠、两位老人）',NULL),(181,'题材','指日高升（官人指太阳）',NULL),(182,'题材','升官发财（龙、猴子）',NULL),(183,'题材','生意兴隆（花生、龙）',NULL),(184,'题材','喜事连连（柿子、喜鹊）',NULL),(185,'题材','称心如意（柿子和桃、秤砣）',NULL),(186,'题材','连中三元（三支喜鹊、三个元宝、三个桂圆、三颗豆子）',NULL),(187,'题材','麻姑献寿（仙女、桃）',NULL),(188,'题材','如意封侯（猴子和如意）',NULL),(189,'题材','福如东海（蝙蝠、海、日出}',NULL),(190,'题材','福寿齐眉（蝙蝠、桃、梅花、荸荠）',NULL),(191,'题材','稳稳升侯（大象和猴子）',NULL),(192,'题材','万象跟新（大象和万年青）',NULL),(193,'题材','安居乐业（鹌鹑、菊花）',NULL),(194,'题材','状元及第（龙和小孩、鸭）',NULL),(195,'题材','麒麟送子（麒麟和小孩）',NULL),(196,'题材','送子观音（观音和小孩）',NULL),(197,'题材','五子闹弥勒（五个小孩和弥勒）',NULL),(198,'题材','送财童子（小孩和元宝）',NULL),(199,'题材','童趣（小孩）',NULL),(200,'题材','渔樵耕读（渔夫、樵夫、农夫与书生）',NULL),(201,'题材','和合二仙',NULL),(202,'题材','岁寒三友（竹松梅）',NULL),(203,'题材','亭亭玉立（蜻蜓荷花、玉兰花）',NULL),(204,'题材','苦瓜（苦尽甘来）',NULL),(205,'题材','鸳鸯（夫妻恩爱）',NULL),(206,'题材','孔雀（文明、修养、高管）',NULL),(207,'题材','熊鱼兼得（鱼和熊）',NULL),(208,'题材','八卦（驱邪避凶）',NULL),(209,'题材','八宝（八件宝器）',NULL),(210,'题材','四大神兽（青龙、白虎、朱雀、玄武）',NULL),(211,'题材','金陵十二钗（林黛玉、薛宝钗、贾元春、贾探春、史湘云、妙玉、王',NULL),(212,'题材','五鼠运财（五只老鼠和铜钱）',NULL),(213,'题材','牧童（小孩和牛）',NULL),(214,'题材','玫瑰花（爱情）',NULL),(217,'题材','无',NULL),(218,'款式','108佛珠',NULL),(219,'款式','吊坠 ',NULL),(220,'款式','戒指',NULL),(221,'款式','耳钉',NULL),(222,'款式','耳坠',NULL),(223,'款式','手把件',NULL),(224,'款式','摆件',NULL),(225,'款式','项链',NULL),(226,'款式','手串',NULL),(227,'款式','手链',NULL),(228,'款式','手环',NULL),(229,'款式','贵妃镯',NULL),(230,'款式','圆镯',NULL),(231,'款式','方镯',NULL),(232,'款式','平安镯',NULL),(233,'款式','扁镯',NULL),(234,'款式','裸石',NULL),(235,'款式','胸针',NULL),(236,'款式','发钗',NULL),(237,'款式','圆珠',NULL),(238,'款式','桶珠',NULL),(239,'款式','鼓珠',NULL),(240,'款式','轮胎珠',NULL),(241,'款式','三通',NULL),(242,'款式','背云',NULL),(243,'款式','套装（两件、三件、四件等',NULL),(244,'透明度','透明',NULL),(245,'透明度','亚透明',NULL),(246,'透明度','半透明',NULL),(247,'透明度','微透明',NULL),(248,'透明度','不透明',NULL),(249,'瑕疵','无瑕',NULL),(250,'瑕疵','微杂',NULL),(251,'瑕疵','微裂',NULL),(252,'瑕疵','微棉',NULL),(253,'瑕疵','石纹',NULL),(254,'瑕疵','有坑',NULL),(255,'瑕疵','填充',NULL),(256,'瑕疵','虫眼',NULL),(257,'瑕疵','白芯',NULL),(258,'雕工','南派',NULL),(259,'雕工','苏派',NULL),(260,'雕工','北派',NULL),(261,'雕工','海派',NULL),(262,'形状','环形',NULL),(263,'形状','星形',NULL),(264,'形状','圆形',NULL),(265,'形状','钩状',NULL),(266,'形状','椭圆',NULL),(267,'形状','方形',NULL),(268,'形状','鼎形',NULL),(269,'形状','卵形',NULL),(270,'形状','三角',NULL),(271,'形状','八角',NULL),(272,'镶嵌材质','银镶',NULL),(273,'镶嵌材质','无',NULL),(274,'性质','无',NULL),(275,'色种','棉红',NULL),(276,'色种','柿子红',NULL),(277,'色种','玫瑰红',NULL),(278,'色种','樱桃红',NULL),(279,'色种','朱砂红',NULL),(280,'色种','俏色',NULL),(281,'色种','黑色',NULL),(282,'色种','铁皮包浆料',NULL),(283,'色种','冻料',NULL),(284,'色种','冰飘料',NULL),(285,'色种','红白料',NULL),(286,'种类','南红',NULL),(289,'瓷度','高瓷乌兰花',NULL),(290,'瓷度','高瓷玉华',NULL),(291,'瓷度','高瓷铁线',NULL),(292,'瓷度','中高瓷铁线',NULL),(293,'瓷度','中瓷铁线',NULL),(294,'瓷度','中瓷',NULL),(295,'瓷度','中高瓷',NULL),(296,'瓷度','高瓷',NULL),(297,'产地','缅甸',NULL),(299,'产地','巴西',NULL),(300,'产地','俄罗斯',NULL),(301,'产地','斯里兰卡',NULL),(313,'产地','印度',NULL),(314,'产地','越南',NULL),(315,'产地','印尼',NULL),(316,'产地','肯尼亚',NULL),(317,'产地','南非',NULL),(318,'产地','阿根廷',NULL),(319,'产地','澳大利亚',NULL),(320,'产地','墨西哥',NULL),(321,'产地','西藏',NULL),(322,'产地','中国',NULL),(323,'产地','坦桑尼亚',NULL),(324,'产地','阿富汗',NULL),(325,'产地','海南',NULL),(326,'产地','伊朗',NULL),(327,'产地','美国',NULL),(328,'产地','湖北',NULL),(329,'产地','台湾',NULL),(330,'产地','意大利',NULL),(331,'产地','日本',NULL),(332,'产地','多米尼加',NULL),(333,'产地','波罗的海',NULL),(334,'产地','赞比亚',NULL),(335,'产地','哥伦比亚',NULL),(336,'产地','莫桑比克',NULL),(337,'产地','泰国',NULL),(338,'产地','尼泊尔',NULL),(339,'产地','安徽',NULL),(340,'产地','文莱',NULL),(341,'产地','加里曼丹',NULL),(342,'产地','保山',NULL),(343,'产地','四川',NULL),(344,'颜色','蔚蓝',NULL),(345,'颜色','灰白色',NULL),(346,'颜色','褐色',NULL),(347,'颜色','秋叶黄',NULL),(348,'颜色','黄绿',NULL),(349,'颜色','绿色',NULL),(350,'颜色','浅蓝',NULL),(351,'种类','绿松石',NULL),(352,'性质','带皮',NULL),(353,'性质','烤色',NULL),(354,'颜色','瓷白',NULL),(355,'颜色','象牙白',NULL),(356,'颜色','浅黄',NULL),(357,'颜色','柠檬黄',NULL),(358,'颜色','鸡油黄',NULL),(359,'颜色','褐黄',NULL),(360,'颜色','褐红',NULL),(361,'颜色','枣红',NULL),(363,'种类','蜜蜡',NULL),(364,'种类','白蜜',NULL),(365,'种类','白花蜜',NULL),(366,'种类','金绞蜜',NULL),(367,'种类','老蜜蜡',NULL),(368,'种类','溶洞蜜',NULL),(369,'净度','全净水',NULL),(370,'净度','净水',NULL),(371,'净度','无',NULL),(372,'种类','金珀',NULL),(373,'种类','红茶珀',NULL),(374,'种类','植物珀',NULL),(375,'种类','虫珀',NULL),(376,'种类','血珀',NULL),(377,'种类','金红珀',NULL),(378,'种类','绿茶珀',NULL),(379,'种类','翳珀\r\n翳珀',NULL),(380,'种类','花珀',NULL),(381,'种类','黄茶珀',NULL),(382,'种类','棕珀',NULL),(383,'种类','紫茶珀',NULL),(384,'种类','根珀',NULL),(385,'种类','多米蓝珀',NULL),(386,'种类','石珀',NULL),(387,'种类','明珀',NULL),(388,'种类','绿珀',NULL),(389,'种类','水胆珀',NULL),(390,'种类','天空蓝多米蓝珀',NULL),(391,'种类','墨西哥蓝珀',NULL),(392,'属性','阿卡',NULL),(393,'属性','沙丁',NULL),(394,'属性','momo',NULL),(395,'颜色','黑红',NULL),(396,'颜色','粉红',NULL),(397,'颜色','橘色',NULL),(398,'颜色','橘红',NULL),(399,'颜色','朱红',NULL),(400,'颜色','正红',NULL),(401,'颜色','深红',NULL),(402,'种类','珊瑚',NULL),(403,'料种','山料',NULL),(404,'料种','籽料',NULL),(405,'料种','山流水料',NULL),(406,'种类','羊脂白和田玉',NULL),(407,'种类','和田白玉',NULL),(408,'种类','青白玉',NULL),(409,'种类','青玉',NULL),(410,'种类','碧玉',NULL),(411,'种类','墨玉',NULL),(412,'种类','黄玉',NULL),(413,'种类','糖玉',NULL),(414,'种类','俏色和田玉',NULL),(415,'产地','新疆',NULL),(416,'产地','青海',NULL),(417,'产地','韩国',NULL),(418,'颜色','乌鸦皮',NULL),(419,'颜色','橙黄',NULL),(422,'颜色','阳绿',NULL),(423,'颜色','西瓜红',NULL),(424,'颜色','鲜红',NULL),(425,'颜色','鸡血红',NULL),(426,'颜色','土黄',NULL),(427,'颜色','棕黄',NULL),(428,'种类','黄龙玉',NULL),(429,'产地','浙江',NULL),(430,'产地','广东',NULL),(432,'镶嵌材质','PT',NULL),(437,'特性','无烧',NULL),(438,'特性','无（有烧）',NULL),(439,'特性','星光',NULL),(440,'颜色','鸽血红',NULL),(441,'种类','红宝石',NULL),(442,'种类','蓝宝石',NULL),(443,'颜色','矢车菊',NULL),(444,'颜色','变色',NULL),(445,'颜色','帕帕拉恰',NULL),(446,'颜色','粉色',NULL),(447,'颜色','绿色',NULL),(448,'颜色','蓝绿色',NULL),(449,'颜色','黄绿色',NULL),(450,'颜色','黄色',NULL),(451,'颜色','橙色',NULL),(452,'颜色','橙红色',NULL),(453,'颜色','紫红',NULL),(454,'颜色','紫色',NULL),(455,'颜色','蓝紫色',NULL),(456,'颜色','浅蓝色',NULL),(457,'颜色','蓝色',NULL),(458,'颜色','深蓝色',NULL),(459,'颜色','皇家蓝',NULL),(460,'特性','水胆',NULL),(461,'特性','猫眼',NULL),(462,'特性','无',NULL),(463,'种类','水晶石',NULL),(464,'种类','黄水晶',NULL),(465,'种类','紫水晶',NULL),(466,'种类','粉晶',NULL),(467,'种类','紫黄晶',NULL),(468,'种类','白幽灵',NULL),(469,'种类','绿幽灵',NULL),(470,'种类','兔毛晶',NULL),(471,'种类','金发晶',NULL),(472,'种类','钛晶',NULL),(473,'种类','铜发晶',NULL),(474,'种类','黑发晶',NULL),(475,'种类','绿发晶',NULL),(476,'种类','茶晶',NULL),(477,'种类','墨晶',NULL),(478,'产地','马达加斯加',NULL),(479,'产地','危地马拉',NULL),(480,'颜色','酒红',NULL),(481,'颜色','橙红',NULL),(482,'颜色','黑色',NULL),(483,'颜色','棕色',NULL),(484,'种类','石榴石',NULL),(485,'种类','沙弗莱',NULL),(486,'种类','翠榴石',NULL),(487,'等级','青金石级',NULL),(488,'等级','青金级',NULL),(489,'等级','金克浪级',NULL),(490,'等级','催生石级',NULL),(491,'颜色','天蓝色',NULL),(492,'颜色','紫蓝色',NULL),(493,'颜色','绿蓝色',NULL),(494,'种类','青金石',NULL),(495,'颜色','亮绿',NULL),(496,'颜色','鲜绿',NULL),(497,'种类','祖母绿',NULL),(498,'特性','变色',NULL),(499,'颜色','西瓜',NULL),(500,'颜色','红色',NULL),(501,'颜色','卢比莱色',NULL),(502,'颜色','深绿色',NULL),(503,'种类','碧玺',NULL),(504,'种类','帕拉伊巴碧玺',NULL),(505,'净度','fl',NULL),(506,'净度','if',NULL),(507,'净度','vvs1',NULL),(508,'净度','vvs2',NULL),(509,'净度','vs1',NULL),(510,'净度','vs2',NULL),(511,'净度','si1',NULL),(512,'净度','si2',NULL),(513,'净度','i1',NULL),(514,'净度','i2',NULL),(515,'净度','i3',NULL),(516,'颜色','D色',NULL),(517,'颜色','E色',NULL),(518,'颜色','F色',NULL),(519,'颜色','G色',NULL),(520,'颜色','H色',NULL),(521,'颜色','I色',NULL),(522,'颜色','J色',NULL),(523,'颜色','K色',NULL),(524,'颜色','L色',NULL),(527,'种类','钻石',NULL),(528,'大小','5ct',NULL),(529,'大小','4ct',NULL),(530,'大小','3ct',NULL),(531,'大小','2ct',NULL),(532,'大小','1ct',NULL),(533,'大小','90分',NULL),(534,'大小','80分',NULL),(535,'大小','70分',NULL),(536,'大小','60分',NULL),(537,'大小','50分',NULL),(538,'大小','40分',NULL),(539,'大小','30分',NULL),(540,'大小','20分',NULL),(541,'大小','10分',NULL),(542,'种类','金绿宝石',NULL),(543,'种类','变石猫眼',NULL),(544,'特性','满星',NULL),(545,'特性','半星',NULL),(546,'特性','带星',NULL),(547,'特性','鱼鳞纹',NULL),(548,'特性','满留疤',NULL),(549,'特性','半留疤',NULL),(550,'特性','老星',NULL),(551,'特性','幼星',NULL),(552,'特性','水波纹',NULL),(553,'种类','小叶紫檀',NULL),(554,'产地','马来西亚',NULL),(555,'种类','沉香',NULL),(556,'种类','水沉香',NULL),(557,'种类','土沉香',NULL),(558,'种类','蚁沉香',NULL),(567,'款式','线香',NULL),(568,'款式','盘香',NULL),(569,'款式','粉',NULL),(570,'地区','海南',NULL),(571,'地区','马来西亚',NULL),(572,'地区','泰国',NULL),(573,'地区','越南',NULL),(574,'地区','文莱',NULL),(575,'地区','加里曼丹',NULL),(576,'地区','非洲',NULL),(577,'地区','南美',NULL),(578,'种类','奇楠沉香',NULL),(585,'纹路','鬼脸',NULL),(586,'纹路','鬼眼',NULL),(587,'纹路','山水纹',NULL),(588,'纹路','虎皮纹',NULL),(589,'纹路','X纹',NULL),(590,'纹路','蜘蛛纹',NULL),(591,'纹路','闪电纹',NULL),(592,'纹路','蟹爪纹',NULL),(593,'种类','黄花梨',NULL),(594,'料性','老料',NULL),(595,'料性','黄料',NULL),(596,'料性','阴沉绿料',NULL),(597,'料性','新料',NULL),(598,'纹路','顺纹',NULL),(599,'纹路','留疤',NULL),(600,'纹路','水波纹',NULL),(601,'种类','金丝楠木',NULL),(602,'镶嵌材质','镶嵌绿松石',NULL),(603,'镶嵌材质','镶嵌蜜蜡',NULL),(604,'镶嵌材质','镶嵌朱砂',NULL),(605,'镶嵌材质','镶嵌南红',NULL),(606,'特性','高密',NULL),(607,'颜色','顺白',NULL),(608,'颜色','阴皮',NULL),(609,'种类','正月菩提',NULL),(610,'种类','偏月菩提',NULL),(611,'瓣数','5瓣',NULL),(612,'瓣数','6瓣',NULL),(613,'瓣数','7瓣',NULL),(614,'瓣数','8瓣',NULL),(615,'瓣数','9瓣',NULL),(616,'瓣数','10瓣',NULL),(617,'瓣数','11瓣',NULL),(618,'瓣数','12瓣',NULL),(619,'瓣数','13瓣',NULL),(620,'瓣数','14瓣',NULL),(621,'瓣数','15瓣',NULL),(622,'瓣数','16瓣',NULL),(623,'瓣数','17瓣',NULL),(624,'瓣数','18瓣',NULL),(625,'瓣数','19瓣',NULL),(626,'瓣数','20瓣',NULL),(627,'瓣数','21瓣',NULL),(628,'瓣数','22瓣',NULL),(629,'瓣数','23瓣',NULL),(630,'纹路','蛤蟆背',NULL),(631,'纹路','荔枝纹',NULL),(632,'纹路','盘龙纹',NULL),(633,'纹路','麒麟纹',NULL),(634,'种类','金刚菩提',NULL),(637,'珠径','6mm',NULL),(638,'珠径','6.5mm',NULL),(639,'珠径','7mm',NULL),(640,'珠径','7.5mm',NULL),(641,'珠径','8mm',NULL),(642,'珠径','8.5mm',NULL),(643,'珠径','9mm',NULL),(644,'珠径','9.5mm',NULL),(645,'珠径','10mm',NULL),(646,'珠径','10.5mm',NULL),(647,'珠径','11mm',NULL),(648,'珠径','11.5mm',NULL),(649,'珠径','12mm',NULL),(650,'珠径','12.5mm',NULL),(651,'珠径','13mm',NULL),(652,'珠径','13.5mm',NULL),(653,'珠径','14mm',NULL),(654,'珠径','14.5mm',NULL),(655,'珠径','15mm',NULL),(658,'纹路','大眼',NULL),(659,'纹路','小眼',NULL),(660,'种类','凤眼菩提',NULL),(661,'颜色','彩色',NULL),(662,'种类','黑曜石',NULL),(663,'种类','冰曜石',NULL);

#
# Structure for table "hzg_product_show"
#

DROP TABLE IF EXISTS `hzg_product_show`;
CREATE TABLE `hzg_product_show` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  `recommend` varchar(12) DEFAULT NULL COMMENT '推荐类型：红掌柜推荐，精品推荐，特惠等',
  `position` varchar(12) DEFAULT NULL COMMENT '推荐位置',
  PRIMARY KEY (`Id`),
  KEY `productId` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品广告位展示';

#
# Structure for table "hzg_product_type"
#

DROP TABLE IF EXISTS `hzg_product_type`;
CREATE TABLE `hzg_product_type` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL COMMENT '父id',
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  `abbreviate` varchar(10) DEFAULT NULL COMMENT '分类简写',
  `title` varchar(50) DEFAULT NULL COMMENT '商品分类优化标题',
  `keyword` varchar(50) DEFAULT NULL COMMENT '商品分类优化关键词',
  `describes` varchar(100) DEFAULT NULL COMMENT '商品分类优化描述',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='商品分类';

#
# Data for table "hzg_product_type"
#

INSERT INTO `hzg_product_type` (`Id`,`parentId`,`name`,`abbreviate`,`title`,`keyword`,`describes`) VALUES (1,NULL,'蜜蜡','ml','蜜蜡','蜜蜡','蜜蜡'),(3,NULL,'翡翠','fc','翡翠','翡翠','翡翠'),(4,NULL,'南红','nh','南红','南红','南红'),(5,NULL,'绿松石','lcs','绿松石','绿松石','绿松石'),(6,NULL,'琥珀','hb','琥珀','琥珀','琥珀'),(7,NULL,'珊瑚','sh','珊瑚','珊瑚','珊瑚'),(8,NULL,'和田玉','hty','和田玉','和田玉','和田玉'),(9,NULL,'黄龙玉','hly','黄龙玉','黄龙玉','黄龙玉'),(10,NULL,'红宝石','hbs','红宝石','红宝石','红宝石'),(11,NULL,'蓝宝石','lbs','蓝宝石','蓝宝石','蓝宝石'),(12,NULL,'水晶','sj','水晶命','水晶命','水晶命'),(13,NULL,'石榴石','sls','石榴石','石榴石','石榴石'),(14,NULL,'青金石','qjs','青金石','青金石','青金石'),(15,NULL,'祖母绿','zml','祖母绿','祖母绿','祖母绿'),(16,NULL,'碧玺','by','碧玺','碧玺','碧玺'),(17,NULL,'钻石','zs','钻石','钻石','钻石'),(18,NULL,'金绿宝石','jlbs','金绿宝石','金绿宝石','金绿宝石'),(19,NULL,'小叶紫檀','xyzt','小叶紫檀','小叶紫檀','小叶紫檀'),(20,NULL,'沉香','cx','沉香','沉香','沉香'),(21,NULL,'黄花梨','hhl','黄花梨','黄花梨','黄花梨'),(22,NULL,'金丝楠木','jsnm','金丝楠木','金丝楠木','金丝楠木'),(23,NULL,'星月菩提','xypt','星月菩提','星月菩提','星月菩提'),(24,NULL,'金刚菩提','jgpt','金刚菩提','金刚菩提','金刚菩提'),(25,NULL,'凤眼菩提','fypt','凤眼菩提','凤眼菩提','凤眼菩提'),(26,NULL,'黑曜石','hys','黑曜石','黑曜石','黑曜石');

#
# Structure for table "hzg_producttypeproperty_relate"
#

DROP TABLE IF EXISTS `hzg_producttypeproperty_relate`;
CREATE TABLE `hzg_producttypeproperty_relate` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `typeId` int(11) DEFAULT NULL COMMENT '商品类型id',
  `propertyId` int(11) DEFAULT NULL COMMENT '商品属性id',
  PRIMARY KEY (`Id`),
  KEY `typeId` (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5598 DEFAULT CHARSET=utf8 COMMENT='商品类型属性关联表';

#
# Data for table "hzg_producttypeproperty_relate"
#

INSERT INTO `hzg_producttypeproperty_relate` (`Id`,`typeId`,`propertyId`) VALUES (1,3,1),(2,3,2),(3,3,3),(4,3,4),(5,3,5),(6,3,6),(7,3,7),(8,3,8),(9,3,9),(10,3,10),(11,3,11),(12,3,12),(13,3,13),(14,3,14),(15,3,15),(16,3,16),(17,3,17),(18,3,18),(19,3,19),(20,3,20),(21,3,21),(22,3,22),(23,3,23),(24,3,24),(25,3,25),(26,3,26),(27,3,27),(28,3,28),(29,3,29),(30,3,30),(31,3,31),(32,3,32),(33,3,33),(34,3,34),(35,3,35),(36,3,36),(37,3,37),(38,3,38),(39,3,39),(40,3,40),(41,3,41),(42,3,42),(43,3,43),(44,3,44),(45,3,45),(46,3,46),(47,3,47),(48,3,48),(49,3,49),(50,3,50),(51,3,51),(52,3,52),(53,3,53),(54,3,54),(55,3,55),(56,3,56),(57,3,57),(58,3,58),(59,3,59),(60,3,60),(61,3,61),(62,3,62),(63,3,63),(64,3,64),(65,3,65),(66,3,66),(67,3,67),(68,3,68),(69,3,69),(70,3,70),(71,3,71),(72,3,72),(73,3,73),(74,3,74),(75,3,75),(76,3,76),(77,3,77),(78,3,78),(79,3,79),(80,3,80),(81,3,81),(82,3,82),(83,3,83),(84,3,84),(85,3,85),(86,3,86),(87,3,87),(88,3,88),(89,3,89),(90,3,90),(91,3,91),(92,3,92),(93,3,93),(94,3,94),(95,3,95),(96,3,96),(97,3,97),(98,3,98),(99,3,99),(100,3,100),(101,3,101),(102,3,102),(103,3,103),(104,3,104),(105,3,105),(106,3,106),(107,3,107),(108,3,108),(109,3,109),(110,3,110),(111,3,111),(112,3,112),(113,3,113),(114,3,114),(115,3,115),(116,3,116),(117,3,117),(118,3,118),(119,3,119),(120,3,120),(121,3,121),(122,3,122),(123,3,123),(124,3,124),(125,3,125),(126,3,126),(127,3,127),(128,3,128),(129,3,129),(130,3,130),(131,3,131),(132,3,132),(133,3,133),(134,3,134),(135,3,135),(136,3,136),(137,3,137),(138,3,138),(139,3,139),(140,3,140),(141,3,141),(142,3,142),(143,3,143),(144,3,144),(145,3,145),(146,3,146),(147,3,147),(148,3,148),(149,3,149),(150,3,150),(151,3,151),(152,3,152),(153,3,153),(154,3,154),(155,3,155),(156,3,156),(157,3,157),(158,3,158),(159,3,159),(160,3,160),(161,3,161),(162,3,162),(163,3,163),(164,3,164),(165,3,165),(166,3,166),(167,3,167),(168,3,168),(169,3,169),(170,3,170),(171,3,171),(172,3,172),(173,3,173),(174,3,174),(175,3,175),(176,3,176),(177,3,177),(178,3,178),(179,3,179),(180,3,180),(181,3,181),(182,3,182),(183,3,183),(184,3,184),(185,3,185),(186,3,186),(187,3,187),(188,3,188),(189,3,189),(190,3,190),(191,3,191),(192,3,192),(193,3,193),(194,3,194),(195,3,195),(196,3,196),(197,3,197),(198,3,198),(199,3,199),(200,3,200),(201,3,201),(202,3,202),(203,3,203),(204,3,204),(205,3,205),(206,3,206),(207,3,207),(208,3,208),(209,3,209),(210,3,210),(211,3,211),(212,3,212),(213,3,213),(214,3,214),(215,3,215),(216,3,216),(217,3,217),(218,3,218),(219,3,219),(220,3,220),(221,3,221),(222,3,222),(223,3,223),(224,3,224),(225,3,225),(226,3,226),(227,3,227),(228,3,228),(229,3,229),(230,3,230),(231,3,231),(232,3,232),(233,3,233),(234,3,234),(235,3,235),(236,3,236),(237,3,237),(238,3,238),(239,3,239),(240,3,240),(241,3,241),(242,3,242),(243,3,243),(244,3,244),(245,3,245),(246,3,246),(247,3,247),(248,3,248),(249,3,249),(250,3,250),(251,3,251),(252,3,252),(253,3,253),(254,3,254),(255,3,255),(256,3,256),(257,3,257),(258,3,258),(259,3,259),(260,3,260),(261,3,261),(262,3,262),(263,3,263),(264,3,264),(265,3,265),(266,3,266),(267,3,267),(268,3,268),(269,3,269),(270,3,270),(271,3,271),(272,3,272),(273,3,273),(364,3,297),(880,4,1),(881,4,2),(882,4,3),(883,4,272),(884,4,273),(885,4,274),(886,4,275),(887,4,276),(888,4,278),(889,4,279),(890,4,280),(891,4,281),(892,4,282),(893,4,283),(894,4,284),(895,4,285),(896,4,286),(897,4,33),(898,4,34),(899,4,35),(900,4,36),(901,4,37),(902,4,38),(903,4,39),(904,4,40),(905,4,41),(906,4,42),(907,4,43),(908,4,44),(909,4,45),(910,4,46),(911,4,47),(912,4,48),(913,4,49),(914,4,50),(915,4,51),(916,4,52),(917,4,53),(918,4,54),(919,4,55),(920,4,56),(921,4,57),(922,4,58),(923,4,59),(924,4,60),(925,4,61),(926,4,62),(927,4,63),(928,4,64),(929,4,65),(930,4,66),(931,4,67),(932,4,68),(933,4,69),(934,4,70),(935,4,71),(936,4,72),(937,4,73),(938,4,74),(939,4,75),(940,4,76),(941,4,77),(942,4,78),(943,4,79),(944,4,80),(945,4,81),(946,4,82),(947,4,83),(948,4,84),(949,4,85),(950,4,86),(951,4,87),(952,4,88),(953,4,89),(954,4,90),(955,4,91),(956,4,92),(957,4,93),(958,4,94),(959,4,95),(960,4,96),(961,4,97),(962,4,98),(963,4,99),(964,4,100),(965,4,101),(966,4,102),(967,4,103),(968,4,104),(969,4,105),(970,4,106),(971,4,107),(972,4,108),(973,4,109),(974,4,110),(975,4,111),(976,4,112),(977,4,113),(978,4,114),(979,4,115),(980,4,116),(981,4,117),(982,4,118),(983,4,119),(984,4,120),(985,4,121),(986,4,122),(987,4,123),(988,4,124),(989,4,125),(990,4,126),(991,4,127),(992,4,128),(993,4,129),(994,4,130),(995,4,131),(996,4,132),(997,4,133),(998,4,134),(999,4,135),(1000,4,136),(1001,4,137),(1002,4,138),(1003,4,139),(1004,4,140),(1005,4,141),(1006,4,142),(1007,4,143),(1008,4,144),(1009,4,145),(1010,4,146),(1011,4,147),(1012,4,148),(1013,4,149),(1014,4,150),(1015,4,151),(1016,4,152),(1017,4,153),(1018,4,154),(1019,4,155),(1020,4,156),(1021,4,157),(1022,4,158),(1023,4,159),(1024,4,160),(1025,4,161),(1026,4,162),(1027,4,163),(1028,4,164),(1029,4,165),(1030,4,166),(1031,4,167),(1032,4,168),(1033,4,169),(1034,4,170),(1035,4,171),(1036,4,172),(1037,4,173),(1038,4,174),(1039,4,175),(1040,4,176),(1041,4,177),(1042,4,178),(1043,4,179),(1044,4,180),(1045,4,181),(1046,4,182),(1047,4,183),(1048,4,184),(1049,4,185),(1050,4,186),(1051,4,187),(1052,4,188),(1053,4,189),(1054,4,190),(1055,4,191),(1056,4,192),(1057,4,193),(1058,4,194),(1059,4,195),(1060,4,196),(1061,4,197),(1062,4,198),(1063,4,199),(1064,4,200),(1065,4,201),(1066,4,202),(1067,4,203),(1068,4,204),(1069,4,205),(1070,4,206),(1071,4,207),(1072,4,208),(1073,4,209),(1074,4,210),(1075,4,211),(1076,4,212),(1077,4,213),(1078,4,214),(1079,4,215),(1080,4,216),(1081,4,217),(1082,4,218),(1083,4,219),(1084,4,220),(1085,4,221),(1086,4,222),(1087,4,223),(1088,4,224),(1089,4,225),(1090,4,226),(1091,4,227),(1092,4,228),(1093,4,229),(1094,4,230),(1095,4,231),(1096,4,232),(1097,4,233),(1098,4,234),(1099,4,235),(1100,4,236),(1101,4,237),(1102,4,238),(1103,4,239),(1104,4,240),(1105,4,241),(1106,4,242),(1107,4,243),(1108,4,244),(1109,4,245),(1110,4,246),(1111,4,247),(1112,4,248),(1113,4,249),(1114,4,250),(1115,4,251),(1116,4,252),(1117,4,253),(1118,4,254),(1119,4,255),(1120,4,256),(1121,4,257),(1122,4,258),(1123,4,259),(1124,4,260),(1125,4,261),(1126,4,262),(1127,4,263),(1128,4,264),(1129,4,265),(1130,4,266),(1131,4,267),(1132,4,268),(1133,4,269),(1134,4,270),(1135,4,271),(1136,4,342),(1137,4,343),(1138,5,1),(1139,5,2),(1140,5,3),(1141,5,272),(1142,5,273),(1143,5,289),(1144,5,290),(1145,5,291),(1146,5,292),(1147,5,293),(1148,5,294),(1149,5,295),(1150,5,296),(1151,5,344),(1152,5,345),(1153,5,346),(1154,5,347),(1155,5,348),(1156,5,349),(1157,5,350),(1158,5,351),(1159,5,20),(1160,5,26),(1161,5,351),(1162,5,326),(1163,5,327),(1164,5,328),(1165,5,339),(1166,5,33),(1167,5,34),(1168,5,35),(1169,5,36),(1170,5,37),(1171,5,38),(1172,5,39),(1173,5,40),(1174,5,41),(1175,5,42),(1176,5,43),(1177,5,44),(1178,5,45),(1179,5,46),(1180,5,47),(1181,5,48),(1182,5,49),(1183,5,50),(1184,5,51),(1185,5,52),(1186,5,53),(1187,5,54),(1188,5,55),(1189,5,56),(1190,5,57),(1191,5,58),(1192,5,59),(1193,5,60),(1194,5,61),(1195,5,62),(1196,5,63),(1197,5,64),(1198,5,65),(1199,5,66),(1200,5,67),(1201,5,68),(1202,5,69),(1203,5,70),(1204,5,71),(1205,5,72),(1206,5,73),(1207,5,74),(1208,5,75),(1209,5,76),(1210,5,77),(1211,5,78),(1212,5,79),(1213,5,80),(1214,5,81),(1215,5,82),(1216,5,83),(1217,5,84),(1218,5,85),(1219,5,86),(1220,5,87),(1221,5,88),(1222,5,89),(1223,5,90),(1224,5,91),(1225,5,92),(1226,5,93),(1227,5,94),(1228,5,95),(1229,5,96),(1230,5,97),(1231,5,98),(1232,5,99),(1233,5,100),(1234,5,101),(1235,5,102),(1236,5,103),(1237,5,104),(1238,5,105),(1239,5,106),(1240,5,107),(1241,5,108),(1242,5,109),(1243,5,110),(1244,5,111),(1245,5,112),(1246,5,113),(1247,5,114),(1248,5,115),(1249,5,116),(1250,5,117),(1251,5,118),(1252,5,119),(1253,5,120),(1254,5,121),(1255,5,122),(1256,5,123),(1257,5,124),(1258,5,125),(1259,5,126),(1260,5,127),(1261,5,128),(1262,5,129),(1263,5,130),(1264,5,131),(1265,5,132),(1266,5,133),(1267,5,134),(1268,5,135),(1269,5,136),(1270,5,137),(1271,5,138),(1272,5,139),(1273,5,140),(1274,5,141),(1275,5,142),(1276,5,143),(1277,5,144),(1278,5,145),(1279,5,146),(1280,5,147),(1281,5,148),(1282,5,149),(1283,5,150),(1284,5,151),(1285,5,152),(1286,5,153),(1287,5,154),(1288,5,155),(1289,5,156),(1290,5,157),(1291,5,158),(1292,5,159),(1293,5,160),(1294,5,161),(1295,5,162),(1296,5,163),(1297,5,164),(1298,5,165),(1299,5,166),(1300,5,167),(1301,5,168),(1302,5,169),(1303,5,170),(1304,5,171),(1305,5,172),(1306,5,173),(1307,5,174),(1308,5,175),(1309,5,176),(1310,5,177),(1311,5,178),(1312,5,179),(1313,5,180),(1314,5,181),(1315,5,182),(1316,5,183),(1317,5,184),(1318,5,185),(1319,5,186),(1320,5,187),(1321,5,188),(1322,5,189),(1323,5,190),(1324,5,191),(1325,5,192),(1326,5,193),(1327,5,194),(1328,5,195),(1329,5,196),(1330,5,197),(1331,5,198),(1332,5,199),(1333,5,200),(1334,5,201),(1335,5,202),(1336,5,203),(1337,5,204),(1338,5,205),(1339,5,206),(1340,5,207),(1341,5,208),(1342,5,209),(1343,5,210),(1344,5,211),(1345,5,212),(1346,5,213),(1347,5,214),(1348,5,215),(1349,5,216),(1350,5,217),(1351,5,218),(1352,5,219),(1353,5,220),(1354,5,221),(1355,5,222),(1356,5,223),(1357,5,224),(1358,5,225),(1359,5,226),(1360,5,227),(1361,5,228),(1362,5,229),(1363,5,230),(1364,5,231),(1365,5,232),(1366,5,233),(1367,5,234),(1368,5,235),(1369,5,236),(1370,5,237),(1371,5,238),(1372,5,239),(1373,5,240),(1374,5,241),(1375,5,242),(1376,5,243),(1377,5,244),(1378,5,245),(1379,5,246),(1380,5,247),(1381,5,248),(1382,5,249),(1383,5,250),(1384,5,251),(1385,5,252),(1386,5,253),(1387,5,254),(1388,5,255),(1389,5,256),(1390,5,257),(1391,5,258),(1392,5,259),(1393,5,260),(1394,5,261),(1395,5,262),(1396,5,263),(1397,5,264),(1398,5,265),(1399,5,266),(1400,5,267),(1401,5,268),(1402,5,269),(1403,5,270),(1404,5,271),(1405,1,1),(1406,1,2),(1407,1,3),(1408,1,272),(1409,1,273),(1410,1,352),(1411,1,353),(1412,1,274),(1413,1,354),(1414,1,355),(1415,1,356),(1416,1,357),(1417,1,358),(1418,1,359),(1419,1,360),(1420,1,361),(1421,1,26),(1422,1,363),(1423,1,364),(1424,1,365),(1425,1,366),(1426,1,367),(1427,1,368),(1428,1,297),(1429,1,333),(1430,1,33),(1431,1,34),(1432,1,35),(1433,1,36),(1434,1,37),(1435,1,38),(1436,1,39),(1437,1,40),(1438,1,41),(1439,1,42),(1440,1,43),(1441,1,44),(1442,1,45),(1443,1,46),(1444,1,47),(1445,1,48),(1446,1,49),(1447,1,50),(1448,1,51),(1449,1,52),(1450,1,53),(1451,1,54),(1452,1,55),(1453,1,56),(1454,1,57),(1455,1,58),(1456,1,59),(1457,1,60),(1458,1,61),(1459,1,62),(1460,1,63),(1461,1,64),(1462,1,65),(1463,1,66),(1464,1,67),(1465,1,68),(1466,1,69),(1467,1,70),(1468,1,71),(1469,1,72),(1470,1,73),(1471,1,74),(1472,1,75),(1473,1,76),(1474,1,77),(1475,1,78),(1476,1,79),(1477,1,80),(1478,1,81),(1479,1,82),(1480,1,83),(1481,1,84),(1482,1,85),(1483,1,86),(1484,1,87),(1485,1,88),(1486,1,89),(1487,1,90),(1488,1,91),(1489,1,92),(1490,1,93),(1491,1,94),(1492,1,95),(1493,1,96),(1494,1,97),(1495,1,98),(1496,1,99),(1497,1,100),(1498,1,101),(1499,1,102),(1500,1,103),(1501,1,104),(1502,1,105),(1503,1,106),(1504,1,107),(1505,1,108),(1506,1,109),(1507,1,110),(1508,1,111),(1509,1,112),(1510,1,113),(1511,1,114),(1512,1,115),(1513,1,116),(1514,1,117),(1515,1,118),(1516,1,119),(1517,1,120),(1518,1,121),(1519,1,122),(1520,1,123),(1521,1,124),(1522,1,125),(1523,1,126),(1524,1,127),(1525,1,128),(1526,1,129),(1527,1,130),(1528,1,131),(1529,1,132),(1530,1,133),(1531,1,134),(1532,1,135),(1533,1,136),(1534,1,137),(1535,1,138),(1536,1,139),(1537,1,140),(1538,1,141),(1539,1,142),(1540,1,143),(1541,1,144),(1542,1,145),(1543,1,146),(1544,1,147),(1545,1,148),(1546,1,149),(1547,1,150),(1548,1,151),(1549,1,152),(1550,1,153),(1551,1,154),(1552,1,155),(1553,1,156),(1554,1,157),(1555,1,158),(1556,1,159),(1557,1,160),(1558,1,161),(1559,1,162),(1560,1,163),(1561,1,164),(1562,1,165),(1563,1,166),(1564,1,167),(1565,1,168),(1566,1,169),(1567,1,170),(1568,1,171),(1569,1,172),(1570,1,173),(1571,1,174),(1572,1,175),(1573,1,176),(1574,1,177),(1575,1,178),(1576,1,179),(1577,1,180),(1578,1,181),(1579,1,182),(1580,1,183),(1581,1,184),(1582,1,185),(1583,1,186),(1584,1,187),(1585,1,188),(1586,1,189),(1587,1,190),(1588,1,191),(1589,1,192),(1590,1,193),(1591,1,194),(1592,1,195),(1593,1,196),(1594,1,197),(1595,1,198),(1596,1,199),(1597,1,200),(1598,1,201),(1599,1,202),(1600,1,203),(1601,1,204),(1602,1,205),(1603,1,206),(1604,1,207),(1605,1,208),(1606,1,209),(1607,1,210),(1608,1,211),(1609,1,212),(1610,1,213),(1611,1,214),(1612,1,215),(1613,1,216),(1614,1,217),(1615,1,218),(1616,1,219),(1617,1,220),(1618,1,221),(1619,1,222),(1620,1,223),(1621,1,224),(1622,1,225),(1623,1,226),(1624,1,227),(1625,1,228),(1626,1,229),(1627,1,230),(1628,1,231),(1629,1,232),(1630,1,233),(1631,1,234),(1632,1,235),(1633,1,236),(1634,1,237),(1635,1,238),(1636,1,239),(1637,1,240),(1638,1,241),(1639,1,242),(1640,1,243),(1641,1,244),(1642,1,245),(1643,1,246),(1644,1,247),(1645,1,248),(1646,1,249),(1647,1,250),(1648,1,251),(1649,1,252),(1650,1,253),(1651,1,254),(1652,1,255),(1653,1,256),(1654,1,257),(1655,1,258),(1656,1,259),(1657,1,260),(1658,1,261),(1659,1,262),(1660,1,263),(1661,1,264),(1662,1,265),(1663,1,266),(1664,1,267),(1665,1,268),(1666,1,269),(1667,1,270),(1668,1,271),(1669,6,1),(1670,6,2),(1671,6,3),(1672,6,272),(1673,6,273),(1674,6,369),(1675,6,370),(1676,6,371),(1677,6,30),(1678,6,372),(1679,6,373),(1680,6,374),(1681,6,375),(1682,6,376),(1683,6,377),(1684,6,378),(1685,6,379),(1686,6,380),(1687,6,381),(1688,6,382),(1689,6,383),(1690,6,384),(1691,6,385),(1692,6,386),(1693,6,387),(1694,6,388),(1695,6,389),(1696,6,390),(1697,6,391),(1698,6,297),(1699,6,320),(1700,6,332),(1701,6,333),(1702,6,33),(1703,6,34),(1704,6,35),(1705,6,36),(1706,6,37),(1707,6,38),(1708,6,39),(1709,6,40),(1710,6,41),(1711,6,42),(1712,6,43),(1713,6,44),(1714,6,45),(1715,6,46),(1716,6,47),(1717,6,48),(1718,6,49),(1719,6,50),(1720,6,51),(1721,6,52),(1722,6,53),(1723,6,54),(1724,6,55),(1725,6,56),(1726,6,57),(1727,6,58),(1728,6,59),(1729,6,60),(1730,6,61),(1731,6,62),(1732,6,63),(1733,6,64),(1734,6,65),(1735,6,66),(1736,6,67),(1737,6,68),(1738,6,69),(1739,6,70),(1740,6,71),(1741,6,72),(1742,6,73),(1743,6,74),(1744,6,75),(1745,6,76),(1746,6,77),(1747,6,78),(1748,6,79),(1749,6,80),(1750,6,81),(1751,6,82),(1752,6,83),(1753,6,84),(1754,6,85),(1755,6,86),(1756,6,87),(1757,6,88),(1758,6,89),(1759,6,90),(1760,6,91),(1761,6,92),(1762,6,93),(1763,6,94),(1764,6,95),(1765,6,96),(1766,6,97),(1767,6,98),(1768,6,99),(1769,6,100),(1770,6,101),(1771,6,102),(1772,6,103),(1773,6,104),(1774,6,105),(1775,6,106),(1776,6,107),(1777,6,108),(1778,6,109),(1779,6,110),(1780,6,111),(1781,6,112),(1782,6,113),(1783,6,114),(1784,6,115),(1785,6,116),(1786,6,117),(1787,6,118),(1788,6,119),(1789,6,120),(1790,6,121),(1791,6,122),(1792,6,123),(1793,6,124),(1794,6,125),(1795,6,126),(1796,6,127),(1797,6,128),(1798,6,129),(1799,6,130),(1800,6,131),(1801,6,132),(1802,6,133),(1803,6,134),(1804,6,135),(1805,6,136),(1806,6,137),(1807,6,138),(1808,6,139),(1809,6,140),(1810,6,141),(1811,6,142),(1812,6,143),(1813,6,144),(1814,6,145),(1815,6,146),(1816,6,147),(1817,6,148),(1818,6,149),(1819,6,150),(1820,6,151),(1821,6,152),(1822,6,153),(1823,6,154),(1824,6,155),(1825,6,156),(1826,6,157),(1827,6,158),(1828,6,159),(1829,6,160),(1830,6,161),(1831,6,162),(1832,6,163),(1833,6,164),(1834,6,165),(1835,6,166),(1836,6,167),(1837,6,168),(1838,6,169),(1839,6,170),(1840,6,171),(1841,6,172),(1842,6,173),(1843,6,174),(1844,6,175),(1845,6,176),(1846,6,177),(1847,6,178),(1848,6,179),(1849,6,180),(1850,6,181),(1851,6,182),(1852,6,183),(1853,6,184),(1854,6,185),(1855,6,186),(1856,6,187),(1857,6,188),(1858,6,189),(1859,6,190),(1860,6,191),(1861,6,192),(1862,6,193),(1863,6,194),(1864,6,195),(1865,6,196),(1866,6,197),(1867,6,198),(1868,6,199),(1869,6,200),(1870,6,201),(1871,6,202),(1872,6,203),(1873,6,204),(1874,6,205),(1875,6,206),(1876,6,207),(1877,6,208),(1878,6,209),(1879,6,210),(1880,6,211),(1881,6,212),(1882,6,213),(1883,6,214),(1884,6,215),(1885,6,216),(1886,6,217),(1887,6,218),(1888,6,219),(1889,6,220),(1890,6,221),(1891,6,222),(1892,6,223),(1893,6,224),(1894,6,225),(1895,6,226),(1896,6,227),(1897,6,228),(1898,6,229),(1899,6,230),(1900,6,231),(1901,6,232),(1902,6,233),(1903,6,234),(1904,6,235),(1905,6,236),(1906,6,237),(1907,6,238),(1908,6,239),(1909,6,240),(1910,6,241),(1911,6,242),(1912,6,243),(1913,6,244),(1914,6,245),(1915,6,246),(1916,6,247),(1917,6,248),(1918,6,249),(1919,6,250),(1920,6,251),(1921,6,252),(1922,6,253),(1923,6,254),(1924,6,255),(1925,6,256),(1926,6,257),(1927,6,258),(1928,6,259),(1929,6,260),(1930,6,261),(1931,6,262),(1932,6,263),(1933,6,264),(1934,6,265),(1935,6,266),(1936,6,267),(1937,6,268),(1938,6,269),(1939,6,270),(1940,6,271),(1941,7,1),(1942,7,2),(1943,7,3),(1944,7,272),(1945,7,273),(1946,7,392),(1947,7,393),(1948,7,394),(1949,7,395),(1950,7,396),(1951,7,397),(1952,7,398),(1953,7,399),(1954,7,400),(1955,7,401),(1956,7,401),(1957,7,14),(1958,7,402),(1959,7,329),(1960,7,330),(1961,7,331),(1962,7,33),(1963,7,34),(1964,7,35),(1965,7,36),(1966,7,37),(1967,7,38),(1968,7,39),(1969,7,40),(1970,7,41),(1971,7,42),(1972,7,43),(1973,7,44),(1974,7,45),(1975,7,46),(1976,7,47),(1977,7,48),(1978,7,49),(1979,7,50),(1980,7,51),(1981,7,52),(1982,7,53),(1983,7,54),(1984,7,55),(1985,7,56),(1986,7,57),(1987,7,58),(1988,7,59),(1989,7,60),(1990,7,61),(1991,7,62),(1992,7,63),(1993,7,64),(1994,7,65),(1995,7,66),(1996,7,67),(1997,7,68),(1998,7,69),(1999,7,70),(2000,7,71),(2001,7,72),(2002,7,73),(2003,7,74),(2004,7,75),(2005,7,76),(2006,7,77),(2007,7,78),(2008,7,79),(2009,7,80),(2010,7,81),(2011,7,82),(2012,7,83),(2013,7,84),(2014,7,85),(2015,7,86),(2016,7,87),(2017,7,88),(2018,7,89),(2019,7,90),(2020,7,91),(2021,7,92),(2022,7,93),(2023,7,94),(2024,7,95),(2025,7,96),(2026,7,97),(2027,7,98),(2028,7,99),(2029,7,100),(2030,7,101),(2031,7,102),(2032,7,103),(2033,7,104),(2034,7,105),(2035,7,106),(2036,7,107),(2037,7,108),(2038,7,109),(2039,7,110),(2040,7,111),(2041,7,112),(2042,7,113),(2043,7,114),(2044,7,115),(2045,7,116),(2046,7,117),(2047,7,118),(2048,7,119),(2049,7,120),(2050,7,121),(2051,7,122),(2052,7,123),(2053,7,124),(2054,7,125),(2055,7,126),(2056,7,127),(2057,7,128),(2058,7,129),(2059,7,130),(2060,7,131),(2061,7,132),(2062,7,133),(2063,7,134),(2064,7,135),(2065,7,136),(2066,7,137),(2067,7,138),(2068,7,139),(2069,7,140),(2070,7,141),(2071,7,142),(2072,7,143),(2073,7,144),(2074,7,145),(2075,7,146),(2076,7,147),(2077,7,148),(2078,7,149),(2079,7,150),(2080,7,151),(2081,7,152),(2082,7,153),(2083,7,154),(2084,7,155),(2085,7,156),(2086,7,157),(2087,7,158),(2088,7,159),(2089,7,160),(2090,7,161),(2091,7,162),(2092,7,163),(2093,7,164),(2094,7,165),(2095,7,166),(2096,7,167),(2097,7,168),(2098,7,169),(2099,7,170),(2100,7,171),(2101,7,172),(2102,7,173),(2103,7,174),(2104,7,175),(2105,7,176),(2106,7,177),(2107,7,178),(2108,7,179),(2109,7,180),(2110,7,181),(2111,7,182),(2112,7,183),(2113,7,184),(2114,7,185),(2115,7,186),(2116,7,187),(2117,7,188),(2118,7,189),(2119,7,190),(2120,7,191),(2121,7,192),(2122,7,193),(2123,7,194),(2124,7,195),(2125,7,196),(2126,7,197),(2127,7,198),(2128,7,199),(2129,7,200),(2130,7,201),(2131,7,202),(2132,7,203),(2133,7,204),(2134,7,205),(2135,7,206),(2136,7,207),(2137,7,208),(2138,7,209),(2139,7,210),(2140,7,211),(2141,7,212),(2142,7,213),(2143,7,214),(2144,7,215),(2145,7,216),(2146,7,217),(2147,7,218),(2148,7,219),(2149,7,220),(2150,7,221),(2151,7,222),(2152,7,223),(2153,7,224),(2154,7,225),(2155,7,226),(2156,7,227),(2157,7,228),(2158,7,229),(2159,7,230),(2160,7,231),(2161,7,232),(2162,7,233),(2163,7,234),(2164,7,235),(2165,7,236),(2166,7,237),(2167,7,238),(2168,7,239),(2169,7,240),(2170,7,241),(2171,7,242),(2172,7,243),(2173,7,244),(2174,7,245),(2175,7,246),(2176,7,247),(2177,7,248),(2178,7,249),(2179,7,250),(2180,7,251),(2181,7,252),(2182,7,253),(2183,7,254),(2184,7,255),(2185,7,256),(2186,7,257),(2187,7,258),(2188,7,259),(2189,7,260),(2190,7,261),(2191,7,262),(2192,7,263),(2193,7,264),(2194,7,265),(2195,7,266),(2196,7,267),(2197,7,268),(2198,7,269),(2199,7,270),(2200,7,271),(2201,8,1),(2202,8,2),(2203,8,3),(2204,8,272),(2205,8,273),(2206,8,403),(2207,8,404),(2208,8,405),(2209,8,30),(2210,8,406),(2211,8,407),(2212,8,408),(2213,8,409),(2214,8,410),(2215,8,411),(2216,8,412),(2217,8,413),(2218,8,414),(2219,8,415),(2220,8,416),(2221,8,417),(2222,8,300),(2223,8,33),(2224,8,34),(2225,8,35),(2226,8,36),(2227,8,37),(2228,8,38),(2229,8,39),(2230,8,40),(2231,8,41),(2232,8,42),(2233,8,43),(2234,8,44),(2235,8,45),(2236,8,46),(2237,8,47),(2238,8,48),(2239,8,49),(2240,8,50),(2241,8,51),(2242,8,52),(2243,8,53),(2244,8,54),(2245,8,55),(2246,8,56),(2247,8,57),(2248,8,58),(2249,8,59),(2250,8,60),(2251,8,61),(2252,8,62),(2253,8,63),(2254,8,64),(2255,8,65),(2256,8,66),(2257,8,67),(2258,8,68),(2259,8,69),(2260,8,70),(2261,8,71),(2262,8,72),(2263,8,73),(2264,8,74),(2265,8,75),(2266,8,76),(2267,8,77),(2268,8,78),(2269,8,79),(2270,8,80),(2271,8,81),(2272,8,82),(2273,8,83),(2274,8,84),(2275,8,85),(2276,8,86),(2277,8,87),(2278,8,88),(2279,8,89),(2280,8,90),(2281,8,91),(2282,8,92),(2283,8,93),(2284,8,94),(2285,8,95),(2286,8,96),(2287,8,97),(2288,8,98),(2289,8,99),(2290,8,100),(2291,8,101),(2292,8,102),(2293,8,103),(2294,8,104),(2295,8,105),(2296,8,106),(2297,8,107),(2298,8,108),(2299,8,109),(2300,8,110),(2301,8,111),(2302,8,112),(2303,8,113),(2304,8,114),(2305,8,115),(2306,8,116),(2307,8,117),(2308,8,118),(2309,8,119),(2310,8,120),(2311,8,121),(2312,8,122),(2313,8,123),(2314,8,124),(2315,8,125),(2316,8,126),(2317,8,127),(2318,8,128),(2319,8,129),(2320,8,130),(2321,8,131),(2322,8,132),(2323,8,133),(2324,8,134),(2325,8,135),(2326,8,136),(2327,8,137),(2328,8,138),(2329,8,139),(2330,8,140),(2331,8,141),(2332,8,142),(2333,8,143),(2334,8,144),(2335,8,145),(2336,8,146),(2337,8,147),(2338,8,148),(2339,8,149),(2340,8,150),(2341,8,151),(2342,8,152),(2343,8,153),(2344,8,154),(2345,8,155),(2346,8,156),(2347,8,157),(2348,8,158),(2349,8,159),(2350,8,160),(2351,8,161),(2352,8,162),(2353,8,163),(2354,8,164),(2355,8,165),(2356,8,166),(2357,8,167),(2358,8,168),(2359,8,169),(2360,8,170),(2361,8,171),(2362,8,172),(2363,8,173),(2364,8,174),(2365,8,175),(2366,8,176),(2367,8,177),(2368,8,178),(2369,8,179),(2370,8,180),(2371,8,181),(2372,8,182),(2373,8,183),(2374,8,184),(2375,8,185),(2376,8,186),(2377,8,187),(2378,8,188),(2379,8,189),(2380,8,190),(2381,8,191),(2382,8,192),(2383,8,193),(2384,8,194),(2385,8,195),(2386,8,196),(2387,8,197),(2388,8,198),(2389,8,199),(2390,8,200),(2391,8,201),(2392,8,202),(2393,8,203),(2394,8,204),(2395,8,205),(2396,8,206),(2397,8,207),(2398,8,208),(2399,8,209),(2400,8,210),(2401,8,211),(2402,8,212),(2403,8,213),(2404,8,214),(2405,8,215),(2406,8,216),(2407,8,217),(2408,8,218),(2409,8,219),(2410,8,220),(2411,8,221),(2412,8,222),(2413,8,223),(2414,8,224),(2415,8,225),(2416,8,226),(2417,8,227),(2418,8,228),(2419,8,229),(2420,8,230),(2421,8,231),(2422,8,232),(2423,8,233),(2424,8,234),(2425,8,235),(2426,8,236),(2427,8,237),(2428,8,238),(2429,8,239),(2430,8,240),(2431,8,241),(2432,8,242),(2433,8,243),(2434,8,244),(2435,8,245),(2436,8,246),(2437,8,247),(2438,8,248),(2439,8,249),(2440,8,250),(2441,8,251),(2442,8,252),(2443,8,253),(2444,8,254),(2445,8,255),(2446,8,256),(2447,8,257),(2448,8,258),(2449,8,259),(2450,8,260),(2451,8,261),(2452,8,262),(2453,8,263),(2454,8,264),(2455,8,265),(2456,8,266),(2457,8,267),(2458,8,268),(2459,8,269),(2460,8,270),(2461,8,271),(2462,9,1),(2463,9,2),(2464,9,3),(2465,9,272),(2466,9,273),(2467,9,403),(2468,9,404),(2469,9,405),(2470,9,418),(2471,9,419),(2472,9,422),(2473,9,423),(2474,9,424),(2475,9,425),(2476,9,426),(2477,9,427),(2478,9,428),(2479,9,342),(2480,9,429),(2481,9,430),(2482,9,33),(2483,9,34),(2484,9,35),(2485,9,36),(2486,9,37),(2487,9,38),(2488,9,39),(2489,9,40),(2490,9,41),(2491,9,42),(2492,9,43),(2493,9,44),(2494,9,45),(2495,9,46),(2496,9,47),(2497,9,48),(2498,9,49),(2499,9,50),(2500,9,51),(2501,9,52),(2502,9,53),(2503,9,54),(2504,9,55),(2505,9,56),(2506,9,57),(2507,9,58),(2508,9,59),(2509,9,60),(2510,9,61),(2511,9,62),(2512,9,63),(2513,9,64),(2514,9,65),(2515,9,66),(2516,9,67),(2517,9,68),(2518,9,69),(2519,9,70),(2520,9,71),(2521,9,72),(2522,9,73),(2523,9,74),(2524,9,75),(2525,9,76),(2526,9,77),(2527,9,78),(2528,9,79),(2529,9,80),(2530,9,81),(2531,9,82),(2532,9,83),(2533,9,84),(2534,9,85),(2535,9,86),(2536,9,87),(2537,9,88),(2538,9,89),(2539,9,90),(2540,9,91),(2541,9,92),(2542,9,93),(2543,9,94),(2544,9,95),(2545,9,96),(2546,9,97),(2547,9,98),(2548,9,99),(2549,9,100),(2550,9,101),(2551,9,102),(2552,9,103),(2553,9,104),(2554,9,105),(2555,9,106),(2556,9,107),(2557,9,108),(2558,9,109),(2559,9,110),(2560,9,111),(2561,9,112),(2562,9,113),(2563,9,114),(2564,9,115),(2565,9,116),(2566,9,117),(2567,9,118),(2568,9,119),(2569,9,120),(2570,9,121),(2571,9,122),(2572,9,123),(2573,9,124),(2574,9,125),(2575,9,126),(2576,9,127),(2577,9,128),(2578,9,129),(2579,9,130),(2580,9,131),(2581,9,132),(2582,9,133),(2583,9,134),(2584,9,135),(2585,9,136),(2586,9,137),(2587,9,138),(2588,9,139),(2589,9,140),(2590,9,141),(2591,9,142),(2592,9,143),(2593,9,144),(2594,9,145),(2595,9,146),(2596,9,147),(2597,9,148),(2598,9,149),(2599,9,150),(2600,9,151),(2601,9,152),(2602,9,153),(2603,9,154),(2604,9,155),(2605,9,156),(2606,9,157),(2607,9,158),(2608,9,159),(2609,9,160),(2610,9,161),(2611,9,162),(2612,9,163),(2613,9,164),(2614,9,165),(2615,9,166),(2616,9,167),(2617,9,168),(2618,9,169),(2619,9,170),(2620,9,171),(2621,9,172),(2622,9,173),(2623,9,174),(2624,9,175),(2625,9,176),(2626,9,177),(2627,9,178),(2628,9,179),(2629,9,180),(2630,9,181),(2631,9,182),(2632,9,183),(2633,9,184),(2634,9,185),(2635,9,186),(2636,9,187),(2637,9,188),(2638,9,189),(2639,9,190),(2640,9,191),(2641,9,192),(2642,9,193),(2643,9,194),(2644,9,195),(2645,9,196),(2646,9,197),(2647,9,198),(2648,9,199),(2649,9,200),(2650,9,201),(2651,9,202),(2652,9,203),(2653,9,204),(2654,9,205),(2655,9,206),(2656,9,207),(2657,9,208),(2658,9,209),(2659,9,210),(2660,9,211),(2661,9,212),(2662,9,213),(2663,9,214),(2664,9,215),(2665,9,216),(2666,9,217),(2667,9,218),(2668,9,219),(2669,9,220),(2670,9,221),(2671,9,222),(2672,9,223),(2673,9,224),(2674,9,225),(2675,9,226),(2676,9,227),(2677,9,228),(2678,9,229),(2679,9,230),(2680,9,231),(2681,9,232),(2682,9,233),(2683,9,234),(2684,9,235),(2685,9,236),(2686,9,237),(2687,9,238),(2688,9,239),(2689,9,240),(2690,9,241),(2691,9,242),(2692,9,243),(2693,9,244),(2694,9,245),(2695,9,246),(2696,9,247),(2697,9,248),(2698,9,249),(2699,9,250),(2700,9,251),(2701,9,252),(2702,9,253),(2703,9,254),(2704,9,255),(2705,9,256),(2706,9,257),(2707,9,258),(2708,9,259),(2709,9,260),(2710,9,261),(2711,9,262),(2712,9,263),(2713,9,264),(2714,9,265),(2715,9,266),(2716,9,267),(2717,9,268),(2718,9,269),(2719,9,270),(2720,9,271),(2772,10,1),(2773,10,2),(2774,10,3),(2775,10,272),(2776,10,273),(2777,10,432),(2778,10,437),(2779,10,438),(2780,10,439),(2781,10,440),(2782,10,430),(2783,10,441),(2784,10,297),(2785,10,301),(2786,10,336),(2787,10,337),(2788,10,33),(2789,10,35),(2790,10,244),(2791,10,245),(2792,10,246),(2793,10,247),(2794,10,248),(2795,10,249),(2796,10,250),(2797,10,251),(2798,10,252),(2799,10,253),(2800,10,254),(2801,10,255),(2802,10,256),(2803,10,257),(2804,10,258),(2805,10,259),(2806,10,260),(2807,10,261),(2808,10,262),(2809,10,263),(2810,10,264),(2811,10,265),(2812,10,266),(2813,10,267),(2814,10,268),(2815,10,269),(2816,10,270),(2817,10,271),(2819,10,219),(2820,10,220),(2821,10,221),(2822,10,222),(2825,10,225),(2826,10,226),(2827,10,227),(2828,10,228),(2834,10,234),(2835,10,235),(2836,10,236),(2837,10,237),(2843,10,243),(2844,11,1),(2845,11,2),(2846,11,3),(2847,11,272),(2848,11,273),(2849,11,432),(2850,11,437),(2851,11,438),(2852,11,439),(2853,11,443),(2854,11,444),(2855,11,445),(2856,11,446),(2857,11,447),(2858,11,448),(2859,11,449),(2860,11,450),(2861,11,451),(2862,11,452),(2863,11,453),(2864,11,454),(2865,11,455),(2866,11,456),(2867,11,457),(2868,11,458),(2869,11,459),(2870,11,442),(2871,11,297),(2872,11,301),(2873,11,313),(2874,11,336),(2875,11,337),(2876,11,33),(2877,11,35),(2878,11,243),(2879,11,237),(2880,11,236),(2881,11,235),(2882,11,234),(2883,11,228),(2884,11,227),(2885,11,226),(2886,11,225),(2887,11,222),(2888,11,221),(2889,11,220),(2890,11,219),(2891,11,244),(2892,11,245),(2893,11,246),(2894,11,247),(2895,11,248),(2896,11,249),(2897,11,250),(2898,11,251),(2899,11,252),(2900,11,253),(2901,11,254),(2902,11,255),(2903,11,256),(2904,11,257),(2905,11,258),(2906,11,259),(2907,11,260),(2908,11,261),(2909,11,262),(2910,11,263),(2911,11,264),(2912,11,265),(2913,11,266),(2914,11,267),(2915,11,268),(2916,11,269),(2917,11,270),(2918,11,271),(2919,12,1),(2920,12,2),(2921,12,3),(2922,12,272),(2923,12,273),(2924,12,439),(2925,12,460),(2926,12,461),(2927,12,462),(2928,12,30),(2929,12,463),(2930,12,464),(2931,12,465),(2932,12,466),(2933,12,467),(2934,12,468),(2935,12,469),(2936,12,470),(2937,12,471),(2938,12,472),(2939,12,473),(2940,12,474),(2941,12,475),(2942,12,476),(2943,12,477),(2944,12,299),(2945,12,322),(2946,12,313),(2947,12,478),(2948,12,479),(2949,12,33),(2950,12,34),(2951,12,35),(2952,12,36),(2953,12,37),(2954,12,38),(2955,12,39),(2956,12,40),(2957,12,41),(2958,12,42),(2959,12,43),(2960,12,44),(2961,12,45),(2962,12,46),(2963,12,47),(2964,12,48),(2965,12,49),(2966,12,50),(2967,12,51),(2968,12,52),(2969,12,53),(2970,12,54),(2971,12,55),(2972,12,56),(2973,12,57),(2974,12,58),(2975,12,59),(2976,12,60),(2977,12,61),(2978,12,62),(2979,12,63),(2980,12,64),(2981,12,65),(2982,12,66),(2983,12,67),(2984,12,68),(2985,12,69),(2986,12,70),(2987,12,71),(2988,12,72),(2989,12,73),(2990,12,74),(2991,12,75),(2992,12,76),(2993,12,77),(2994,12,78),(2995,12,79),(2996,12,80),(2997,12,81),(2998,12,82),(2999,12,83),(3000,12,84),(3001,12,85),(3002,12,86),(3003,12,87),(3004,12,88),(3005,12,89),(3006,12,90),(3007,12,91),(3008,12,92),(3009,12,93),(3010,12,94),(3011,12,95),(3012,12,96),(3013,12,97),(3014,12,98),(3015,12,99),(3016,12,100),(3017,12,101),(3018,12,102),(3019,12,103),(3020,12,104),(3021,12,105),(3022,12,106),(3023,12,107),(3024,12,108),(3025,12,109),(3026,12,110),(3027,12,111),(3028,12,112),(3029,12,113),(3030,12,114),(3031,12,115),(3032,12,116),(3033,12,117),(3034,12,118),(3035,12,119),(3036,12,120),(3037,12,121),(3038,12,122),(3039,12,123),(3040,12,124),(3041,12,125),(3042,12,126),(3043,12,127),(3044,12,128),(3045,12,129),(3046,12,130),(3047,12,131),(3048,12,132),(3049,12,133),(3050,12,134),(3051,12,135),(3052,12,136),(3053,12,137),(3054,12,138),(3055,12,139),(3056,12,140),(3057,12,141),(3058,12,142),(3059,12,143),(3060,12,144),(3061,12,145),(3062,12,146),(3063,12,147),(3064,12,148),(3065,12,149),(3066,12,150),(3067,12,151),(3068,12,152),(3069,12,153),(3070,12,154),(3071,12,155),(3072,12,156),(3073,12,157),(3074,12,158),(3075,12,159),(3076,12,160),(3077,12,161),(3078,12,162),(3079,12,163),(3080,12,164),(3081,12,165),(3082,12,166),(3083,12,167),(3084,12,168),(3085,12,169),(3086,12,170),(3087,12,171),(3088,12,172),(3089,12,173),(3090,12,174),(3091,12,175),(3092,12,176),(3093,12,177),(3094,12,178),(3095,12,179),(3096,12,180),(3097,12,181),(3098,12,182),(3099,12,183),(3100,12,184),(3101,12,185),(3102,12,186),(3103,12,187),(3104,12,188),(3105,12,189),(3106,12,190),(3107,12,191),(3108,12,192),(3109,12,193),(3110,12,194),(3111,12,195),(3112,12,196),(3113,12,197),(3114,12,198),(3115,12,199),(3116,12,200),(3117,12,201),(3118,12,202),(3119,12,203),(3120,12,204),(3121,12,205),(3122,12,206),(3123,12,207),(3124,12,208),(3125,12,209),(3126,12,210),(3127,12,211),(3128,12,212),(3129,12,213),(3130,12,214),(3131,12,215),(3132,12,216),(3133,12,217),(3134,12,243),(3135,12,242),(3136,12,241),(3137,12,240),(3138,12,239),(3139,12,238),(3140,12,237),(3141,12,236),(3142,12,235),(3143,12,234),(3144,12,233),(3145,12,232),(3146,12,231),(3147,12,230),(3148,12,229),(3149,12,228),(3150,12,227),(3151,12,226),(3152,12,225),(3153,12,224),(3154,12,223),(3155,12,222),(3156,12,221),(3157,12,220),(3158,12,219),(3159,12,218),(3160,12,244),(3161,12,245),(3162,12,246),(3163,12,247),(3164,12,248),(3165,12,249),(3166,12,250),(3167,12,251),(3168,12,252),(3169,12,253),(3170,12,254),(3171,12,255),(3172,12,256),(3173,12,257),(3174,12,258),(3175,12,259),(3176,12,260),(3177,12,261),(3178,12,262),(3179,12,263),(3180,12,264),(3181,12,265),(3182,12,266),(3183,12,267),(3184,12,268),(3185,12,269),(3186,12,270),(3187,12,271),(3261,13,1),(3262,13,2),(3263,13,3),(3264,13,272),(3265,13,273),(3266,13,439),(3267,13,461),(3268,13,462),(3269,13,480),(3270,13,453),(3271,13,481),(3272,13,451),(3273,13,450),(3274,13,457),(3275,13,454),(3276,13,482),(3277,13,446),(3278,13,483),(3279,13,13),(3280,13,40),(3281,13,464),(3282,13,485),(3283,13,486),(3284,13,299),(3289,13,33),(3290,13,34),(3291,13,35),(3292,13,36),(3293,13,37),(3294,13,38),(3295,13,39),(3296,13,40),(3297,13,41),(3298,13,42),(3299,13,43),(3300,13,44),(3301,13,45),(3302,13,46),(3303,13,47),(3304,13,48),(3305,13,49),(3306,13,50),(3307,13,51),(3308,13,52),(3309,13,53),(3310,13,54),(3311,13,55),(3312,13,56),(3313,13,57),(3314,13,58),(3315,13,59),(3316,13,60),(3317,13,61),(3318,13,62),(3319,13,63),(3320,13,64),(3321,13,65),(3322,13,66),(3323,13,67),(3324,13,68),(3325,13,69),(3326,13,70),(3327,13,71),(3328,13,72),(3329,13,73),(3330,13,74),(3331,13,75),(3332,13,76),(3333,13,77),(3334,13,78),(3335,13,79),(3336,13,80),(3337,13,81),(3338,13,82),(3339,13,83),(3340,13,84),(3341,13,85),(3342,13,86),(3343,13,87),(3344,13,88),(3345,13,89),(3346,13,90),(3347,13,91),(3348,13,92),(3349,13,93),(3350,13,94),(3351,13,95),(3352,13,96),(3353,13,97),(3354,13,98),(3355,13,99),(3356,13,100),(3357,13,101),(3358,13,102),(3359,13,103),(3360,13,104),(3361,13,105),(3362,13,106),(3363,13,107),(3364,13,108),(3365,13,109),(3366,13,110),(3367,13,111),(3368,13,112),(3369,13,113),(3370,13,114),(3371,13,115),(3372,13,116),(3373,13,117),(3374,13,118),(3375,13,119),(3376,13,120),(3377,13,121),(3378,13,122),(3379,13,123),(3380,13,124),(3381,13,125),(3382,13,126),(3383,13,127),(3384,13,128),(3385,13,129),(3386,13,130),(3387,13,131),(3388,13,132),(3389,13,133),(3390,13,134),(3391,13,135),(3392,13,136),(3393,13,137),(3394,13,138),(3395,13,139),(3396,13,140),(3397,13,141),(3398,13,142),(3399,13,143),(3400,13,144),(3401,13,145),(3402,13,146),(3403,13,147),(3404,13,148),(3405,13,149),(3406,13,150),(3407,13,151),(3408,13,152),(3409,13,153),(3410,13,154),(3411,13,155),(3412,13,156),(3413,13,157),(3414,13,158),(3415,13,159),(3416,13,160),(3417,13,161),(3418,13,162),(3419,13,163),(3420,13,164),(3421,13,165),(3422,13,166),(3423,13,167),(3424,13,168),(3425,13,169),(3426,13,170),(3427,13,171),(3428,13,172),(3429,13,173),(3430,13,174),(3431,13,175),(3432,13,176),(3433,13,177),(3434,13,178),(3435,13,179),(3436,13,180),(3437,13,181),(3438,13,182),(3439,13,183),(3440,13,184),(3441,13,185),(3442,13,186),(3443,13,187),(3444,13,188),(3445,13,189),(3446,13,190),(3447,13,191),(3448,13,192),(3449,13,193),(3450,13,194),(3451,13,195),(3452,13,196),(3453,13,197),(3454,13,198),(3455,13,199),(3456,13,200),(3457,13,201),(3458,13,202),(3459,13,203),(3460,13,204),(3461,13,205),(3462,13,206),(3463,13,207),(3464,13,208),(3465,13,209),(3466,13,210),(3467,13,211),(3468,13,212),(3469,13,213),(3470,13,214),(3471,13,215),(3472,13,216),(3473,13,217),(3474,13,243),(3475,13,237),(3476,13,236),(3477,13,235),(3478,13,234),(3479,13,228),(3480,13,227),(3481,13,226),(3482,13,225),(3483,13,222),(3484,13,221),(3485,13,220),(3486,13,219),(3487,13,244),(3488,13,245),(3489,13,246),(3490,13,247),(3491,13,248),(3492,13,249),(3493,13,250),(3494,13,251),(3495,13,252),(3496,13,253),(3497,13,254),(3498,13,255),(3499,13,256),(3500,13,257),(3501,13,258),(3502,13,259),(3503,13,260),(3504,13,261),(3505,13,262),(3506,13,263),(3507,13,264),(3508,13,265),(3509,13,266),(3510,13,267),(3511,13,268),(3512,13,269),(3513,13,270),(3514,13,271),(3515,14,1),(3516,14,2),(3517,14,3),(3518,14,272),(3519,14,273),(3520,14,487),(3521,14,488),(3522,14,489),(3523,14,490),(3524,14,458),(3525,14,491),(3526,14,492),(3527,14,493),(3528,14,494),(3529,14,324),(3530,14,243),(3531,14,242),(3532,14,241),(3533,14,240),(3534,14,239),(3535,14,238),(3536,14,237),(3537,14,236),(3538,14,235),(3539,14,234),(3540,14,233),(3541,14,232),(3542,14,231),(3543,14,230),(3544,14,229),(3545,14,228),(3546,14,227),(3547,14,226),(3548,14,225),(3549,14,224),(3550,14,223),(3551,14,222),(3552,14,221),(3553,14,220),(3554,14,219),(3555,14,218),(3556,14,33),(3557,14,34),(3558,14,35),(3559,14,36),(3560,14,37),(3561,14,38),(3562,14,39),(3563,14,40),(3564,14,41),(3565,14,42),(3566,14,43),(3567,14,44),(3568,14,45),(3569,14,46),(3570,14,47),(3571,14,48),(3572,14,49),(3573,14,50),(3574,14,51),(3575,14,52),(3576,14,53),(3577,14,54),(3578,14,55),(3579,14,56),(3580,14,57),(3581,14,58),(3582,14,59),(3583,14,60),(3584,14,61),(3585,14,62),(3586,14,63),(3587,14,64),(3588,14,65),(3589,14,66),(3590,14,67),(3591,14,68),(3592,14,69),(3593,14,70),(3594,14,71),(3595,14,72),(3596,14,73),(3597,14,74),(3598,14,75),(3599,14,76),(3600,14,77),(3601,14,78),(3602,14,79),(3603,14,80),(3604,14,81),(3605,14,82),(3606,14,83),(3607,14,84),(3608,14,85),(3609,14,86),(3610,14,87),(3611,14,88),(3612,14,89),(3613,14,90),(3614,14,91),(3615,14,92),(3616,14,93),(3617,14,94),(3618,14,95),(3619,14,96),(3620,14,97),(3621,14,98),(3622,14,99),(3623,14,100),(3624,14,101),(3625,14,102),(3626,14,103),(3627,14,104),(3628,14,105),(3629,14,106),(3630,14,107),(3631,14,108),(3632,14,109),(3633,14,110),(3634,14,111),(3635,14,112),(3636,14,113),(3637,14,114),(3638,14,115),(3639,14,116),(3640,14,117),(3641,14,118),(3642,14,119),(3643,14,120),(3644,14,121),(3645,14,122),(3646,14,123),(3647,14,124),(3648,14,125),(3649,14,126),(3650,14,127),(3651,14,128),(3652,14,129),(3653,14,130),(3654,14,131),(3655,14,132),(3656,14,133),(3657,14,134),(3658,14,135),(3659,14,136),(3660,14,137),(3661,14,138),(3662,14,139),(3663,14,140),(3664,14,141),(3665,14,142),(3666,14,143),(3667,14,144),(3668,14,145),(3669,14,146),(3670,14,147),(3671,14,148),(3672,14,149),(3673,14,150),(3674,14,151),(3675,14,152),(3676,14,153),(3677,14,154),(3678,14,155),(3679,14,156),(3680,14,157),(3681,14,158),(3682,14,159),(3683,14,160),(3684,14,161),(3685,14,162),(3686,14,163),(3687,14,164),(3688,14,165),(3689,14,166),(3690,14,167),(3691,14,168),(3692,14,169),(3693,14,170),(3694,14,171),(3695,14,172),(3696,14,173),(3697,14,174),(3698,14,175),(3699,14,176),(3700,14,177),(3701,14,178),(3702,14,179),(3703,14,180),(3704,14,181),(3705,14,182),(3706,14,183),(3707,14,184),(3708,14,185),(3709,14,186),(3710,14,187),(3711,14,188),(3712,14,189),(3713,14,190),(3714,14,191),(3715,14,192),(3716,14,193),(3717,14,194),(3718,14,195),(3719,14,196),(3720,14,197),(3721,14,198),(3722,14,199),(3723,14,200),(3724,14,201),(3725,14,202),(3726,14,203),(3727,14,204),(3728,14,205),(3729,14,206),(3730,14,207),(3731,14,208),(3732,14,209),(3733,14,210),(3734,14,211),(3735,14,212),(3736,14,213),(3737,14,214),(3738,14,215),(3739,14,216),(3740,14,217),(3741,14,244),(3742,14,245),(3743,14,246),(3744,14,247),(3745,14,248),(3746,14,249),(3747,14,250),(3748,14,251),(3749,14,252),(3750,14,253),(3751,14,254),(3752,14,255),(3753,14,256),(3754,14,257),(3755,14,258),(3756,14,259),(3757,14,260),(3758,14,261),(3759,14,262),(3760,14,263),(3761,14,264),(3762,14,265),(3763,14,266),(3764,14,267),(3765,14,268),(3766,14,269),(3767,14,270),(3768,14,271),(3769,15,1),(3770,15,2),(3771,15,3),(3772,15,272),(3773,15,273),(3774,15,462),(3775,15,495),(3776,15,496),(3778,15,18),(3779,15,20),(3780,15,348),(3781,15,497),(3782,15,299),(3783,15,334),(3784,15,335),(3785,15,243),(3786,15,237),(3787,15,236),(3788,15,235),(3789,15,234),(3790,15,228),(3791,15,227),(3792,15,226),(3793,15,225),(3794,15,222),(3795,15,221),(3796,15,220),(3797,15,219),(3798,15,33),(3799,15,35),(3800,15,244),(3801,15,245),(3802,15,246),(3803,15,247),(3804,15,248),(3805,15,249),(3806,15,250),(3807,15,251),(3808,15,252),(3809,15,253),(3810,15,254),(3811,15,255),(3812,15,256),(3813,15,257),(3814,15,258),(3815,15,259),(3816,15,260),(3817,15,261),(3818,15,262),(3819,15,263),(3820,15,264),(3821,15,265),(3822,15,266),(3823,15,267),(3824,15,268),(3825,15,269),(3826,15,270),(3827,15,271),(3828,16,1),(3829,16,2),(3830,16,3),(3831,16,272),(3832,16,273),(3833,16,432),(3834,16,461),(3835,16,498),(3836,16,462),(3837,16,501),(3838,16,500),(3839,16,446),(3840,16,499),(3841,16,502),(3842,16,457),(3843,16,450),(3844,16,451),(3845,16,482),(3846,16,13),(3847,16,503),(3848,16,504),(3849,16,299),(3850,16,243),(3851,16,242),(3852,16,241),(3853,16,240),(3854,16,239),(3855,16,238),(3856,16,237),(3857,16,236),(3858,16,235),(3859,16,234),(3860,16,233),(3861,16,232),(3862,16,231),(3863,16,230),(3864,16,229),(3865,16,228),(3866,16,227),(3867,16,226),(3868,16,225),(3869,16,224),(3870,16,223),(3871,16,222),(3872,16,221),(3873,16,220),(3874,16,219),(3875,16,218),(3876,16,33),(3877,16,35),(3878,16,36),(3879,16,37),(3880,16,38),(3881,16,39),(3882,16,40),(3883,16,41),(3884,16,42),(3885,16,43),(3886,16,44),(3887,16,45),(3888,16,46),(3889,16,47),(3890,16,48),(3891,16,49),(3892,16,50),(3893,16,51),(3894,16,52),(3895,16,53),(3896,16,54),(3897,16,55),(3898,16,56),(3899,16,57),(3900,16,58),(3901,16,59),(3902,16,60),(3903,16,61),(3904,16,62),(3905,16,63),(3906,16,64),(3907,16,65),(3908,16,66),(3909,16,67),(3910,16,68),(3911,16,69),(3912,16,70),(3913,16,71),(3914,16,72),(3915,16,73),(3916,16,74),(3917,16,75),(3918,16,76),(3919,16,77),(3920,16,78),(3921,16,79),(3922,16,80),(3923,16,81),(3924,16,82),(3925,16,83),(3926,16,84),(3927,16,85),(3928,16,86),(3929,16,87),(3930,16,88),(3931,16,89),(3932,16,90),(3933,16,91),(3934,16,92),(3935,16,93),(3936,16,94),(3937,16,95),(3938,16,96),(3939,16,97),(3940,16,98),(3941,16,99),(3942,16,100),(3943,16,101),(3944,16,102),(3945,16,103),(3946,16,104),(3947,16,105),(3948,16,106),(3949,16,107),(3950,16,108),(3951,16,109),(3952,16,110),(3953,16,111),(3954,16,112),(3955,16,113),(3956,16,114),(3957,16,115),(3958,16,116),(3959,16,117),(3960,16,118),(3961,16,119),(3962,16,120),(3963,16,121),(3964,16,122),(3965,16,123),(3966,16,124),(3967,16,125),(3968,16,126),(3969,16,127),(3970,16,128),(3971,16,129),(3972,16,130),(3973,16,131),(3974,16,132),(3975,16,133),(3976,16,134),(3977,16,135),(3978,16,136),(3979,16,137),(3980,16,138),(3981,16,139),(3982,16,140),(3983,16,141),(3984,16,142),(3985,16,143),(3986,16,144),(3987,16,145),(3988,16,146),(3989,16,147),(3990,16,148),(3991,16,149),(3992,16,150),(3993,16,151),(3994,16,152),(3995,16,153),(3996,16,154),(3997,16,155),(3998,16,156),(3999,16,157),(4000,16,158),(4001,16,159),(4002,16,160),(4003,16,161),(4004,16,162),(4005,16,163),(4006,16,164),(4007,16,165),(4008,16,166),(4009,16,167),(4010,16,168),(4011,16,169),(4012,16,170),(4013,16,171),(4014,16,172),(4015,16,173),(4016,16,174),(4017,16,175),(4018,16,176),(4019,16,177),(4020,16,178),(4021,16,179),(4022,16,180),(4023,16,181),(4024,16,182),(4025,16,183),(4026,16,184),(4027,16,185),(4028,16,186),(4029,16,187),(4030,16,188),(4031,16,189),(4032,16,190),(4033,16,191),(4034,16,192),(4035,16,193),(4036,16,194),(4037,16,195),(4038,16,196),(4039,16,197),(4040,16,198),(4041,16,199),(4042,16,200),(4043,16,201),(4044,16,202),(4045,16,203),(4046,16,204),(4047,16,205),(4048,16,206),(4049,16,207),(4050,16,208),(4051,16,209),(4052,16,210),(4053,16,211),(4054,16,212),(4055,16,213),(4056,16,214),(4057,16,215),(4058,16,216),(4059,16,217),(4060,16,244),(4061,16,245),(4062,16,246),(4063,16,247),(4064,16,248),(4065,16,249),(4066,16,250),(4067,16,251),(4068,16,252),(4069,16,253),(4070,16,254),(4071,16,255),(4072,16,256),(4073,16,257),(4074,16,258),(4075,16,259),(4076,16,260),(4077,16,261),(4078,16,262),(4079,16,263),(4080,16,264),(4081,16,265),(4082,16,266),(4083,16,267),(4084,16,268),(4085,16,269),(4086,16,270),(4087,16,271),(4088,17,1),(4089,17,2),(4090,17,3),(4091,17,272),(4092,17,273),(4093,17,432),(4094,17,505),(4095,17,506),(4096,17,507),(4097,17,508),(4098,17,509),(4099,17,510),(4100,17,511),(4101,17,512),(4102,17,513),(4103,17,514),(4104,17,515),(4105,17,516),(4106,17,517),(4107,17,518),(4108,17,519),(4109,17,520),(4110,17,521),(4111,17,522),(4112,17,523),(4113,17,524),(4114,17,500),(4115,17,446),(4116,17,457),(4117,17,454),(4118,17,450),(4119,17,528),(4120,17,529),(4121,17,530),(4122,17,531),(4123,17,532),(4124,17,533),(4125,17,534),(4126,17,535),(4127,17,536),(4128,17,537),(4129,17,538),(4130,17,539),(4131,17,540),(4132,17,541),(4133,17,527),(4134,17,317),(4135,17,300),(4136,17,220),(4137,17,219),(4138,17,244),(4139,17,245),(4140,17,246),(4141,17,247),(4142,17,248),(4143,17,249),(4144,17,250),(4145,17,251),(4146,17,252),(4147,17,253),(4148,17,254),(4149,17,255),(4150,17,256),(4151,17,257),(4152,17,258),(4153,17,259),(4154,17,260),(4155,17,261),(4156,17,262),(4157,17,263),(4158,17,264),(4159,17,265),(4160,17,266),(4161,17,267),(4162,17,268),(4163,17,269),(4164,17,270),(4165,17,271),(4166,18,1),(4167,18,2),(4168,18,3),(4169,18,272),(4170,18,273),(4171,18,432),(4172,18,461),(4173,18,498),(4174,18,462),(4175,18,349),(4176,18,450),(4177,18,483),(4178,18,13),(4193,18,542),(4194,18,543),(4195,18,299),(4196,18,300),(4197,18,243),(4198,18,242),(4199,18,241),(4200,18,240),(4201,18,239),(4202,18,238),(4203,18,237),(4204,18,236),(4205,18,235),(4206,18,234),(4207,18,233),(4208,18,232),(4209,18,231),(4210,18,230),(4211,18,229),(4212,18,228),(4213,18,227),(4214,18,226),(4215,18,225),(4216,18,224),(4217,18,223),(4218,18,222),(4219,18,221),(4220,18,220),(4221,18,219),(4222,18,218),(4223,18,33),(4224,18,35),(4225,18,244),(4226,18,245),(4227,18,246),(4228,18,247),(4229,18,248),(4230,18,249),(4231,18,250),(4232,18,251),(4233,18,252),(4234,18,253),(4235,18,254),(4236,18,255),(4237,18,256),(4238,18,257),(4239,18,258),(4240,18,259),(4241,18,260),(4242,18,261),(4243,18,262),(4244,18,263),(4245,18,264),(4246,18,265),(4247,18,266),(4248,18,267),(4249,18,268),(4250,18,269),(4251,18,270),(4252,18,271),(4253,18,301),(4254,19,273),(4255,19,544),(4256,19,545),(4257,19,546),(4258,19,547),(4259,19,548),(4260,19,549),(4261,19,550),(4262,19,551),(4263,19,552),(4264,19,425),(4265,19,30),(4266,19,553),(4267,19,297),(4268,19,313),(4269,19,226),(4270,19,224),(4271,19,223),(4272,19,219),(4273,19,218),(4274,19,33),(4275,19,35),(4276,19,36),(4277,19,37),(4278,19,38),(4279,19,39),(4280,19,40),(4281,19,41),(4282,19,42),(4283,19,43),(4284,19,44),(4285,19,45),(4286,19,46),(4287,19,47),(4288,19,48),(4289,19,49),(4290,19,50),(4291,19,51),(4292,19,52),(4293,19,53),(4294,19,54),(4295,19,55),(4296,19,56),(4297,19,57),(4298,19,58),(4299,19,59),(4300,19,60),(4301,19,61),(4302,19,62),(4303,19,63),(4304,19,64),(4305,19,65),(4306,19,66),(4307,19,67),(4308,19,68),(4309,19,69),(4310,19,70),(4311,19,71),(4312,19,72),(4313,19,73),(4314,19,74),(4315,19,75),(4316,19,76),(4317,19,77),(4318,19,78),(4319,19,79),(4320,19,80),(4321,19,81),(4322,19,82),(4323,19,83),(4324,19,84),(4325,19,85),(4326,19,86),(4327,19,87),(4328,19,88),(4329,19,89),(4330,19,90),(4331,19,91),(4332,19,92),(4333,19,93),(4334,19,94),(4335,19,95),(4336,19,96),(4337,19,97),(4338,19,98),(4339,19,99),(4340,19,100),(4341,19,101),(4342,19,102),(4343,19,103),(4344,19,104),(4345,19,105),(4346,19,106),(4347,19,107),(4348,19,108),(4349,19,109),(4350,19,110),(4351,19,111),(4352,19,112),(4353,19,113),(4354,19,114),(4355,19,115),(4356,19,116),(4357,19,117),(4358,19,118),(4359,19,119),(4360,19,120),(4361,19,121),(4362,19,122),(4363,19,123),(4364,19,124),(4365,19,125),(4366,19,126),(4367,19,127),(4368,19,128),(4369,19,129),(4370,19,130),(4371,19,131),(4372,19,132),(4373,19,133),(4374,19,134),(4375,19,135),(4376,19,136),(4377,19,137),(4378,19,138),(4379,19,139),(4380,19,140),(4381,19,141),(4382,19,142),(4383,19,143),(4384,19,144),(4385,19,145),(4386,19,146),(4387,19,147),(4388,19,148),(4389,19,149),(4390,19,150),(4391,19,151),(4392,19,152),(4393,19,153),(4394,19,154),(4395,19,155),(4396,19,156),(4397,19,157),(4398,19,158),(4399,19,159),(4400,19,160),(4401,19,161),(4402,19,162),(4403,19,163),(4404,19,164),(4405,19,165),(4406,19,166),(4407,19,167),(4408,19,168),(4409,19,169),(4410,19,170),(4411,19,171),(4412,19,172),(4413,19,173),(4414,19,174),(4415,19,175),(4416,19,176),(4417,19,177),(4418,19,178),(4419,19,179),(4420,19,180),(4421,19,181),(4422,19,182),(4423,19,183),(4424,19,184),(4425,19,185),(4426,19,186),(4427,19,187),(4428,19,188),(4429,19,189),(4430,19,190),(4431,19,191),(4432,19,192),(4433,19,193),(4434,19,194),(4435,19,195),(4436,19,196),(4437,19,197),(4438,19,198),(4439,19,199),(4440,19,200),(4441,19,201),(4442,19,202),(4443,19,203),(4444,19,204),(4445,19,205),(4446,19,206),(4447,19,207),(4448,19,208),(4449,19,209),(4450,19,210),(4451,19,211),(4452,19,212),(4453,19,213),(4454,19,214),(4455,19,215),(4456,19,216),(4457,19,217),(4458,19,244),(4459,19,245),(4460,19,246),(4461,19,247),(4462,19,248),(4463,19,249),(4464,19,250),(4465,19,251),(4466,19,252),(4467,19,253),(4468,19,254),(4469,19,255),(4470,19,256),(4471,19,257),(4472,19,258),(4473,19,259),(4474,19,260),(4475,19,261),(4476,19,262),(4477,19,263),(4478,19,264),(4479,19,265),(4480,19,266),(4481,19,267),(4482,19,268),(4483,19,269),(4484,19,270),(4485,19,271),(4486,20,273),(4487,20,30),(4488,20,555),(4489,20,556),(4490,20,557),(4491,20,558),(4492,20,559),(4493,20,570),(4494,20,571),(4495,20,572),(4496,20,573),(4497,20,574),(4498,20,575),(4499,20,226),(4500,20,224),(4501,20,223),(4502,20,219),(4503,20,218),(4504,20,567),(4505,20,568),(4506,20,569),(4507,20,33),(4508,20,35),(4509,20,36),(4510,20,37),(4511,20,38),(4512,20,39),(4513,20,40),(4514,20,41),(4515,20,42),(4516,20,43),(4517,20,44),(4518,20,45),(4519,20,46),(4520,20,47),(4521,20,48),(4522,20,49),(4523,20,50),(4524,20,51),(4525,20,52),(4526,20,53),(4527,20,54),(4528,20,55),(4529,20,56),(4530,20,57),(4531,20,58),(4532,20,59),(4533,20,60),(4534,20,61),(4535,20,62),(4536,20,63),(4537,20,64),(4538,20,65),(4539,20,66),(4540,20,67),(4541,20,68),(4542,20,69),(4543,20,70),(4544,20,71),(4545,20,72),(4546,20,73),(4547,20,74),(4548,20,75),(4549,20,76),(4550,20,77),(4551,20,78),(4552,20,79),(4553,20,80),(4554,20,81),(4555,20,82),(4556,20,83),(4557,20,84),(4558,20,85),(4559,20,86),(4560,20,87),(4561,20,88),(4562,20,89),(4563,20,90),(4564,20,91),(4565,20,92),(4566,20,93),(4567,20,94),(4568,20,95),(4569,20,96),(4570,20,97),(4571,20,98),(4572,20,99),(4573,20,100),(4574,20,101),(4575,20,102),(4576,20,103),(4577,20,104),(4578,20,105),(4579,20,106),(4580,20,107),(4581,20,108),(4582,20,109),(4583,20,110),(4584,20,111),(4585,20,112),(4586,20,113),(4587,20,114),(4588,20,115),(4589,20,116),(4590,20,117),(4591,20,118),(4592,20,119),(4593,20,120),(4594,20,121),(4595,20,122),(4596,20,123),(4597,20,124),(4598,20,125),(4599,20,126),(4600,20,127),(4601,20,128),(4602,20,129),(4603,20,130),(4604,20,131),(4605,20,132),(4606,20,133),(4607,20,134),(4608,20,135),(4609,20,136),(4610,20,137),(4611,20,138),(4612,20,139),(4613,20,140),(4614,20,141),(4615,20,142),(4616,20,143),(4617,20,144),(4618,20,145),(4619,20,146),(4620,20,147),(4621,20,148),(4622,20,149),(4623,20,150),(4624,20,151),(4625,20,152),(4626,20,153),(4627,20,154),(4628,20,155),(4629,20,156),(4630,20,157),(4631,20,158),(4632,20,159),(4633,20,160),(4634,20,161),(4635,20,162),(4636,20,163),(4637,20,164),(4638,20,165),(4639,20,166),(4640,20,167),(4641,20,168),(4642,20,169),(4643,20,170),(4644,20,171),(4645,20,172),(4646,20,173),(4647,20,174),(4648,20,175),(4649,20,176),(4650,20,177),(4651,20,178),(4652,20,179),(4653,20,180),(4654,20,181),(4655,20,182),(4656,20,183),(4657,20,184),(4658,20,185),(4659,20,186),(4660,20,187),(4661,20,188),(4662,20,189),(4663,20,190),(4664,20,191),(4665,20,192),(4666,20,193),(4667,20,194),(4668,20,195),(4669,20,196),(4670,20,197),(4671,20,198),(4672,20,199),(4673,20,200),(4674,20,201),(4675,20,202),(4676,20,203),(4677,20,204),(4678,20,205),(4679,20,206),(4680,20,207),(4681,20,208),(4682,20,209),(4683,20,210),(4684,20,211),(4685,20,212),(4686,20,213),(4687,20,214),(4688,20,215),(4689,20,216),(4690,20,217),(4691,20,244),(4692,20,245),(4693,20,246),(4694,20,247),(4695,20,248),(4696,20,249),(4697,20,250),(4698,20,251),(4699,20,252),(4700,20,253),(4701,20,254),(4702,20,255),(4703,20,256),(4704,20,257),(4705,20,258),(4706,20,259),(4707,20,260),(4708,20,261),(4709,20,262),(4710,20,263),(4711,20,264),(4712,20,265),(4713,20,266),(4714,20,267),(4715,20,268),(4716,20,269),(4717,20,270),(4718,20,271),(4719,21,273),(4720,21,585),(4721,21,586),(4722,21,587),(4723,21,588),(4724,21,589),(4725,21,590),(4726,21,591),(4727,21,592),(4728,21,593),(4729,21,570),(4730,21,573),(4731,21,576),(4732,21,577),(4733,21,226),(4734,21,224),(4735,21,223),(4736,21,219),(4737,21,218),(4738,21,33),(4739,21,35),(4740,21,36),(4741,21,37),(4742,21,38),(4743,21,39),(4744,21,40),(4745,21,41),(4746,21,42),(4747,21,43),(4748,21,44),(4749,21,45),(4750,21,46),(4751,21,47),(4752,21,48),(4753,21,49),(4754,21,50),(4755,21,51),(4756,21,52),(4757,21,53),(4758,21,54),(4759,21,55),(4760,21,56),(4761,21,57),(4762,21,58),(4763,21,59),(4764,21,60),(4765,21,61),(4766,21,62),(4767,21,63),(4768,21,64),(4769,21,65),(4770,21,66),(4771,21,67),(4772,21,68),(4773,21,69),(4774,21,70),(4775,21,71),(4776,21,72),(4777,21,73),(4778,21,74),(4779,21,75),(4780,21,76),(4781,21,77),(4782,21,78),(4783,21,79),(4784,21,80),(4785,21,81),(4786,21,82),(4787,21,83),(4788,21,84),(4789,21,85),(4790,21,86),(4791,21,87),(4792,21,88),(4793,21,89),(4794,21,90),(4795,21,91),(4796,21,92),(4797,21,93),(4798,21,94),(4799,21,95),(4800,21,96),(4801,21,97),(4802,21,98),(4803,21,99),(4804,21,100),(4805,21,101),(4806,21,102),(4807,21,103),(4808,21,104),(4809,21,105),(4810,21,106),(4811,21,107),(4812,21,108),(4813,21,109),(4814,21,110),(4815,21,111),(4816,21,112),(4817,21,113),(4818,21,114),(4819,21,115),(4820,21,116),(4821,21,117),(4822,21,118),(4823,21,119),(4824,21,120),(4825,21,121),(4826,21,122),(4827,21,123),(4828,21,124),(4829,21,125),(4830,21,126),(4831,21,127),(4832,21,128),(4833,21,129),(4834,21,130),(4835,21,131),(4836,21,132),(4837,21,133),(4838,21,134),(4839,21,135),(4840,21,136),(4841,21,137),(4842,21,138),(4843,21,139),(4844,21,140),(4845,21,141),(4846,21,142),(4847,21,143),(4848,21,144),(4849,21,145),(4850,21,146),(4851,21,147),(4852,21,148),(4853,21,149),(4854,21,150),(4855,21,151),(4856,21,152),(4857,21,153),(4858,21,154),(4859,21,155),(4860,21,156),(4861,21,157),(4862,21,158),(4863,21,159),(4864,21,160),(4865,21,161),(4866,21,162),(4867,21,163),(4868,21,164),(4869,21,165),(4870,21,166),(4871,21,167),(4872,21,168),(4873,21,169),(4874,21,170),(4875,21,171),(4876,21,172),(4877,21,173),(4878,21,174),(4879,21,175),(4880,21,176),(4881,21,177),(4882,21,178),(4883,21,179),(4884,21,180),(4885,21,181),(4886,21,182),(4887,21,183),(4888,21,184),(4889,21,185),(4890,21,186),(4891,21,187),(4892,21,188),(4893,21,189),(4894,21,190),(4895,21,191),(4896,21,192),(4897,21,193),(4898,21,194),(4899,21,195),(4900,21,196),(4901,21,197),(4902,21,198),(4903,21,199),(4904,21,200),(4905,21,201),(4906,21,202),(4907,21,203),(4908,21,204),(4909,21,205),(4910,21,206),(4911,21,207),(4912,21,208),(4913,21,209),(4914,21,210),(4915,21,211),(4916,21,212),(4917,21,213),(4918,21,214),(4919,21,215),(4920,21,216),(4921,21,217),(4922,21,244),(4923,21,245),(4924,21,246),(4925,21,247),(4926,21,248),(4927,21,249),(4928,21,250),(4929,21,251),(4930,21,252),(4931,21,253),(4932,21,254),(4933,21,255),(4934,21,256),(4935,21,257),(4936,21,258),(4937,21,259),(4938,21,260),(4939,21,261),(4940,21,262),(4941,21,263),(4942,21,264),(4943,21,265),(4944,21,266),(4945,21,267),(4946,21,268),(4947,21,269),(4948,21,270),(4949,21,271),(4950,22,273),(4951,22,594),(4952,22,595),(4953,22,596),(4954,22,597),(4955,22,588),(4956,22,598),(4957,22,599),(4958,22,600),(4959,22,601),(4960,22,322),(4961,22,226),(4962,22,224),(4963,22,223),(4964,22,219),(4965,22,218),(4966,22,33),(4967,22,35),(4968,22,36),(4969,22,37),(4970,22,38),(4971,22,39),(4972,22,40),(4973,22,41),(4974,22,42),(4975,22,43),(4976,22,44),(4977,22,45),(4978,22,46),(4979,22,47),(4980,22,48),(4981,22,49),(4982,22,50),(4983,22,51),(4984,22,52),(4985,22,53),(4986,22,54),(4987,22,55),(4988,22,56),(4989,22,57),(4990,22,58),(4991,22,59),(4992,22,60),(4993,22,61),(4994,22,62),(4995,22,63),(4996,22,64),(4997,22,65),(4998,22,66),(4999,22,67),(5000,22,68),(5001,22,69),(5002,22,70),(5003,22,71),(5004,22,72),(5005,22,73),(5006,22,74),(5007,22,75),(5008,22,76),(5009,22,77),(5010,22,78),(5011,22,79),(5012,22,80),(5013,22,81),(5014,22,82),(5015,22,83),(5016,22,84),(5017,22,85),(5018,22,86),(5019,22,87),(5020,22,88),(5021,22,89),(5022,22,90),(5023,22,91),(5024,22,92),(5025,22,93),(5026,22,94),(5027,22,95),(5028,22,96),(5029,22,97),(5030,22,98),(5031,22,99),(5032,22,100),(5033,22,101),(5034,22,102),(5035,22,103),(5036,22,104),(5037,22,105),(5038,22,106),(5039,22,107),(5040,22,108),(5041,22,109),(5042,22,110),(5043,22,111),(5044,22,112),(5045,22,113),(5046,22,114),(5047,22,115),(5048,22,116),(5049,22,117),(5050,22,118),(5051,22,119),(5052,22,120),(5053,22,121),(5054,22,122),(5055,22,123),(5056,22,124),(5057,22,125),(5058,22,126),(5059,22,127),(5060,22,128),(5061,22,129),(5062,22,130),(5063,22,131),(5064,22,132),(5065,22,133),(5066,22,134),(5067,22,135),(5068,22,136),(5069,22,137),(5070,22,138),(5071,22,139),(5072,22,140),(5073,22,141),(5074,22,142),(5075,22,143),(5076,22,144),(5077,22,145),(5078,22,146),(5079,22,147),(5080,22,148),(5081,22,149),(5082,22,150),(5083,22,151),(5084,22,152),(5085,22,153),(5086,22,154),(5087,22,155),(5088,22,156),(5089,22,157),(5090,22,158),(5091,22,159),(5092,22,160),(5093,22,161),(5094,22,162),(5095,22,163),(5096,22,164),(5097,22,165),(5098,22,166),(5099,22,167),(5100,22,168),(5101,22,169),(5102,22,170),(5103,22,171),(5104,22,172),(5105,22,173),(5106,22,174),(5107,22,175),(5108,22,176),(5109,22,177),(5110,22,178),(5111,22,179),(5112,22,180),(5113,22,181),(5114,22,182),(5115,22,183),(5116,22,184),(5117,22,185),(5118,22,186),(5119,22,187),(5120,22,188),(5121,22,189),(5122,22,190),(5123,22,191),(5124,22,192),(5125,22,193),(5126,22,194),(5127,22,195),(5128,22,196),(5129,22,197),(5130,22,198),(5131,22,199),(5132,22,200),(5133,22,201),(5134,22,202),(5135,22,203),(5136,22,204),(5137,22,205),(5138,22,206),(5139,22,207),(5140,22,208),(5141,22,209),(5142,22,210),(5143,22,211),(5144,22,212),(5145,22,213),(5146,22,214),(5147,22,215),(5148,22,216),(5149,22,217),(5150,22,244),(5151,22,245),(5152,22,246),(5153,22,247),(5154,22,248),(5155,22,249),(5156,22,250),(5157,22,251),(5158,22,252),(5159,22,253),(5160,22,254),(5161,22,255),(5162,22,256),(5163,22,257),(5164,22,258),(5165,22,259),(5166,22,260),(5167,22,261),(5168,22,262),(5169,22,263),(5170,22,264),(5171,22,265),(5172,22,266),(5173,22,267),(5174,22,268),(5175,22,269),(5176,22,270),(5177,22,271),(5178,23,1),(5179,23,2),(5180,23,3),(5181,23,272),(5182,23,602),(5183,23,603),(5184,23,604),(5185,23,606),(5186,23,605),(5187,23,462),(5188,23,607),(5189,23,608),(5190,23,30),(5191,23,609),(5192,23,610),(5193,23,314),(5194,23,325),(5195,23,338),(5196,23,226),(5197,23,224),(5198,23,223),(5199,23,219),(5200,23,218),(5201,23,36),(5202,23,37),(5203,23,217),(5204,23,244),(5205,23,245),(5206,23,246),(5207,23,247),(5208,23,248),(5209,23,249),(5210,23,250),(5211,23,251),(5212,23,252),(5213,23,253),(5214,23,254),(5215,23,255),(5216,23,256),(5217,23,257),(5218,23,258),(5219,23,259),(5220,23,260),(5221,23,261),(5222,23,262),(5223,23,263),(5224,23,264),(5225,23,265),(5226,23,266),(5227,23,267),(5228,23,268),(5229,23,269),(5230,23,270),(5231,23,271),(5232,24,273),(5233,24,611),(5234,24,612),(5235,24,613),(5236,24,614),(5237,24,615),(5238,24,616),(5239,24,617),(5240,24,618),(5241,24,619),(5242,24,620),(5243,24,621),(5244,24,622),(5245,24,623),(5246,24,624),(5247,24,625),(5248,24,626),(5249,24,627),(5250,24,628),(5251,24,629),(5252,24,630),(5253,24,631),(5254,24,632),(5255,24,633),(5256,24,585),(5257,24,634),(5258,24,338),(5259,24,226),(5260,24,224),(5261,24,223),(5262,24,219),(5263,24,218),(5264,24,36),(5265,24,37),(5266,24,217),(5267,24,244),(5268,24,245),(5269,24,246),(5270,24,247),(5271,24,248),(5272,24,249),(5273,24,250),(5274,24,251),(5275,24,252),(5276,24,253),(5277,24,254),(5278,24,255),(5279,24,256),(5280,24,257),(5281,24,258),(5282,24,259),(5283,24,260),(5284,24,261),(5285,24,262),(5286,24,263),(5287,24,264),(5288,24,265),(5289,24,266),(5290,24,267),(5291,24,268),(5292,24,269),(5293,24,270),(5294,24,271),(5295,25,273),(5296,25,637),(5297,25,638),(5298,25,639),(5299,25,640),(5300,25,641),(5301,25,642),(5302,25,643),(5303,25,644),(5304,25,645),(5305,25,646),(5306,25,647),(5307,25,648),(5308,25,649),(5309,25,650),(5310,25,651),(5311,25,652),(5312,25,653),(5313,25,654),(5314,25,655),(5315,25,658),(5316,25,659),(5317,25,660),(5318,25,322),(5319,25,338),(5320,25,226),(5321,25,218),(5322,25,36),(5323,25,37),(5324,25,217),(5325,25,244),(5326,25,245),(5327,25,246),(5328,25,247),(5329,25,248),(5330,25,249),(5331,25,250),(5332,25,251),(5333,25,252),(5334,25,253),(5335,25,254),(5336,25,255),(5337,25,256),(5338,25,257),(5339,25,258),(5340,25,259),(5341,25,260),(5342,25,261),(5343,25,262),(5344,25,263),(5345,25,264),(5346,25,265),(5347,25,266),(5348,25,267),(5349,25,268),(5350,25,269),(5351,25,270),(5352,25,271),(5353,26,273),(5354,26,462),(5355,26,661),(5356,26,30),(5357,26,662),(5358,26,663),(5359,26,320),(5360,26,243),(5361,26,242),(5362,26,241),(5363,26,240),(5364,26,239),(5365,26,238),(5366,26,237),(5367,26,236),(5368,26,235),(5369,26,234),(5370,26,233),(5371,26,232),(5372,26,231),(5373,26,230),(5374,26,229),(5375,26,228),(5376,26,227),(5377,26,226),(5378,26,225),(5379,26,224),(5380,26,223),(5381,26,222),(5382,26,221),(5383,26,220),(5384,26,219),(5385,26,218),(5386,26,33),(5387,26,35),(5388,26,36),(5389,26,37),(5390,26,38),(5391,26,39),(5392,26,40),(5393,26,41),(5394,26,42),(5395,26,43),(5396,26,44),(5397,26,45),(5398,26,46),(5399,26,47),(5400,26,48),(5401,26,49),(5402,26,50),(5403,26,51),(5404,26,52),(5405,26,53),(5406,26,54),(5407,26,55),(5408,26,56),(5409,26,57),(5410,26,58),(5411,26,59),(5412,26,60),(5413,26,61),(5414,26,62),(5415,26,63),(5416,26,64),(5417,26,65),(5418,26,66),(5419,26,67),(5420,26,68),(5421,26,69),(5422,26,70),(5423,26,71),(5424,26,72),(5425,26,73),(5426,26,74),(5427,26,75),(5428,26,76),(5429,26,77),(5430,26,78),(5431,26,79),(5432,26,80),(5433,26,81),(5434,26,82),(5435,26,83),(5436,26,84),(5437,26,85),(5438,26,86),(5439,26,87),(5440,26,88),(5441,26,89),(5442,26,90),(5443,26,91),(5444,26,92),(5445,26,93),(5446,26,94),(5447,26,95),(5448,26,96),(5449,26,97),(5450,26,98),(5451,26,99),(5452,26,100),(5453,26,101),(5454,26,102),(5455,26,103),(5456,26,104),(5457,26,105),(5458,26,106),(5459,26,107),(5460,26,108),(5461,26,109),(5462,26,110),(5463,26,111),(5464,26,112),(5465,26,113),(5466,26,114),(5467,26,115),(5468,26,116),(5469,26,117),(5470,26,118),(5471,26,119),(5472,26,120),(5473,26,121),(5474,26,122),(5475,26,123),(5476,26,124),(5477,26,125),(5478,26,126),(5479,26,127),(5480,26,128),(5481,26,129),(5482,26,130),(5483,26,131),(5484,26,132),(5485,26,133),(5486,26,134),(5487,26,135),(5488,26,136),(5489,26,137),(5490,26,138),(5491,26,139),(5492,26,140),(5493,26,141),(5494,26,142),(5495,26,143),(5496,26,144),(5497,26,145),(5498,26,146),(5499,26,147),(5500,26,148),(5501,26,149),(5502,26,150),(5503,26,151),(5504,26,152),(5505,26,153),(5506,26,154),(5507,26,155),(5508,26,156),(5509,26,157),(5510,26,158),(5511,26,159),(5512,26,160),(5513,26,161),(5514,26,162),(5515,26,163),(5516,26,164),(5517,26,165),(5518,26,166),(5519,26,167),(5520,26,168),(5521,26,169),(5522,26,170),(5523,26,171),(5524,26,172),(5525,26,173),(5526,26,174),(5527,26,175),(5528,26,176),(5529,26,177),(5530,26,178),(5531,26,179),(5532,26,180),(5533,26,181),(5534,26,182),(5535,26,183),(5536,26,184),(5537,26,185),(5538,26,186),(5539,26,187),(5540,26,188),(5541,26,189),(5542,26,190),(5543,26,191),(5544,26,192),(5545,26,193),(5546,26,194),(5547,26,195),(5548,26,196),(5549,26,197),(5550,26,198),(5551,26,199),(5552,26,200),(5553,26,201),(5554,26,202),(5555,26,203),(5556,26,204),(5557,26,205),(5558,26,206),(5559,26,207),(5560,26,208),(5561,26,209),(5562,26,210),(5563,26,211),(5564,26,212),(5565,26,213),(5566,26,214),(5567,26,215),(5568,26,216),(5569,26,217),(5570,26,244),(5571,26,245),(5572,26,246),(5573,26,247),(5574,26,248),(5575,26,249),(5576,26,250),(5577,26,251),(5578,26,252),(5579,26,253),(5580,26,254),(5581,26,255),(5582,26,256),(5583,26,257),(5584,26,258),(5585,26,259),(5586,26,260),(5587,26,261),(5588,26,262),(5589,26,263),(5590,26,264),(5591,26,265),(5592,26,266),(5593,26,267),(5594,26,268),(5595,26,269),(5596,26,270),(5597,26,271);

#
# Structure for table "hzg_purchase"
#

DROP TABLE IF EXISTS `hzg_purchase`;
CREATE TABLE `hzg_purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '采购单号',
  `name` varchar(60) DEFAULT NULL COMMENT '采购标题',
  `userId` int(11) NOT NULL DEFAULT '0' COMMENT '采购人ID',
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '采购类型，0:正常采购,1:临时采购,2:应急采购,3:现金采购,4:押金采购',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '采购单状态，0:申请,1:完成,2:作废',
  `amount` float(10,2) DEFAULT NULL COMMENT '采购金额',
  `date` datetime DEFAULT NULL COMMENT '采购时间',
  `inputDate` datetime DEFAULT NULL COMMENT '采购单录入时间',
  `inputerId` int(11) NOT NULL DEFAULT '0' COMMENT '采购单录入人id',
  `describes` varchar(256) DEFAULT NULL COMMENT '采购描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 COMMENT='采购单';

#
# Structure for table "hzg_purchase_book"
#

DROP TABLE IF EXISTS `hzg_purchase_book`;
CREATE TABLE `hzg_purchase_book` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `deposit` varchar(32) DEFAULT NULL COMMENT '订金',
  `payDate` datetime DEFAULT NULL COMMENT '预付订金时间',
  `state` int(1) DEFAULT NULL COMMENT '状态，0：未支付，1：支付完成，2:取消',
  `purchaseId` int(11) DEFAULT NULL COMMENT '采购单id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='临时采购预订单';

#
# Structure for table "hzg_purchase_detail"
#

DROP TABLE IF EXISTS `hzg_purchase_detail`;
CREATE TABLE `hzg_purchase_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseId` int(11) DEFAULT NULL COMMENT '采购单id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编号',
  `productName` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `amount` varchar(32) DEFAULT NULL COMMENT '单类商品采购金额,，加密价格后的字符串',
  `quantity` float(8,2) DEFAULT NULL COMMENT '采购数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '单位,如：件、只、双、条、枚、副、克、克拉',
  `price` varchar(32) DEFAULT NULL COMMENT '采购单价，加密价格后的字符串',
  `supplierId` int(11) DEFAULT NULL COMMENT '供应商id',
  PRIMARY KEY (`Id`),
  KEY `purchaseId` (`purchaseId`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8 COMMENT='采购明细表';

#
# Structure for table "hzg_purchase_detail_product"
#

DROP TABLE IF EXISTS `hzg_purchase_detail_product`;
CREATE TABLE `hzg_purchase_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseDetailId` int(11) DEFAULT NULL COMMENT '采购单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '关联商品id',
  PRIMARY KEY (`Id`),
  KEY `purchaseDetailId` (`purchaseDetailId`)
) ENGINE=InnoDB AUTO_INCREMENT=1140 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购明细表';

#
# Structure for table "hzg_purchase_pricechange"
#

DROP TABLE IF EXISTS `hzg_purchase_pricechange`;
CREATE TABLE `hzg_purchase_pricechange` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseId` int(11) DEFAULT NULL COMMENT '采购单id',
  `oldPrice` float(8,2) DEFAULT NULL COMMENT '原采购价',
  `newPrice` float(8,2) DEFAULT NULL COMMENT '现采购价',
  `applyerId` int(11) DEFAULT NULL COMMENT '采购价变动申请人id',
  `applyDate` datetime DEFAULT NULL COMMENT '申请时间',
  `status` int(1) DEFAULT NULL COMMENT '状态，0：有效状态，1：作废状态',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='成本价变动';

#
# Structure for table "hzg_purchase_returnproduct"
#

DROP TABLE IF EXISTS `hzg_purchase_returnproduct`;
CREATE TABLE `hzg_purchase_returnproduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseDetailId` int(11) DEFAULT NULL COMMENT '采购明细id',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '采购退货单状态，0:申请，1:已退',
  `refundAmount` float(8,2) DEFAULT NULL COMMENT '退货金额',
  `reason` varchar(60) NOT NULL COMMENT '退货原因',
  `applyDate` date NOT NULL COMMENT '申请时间',
  `applyUserId` int(11) NOT NULL COMMENT '申请人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购退货单';

#
# Structure for table "hzg_repairproduct"
#

DROP TABLE IF EXISTS `hzg_repairproduct`;
CREATE TABLE `hzg_repairproduct` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '修补货品单号',
  `entity` varchar(32) DEFAULT NULL COMMENT '业务类型实体：order：定单，purchase：采购等',
  `entityId` int(11) DEFAULT NULL COMMENT '业务类型实体id：订单id，采购id等',
  `entityNo` varchar(32) DEFAULT NULL COMMENT '业务实体编号',
  `amount` varchar(32) DEFAULT NULL COMMENT '修补货品所需金额',
  `describes` varchar(60) DEFAULT NULL COMMENT '修补货品描述',
  `userId` int(11) DEFAULT NULL COMMENT '修补人id',
  `state` int(2) DEFAULT NULL COMMENT '状态，0:申请，1:已付款，2:取消，3:销售确认可修补，31:销售确认不可修补，4：销售总监确认可修补，41：销售总监确认不可修补，5：仓储确认可修补，51：仓储确认不可修补,6:修补完成',
  `date` datetime DEFAULT NULL COMMENT '修补时间',
  `inputDate` datetime DEFAULT NULL COMMENT '修补申请时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='修补货品表';

#
# Structure for table "hzg_repairproduct_detail"
#

DROP TABLE IF EXISTS `hzg_repairproduct_detail`;
CREATE TABLE `hzg_repairproduct_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `repairProductId` int(11) DEFAULT NULL COMMENT '修补单id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品no',
  `price` varchar(32) DEFAULT NULL COMMENT '修补单价，加密价格后的字符串',
  `quantity` float(8,2) DEFAULT NULL COMMENT '修补数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '修补单位,如：件、只、双、条、枚、副、克、克拉',
  `amount` varchar(32) DEFAULT NULL COMMENT '修补金额',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:未修补，1:已修补，2:不能修补',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='修补货品明细表';

#
# Structure for table "hzg_repairproduct_detail_product"
#

DROP TABLE IF EXISTS `hzg_repairproduct_detail_product`;
CREATE TABLE `hzg_repairproduct_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `repairProductDetailId` int(11) DEFAULT NULL COMMENT '修补单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='修补货品明细对应商品表';

#
# Structure for table "hzg_returnproduct"
#

DROP TABLE IF EXISTS `hzg_returnproduct`;
CREATE TABLE `hzg_returnproduct` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '退货单号',
  `entity` varchar(32) DEFAULT NULL COMMENT '业务类型实体：order：定单，purchase：采购等',
  `entityId` int(11) DEFAULT NULL COMMENT '业务类型实体id：订单id，采购id等',
  `entityNo` varchar(32) DEFAULT NULL COMMENT '业务实体编号',
  `amount` varchar(32) DEFAULT NULL COMMENT '退款金额',
  `reason` varchar(60) DEFAULT NULL COMMENT '退货原因',
  `userId` int(11) DEFAULT NULL COMMENT '退货人id',
  `state` int(2) DEFAULT NULL COMMENT '状态，0:申请，1:已退款，2:取消，3:销售确认可退，31:销售确认不可退，4：销售总监确认可退，41：销售总监确认不可退，5：仓储确认可退，51：仓储确认不可退，6：采购退货申请，61：采购退货已退款，63：采购退货取消，7：采购确认退货，8：仓储确认已邮寄货物，9：供应商确认收货',
  `date` datetime DEFAULT NULL COMMENT '退货时间',
  `inputDate` datetime DEFAULT NULL COMMENT '退货申请时间',
  `type` int(1) DEFAULT NULL COMMENT '退货类型，0:正常退货，1:换货退货',
  `fee` varchar(32) DEFAULT NULL COMMENT '退货费',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='退货表';

#
# Structure for table "hzg_returnproduct_detail"
#

DROP TABLE IF EXISTS `hzg_returnproduct_detail`;
CREATE TABLE `hzg_returnproduct_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `returnProductId` int(11) DEFAULT NULL COMMENT '退货单id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品no',
  `price` varchar(32) DEFAULT NULL COMMENT '退货单价，加密价格后的字符串',
  `quantity` float(8,2) DEFAULT NULL COMMENT '退货数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '退货单位,如：件、只、双、条、枚、副、克、克拉',
  `amount` varchar(32) DEFAULT NULL COMMENT '退款金额',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:未退货，1:已退货，2:不能退货',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='退货明细表';

#
# Structure for table "hzg_returnproduct_detail_product"
#

DROP TABLE IF EXISTS `hzg_returnproduct_detail_product`;
CREATE TABLE `hzg_returnproduct_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `returnProductDetailId` int(11) DEFAULT NULL COMMENT '退货单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='退货明细对应商品表';

#
# Structure for table "hzg_stock"
#

DROP TABLE IF EXISTS `hzg_stock`;
CREATE TABLE `hzg_stock` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '库存编号',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编码',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量，数量为0表示库存中已没有此商品',
  `unit` varchar(6) DEFAULT NULL COMMENT '单位,如：件、只、双、条、枚、副、克、克拉',
  `state` int(1) DEFAULT NULL COMMENT '状态，0：有效，1：无效',
  `warehouseId` int(11) DEFAULT NULL COMMENT '所在仓库id',
  `describes` varchar(60) DEFAULT NULL COMMENT '备注',
  `date` datetime DEFAULT NULL COMMENT '最近一次入库时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COMMENT='商品库存信息表';

#
# Structure for table "hzg_stock_changewarehouse"
#

DROP TABLE IF EXISTS `hzg_stock_changewarehouse`;
CREATE TABLE `hzg_stock_changewarehouse` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `targetWarehouseId` int(11) DEFAULT NULL COMMENT '调仓目的仓库',
  `state` int(1) DEFAULT NULL COMMENT '0:调仓未完成，1：调仓完成',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='调仓出库';

#
# Structure for table "hzg_stock_deposit"
#

DROP TABLE IF EXISTS `hzg_stock_deposit`;
CREATE TABLE `hzg_stock_deposit` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` float(8,2) DEFAULT NULL COMMENT '押金金额',
  `returnGoodsDate` datetime DEFAULT NULL COMMENT '预计退还货物时间',
  `returnDepositDate` datetime DEFAULT NULL COMMENT '预计退还押金时间',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:未退，1:已退',
  `purchaseId` int(11) DEFAULT NULL COMMENT '押金采购单id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='押金入库单';

#
# Structure for table "hzg_stock_inout"
#

DROP TABLE IF EXISTS `hzg_stock_inout`;
CREATE TABLE `hzg_stock_inout` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '入库单号',
  `type` int(2) DEFAULT NULL COMMENT '类型：0:现金入库，1:代销入库，2:增量入库，3:加工入库，4:押金入库，5:修补入库，6:调仓入库，7:退货入库, 10：虚拟出库，11:系统自动出库，12:报损出库，13:调仓出库,14:内购出库,15:正常出库',
  `describes` varchar(60) DEFAULT NULL COMMENT '备注',
  `date` datetime DEFAULT NULL COMMENT '入库\\出库时间',
  `inputerId` int(11) DEFAULT NULL COMMENT '录入人id',
  `inputDate` datetime DEFAULT NULL COMMENT '录入时间',
  `state` int(1) DEFAULT NULL COMMENT '状态，0：申请，1:完成，2:作废',
  `depositId` int(11) DEFAULT NULL COMMENT '押金入库id',
  `processRepairId` int(11) DEFAULT NULL COMMENT '修补入库id',
  `changeWarehouseId` int(11) DEFAULT NULL COMMENT '调仓出库id',
  `warehouseId` int(11) DEFAULT NULL COMMENT '入库仓库id，出库仓库id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8 COMMENT='入库、出库单';

#
# Structure for table "hzg_stock_inout_detail"
#

DROP TABLE IF EXISTS `hzg_stock_inout_detail`;
CREATE TABLE `hzg_stock_inout_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `state` int(1) DEFAULT NULL COMMENT '状态，0：申请，1:完成',
  `stockInOutId` int(11) DEFAULT NULL COMMENT '入库/出库id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编号',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量',
  `unit` varchar(6) DEFAULT NULL COMMENT '单位,如：件、只、双、条、枚、副、克、克拉',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 COMMENT='入库出库明细';

#
# Structure for table "hzg_stock_inout_detail_product"
#

DROP TABLE IF EXISTS `hzg_stock_inout_detail_product`;
CREATE TABLE `hzg_stock_inout_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `stockInOutDetailId` int(11) DEFAULT NULL COMMENT '入库出库单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '关联商品id',
  PRIMARY KEY (`Id`),
  KEY `stockInOutDetailId` (`stockInOutDetailId`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购明细表';

#
# Structure for table "hzg_stock_processrepair"
#

DROP TABLE IF EXISTS `hzg_stock_processrepair`;
CREATE TABLE `hzg_stock_processrepair` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(2) DEFAULT NULL COMMENT '类型：0:自己加工，1:第三方加工，10:修补',
  `expense` float(8,2) DEFAULT NULL COMMENT '实际加工费、修补费',
  `date` datetime DEFAULT NULL COMMENT '加工时间、修补时间',
  `saleExpense` float(8,2) DEFAULT NULL COMMENT '销售时标注的加工费',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='加工入库、修补入库单';

#
# Structure for table "hzg_stock_warehouse"
#

DROP TABLE IF EXISTS `hzg_stock_warehouse`;
CREATE TABLE `hzg_stock_warehouse` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '仓库编号',
  `name` varchar(30) DEFAULT NULL COMMENT '仓库名称',
  `address` varchar(60) DEFAULT NULL COMMENT '地址',
  `chargerId` int(11) DEFAULT NULL COMMENT '库管人id',
  `companyId` int(11) DEFAULT NULL COMMENT '所属公司',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='仓库';

#
# Structure for table "hzg_suggest"
#

DROP TABLE IF EXISTS `hzg_suggest`;
CREATE TABLE `hzg_suggest` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '投诉建议ID',
  `cateId` int(3) unsigned DEFAULT NULL COMMENT '投诉建议分类ID',
  `content` text COMMENT '投诉/建议内容',
  `userNic` int(11) unsigned DEFAULT NULL COMMENT '用户称呼',
  `userEmail` varchar(30) DEFAULT NULL COMMENT '用户邮箱',
  `userTel` varchar(30) DEFAULT NULL COMMENT '用户联系方式',
  `state` int(1) unsigned DEFAULT NULL COMMENT '状态（回访/未回访）',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉建议表';

#
# Structure for table "hzg_suggest_cate"
#

DROP TABLE IF EXISTS `hzg_suggest_cate`;
CREATE TABLE `hzg_suggest_cate` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '投诉建议分类ID',
  `f_id` int(10) unsigned DEFAULT NULL COMMENT '父分类',
  `cateName` varchar(20) DEFAULT NULL COMMENT '投诉建议分类名称',
  `state` int(1) unsigned DEFAULT NULL COMMENT '状态（正常/禁用）',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉建议分类表';

#
# Structure for table "hzg_supplier"
#

DROP TABLE IF EXISTS `hzg_supplier`;
CREATE TABLE `hzg_supplier` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '供货商、加工商名称',
  `mainProductTypeId` int(11) NOT NULL DEFAULT '0' COMMENT '主要供货种类ID',
  `level` varchar(10) DEFAULT NULL COMMENT '供应商、加工商等级，A:A级  90－100分  请保持.B:B级  80－ 89分  正常抽样，请努力.C:C级  70－ 79分  加严抽样，请改善.D:D级  70分以下  列入考察',
  `charger` varchar(20) NOT NULL DEFAULT '' COMMENT '负责人姓名',
  `address` varchar(60) NOT NULL DEFAULT '' COMMENT '供应商、加工商地址',
  `phone` varchar(16) NOT NULL DEFAULT '' COMMENT '供应商、加工商电话',
  `cooperateDate` datetime DEFAULT NULL COMMENT '合作日期',
  `account` varchar(25) NOT NULL COMMENT '付款账号',
  `branch` varchar(30) NOT NULL DEFAULT '' COMMENT '账号开户行',
  `bank` varchar(30) NOT NULL DEFAULT '' COMMENT '账号所属银行，如：中国招商银行',
  `payTypes` varchar(30) NOT NULL DEFAULT '' COMMENT '结款方式，如：0：现金，1：转账，2：支付宝，3：微信，4：银联，5：支票，6：其他等',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '状态，0:在用，1:注销',
  `inputerId` int(11) NOT NULL DEFAULT '0' COMMENT '录入人ID',
  `inputDate` datetime DEFAULT NULL COMMENT '录入时间',
  `types` varchar(20) NOT NULL DEFAULT '' COMMENT '0：供货商，1：加工商',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='供货商、加工商';

#
# Structure for table "hzg_supplierproducttype_relation"
#

DROP TABLE IF EXISTS `hzg_supplierproducttype_relation`;
CREATE TABLE `hzg_supplierproducttype_relation` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `supplierId` int(11) DEFAULT NULL COMMENT '供货商id',
  `typeId` int(11) DEFAULT NULL COMMENT '商品种类id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供货商商品种类关联表';

#
# Structure for table "hzg_sys_audit"
#

DROP TABLE IF EXISTS `hzg_sys_audit`;
CREATE TABLE `hzg_sys_audit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '审核编号',
  `name` varchar(64) DEFAULT NULL COMMENT '事宜名称',
  `content` varchar(256) DEFAULT NULL COMMENT '内容，通知等',
  `userId` int(11) DEFAULT NULL COMMENT '办理人id',
  `postId` int(11) DEFAULT NULL COMMENT '办理节点岗位 id：财务专员，财务总监，销售总监，仓储，总经理等。对应 hzg_sys_post 岗位表的id',
  `result` varchar(1) DEFAULT NULL COMMENT '办理结果，Y：通过，N：不通过，L：锁定',
  `dealDate` datetime DEFAULT NULL COMMENT '办理时间',
  `inputDate` datetime DEFAULT NULL COMMENT '流转到该节点时间',
  `remark` varchar(256) DEFAULT NULL COMMENT '办理批语',
  `entity` varchar(32) DEFAULT NULL COMMENT '业务类型实体：product：商品，returnProduct：退货，changeProduct：换货，order：定单，purchase：采购等',
  `entityId` int(11) DEFAULT NULL COMMENT '业务类型实体id：退货单id，换货单id，订单id，采购id等',
  `entityNo` varchar(32) DEFAULT NULL COMMENT '业务实体编号',
  `state` int(1) DEFAULT NULL COMMENT '状态，0：待办，1：已办',
  `refusePostId` int(11) DEFAULT NULL COMMENT '办理驳回节点岗位 id，办理通过则该字段为空',
  `refuseUserId` int(11) DEFAULT NULL COMMENT '办理驳回节点用户id',
  `companyId` int(11) DEFAULT NULL COMMENT '所属公司',
  `action` varchar(32) DEFAULT NULL COMMENT '审核通过，调用的动作',
  `refusedAction` varchar(32) DEFAULT NULL COMMENT '被打回时调用的动作',
  `preFlowAuditNo` varchar(16) DEFAULT NULL COMMENT '前一个流程里事宜的编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8 COMMENT='办理记录表';

#
# Structure for table "hzg_sys_audit_flow"
#

DROP TABLE IF EXISTS `hzg_sys_audit_flow`;
CREATE TABLE `hzg_sys_audit_flow` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT '流程名称',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  `state` int(1) DEFAULT NULL COMMENT '状态：0：在用，1：没在用',
  `entity` varchar(32) DEFAULT NULL COMMENT '业务类型实体：product：商品，returnProduct：退货，changeProduct：换货，order：定单，purchase：采购等',
  `companyId` int(11) DEFAULT NULL COMMENT '所属公司',
  `action` varchar(32) DEFAULT NULL COMMENT '流程结束后调用动作',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

#
# Data for table "hzg_sys_audit_flow"
#

INSERT INTO `hzg_sys_audit_flow` (`Id`,`name`,`inputDate`,`state`,`entity`,`companyId`,`action`) VALUES (16,'商品采购','2017-06-30 13:19:22',0,'purchase',11,'stockInNotify'),(20,'应急/押金/现金采购','2017-07-03 13:26:35',0,'purchaseEmergency',11,'stockInNotifyCaiwu'),(21,'押金入库退还货品提醒流程','2017-07-12 16:26:30',0,'stockInDepositCangchu',11,NULL),(22,'押金入库退还押金提醒流程','2017-07-12 16:28:51',0,'stockInDepositCaiwu',11,NULL),(27,'商品上架','2017-07-31 13:36:14',0,'product',11,NULL),(29,'提示入库商品','2017-08-03 15:37:35',0,'stockInNotify',11,NULL),(30,'财务提示入库商品','2017-08-22 10:53:43',0,'stockInNotifyCaiwu',11,NULL),(31,'销售员调价申请','2017-08-30 17:17:27',0,'priceChangeSaler',11,NULL),(33,'报损出库','2017-10-24 14:01:39',0,'stockOutBreakage',11,NULL),(34,'提醒打印快递单','2017-11-10 11:32:12',0,'printExpressWaybillNotify',11,NULL),(35,'销售主管调价申请','2018-04-14 09:29:32',0,'priceChangeCharger',11,NULL),(36,'销售经理调价申请','2018-04-14 09:35:37',0,'priceChangeManager',11,NULL),(37,'销售总监调价申请','2018-04-14 09:37:12',0,'priceChangeDirector',11,NULL),(39,'提示审核凭证','2018-04-14 15:18:59',0,'voucherAuditNotify',11,NULL);

#
# Structure for table "hzg_sys_audit_flow_node"
#

DROP TABLE IF EXISTS `hzg_sys_audit_flow_node`;
CREATE TABLE `hzg_sys_audit_flow_node` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '流程名称',
  `postId` int(11) DEFAULT NULL COMMENT '当前办理节点岗位id',
  `nextPostId` int(11) DEFAULT NULL COMMENT '下一办理节点岗位id',
  `auditFlowId` int(11) DEFAULT NULL COMMENT '流程id',
  `action` varchar(32) DEFAULT NULL COMMENT '审核通过，调用的动作',
  `refusedAction` varchar(32) DEFAULT NULL COMMENT '被打回时调用的动作',
  PRIMARY KEY (`Id`),
  KEY `postId` (`postId`),
  KEY `nextPostId` (`nextPostId`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='办理流程节点';

#
# Data for table "hzg_sys_audit_flow_node"
#

INSERT INTO `hzg_sys_audit_flow_node` (`Id`,`name`,`postId`,`nextPostId`,`auditFlowId`,`action`,`refusedAction`) VALUES (24,'录入采购单',25,26,16,NULL,'purchaseModify'),(25,'总经理审核采购单',26,22,16,'purchaseAuditProductPass',NULL),(26,'仓储复核采购单商品信息',22,NULL,16,'purchaseClose',NULL),(34,'采购员录入采购单',25,26,20,NULL,NULL),(35,'总经理审核采购单',26,21,20,'purchaseEmergencyPass',NULL),(36,'财务审核付款',21,NULL,20,'purchasePayPass',NULL),(37,'仓储入库',27,25,21,NULL,NULL),(38,'采购退货货物',25,NULL,21,NULL,NULL),(39,'仓储入库',27,21,22,NULL,NULL),(40,'财务退还押金',21,NULL,22,'returnDeposit',NULL),(50,'采购人员录入商品信息',25,23,27,NULL,'stockInProductModify'),(51,'摄影人员上传商品多媒体文件',23,24,27,NULL,'productFilesUpload'),(52,'编辑人员审核及上架商品',24,NULL,27,'onSale',NULL),(55,'仓储复核采购的商品信息',22,27,29,NULL,NULL),(56,'提示入库员入库商品',27,NULL,29,NULL,NULL),(57,'财务复核采购的商品信息及采购金额',21,27,30,NULL,NULL),(58,'提示入库员入库商品',27,NULL,30,NULL,NULL),(59,'销售员申请调价',17,28,31,NULL,'priceChangeModify'),(60,'销售主管审核调价申请',28,NULL,31,'priceChangeSetStateUse',NULL),(64,'录入报损出库单',27,26,33,NULL,NULL),(65,'总经理审核报损出库单',26,21,33,NULL,NULL),(66,'财务审核报损出库单',21,NULL,33,'stockOutProductBreakage',NULL),(67,'生成快递单',17,27,34,NULL,NULL),(68,'提醒打印快递单',27,NULL,34,NULL,NULL),(69,'销售主管调价申请',28,31,35,NULL,'priceChangeModify'),(70,'销售经理审核调价申请',31,NULL,35,'priceChangeSetStateUse',NULL),(71,'销售经理调价申请',31,30,36,NULL,'priceChangeModify'),(72,'销售总监审核调价申请',30,NULL,36,'priceChangeSetStateUse',NULL),(73,'销售总监调价申请',30,26,37,NULL,'priceChangeModify'),(74,'总经理审核调价申请',26,NULL,37,'priceChangeSetStateUse',NULL),(75,'请审核凭证',21,30,32,NULL,NULL),(76,'请审核凭证',30,NULL,32,NULL,NULL),(77,'发起凭证审核',21,32,39,NULL,NULL),(78,'审核凭证',32,NULL,39,'voucherVerifyPassModifyState',NULL);

#
# Structure for table "hzg_sys_company"
#

DROP TABLE IF EXISTS `hzg_sys_company`;
CREATE TABLE `hzg_sys_company` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '公司名称',
  `phone` varchar(16) DEFAULT NULL COMMENT '联系电话',
  `address` varchar(60) DEFAULT NULL COMMENT '地址',
  `city` varchar(16) DEFAULT NULL COMMENT '城市',
  `province` varchar(16) DEFAULT NULL COMMENT '省份',
  `country` varchar(16) DEFAULT NULL COMMENT '国家',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  `chargerId` int(11) DEFAULT NULL COMMENT '公司负责人id',
  `postCode` varchar(7) DEFAULT NULL COMMENT '邮编',
  PRIMARY KEY (`Id`),
  KEY `chargerId` (`chargerId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公司表';

INSERT INTO `hzg_sys_company` (`Id`,`name`,`phone`,`address`,`city`,`province`,`country`,`inputDate`,`chargerId`,`postCode`) VALUES (11,'红掌柜珠宝有限公司','0871-1234567','西山区西园路与滇池路交叉口融城优郡B5栋19楼','昆明市','云南省','中国','2017-05-03 15:46:23',NULL,'655000'),(12,'广州分公司','026-1234567','广州市','广州市','广东省','中国','2017-05-03 15:50:20',NULL,'510000');

#
# Structure for table "hzg_sys_dept"
#

DROP TABLE IF EXISTS `hzg_sys_dept`;
CREATE TABLE `hzg_sys_dept` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '部门名称，如：财务，营销，销售，采购等',
  `phone` varchar(16) DEFAULT NULL COMMENT '联系电话',
  `address` varchar(60) DEFAULT NULL COMMENT '地址',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  `companyId` int(11) DEFAULT NULL COMMENT '所属公司id',
  `chargerId` int(11) DEFAULT NULL COMMENT '部门负责人id',
  PRIMARY KEY (`Id`),
  KEY `chargerId` (`chargerId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='部门表';

#
# Data for table "hzg_sys_dept"
#

INSERT INTO `hzg_sys_dept` (`Id`,`name`,`phone`,`address`,`inputDate`,`companyId`,`chargerId`) VALUES (13,'营销部','0871-2345678','西苑路51号B座','2017-05-03 15:47:47',11,NULL),(14,'市场','0871-3456789','西苑路51号B座','2017-05-03 15:49:42',11,NULL),(15,'财务部','0871-3456789','西苑路51号B座','2017-05-24 09:29:30',11,NULL),(16,'总经理室','0871-1234567','西苑路2号21楼','2017-06-19 15:34:18',11,NULL),(17,'测试','111','测试','2017-09-27 18:00:19',11,29),(18,'test1','11','test1','2017-09-27 18:01:40',11,29);

#
# Structure for table "hzg_sys_post"
#

DROP TABLE IF EXISTS `hzg_sys_post`;
CREATE TABLE `hzg_sys_post` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(12) DEFAULT NULL COMMENT '岗位名称，如：财务专员，财务总监，仓储，总经理，采购专员等',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  `deptId` int(11) DEFAULT NULL COMMENT '所属部门id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='岗位';

#
# Data for table "hzg_sys_post"
#

INSERT INTO `hzg_sys_post` (`Id`,`name`,`inputDate`,`deptId`) VALUES (16,'信息','2017-05-03 15:48:50',13),(17,'销售','2017-05-03 15:54:05',14),(19,'新媒体','2017-05-04 13:14:59',13),(20,'竞价','2017-05-04 14:13:22',13),(21,'财务','2017-05-24 09:29:58',15),(22,'仓储','2017-05-24 09:30:59',14),(23,'摄影','2017-05-24 09:44:59',14),(24,'编辑','2017-05-24 09:45:12',14),(25,'采购','2017-05-24 09:47:27',14),(26,'总经理','2017-06-19 15:34:43',16),(27,'库管员','2017-06-30 14:25:35',14),(28,'销售主管','2017-08-30 17:16:10',14),(29,'test','2017-09-27 11:50:44',13),(30,'销售总监','2017-12-19 11:05:42',14),(31,'销售经理','2018-03-27 10:47:53',14),(32,'财务总监','1970-01-04 09:07:03',15);

#
# Structure for table "hzg_sys_privilege_relation"
#

DROP TABLE IF EXISTS `hzg_sys_privilege_relation`;
CREATE TABLE `hzg_sys_privilege_relation` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `postId` int(11) DEFAULT NULL COMMENT '岗位id',
  `resourceId` int(11) DEFAULT NULL COMMENT '权限资源id',
  `assignDate` datetime DEFAULT NULL COMMENT '分配时间',
  `revokeDate` datetime DEFAULT NULL COMMENT '撤回时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=751 DEFAULT CHARSET=utf8 COMMENT='后台用户、岗位、权限资源关联表';

#
# Data for table "hzg_sys_privilege_relation"
#

INSERT INTO `hzg_sys_privilege_relation` (`Id`,`postId`,`resourceId`,`assignDate`,`revokeDate`) VALUES (1,16,10,NULL,NULL),(2,16,18,NULL,NULL),(3,16,21,NULL,NULL),(4,16,14,NULL,NULL),(161,16,32,NULL,NULL),(163,16,30,NULL,NULL),(164,16,29,NULL,NULL),(165,16,28,NULL,NULL),(166,16,27,NULL,NULL),(167,16,26,NULL,NULL),(168,16,25,NULL,NULL),(169,16,24,NULL,NULL),(170,16,23,NULL,NULL),(171,16,22,NULL,NULL),(172,16,20,NULL,NULL),(173,16,19,NULL,NULL),(174,16,17,NULL,NULL),(175,16,16,NULL,NULL),(176,16,15,NULL,NULL),(177,16,13,NULL,NULL),(178,16,12,NULL,NULL),(179,16,11,NULL,NULL),(180,16,9,NULL,NULL),(181,16,8,NULL,NULL),(182,16,7,NULL,NULL),(183,16,6,NULL,NULL),(184,16,5,NULL,NULL),(185,16,4,NULL,NULL),(186,16,3,NULL,NULL),(187,16,31,NULL,NULL),(188,16,33,NULL,NULL),(189,16,37,NULL,NULL),(190,16,36,NULL,NULL),(191,16,35,NULL,NULL),(192,16,34,NULL,NULL),(194,22,33,NULL,NULL),(195,21,33,NULL,NULL),(202,16,43,NULL,NULL),(203,16,42,NULL,NULL),(204,16,41,NULL,NULL),(205,16,40,NULL,NULL),(206,16,39,NULL,NULL),(207,16,38,NULL,NULL),(214,16,55,NULL,NULL),(215,16,54,NULL,NULL),(216,16,53,NULL,NULL),(217,16,52,NULL,NULL),(218,16,51,NULL,NULL),(219,16,50,NULL,NULL),(220,16,49,NULL,NULL),(221,16,48,NULL,NULL),(222,16,47,NULL,NULL),(223,16,46,NULL,NULL),(224,16,45,NULL,NULL),(225,16,44,NULL,NULL),(226,25,55,NULL,NULL),(227,25,54,NULL,NULL),(228,25,53,NULL,NULL),(229,25,52,NULL,NULL),(230,25,51,NULL,NULL),(231,25,50,NULL,NULL),(232,25,49,NULL,NULL),(233,25,48,NULL,NULL),(234,25,47,NULL,NULL),(235,25,46,NULL,NULL),(236,25,45,NULL,NULL),(237,25,44,NULL,NULL),(238,16,56,NULL,NULL),(239,25,23,NULL,NULL),(240,25,68,NULL,NULL),(241,25,67,NULL,NULL),(242,25,66,NULL,NULL),(243,25,65,NULL,NULL),(244,25,64,NULL,NULL),(245,25,63,NULL,NULL),(246,25,62,NULL,NULL),(247,25,61,NULL,NULL),(248,25,60,NULL,NULL),(249,25,59,NULL,NULL),(250,25,58,NULL,NULL),(251,25,57,NULL,NULL),(252,16,68,NULL,NULL),(253,16,67,NULL,NULL),(254,16,66,NULL,NULL),(255,16,65,NULL,NULL),(256,16,64,NULL,NULL),(257,16,63,NULL,NULL),(258,16,62,NULL,NULL),(259,16,61,NULL,NULL),(260,16,60,NULL,NULL),(261,16,59,NULL,NULL),(262,16,58,NULL,NULL),(263,16,57,NULL,NULL),(264,25,74,NULL,NULL),(265,25,73,NULL,NULL),(266,25,72,NULL,NULL),(267,25,71,NULL,NULL),(268,25,70,NULL,NULL),(269,25,69,NULL,NULL),(270,25,75,NULL,NULL),(271,26,45,NULL,NULL),(272,22,45,NULL,NULL),(273,25,33,NULL,NULL),(274,27,45,NULL,NULL),(275,21,45,NULL,NULL),(276,27,82,NULL,NULL),(277,27,81,NULL,NULL),(278,27,80,NULL,NULL),(279,27,79,NULL,NULL),(280,27,78,NULL,NULL),(281,27,77,NULL,NULL),(282,27,76,NULL,NULL),(283,16,94,NULL,NULL),(284,16,93,NULL,NULL),(285,16,92,NULL,NULL),(286,16,91,NULL,NULL),(287,16,90,NULL,NULL),(288,16,89,NULL,NULL),(289,21,94,NULL,NULL),(290,21,93,NULL,NULL),(291,21,92,NULL,NULL),(292,21,91,NULL,NULL),(293,21,90,NULL,NULL),(294,21,89,NULL,NULL),(295,21,100,NULL,NULL),(296,21,99,NULL,NULL),(297,21,98,NULL,NULL),(298,21,97,NULL,NULL),(299,21,96,NULL,NULL),(300,21,95,NULL,NULL),(301,16,100,NULL,NULL),(302,16,99,NULL,NULL),(303,16,98,NULL,NULL),(304,16,97,NULL,NULL),(305,16,96,NULL,NULL),(306,16,95,NULL,NULL),(307,16,88,NULL,NULL),(308,16,87,NULL,NULL),(309,16,86,NULL,NULL),(310,16,85,NULL,NULL),(311,16,84,NULL,NULL),(312,16,83,NULL,NULL),(313,16,82,NULL,NULL),(314,16,75,NULL,NULL),(315,16,74,NULL,NULL),(316,16,73,NULL,NULL),(317,16,72,NULL,NULL),(318,16,71,NULL,NULL),(319,16,70,NULL,NULL),(320,16,69,NULL,NULL),(321,27,88,NULL,NULL),(322,27,87,NULL,NULL),(323,27,86,NULL,NULL),(324,27,85,NULL,NULL),(325,27,84,NULL,NULL),(326,27,83,NULL,NULL),(327,27,67,NULL,NULL),(328,27,66,NULL,NULL),(329,27,65,NULL,NULL),(330,27,64,NULL,NULL),(331,27,63,NULL,NULL),(332,27,48,NULL,NULL),(333,27,47,NULL,NULL),(334,25,103,NULL,NULL),(335,25,102,NULL,NULL),(336,27,105,NULL,NULL),(337,27,104,NULL,NULL),(338,22,111,NULL,NULL),(339,22,110,NULL,NULL),(340,22,109,NULL,NULL),(341,22,108,NULL,NULL),(342,22,107,NULL,NULL),(343,22,106,NULL,NULL),(344,16,111,NULL,NULL),(345,16,110,NULL,NULL),(346,16,109,NULL,NULL),(347,16,108,NULL,NULL),(348,16,107,NULL,NULL),(349,16,106,NULL,NULL),(350,16,105,NULL,NULL),(351,16,104,NULL,NULL),(352,16,103,NULL,NULL),(353,16,102,NULL,NULL),(355,22,19,NULL,NULL),(356,27,111,NULL,NULL),(357,21,87,NULL,NULL),(358,25,87,NULL,NULL),(359,27,112,NULL,NULL),(360,22,112,NULL,NULL),(361,23,124,NULL,NULL),(362,23,123,NULL,NULL),(363,23,113,NULL,NULL),(364,23,67,NULL,NULL),(365,23,65,NULL,NULL),(366,23,64,NULL,NULL),(367,24,122,NULL,NULL),(368,24,121,NULL,NULL),(369,24,120,NULL,NULL),(370,24,118,NULL,NULL),(371,24,115,NULL,NULL),(372,24,114,NULL,NULL),(373,24,67,NULL,NULL),(374,24,65,NULL,NULL),(375,24,64,NULL,NULL),(376,24,63,NULL,NULL),(377,23,63,NULL,NULL),(378,23,125,NULL,NULL),(379,24,126,NULL,NULL),(380,17,137,NULL,NULL),(381,17,136,NULL,NULL),(382,17,135,NULL,NULL),(383,17,134,NULL,NULL),(384,17,133,NULL,NULL),(385,17,132,NULL,NULL),(386,17,138,NULL,NULL),(392,17,67,NULL,NULL),(393,17,65,NULL,NULL),(394,17,64,NULL,NULL),(395,17,63,NULL,NULL),(402,17,126,NULL,NULL),(404,17,97,NULL,NULL),(408,28,138,NULL,NULL),(409,28,137,NULL,NULL),(410,28,136,NULL,NULL),(411,28,135,NULL,NULL),(412,28,134,NULL,NULL),(413,28,133,NULL,NULL),(414,28,132,NULL,NULL),(415,28,100,NULL,NULL),(416,28,99,NULL,NULL),(417,28,97,NULL,NULL),(418,28,95,NULL,NULL),(419,28,67,NULL,NULL),(420,28,65,NULL,NULL),(421,28,64,NULL,NULL),(422,17,158,NULL,NULL),(423,17,157,NULL,NULL),(424,17,156,NULL,NULL),(425,17,153,NULL,NULL),(426,17,152,NULL,NULL),(427,17,151,NULL,NULL),(428,17,150,NULL,NULL),(429,17,149,NULL,NULL),(430,17,148,NULL,NULL),(431,17,147,NULL,NULL),(432,17,145,NULL,NULL),(433,22,158,NULL,NULL),(434,22,157,NULL,NULL),(435,22,156,NULL,NULL),(436,22,154,NULL,NULL),(437,22,153,NULL,NULL),(438,22,152,NULL,NULL),(439,22,151,NULL,NULL),(440,22,150,NULL,NULL),(441,22,145,NULL,NULL),(442,24,129,NULL,NULL),(443,24,128,NULL,NULL),(444,24,127,NULL,NULL),(445,24,131,NULL,NULL),(446,24,130,NULL,NULL),(447,17,159,NULL,NULL),(448,22,160,NULL,NULL),(449,22,67,NULL,NULL),(450,22,65,NULL,NULL),(451,22,64,NULL,NULL),(452,22,63,NULL,NULL),(453,22,139,NULL,NULL),(454,21,161,NULL,NULL),(455,21,152,NULL,NULL),(456,21,151,NULL,NULL),(457,21,150,NULL,NULL),(458,21,145,NULL,NULL),(459,21,162,NULL,NULL),(460,27,163,NULL,NULL),(461,26,87,NULL,NULL),(462,25,163,NULL,NULL),(463,25,85,NULL,NULL),(464,25,84,NULL,NULL),(465,25,83,NULL,NULL),(466,27,168,NULL,NULL),(467,27,167,NULL,NULL),(468,24,166,NULL,NULL),(469,24,165,NULL,NULL),(470,24,164,NULL,NULL),(471,27,169,NULL,NULL),(473,17,180,NULL,NULL),(474,17,179,NULL,NULL),(475,17,178,NULL,NULL),(476,17,177,NULL,NULL),(478,30,187,NULL,NULL),(479,30,138,NULL,NULL),(480,30,100,NULL,NULL),(481,30,99,NULL,NULL),(482,30,97,NULL,NULL),(483,30,95,NULL,NULL),(484,30,67,NULL,NULL),(485,30,65,NULL,NULL),(486,30,64,NULL,NULL),(488,22,188,NULL,NULL),(489,30,180,NULL,NULL),(490,30,179,NULL,NULL),(491,30,178,NULL,NULL),(492,30,177,NULL,NULL),(493,22,180,NULL,NULL),(494,22,179,NULL,NULL),(495,22,178,NULL,NULL),(496,22,177,NULL,NULL),(497,21,180,NULL,NULL),(498,21,179,NULL,NULL),(499,21,178,NULL,NULL),(500,21,177,NULL,NULL),(501,27,190,NULL,NULL),(502,17,186,NULL,NULL),(503,21,67,NULL,NULL),(504,17,191,NULL,NULL),(505,21,192,NULL,NULL),(506,21,131,NULL,NULL),(507,21,130,NULL,NULL),(508,21,75,NULL,NULL),(509,21,74,NULL,NULL),(510,21,73,NULL,NULL),(511,21,72,NULL,NULL),(512,21,70,NULL,NULL),(513,21,65,NULL,NULL),(514,21,64,NULL,NULL),(515,21,63,NULL,NULL),(516,21,62,NULL,NULL),(517,21,61,NULL,NULL),(518,21,60,NULL,NULL),(519,21,58,NULL,NULL),(520,21,48,NULL,NULL),(521,21,47,NULL,NULL),(522,21,127,NULL,NULL),(523,21,160,NULL,NULL),(524,21,159,NULL,NULL),(525,21,158,NULL,NULL),(526,21,157,NULL,NULL),(527,21,156,NULL,NULL),(528,21,153,NULL,NULL),(529,21,82,NULL,NULL),(530,21,193,NULL,NULL),(531,21,189,NULL,NULL),(533,17,194,NULL,NULL),(534,17,176,NULL,NULL),(535,30,204,NULL,NULL),(536,30,203,NULL,NULL),(537,30,202,NULL,NULL),(538,30,201,NULL,NULL),(539,22,204,NULL,NULL),(540,22,203,NULL,NULL),(541,22,202,NULL,NULL),(542,22,201,NULL,NULL),(543,17,204,NULL,NULL),(544,17,203,NULL,NULL),(545,17,202,NULL,NULL),(546,17,201,NULL,NULL),(547,17,196,NULL,NULL),(548,21,204,NULL,NULL),(549,21,203,NULL,NULL),(550,21,202,NULL,NULL),(551,21,201,NULL,NULL),(552,21,195,NULL,NULL),(553,17,205,NULL,NULL),(554,30,206,NULL,NULL),(555,22,208,NULL,NULL),(556,17,209,NULL,NULL),(557,17,210,NULL,NULL),(559,25,211,NULL,NULL),(560,25,212,NULL,NULL),(561,25,180,NULL,NULL),(562,25,179,NULL,NULL),(563,25,178,NULL,NULL),(564,25,177,NULL,NULL),(565,22,213,NULL,NULL),(568,25,214,NULL,NULL),(569,25,191,NULL,NULL),(570,21,220,NULL,NULL),(571,21,218,NULL,NULL),(572,21,216,NULL,NULL),(573,17,250,NULL,NULL),(574,17,249,NULL,NULL),(575,17,248,NULL,NULL),(576,17,247,NULL,NULL),(577,17,246,NULL,NULL),(578,17,245,NULL,NULL),(579,17,226,NULL,NULL),(580,17,224,NULL,NULL),(581,17,223,NULL,NULL),(582,17,221,NULL,NULL),(584,16,252,NULL,NULL),(585,17,251,NULL,NULL),(586,17,253,NULL,NULL),(587,16,254,NULL,NULL),(588,30,261,NULL,NULL),(589,30,260,NULL,NULL),(590,30,259,NULL,NULL),(591,30,258,NULL,NULL),(592,30,256,NULL,NULL),(593,17,264,NULL,NULL),(594,17,262,NULL,NULL),(595,17,261,NULL,NULL),(596,17,260,NULL,NULL),(597,17,259,NULL,NULL),(598,17,258,NULL,NULL),(599,17,257,NULL,NULL),(600,22,263,NULL,NULL),(601,22,261,NULL,NULL),(602,22,260,NULL,NULL),(603,22,259,NULL,NULL),(604,22,258,NULL,NULL),(605,22,255,NULL,NULL),(606,21,265,NULL,NULL),(607,21,261,NULL,NULL),(608,21,260,NULL,NULL),(609,21,259,NULL,NULL),(610,21,258,NULL,NULL),(611,17,143,NULL,NULL),(612,17,142,NULL,NULL),(613,17,141,NULL,NULL),(614,17,140,NULL,NULL),(615,17,139,NULL,NULL),(616,28,143,NULL,NULL),(617,28,142,NULL,NULL),(618,28,141,NULL,NULL),(619,28,140,NULL,NULL),(620,28,139,NULL,NULL),(621,31,268,NULL,NULL),(622,31,143,NULL,NULL),(623,31,142,NULL,NULL),(624,31,141,NULL,NULL),(625,31,140,NULL,NULL),(626,31,139,NULL,NULL),(627,31,138,NULL,NULL),(628,30,269,NULL,NULL),(629,30,143,NULL,NULL),(630,30,142,NULL,NULL),(631,30,141,NULL,NULL),(632,30,140,NULL,NULL),(633,30,139,NULL,NULL),(634,28,267,NULL,NULL),(635,17,266,NULL,NULL),(636,23,280,NULL,NULL),(637,23,276,NULL,NULL),(638,23,275,NULL,NULL),(639,23,274,NULL,NULL),(640,23,272,NULL,NULL),(641,23,271,NULL,NULL),(642,23,270,NULL,NULL),(643,22,279,NULL,NULL),(644,22,275,NULL,NULL),(645,22,274,NULL,NULL),(646,22,270,NULL,NULL),(647,22,288,NULL,NULL),(648,22,285,NULL,NULL),(649,22,284,NULL,NULL),(650,22,282,NULL,NULL),(651,23,288,NULL,NULL),(652,23,287,NULL,NULL),(653,23,286,NULL,NULL),(654,23,285,NULL,NULL),(655,23,284,NULL,NULL),(656,23,283,NULL,NULL),(657,23,281,NULL,NULL),(658,23,126,NULL,NULL),(660,23,289,NULL,NULL),(661,21,359,NULL,NULL),(662,21,358,NULL,NULL),(663,21,357,NULL,NULL),(664,21,349,NULL,NULL),(665,21,348,NULL,NULL),(666,21,347,NULL,NULL),(667,21,346,NULL,NULL),(668,21,345,NULL,NULL),(669,21,344,NULL,NULL),(670,21,343,NULL,NULL),(671,21,342,NULL,NULL),(672,21,341,NULL,NULL),(673,21,340,NULL,NULL),(674,21,339,NULL,NULL),(675,21,338,NULL,NULL),(676,21,337,NULL,NULL),(677,21,336,NULL,NULL),(678,21,335,NULL,NULL),(679,21,334,NULL,NULL),(680,21,333,NULL,NULL),(681,21,332,NULL,NULL),(682,21,331,NULL,NULL),(683,21,330,NULL,NULL),(684,21,329,NULL,NULL),(685,21,328,NULL,NULL),(686,21,327,NULL,NULL),(687,21,326,NULL,NULL),(688,21,325,NULL,NULL),(689,21,324,NULL,NULL),(690,21,323,NULL,NULL),(691,21,322,NULL,NULL),(692,21,321,NULL,NULL),(693,21,320,NULL,NULL),(694,21,319,NULL,NULL),(695,21,318,NULL,NULL),(696,21,317,NULL,NULL),(697,21,316,NULL,NULL),(698,21,315,NULL,NULL),(699,21,314,NULL,NULL),(700,21,313,NULL,NULL),(701,21,312,NULL,NULL),(702,21,311,NULL,NULL),(703,21,310,NULL,NULL),(704,21,309,NULL,NULL),(705,21,308,NULL,NULL),(706,32,359,NULL,NULL),(707,32,358,NULL,NULL),(708,32,357,NULL,NULL),(709,32,346,NULL,NULL),(710,32,345,NULL,NULL),(711,32,344,NULL,NULL),(712,32,343,NULL,NULL),(713,32,342,NULL,NULL),(714,32,341,NULL,NULL),(715,32,338,NULL,NULL),(716,32,336,NULL,NULL),(717,32,335,NULL,NULL),(718,32,334,NULL,NULL),(719,32,332,NULL,NULL),(720,32,331,NULL,NULL),(721,32,329,NULL,NULL),(722,32,325,NULL,NULL),(723,32,324,NULL,NULL),(724,32,323,NULL,NULL),(725,32,322,NULL,NULL),(726,32,318,NULL,NULL),(727,32,317,NULL,NULL),(728,32,314,NULL,NULL),(729,32,313,NULL,NULL),(730,32,312,NULL,NULL),(731,32,311,NULL,NULL),(732,32,310,NULL,NULL),(733,22,307,NULL,NULL),(734,22,306,NULL,NULL),(735,22,305,NULL,NULL),(736,22,304,NULL,NULL),(737,22,303,NULL,NULL),(738,22,302,NULL,NULL),(739,22,298,NULL,NULL),(740,22,297,NULL,NULL),(741,22,296,NULL,NULL),(742,24,301,NULL,NULL),(743,24,300,NULL,NULL),(744,24,299,NULL,NULL),(745,24,295,NULL,NULL),(746,24,294,NULL,NULL),(747,24,293,NULL,NULL),(748,24,292,NULL,NULL),(749,24,291,NULL,NULL),(750,24,290,NULL,NULL),(751,17,361,NULL,NULL),(752,17,360,NULL,NULL),(753,17,365,NULL,NULL),(754,17,364,NULL,NULL),(755,17,363,NULL,NULL),(756,17,362,NULL,NULL),(757,17,371,NULL,NULL),(758,17,370,NULL,NULL),(759,17,369,NULL,NULL),(760,17,368,NULL,NULL),(761,17,367,NULL,NULL),(762,17,366,NULL,NULL),(763,24,356,NULL,NULL),(766,24,355,NULL,NULL),(769,24,354,NULL,NULL),(772,24,353,NULL,NULL),(775,24,352,NULL,NULL),(778,24,351,NULL,NULL),(781,24,350,NULL,NULL),(782,22,49,NULL,NULL),(785,22,48,NULL,NULL),(788,22,47,NULL,NULL);

#
# Structure for table "hzg_sys_privilege_resource"
#

DROP TABLE IF EXISTS `hzg_sys_privilege_resource`;
CREATE TABLE `hzg_sys_privilege_resource` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '权限名称',
  `uri` varchar(96) DEFAULT NULL COMMENT '资源uri',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=360 DEFAULT CHARSET=utf8 COMMENT='权限资源表';

#
# Data for table "hzg_sys_privilege_resource"
#

INSERT INTO `hzg_sys_privilege_resource` (`Id`,`name`,`uri`,`inputDate`) VALUES (3,'后台用户注册','/sys/save/user','2017-05-08 14:38:13'),(4,'公司注册','/sys/save/company','2017-05-08 14:44:01'),(5,'部门注册','/sys/save/dept','2017-05-08 14:44:16'),(6,'岗位注册','/sys/save/post','2017-05-08 14:44:52'),(7,'后台用户修改','/sys/update/user','2017-05-08 14:45:13'),(8,'公司修改','/sys/update/company','2017-05-08 14:45:23'),(9,'部门修改','/sys/update/dept','2017-05-08 14:45:42'),(10,'岗位修改','/sys/update/post','2017-05-08 14:46:00'),(11,'后台用户查看','/sys/view/user/{id}','2017-05-08 14:47:21'),(12,'公司查看','/sys/view/company/{id}','2017-05-08 14:47:30'),(13,'部门查看','/sys/view/dept/{id}','2017-05-08 14:47:38'),(14,'岗位查看','/sys/view/post/{id}','2017-05-08 14:47:44'),(15,'权限添加','/sys/save/privilegeResource','2017-05-08 14:48:12'),(16,'权限修改','/sys/update/privilegeResource','2017-05-08 14:48:30'),(17,'权限查看','/sys/view/privilegeResource/{id}','2017-05-08 14:48:41'),(18,'权限分配','/sys/business/assignPrivilege','2017-05-15 11:15:41'),(19,'公司查询','/sys/query/company','2017-05-15 13:35:46'),(20,'部门查询','/sys/query/dept','2017-05-15 13:35:55'),(21,'岗位查询','/sys/query/post','2017-05-15 13:36:09'),(22,'后台用户查询','/sys/query/user','2017-05-15 13:36:27'),(23,'后台用户建议','/sys/suggest/user/{properties}/{word}','2017-05-15 13:42:31'),(24,'岗位建议','/sys/suggest/post/{properties}/{word}','2017-05-15 13:42:57'),(25,'部门建议','/sys/suggest/dept/{properties}/{word}','2017-05-15 13:43:07'),(26,'公司建议','/sys/suggest/company/{properties}/{word}','2017-05-15 13:43:18'),(27,'用户复杂查询','/sys/complexQuery/user','2017-05-15 16:20:39'),(28,'公司复杂查询','/sys/complexQuery/company','2017-05-15 16:20:51'),(29,'部门复杂查询','/sys/complexQuery/dept','2017-05-15 16:21:00'),(30,'岗位复杂查询','/sys/complexQuery/post','2017-05-15 16:21:11'),(31,'权限复杂查询','/sys/complexQuery/privilegeResource','2017-05-15 16:21:26'),(32,'权限查询','/sys/query/privilegeResource','2017-05-15 16:22:13'),(33,'事宜办理、审核','/sys/audit','2017-05-20 15:15:43'),(34,'流程查看','/sys/view/auditFlow/{id}','2017-05-22 14:19:23'),(35,'流程添加','/sys/save/auditFlow','2017-05-22 14:22:55'),(36,'流程查询','/sys/query/auditFlow','2017-05-22 14:24:48'),(37,'流程复杂查询','/sys/complexQuery/auditFlow','2017-05-22 14:25:03'),(44,'采购单保存','/erp/save/purchase','2017-05-26 13:27:29'),(45,'采购单查看','/erp/view/purchase/{id}','2017-05-26 13:28:42'),(46,'采购单修改','/erp/update/purchase','2017-05-26 13:28:56'),(47,'采购单复杂查询','/erp/complexQuery/purchase','2017-05-26 13:29:26'),(48,'采购单查询','/erp/query/purchase','2017-05-26 13:29:59'),(49,'采购单建议','/erp/suggest/purchase/{properties}/{word}','2017-05-26 13:30:22'),(50,'供应商保存','/erp/save/supplier','2017-05-26 13:27:29'),(51,'供应商查看','/erp/view/supplier/{id}','2017-05-26 13:28:42'),(52,'供应商修改','/erp/update/supplier','2017-05-26 13:28:56'),(53,'供应商复杂查询','/erp/complexQuery/supplier','2017-05-26 13:29:26'),(54,'供应商查询','/erp/query/supplier','2017-05-26 13:29:59'),(55,'供应商建议','/erp/suggest/supplier/{properties}/{word}','2017-05-26 13:30:22'),(56,'流程修改','/sys/update/auditFlow','2017-06-01 10:38:22'),(57,'商品类型保存','/erp/save/productType','2017-05-26 13:27:29'),(58,'商品类型查看','/erp/view/productType/{id}','2017-05-26 13:28:42'),(59,'商品类型修改','/erp/update/productType','2017-05-26 13:28:56'),(60,'商品类型复杂查询','/erp/complexQuery/productType','2017-05-26 13:29:26'),(61,'商品类型查询','/erp/query/productType','2017-05-26 13:29:59'),(62,'商品类型建议','/erp/suggest/productType/{properties}/{word}','2017-05-26 13:30:22'),(63,'商品建议','/erp/suggest/product/{properties}/{word}','2017-05-26 13:30:22'),(64,'商品查询','/erp/query/product','2017-05-26 13:29:59'),(65,'商品复杂查询','/erp/complexQuery/product','2017-05-26 13:29:26'),(66,'商品修改','/erp/update/product','2017-05-26 13:28:56'),(67,'商品查看','/erp/view/product/{id}','2017-05-26 13:28:42'),(68,'商品保存','/erp/save/product','2017-05-26 13:27:29'),(69,'商品属性保存','/erp/save/productProperty','2017-05-26 13:27:29'),(70,'商品属性查看','/erp/view/productProperty/{id}','2017-05-26 13:28:42'),(71,'商品属性修改','/erp/update/productProperty','2017-05-26 13:28:56'),(72,'商品属性复杂查询','/erp/complexQuery/productProperty','2017-05-26 13:29:26'),(73,'商品属性查询','/erp/query/productProperty','2017-05-26 13:29:59'),(74,'商品属性建议','/erp/suggest/productProperty/{properties}/{word}','2017-05-26 13:30:22'),(75,'商品属性私有查询','/erp/privateQuery/productProperty','2017-06-10 14:25:45'),(82,'erp多实体建议','/erp/entitiesSuggest/{targetEntities}/{entities}','2017-05-26 13:29:26'),(83,'入库、出库单建议','/erp/suggest/stockInOut/{properties}/{word}','2017-05-26 13:30:22'),(84,'入库、出库单查询','/erp/query/stockInOut','2017-05-26 13:29:59'),(85,'入库、出库单复杂查询','/erp/complexQuery/stockInOut','2017-05-26 13:29:26'),(86,'入库、出库单修改','/erp/update/stockInOut','2017-05-26 13:28:56'),(87,'入库、出库单查看','/erp/view/stockInOut/{id}','2017-05-26 13:28:42'),(88,'入库、出库单保存','/erp/save/stockInOut','2017-05-26 13:27:29'),(89,'公司账户查询','/pay/query/account','2017-05-26 13:29:59'),(90,'公司账户复杂查询','/pay/complexQuery/account','2017-05-26 13:29:26'),(91,'公司账户修改','/pay/update/account','2017-05-26 13:28:56'),(92,'公司账户查看','/pay/view/account/{id}','2017-05-26 13:28:42'),(93,'公司账户保存','/pay/save/account','2017-05-26 13:27:29'),(94,'公司账户建议','/pay/suggest/account/{properties}/{word}','2017-05-26 13:30:22'),(95,'支付记录建议','/pay/suggest/pay/{properties}/{word}','2017-05-26 13:30:22'),(96,'支付记录保存','/pay/save/pay','2017-05-26 13:27:29'),(97,'支付记录查看','/pay/view/pay/{id}','2017-05-26 13:28:42'),(98,'支付记录修改','/pay/update/pay','2017-05-26 13:28:56'),(99,'支付记录复杂查询','/pay/complexQuery/pay','2017-05-26 13:29:26'),(100,'支付记录查询','/pay/query/pay','2017-05-26 13:29:59'),(102,'采购单作废','/erp/delete/purchase','2017-07-12 13:53:41'),(103,'采购单恢复','/erp/recover/purchase','2017-07-12 13:53:56'),(104,'入库、出库单作废','/erp/delete/stockInOut','2017-07-12 13:54:22'),(105,'入库单恢复','/erp/recover/stockInOut','2017-07-12 13:54:35'),(106,'仓库保存','/erp/save/warehouse','2017-05-26 13:27:29'),(107,'仓库查看','/erp/view/warehouse/{id}','2017-05-26 13:28:42'),(108,'仓库修改','/erp/update/warehouse','2017-05-26 13:28:56'),(109,'仓库复杂查询','/erp/complexQuery/warehouse','2017-05-26 13:29:26'),(110,'仓库查询','/erp/query/warehouse','2017-05-26 13:29:59'),(111,'仓库建议','/erp/suggest/warehouse/{properties}/{word}','2017-05-26 13:30:22'),(112,'库存查看','/erp/view/stock/{id}','2017-07-18 14:00:24'),(113,'上传商品多媒体文件','/erp/business/uploadMediaFiles','2017-07-27 09:15:49'),(122,'商品描述复杂查询','/erp/complexQuery/productDescribe','2017-05-26 13:29:26'),(123,'商品多媒体文件上传信息更新','/erp/doBusiness/updateUploadMediaFilesInfo','2017-05-26 13:29:26'),(124,'商品跨域查询','/erp/doBusiness/queryProductAccessAllow','2017-05-26 13:29:59'),(125,'文件系统删除文件','/stream_hzg_upload/deleteFile','2017-07-27 17:20:58'),(126,'商品私有查询','/erp/privateQuery/product','2017-08-02 15:10:44'),(127,'商品描述查询','/erp/query/productDescribe','2017-05-26 13:29:59'),(128,'商品描述保存','/erp/save/productDescribe','2017-05-26 13:27:29'),(129,'商品描述修改','/erp/update/productDescribe','2017-05-26 13:28:56'),(130,'商品描述建议','/erp/suggest/productDescribe/{properties}/{word}','2017-05-26 13:30:22'),(131,'商品描述查看','/erp/view/productDescribe/{id}','2017-07-27 09:16:11'),(138,'价格变动复杂查询','/erp/complexQuery/productPriceChange','2017-07-27 09:16:11'),(139,'价格变动查看','/erp/view/productPriceChange/{id}','2017-07-27 09:16:11'),(140,'价格变动建议','/erp/suggest/productPriceChange/{properties}/{word}','2017-05-26 13:30:22'),(141,'价格变动修改','/erp/update/productPriceChange','2017-05-26 13:28:56'),(142,'价格变动保存','/erp/save/productPriceChange','2017-05-26 13:27:29'),(143,'价格变动查询','/erp/query/productPriceChange','2017-05-26 13:29:59'),(145,'订单查看','/orderManagement/view/order/{id}','2017-07-27 09:16:11'),(147,'订单代下单页面','/orderManagement/business/assistBook','2017-05-26 13:28:56'),(148,'订单代下单','/orderManagement/assistBook','2017-05-26 13:27:29'),(149,'订单取消','/orderManagement/cancel','2017-05-26 13:29:59'),(150,'订单查询','/orderManagement/unlimitedQuery/order','2017-05-26 13:29:59'),(151,'订单复杂查询','/orderManagement/unlimitedComplexQuery/order','2017-05-26 13:29:59'),(152,'订单建议','/orderManagement/unlimitedSuggest/order/{properties}/{word}','2017-05-26 13:29:59'),(153,'商品加工、私人订制查询','/orderManagement/unlimitedQuery/orderPrivate','2017-05-26 13:29:59'),(154,'商品加工、私人订制金额核定','/orderManagement/doBusiness/authorizeOrderPrivateAmount','2017-05-26 13:27:29'),(156,'商品加工、私人订制建议','/orderManagement/unlimitedSuggest/orderPrivate/{properties}/{word}','2017-05-26 13:30:22'),(157,'商品加工、私人订制查看','/orderManagement/view/orderPrivate/{id}','2017-07-27 09:16:11'),(158,'商品加工、私人订制复杂查询','/orderManagement/unlimitedComplexQuery/orderPrivate','2017-07-27 09:16:11'),(159,'价格变动私有查询','/erp/privateQuery/productPriceChange','2017-09-11 17:17:07'),(160,'商品加工、私人订制列表','/orderManagement/list/orderPrivate',NULL),(161,'订单确认付款','/orderManagement/paid','2017-09-21 11:01:07'),(162,'审核通过自助单','/orderManagement/audit','2017-09-22 14:10:26'),(163,'入库出库私有查询','/erp/privateQuery/StockInOut','2017-10-19 09:32:20'),(164,'商品上架下架页面','/erp/view/productUpDownShelf/{id}','2017-11-25 10:21:53'),(165,'商品上架','/erp/doBusiness/upShelfProduct','2017-11-25 10:23:13'),(166,'商品下架','/erp/doBusiness/downShelfProduct','2017-11-25 10:23:24'),(167,'入库商品','/erp/doBusiness/stockInProduct','2017-11-25 10:25:20'),(168,'出库商品','/erp/doBusiness/stockOutProduct','2017-11-25 10:25:29'),(169,'根据接收人和出库单产生顺丰快递单','/erp/doBusiness/generateSfExpressOrderByReceiverAndStockOut','2017-12-05 13:23:46'),(176,'退货申请','/afterSaleService/business/returnProduct','2017-12-19 10:51:46'),(177,'退货单查看','/afterSaleService/view/returnProduct/{id}','2017-12-19 10:51:46'),(178,'退货单查询','/afterSaleService/unlimitedQuery/returnProduct','2017-12-19 10:51:46'),(179,'退货单建议','/afterSaleService/unlimitedSuggest/returnProduct/{properties}/{word}','2017-12-19 10:51:46'),(180,'退货单复杂查询','/afterSaleService/unlimitedComplexQuery/returnProduct','2017-12-19 10:51:46'),(186,'退货销售审核','/afterSaleService/doBusiness/returnProductSaleAudit','2017-12-19 10:51:46'),(187,'退货销售总监审核','/afterSaleService/doBusiness/returnProductDirectorAudit','2017-12-19 10:51:46'),(188,'退货仓储审核','/afterSaleService/doBusiness/returnProductWarehousingAudit','2017-12-19 10:51:46'),(189,'退货财务审核','/afterSaleService/doBusiness/returnProductRefund','2017-12-19 10:51:46'),(190,'打印快递单','/erp/print/expressWaybill','2017-12-20 16:10:51'),(191,'退货保存','/afterSaleService/save/returnProduct','2017-12-25 14:56:18'),(192,'采购单余款确认已付','/erp/doBusiness/purchaseBookPaid','2018-01-18 17:01:31'),(193,'预订单订金确认已付款','/orderManagement/doBusiness/orderBookPaid','2018-01-23 15:40:12'),(194,'换货申请','/afterSaleService/business/changeProduct','2018-02-06 09:58:57'),(195,'换货完成','/afterSaleService/doBusiness/changeProductComplete','2018-02-06 09:59:59'),(196,'换货保存','/afterSaleService/save/changeProduct','2017-12-25 14:56:18'),(201,'换货单复杂查询','/afterSaleService/unlimitedComplexQuery/changeProduct','2017-12-19 10:51:46'),(202,'换货单建议','/afterSaleService/unlimitedSuggest/changeProduct/{properties}/{word}','2017-12-19 10:51:46'),(203,'换货单查询','/afterSaleService/unlimitedQuery/changeProduct','2017-12-19 10:51:46'),(204,'换货单查看','/afterSaleService/view/changeProduct/{id}','2017-12-19 10:51:46'),(205,'换货销售审核','/afterSaleService/doBusiness/changeProductSaleAudit','2018-02-23 10:46:17'),(206,'换货销售总监审核','/afterSaleService/doBusiness/changeProductDirectorAudit','2018-02-23 10:46:17'),(208,'换货仓储审核','/afterSaleService/doBusiness/changeProductWarehousingAudit','2018-02-23 10:46:17'),(209,'客户注册','/customerManagement/save/customer','2018-03-02 14:58:41'),(210,'客户查看','/customerManagement/view/customer/{id}','2018-03-02 15:27:04'),(211,'采购退货采购员确认申请','/afterSaleService/doBusiness/purchaseReturnProductAudit','2018-02-23 10:46:17'),(212,'采购退货供应商确认已收货','/afterSaleService/doBusiness/purchaseReturnProductSupplierReceived','2018-02-23 10:46:17'),(213,'采购退货仓储确认已发货','/afterSaleService/doBusiness/purchaseReturnProductWarehouseAudit','2018-02-23 10:46:17'),(214,'采购退货申请','/afterSaleService/business/purchaseReturnProduct','2018-02-23 10:46:17'),(215,'支付记录查询','/pay/query/refund','2017-05-26 13:29:59'),(216,'退款记录复杂查询','/pay/complexQuery/refund','2017-05-26 13:29:26'),(217,'退款记录修改','/pay/update/refund','2017-05-26 13:28:56'),(218,'退款记录查看','/pay/view/refund/{id}','2017-05-26 13:28:42'),(221,'客户查询','/customerManagement/unlimitedQuery/customer','2018-03-02 15:27:04'),(223,'客户复杂查询','/customerManagement/unlimitedComplexQuery/customer','2018-03-02 15:27:04'),(224,'客户建议','/customerManagement/unlimitedSuggest/customer/{properties}/{word}','2018-03-02 15:27:04'),(226,'客户修改','/customerManagement/update/customer','2018-03-02 15:27:04'),(245,'用户修改','/customerManagement/update/user','2018-03-02 15:27:04'),(246,'用户建议','/customerManagement/unlimitedSuggest/user/{properties}/{word}','2018-03-02 15:27:04'),(247,'用户复杂查询','/customerManagement/unlimitedComplexQuery/user','2018-03-02 15:27:04'),(248,'用户查询','/customerManagement/unlimitedQuery/user','2018-03-02 15:27:04'),(249,'用户查看','/customerManagement/view/user/{id}','2018-03-02 15:27:04'),(250,'用户注册','/customerManagement/save/user','2018-03-02 14:58:41'),(251,'用户修改密码','/customerManagement/doBusiness/modifyPassword','2018-03-10 17:35:31'),(252,'后台用户密码修改','/sys/doBusiness/modifyPassword','2018-03-10 17:38:21'),(253,'用户密码重置','/customerManagement/doBusiness/resetPassword','2018-03-12 10:26:16'),(254,'后台用户密码重置','/sys/doBusiness/resetPassword','2018-03-12 10:26:52'),(255,'修补货品仓储审核','/afterSaleService/doBusiness/repairProductWarehousingAudit','2018-02-23 10:46:17'),(256,'修补货品销售总监审核','/afterSaleService/doBusiness/repairProductDirectorAudit','2018-02-23 10:46:17'),(257,'修补货品销售审核','/afterSaleService/doBusiness/repairProductSaleAudit','2018-02-23 10:46:17'),(258,'修补货品单查看','/afterSaleService/view/repairProduct/{id}','2017-12-19 10:51:46'),(259,'修补货品单查询','/afterSaleService/unlimitedQuery/repairProduct','2017-12-19 10:51:46'),(260,'修补货品单建议','/afterSaleService/unlimitedSuggest/repairProduct/{properties}/{word}','2017-12-19 10:51:46'),(261,'修补货品单复杂查询','/afterSaleService/unlimitedComplexQuery/repairProduct','2017-12-19 10:51:46'),(262,'修补货品保存','/afterSaleService/save/repairProduct','2017-12-25 14:56:18'),(263,'修补货品完成','/afterSaleService/doBusiness/repairProductComplete','2018-02-06 09:59:59'),(264,'修补货品申请','/afterSaleService/business/repairProduct','2018-02-06 09:58:57'),(265,'修补货品财务审核','/afterSaleService/doBusiness/repairProductPaid','2018-02-23 10:46:17'),(266,'销售人员调价','/sys/audit/priceChange/saler','2018-03-27 10:43:58'),(267,'销售主管调价','/sys/audit/priceChange/charger','2018-03-27 10:44:29'),(268,'销售经理调价','/sys/audit/priceChange/manager','2018-03-27 10:45:07'),(269,'销售总监调价','/sys/audit/priceChange/director','2018-03-27 10:45:38'),(270,'借货查询','/erp/query/borrowProduct','2018-04-03 13:13:11'),(271,'借货保存','/erp/save/borrowProduct','2018-04-03 13:13:11'),(272,'借货修改','/erp/update/borrowProduct','2018-04-03 13:13:11'),(274,'借货查看','/erp/view/borrowProduct/{id}','2018-04-03 13:13:11'),(275,'借货复杂查询','/erp/complexQuery/borrowProduct','2018-04-03 13:13:11'),(276,'借货单作废','/erp/delete/borrowProduct','2018-04-03 13:13:11'),(279,'借货仓储审核','/erp/doBusiness/borrowProductWarehousingAudit','2018-04-03 13:13:11'),(280,'借货申请','/erp/doBusiness/applyBorrowProduct','2018-04-03 13:13:11'),(281,'还货申请','/erp/doBusiness/applyBorrowProductReturn','2018-04-03 13:13:11'),(282,'还货仓储审核','/erp/doBusiness/borrowProductReturnWarehousingAudit','2018-04-03 13:13:11'),(283,'还货单作废','/erp/delete/borrowProductReturn','2018-04-03 13:13:11'),(284,'还货复杂查询','/erp/complexQuery/borrowProductReturn','2018-04-03 13:13:11'),(285,'还货查看','/erp/view/borrowProductReturn/{id}','2018-04-03 13:13:11'),(286,'还货修改','/erp/update/borrowProductReturn','2018-04-03 13:13:11'),(287,'还货保存','/erp/save/borrowProductReturn','2018-04-03 13:13:11'),(288,'还货查询','/erp/query/borrowProductReturn','2018-04-03 13:13:11'),(289,'借货建议','/erp/suggest/borrowProduct/{properties}/{word}','2018-04-03 13:13:11'),(290,'查看文章','/sys/view/article/{id}','2017-10-09 09:29:26'),(291,'添加文章分类','/sys/save/articleCate','2017-10-12 13:57:30'),(292,'查看文章分类','/sys/view/articleCate/{id}','2017-10-12 14:02:05'),(293,'文章分类查询','/sys/query/articleCate','2017-10-12 15:28:46'),(294,'文章分类复杂查询','/sys/complexQuery/articleCate','2017-10-12 17:12:08'),(295,'文章分类修改','/sys/update/articleCate','2017-10-13 14:16:03'),(296,'添加商品盘点','/erp/save/productCheck','2017-10-25 11:49:10'),(297,'查看商品盘点','/erp/view/productCheck/{id}','2017-10-25 11:52:56'),(298,'商品盘点查询','/erp/query/productCheck','2017-10-26 13:57:29'),(299,'文章查询','/sys/query/article','2017-10-26 15:04:58'),(300,'文章复杂查询','/sys/complexQuery/article','2017-10-26 15:05:29'),(301,'文章修改','/sys/update/article','2017-10-26 15:05:57'),(302,'查询商品计量单位','/erp/privateQuery/productUnit','2017-11-06 15:12:02'),(303,'商品盘点复杂查询','/erp/complexQuery/productCheck','2017-11-09 15:58:13'),(304,'库存复杂查询','/erp/complexQuery/stock','2017-11-11 09:42:23'),(305,'录入商品盘点','/erp/view/productCheckInput/{id}','2017-11-13 14:10:22'),(306,'提交商品盘点','/erp/update/productCheck','2017-11-14 10:47:03'),(307,'商品盘点私有查询','/erp/privateView/productCheck/{properties}/{values}','2017-11-15 10:41:56'),(308,'添加凭证','/finance/save/voucher','2017-11-25 17:17:51'),(309,'填制凭证','/finance/view/voucher/{id}','2017-11-25 17:21:09'),(310,'凭证查询','/finance/query/voucher','2017-11-25 17:26:56'),(311,'凭证类别建议','/finance/suggest/voucherCategory/{properties}/{word}','2017-11-28 11:21:49'),(312,'科目建议','/finance/suggest/subject/{properties}/{word}','2017-11-29 14:53:57'),(313,'用户建议','/finance/suggest/user/{properties}/{word}','2017-11-29 16:56:56'),(314,'凭证复杂查询','/finance/complexQuery/voucher','2017-12-02 13:27:32'),(315,'添加凭证类别','/finance/save/voucherCategory','2017-12-04 14:50:36'),(316,'查看凭证类别','/finance/view/voucherCategory/{id}','2017-12-04 14:54:34'),(317,'凭证类别查询','/finance/query/voucherCategory','2017-12-04 15:13:19'),(318,'凭证类别复杂查询','/finance/complexQuery/voucherCategory','2017-12-04 16:19:59'),(319,'凭证类别修改','/finance/update/voucherCategory','2017-12-04 16:21:10'),(320,'删除凭证类别','/finance/delete/voucherCategory','2017-12-04 17:08:53'),(321,'添加科目','/finance/save/subject','2017-12-06 10:32:12'),(322,'查看科目','/finance/view/subject/{id}','2017-12-06 10:34:05'),(323,'科目查询','/finance/query/subject','2017-12-06 10:37:18'),(324,'查询上级科目','/finance/privateQuery/subject','2017-12-06 16:50:37'),(325,'科目复杂查询','/finance/complexQuery/subject','2017-12-08 09:27:00'),(326,'修改科目','/finance/update/subject','2017-12-08 16:22:43'),(327,'删除科目','/finance/delete/subject','2017-12-08 16:23:29'),(328,'打印凭证','/fiance/print/voucher','2017-12-09 15:18:09'),(329,'供应商建议','/finance/suggest/supplier/{properties}/{word}','2017-12-12 15:15:45'),(330,'科目设置','/finance/view/subjectSet/{id}','2017-12-12 17:58:15'),(331,'科目类别查询','/finance/query/subjectCategory','2017-12-13 17:11:50'),(332,'科目设置查询','/finance/queryDistinct/subject','2017-12-14 14:12:25'),(333,'科目扩展设置','/finance/view/extendSet/{id}','2017-12-20 09:15:38'),(334,'查询科目关联','/finance/query/subjectRelate','2017-12-20 09:19:46'),(335,'银行科目扩展查询','/finance/queryDistinct/bankSubjectExtend','2017-12-20 09:20:51'),(336,'账户建议','/finance/suggest/account/{properties}/{word}','2017-12-21 09:10:29'),(337,'添加银行科目扩展','/finance/save/bankSubjectExtend','2017-12-21 10:26:49'),(338,'采购科目扩展查询','/finance/queryDistinct/purchaseSubjectExtend','2017-12-22 14:33:21'),(339,'添加采购科目扩展','/finance/save/purchaseSubjectExtend','2017-12-22 14:34:47'),(340,'跳转生成凭证页面','/finance/view/createVoucher/{id}','2018-01-18 11:59:46'),(341,'查询单据类型','/finance/privateQuery/docType','2018-01-22 17:31:06'),(342,'查询制单人','/finance/privateQuery/chartMaker','2018-01-25 15:03:54'),(343,'查询仓库','/finance/privateQuery/warehouse','2018-01-27 13:39:44'),(344,'查询商品分类','/finance/privateQuery/productType','2018-01-27 17:37:08'),(345,'查询账户','/finance/privateQuery/account','2018-01-29 13:11:24'),(346,'查询凭证条目来源','/finance/specialQuery/voucherItemSource','2018-02-01 13:49:46'),(347,'生成凭证','/finance/create/voucher','2018-02-28 14:24:19'),(348,'修改凭证','/finance/update/voucher','2018-03-13 14:39:17'),(349,'删除凭证','/finance/delete/voucher','2018-03-13 14:41:56'),(350,'添加文章标签','/sys/save/articleTag','2018-03-28 14:59:51'),(351,'查看文章标签','/sys/view/articleTag/{id}','2018-03-28 15:00:52'),(352,'文章标签查询','/sys/query/articleTag','2018-03-28 15:01:35'),(353,'文章标签复杂查询','/sys/complexQuery/articleTag','2018-03-28 15:02:29'),(354,'文章标签修改','/sys/update/articleTag','2018-03-28 15:03:24'),(355,'查询文章标签','/sys/specialQuery/articleTag','2018-03-29 11:27:07'),(356,'添加文章','/sys/save/article','2018-03-29 14:17:44'),(357,'销售毛利分析表复杂查询','/finance/complexQuery/grossProfit','2018-04-12 17:25:33'),(358,'供应商往来对账表复杂查询','/finance/complexQuery/supplierContact','2018-04-12 17:26:39'),(359,'客户往来对账表复杂查询','/finance/complexQuery/customerContact','2018-04-12 17:27:12'),(360,'客户后台保存','/customerManagement/doBusiness/customerAdminSave','2018-04-23 17:02:40'),(361,'客户后台修改','/customerManagement/doBusiness/customerAdminUpdate','2018-04-23 17:03:00'),(362,'用户后台更新','/customerManagement/doBusiness/userAdminUpdate','2018-04-24 15:34:14'),(363,'用户后台保存','/customerManagement/doBusiness/userAdminSave','2018-04-24 15:34:36'),(364,'收件信息后台保存','/customerManagement/doBusiness/expressAdminSave','2018-04-24 15:40:33'),(365,'收件信息后台修改','/customerManagement/doBusiness/expressAdminUpdate','2018-04-24 15:40:55'),(366,'收件信息添加','/customerManagement/save/express','2018-03-02 14:58:41'),(367,'收件信息查看','/customerManagement/view/express/{id}','2018-03-02 15:27:04'),(368,'收件信息查询','/customerManagement/unlimitedQuery/express','2018-03-02 15:27:04'),(369,'收件信息复杂查询','/customerManagement/unlimitedComplexQuery/express','2018-03-02 15:27:04'),(370,'收件信息建议','/customerManagement/unlimitedSuggest/express/{properties}/{word}','2018-03-02 15:27:04'),(371,'收件信息修改','/customerManagement/update/express','2018-03-02 15:27:04');

#
# Structure for table "hzg_sys_user"
#

DROP TABLE IF EXISTS `hzg_sys_user`;
CREATE TABLE `hzg_sys_user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `gender` varchar(6) DEFAULT NULL COMMENT '性别：男，女',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) DEFAULT NULL COMMENT 'md5加密过的密码',
  `email` varchar(30) DEFAULT NULL COMMENT 'email地址',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  `passModifyDate` datetime DEFAULT NULL COMMENT '密码修改时间',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:使用，1:注销',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机号',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='后台用户表';

#
# Data for table "hzg_sys_user"
#

INSERT INTO `hzg_sys_user` (`Id`,`name`,`gender`,`username`,`password`,`email`,`inputDate`,`passModifyDate`,`state`,`mobile`) VALUES (26,'信息管理员','male','admin','FCEA920F7412B5DA7BE0CF42B8C93759','it@hzg.com','2017-05-03 15:53:28',NULL,0,NULL),(29,'采购员','male','purchase','FCEA920F7412B5DA7BE0CF42B8C93759','purchase@hzg.com','2017-05-31 15:32:18',NULL,0,NULL),(30,'掌柜','male','zhangui','FCEA920F7412B5DA7BE0CF42B8C93759','zhangui@hzg.com','2017-06-19 15:35:32',NULL,0,NULL),(31,'仓储','male','cangchu','FCEA920F7412B5DA7BE0CF42B8C93759','canchu@hzg.com','2017-06-19 15:37:58',NULL,0,NULL),(32,'摄影','male','sheying','FCEA920F7412B5DA7BE0CF42B8C93759','sheying@hzg.com','2017-06-19 15:39:27',NULL,0,NULL),(33,'编辑','male','bianji','FCEA920F7412B5DA7BE0CF42B8C93759','bianji@hzg.com','2017-06-19 15:42:09',NULL,0,NULL),(34,'库管员','male','kuguan','FCEA920F7412B5DA7BE0CF42B8C93759','kuguan@hzg.com','2017-06-30 14:28:46',NULL,0,NULL),(35,'财务','male','caiwu','FCEA920F7412B5DA7BE0CF42B8C93759','caiwu@hzg.com','2017-07-03 14:00:37',NULL,0,NULL),(36,'采购一','male','purchase1','FCEA920F7412B5DA7BE0CF42B8C93759','purchase@hzg.com','2017-07-07 11:51:31',NULL,0,NULL),(37,'仓储一','male','cangchu1','FCEA920F7412B5DA7BE0CF42B8C93759','cangchu1@hzg.com','2017-07-20 10:38:28',NULL,0,NULL),(38,'销售','female','xiaoshou','FCEA920F7412B5DA7BE0CF42B8C93759','xiaoshou@hzg.com','2017-08-30 11:06:08',NULL,0,NULL),(39,'销售主管','male','saleCharger','FCEA920F7412B5DA7BE0CF42B8C93759','saleCharger@hzg.com','2017-08-30 17:25:05',NULL,0,NULL),(40,'销售总监','male','saleDirector','FCEA920F7412B5DA7BE0CF42B8C93759','saleDirector@hzg.com','2017-12-19 11:10:44',NULL,0,'18210031001'),(41,'销售经理','male','saleManager','FCEA920F7412B5DA7BE0CF42B8C93759','saleManager@hzg.com','2018-03-27 10:47:33',NULL,0,'12345678901'),(42,'张三','male','caiwuzj','FCEA920F7412B5DA7BE0CF42B8C93759','caiwuzj@hzg.com','1970-01-04 09:12:09',NULL,0,'18356743678'),(43,'财务总监','female','caiwuDirector','FCEA920F7412B5DA7BE0CF42B8C93759','caiwuDirector@hong6.com','2018-04-14 16:09:35',NULL,0,'18014630004');

#
# Structure for table "hzg_sys_userpost_relation"
#

DROP TABLE IF EXISTS `hzg_sys_userpost_relation`;
CREATE TABLE `hzg_sys_userpost_relation` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  `postId` int(11) DEFAULT NULL COMMENT '岗位id',
  PRIMARY KEY (`Id`),
  KEY `userId` (`userId`),
  KEY `postId` (`postId`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8 COMMENT='用户岗位关联表';

#
# Data for table "hzg_sys_userpost_relation"
#

INSERT INTO `hzg_sys_userpost_relation` (`Id`,`userId`,`postId`) VALUES (134,26,16),(135,26,19),(136,26,20),(142,29,25),(143,30,26),(144,31,22),(145,32,23),(146,33,24),(147,34,27),(148,35,21),(149,36,25),(150,37,22),(151,38,17),(152,39,28),(153,40,30),(155,41,31);