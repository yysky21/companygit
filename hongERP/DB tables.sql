﻿# Host: 127.0.0.1  (Version: 5.5.47)
# Date: 2017-09-01 11:47:33
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;


#
# Structure for table "hzg_action"
# type : '入库出库操作类型: 0:打印商品条码，1:打印出库单，2:打印快递单, 21:生成快递单，3:打印入库单，4:入库，5:出库。商品操作类型: 0:上架商品，1:下架商品。
# 退货操作类型：1:财务确认已退款，3:销售确认可退，31:销售确认不可退，4：销售总监确认可退，41：销售总监确认不可退，5：仓储确认可退，51：仓储确认不可退。
# 换货操作类型：1:财务确认换货完成，3:销售确认要退商品可退，31:销售确认要退商品不可退，4：销售总监确认要退商品可退，41：销售总监确认要退商品不可退，5：仓储确认要退商品可退，51：仓储确认要退商品不可退。
# 修补货品操作类型：1:财务确认修补款已付，3:销售确认可修补，31:销售确认不可修补，4：销售总监确认可修补，41：销售总监确认不可修补，5：仓储确认可修补，51：仓储确认不可修补,6:仓储确认修补完成。
# 订单操作类型:0:取消订单，1:确认订单已支付，2:财务审核通过自助单, 3:确认预订单订金已支付。采购单操作类型：0:确认预订单订金已支付。用户操作类型：0：修改密码,1:重置密码'
#

DROP TABLE IF EXISTS `hzg_action`;
CREATE TABLE `hzg_action` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `entity` varchar(32) DEFAULT NULL COMMENT '业务类型实体：stockInOut 入库出库，product：商品，returnProduct：退货，changeProduct：换货，order：定单，purchase：采购等',
  `entityId` int(11) DEFAULT NULL COMMENT '业务类型实体id：退货单id，换货单id，订单id，采购id等',
  `type` int(2) DEFAULT NULL COMMENT 'see type introduce',
  `inputDate` datetime DEFAULT NULL COMMENT '操作时间',
  `inputerId` int(11) DEFAULT NULL COMMENT '操作人id',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='操作记录表';


/*Table structure for table `hzg_article` */

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
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 COMMENT='文章表';

/*Data for the table `hzg_article` */

insert  into `hzg_article`(`Id`,`cateId`,`title`,`imageUrl`,`content`,`shortContent`,`position`,`hits`,`authorId`,`inputDate`,`state`,`seoTitle`,`seoKeyword`,`seoDesc`) values (59,5,'gfg','http://static.demohzg.com/2017-10-17/article/162147/Hydrangeas.jpg','fadf','fdsf',3,2,26,'2017-10-17 16:22:06',0,'fads','dfs','dfsfsssssssss'),(60,5,'gdfsg','http://static.demohzg.com/2017-10-17/article/163458/Jellyfish.jpg','gdfsgf','fdsg',2,4,26,'2017-10-17 16:35:15',2,'dsfhgf','fdsg','dsfh'),(61,4,'fzfd','http://static.demohzg.com/2017-10-18/article/095615/Hydrangeas.jpg','ffd','dsafd',2,12,26,'2017-10-18 09:56:37',1,'fadf','dfgzdadf','dsgfds'),(62,11,'fdgf','http://static.demohzg.com/2017-10-18/article/182415/Jellyfish.jpg','dfgdaf<img alt=\"\" src=\"http://static.demohzg.com/2017-10-18/article/100823/Chrysanthemum.jpg\" style=\"height:768px; width:1024px\" />fsdagfd','dafdf',3,43,26,'2017-10-18 10:08:34',2,'dafd','dgfd','gdf'),(63,8,'fadf','http://static.demohzg.com/2017-10-18/article/182817/Desert.jpg','dsfd','fdadf',2,3,26,'2017-10-18 10:25:02',0,'fdaff','dsagf','dfdafaaaaaaaaa'),(64,4,'公司大法官','http://static.demohzg.com/2017-10-18/article/134033/Chrysanthemum.jpg','福瑞迪','dfeaw',2,NULL,26,'2017-10-18 13:40:57',1,'FEWAF  ','fsafD','FERFeeeeeeeeeeee'),(65,4,'公司大法官','http://static.demohzg.com/2017-10-18/article/134033/Chrysanthemum.jpg','福瑞迪eeeeeeeee','dfeaw',2,NULL,26,'2017-10-18 13:43:19',2,'FEWAF  ','fsafDFAEWR','FERF'),(66,4,'gdst','http://static.demohzg.com/2017-10-19/article/110318/Koala.jpg','grtsdtg','fdsgrf',1,NULL,26,'2017-10-18 17:03:14',1,'gfdsf','gfsgr','fsgrdffd'),(67,8,'htrdfg','http://static.demohzg.com/2017-10-18/article/171658/Chrysanthemum.jpg','gsert<img alt=\"\" src=\"http://static.demohzg.com/2017-10-20/article/154419/Desert.jpg\" style=\"height:225px; width:300px\" />','gfrtgrt',3,NULL,26,'2017-10-18 17:04:49',0,'grewsgr','fsgvf','err4erf'),(68,5,'xdC','http://static.demohzg.com/2017-10-20/article/144155/Jellyfish.jpg','dfdrrrrrrrrrrrrr','fsdgfzzzzzzzzzzzzzzzzz',1,NULL,26,'2017-10-19 09:32:51',2,'fgfdsg','fdsg','fsg'),(69,7,'gfhg','http://static.demohzg.com/2017-10-19/article/154056/Tulips.jpg','dfdfadsfdsgfddsafd','dfadsfzzzzzzzzzzzz',3,NULL,26,'2017-10-19 14:50:42',1,'fdsaf','dsag','dgafgwwwwwwwwwwww'),(70,4,'gfds','http://static.demohzg.com/2017-10-19/article/162445/Jellyfish.jpg','<span style=\"font-size:10.5pt\"><span style=\"font-family:微软雅黑,sans-serif\">2、<span style=\"color:#df402a\">错误：</span><span style=\"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;\"><span style=\"color:#333333\">Unable to open debugger port (127.0.0.1:51656): java.net.SocketException &quot;socket closed&quot;</span></span></span></span><br />\r\n<span style=\"font-size:10.5pt\"><span style=\"font-family:微软雅黑,sans-serif\"><a name=\"4068-1508151257467\"></a><span style=\"color:#df402a\">可能原因1：</span><span style=\"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;\"><span style=\"color:#333333\">这是由于debugger的端口失效或冲突导致的，IntellJ IDEA会在Tomcat server配置成功后自动为debugger分配端口</span></span></span></span><br />\r\n<span style=\"font-size:10.5pt\"><span style=\"font-family:微软雅黑,sans-serif\"><a name=\"7392-1508152057646\"></a><img alt=\"clipboard.png\" src=\"file:///C:\\Users\\ADMINI~1\\AppData\\Local\\Temp\\msohtmlclip1\\01\\clip_image002.gif\" style=\"height:284px; width:553px\" /></span></span><br />\r\n<span style=\"font-size:10.5pt\"><span style=\"font-family:微软雅黑,sans-serif\"><a name=\"4976-1508151604268\"></a><span style=\"color:#df402a\">解决方法：</span><span style=\"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;\"><span style=\"color:#333333\">先删除 Tomcat server删除之后再重新配置一次Tomcat server，配置成功之后IDEA又会为其自动分配一个新的端口，问题就解决啦。</span></span></span></span><br />\r\n<span style=\"font-size:10.5pt\"><span style=\"font-family:微软雅黑,sans-serif\"><a name=\"7385-1508152085322\"></a><img alt=\"clipboard.png\" src=\"file:///C:\\Users\\ADMINI~1\\AppData\\Local\\Temp\\msohtmlclip1\\01\\clip_image004.gif\" style=\"height:348px; width:553px\" /></span></span><br />\r\n&nbsp;','fdafd',2,NULL,26,'2017-10-19 16:25:44',2,'fsad','dafd','dasfd'),(79,5,'fad','http://static.demohzg.com/2017-10-23/article/114929/Koala.jpg','fsfddd','dfsd',2,NULL,26,'2017-10-20 16:59:05',0,'dfd','fsdeee','fsdddd'),(83,3,'fdd','http://static.demohzg.com/2017-10-23/article/115030/Desert.jpg','dd','dd',1,NULL,26,'2017-10-23 11:51:17',0,'dd','dd','dfd'),(84,2,'fddd','http://static.demohzg.com/2017-10-23/article/131603/Desert.jpg','fdffd','ffafdd',1,NULL,26,'2017-10-23 13:16:46',0,'fad','fa','fafd'),(85,1,'fdad','http://static.demohzg.com/2017-10-23/article/131849/Hydrangeas.jpg','fdafd','fad',1,NULL,26,'2017-10-23 13:19:21',0,'fadf','fadf','fdf'),(86,3,'dsfd','http://static.demohzg.com/2017-10-23/article/132131/Desert.jpg','dfd','fafd',2,NULL,26,'2017-10-23 13:21:52',1,'dd','dad','dadf'),(88,4,'fadfdd','http://static.demohzg.com/2017-10-23/article/132634/Lighthouse.jpg','fafd','fdaf',2,NULL,26,'2017-10-23 13:26:50',0,'fdaf','fdfd','dggh'),(90,4,'hhj','http://static.demohzg.com/2017-10-23/article/132733/Jellyfish.jpg','ghjyh','gfsd',2,NULL,26,'2017-10-23 13:28:44',1,'fdasf','dsafd','fdg'),(92,6,'saddf','http://static.demohzg.com/2017-10-23/article/134135/Chrysanthemum.jpg','fdad','dsafd',1,NULL,26,'2017-10-23 13:41:56',0,'fdasd','fdsafd','dasd'),(93,6,'saddf','http://static.demohzg.com/2017-10-23/article/134135/Chrysanthemum.jpg','fdadfasfd','dsafd',1,NULL,26,'2017-10-23 13:42:00',1,'fdasddf','fdsafd','dasd'),(99,2,'fdsaf','http://static.demohzg.com/2017-10-23/article/140428/Jellyfish.jpg','fafd<img alt=\"\" src=\"http://static.demohzg.com/2017-10-23/article/140442/Tulips.jpg\" style=\"height:225px; width:300px\" />dsafads','fdsafd',2,NULL,26,'2017-10-23 14:05:08',1,'fsdaf','dsfd','adsfd'),(100,2,'dasf','http://static.demohzg.com/2017-10-23/article/140602/Tulips.jpg','fad<img alt=\"\" src=\"http://static.demohzg.com/2017-10-23/article/140620/Desert.jpg\" style=\"height:225px; width:300px\" />','daf',2,NULL,26,'2017-10-23 14:06:25',1,'dafd','fdsafd','dsad'),(101,3,'fas','http://static.demohzg.com/2017-10-23/article/140647/Desert.jpg','fasd','fasdfd',1,NULL,26,'2017-10-23 14:06:57',1,'faf','afdsf','asdf'),(102,5,'fad','http://static.demohzg.com/2017-10-23/article/140712/Tulips.jpg','fdsadfad','fads',1,NULL,26,'2017-10-23 14:11:27',1,'fads','adsfd','dsad'),(103,4,'fafd','http://static.demohzg.com/2017-10-23/article/142905/Jellyfish.jpg','fasfd','fdsafd',2,NULL,26,'2017-10-23 14:29:19',1,'fad','fasdds','fasdf'),(104,3,'dad','http://static.demohzg.com/2017-10-23/article/142933/Hydrangeas.jpg','fdasd','fadssd',2,NULL,26,'2017-10-23 14:30:13',1,'fasd','fad','fdasfd'),(105,5,'fgd','http://static.demohzg.com/2017-10-23/article/145049/Chrysanthemum.jpg','dfad','fdsadf',1,NULL,26,'2017-10-23 14:51:01',1,'fsadf','fad','fsdf'),(106,5,'fdd','http://static.demohzg.com/2017-10-23/article/145258/Tulips.jpg','fsadf','fasd',2,NULL,26,'2017-10-23 14:53:12',1,'fasfd','fasdds','fafd'),(107,5,'fad','http://static.demohzg.com/2017-10-23/article/145649/Desert.jpg','dasds','fasd',1,NULL,26,'2017-10-23 14:57:00',1,'faffd','fsad','dsad'),(108,4,'fdad','http://static.demohzg.com/2017-10-23/article/145747/Desert.jpg','fdf','fafd',2,NULL,26,'2017-10-23 14:58:24',1,'fdads','fafasd','fadsfd'),(109,5,'fasdf','http://static.demohzg.com/2017-10-23/article/150049/Desert.jpg','fafd','fasfd',1,NULL,26,'2017-10-23 15:01:07',1,'fas','fasdds','fdsafd'),(110,4,'fasd','http://static.demohzg.com/2017-10-23/article/150142/Desert.jpg','fsadfd','dasf',2,NULL,26,'2017-10-23 15:02:06',1,'fdsad','dsf','sdaf'),(111,4,'fasd','http://static.demohzg.com/2017-10-23/article/150142/Desert.jpg','fsadfd','dasf',2,NULL,26,'2017-10-23 15:02:24',1,'fdsad','dsf','s4rq4gt'),(112,1,'fadf','http://static.demohzg.com/2017-10-23/article/150252/Desert.jpg','fdsafd','dasfd',1,NULL,26,'2017-10-23 15:03:09',1,'fasdfd','fsdf','dsafd'),(113,1,'fdf','http://static.demohzg.com/2017-10-23/article/151242/Desert.jpg','fafd','fasd',2,NULL,26,'2017-10-23 15:13:08',1,'fasdf','fdsfd','fafd'),(114,3,'fasd','http://static.demohzg.com/2017-10-23/article/151946/Chrysanthemum.jpg','fsasdfdafds','fdsafd',1,NULL,26,'2017-10-23 15:20:20',0,'fasd','fasdds','fasfd'),(115,3,'fdads','http://static.demohzg.com/2017-10-23/article/152928/Hydrangeas.jpg','fad','fafdaf',1,NULL,26,'2017-10-23 15:29:42',1,'fad','fadfd','fad'),(116,3,'fafd','http://static.demohzg.com/2017-10-23/article/154625/Desert.jpg','fadffaf','fsdafd',1,NULL,26,'2017-10-23 15:47:04',2,'fad','fafd','fafd'),(117,2,'fasd','http://static.demohzg.com/2017-10-23/article/154712/Hydrangeas.jpg','fasd<img alt=\"\" src=\"http://static.demohzg.com/2017-10-23/article/154733/Hydrangeas.jpg\" style=\"height:768px; width:1024px\" />','fasd',2,NULL,26,'2017-10-23 15:47:42',1,'fafd','fadf','dasgtarewrfe'),(118,2,'fafd','http://static.demohzg.com/2017-10-23/article/155446/Hydrangeas.jpg','fasfd<img alt=\"\" src=\"http://static.demohzg.com/2017-10-23/article/155459/Koala.jpg\" style=\"height:150px; width:200px\" />','ffasd',2,NULL,26,'2017-10-23 15:55:10',2,'fdsad','fdsads','dsadf'),(119,3,'sdd','http://static.demohzg.com/2017-10-23/article/172055/Desert.jpg','fdds','fad',2,NULL,26,'2017-10-23 17:21:22',1,'fdaff','fdd','fgfg'),(120,2,'dsfd','http://static.demohzg.com/2017-10-23/article/172625/Hydrangeas.jpg','fsdfd','ffd',1,NULL,26,'2017-10-23 17:26:39',1,'fsfd','dfdf','fdgf'),(121,6,'fdgf','http://static.demohzg.com/2017-10-23/article/173318/Jellyfish.jpg','zfdf','dfd',1,NULL,26,'2017-10-23 17:33:38',0,'fdf','adf','fdsa'),(122,6,'fdgf','http://static.demohzg.com/2017-10-23/article/173318/Jellyfish.jpg','zfdf','dfd',1,NULL,26,'2017-10-23 17:33:42',1,'fdf','adf','fdsa');

