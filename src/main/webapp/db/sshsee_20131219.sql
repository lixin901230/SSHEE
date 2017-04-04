/*
SQLyog Ultimate v8.32 
MySQL - 5.1.21-beta-community : Database - sshsee
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sshsee` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sshsee`;

/*Table structure for table `t_sys_access_log` */

DROP TABLE IF EXISTS `t_sys_access_log`;

CREATE TABLE `t_sys_access_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '认证日志ID，唯一主键',
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `userName` varchar(255) DEFAULT NULL COMMENT '用户名',
  `loginTime` datetime DEFAULT NULL COMMENT '登陆时间',
  `logoutTime` datetime DEFAULT NULL COMMENT '退出时间',
  `logoutType` int(1) DEFAULT NULL COMMENT '退出类型；0：正常退出；1：非正常退出',
  `loginIp` varchar(255) DEFAULT NULL COMMENT '认证登陆终端的IP',
  `sessionId` varchar(255) DEFAULT NULL COMMENT 'sessionID',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='认证日志信息表';

/*Data for the table `t_sys_access_log` */

/*Table structure for table `t_sys_dictionary` */

DROP TABLE IF EXISTS `t_sys_dictionary`;

CREATE TABLE `t_sys_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '字典id，唯一主键',
  `parentId` int(11) DEFAULT NULL COMMENT '字典父节点，用于存放比如省、市、县等系统字典数据',
  `dic_Name` varchar(255) DEFAULT NULL COMMENT '字典数据名称',
  `state` int(11) DEFAULT NULL COMMENT '典字状态，1：可用，0：不可用',
  `createTime` datetime DEFAULT NULL COMMENT '建创时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_dictionary` */

/*Table structure for table `t_sys_operation_log` */

DROP TABLE IF EXISTS `t_sys_operation_log`;

