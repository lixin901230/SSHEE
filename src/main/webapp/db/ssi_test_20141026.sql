/*
SQLyog Community v11.11 (64 bit)
MySQL - 5.1.73-community : Database - sshsee
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

/*Table structure for table `t_sys_dictionary` */

DROP TABLE IF EXISTS `t_sys_dictionary`;

CREATE TABLE `t_sys_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '字典id，唯一主键',
  `parentId` int(11) DEFAULT NULL COMMENT '字典父节点，用于存放比如省、市、县等系统字典数据',
  `dicName` varchar(255) DEFAULT NULL COMMENT '字典数据名称',
  `state` int(11) DEFAULT NULL COMMENT '典字状态，1：可用，0：不可用',
  `createTime` datetime DEFAULT NULL COMMENT '建创时间',
  `lastUpdateTime` datetime DEFAULT NULL COMMENT '近最修改时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_dictionary` */

/*Table structure for table `t_sys_log_access` */

DROP TABLE IF EXISTS `t_sys_log_access`;

CREATE TABLE `t_sys_log_access` (
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

/*Data for the table `t_sys_log_access` */

/*Table structure for table `t_sys_log_operation` */

DROP TABLE IF EXISTS `t_sys_log_operation`;

CREATE TABLE `t_sys_log_operation` (
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

/*Data for the table `t_sys_log_operation` */

/*Table structure for table `t_sys_organization` */

DROP TABLE IF EXISTS `t_sys_organization`;

CREATE TABLE `t_sys_organization` (
  `id` varchar(255) NOT NULL COMMENT '构机ID，唯一主键',
  `parentId` varchar(255) DEFAULT NULL COMMENT '构机父ID',
  `orgCode` varchar(255) DEFAULT NULL COMMENT '构机编码',
  `orgName` varchar(255) DEFAULT NULL COMMENT '构机名称',
  `createTime` datetime DEFAULT NULL COMMENT '建创时间',
  `lastUpdateTime` datetime DEFAULT NULL COMMENT '近最修改时间',
  `statu` int(11) DEFAULT NULL COMMENT '状态，1：可以，0：不可用',
  `iconCls` varchar(255) DEFAULT '' COMMENT '点节图标样式',
  `nodeSort` int(11) DEFAULT NULL COMMENT '排序；同级菜单中，从1开始编序',
  `state` varchar(11) DEFAULT NULL COMMENT '节点状态，是closed还是open',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_organization` */

insert  into `t_sys_organization`(`id`,`parentId`,`orgCode`,`orgName`,`createTime`,`lastUpdateTime`,`statu`,`iconCls`,`nodeSort`,`state`,`remark`) values ('0','ROOT_NODE','ROOT_NODE','组织机构树根节点','2014-02-20 17:46:09','2014-02-20 17:46:11',1,'',1,'open','组织机构根树节点'),('1','0','101','二级组织机构','2014-02-20 17:49:10','2014-02-20 17:49:12',1,'',1,'open',NULL),('2','1','201','三级组织机构','2014-02-20 17:48:35','2014-02-20 17:48:37',1,'',1,'open',NULL),('3','2','301','四级组织机构','2014-02-20 17:49:47','2014-02-20 17:49:49',1,'',1,'open',''),('4','0','401','二级兄弟组织机构1','2014-02-20 17:50:33','2014-02-20 17:50:35',1,'',1,'open',NULL),('5','4','501','三级组织机构','2014-02-20 17:52:13','2014-02-20 17:52:15',1,'',1,'open',NULL),('6','1','601','四级组织机构','2014-02-20 17:53:01','2014-02-20 17:53:03',1,'',1,'open',NULL);

/*Table structure for table `t_sys_portal` */

DROP TABLE IF EXISTS `t_sys_portal`;

CREATE TABLE `t_sys_portal` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '户门ID，唯一主键',
  `portalCode` varchar(255) DEFAULT NULL COMMENT '门户编码',
  `portalName` varchar(255) DEFAULT NULL COMMENT '户门名称',
  `portalIcon` varchar(255) DEFAULT NULL COMMENT '户门图标',
  `createTime` datetime DEFAULT NULL COMMENT '建创时间',
  `lastUpdateTime` datetime DEFAULT NULL COMMENT '近最修改时间',
  `state` int(11) DEFAULT NULL COMMENT '态状',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_portal` */

/*Table structure for table `t_sys_resource` */

DROP TABLE IF EXISTS `t_sys_resource`;

CREATE TABLE `t_sys_resource` (
  `id` varchar(255) NOT NULL COMMENT '资源ID，唯一主键',
  `parentId` varchar(255) DEFAULT NULL COMMENT '资源的父节点id',
  `resourceCode` varchar(255) DEFAULT NULL COMMENT '资源代码',
  `resourceName` varchar(255) DEFAULT NULL COMMENT '资源名称',
  `url` varchar(255) DEFAULT NULL COMMENT 'url',
  `iconCls` varchar(255) DEFAULT NULL COMMENT '点节图标样式',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `isMenu` int(11) DEFAULT NULL COMMENT '是否为模块、菜单或者功能点，0：块模，1：菜单，2：功能点',
  `nodeSort` int(11) DEFAULT NULL COMMENT '排序；同级菜单中，从1开始编序',
  `statu` int(11) DEFAULT NULL COMMENT '状态，1：可以，0：不可用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `state` varchar(255) DEFAULT NULL COMMENT '节点状态，是closed还是open',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源信息表';

/*Data for the table `t_sys_resource` */

insert  into `t_sys_resource`(`id`,`parentId`,`resourceCode`,`resourceName`,`url`,`iconCls`,`createTime`,`isMenu`,`nodeSort`,`statu`,`remark`,`state`) values ('0','ROOT_NODE','welcome','主页','view/common/layout/portal.jsp','menu_icon_welcome_page','2013-12-08 16:07:10',1,1,1,'系统登陆成功后的展示页','open'),('1','0','sysMan','系统管理','','menu_icon_sys_man','2013-12-08 16:52:06',0,1,1,'模块',''),('101','1','userMan','用户管理','/sysman/userAction!toUserListPage.action','menu_icon_user_man','2013-12-08 16:54:44',1,1,1,'菜单','closed'),('10101','101','userManList','用户列表','/sysman/userAction!toUserListPage.action',NULL,'2013-12-08 16:58:03',2,1,1,'功能菜单','open'),('1010101','10101','userManDetail','用户查看','',NULL,'2013-12-08 16:58:05',2,2,1,'功能点',NULL),('1010102','10101','userManAdd','用户添加','/sysman/userAction!toAddUserPage.action',NULL,'2013-12-08 17:00:39',2,3,1,'功能点',NULL),('1010103','10101','userManEdit','用户修改','/sysman/userAction!toEditUserPage.action*',NULL,'2013-12-08 17:02:56',2,4,1,'功能点',NULL),('1010104','10101','userManDel','用户删除','/sysman/userAction!deleteUser.action',NULL,'2013-12-08 17:02:58',2,5,1,'功能点',NULL),('1010105','10101','userManAuth','用户授权','/sysman/userAction!toUserAuthPage.action*',NULL,'2013-12-08 17:03:01',2,6,1,'功能点',NULL),('1010106','10101','userManImport','用户导入','',NULL,'2013-12-08 17:27:47',2,7,1,'功能点',NULL),('1010107','10101','userManExport','用户导出','',NULL,'2013-12-08 17:27:50',2,8,1,'功能点',NULL),('102','1','roleMan','角色管理','/sysman/roleAction!toRoleListPage.action','menu_icon_role_man','2013-12-08 17:27:50',1,2,1,'菜单','closed'),('10201','102','roleManList','角色列表','/sysman/roleAction!toRoleListPage.action',NULL,'2013-12-08 17:27:50',2,1,1,'功能菜单','open'),('1020101','10201','roleManDetail','角色查看','',NULL,'2013-12-08 17:27:50',2,2,1,'功能点',NULL),('1020102','10201','roleManAdd','角色添加','/sysman/roleAction!toAddRolePage.action',NULL,'2013-12-08 17:27:50',2,3,1,'功能点',NULL),('1020103','10201','roleManEdit','角色修改','/sysman/roleAction!getEditRole.action*',NULL,'2013-12-08 17:27:50',2,4,1,'功能点',NULL),('1020104','10201','roleManDel','角色删除','/sysman/roleAction!deleteRole.action',NULL,'2013-12-08 17:27:50',2,5,1,'功能点',NULL),('1020105','10201','roleManAuth','角色授权','',NULL,'2013-12-08 17:27:50',2,6,1,'功能点',NULL),('1020106','10201','roleManImport','角色导入','',NULL,'2013-12-08 17:27:50',2,7,1,'功能点',NULL),('1020107','10201','roleManExport','角色导出','',NULL,'2013-12-08 17:27:50',2,8,1,'功能点',NULL),('1020108','10201','roleManEidtSave','角色编辑保存','',NULL,'2014-01-15 23:47:01',2,9,1,'功能点',NULL),('103','1','resourceMan','资源管理','/sysman/resourceAction!toResourceListPage.action','menu_icon_resource_man','2013-12-08 17:27:50',1,3,1,'菜单','closed'),('10301','103','resourceManList','资源列表','/sysman/resourceAction!toResourceListPage.action',NULL,'2013-12-08 17:27:50',2,1,1,'功能菜单','open'),('1030101','10301','resourceManDetail','资源查看','',NULL,'2013-12-08 17:27:50',2,2,1,'功能点',NULL),('1030102','10301','resourceManAdd','资源添加','/sysman/resourceAction!toAddResourcePage.action',NULL,'2013-12-08 17:27:50',2,3,1,'功能点',NULL),('1030103','10301','resourceManEdit','资源修改','',NULL,'2013-12-08 17:27:50',2,4,1,'功能点',NULL),('1030104','10301','resourceManDel','资源删除','',NULL,'2013-12-08 17:27:50',2,5,1,'功能点',NULL),('1030105','10301','resourceManImport','资源导入','',NULL,'2013-12-08 17:27:50',2,6,1,'功能点',NULL),('1030106','10301','resourceManExport','资源导出','',NULL,'2013-12-08 17:27:50',2,7,1,'功能点',NULL),('104','1','authMan','授权管理','/sysman/authAction!toAuthUserListPage.action','index_icon_center','2014-02-13 00:28:32',1,4,1,'菜单','closed'),('10401','104','authList','授权用户列表','/sysman/authAction!toAuthUserListPage.action','menu_icon_biz_man','2014-02-13 00:59:10',2,2,1,'菜单','open'),('1040101','10401','authShow','查看权限','/sysman/authAction!toAuthUserListPage.action','menu_icon_biz_man','2014-02-13 00:59:10',2,2,1,'菜单',''),('1040102','10401','authAdd','增加授权',NULL,NULL,'2014-02-13 00:41:55',2,2,1,'功能点',NULL),('1040103','10401','authRemove','移除授权',NULL,NULL,'2014-02-13 00:59:08',2,3,1,'功能点',NULL),('1040104','10401','authEdit','修改授权','/sysman/authAction!loadAuthMainPage.action','menu_icon_biz_man','2014-02-13 00:59:10',2,2,1,'菜单',''),('1040105','10401','authExport','导出',NULL,NULL,'2014-02-13 00:59:13',2,1,1,'功能点',''),('1040106','10401','authImport','导入',NULL,NULL,'2014-02-13 00:59:15',2,2,1,'功能点',NULL),('105','1','userGroupMan','用户组管理','/sysman/userGroupAction!toUserGroupListPage.action','menu_icon_user_group_man','2013-12-29 17:56:18',1,4,1,'菜单','closed'),('10501','105','userGroupList','用户组列表','/sysman/userGroupAction!toUserGroupListPage.action','','2014-02-13 00:07:22',2,1,1,'功能菜单','open'),('1050101','10501','userGroupDetail','用户组查看','','','2014-02-13 00:07:20',2,1,1,'功能点',''),('1050102','10501','userGroupAdd','用户组添加','','','2014-02-13 00:07:18',2,2,1,'功能点',''),('1050103','10501','userGroupAddUser','用户组加入用户','','','2014-02-13 00:07:15',2,3,1,'功能点',''),('1050104','10501','userGroupRemoveUser','用户组移除用户','','','2014-02-13 00:07:13',2,4,1,'功能点',''),('1050105','10501','userGroupEdit','用户组编辑','','','2014-02-13 00:07:10',2,5,1,'功能点',''),('1050106','10501','userGroupDel','用户组删除','','','2014-02-13 00:07:08',2,6,1,'功能点',''),('1050107','10501','userGroupImportTemplateExcel','用户组导入模板','','','2014-02-13 00:07:05',2,7,1,'功能点',''),('1050108','10501','userGroupImport','用户组导入','','','2014-02-13 00:07:01',2,8,1,'功能点',''),('1050109','10501','userGroupExport','用户组导出','','','2014-02-13 00:11:16',2,9,1,'功能点',''),('106','1','orgInfoMan','组织机构管理','/sysman/orgInfoAction!toOrgInfoListPage.action','menu_icon_org_man','2013-12-29 17:56:14',1,5,1,'菜单','closed'),('10601','106','orgInfoList','机构列表','/sysman/orgInfoAction!toOrgInfoListPage.action','','2014-02-13 00:07:22',2,1,1,'功能菜单','open'),('1060101','10601','orgInfoDetail','机构查看','','','2014-02-13 00:07:20',2,1,1,'功能点',''),('1060102','10601','orgInfoAdd','机构添加','','','2014-02-13 00:07:18',2,2,1,'功能点',''),('1060103','10601','orgInfoEdit','机构编辑',NULL,NULL,'2014-02-13 00:07:10',2,5,1,'功能点',NULL),('1060104','10601','orgInfoDel','机构删除','','','2014-02-13 00:07:08',2,6,1,'功能点',''),('1060105','10601','orgInfoImportTemplateExcel','机构导入模板','','','2014-02-13 00:07:05',2,7,1,'功能点',''),('1060106','10601','orgInfoImport','机构导入','','','2014-02-13 00:07:01',2,8,1,'功能点',''),('1060107','10601','orgInfoExport','机构导出','','','2014-02-13 00:11:16',2,9,1,'功能点',NULL),('1060108','10601','orgInfoAddUser','机构加入用户','','','2014-02-13 00:07:15',2,3,1,'功能点',''),('1060109','10601','orgInfoRemoveUser','机构移除用户','','','2014-02-13 00:07:13',2,4,1,'功能点',''),('107','1','portalMan','门户管理','','menu_icon_portal_man','2014-01-01 23:41:26',1,6,1,'菜单','closed'),('10701','107','portalCurrLogoShow','门户当前LOGO查看',NULL,NULL,'2014-02-13 01:03:30',2,1,1,'功能菜单','open'),('10702','107','portalLogoListMore','更多门户LOGO（列表）',NULL,NULL,'2014-02-13 01:05:37',2,2,1,'功能点',NULL),('10703','107','portalLogoUpload','门户LOGO上传',NULL,NULL,'2014-02-13 01:05:37',2,3,1,'功能点',NULL),('10704','107','portalLogoChange','门户LOGO更换',NULL,NULL,'2014-02-13 01:10:34',2,4,1,'功能点',NULL),('10705','107','portalLogoEdit','门户LOGO删除',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('108','1','dicMan','数据字典管理','','menu_icon_dic_man','2014-01-02 21:50:27',1,7,1,'数据字典管理','closed'),('10801','108','dicDataList','字典数据列表',NULL,NULL,'2014-02-13 01:19:29',2,1,1,'功能菜单','open'),('1080101','10801','dicDataAdd','字典数据添加',NULL,NULL,'2014-02-13 01:19:26',2,1,1,'功能点',NULL),('1080102','10801','dicDataEdit','字典数据编辑',NULL,NULL,'2014-02-13 01:19:24',2,2,1,'功能点',NULL),('1080103','10801','dicDataDel','字典数据删除',NULL,NULL,'2014-02-13 01:19:22',2,3,1,'功能点',NULL),('1080104','10801','dicDataTempleteExcel','字典数据Excel导入模板',NULL,NULL,'2014-02-13 01:19:20',2,4,1,'功能点',NULL),('1080105','10801','dicDataImportExcel','字典数据导入Excel',NULL,NULL,'2014-02-13 01:19:17',2,5,1,'功能点',NULL),('1080106','10801','dicDataExportExcel','字典数据导出Excel',NULL,NULL,'2014-02-13 01:19:15',2,6,1,'功能点',NULL),('109','1','logMan','日志管理','','menu_icon_log_man','2013-12-25 17:33:08',1,8,1,'菜单','open'),('10901','109','authLogMan','认证日志管理','','menu_icon_access_log_man','2013-12-23 17:35:25',1,1,1,'子菜单','closed'),('1090101','10901','authLogList','认证日志列表','','','2013-12-23 17:40:02',2,1,1,'功能菜单','open'),('109010101','1090101','authLogImport','认证日志导入','','','2013-12-23 17:42:06',2,2,1,'功能点',''),('109010102','1090101','authLogExport','认证日志导出','','','2013-12-24 17:46:36',2,3,1,'功能点',''),('109010103','1090101','authLogClean','认证日志清理','','','2013-12-16 17:47:48',2,4,1,'功能点',''),('10902','109','sysLogMan','系统日志管理','','menu_icon_sys_log_man','2013-12-24 17:49:00',1,2,1,'子菜单','closed'),('1090201','10902','sysLogList','系统日志列表','','','2013-12-13 17:50:08',2,1,1,'功能菜单','open'),('109020101','1090201','sysLogImport','系统日志导入','','','2013-12-13 17:50:38',2,2,1,'功能点',''),('109020102','1090201','sysLogExport','系统日志导出','','','2013-12-13 17:51:35',2,3,1,'功能点',''),('109020103','1090201','sysLogClean','系统日志清理','','','2013-12-13 17:52:16',2,4,1,'功能点',''),('2','0','exampleMan','技术攻关','','menu_icon_biz_man','2014-01-02 21:55:48',0,2,1,'模块',''),('201','2','exampleTree','树形示例','','menu_icon_resource_man','2014-01-02 21:55:53',1,1,1,'菜单','closed'),('20101','201','exampleZTree','zTree示例','/view/plugDemo/tree/zTree/ztreeDemo.jsp','','2014-01-02 21:55:56',1,2,1,'菜单','open'),('20102','201','exampleDTree','dTree示例','','','2014-01-02 21:55:58',1,3,1,'菜单','open'),('20103','201','exampleDhtmlxTree','dhtmlxTree示例','','menu_icon_user_group_man','2013-12-29 19:13:59',1,2,1,'菜单','open'),('202','2','examplePagerPlugin','jQuery Ajax分页插件示例','/sysman/userAction!loadUserListPage.action?pager.pageSize=3','menu_icon_sys_log_man','2014-09-03 01:27:50',1,2,1,'功能菜单','open'),('203','2','exampleJqGrid','JqGrid示例','/view/study/plugindemo/jqgrid/jqgrid_demo.jsp','menu_icon_sys_log_man','2014-10-25 18:01:48',1,3,1,'功能点','open'),('3','0','reportMan','统计报表管理','','menu_icon_report_man','2013-12-29 18:59:23',0,3,1,'模块',''),('402881e84503fc8d0145041e68f70001','109','123','123','123','menu_icon_sys_log_man','2014-03-27 23:17:52',1,1,1,'123','open'),('402881e84503fc8d014504203cdc0002','402881e84503fc8d0145041e68f70001','321','测试测试','321123','menu_icon_log_man, menu_icon_log_man','2014-03-27 23:19:52',2,1,1,'321123',NULL);

/*Table structure for table `t_sys_role` */

DROP TABLE IF EXISTS `t_sys_role`;

CREATE TABLE `t_sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID，唯一字段',
  `roleName` varchar(255) DEFAULT NULL COMMENT '色角名称',
  `roleType` varchar(255) DEFAULT 'NULL' COMMENT '角色类型；1：超级管理员，2：系统管理员；3：普通用户',
  `createTime` datetime DEFAULT NULL COMMENT '建时时间',
  `lastUpdateTime` datetime DEFAULT NULL COMMENT '最近更新时间',
  `state` int(11) DEFAULT NULL COMMENT '角色状态；0：禁用；1：启用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

/*Data for the table `t_sys_role` */

insert  into `t_sys_role`(`id`,`roleName`,`roleType`,`createTime`,`lastUpdateTime`,`state`,`remark`) values (1,'超级管理员','1','2013-11-13 14:11:52','2014-10-26 01:45:12',1,'拥有系统所有权限'),(2,'系统管理员','2','2013-11-18 14:12:28','2014-10-26 01:45:16',1,'拥有除授权管理的所有权限'),(3,'普通用户','3','2013-11-18 14:13:08','2014-09-03 01:31:06',1,'拥有除系统管理模块外的访问权限');

/*Table structure for table `t_sys_role$resource` */

DROP TABLE IF EXISTS `t_sys_role$resource`;

CREATE TABLE `t_sys_role$resource` (
  `roleId` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `resourceId` varchar(32) DEFAULT NULL COMMENT '资源ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色跟资源关联表';

/*Data for the table `t_sys_role$resource` */

insert  into `t_sys_role$resource`(`roleId`,`resourceId`) values ('3','0'),('3','2'),('3','201'),('3','20101'),('3','20102'),('3','202'),('3','3'),('1','0'),('1','1'),('1','101'),('1','10101'),('1','1010101'),('1','1010102'),('1','1010103'),('1','1010104'),('1','1010105'),('1','1010106'),('1','1010107'),('1','102'),('1','10201'),('1','1020101'),('1','1020102'),('1','1020103'),('1','1020104'),('1','1020105'),('1','1020106'),('1','1020107'),('1','1020108'),('1','103'),('1','10301'),('1','1030101'),('1','1030102'),('1','1030103'),('1','1030104'),('1','1030105'),('1','1030106'),('1','104'),('1','10401'),('1','1040101'),('1','1040102'),('1','1040103'),('1','1040104'),('1','1040105'),('1','1040106'),('1','105'),('1','10501'),('1','1050101'),('1','1050102'),('1','1050103'),('1','1050104'),('1','1050105'),('1','1050106'),('1','1050107'),('1','1050108'),('1','1050109'),('1','106'),('1','10601'),('1','1060101'),('1','1060102'),('1','1060103'),('1','1060104'),('1','1060105'),('1','1060106'),('1','1060107'),('1','1060108'),('1','1060109'),('1','107'),('1','10701'),('1','10702'),('1','10703'),('1','10704'),('1','10705'),('1','108'),('1','10801'),('1','1080101'),('1','1080102'),('1','1080103'),('1','1080104'),('1','1080105'),('1','1080106'),('1','109'),('1','10901'),('1','1090101'),('1','109010101'),('1','109010102'),('1','109010103'),('1','10902'),('1','1090201'),('1','109020101'),('1','109020102'),('1','109020103'),('1','2'),('1','201'),('1','20101'),('1','20102'),('1','20103'),('1','202'),('1','203'),('1','3'),('2','0'),('2','1'),('2','101'),('2','10101'),('2','1010101'),('2','1010102'),('2','1010103'),('2','1010104'),('2','1010105'),('2','1010106'),('2','1010107'),('2','102'),('2','10201'),('2','1020101'),('2','1020102'),('2','1020103'),('2','1020104'),('2','1020105'),('2','1020106'),('2','1020107'),('2','1020108'),('2','103'),('2','10301'),('2','1030101'),('2','1030102'),('2','1030103'),('2','1030104'),('2','1030105'),('2','1030106'),('2','104'),('2','10401'),('2','1040101'),('2','1040102'),('2','1040103'),('2','1040104'),('2','1040105'),('2','1040106'),('2','105'),('2','10501'),('2','1050101'),('2','1050102'),('2','1050103'),('2','1050104'),('2','1050105'),('2','1050106'),('2','1050107'),('2','1050108'),('2','1050109'),('2','106'),('2','10601'),('2','1060101'),('2','1060102'),('2','1060103'),('2','1060104'),('2','1060105'),('2','1060106'),('2','1060107'),('2','1060108'),('2','1060109'),('2','107'),('2','10701'),('2','10702'),('2','10703'),('2','10704'),('2','10705'),('2','108'),('2','10801'),('2','1080101'),('2','1080102'),('2','1080103'),('2','1080104'),('2','1080105'),('2','1080106'),('2','109'),('2','10901'),('2','1090101'),('2','109010101'),('2','109010102'),('2','109010103'),('2','10902'),('2','1090201'),('2','109020101'),('2','109020102'),('2','109020103'),('2','2'),('2','201'),('2','20101'),('2','20102'),('2','20103'),('2','202'),('2','203'),('2','3');

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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

/*Data for the table `t_sys_user` */

insert  into `t_sys_user`(`id`,`userName`,`password`,`email`,`sex`,`telphone`,`createTime`,`lastUpdateTime`,`statu`,`remark`) values (1,'initAdmin','initAdmin','412506897@qq.com','男','12345678911','2013-11-24 16:02:18','2013-11-27 16:51:10',1,'超管，拥有所有权限'),(2,'admin','admin','123121@qq.com','男','12345678911','2013-11-24 16:02:42','2013-11-27 16:51:14',1,'管理员，拥有除权限模块的所有权限'),(4,'lx','lx','lx12312@qq.com','男','12345678911','2014-01-14 10:47:21','2014-02-19 22:27:12',1,'普通用户'),(40,'asdf','asdf','fsadf','sad','sadf','2014-09-23 21:16:21',NULL,1,'asdf'),(41,'asdf','sadf','dfsa','as','asdf','2014-09-23 21:16:28',NULL,1,'asdf'),(42,'asdf','asdf','dasdf','asf','asdf','2014-09-23 21:16:36',NULL,1,'asdf'),(43,'12','12','12','12','12','2014-09-23 21:17:08',NULL,1,'12'),(44,'asdf','asdf','asdf','asf','asf','2014-09-23 21:17:44',NULL,1,'sadf'),(45,'asdf','sadf','asdf','sadf','asfd','2014-09-23 21:17:52',NULL,1,'asdf'),(46,'33','3','3','3','3','2014-09-23 22:51:43',NULL,1,'33'),(47,'34','4','4','4','4','2014-09-23 22:51:52',NULL,1,'4'),(48,'5','5','5','5','5','2014-09-23 22:52:01',NULL,1,'5'),(49,'7','7','7','7','7','2014-09-23 22:52:17',NULL,1,'7'),(50,'8','8','8','8','8','2014-09-23 22:52:25',NULL,1,'8'),(51,'9','9','9','9','9','2014-09-23 22:52:31',NULL,1,'9'),(52,'23','23','23','23','23','2014-09-23 22:52:43',NULL,3,'323'),(53,'33','33','33','33','333','2014-09-23 22:53:14',NULL,1,'33'),(54,'44','44','44','44','44','2014-09-23 22:53:23',NULL,1,'44'),(55,'55','55','55','55','55','2014-09-23 22:53:30',NULL,1,'55'),(56,'233','233','2323','233','233','2014-09-23 22:53:48',NULL,1,'233'),(57,'123321','321','123','123','231','2014-09-23 22:54:08',NULL,1,'321'),(58,'442','224','442','442','442','2014-09-23 22:54:25',NULL,1,'242'),(59,'12312312','1321','132','12312','12312','2014-09-23 22:54:35',NULL,1,'123123');

/*Table structure for table `t_sys_user$organization` */

DROP TABLE IF EXISTS `t_sys_user$organization`;

CREATE TABLE `t_sys_user$organization` (
  `userId` int(11) DEFAULT NULL COMMENT '户用ID',
  `orgId` varchar(32) DEFAULT NULL COMMENT '组织机构ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_user$organization` */

insert  into `t_sys_user$organization`(`userId`,`orgId`) values (2,'1'),(1,'1'),(3,'1'),(4,'1'),(1,'2'),(2,'2'),(3,'2'),(1,'3'),(2,'3'),(3,'3'),(2,'4'),(3,'4'),(4,'4'),(1,'4'),(1,'5'),(3,'5'),(2,'5'),(4,'5'),(1,'6'),(2,'6'),(3,'6'),(4,'6');

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

insert  into `t_sys_user$role`(`userId`,`roleId`) values (1,1),(4,3),(2,2),(40,3),(41,3),(42,1),(43,3),(44,1),(45,1),(46,2),(47,1),(48,3),(49,2),(50,1),(51,1),(52,2),(53,1),(54,1),(55,1),(56,1),(57,3),(58,1),(59,1);

/*Table structure for table `t_sys_user$user_group` */

DROP TABLE IF EXISTS `t_sys_user$user_group`;

CREATE TABLE `t_sys_user$user_group` (
  `userId` int(11) DEFAULT NULL COMMENT '户用ID',
  `userGroupId` varchar(32) DEFAULT NULL COMMENT '用户组ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_user$user_group` */

insert  into `t_sys_user$user_group`(`userId`,`userGroupId`) values (1,'2c908bcd44493c38014449536b050001'),(2,'402881ee443a199901443a2338510002'),(2,'2c908bcd44493c38014449536b050001'),(3,'2c908bcd44493c38014449536b050001'),(4,'2c908bcd44493c38014449536b050001'),(1,'402881ee443a199901443a2338510002'),(3,'402881ee443a199901443a4e8da40005'),(4,'402881ee443a199901443a4e8da40005');

/*Table structure for table `t_sys_user_group` */

DROP TABLE IF EXISTS `t_sys_user_group`;

CREATE TABLE `t_sys_user_group` (
  `id` varchar(32) NOT NULL COMMENT '用户组ID，唯一主键',
  `groupCode` varchar(255) DEFAULT NULL COMMENT '用户组编码',
  `groupName` varchar(255) DEFAULT NULL COMMENT '用户组名',
  `createTime` datetime DEFAULT NULL COMMENT '建创时间',
  `lastUpdateTime` datetime DEFAULT NULL COMMENT '近最修改时间',
  `statu` int(11) DEFAULT NULL COMMENT '状态，1：可以，0：不可用',
  `remark` varchar(255) DEFAULT NULL COMMENT '注备',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_user_group` */

insert  into `t_sys_user_group`(`id`,`groupCode`,`groupName`,`createTime`,`lastUpdateTime`,`statu`,`remark`) values ('2c908bcd44493c38014449536b050001','d53cc8e4-ebbe-4501-9b16-089515d7','123','2014-02-19 16:46:45','2014-02-19 16:46:45',1,'123'),('402881ee443a199901443a2338510002',NULL,'11','2014-02-16 17:59:50','2014-02-16 17:59:50',1,'11'),('402881ee443a199901443a4e8da40005','749434fb-4d74-43b5-a2e8-821468f9','1234','2014-02-16 18:47:10','2014-02-16 18:47:10',1,'123');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