/*Table structure for table `hzg_article_cate` */

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='文章分类表';

/*Data for the table `hzg_article_cate` */

insert  into `hzg_article_cate`(`Id`,`parentId`,`name`,`nickname`,`articleTitle`,`articleKeyword`,`articleDesc`,`inputDate`) values (1,NULL,'fadf','dff','fdf','fdgff','fgsds','2017-10-18 09:57:32'),(2,4,'美国职业篮球联赛','NBA','NNNN','BBBB','AAAA','2017-10-18 09:57:32'),(3,NULL,'发的','发的','东方红如果','凤飞飞','辅导费','2017-10-18 09:57:32'),(4,NULL,'体育','sports','体育','体育','世界性运动','2017-10-18 09:57:32'),(5,NULL,'多发点','答复','发的','发大水','法撒旦','2017-10-18 09:57:32'),(6,NULL,'肥嘟嘟','发发呆','凡人歌','frere','烦人','2017-10-18 09:57:32'),(7,NULL,'财经','economics','财经','财经','中国经济飞速发展','2017-10-18 09:57:32'),(8,4,'大幅度的','大范甘迪','肥嘟嘟','放的地方','东方饭店','2017-10-18 09:57:32'),(9,4,'中国职业篮球联赛','CBA','CCCCCC','BBBBB','AAAAA','2017-10-18 09:57:32'),(10,NULL,'asdfd','dfafda','fewegr','fdghregr','fdgare','2017-10-18 09:57:32'),(11,NULL,'qaqaqaqaqaqaqaqa','dfafda','fewegr','fdghregr','fdgare','2017-10-18 09:57:32'),(12,4,'v刹下载','飞的等发达','等发达','大大','大锅饭的','2017-10-18 09:57:32'),(13,5,'earer','adf','adfd','dafre','werafw','2017-10-18 09:57:32'),(14,5,'earer','adf','adfdewqer','dafrefdasfd','werafwaaaaaaaaaaa','2017-10-18 09:57:32'),(15,4,'agdfg','afdf','dsafdrfewre','adgfddsae','gafdaaa','2017-10-18 09:57:32'),(16,NULL,'fadfg','fgfd','dfadf','fa','fadg','2017-10-19 11:04:23');



#
# Structure for table "hzg_borrowproduct"
#

CREATE TABLE `hzg_borrowproduct` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '借货单号',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:保存，1:申请，2:完成， 3:取消',
  `describes` varchar(60) DEFAULT NULL COMMENT '描述',
  `borrowerId` int(11) DEFAULT NULL COMMENT '借货人id',
  `chargerId` int(11) DEFAULT NULL COMMENT '出借人id',
  `date` datetime DEFAULT NULL COMMENT '借货时间',
  `inputDate` datetime DEFAULT NULL COMMENT '记录生成时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借货表';

#
# Structure for table "hzg_borrowproduct_detail"
#

CREATE TABLE `hzg_borrowproduct_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编码',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '单位,如：件、只、双、条、枚、副、克、克拉',
  `borrowProductId` int(11) DEFAULT NULL COMMENT '借货单id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='借货表明细';

#
# Structure for table "hzg_borrowproduct_detail_product"
#

CREATE TABLE `hzg_borrowproduct_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowProductDetailId` int(11) DEFAULT NULL COMMENT '借货单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='借货明细对应商品表';

#
# Structure for table "hzg_borrowproduct_return"
#

CREATE TABLE `hzg_borrowproduct_return` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '还货单号',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:保存，1:申请，2:完成， 3:取消，4:已还，5:部分已还',
  `describes` varchar(60) DEFAULT NULL COMMENT '描述',
  `returnerId` int(11) DEFAULT NULL COMMENT '还货人id',
  `chargerId` int(11) DEFAULT NULL COMMENT '收货人id',
  `date` datetime DEFAULT NULL COMMENT '还货时间',
  `inputDate` datetime DEFAULT NULL COMMENT '记录生成时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='还货表';

#
# Structure for table "hzg_borrowproduct_return_detail"
#

CREATE TABLE `hzg_borrowproduct_return_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编码',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '单位,如：件、只、双、条、枚、副、克、克拉',
  `borrowDetailId` int(11) NOT NULL DEFAULT '0' COMMENT '对应借货明细id',
  `borrowProductReturnId` int(11) NOT NULL DEFAULT '0' COMMENT '还货单id',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:已借，1:已还，2:部分已还',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='还货表明细';

#
# Structure for table "hzg_borrowproduct_return_detail_product"
#

CREATE TABLE `hzg_borrowproduct_return_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowProductReturnDetailId` int(11) DEFAULT NULL COMMENT '还货单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='还货明细对应商品表';



#
# Structure for table "hzg_changeproduct"
#

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='换货表';


#
# Structure for table "hzg_changeproduct_detail"
#

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='换货明细表';


#
# Structure for table "hzg_changeproduct_detail_product"
#