CREATE TABLE `t_sys_operation_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '操作日志ID',
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `userName` varchar(255) DEFAULT NULL COMMENT '用户名',
  `operationTime` datetime DEFAULT NULL COMMENT '操作时间',
  `operationType` int(11) DEFAULT NULL COMMENT '操作类型；0：查询；1：添加；2：修改；3：删除；4：导入；5：导出；',
  `operationUrl` varchar(255) DEFAULT NULL COMMENT '操作资源的URL',
  `operationContent` varchar(255) DEFAULT NULL COMMENT '操作内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作日志信息表';

/*Data for the table `t_sys_operation_log` */

/*Table structure for table `t_sys_resource` */

DROP TABLE IF EXISTS `t_sys_resource`;

CREATE TABLE `t_sys_resource` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT '资源ID，唯一主键',
  `parentId` varchar(255) DEFAULT NULL COMMENT '资源的父节点id',
  `nodeCode` varchar(255) DEFAULT NULL COMMENT '资源代码',
  `nodeName` varchar(255) DEFAULT NULL COMMENT '资源名称',
  `url` varchar(255) DEFAULT NULL COMMENT 'url',
  `icon` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `isMenu` int(11) DEFAULT NULL COMMENT '是否为模块、菜单或者功能点，0：块模，1：菜单，2：功能点',
  `nodeSort` int(11) DEFAULT NULL COMMENT '排序；同级菜单中，从1开始编序',
  `statu` int(11) DEFAULT NULL COMMENT '状态，1：可以，0：不可用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源信息表';

/*Data for the table `t_sys_resource` */

insert  into `t_sys_resource`(`id`,`parentId`,`nodeCode`,`nodeName`,`url`,`icon`,`createTime`,`isMenu`,`nodeSort`,`statu`,`remark`) values ('0','ROOT_NODE','welcome','首页','${ctx}/view/common/layout/portal.jsp',NULL,'2013-12-08 16:07:10',1,1,1,'系统登陆成功后的展示页'),('1','0','sysMan','系统管理',NULL,NULL,'2013-12-08 16:52:06',0,1,1,'模块'),('101','1','userMan','用户管理','http://localhost:8081/sshsee/sysman/userAction!toUserListPage.action',NULL,'2013-12-08 16:54:44',1,1,1,'菜单'),('10101','101','userManList','用户列表','http://localhost:8081/sshsee/sysman/userAction!toUserListPage.action',NULL,'2013-12-08 16:58:03',1,1,1,'功能菜单'),('10102','101','userManDetail','用户查看','1',NULL,'2013-12-08 16:58:05',1,2,1,'功能点'),('10103','101','userManAdd','用户添加','1',NULL,'2013-12-08 17:00:39',2,3,1,'功能点'),('10104','101','userManEdit','用户修改','1',NULL,'2013-12-08 17:02:56',2,4,1,'功能点'),('10105','101','userManDel','用户删除','1',NULL,'2013-12-08 17:02:58',2,5,1,'功能点'),('10106','101','userAuth','用户授权','1',NULL,'2013-12-08 17:03:01',2,6,1,'功能点'),('10107','101','userManImport','用户导入','1',NULL,'2013-12-08 17:27:47',2,7,1,'功能点'),('10108','101','userManExport','用户导出','1',NULL,'2013-12-08 17:27:50',2,8,1,'功能点'),('102','1','roleMan','角色管理','http://localhost:8081/sshsee/sysman/roleAction!toRoleListPage.action',NULL,'2013-12-08 17:27:50',1,2,1,'菜单'),('10201','102','roleManList','角色列表','http://localhost:8081/sshsee/sysman/roleAction!toRoleListPage.action',NULL,'2013-12-08 17:27:50',2,1,1,'功能菜单'),('10202','102','roleManDetail','角色查看','1',NULL,'2013-12-08 17:27:50',2,2,1,'功能点'),('10203','102','roleManAdd','角色添加','1',NULL,'2013-12-08 17:27:50',2,3,1,'功能点'),('10204','102','roleManEdit','角色修改','1',NULL,'2013-12-08 17:27:50',2,4,1,'功能点'),('10205','102','roleManDel','角色删除','1',NULL,'2013-12-08 17:27:50',2,5,1,'功能点'),('10206','102','roleManAuth','角色授权','1',NULL,'2013-12-08 17:27:50',2,6,1,'功能点'),('10207','102','roleManImport','角色导入','1',NULL,'2013-12-08 17:27:50',2,7,1,'功能点'),('10208','102','roleManExport','角色导出','1',NULL,'2013-12-08 17:27:50',2,8,1,'功能点'),('10209','102',NULL,'角色编辑保存','1',NULL,NULL,2,9,1,NULL),('103','1','resourceMan','资源管理','http://localhost:8081/sshsee/sysman/resourceAction!toResourceListPage.action',NULL,'2013-12-08 17:27:50',1,3,1,'菜单'),('10301','103','resourceManList','资源列表','http://localhost:8081/sshsee/sysman/resourceAction!toResourceListPage.action',NULL,'2013-12-08 17:27:50',2,1,1,'功能菜单'),('10302','103','resourceManDetail','资源查看','1',NULL,'2013-12-08 17:27:50',2,2,1,'功能点'),('10303','103','resourceManAdd','资源添加','1',NULL,'2013-12-08 17:27:50',2,3,1,'功能点'),('10304','103','resourceManEdit','资源修改','1',NULL,'2013-12-08 17:27:50',2,4,1,'功能点'),('10305','103','resourceManDel','资源删除','1',NULL,'2013-12-08 17:27:50',2,5,1,'功能点'),('10306','103','resourceManImport','资源导入','1',NULL,'2013-12-08 17:27:50',2,6,1,'功能点'),('10307','103','resourceManExport','资源导出','1',NULL,'2013-12-08 17:27:50',2,7,1,'功能点'),('104','1','logMan','日志管理','',NULL,'2013-12-25 17:33:08',1,4,1,'菜单'),('10401','104','authLogMan','认证日志管理','1',NULL,'2013-12-23 17:35:25',1,1,1,'子菜单'),('1040101','10401','authLogList','认证日志列表','1',NULL,'2013-12-23 17:40:02',2,1,1,'认证日志列表'),('1040102','10401','authLogImport','认证日志导入','1',NULL,'2013-12-23 17:42:06',2,2,1,'认证日志导入'),('1040103','10401','authLogExport','认证日志导出','1',NULL,'2013-12-24 17:46:36',2,3,1,'认证日志导出'),('1040104','10401','authLogClean','认证日志清理','1',NULL,'2013-12-16 17:47:48',2,4,1,'认证日志清理'),('10402','104','sysLogMan','系统日志管理','1',NULL,'2013-12-24 17:49:00',1,2,1,'系统日志管理'),('1040201','10402','sysLogList','系统日志列表','1',NULL,'2013-12-13 17:50:08',2,1,1,'系统日志列表'),('1040202','10402','sysLogImport','系统日志导入','1',NULL,'2013-12-13 17:50:38',2,2,1,'系统日志导入'),('1040203','10402','sysLogExport','系统日志导出','1',NULL,'2013-12-13 17:51:35',2,3,1,'系统日志导出'),('1040204','10402','sysLogClean','系统日志清理','1',NULL,'2013-12-13 17:52:16',2,4,1,'日志清理'),('2','0','bizMan','业务模块','',NULL,NULL,0,2,1,NULL),('201','2','customMan','客户管理',NULL,NULL,NULL,1,1,1,NULL),('20101','201','customList','客户列表',NULL,NULL,NULL,1,2,1,NULL),('20102','20101','customAdd','客户添加',NULL,NULL,NULL,1,3,1,NULL),('202','2','orderMan','订单管理',NULL,NULL,NULL,1,2,1,NULL);

/*Table structure for table `t_sys_role` */

DROP TABLE IF EXISTS `t_sys_role`;

CREATE TABLE `t_sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID，唯一字段',
  `roleName` varchar(255) DEFAULT NULL COMMENT '色角名称',
  `roleType` varchar(255) DEFAULT 'NULL' COMMENT '角色类型；1：超级管理员，2：系统管理员；3：普通用户',
  `createTime` datetime DEFAULT NULL COMMENT '建时时间',
  `state` int(11) DEFAULT NULL COMMENT '角色状态；0：禁用；1：启用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

