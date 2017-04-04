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
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `isMenu` int(11) DEFAULT NULL COMMENT '是否是菜单，0：菜单，1：非菜单',
  `nodeSort` int(11) DEFAULT NULL COMMENT '排序；同级菜单中，从1开始编序',
  `statu` int(11) DEFAULT NULL COMMENT '状态，1：可以，0：不可用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源信息表';

/*Data for the table `t_sys_resource` */


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


/*Table structure for table `t_sys_role$resource` */

DROP TABLE IF EXISTS `t_sys_role$resource`;

CREATE TABLE `t_sys_role$resource` (
  `roleId` int(11) DEFAULT NULL COMMENT '角色ID',
  `resourceId` int(11) DEFAULT NULL COMMENT '资源ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色跟资源关联表';

/*Data for the table `t_sys_role$resource` */


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


/*Table structure for table `t_sys_user$resource` */

DROP TABLE IF EXISTS `t_sys_user$resource`;

CREATE TABLE `t_sys_user$resource` (
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `resourceId` int(11) DEFAULT NULL COMMENT '资源ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户跟资源关联表';


/*Table structure for table `t_sys_user$role` */

DROP TABLE IF EXISTS `t_sys_user$role`;

CREATE TABLE `t_sys_user$role` (
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `roleId` int(11) DEFAULT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户跟角色关联表';


/* Data for the tables  */

INSERT INTO `t_sys_resource` VALUES ('0', 'ROOT_NODE', 'welcome', '首页', '${ctx}/view/common/layout/portal.jsp', '2013-12-08 16:07:10', '1', '1', '1', '系统登陆成功后的展示页');
INSERT INTO `t_sys_resource` VALUES ('1', '0', 'sysMan', '系统管理', null, '2013-12-08 16:52:06', '0', '1', '1', '模块');
INSERT INTO `t_sys_resource` VALUES ('101', '1', 'userMan', '用户管理', null, '2013-12-08 16:54:44', '0', '1', '1', '菜单');
INSERT INTO `t_sys_resource` VALUES ('10101', '101', 'userManList', '用户列表', null, '2013-12-08 16:58:03', '1', '1', '1', '功能菜单');
INSERT INTO `t_sys_resource` VALUES ('10102', '101', 'userManDetail', '用户查看', null, '2013-12-08 16:58:05', '1', '2', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10103', '101', 'userManAdd', '用户添加', null, '2013-12-08 17:00:39', '1', '3', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10104', '101', 'userManEdit', '用户修改', null, '2013-12-08 17:02:56', '1', '4', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10105', '101', 'userManDel', '用户删除', null, '2013-12-08 17:02:58', '1', '5', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10106', '101', 'userAuth', '用户授权', null, '2013-12-08 17:03:01', '1', '6', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10107', '101', 'userManImport', '用户导入', null, '2013-12-08 17:27:47', '1', '7', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10108', '101', 'userManExport', '用户导出', null, '2013-12-08 17:27:50', '1', '8', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('102', '1', 'roleMan', '角色管理', null, '2013-12-08 17:27:50', '0', '2', '1', '菜单');
INSERT INTO `t_sys_resource` VALUES ('10201', '102', 'roleManList', '角色列表', null, '2013-12-08 17:27:50', '1', '1', '1', '功能菜单');
INSERT INTO `t_sys_resource` VALUES ('10202', '102', 'roleManDetail', '角色查看', null, '2013-12-08 17:27:50', '1', '2', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10203', '102', 'roleManAdd', '角色添加', null, '2013-12-08 17:27:50', '1', '3', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10204', '102', 'roleManEdit', '角色修改', null, '2013-12-08 17:27:50', '1', '4', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10205', '102', 'roleManDel', '角色删除', null, '2013-12-08 17:27:50', '1', '5', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10206', '102', 'roleManAuth', '角色授权', null, '2013-12-08 17:27:50', '1', '6', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10207', '102', 'roleManImport', '角色导入', null, '2013-12-08 17:27:50', '1', '7', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10208', '102', 'roleManExport', '角色导出', null, '2013-12-08 17:27:50', '1', '8', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('103', '1', 'resourceMan', '资源管理', null, '2013-12-08 17:27:50', '0', '3', '1', '菜单');
INSERT INTO `t_sys_resource` VALUES ('10301', '103', 'resourceManList', '资源列表', null, '2013-12-08 17:27:50', '1', '1', '1', '功能菜单');
INSERT INTO `t_sys_resource` VALUES ('10302', '103', 'resourceManDetail', '资源查看', null, '2013-12-08 17:27:50', '1', '2', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10303', '103', 'resourceManAdd', '资源添加', null, '2013-12-08 17:27:50', '1', '3', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10304', '103', 'resourceManEdit', '资源修改', null, '2013-12-08 17:27:50', '1', '4', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10305', '103', 'resourceManDel', '资源删除', null, '2013-12-08 17:27:50', '1', '5', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10306', '103', 'resourceManImport', '资源导入', null, '2013-12-08 17:27:50', '1', '6', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('10307', '103', 'resourceManExport', '资源导出', null, '2013-12-08 17:27:50', '1', '7', '1', '功能点');
INSERT INTO `t_sys_resource` VALUES ('104', '1', 'logMan', '日志管理', null, '2013-12-25 17:33:08', '0', '4', '1', '菜单');
INSERT INTO `t_sys_resource` VALUES ('10401', '104', 'authLogMan', '认证日志管理', null, '2013-12-23 17:35:25', '0', '1', '1', '子菜单');
INSERT INTO `t_sys_resource` VALUES ('1040101', '10401', 'authLogList', '认证日志列表', null, '2013-12-23 17:40:02', '1', '1', '1', '认证日志列表');
INSERT INTO `t_sys_resource` VALUES ('1040102', '10401', 'authLogImport', '认证日志导入', null, '2013-12-23 17:42:06', '1', '2', '1', '认证日志导入');
INSERT INTO `t_sys_resource` VALUES ('1040103', '10401', 'authLogExport', '认证日志导出', null, '2013-12-24 17:46:36', '1', '3', '1', '认证日志导出');
INSERT INTO `t_sys_resource` VALUES ('1040104', '10401', 'authLogClean', '认证日志清理', null, '2013-12-16 17:47:48', '1', '4', '1', '认证日志清理');
INSERT INTO `t_sys_resource` VALUES ('10402', '104', 'sysLogMan', '系统日志管理', null, '2013-12-24 17:49:00', '0', '2', '1', '系统日志管理');
INSERT INTO `t_sys_resource` VALUES ('1040201', '10402', 'sysLogList', '系统日志列表', null, '2013-12-13 17:50:08', '1', '1', '1', '系统日志列表');
INSERT INTO `t_sys_resource` VALUES ('1040202', '10402', 'sysLogImport', '系统日志导入', null, '2013-12-13 17:50:38', '1', '2', '1', '系统日志导入');
INSERT INTO `t_sys_resource` VALUES ('1040203', '10402', 'sysLogExport', '系统日志导出', null, '2013-12-13 17:51:35', '1', '3', '1', '系统日志导出');
INSERT INTO `t_sys_resource` VALUES ('1040204', '10402', 'sysLogClean', '系统日志清理', null, '2013-12-13 17:52:16', '1', '4', '1', '日志清理');
INSERT INTO `t_sys_role` VALUES ('1', '超级管理员', '1', '2013-11-13 14:11:52', '1', '拥有系统所有权限');
INSERT INTO `t_sys_role` VALUES ('2', '系统管理员', '2', '2013-11-18 14:12:28', '1', '拥有除授权管理的所有权限');
INSERT INTO `t_sys_role` VALUES ('3', '普通用户', '3', '2013-11-18 14:13:08', '1', '拥有除系统管理模块外的访问权限');
INSERT INTO `t_sys_role$resource` VALUES ('1', '0');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1');
INSERT INTO `t_sys_role$resource` VALUES ('1', '101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10104');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10105');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10106');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10107');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10108');
INSERT INTO `t_sys_role$resource` VALUES ('1', '102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10202');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10203');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10204');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10205');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10206');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10207');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10208');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10302');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10303');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10304');
INSERT INTO `t_sys_role$resource` VALUES ('1', '103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10305');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10306');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10307');
INSERT INTO `t_sys_role$resource` VALUES ('2', '0');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1');
INSERT INTO `t_sys_role$resource` VALUES ('2', '101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10104');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10105');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10106');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10107');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10108');
INSERT INTO `t_sys_role$resource` VALUES ('2', '102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10202');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10203');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10204');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10205');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10206');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10207');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10208');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10302');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10303');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10304');
INSERT INTO `t_sys_role$resource` VALUES ('2', '103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10305');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10306');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10307');
INSERT INTO `t_sys_role$resource` VALUES ('3', '0');
INSERT INTO `t_sys_role$resource` VALUES ('3', '1');
INSERT INTO `t_sys_role$resource` VALUES ('3', '101');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10102');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10103');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10104');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10105');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10106');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10107');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10108');
INSERT INTO `t_sys_role$resource` VALUES ('3', '102');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10202');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10203');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10204');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10205');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10206');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10207');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10208');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10302');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10303');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10304');
INSERT INTO `t_sys_role$resource` VALUES ('3', '103');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10305');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10306');
INSERT INTO `t_sys_role$resource` VALUES ('3', '10307');
INSERT INTO `t_sys_user` VALUES ('1', 'superadmin', 'superadmin', '412506897@qq.com', '男', '12345678911', '2013-11-24 16:02:18', '2013-11-27 16:51:10', '1', '超管，拥有所有权限');
INSERT INTO `t_sys_user` VALUES ('2', 'admin', 'admin', '123121@qq.com', '男', '12345678911', '2013-11-24 16:02:42', '2013-11-27 16:51:14', '1', '管理员，拥有除权限模块的所有权限');
INSERT INTO `t_sys_user` VALUES ('3', 'user', 'user', 'user123@sina.cn', '女', '12345678911', '2013-11-11 16:03:31', '2013-11-20 16:51:16', '1', '普通用户');
INSERT INTO `t_sys_user` VALUES ('4', 'lx', 'lx', 'lx12312@qq.com', '男', '12345678911', '2013-11-10 16:03:53', '2013-11-27 16:51:25', '1', '普通用户');
INSERT INTO `t_sys_user$role` VALUES ('1', '1');
INSERT INTO `t_sys_user$role` VALUES ('2', '2');
INSERT INTO `t_sys_user$role` VALUES ('3', '3');
INSERT INTO `t_sys_user$role` VALUES ('4', '3');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