CREATE TABLE `hzg_changeproduct_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `changeProductDetailId` int(11) DEFAULT NULL COMMENT '换货单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='换货明细对应商品表';



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
# Data for table "hzg_config"
#


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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='客户';


#
# Data for table "hzg_customer"
#


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户级别表';

#
# Data for table "hzg_customer_degree"
#


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户收货地址表';

#
# Data for table "hzg_customer_express"
#


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
  PRIMARY KEY (`Id`),
  KEY `customerId` (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

#
# Data for table "hzg_customer_user"
#


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
# Data for table "hzg_customer_user_point"
#


#
# Structure for table "hzg_express_deliver"
#

DROP TABLE IF EXISTS `hzg_express_deliver`;
CREATE TABLE `hzg_express_deliver` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(20) DEFAULT NULL COMMENT '快递单号',
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
  `inputDate` datetime DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `no` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='快递单表';



#
# Structure for table "hzg_express_deliver_detail"
#

DROP TABLE IF EXISTS `hzg_express_deliver_detail`;
CREATE TABLE `hzg_express_deliver_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productNo` int(11) DEFAULT NULL COMMENT '快递货物对应商品no',
  `quantity` float(8,2) DEFAULT NULL COMMENT '货物数量',
  `unit` varchar(8) DEFAULT NULL COMMENT '货物单位',
  `weight` float(9,2) DEFAULT NULL COMMENT '货物重量,单位 kg',
  `price` varchar(32) DEFAULT NULL COMMENT '货物单价',
  `state` int(1) DEFAULT NULL COMMENT '快递状态，快递状态，0:未发送，1：已发送， 2：已收货，3：收货失败',
  `expressDeliverId` int(11) DEFAULT NULL COMMENT '快递单id',
  `mailNo` varchar(64) DEFAULT NULL COMMENT '快递公司内部使用的快递运单号',
  `insure` varchar(32) DEFAULT NULL COMMENT '货物保价',
  `setting` varchar(2) DEFAULT NULL COMMENT '顺丰丰桥配置信息 key',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='快递单表详情单';


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购明细表';


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
# Data for table "hzg_job"
#


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
# Data for table "hzg_keyword"
#


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
# Data for table "hzg_money_account"
#

INSERT INTO `hzg_money_account` VALUES (3,'6245 3535 3543 5354 555','招商银行',30,'招商银行昆明人民中路支行',6650165.00,'2017-07-06 10:50:57'),(4,'6233 5675 3378 9776 902','交通用户',30,'交通银行昆明永昌支行',5881982.00,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8 COMMENT='支付记录';


#
# Data for table "hzg_money_pay"
#


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
  `entity` varchar(32) DEFAULT NULL COMMENT '单据类型：returnProduct:退货，purchaseDeposit:押金采购退货等',
  `entityId` int(11) DEFAULT NULL COMMENT '单据id',
  `entityNo` varchar(16) DEFAULT NULL COMMENT '单据编号',
  `balanceType` int(1) DEFAULT NULL COMMENT '收支类型：0:支出，1:收入',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='退款';


#
# Data for table "hzg_money_refund"
#


#
# Structure for table "hzg_order"
#

DROP TABLE IF EXISTS `hzg_order`;
CREATE TABLE `hzg_order` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(16) DEFAULT NULL COMMENT '订单号',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:未支付，1:已支付，2:取消，3：已退款， 4：财务确认已支付， 5：部分退款',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单';

#
# Data for table "hzg_order"
#


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预订单';

#
# Data for table "hzg_order_book"
#


#
# Structure for table "hzg_order_changeproduct"
#

DROP TABLE IF EXISTS `hzg_order_changeproduct`;
CREATE TABLE `hzg_order_changeproduct` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderDetailId` int(11) DEFAULT NULL COMMENT '订单明细id',
  `priceDiff` varchar(32) DEFAULT NULL COMMENT '换货差价（被换商品总价-要换商品总价）',
  `newId` int(11) DEFAULT NULL COMMENT '要换商品id',
  `newQuantity` float(8,2) DEFAULT NULL COMMENT '要换商品数量',
  `newUnit` varchar(8) DEFAULT NULL COMMENT '要换货计量单位',
  `reason` varchar(60) DEFAULT NULL COMMENT '换货原因',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:申请，1:已换，2:不能换货',
  `oldQuantity` float(8,2) DEFAULT NULL COMMENT '被换商品数量',
  `oldUnit` varchar(8) DEFAULT NULL COMMENT '被换货计量单位',
  `date` datetime DEFAULT NULL COMMENT '换货时间',
  `userId` int(11) DEFAULT NULL COMMENT '换货人id',
  `inputDate` datetime DEFAULT NULL COMMENT '换货记录生成时间',
  PRIMARY KEY (`Id`),
  KEY `orderDetailId` (`orderDetailId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='换货';

#
# Data for table "hzg_order_changeproduct"
#


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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='订单商品明细';


#
# Data for table "hzg_order_detail"
#


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单明细对应商品列表';


#
# Structure for table "hzg_order_gift"
#

DROP TABLE IF EXISTS `hzg_order_gift`;
CREATE TABLE `hzg_order_gift` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) DEFAULT NULL COMMENT '订单id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '赠品no（商品no）',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量',
  `unit` varchar(6) DEFAULT NULL COMMENT '计量单位',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='销售赠品';


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单赠品对应商品列表';


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品加工，私人订制表';

#
# Data for table "hzg_order_private"
#


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='私人订制配饰';


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单私人订制配饰对应商品列表';


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品加工，私人订制表金额核定';

#
# Data for table "hzg_order_private_authorize"
#


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
# Data for table "hzg_order_receivedapply"
#


#
# Structure for table "hzg_order_repair"
#

DROP TABLE IF EXISTS `hzg_order_repair`;
CREATE TABLE `hzg_order_repair` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderDetailId` int(11) DEFAULT NULL COMMENT '订单明细id',
  `inputDate` datetime DEFAULT NULL COMMENT '记录生成时间',
  `quantity` float(8,2) DEFAULT NULL COMMENT '修补数量',
  `amount` varchar(32) DEFAULT NULL COMMENT '修补金额',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:申请，1:已修补，2:不能修补',
  `describe` varchar(60) DEFAULT NULL COMMENT '修补描述',
  `date` datetime DEFAULT NULL COMMENT '修补时间',
  `userId` varchar(255) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`Id`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户修补申请';

#
# Data for table "hzg_order_repair"
#


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退货表';


#
# Data for table "hzg_returnproduct"
#


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='退货明细表';


#
# Structure for table "hzg_returnproduct_detail_product"
#

DROP TABLE IF EXISTS `hzg_returnproduct_detail_product`;
CREATE TABLE `hzg_order_returnproduct_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `returnProductDetailId` int(11) DEFAULT NULL COMMENT '退货单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='退货明细对应商品表';


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
  `describe` varchar(60) DEFAULT NULL COMMENT '修补货品描述',
  `userId` int(11) DEFAULT NULL COMMENT '修补人id',
  `state` int(2) DEFAULT NULL COMMENT '状态，0:申请，1:已付款，2:取消，3:销售确认可修补，31:销售确认不可修补，4：销售总监确认可修补，41：销售总监确认不可修补，5：仓储确认可修补，51：仓储确认不可修补,6:修补完成',
  `date` datetime DEFAULT NULL COMMENT '修补时间',
  `inputDate` datetime DEFAULT NULL COMMENT '修补申请时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='修补货品表';

#
# Data for table "hzg_repairproduct"
#


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='修补货品明细表';

#
# Data for table "hzg_repairproduct_detail"
#


#
# Structure for table "hzg_repairproduct_detail_product"
#

DROP TABLE IF EXISTS `hzg_repairproduct_detail_product`;
CREATE TABLE `hzg_repairproduct_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `repairProductDetailId` int(11) DEFAULT NULL COMMENT '修补单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='修补货品明细对应商品表';

#
# Data for table "hzg_repairproduct_detail_product"
#


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
  `state` int(2) DEFAULT NULL COMMENT '状态，0:采购，10:采购审核通过，11:采购完成，1:入库，12:部分入库，2:出库，21：部分出库，3:在售，4:已售，41:部分已售，5:无效, 6:编辑状态,7:多媒体文件已上传,8:已发货,81:部分发货，82:申请采购退货，83：采购退货完成，84：部分申请采购退货，85：部分采购退货完成，86:申请修补,87:已修补,88:部分申请修补，89：部分申请修补完成，9:申请退货，91:已退货，92:申请换货，93:已换货,94:部分申请退货，95:部分已退货，96:部分申请换货，97:部分已换货，98:换货申请退货，99:换货部分申请退货',
  `supplierId` int(11) DEFAULT NULL COMMENT '供货商ID',
  `describeId` int(11) DEFAULT NULL COMMENT '商品描述表ID',
  `costPrice` varchar(32) DEFAULT NULL COMMENT '采购成本价，加密价格后的字符串',
  `unitPrice` varchar(32) DEFAULT NULL COMMENT '单价(采购成本价/采购数量*记录单位)，加密价格后的字符串',
  `useType` varchar(12) DEFAULT NULL COMMENT '用途类型,product：商品，acc：配饰，materials：加工材料',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8 COMMENT='商品信息';

#
# Data for table "hzg_product"
#


#
# Structure for table "hzg_product_borrowreturn"
#

DROP TABLE IF EXISTS `hzg_product_borrowreturn`;
CREATE TABLE `hzg_product_borrowreturn` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  `inputDate` datetime DEFAULT NULL COMMENT '记录生成时间',
  `quantity` float(8,2) DEFAULT NULL COMMENT '商品数量',
  `unit` varchar(6) DEFAULT NULL COMMENT '计量单位',
  `state` int(1) DEFAULT NULL COMMENT '状态，0:申请，1:完成，2:失败',
  `type` varchar(2) DEFAULT NULL COMMENT '类型：借货，还货',
  `describe` varchar(60) DEFAULT NULL COMMENT '描述',
  `chargerId` int(11) DEFAULT NULL COMMENT '借换人id',
  PRIMARY KEY (`Id`),
  KEY `backUserId` (`chargerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借换货记录';

#
# Data for table "hzg_product_borrowreturn"
#


#
# Structure for table "hzg_product_check"
#

DROP TABLE IF EXISTS `hzg_product_check`;

CREATE TABLE `hzg_product_check` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `checkDate` datetime DEFAULT NULL COMMENT '盘点日期',
  `checkNo` varchar(15) DEFAULT NULL COMMENT '盘点单据编号',
  `warehouseId` int(11) unsigned DEFAULT NULL COMMENT '盘点仓储id',
  `deptId` int(11) unsigned DEFAULT NULL COMMENT '盘点部门id',
  `quantity` float(8,2) DEFAULT NULL COMMENT '盈亏总数量',
  `amount` varchar(32) DEFAULT NULL COMMENT '盈亏总金额',
  `chartMakerId` int(11) unsigned DEFAULT NULL COMMENT '制单人id',
  `companyId` int(11) unsigned DEFAULT NULL COMMENT '公司id',
  `remark` varchar(150) DEFAULT NULL COMMENT '备注',
  `state` int(1) DEFAULT NULL COMMENT '状态（0:保存/1:盘点）',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=368 DEFAULT CHARSET=utf8 COMMENT='商品盘点';

#
# Data for table "hzg_product_check"
#


#
# Structure for table "hzg_product_check_detail"
#

DROP TABLE IF EXISTS `hzg_product_check_detail`;

CREATE TABLE `hzg_product_check_detail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) unsigned DEFAULT NULL COMMENT '商品id',
  `checkId` int(11) unsigned DEFAULT NULL COMMENT '盘点单id',
  `itemNo` varchar(15) DEFAULT NULL COMMENT '存货编码',
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
) ENGINE=InnoDB AUTO_INCREMENT=1042 DEFAULT CHARSET=utf8 COMMENT='商品盘点明细表';

#
# Data for table "hzg_product_check_detail"
#


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
# Data for table "hzg_product_count"
#


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
# Data for table "hzg_product_damage"
#


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
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8 COMMENT='商品描述';


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
# Data for table "hzg_product_norelate"
#


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
) ENGINE=InnoDB AUTO_INCREMENT=1784 DEFAULT CHARSET=utf8 COMMENT='商品属性表';


#
# Structure for table "hzg_product_price_change"
#

DROP TABLE IF EXISTS `hzg_product_price_change`;
CREATE TABLE `hzg_product_price_change` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(6) DEFAULT NULL COMMENT '价格变动码',
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='商品销售价格变动表';


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
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8 COMMENT='商品属性表';

#
# Data for table "hzg_product_property"
#

