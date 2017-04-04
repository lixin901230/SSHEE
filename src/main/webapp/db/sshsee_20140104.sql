/*
MySQL Data Transfer
Source Host: localhost
Source Database: sshsee
Target Host: localhost
Target Database: sshsee
Date: 2014-1-4 0:25:45
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for t_sys_dictionary
-- ----------------------------
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

-- ----------------------------
-- Table structure for t_sys_log_access
-- ----------------------------
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

-- ----------------------------
-- Table structure for t_sys_log_operation
-- ----------------------------
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

-- ----------------------------
-- Table structure for t_sys_organization
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_organization`;
CREATE TABLE `t_sys_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '构机ID，唯一主键',
  `parentId` varchar(255) DEFAULT NULL COMMENT '构机父ID',
  `orgCode` varchar(255) DEFAULT NULL COMMENT '构机编码',
  `orgName` varchar(255) DEFAULT NULL COMMENT '构机名称',
  `createTime` datetime DEFAULT NULL COMMENT '建创时间',
  `lastUpdateTime` datetime DEFAULT NULL COMMENT '近最修改时间',
  `state` int(11) DEFAULT NULL COMMENT '态状',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_portal
-- ----------------------------
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

-- ----------------------------
-- Table structure for t_sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_resource`;
CREATE TABLE `t_sys_resource` (
  `id` varchar(255) NOT NULL COMMENT '资源ID，唯一主键',
  `parentId` varchar(255) DEFAULT NULL COMMENT '资源的父节点id',
  `nodeCode` varchar(255) DEFAULT NULL COMMENT '资源代码',
  `nodeName` varchar(255) DEFAULT NULL COMMENT '资源名称',
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

-- ----------------------------
-- Table structure for t_sys_role
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Table structure for t_sys_role$resource
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role$resource`;
CREATE TABLE `t_sys_role$resource` (
  `roleId` varchar(11) DEFAULT NULL COMMENT '角色ID',
  `resourceId` int(11) DEFAULT NULL COMMENT '资源ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色跟资源关联表';

-- ----------------------------
-- Table structure for t_sys_user
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Table structure for t_sys_user$resource
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user$resource`;
CREATE TABLE `t_sys_user$resource` (
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `resourceId` int(11) DEFAULT NULL COMMENT '资源ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户跟资源关联表';

-- ----------------------------
-- Table structure for t_sys_user$role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user$role`;
CREATE TABLE `t_sys_user$role` (
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `roleId` int(11) DEFAULT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户跟角色关联表';

-- ----------------------------
-- Table structure for t_sys_user_group
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user_group`;
CREATE TABLE `t_sys_user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户组ID，唯一主键',
  `groupCode` varchar(255) DEFAULT NULL COMMENT '用户组编码',
  `groupName` varchar(255) DEFAULT NULL COMMENT '用户组名',
  `createTime` datetime DEFAULT NULL COMMENT '建创时间',
  `lastUpdateTime` datetime DEFAULT NULL COMMENT '近最修改时间',
  `state` int(11) DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '注备',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `t_sys_resource` VALUES ('0', 'ROOT_NODE', 'welcome', '首页', 'view/common/layout/portal.jsp', 'menu_icon_welcome_page', '2013-12-08 16:07:10', '1', '1', '1', '系统登陆成功后的展示页', 'open');
INSERT INTO `t_sys_resource` VALUES ('1', '0', 'sysMan', '系统管理', '', 'menu_icon_sys_man', '2013-12-08 16:52:06', '0', '1', '1', '模块', 'open');
INSERT INTO `t_sys_resource` VALUES ('101', '1', 'userMan', '用户管理', 'sysman/userAction!toUserListPage.action', 'menu_icon_user_man', '2013-12-08 16:54:44', '1', '1', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10101', '101', 'userManList', '用户列表', 'sysman/userAction!toUserListPage.action', null, '2013-12-08 16:58:03', '2', '1', '1', '功能菜单', null);
INSERT INTO `t_sys_resource` VALUES ('10102', '101', 'userManDetail', '用户查看', '', null, '2013-12-08 16:58:05', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10103', '101', 'userManAdd', '用户添加', '', null, '2013-12-08 17:00:39', '2', '3', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10104', '101', 'userManEdit', '用户修改', '', null, '2013-12-08 17:02:56', '2', '4', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10105', '101', 'userManDel', '用户删除', '', null, '2013-12-08 17:02:58', '2', '5', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10106', '101', 'userAuth', '用户授权', '', null, '2013-12-08 17:03:01', '2', '6', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10107', '101', 'userManImport', '用户导入', '', null, '2013-12-08 17:27:47', '2', '7', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10108', '101', 'userManExport', '用户导出', '', null, '2013-12-08 17:27:50', '2', '8', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('102', '1', 'roleMan', '角色管理', 'sysman/roleAction!toRoleListPage.action', 'menu_icon_role_man', '2013-12-08 17:27:50', '1', '2', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10201', '102', 'roleManList', '角色列表', 'sysman/roleAction!toRoleListPage.action', null, '2013-12-08 17:27:50', '2', '1', '1', '功能菜单', null);
INSERT INTO `t_sys_resource` VALUES ('10202', '102', 'roleManDetail', '角色查看', '', null, '2013-12-08 17:27:50', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10203', '102', 'roleManAdd', '角色添加', '', null, '2013-12-08 17:27:50', '2', '3', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10204', '102', 'roleManEdit', '角色修改', '', null, '2013-12-08 17:27:50', '2', '4', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10205', '102', 'roleManDel', '角色删除', '', null, '2013-12-08 17:27:50', '2', '5', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10206', '102', 'roleManAuth', '角色授权', '', null, '2013-12-08 17:27:50', '2', '6', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10207', '102', 'roleManImport', '角色导入', '', null, '2013-12-08 17:27:50', '2', '7', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10208', '102', 'roleManExport', '角色导出', '', null, '2013-12-08 17:27:50', '2', '8', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10209', '102', null, '角色编辑保存', '', null, null, '2', '9', '1', null, null);
INSERT INTO `t_sys_resource` VALUES ('103', '1', 'resourceMan', '资源管理', 'sysman/resourceAction!toResourceListPage.action', 'menu_icon_resource_man', '2013-12-08 17:27:50', '1', '3', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10301', '103', 'resourceManList', '资源列表', 'sysman/resourceAction!toResourceListPage.action', null, '2013-12-08 17:27:50', '2', '1', '1', '功能菜单', null);
INSERT INTO `t_sys_resource` VALUES ('10302', '103', 'resourceManDetail', '资源查看', '', null, '2013-12-08 17:27:50', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10303', '103', 'resourceManAdd', '资源添加', '', null, '2013-12-08 17:27:50', '2', '3', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10304', '103', 'resourceManEdit', '资源修改', '', null, '2013-12-08 17:27:50', '2', '4', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10305', '103', 'resourceManDel', '资源删除', '', null, '2013-12-08 17:27:50', '2', '5', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10306', '103', 'resourceManImport', '资源导入', '', null, '2013-12-08 17:27:50', '2', '6', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10307', '103', 'resourceManExport', '资源导出', '', null, '2013-12-08 17:27:50', '2', '7', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('104', '1', 'userGroupMan', '用户组管理', '', 'menu_icon_user_group_man', '2013-12-29 17:56:18', '1', '4', '1', '菜单', '');
INSERT INTO `t_sys_resource` VALUES ('105', '1', 'orgMan', '机构管理', '', 'menu_icon_org_man', '2013-12-29 17:56:14', '1', '5', '1', '菜单', '');
INSERT INTO `t_sys_resource` VALUES ('106', '1', 'portalMan', '门户管理', '', 'menu_icon_portal_man', '2014-01-01 23:41:26', '1', '6', '1', '菜单', null);
INSERT INTO `t_sys_resource` VALUES ('107', '1', 'dictionaryMan', '数据字典管理', '', 'menu_icon_dic_man', '2014-01-02 21:50:27', '1', '7', '1', '数据字典管理', null);
INSERT INTO `t_sys_resource` VALUES ('108', '1', 'logMan', '日志管理', '', 'menu_icon_log_man', '2013-12-25 17:33:08', '1', '8', '1', '菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('10801', '108', 'authLogMan', '认证日志管理', '', 'menu_icon_access_log_man', '2013-12-23 17:35:25', '1', '1', '1', '子菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('1080101', '10801', 'authLogList', '认证日志列表', '', '', '2013-12-23 17:40:02', '2', '1', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1080102', '10801', 'authLogImport', '认证日志导入', '', '', '2013-12-23 17:42:06', '2', '2', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1080103', '10801', 'authLogExport', '认证日志导出', '', '', '2013-12-24 17:46:36', '2', '3', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1080104', '10801', 'authLogClean', '认证日志清理', '', '', '2013-12-16 17:47:48', '2', '4', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('10802', '108', 'sysLogMan', '系统日志管理', '', 'menu_icon_sys_log_man', '2013-12-24 17:49:00', '1', '2', '1', '子菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('1080201', '10802', 'sysLogList', '系统日志列表', '', '', '2013-12-13 17:50:08', '2', '1', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1080202', '10802', 'sysLogImport', '系统日志导入', '', '', '2013-12-13 17:50:38', '2', '2', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1080203', '10802', 'sysLogExport', '系统日志导出', '', '', '2013-12-13 17:51:35', '2', '3', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1080204', '10802', 'sysLogClean', '系统日志清理', '', '', '2013-12-13 17:52:16', '2', '4', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('2', '0', 'bizMan', '业务模块', '', 'menu_icon_biz_man', '2014-01-02 21:55:48', '0', '2', '1', '模块', 'open');
INSERT INTO `t_sys_resource` VALUES ('201', '2', 'customMan', '客户管理', '', '', '2014-01-02 21:55:53', '1', '1', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('20101', '201', 'customList', '客户列表', '', '', '2014-01-02 21:55:56', '2', '2', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('20102', '20101', 'customAdd', '客户添加', '', '', '2014-01-02 21:55:58', '2', '3', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('202', '2', 'orderMan', '订单管理', '', 'menu_icon_user_group_man', '2013-12-29 19:13:59', '1', '2', '1', '菜单', '');
INSERT INTO `t_sys_resource` VALUES ('3', '0', 'reportMan', '统计报表管理', '', 'menu_icon_report_man', '2013-12-29 18:59:23', '0', '3', '1', '模块', '');
INSERT INTO `t_sys_role` VALUES ('1', '超级管理员', '1', '2013-11-13 14:11:52', null, '1', '拥有系统所有权限');
INSERT INTO `t_sys_role` VALUES ('2', '系统管理员', '2', '2013-11-18 14:12:28', null, '1', '拥有除授权管理的所有权限');
INSERT INTO `t_sys_role` VALUES ('3', '普通用户', '3', '2013-11-18 14:13:08', null, '1', '拥有除系统管理模块外的访问权限');
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
INSERT INTO `t_sys_role$resource` VALUES ('', '102');
INSERT INTO `t_sys_role$resource` VALUES ('', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('', '10202');
INSERT INTO `t_sys_role$resource` VALUES ('', '10203');
INSERT INTO `t_sys_role$resource` VALUES ('', '10204');
INSERT INTO `t_sys_role$resource` VALUES ('', '10205');
INSERT INTO `t_sys_role$resource` VALUES ('', '10206');
INSERT INTO `t_sys_role$resource` VALUES ('', '10207');
INSERT INTO `t_sys_role$resource` VALUES ('', '10208');
INSERT INTO `t_sys_role$resource` VALUES ('', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('', '10302');
INSERT INTO `t_sys_role$resource` VALUES ('', '10303');
INSERT INTO `t_sys_role$resource` VALUES ('', '10304');
INSERT INTO `t_sys_role$resource` VALUES ('', '103');
INSERT INTO `t_sys_role$resource` VALUES ('', '10305');
INSERT INTO `t_sys_role$resource` VALUES ('', '10306');
INSERT INTO `t_sys_role$resource` VALUES ('', '10307');
INSERT INTO `t_sys_role$resource` VALUES ('11', '101');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10102');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10103');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10104');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10105');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10106');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10107');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10108');
INSERT INTO `t_sys_role$resource` VALUES ('11', '102');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10202');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10203');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10204');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10205');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10206');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10207');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10208');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10209');
INSERT INTO `t_sys_role$resource` VALUES ('11', '103');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10302');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10303');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10304');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10305');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10306');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10307');
INSERT INTO `t_sys_role$resource` VALUES ('11', '104');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10401');
INSERT INTO `t_sys_role$resource` VALUES ('11', '1040101');
INSERT INTO `t_sys_role$resource` VALUES ('11', '1040102');
INSERT INTO `t_sys_role$resource` VALUES ('11', '1040103');
INSERT INTO `t_sys_role$resource` VALUES ('11', '1040104');
INSERT INTO `t_sys_role$resource` VALUES ('11', '10402');
INSERT INTO `t_sys_role$resource` VALUES ('11', '1040201');
INSERT INTO `t_sys_role$resource` VALUES ('11', '1040202');
INSERT INTO `t_sys_role$resource` VALUES ('11', '1040203');
INSERT INTO `t_sys_role$resource` VALUES ('11', '1040204');
INSERT INTO `t_sys_role$resource` VALUES ('11', '105');
INSERT INTO `t_sys_role$resource` VALUES ('11', '106');
INSERT INTO `t_sys_role$resource` VALUES ('11', '2');
INSERT INTO `t_sys_role$resource` VALUES ('11', '201');
INSERT INTO `t_sys_role$resource` VALUES ('11', '20101');
INSERT INTO `t_sys_role$resource` VALUES ('11', '20102');
INSERT INTO `t_sys_role$resource` VALUES ('11', '202');
INSERT INTO `t_sys_role$resource` VALUES ('12', '101');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10102');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10103');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10104');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10105');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10106');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10107');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10108');
INSERT INTO `t_sys_role$resource` VALUES ('12', '102');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10202');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10203');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10204');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10205');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10206');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10207');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10208');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10209');
INSERT INTO `t_sys_role$resource` VALUES ('12', '103');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10302');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10303');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10304');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10305');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10306');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10307');
INSERT INTO `t_sys_role$resource` VALUES ('12', '104');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10401');
INSERT INTO `t_sys_role$resource` VALUES ('12', '1040101');
INSERT INTO `t_sys_role$resource` VALUES ('12', '1040102');
INSERT INTO `t_sys_role$resource` VALUES ('12', '1040103');
INSERT INTO `t_sys_role$resource` VALUES ('12', '1040104');
INSERT INTO `t_sys_role$resource` VALUES ('12', '10402');
INSERT INTO `t_sys_role$resource` VALUES ('12', '1040201');
INSERT INTO `t_sys_role$resource` VALUES ('12', '1040202');
INSERT INTO `t_sys_role$resource` VALUES ('12', '1040203');
INSERT INTO `t_sys_role$resource` VALUES ('12', '1040204');
INSERT INTO `t_sys_role$resource` VALUES ('12', '105');
INSERT INTO `t_sys_role$resource` VALUES ('12', '106');
INSERT INTO `t_sys_role$resource` VALUES ('12', '2');
INSERT INTO `t_sys_role$resource` VALUES ('12', '201');
INSERT INTO `t_sys_role$resource` VALUES ('12', '20101');
INSERT INTO `t_sys_role$resource` VALUES ('12', '20102');
INSERT INTO `t_sys_role$resource` VALUES ('12', '202');
INSERT INTO `t_sys_role$resource` VALUES ('13', '101');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10102');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10103');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10104');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10105');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10106');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10107');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10108');
INSERT INTO `t_sys_role$resource` VALUES ('13', '102');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10202');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10203');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10204');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10205');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10206');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10207');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10208');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10209');
INSERT INTO `t_sys_role$resource` VALUES ('13', '103');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10302');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10303');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10304');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10305');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10306');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10307');
INSERT INTO `t_sys_role$resource` VALUES ('13', '104');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10401');
INSERT INTO `t_sys_role$resource` VALUES ('13', '1040101');
INSERT INTO `t_sys_role$resource` VALUES ('13', '1040102');
INSERT INTO `t_sys_role$resource` VALUES ('13', '1040103');
INSERT INTO `t_sys_role$resource` VALUES ('13', '1040104');
INSERT INTO `t_sys_role$resource` VALUES ('13', '10402');
INSERT INTO `t_sys_role$resource` VALUES ('13', '1040201');
INSERT INTO `t_sys_role$resource` VALUES ('13', '1040202');
INSERT INTO `t_sys_role$resource` VALUES ('13', '1040203');
INSERT INTO `t_sys_role$resource` VALUES ('13', '1040204');
INSERT INTO `t_sys_role$resource` VALUES ('13', '105');
INSERT INTO `t_sys_role$resource` VALUES ('13', '106');
INSERT INTO `t_sys_role$resource` VALUES ('13', '2');
INSERT INTO `t_sys_role$resource` VALUES ('13', '201');
INSERT INTO `t_sys_role$resource` VALUES ('13', '20101');
INSERT INTO `t_sys_role$resource` VALUES ('13', '20102');
INSERT INTO `t_sys_role$resource` VALUES ('13', '202');
INSERT INTO `t_sys_user` VALUES ('1', 'superadmin', 'superadmin', '412506897@qq.com', '男', '12345678911', '2013-11-24 16:02:18', '2013-11-27 16:51:10', '1', '超管，拥有所有权限');
INSERT INTO `t_sys_user` VALUES ('2', 'admin', 'admin', '123121@qq.com', '男', '12345678911', '2013-11-24 16:02:42', '2013-11-27 16:51:14', '1', '管理员，拥有除权限模块的所有权限');
INSERT INTO `t_sys_user` VALUES ('3', 'user', 'user', 'user123@sina.cn', '女', '12345678911', '2013-11-11 16:03:31', '2013-11-20 16:51:16', '1', '普通用户');
INSERT INTO `t_sys_user` VALUES ('4', 'lx', 'lx', 'lx12312@qq.com', '男', '12345678911', null, '2014-01-04 00:23:52', '1', '普通用户');
INSERT INTO `t_sys_user$role` VALUES ('1', '1');
INSERT INTO `t_sys_user$role` VALUES ('3', '3');
INSERT INTO `t_sys_user$role` VALUES ('2', '2');
INSERT INTO `t_sys_user$role` VALUES ('4', '1');