/*Data for the table `t_sys_role` */

insert  into `t_sys_role`(`id`,`roleName`,`roleType`,`createTime`,`state`,`remark`) values (1,'超级管理员','1','2013-11-13 14:11:52',1,'拥有系统所有权限'),(2,'系统管理员','2','2013-11-18 14:12:28',1,'拥有除授权管理的所有权限'),(3,'普通用户','3','2013-11-18 14:13:08',1,'拥有除系统管理模块外的访问权限');

/*Table structure for table `t_sys_role$resource` */

DROP TABLE IF EXISTS `t_sys_role$resource`;

CREATE TABLE `t_sys_role$resource` (
  `roleId` varchar(11) DEFAULT NULL COMMENT '角色ID',
  `resourceId` int(11) DEFAULT NULL COMMENT '资源ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色跟资源关联表';

/*Data for the table `t_sys_role$resource` */

insert  into `t_sys_role$resource`(`roleId`,`resourceId`) values ('1',0),('1',1),('1',101),('1',10102),('1',10103),('1',10104),('1',10105),('1',10106),('1',10107),('1',10101),('1',10108),('1',102),('1',10201),('1',10202),('1',10203),('1',10204),('1',10205),('1',10206),('1',10207),('1',10208),('1',10301),('1',10302),('1',10303),('1',10304),('1',103),('1',10305),('1',10306),('1',10307),('2',0),('2',1),('2',101),('2',10102),('2',10103),('2',10104),('2',10105),('2',10106),('2',10107),('2',10101),('2',10108),('2',102),('2',10201),('2',10202),('2',10203),('2',10204),('2',10205),('2',10206),('2',10207),('2',10208),('2',10301),('2',10302),('2',10303),('2',10304),('2',103),('2',10305),('2',10306),('2',10307),('3',0),('3',1),('3',101),('3',10102),('3',10103),('3',10104),('3',10105),('3',10106),('3',10107),('3',10101),('3',10108),('',102),('',10201),('',10202),('',10203),('',10204),('',10205),('',10206),('',10207),('',10208),('',10301),('',10302),('',10303),('',10304),('',103),('',10305),('',10306),('',10307);

/*Table structure for table `t_sys_user` */

DROP TABLE IF EXISTS `t_sys_user`;

CREATE TABLE `t_sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id，唯一主键',
  `userName` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `sex` varchar(255) DEFAULT NULL COMMENT '性别',
  `telphone` varchar(255) DEFAULT NULL COMMENT '手机',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `lastUpdateTime` datetime DEFAULT NULL COMMENT '最后修改时间',
  `statu` int(11) DEFAULT NULL COMMENT '状态，0：未激活，不可用；1：已激活，可用；2：挂起；3：禁用；4：过期',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

/*Data for the table `t_sys_user` */

insert  into `t_sys_user`(`id`,`userName`,`password`,`email`,`sex`,`telphone`,`createTime`,`lastUpdateTime`,`statu`,`remark`) values (1,'superadmin','superadmin','412506897@qq.com','男','12345678911','2013-11-24 16:02:18','2013-11-27 16:51:10',1,'超管，拥有所有权限'),(2,'admin','admin','123121@qq.com','男','12345678911','2013-11-24 16:02:42','2013-11-27 16:51:14',1,'管理员，拥有除权限模块的所有权限'),(3,'user','user','user123@sina.cn','女','12345678911','2013-11-11 16:03:31','2013-11-20 16:51:16',1,'普通用户'),(4,'lx','lx','lx12312@qq.com','男','12345678911','2013-11-10 16:03:53','2013-11-27 16:51:25',1,'普通用户');

/*Table structure for table `t_sys_user$resource` */

DROP TABLE IF EXISTS `t_sys_user$resource`;

CREATE TABLE `t_sys_user$resource` (
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `resourceId` int(11) DEFAULT NULL COMMENT '资源ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户跟资源关联表';

/*Data for the table `t_sys_user$resource` */

/*Table structure for table `t_sys_user$role` */

DROP TABLE IF EXISTS `t_sys_user$role`;

CREATE TABLE `t_sys_user$role` (
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `roleId` int(11) DEFAULT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户跟角色关联表';

/*Data for the table `t_sys_user$role` */

insert  into `t_sys_user$role`(`userId`,`roleId`) values (1,1),(2,2),(3,3),(4,3);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