INSERT INTO `hzg_product_property` VALUES (1,'镶嵌材质','18K',NULL),(2,'镶嵌材质','14K',NULL),(3,'镶嵌材质','9K',NULL),(4,'种水','玻璃种',NULL),(5,'种水','高冰种',NULL),(6,'种水','冰种',NULL),(7,'种水','糯冰种',NULL),(8,'种水','糯种',NULL),(9,'种水','豆种',NULL),(10,'种水','花青种',NULL),(11,'种水','干青种',NULL),(12,'种水','油青种',NULL),(13,'颜色','无色',NULL),(14,'颜色','白色',NULL),(15,'颜色','浅绿',NULL),(16,'颜色','阳绿',NULL),(17,'颜色','翠绿',NULL),(18,'颜色','深绿',NULL),(19,'颜色','暗绿',NULL),(20,'颜色','蓝绿',NULL),(21,'颜色','蓝水',NULL),(22,'颜色','灰绿',NULL),(23,'颜色','紫罗兰',NULL),(24,'颜色','红翡',NULL),(25,'颜色','黄翡',NULL),(26,'颜色','俏色',NULL),(27,'颜色','多宝',NULL),(28,'颜色','飘花',NULL),(29,'颜色','福绿寿',NULL),(30,'颜色','无',NULL),(31,'种类','翡翠',NULL),(32,'种类','墨翠',NULL),(33,'题材','刻面',NULL),(35,'题材','光面',NULL),(36,'题材','单圈',NULL),(37,'题材','多圈',NULL),(38,'题材','观音',NULL),(39,'题材','关羽',NULL),(40,'题材','弥勒佛',NULL),(41,'题材','大日如来（阿弥陀佛、释迦牟尼佛）',NULL),(42,'题材','大势至',NULL),(43,'题材','普贤',NULL),(44,'题材','地藏王',NULL),(45,'题材','虚空藏',NULL),(46,'题材','不动明王',NULL),(47,'题材','一念之间（半魔半佛）',NULL),(48,'题材','千手观音',NULL),(49,'题材','罗汉',NULL),(50,'题材','子鼠',NULL),(51,'题材','丑牛',NULL),(52,'题材','寅虎',NULL),(53,'题材','卯兔',NULL),(54,'题材','辰龙',NULL),(55,'题材','巳蛇',NULL),(56,'题材','午马',NULL),(57,'题材','未羊',NULL),(58,'题材','申猴',NULL),(59,'题材','酉鸡',NULL),(60,'题材','戌狗',NULL),(61,'题材','亥猪',NULL),(62,'题材','福瓜',NULL),(63,'题材','福豆',NULL),(64,'题材','金枝玉叶（叶子）',NULL),(65,'题材','花开富贵（牡丹）',NULL),(66,'题材','凤凰（吉祥）',NULL),(67,'题材','麒麟（辟邪、吉祥）',NULL),(68,'题材','招财进宝（金蟾）',NULL),(69,'题材','貔貅（财富）',NULL),(70,'题材','龙龟（荣归）',NULL),(71,'题材','囚牛（立于琴头）',NULL),(72,'题材','睚眦（喜好刀剑）',NULL),(73,'题材','蒲牢（立于钟上）',NULL),(74,'题材','狻猊（立于香炉）',NULL),(75,'题材','狴犴（立于衙门）',NULL),(76,'题材','饕餮（立于食盒）',NULL),(77,'题材','螭吻（立于殿脊带鱼尾）',NULL),(78,'题材','椒图（带螺蚌的龙）',NULL),(79,'题材','福寿双全（蝙蝠或桃、铜钱、狐狸、佛手）',NULL),(80,'题材','福禄寿喜（蝙蝠、鹿、桃、喜）',NULL),(81,'题材','福禄寿（蝙蝠、鹿、桃）',NULL),(82,'题材','福从天降（蝙蝠、小孩、南瓜）',NULL),(83,'题材','福禄（葫芦）',NULL),(84,'题材','终身有福（钟和蝙蝠）',NULL),(85,'题材','五福临门（五只蝙蝠）',NULL),(86,'题材','流云百福（云和蝙蝠）',NULL),(87,'题材','福在眼前（蝙蝠和铜钱）',NULL),(88,'题材','洪福齐天（蝙蝠、猴子和桃）',NULL),(89,'题材','喜上眉梢（喜鹊）',NULL),(90,'题材','三阳开泰（三只羊）',NULL),(91,'题材','如意（林芝）',NULL),(92,'题材','弯弯顺（虾）',NULL),(93,'题材','平安扣',NULL),(94,'题材','丹凤朝阳（凤凰、牡丹、太阳、梧桐树）',NULL),(95,'题材','龙凤呈祥（龙和凤）',NULL),(96,'题材','喜从天降（蜘蛛网和蜘蛛）',NULL),(97,'题材','知足常乐（蜘蛛）',NULL),(98,'题材','寿桃',NULL),(99,'题材','禅悟',NULL),(100,'题材','鱼跃龙门',NULL),(101,'题材','金玉满堂（金鱼）',NULL),(102,'题材','年年有余（荷叶和鱼）',NULL),(103,'题材','一鸣惊人（蝉）',NULL),(104,'题材','大展宏图（鹰）',NULL),(105,'题材','英雄斗志（鹰、熊）',NULL),(106,'题材','长寿龟',NULL),(107,'题材','龙马精神（龙和马）',NULL),(108,'题材','一品当朝（鹤）',NULL),(109,'题材','松鹤延年（松和鹤）',NULL),(110,'题材','钟馗',NULL),(111,'题材','达摩',NULL),(112,'题材','狮子',NULL),(113,'题材','虎虎生威（虎）',NULL),(114,'题材','财神（赵公明）',NULL),(115,'题材','黄财神（藏传佛教）',NULL),(116,'题材','大黑天（藏传佛教）',NULL),(117,'题材','绿度母（藏传佛教）',NULL),(118,'题材','官上加官（公鸡、鸡冠花）',NULL),(119,'题材','高官厚禄（鸡和鹿）',NULL),(120,'题材','加官授禄（鹿）',NULL),(121,'题材','路路顺利（两只鹿）',NULL),(122,'题材','鹤鹿回春（鹤和鹿）',NULL),(123,'题材','封侯挂印（猴和印章）',NULL),(124,'题材','辈辈封侯（大猴背小猴）',NULL),(125,'题材','马上封侯（马和猴）',NULL),(126,'题材','长命富贵（如意锁）',NULL),(127,'题材','望子成龙（一大一小动物）',NULL),(128,'题材','平安如意（瓶子、鹌鹑）',NULL),(129,'题材','事事如意（柿子和如意）',NULL),(130,'题材','二龙戏珠',NULL),(131,'题材','万象升平（象和瓶）',NULL),(132,'题材','吉祥如意（云、象、林芝、雄鸡）',NULL),(133,'题材','必定如意（笔）',NULL),(134,'题材','连升三级（三只鸡或三叉戟）',NULL),(135,'题材','嫦娥奔月',NULL),(136,'题材','四海升平（海水、四个小孩、瓶子）',NULL),(137,'题材','多子多福（许多果实、石榴、葡萄、莲子、花生、玉米）',NULL),(138,'题材','八仙过海',NULL),(139,'题材','独占鳌头（鳖）',NULL),(140,'题材','琴棋书画',NULL),(141,'题材','伯牙摔琴（人物、琴、墓碑）',NULL),(142,'题材','天女散花（仙女、花）',NULL),(143,'题材','踏雪寻梅（老人、风雪、梅花、骑驴）',NULL),(144,'题材','鹤寿龟龌（鹤和龟）',NULL),(145,'题材','百财（白菜）',NULL),(146,'题材','红红火火（辣椒）',NULL),(147,'题材','长寿（茄子、桃）',NULL),(148,'题材','岁岁平安（麦穗）',NULL),(149,'题材','节节高升（竹子）',NULL),(150,'题材','佳偶天成（莲藕）',NULL),(151,'题材','聪明伶俐（菱角）',NULL),(152,'题材','傲骨长存（梅花）',NULL),(153,'题材','百年好合（百合）',NULL),(154,'题材','品性高洁（兰花）',NULL),(155,'题材','辟邪进宝（海螺、葫芦）',NULL),(156,'题材','甲天下（蝎子、甲虫）',NULL),(157,'题材','蝴蝶（爱情）',NULL),(158,'题材','五子登科（五只小鸡）',NULL),(159,'题材','天鹅（忠诚、高贵、纯洁）',NULL),(160,'题材','八方来财（螃蟹）',NULL),(161,'题材','壁虎（庇护、必得幸福）',NULL),(162,'题材','百鸟嘲凤（百鸟图）',NULL),(163,'题材','欢欢喜喜（獾）',NULL),(164,'题材','后羿射日',NULL),(165,'题材','女娲补天',NULL),(166,'题材','寿星',NULL),(167,'题材','老子',NULL),(168,'题材','孔子',NULL),(169,'题材','侍女（胸怀博大）',NULL),(170,'题材','天使',NULL),(171,'题材','渔翁得利',NULL),(172,'题材','刘海戏金蟾',NULL),(173,'题材','福星高照（三位老神仙）',NULL),(174,'题材','群仙祝寿（多位仙人手持礼物）',NULL),(175,'题材','把把胡（茶壶）',NULL),(176,'题材','青云直上（风筝）',NULL),(177,'题材','一路平安（鹭鸶、瓶、鹌鹑）',NULL),(178,'题材','一路富贵（鹭鸶和牡丹）',NULL),(179,'题材','一路联科（鹭鸶、荷叶、桂圆）',NULL),(180,'题材','堂上双白（海棠、两位老人）',NULL),(181,'题材','指日高升（官人指太阳）',NULL),(182,'题材','升官发财（龙、猴子）',NULL),(183,'题材','生意兴隆（花生、龙）',NULL),(184,'题材','喜事连连（柿子、喜鹊）',NULL),(185,'题材','称心如意（柿子和桃、秤砣）',NULL),(186,'题材','连中三元（三支喜鹊、三个元宝、三个桂圆、三颗豆子）',NULL),(187,'题材','麻姑献寿（仙女、桃）',NULL),(188,'题材','如意封侯（猴子和如意）',NULL),(189,'题材','福如东海（蝙蝠、海、日出}',NULL),(190,'题材','福寿齐眉（蝙蝠、桃、梅花、荸荠）',NULL),(191,'题材','稳稳升侯（大象和猴子）',NULL),(192,'题材','万象跟新（大象和万年青）',NULL),(193,'题材','安居乐业（鹌鹑、菊花）',NULL),(194,'题材','状元及第（龙和小孩、鸭）',NULL),(195,'题材','麒麟送子（麒麟和小孩）',NULL),(196,'题材','送子观音（观音和小孩）',NULL),(197,'题材','五子闹弥勒（五个小孩和弥勒）',NULL),(198,'题材','送财童子（小孩和元宝）',NULL),(199,'题材','童趣（小孩）',NULL),(200,'题材','渔樵耕读（渔夫、樵夫、农夫与书生）',NULL),(201,'题材','和合二仙',NULL),(202,'题材','岁寒三友（竹松梅）',NULL),(203,'题材','亭亭玉立（蜻蜓荷花、玉兰花）',NULL),(204,'题材','苦瓜（苦尽甘来）',NULL),(205,'题材','鸳鸯（夫妻恩爱）',NULL),(206,'题材','孔雀（文明、修养、高管）',NULL),(207,'题材','熊鱼兼得（鱼和熊）',NULL),(208,'题材','八卦（驱邪避凶）',NULL),(209,'题材','八宝（八件宝器）',NULL),(210,'题材','四大神兽（青龙、白虎、朱雀、玄武）',NULL),(211,'题材','金陵十二钗（林黛玉、薛宝钗、贾元春、贾探春、史湘云、妙玉、王',NULL),(212,'题材','五鼠运财（五只老鼠和铜钱）',NULL),(213,'题材','牧童（小孩和牛）',NULL),(214,'题材','玫瑰花（爱情）',NULL),(217,'题材','无',NULL),(218,'款式','108佛珠',NULL),(219,'款式','吊坠 ',NULL),(220,'款式','戒指',NULL),(221,'款式','耳钉',NULL),(222,'款式','耳坠',NULL),(223,'款式','手把件',NULL),(224,'款式','摆件',NULL),(225,'款式','项链',NULL),(226,'款式','手串',NULL),(227,'款式','手链',NULL),(228,'款式','手环',NULL),(229,'款式','贵妃镯',NULL),(230,'款式','圆镯',NULL),(231,'款式','方镯',NULL),(232,'款式','平安镯',NULL),(233,'款式','扁镯',NULL),(234,'款式','裸石',NULL),(235,'款式','胸针',NULL),(236,'款式','发钗',NULL),(237,'款式','圆珠',NULL),(238,'款式','桶珠',NULL),(239,'款式','鼓珠',NULL),(240,'款式','轮胎珠',NULL),(241,'款式','三通',NULL),(242,'款式','背云',NULL),(243,'款式','套装（两件、三件、四件等',NULL),(244,'透明度','透明',NULL),(245,'透明度','亚透明',NULL),(246,'透明度','半透明',NULL),(247,'透明度','微透明',NULL),(248,'透明度','不透明',NULL),(249,'瑕疵','无瑕',NULL),(250,'瑕疵','微杂',NULL),(251,'瑕疵','微裂',NULL),(252,'瑕疵','微棉',NULL),(253,'瑕疵','石纹',NULL),(254,'瑕疵','有坑',NULL),(255,'瑕疵','填充',NULL),(256,'瑕疵','虫眼',NULL),(257,'瑕疵','白芯',NULL),(258,'雕工','南派',NULL),(259,'雕工','苏派',NULL),(260,'雕工','北派',NULL),(261,'雕工','海派',NULL),(262,'形状','环形',NULL),(263,'形状','星形',NULL),(264,'形状','圆形',NULL),(265,'形状','钩状',NULL),(266,'形状','椭圆',NULL),(267,'形状','方形',NULL),(268,'形状','鼎形',NULL),(269,'形状','卵形',NULL),(270,'形状','三角',NULL),(271,'形状','八角',NULL);

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
# Data for table "hzg_product_show"
#


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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商品分类';

#
# Data for table "hzg_product_type"
#

INSERT INTO `hzg_product_type` VALUES (1,NULL,'蜜蜡','蜜蜡','蜜蜡','蜜蜡','蜜蜡'),(2,1,'红色蜜蜡','红蜡','红色蜜蜡','红色、蜜蜡','红色蜜蜡'),(3,NULL,'翡翠','fc','翡翠','翡翠','翡翠');

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
) ENGINE=InnoDB AUTO_INCREMENT=364 DEFAULT CHARSET=utf8 COMMENT='商品类型属性关联表';

#
# Data for table "hzg_producttypeproperty_relate"
#

INSERT INTO `hzg_producttypeproperty_relate` VALUES (1,3,1),(2,3,2),(3,3,3),(4,3,4),(5,3,5),(6,3,6),(7,3,7),(8,3,8),(9,3,9),(10,3,10),(11,3,11),(12,3,12),(13,3,13),(14,3,14),(15,3,15),(16,3,16),(17,3,17),(18,3,18),(19,3,19),(20,3,20),(21,3,21),(22,3,22),(23,3,23),(24,3,24),(25,3,25),(26,3,26),(27,3,27),(28,3,28),(29,3,29),(30,3,30),(31,3,31),(32,3,32),(33,3,33),(34,3,34),(35,3,35),(36,3,36),(37,3,37),(38,3,38),(39,3,39),(40,3,40),(41,3,41),(42,3,42),(43,3,43),(44,3,44),(45,3,45),(46,3,46),(47,3,47),(48,3,48),(49,3,49),(50,3,50),(51,3,51),(52,3,52),(53,3,53),(54,3,54),(55,3,55),(56,3,56),(57,3,57),(58,3,58),(59,3,59),(60,3,60),(61,3,61),(62,3,62),(63,3,63),(64,3,64),(65,3,65),(66,3,66),(67,3,67),(68,3,68),(69,3,69),(70,3,70),(71,3,71),(72,3,72),(73,3,73),(74,3,74),(75,3,75),(76,3,76),(77,3,77),(78,3,78),(79,3,79),(80,3,80),(81,3,81),(82,3,82),(83,3,83),(84,3,84),(85,3,85),(86,3,86),(87,3,87),(88,3,88),(89,3,89),(90,3,90),(91,3,91),(92,3,92),(93,3,93),(94,3,94),(95,3,95),(96,3,96),(97,3,97),(98,3,98),(99,3,99),(100,3,100),(101,3,101),(102,3,102),(103,3,103),(104,3,104),(105,3,105),(106,3,106),(107,3,107),(108,3,108),(109,3,109),(110,3,110),(111,3,111),(112,3,112),(113,3,113),(114,3,114),(115,3,115),(116,3,116),(117,3,117),(118,3,118),(119,3,119),(120,3,120),(121,3,121),(122,3,122),(123,3,123),(124,3,124),(125,3,125),(126,3,126),(127,3,127),(128,3,128),(129,3,129),(130,3,130),(131,3,131),(132,3,132),(133,3,133),(134,3,134),(135,3,135),(136,3,136),(137,3,137),(138,3,138),(139,3,139),(140,3,140),(141,3,141),(142,3,142),(143,3,143),(144,3,144),(145,3,145),(146,3,146),(147,3,147),(148,3,148),(149,3,149),(150,3,150),(151,3,151),(152,3,152),(153,3,153),(154,3,154),(155,3,155),(156,3,156),(157,3,157),(158,3,158),(159,3,159),(160,3,160),(161,3,161),(162,3,162),(163,3,163),(164,3,164),(165,3,165),(166,3,166),(167,3,167),(168,3,168),(169,3,169),(170,3,170),(171,3,171),(172,3,172),(173,3,173),(174,3,174),(175,3,175),(176,3,176),(177,3,177),(178,3,178),(179,3,179),(180,3,180),(181,3,181),(182,3,182),(183,3,183),(184,3,184),(185,3,185),(186,3,186),(187,3,187),(188,3,188),(189,3,189),(190,3,190),(191,3,191),(192,3,192),(193,3,193),(194,3,194),(195,3,195),(196,3,196),(197,3,197),(198,3,198),(199,3,199),(200,3,200),(201,3,201),(202,3,202),(203,3,203),(204,3,204),(205,3,205),(206,3,206),(207,3,207),(208,3,208),(209,3,209),(210,3,210),(211,3,211),(212,3,212),(213,3,213),(214,3,214),(215,3,215),(216,3,216),(217,3,217),(218,3,218),(219,3,219),(220,3,220),(221,3,221),(222,3,222),(223,3,223),(224,3,224),(225,3,225),(226,3,226),(227,3,227),(228,3,228),(229,3,229),(230,3,230),(231,3,231),(232,3,232),(233,3,233),(234,3,234),(235,3,235),(236,3,236),(237,3,237),(238,3,238),(239,3,239),(240,3,240),(241,3,241),(242,3,242),(243,3,243),(244,3,244),(245,3,245),(246,3,246),(247,3,247),(248,3,248),(249,3,249),(250,3,250),(251,3,251),(252,3,252),(253,3,253),(254,3,254),(255,3,255),(256,3,256),(257,3,257),(258,3,258),(259,3,259),(260,3,260),(261,3,261),(262,3,262),(263,3,263),(264,3,264),(265,3,265),(266,3,266),(267,3,267),(268,3,268),(269,3,269),(270,3,270),(271,3,271),(272,3,272),(273,3,273),(274,3,274),(275,3,275),(276,3,276),(277,3,277),(278,3,278),(279,3,279),(280,3,280),(281,3,281),(282,3,282),(283,3,283),(284,3,284),(285,3,285),(286,3,286),(287,3,287),(288,3,288),(289,3,289),(290,3,290),(291,3,291),(292,3,292),(293,3,293),(294,3,294),(295,3,295),(296,3,296),(297,3,297),(298,3,298),(299,3,299),(300,3,300),(301,3,301),(302,3,302),(303,3,303),(304,3,304),(305,3,305),(306,3,306),(307,3,307),(308,3,308),(309,3,309),(310,3,310),(311,3,311),(312,3,312),(313,3,313),(314,3,314),(315,3,315),(316,3,316),(317,3,317),(318,3,318),(319,3,319),(320,3,320),(321,3,321),(322,3,322),(323,3,323),(324,3,324),(325,3,325),(326,3,326),(327,3,327),(328,3,328),(329,3,329),(330,3,330),(331,3,331),(332,3,332),(333,3,333),(334,3,334),(335,3,335),(336,3,336),(337,3,337),(338,3,338),(339,3,339),(340,3,340),(341,3,341),(342,3,342),(343,3,343),(344,3,344),(345,3,345),(346,3,346),(347,3,347),(348,3,348),(349,3,349),(350,3,350),(351,3,351),(352,3,352),(353,3,353),(354,3,354),(355,3,355),(356,3,356),(357,3,357),(358,3,358),(359,3,359),(360,3,360),(361,3,361),(362,3,362),(363,3,363);

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
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '采购单状态，0:申请,1:完成, 2:作废',
  `amount` float(10,2) DEFAULT NULL COMMENT '采购金额',
  `date` datetime DEFAULT NULL COMMENT '采购时间',
  `inputDate` datetime DEFAULT NULL COMMENT '采购单录入时间',
  `inputerId` int(11) NOT NULL DEFAULT '0' COMMENT '采购单录入人id',
  `describes` varchar(256) DEFAULT NULL COMMENT '采购描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='采购单';


#
# Structure for table "hzg_purchase_book"
#

CREATE TABLE `hzg_purchase_book` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `deposit` varchar(32) DEFAULT NULL COMMENT '订金',
  `payDate` datetime DEFAULT NULL COMMENT '预付订金时间',
  `state` int(1) DEFAULT NULL COMMENT '状态，0：未支付，1：支付完成，2:取消',
  `purchaseId` int(11) DEFAULT NULL COMMENT '采购单id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='临时采购预订单';


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
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 COMMENT='采购明细表';


#
# Structure for table "hzg_purchase_detail_product"
#

CREATE TABLE `hzg_purchase_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseDetailId` int(11) DEFAULT NULL COMMENT '采购单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '关联商品id',
  PRIMARY KEY (`Id`),
  KEY `purchaseDetailId` (`purchaseDetailId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购明细表';


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
# Data for table "hzg_purchase_pricechange"
#


#
# Structure for table "hzg_purchase_returnproduct"
#

DROP TABLE IF EXISTS `hzg_purchase_returnproduct`;
CREATE TABLE `hzg_purchase_returnproduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseDetailId` int(11) DEFAULT NULL COMMENT '采购明细id',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '采购退货单状态，0:申请，1:已退',
  `amount` float(8,2) DEFAULT NULL COMMENT '退货金额',
  `reason` varchar(60) NOT NULL COMMENT '退货原因',
  `applyDate` date NOT NULL COMMENT '申请时间',
  `applyUserId` int(11) NOT NULL COMMENT '申请人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购退货单';

#
# Data for table "hzg_purchase_returnproduct"
#


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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='商品库存信息表';


#
# Structure for table "hzg_stock_changewarehouse"
#

CREATE TABLE `hzg_stock_changewarehouse` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `targetWarehouseId` int(11) DEFAULT NULL COMMENT '调仓目的仓库',
  `state` int(1) DEFAULT NULL COMMENT '0:调仓未完成，1：调仓完成',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='调仓出库';


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
  `type` int(2) DEFAULT NULL COMMENT '类型：0:现金入库，1:代销入库，2:增量入库，3:加工入库，4:押金入库，5:修补入库，51:退货入库, 6:调仓入库，10：虚拟出库，11:系统自动出库，12:报损出库，13:调仓出库,14:内购出库,15:正常出库',
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COMMENT='入库、出库单';


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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='入库出库明细';


#
# Structure for table "hzg_stock_inout_detail_product"
#

CREATE TABLE `hzg_stock_inout_detail_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `stockInOutDetailId` int(11) DEFAULT NULL COMMENT '入库出库单明细id',
  `productId` int(11) DEFAULT NULL COMMENT '关联商品id',
  PRIMARY KEY (`Id`),
  KEY `stockInOutDetailId` (`stockInOutDetailId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='入库出库明细对应商品表';


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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='加工入库、修补入库单';


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
# Data for table "hzg_stock_warehouse"
#

INSERT INTO `hzg_stock_warehouse` VALUES (3,'CK170714010','西苑路仓库','昆明市西山区西苑路2号19楼仓库',31,11,'2017-07-14 12:03:19');

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
# Data for table "hzg_suggest"
#


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
# Data for table "hzg_suggest_cate"
#


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
  `account` varchar(20) NOT NULL COMMENT '付款账号',
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
# Data for table "hzg_supplier"
#

INSERT INTO `hzg_supplier` VALUES (3,'保山市蜜蜡供应公司',1,'A','负责人','云南省保山市开发区建设路2号','0879-12345678','2015-08-20 00:00:00','6212 3456 7891 2345 ','昆明分行人民中路支行','招商银行','[0, 1, 2, 3]',0,29,'2017-06-03 14:35:19','[0, 1]');

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
# Data for table "hzg_supplierproducttype_relation"
#


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
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 COMMENT='办理记录表';


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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

#
# Data for table "hzg_sys_audit_flow"
#

INSERT INTO `hzg_sys_audit_flow` VALUES (16,'商品采购','2017-06-30 13:19:22',0,'purchase',11,'stockInNotify'),(20,'应急/押金/现金采购','2017-07-03 13:26:35',0,'purchaseEmergency',11,'stockInNotifyCaiwu'),(21,'押金入库退还货品提醒流程','2017-07-12 16:26:30',0,'stockInOutDepositCangchu',11,NULL),(22,'押金入库退还押金提醒流程','2017-07-12 16:28:51',0,'stockInOutDepositCaiwu',11,NULL),(27,'商品上架','2017-07-31 13:36:14',0,'product',11,NULL),(29,'提示入库商品','2017-08-03 15:37:35',0,'stockInNotify',11,NULL),(30,'财务提示入库商品','2017-08-22 10:53:43',0,'stockInNotifyCaiwu',11,NULL),(31,'销售员调价申请','2017-08-30 17:17:27',0,'priceChangeSaler',11,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='办理流程节点';

#
# Data for table "hzg_sys_audit_flow_node"
#

INSERT INTO `hzg_sys_audit_flow_node` VALUES (24,'录入采购单',25,26,16,NULL,'purchaseModify'),(25,'总经理审核采购单',26,22,16,'purchaseAuditProductPass',NULL),(26,'仓储复核采购单商品信息',22,NULL,16,'purchaseClose',NULL),(34,'采购员录入采购单',25,26,20,NULL,NULL),(35,'总经理审核采购单',26,21,20,'purchaseEmergencyPass',NULL),(36,'财务审核付款',21,NULL,20,'purchasePayPass',NULL),(37,'仓储入库',27,25,21,NULL,NULL),(38,'采购退货货物',25,NULL,21,NULL,NULL),(39,'仓储入库',27,21,22,NULL,NULL),(40,'财务退还押金',21,NULL,22,'returnDeposit',NULL),(50,'采购人员录入商品信息',25,23,27,NULL,'stockInProductModify'),(51,'摄影人员上传商品多媒体文件',23,24,27,NULL,'productFilesUpload'),(52,'编辑人员审核及上架商品',24,NULL,27,'onSale',NULL),(55,'仓储复核采购的商品信息',22,27,29,NULL,NULL),(56,'提示入库员入库商品',27,NULL,29,NULL,NULL),(57,'财务复核采购的商品信息及采购金额',21,27,30,NULL,NULL),(58,'提示入库员入库商品',27,NULL,30,NULL,NULL),(59,'销售员申请调价',17,28,31,NULL,'priceChangeModify'),(60,'销售主管审核调价申请',28,NULL,31,'priceChangeSetStateUse',NULL);

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

#
# Data for table "hzg_sys_company"
#

INSERT INTO `hzg_sys_company` VALUES (11,'红掌柜珠宝有限公司','0871-1234567','西苑路51号B座','2017-05-03 15:46:23',NULL),(12,'广州分公司','026-1234567','广州','2017-05-03 15:50:20',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='部门表';

#
# Data for table "hzg_sys_dept"
#

INSERT INTO `hzg_sys_dept` VALUES (13,'营销部','0871-2345678','西苑路51号B座','2017-05-03 15:47:47',11,NULL),(14,'市场','0871-3456789','西苑路51号B座','2017-05-03 15:49:42',11,NULL),(15,'财务部','0871-3456789','西苑路51号B座','2017-05-24 09:29:30',11,NULL),(16,'总经理室','0871-1234567','西苑路2号21楼','2017-06-19 15:34:18',11,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='岗位';

#
# Data for table "hzg_sys_post"
#

INSERT INTO `hzg_sys_post` VALUES (16,'信息','2017-05-03 15:48:50',13),(17,'销售员','2017-05-03 15:54:05',14),(19,'新媒体','2017-05-04 13:14:59',13),(20,'竞价','2017-05-04 14:13:22',13),(21,'财务专员','2017-05-24 09:29:58',15),(22,'仓储','2017-05-24 09:30:59',14),(23,'摄影','2017-05-24 09:44:59',14),(24,'编辑','2017-05-24 09:45:12',14),(25,'采购','2017-05-24 09:47:27',14),(26,'总经理','2017-06-19 15:34:43',16),(27,'仓储入库','2017-06-30 14:25:35',14),(28,'销售主管','2017-08-30 17:16:10',14);

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
) ENGINE=InnoDB AUTO_INCREMENT=422 DEFAULT CHARSET=utf8 COMMENT='岗位、权限资源关联表';

#
# Data for table "hzg_sys_privilege_relation"
#

INSERT INTO `hzg_sys_privilege_relation` VALUES (1,16,10,NULL,NULL),(2,16,18,NULL,NULL),(3,16,21,NULL,NULL),(4,16,14,NULL,NULL),(161,16,32,NULL,NULL),(163,16,30,NULL,NULL),(164,16,29,NULL,NULL),(165,16,28,NULL,NULL),(166,16,27,NULL,NULL),(167,16,26,NULL,NULL),(168,16,25,NULL,NULL),(169,16,24,NULL,NULL),(170,16,23,NULL,NULL),(171,16,22,NULL,NULL),(172,16,20,NULL,NULL),(173,16,19,NULL,NULL),(174,16,17,NULL,NULL),(175,16,16,NULL,NULL),(176,16,15,NULL,NULL),(177,16,13,NULL,NULL),(178,16,12,NULL,NULL),(179,16,11,NULL,NULL),(180,16,9,NULL,NULL),(181,16,8,NULL,NULL),(182,16,7,NULL,NULL),(183,16,6,NULL,NULL),(184,16,5,NULL,NULL),(185,16,4,NULL,NULL),(186,16,3,NULL,NULL),(187,16,31,NULL,NULL),(188,16,33,NULL,NULL),(189,16,37,NULL,NULL),(190,16,36,NULL,NULL),(191,16,35,NULL,NULL),(192,16,34,NULL,NULL),(194,22,33,NULL,NULL),(195,21,33,NULL,NULL),(202,16,43,NULL,NULL),(203,16,42,NULL,NULL),(204,16,41,NULL,NULL),(205,16,40,NULL,NULL),(206,16,39,NULL,NULL),(207,16,38,NULL,NULL),(214,16,55,NULL,NULL),(215,16,54,NULL,NULL),(216,16,53,NULL,NULL),(217,16,52,NULL,NULL),(218,16,51,NULL,NULL),(219,16,50,NULL,NULL),(220,16,49,NULL,NULL),(221,16,48,NULL,NULL),(222,16,47,NULL,NULL),(223,16,46,NULL,NULL),(224,16,45,NULL,NULL),(225,16,44,NULL,NULL),(226,25,55,NULL,NULL),(227,25,54,NULL,NULL),(228,25,53,NULL,NULL),(229,25,52,NULL,NULL),(230,25,51,NULL,NULL),(231,25,50,NULL,NULL),(232,25,49,NULL,NULL),(233,25,48,NULL,NULL),(234,25,47,NULL,NULL),(235,25,46,NULL,NULL),(236,25,45,NULL,NULL),(237,25,44,NULL,NULL),(238,16,56,NULL,NULL),(239,25,23,NULL,NULL),(240,25,68,NULL,NULL),(241,25,67,NULL,NULL),(242,25,66,NULL,NULL),(243,25,65,NULL,NULL),(244,25,64,NULL,NULL),(245,25,63,NULL,NULL),(246,25,62,NULL,NULL),(247,25,61,NULL,NULL),(248,25,60,NULL,NULL),(249,25,59,NULL,NULL),(250,25,58,NULL,NULL),(251,25,57,NULL,NULL),(252,16,68,NULL,NULL),(253,16,67,NULL,NULL),(254,16,66,NULL,NULL),(255,16,65,NULL,NULL),(256,16,64,NULL,NULL),(257,16,63,NULL,NULL),(258,16,62,NULL,NULL),(259,16,61,NULL,NULL),(260,16,60,NULL,NULL),(261,16,59,NULL,NULL),(262,16,58,NULL,NULL),(263,16,57,NULL,NULL),(264,25,74,NULL,NULL),(265,25,73,NULL,NULL),(266,25,72,NULL,NULL),(267,25,71,NULL,NULL),(268,25,70,NULL,NULL),(269,25,69,NULL,NULL),(270,25,75,NULL,NULL),(271,26,45,NULL,NULL),(272,22,45,NULL,NULL),(273,25,33,NULL,NULL),(274,27,45,NULL,NULL),(275,21,45,NULL,NULL),(276,27,82,NULL,NULL),(277,27,81,NULL,NULL),(278,27,80,NULL,NULL),(279,27,79,NULL,NULL),(280,27,78,NULL,NULL),(281,27,77,NULL,NULL),(282,27,76,NULL,NULL),(283,16,94,NULL,NULL),(284,16,93,NULL,NULL),(285,16,92,NULL,NULL),(286,16,91,NULL,NULL),(287,16,90,NULL,NULL),(288,16,89,NULL,NULL),(289,21,94,NULL,NULL),(290,21,93,NULL,NULL),(291,21,92,NULL,NULL),(292,21,91,NULL,NULL),(293,21,90,NULL,NULL),(294,21,89,NULL,NULL),(295,21,100,NULL,NULL),(296,21,99,NULL,NULL),(297,21,98,NULL,NULL),(298,21,97,NULL,NULL),(299,21,96,NULL,NULL),(300,21,95,NULL,NULL),(301,16,100,NULL,NULL),(302,16,99,NULL,NULL),(303,16,98,NULL,NULL),(304,16,97,NULL,NULL),(305,16,96,NULL,NULL),(306,16,95,NULL,NULL),(307,16,88,NULL,NULL),(308,16,87,NULL,NULL),(309,16,86,NULL,NULL),(310,16,85,NULL,NULL),(311,16,84,NULL,NULL),(312,16,83,NULL,NULL),(313,16,82,NULL,NULL),(314,16,75,NULL,NULL),(315,16,74,NULL,NULL),(316,16,73,NULL,NULL),(317,16,72,NULL,NULL),(318,16,71,NULL,NULL),(319,16,70,NULL,NULL),(320,16,69,NULL,NULL),(321,27,88,NULL,NULL),(322,27,87,NULL,NULL),(323,27,86,NULL,NULL),(324,27,85,NULL,NULL),(325,27,84,NULL,NULL),(326,27,83,NULL,NULL),(327,27,67,NULL,NULL),(328,27,66,NULL,NULL),(329,27,65,NULL,NULL),(330,27,64,NULL,NULL),(331,27,63,NULL,NULL),(332,27,48,NULL,NULL),(333,27,47,NULL,NULL),(334,25,103,NULL,NULL),(335,25,102,NULL,NULL),(336,27,105,NULL,NULL),(337,27,104,NULL,NULL),(338,22,111,NULL,NULL),(339,22,110,NULL,NULL),(340,22,109,NULL,NULL),(341,22,108,NULL,NULL),(342,22,107,NULL,NULL),(343,22,106,NULL,NULL),(344,16,111,NULL,NULL),(345,16,110,NULL,NULL),(346,16,109,NULL,NULL),(347,16,108,NULL,NULL),(348,16,107,NULL,NULL),(349,16,106,NULL,NULL),(350,16,105,NULL,NULL),(351,16,104,NULL,NULL),(352,16,103,NULL,NULL),(353,16,102,NULL,NULL),(355,22,19,NULL,NULL),(356,27,111,NULL,NULL),(357,21,87,NULL,NULL),(358,25,87,NULL,NULL),(359,27,112,NULL,NULL),(360,22,112,NULL,NULL),(361,23,124,NULL,NULL),(362,23,123,NULL,NULL),(363,23,113,NULL,NULL),(364,23,67,NULL,NULL),(365,23,65,NULL,NULL),(366,23,64,NULL,NULL),(367,24,122,NULL,NULL),(368,24,121,NULL,NULL),(369,24,120,NULL,NULL),(370,24,118,NULL,NULL),(371,24,115,NULL,NULL),(372,24,114,NULL,NULL),(373,24,67,NULL,NULL),(374,24,65,NULL,NULL),(375,24,64,NULL,NULL),(376,24,63,NULL,NULL),(377,23,63,NULL,NULL),(378,23,125,NULL,NULL),(379,24,126,NULL,NULL),(380,17,137,NULL,NULL),(381,17,136,NULL,NULL),(382,17,135,NULL,NULL),(383,17,134,NULL,NULL),(384,17,133,NULL,NULL),(385,17,132,NULL,NULL),(386,17,138,NULL,NULL),(392,17,67,NULL,NULL),(393,17,65,NULL,NULL),(394,17,64,NULL,NULL),(395,17,63,NULL,NULL),(402,17,126,NULL,NULL),(404,17,97,NULL,NULL),(408,28,138,NULL,NULL),(409,28,137,NULL,NULL),(410,28,136,NULL,NULL),(411,28,135,NULL,NULL),(412,28,134,NULL,NULL),(413,28,133,NULL,NULL),(414,28,132,NULL,NULL),(415,28,100,NULL,NULL),(416,28,99,NULL,NULL),(417,28,97,NULL,NULL),(418,28,95,NULL,NULL),(419,28,67,NULL,NULL),(420,28,65,NULL,NULL),(421,28,64,NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8 COMMENT='权限资源表';

#
# Data for table "hzg_sys_privilege_resource"
#

INSERT INTO `hzg_sys_privilege_resource` VALUES (3,'后台用户注册','/sys/save/user','2017-05-08 14:38:13'),(4,'公司注册','/sys/save/company','2017-05-08 14:44:01'),(5,'部门注册','/sys/save/dept','2017-05-08 14:44:16'),(6,'岗位注册','/sys/save/post','2017-05-08 14:44:52'),(7,'后台用户修改','/sys/update/user','2017-05-08 14:45:13'),(8,'公司修改','/sys/update/company','2017-05-08 14:45:23'),(9,'部门修改','/sys/update/dept','2017-05-08 14:45:42'),(10,'岗位修改','/sys/update/post','2017-05-08 14:46:00'),(11,'后台用户查看','/sys/view/user/{id}','2017-05-08 14:47:21'),(12,'公司查看','/sys/view/company/{id}','2017-05-08 14:47:30'),(13,'部门查看','/sys/view/dept/{id}','2017-05-08 14:47:38'),(14,'岗位查看','/sys/view/post/{id}','2017-05-08 14:47:44'),(15,'权限添加','/sys/save/privilegeResource','2017-05-08 14:48:12'),(16,'权限修改','/sys/update/privilegeResource','2017-05-08 14:48:30'),(17,'权限查看','/sys/view/privilegeResource/{id}','2017-05-08 14:48:41'),(18,'权限分配','/sys/business/assignPrivilege','2017-05-15 11:15:41'),(19,'公司查询','/sys/query/company','2017-05-15 13:35:46'),(20,'部门查询','/sys/query/dept','2017-05-15 13:35:55'),(21,'岗位查询','/sys/query/post','2017-05-15 13:36:09'),(22,'后台用户查询','/sys/query/user','2017-05-15 13:36:27'),(23,'后台用户建议','/sys/suggest/user/{properties}/{word}','2017-05-15 13:42:31'),(24,'岗位建议','/sys/suggest/post/{properties}/{word}','2017-05-15 13:42:57'),(25,'部门建议','/sys/suggest/dept/{properties}/{word}','2017-05-15 13:43:07'),(26,'公司建议','/sys/suggest/dept/{properties}/{word}','2017-05-15 13:43:18'),(27,'用户复杂查询','/sys/complexQuery/user','2017-05-15 16:20:39'),(28,'公司复杂查询','/sys/complexQuery/company','2017-05-15 16:20:51'),(29,'部门复杂查询','/sys/complexQuery/dept','2017-05-15 16:21:00'),(30,'岗位复杂查询','/sys/complexQuery/post','2017-05-15 16:21:11'),(31,'权限复杂查询','/sys/complexQuery/privilegeResource','2017-05-15 16:21:26'),(32,'权限查询','/sys/query/privilegeResource','2017-05-15 16:22:13'),(33,'事宜办理、审核','/sys/audit','2017-05-20 15:15:43'),(34,'流程查看','/sys/view/auditFlow/{id}','2017-05-22 14:19:23'),(35,'流程添加','/sys/save/auditFlow','2017-05-22 14:22:55'),(36,'流程查询','/sys/query/auditFlow','2017-05-22 14:24:48'),(37,'流程复杂查询','/sys/complexQuery/auditFlow','2017-05-22 14:25:03'),(44,'采购单保存','/erp/save/purchase','2017-05-26 13:27:29'),(45,'采购单查看','/erp/view/purchase/{id}','2017-05-26 13:28:42'),(46,'采购单修改','/erp/update/purchase','2017-05-26 13:28:56'),(47,'采购单复杂查询','/erp/complexQuery/purchase','2017-05-26 13:29:26'),(48,'采购单查询','/erp/query/purchase','2017-05-26 13:29:59'),(49,'采购单建议','/erp/suggest/purchase/{properties}/{word}','2017-05-26 13:30:22'),(50,'供应商保存','/erp/save/supplier','2017-05-26 13:27:29'),(51,'供应商查看','/erp/view/supplier/{id}','2017-05-26 13:28:42'),(52,'供应商修改','/erp/update/supplier','2017-05-26 13:28:56'),(53,'供应商复杂查询','/erp/complexQuery/supplier','2017-05-26 13:29:26'),(54,'供应商查询','/erp/query/supplier','2017-05-26 13:29:59'),(55,'供应商建议','/erp/suggest/supplier/{properties}/{word}','2017-05-26 13:30:22'),(56,'流程修改','/sys/update/auditFlow','2017-06-01 10:38:22'),(57,'商品类型保存','/erp/save/productType','2017-05-26 13:27:29'),(58,'商品类型查看','/erp/view/productType/{id}','2017-05-26 13:28:42'),(59,'商品类型修改','/erp/update/productType','2017-05-26 13:28:56'),(60,'商品类型复杂查询','/erp/complexQuery/productType','2017-05-26 13:29:26'),(61,'商品类型查询','/erp/query/productType','2017-05-26 13:29:59'),(62,'商品类型建议','/erp/suggest/productType/{properties}/{word}','2017-05-26 13:30:22'),(63,'商品建议','/erp/suggest/product/{properties}/{word}','2017-05-26 13:30:22'),(64,'商品查询','/erp/query/product','2017-05-26 13:29:59'),(65,'商品复杂查询','/erp/complexQuery/product','2017-05-26 13:29:26'),(66,'商品修改','/erp/update/product','2017-05-26 13:28:56'),(67,'商品查看','/erp/view/product/{id}','2017-05-26 13:28:42'),(68,'商品保存','/erp/save/product','2017-05-26 13:27:29'),(69,'商品属性保存','/erp/save/productProperty','2017-05-26 13:27:29'),(70,'商品属性查看','/erp/view/productProperty/{id}','2017-05-26 13:28:42'),(71,'商品属性修改','/erp/update/productProperty','2017-05-26 13:28:56'),(72,'商品属性复杂查询','/erp/complexQuery/productProperty','2017-05-26 13:29:26'),(73,'商品属性查询','/erp/query/productProperty','2017-05-26 13:29:59'),(74,'商品属性建议','/erp/suggest/productProperty/{properties}/{word}','2017-05-26 13:30:22'),(75,'商品属性私有查询','/erp/privateQuery/productProperty','2017-06-10 14:25:45'),(82,'多实体建议','/erp/entitiesSuggest/{targetEntities}/{entities}/{properties}/{word}','2017-05-26 13:29:26'),(83,'入库、出库单建议','/erp/suggest/stockInOut/{properties}/{word}','2017-05-26 13:30:22'),(84,'入库、出库单查询','/erp/query/stockInOut','2017-05-26 13:29:59'),(85,'入库、出库单复杂查询','/erp/complexQuery/stockInOut','2017-05-26 13:29:26'),(86,'入库、出库单修改','/erp/update/stockInOut','2017-05-26 13:28:56'),(87,'入库、出库单查看','/erp/view/stockInOut/{id}','2017-05-26 13:28:42'),(88,'入库、出库单保存','/erp/save/stockInOut','2017-05-26 13:27:29'),(89,'公司账户查询','/pay/query/account','2017-05-26 13:29:59'),(90,'公司账户复杂查询','/pay/complexQuery/account','2017-05-26 13:29:26'),(91,'公司账户修改','/pay/update/account','2017-05-26 13:28:56'),(92,'公司账户查看','/pay/view/account/{id}','2017-05-26 13:28:42'),(93,'公司账户保存','/pay/save/account','2017-05-26 13:27:29'),(94,'公司账户建议','/pay/suggest/account/{properties}/{word}','2017-05-26 13:30:22'),(95,'支付记录建议','/pay/suggest/pay/{properties}/{word}','2017-05-26 13:30:22'),(96,'支付记录保存','/pay/save/pay','2017-05-26 13:27:29'),(97,'支付记录查看','/pay/view/pay/{id}','2017-05-26 13:28:42'),(98,'支付记录修改','/pay/update/pay','2017-05-26 13:28:56'),(99,'支付记录复杂查询','/pay/complexQuery/pay','2017-05-26 13:29:26'),(100,'支付记录查询','/pay/query/pay','2017-05-26 13:29:59'),(102,'采购单作废','/erp/delete/purchase','2017-07-12 13:53:41'),(103,'采购单恢复','/erp/recover/purchase','2017-07-12 13:53:56'),(104,'入库单作废','/erp/delete/stockInOut','2017-07-12 13:54:22'),(105,'入库单恢复','/erp/recover/stockInOut','2017-07-12 13:54:35'),(106,'仓库保存','/erp/save/warehouse','2017-05-26 13:27:29'),(107,'仓库查看','/erp/view/warehouse/{id}','2017-05-26 13:28:42'),(108,'仓库修改','/erp/update/warehouse','2017-05-26 13:28:56'),(109,'仓库复杂查询','/erp/complexQuery/warehouse','2017-05-26 13:29:26'),(110,'仓库查询','/erp/query/warehouse','2017-05-26 13:29:59'),(111,'仓库建议','/erp/suggest/warehouse/{properties}/{word}','2017-05-26 13:30:22'),(112,'库存查看','/erp/view/stock/{id}','2017-07-18 14:00:24'),(113,'上传商品多媒体文件','/erp/business/uploadMediaFiles','2017-07-27 09:15:49'),(122,'商品描述复杂查询','/erp/complexQuery/productDescribe','2017-05-26 13:29:26'),(123,'商品多媒体文件上传信息更新','/erp/doBusiness/updateUploadMediaFilesInfo','2017-05-26 13:29:26'),(124,'商品跨域查询','/erp/doBusiness/queryProductAccessAllow','2017-05-26 13:29:59'),(125,'文件系统删除文件','/stream_hzg_upload/deleteFile','2017-07-27 17:20:58'),(126,'商品私有查询','/erp/privateQuery/product','2017-08-02 15:10:44'),(127,'商品描述查询','/erp/query/productDescribe','2017-05-26 13:29:59'),(128,'商品描述保存','/erp/save/productDescribe','2017-05-26 13:27:29'),(129,'商品描述修改','/erp/update/productDescribe','2017-05-26 13:28:56'),(130,'商品描述建议','/erp/suggest/productDescribe/{properties}/{word}','2017-05-26 13:30:22'),(131,'商品描述查看','/erp/view/productDescribe/{id}','2017-07-27 09:16:11'),(132,'价格变动查询','/erp/query/productPriceChange','2017-05-26 13:29:59'),(133,'价格变动保存','/erp/save/productPriceChange','2017-05-26 13:27:29'),(134,'价格变动修改','/erp/update/productPriceChange','2017-05-26 13:28:56'),(135,'价格变动建议','/erp/suggest/productPriceChange/{properties}/{word}','2017-05-26 13:30:22'),(136,'价格变动查看','/erp/view/productPriceChange/{id}','2017-07-27 09:16:11'),(137,'价格变动复杂查询','/erp/complexQuery/productPriceChange',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='后台用户表';

#
# Data for table "hzg_sys_user"
#

INSERT INTO `hzg_sys_user` VALUES (26,'信息管理员','male','admin','FCEA920F7412B5DA7BE0CF42B8C93759','it@hzg.com','2017-05-03 15:53:28',NULL,0),(29,'采购员','male','purchase','FCEA920F7412B5DA7BE0CF42B8C93759','purchase@hzg.com','2017-05-31 15:32:18',NULL,0),(30,'掌柜','male','zhangui','FCEA920F7412B5DA7BE0CF42B8C93759','zhangui@hzg.com','2017-06-19 15:35:32',NULL,0),(31,'仓储','male','cangchu','FCEA920F7412B5DA7BE0CF42B8C93759','canchu@hzg.com','2017-06-19 15:37:58',NULL,0),(32,'摄影','male','sheying','FCEA920F7412B5DA7BE0CF42B8C93759','sheying@hzg.com','2017-06-19 15:39:27',NULL,0),(33,'编辑','male','bianji','FCEA920F7412B5DA7BE0CF42B8C93759','bianji@hzg.com','2017-06-19 15:42:09',NULL,0),(34,'入库员','male','rukuyuan','FCEA920F7412B5DA7BE0CF42B8C93759','rukuyuan@hzg.com','2017-06-30 14:28:46',NULL,0),(35,'财务','male','caiwu','FCEA920F7412B5DA7BE0CF42B8C93759','caiwu@hzg.com','2017-07-03 14:00:37',NULL,0),(36,'采购一','male','purchase1','FCEA920F7412B5DA7BE0CF42B8C93759','purchase@hzg.com','2017-07-07 11:51:31',NULL,0),(37,'仓储一','male','cangchu1','FCEA920F7412B5DA7BE0CF42B8C93759','cangchu1@hzg.com','2017-07-20 10:38:28',NULL,0),(38,'销售','female','xiaoshou','FCEA920F7412B5DA7BE0CF42B8C93759','xiaoshou@hzg.com','2017-08-30 11:06:08',NULL,0),(39,'销售主管','male','saleCharger','FCEA920F7412B5DA7BE0CF42B8C93759','saleCharger@hzg.com','2017-08-30 17:25:05',NULL,0);

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
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8 COMMENT='用户岗位关联表';

#
# Data for table "hzg_sys_userpost_relation"
#

INSERT INTO `hzg_sys_userpost_relation` VALUES (134,26,16),(135,26,19),(136,26,20),(142,29,25),(143,30,26),(144,31,22),(145,32,23),(146,33,24),(147,34,27),(148,35,21),(149,36,25),(150,37,22),(151,38,17),(152,39,28);

/*Table structure for table `hzg_finance_banksubject_extend` */

DROP TABLE IF EXISTS `hzg_finance_banksubject_extend`;

CREATE TABLE `hzg_finance_banksubject_extend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` int(11) DEFAULT NULL COMMENT '账户id',
  `subjectId` int(11) DEFAULT NULL COMMENT '科目id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `hzg_finance_banksubject_extend` */


/*Table structure for table `hzg_finance_doctype` */

DROP TABLE IF EXISTS `hzg_finance_doctype`;

CREATE TABLE `hzg_finance_doctype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) DEFAULT NULL COMMENT '单据类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `hzg_finance_doctype` */


/*Table structure for table `hzg_finance_doctypesubject_relation` */

DROP TABLE IF EXISTS `hzg_finance_doctypesubject_relation`;

CREATE TABLE `hzg_finance_doctypesubject_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `subjectId` int(11) DEFAULT NULL COMMENT '科目id',
  `direction` int(1) DEFAULT NULL COMMENT '余额方向',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hzg_finance_doctypesubject_relation` */

/*Table structure for table `hzg_finance_form_capitalflowmeter` */

DROP TABLE IF EXISTS `hzg_finance_form_capitalflowmeter`;

CREATE TABLE `hzg_finance_form_capitalflowmeter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` int(11) DEFAULT NULL COMMENT '账户id',
  `date` datetime DEFAULT NULL COMMENT '单据日期',
  `docTypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `no` varchar(16) DEFAULT NULL COMMENT '单据编号',
  `beginning` varchar(32) DEFAULT NULL COMMENT '期初余额',
  `income` varchar(32) DEFAULT NULL COMMENT '收入金额',
  `spending` varchar(32) DEFAULT NULL COMMENT '支出金额',
  `ending` varchar(32) DEFAULT NULL COMMENT '期末余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金流水表';

/*Table structure for table `hzg_finance_form_customercontact` */

DROP TABLE IF EXISTS `hzg_finance_form_customercontact`;

CREATE TABLE `hzg_finance_form_customercontact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) DEFAULT NULL COMMENT '客户id',
  `date` datetime DEFAULT NULL COMMENT '单据日期',
  `docTypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `no` varchar(16) DEFAULT NULL COMMENT '单据编号',
  `chartMakerId` int(11) DEFAULT NULL COMMENT '业务员id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编号',
  `productName` varchar(16) DEFAULT NULL COMMENT '商品名称',
  `unit` varchar(8) DEFAULT NULL COMMENT '计量单位',
  `quantity` float(8,2) DEFAULT NULL COMMENT '数量',
  `unitPrice` varchar(32) DEFAULT NULL COMMENT '单价',
  `receivable` varchar(32) DEFAULT NULL COMMENT '应收金额',
  `received` varchar(32) DEFAULT NULL COMMENT '已收金额',
  `remainder` varchar(32) DEFAULT NULL COMMENT '应收余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户往来对账表';

/*Table structure for table `hzg_finance_form_grossprofit` */

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
  `discount` varchar(32) DEFAULT NULL COMMENT '折让金额',
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

/*Table structure for table `hzg_finance_form_inoutdetail` */

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='进销存明细账表';

/*Table structure for table `hzg_finance_form_suppliercontact` */

DROP TABLE IF EXISTS `hzg_finance_form_suppliercontact`;

CREATE TABLE `hzg_finance_form_suppliercontact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplierId` int(11) DEFAULT NULL COMMENT '供应商id',
  `date` datetime DEFAULT NULL COMMENT '单据日期',
  `docTypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `no` varchar(16) DEFAULT NULL COMMENT '单据编号',
  `chartMakerId` int(11) DEFAULT NULL COMMENT '业务员id',
  `productNo` varchar(16) DEFAULT NULL COMMENT '商品编号',
  `productName` varchar(16) DEFAULT NULL COMMENT '商品名称',
  `unit` varchar(8) DEFAULT NULL COMMENT '计量单位',
  `quantity` float(8,2) DEFAULT NULL COMMENT '数量',
  `unitPrice` varchar(32) DEFAULT NULL COMMENT '单价',
  `payable` varchar(32) DEFAULT NULL COMMENT '应付金额',
  `paid` varchar(32) DEFAULT NULL COMMENT '已付金额',
  `remainder` varchar(32) DEFAULT NULL COMMENT '应付余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商往来对账表';

/*Table structure for table `hzg_finance_purchasesubject_extend` */

DROP TABLE IF EXISTS `hzg_finance_purchasesubject_extend`;

CREATE TABLE `hzg_finance_purchasesubject_extend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplierId` int(11) DEFAULT NULL COMMENT '供应商id',
  `subjectId` int(11) DEFAULT NULL COMMENT '科目id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `hzg_finance_purchasesubject_extend` */


/*Table structure for table `hzg_finance_subject` */

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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='科目表';

/*Data for the table `hzg_finance_subject` */


/*Table structure for table `hzg_finance_subject_category` */

DROP TABLE IF EXISTS `hzg_finance_subject_category`;

CREATE TABLE `hzg_finance_subject_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL COMMENT '科目类别名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='科目类别表';

/*Data for the table `hzg_finance_subject_category` */


/*Table structure for table `hzg_finance_subject_relate` */

DROP TABLE IF EXISTS `hzg_finance_subject_relate`;

CREATE TABLE `hzg_finance_subject_relate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '科目扩展id',
  `categoryId` int(11) DEFAULT NULL COMMENT '科目类别id',
  `entity` varchar(16) DEFAULT NULL COMMENT '关联实体',
  `field` varchar(16) DEFAULT NULL COMMENT '关联字段',
  `fieldName` varchar(10) DEFAULT NULL COMMENT '关联字段中文名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `hzg_finance_subject_relate` */


/*Table structure for table `hzg_finance_voucher` */

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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='凭证';

/*Data for the table `hzg_finance_voucher` */


/*Table structure for table `hzg_finance_voucher_category` */

DROP TABLE IF EXISTS `hzg_finance_voucher_category`;

CREATE TABLE `hzg_finance_voucher_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voucherWord` varchar(10) DEFAULT NULL COMMENT '凭证字',
  `name` varchar(16) DEFAULT NULL COMMENT '凭证类别名称',
  `inputDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='凭证类别';

/*Data for the table `hzg_finance_voucher_category` */


/*Table structure for table `hzg_finance_voucher_detail` */

DROP TABLE IF EXISTS `hzg_finance_voucher_detail`;

CREATE TABLE `hzg_finance_voucher_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voucherId` int(11) DEFAULT NULL COMMENT '凭证ID',
  `voucherItemId` int(11) DEFAULT NULL COMMENT '凭证条目ID',
  `itemTypeId` int(11) DEFAULT NULL COMMENT '条目类型id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COMMENT='凭证明细';

/*Data for the table `hzg_finance_voucher_detail` */


/*Table structure for table `hzg_finance_voucher_item` */

DROP TABLE IF EXISTS `hzg_finance_voucher_item`;

CREATE TABLE `hzg_finance_voucher_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `summary` varchar(60) DEFAULT NULL COMMENT '摘要',
  `assistant` varchar(30) DEFAULT NULL COMMENT '辅助项',
  `debit` float(8,2) DEFAULT NULL COMMENT '借方',
  `credit` float(8,2) DEFAULT NULL COMMENT '贷方',
  `subjectId` int(11) DEFAULT NULL COMMENT '科目ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COMMENT='采购凭证条目';

/*Data for the table `hzg_finance_voucher_item` */


/*Table structure for table `hzg_finance_voucher_itemsource` */

DROP TABLE IF EXISTS `hzg_finance_voucher_itemsource`;

CREATE TABLE `hzg_finance_voucher_itemsource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '凭证条目来源id',
  `chartMakerId` int(11) DEFAULT NULL COMMENT '制单人id',
  `date` datetime DEFAULT NULL COMMENT '单据日期',
  `warehouseId` int(11) DEFAULT NULL COMMENT '仓库id',
  `doctypeId` int(11) DEFAULT NULL COMMENT '单据类型id',
  `businessType` varchar(16) DEFAULT NULL COMMENT '业务类型',
  `docNo` varchar(16) DEFAULT NULL COMMENT '单据编号',
  `contactUnit` varchar(30) DEFAULT NULL COMMENT '往来单位名称',
  `ammout` varchar(32) DEFAULT NULL COMMENT '金额',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `extend` varchar(32) DEFAULT NULL COMMENT '扩展字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hzg_finance_voucher_itemsource` */

/*Table structure for table `hzg_finance_voucher_itemsource_detail` */

DROP TABLE IF EXISTS `hzg_finance_voucher_itemsource_detail`;

CREATE TABLE `hzg_finance_voucher_itemsource_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemsourceId` int(11) DEFAULT NULL COMMENT '凭证条目来源id',
  `entity` varchar(32) DEFAULT NULL COMMENT '条件实体,如:商品类型:productType，仓库:warehouse等',
  `entityId` int(11) DEFAULT NULL COMMENT '商品分类id,仓库id等',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hzg_finance_voucher_itemsource_detail` */
