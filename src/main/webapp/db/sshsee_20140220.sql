/*
MySQL Data Transfer
Source Host: localhost
Source Database: sshsee
Target Host: localhost
Target Database: sshsee
Date: 2014-2-21 0:55:40
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Table structure for t_sys_role$resource
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role$resource`;
CREATE TABLE `t_sys_role$resource` (
  `roleId` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `resourceId` varchar(32) DEFAULT NULL COMMENT '资源ID'
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Table structure for t_sys_user$organization
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user$organization`;
CREATE TABLE `t_sys_user$organization` (
  `userId` int(11) DEFAULT NULL COMMENT '户用ID',
  `orgId` varchar(32) DEFAULT NULL COMMENT '组织机构ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for t_sys_user$user_group
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user$user_group`;
CREATE TABLE `t_sys_user$user_group` (
  `userId` int(11) DEFAULT NULL COMMENT '户用ID',
  `userGroupId` varchar(32) DEFAULT NULL COMMENT '用户组ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_user_group
-- ----------------------------
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

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `t_sys_organization` VALUES ('0', 'ROOT_NODE', 'ROOT_NODE', '组织机构树根节点', '2014-02-20 17:46:09', '2014-02-20 17:46:11', '1', '', '1', 'open', '组织机构根树节点');
INSERT INTO `t_sys_organization` VALUES ('1', '0', '101', '二级组织机构', '2014-02-20 17:49:10', '2014-02-20 17:49:12', '1', '', '1', 'open', null);
INSERT INTO `t_sys_organization` VALUES ('2', '1', '201', '三级组织机构', '2014-02-20 17:48:35', '2014-02-20 17:48:37', '1', '', '1', 'open', null);
INSERT INTO `t_sys_organization` VALUES ('3', '2', '301', '四级组织机构', '2014-02-20 17:49:47', '2014-02-20 17:49:49', '1', '', '1', 'open', '');
INSERT INTO `t_sys_organization` VALUES ('4', '0', '401', '二级兄弟组织机构1', '2014-02-20 17:50:33', '2014-02-20 17:50:35', '1', '', '1', 'open', null);
INSERT INTO `t_sys_organization` VALUES ('5', '4', '501', '三级组织机构', '2014-02-20 17:52:13', '2014-02-20 17:52:15', '1', '', '1', 'open', null);
INSERT INTO `t_sys_organization` VALUES ('6', '1', '601', '四级组织机构', '2014-02-20 17:53:01', '2014-02-20 17:53:03', '1', '', '1', 'open', null);
INSERT INTO `t_sys_resource` VALUES ('0', 'ROOT_NODE', 'welcome', '主页', 'view/common/layout/portal.jsp', 'menu_icon_welcome_page', '2013-12-08 16:07:10', '1', '1', '1', '系统登陆成功后的展示页', 'open');
INSERT INTO `t_sys_resource` VALUES ('1', '0', 'sysMan', '系统管理', '', 'menu_icon_sys_man', '2013-12-08 16:52:06', '0', '1', '1', '模块', '');
INSERT INTO `t_sys_resource` VALUES ('101', '1', 'userMan', '用户管理', '/sysman/userAction!toUserListPage.action', 'menu_icon_user_man', '2013-12-08 16:54:44', '1', '1', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10101', '101', 'userManList', '用户列表', '/sysman/userAction!toUserListPage.action', null, '2013-12-08 16:58:03', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('1010101', '10101', 'userManDetail', '用户查看', '', null, '2013-12-08 16:58:05', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1010102', '10101', 'userManAdd', '用户添加', '/sysman/userAction!toAddUserPage.action', null, '2013-12-08 17:00:39', '2', '3', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1010103', '10101', 'userManEdit', '用户修改', '/sysman/userAction!toEditUserPage.action*', null, '2013-12-08 17:02:56', '2', '4', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1010104', '10101', 'userManDel', '用户删除', '/sysman/userAction!deleteUser.action', null, '2013-12-08 17:02:58', '2', '5', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1010105', '10101', 'userManAuth', '用户授权', '/sysman/userAction!toUserAuthPage.action*', null, '2013-12-08 17:03:01', '2', '6', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1010106', '10101', 'userManImport', '用户导入', '', null, '2013-12-08 17:27:47', '2', '7', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1010107', '10101', 'userManExport', '用户导出', '', null, '2013-12-08 17:27:50', '2', '8', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('102', '1', 'roleMan', '角色管理', '/sysman/roleAction!toRoleListPage.action', 'menu_icon_role_man', '2013-12-08 17:27:50', '1', '2', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10201', '102', 'roleManList', '角色列表', '/sysman/roleAction!toRoleListPage.action', null, '2013-12-08 17:27:50', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('1020101', '10201', 'roleManDetail', '角色查看', '', null, '2013-12-08 17:27:50', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1020102', '10201', 'roleManAdd', '角色添加', '/sysman/roleAction!toAddRolePage.action', null, '2013-12-08 17:27:50', '2', '3', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1020103', '10201', 'roleManEdit', '角色修改', '/sysman/roleAction!getEditRole.action*', null, '2013-12-08 17:27:50', '2', '4', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1020104', '10201', 'roleManDel', '角色删除', '/sysman/roleAction!deleteRole.action', null, '2013-12-08 17:27:50', '2', '5', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1020105', '10201', 'roleManAuth', '角色授权', '', null, '2013-12-08 17:27:50', '2', '6', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1020106', '10201', 'roleManImport', '角色导入', '', null, '2013-12-08 17:27:50', '2', '7', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1020107', '10201', 'roleManExport', '角色导出', '', null, '2013-12-08 17:27:50', '2', '8', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1020108', '10201', 'roleManEidtSave', '角色编辑保存', '', null, '2014-01-15 23:47:01', '2', '9', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('103', '1', 'resourceMan', '资源管理', '/sysman/resourceAction!toResourceListPage.action', 'menu_icon_resource_man', '2013-12-08 17:27:50', '1', '3', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10301', '103', 'resourceManList', '资源列表', '/sysman/resourceAction!toResourceListPage.action', null, '2013-12-08 17:27:50', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('1030101', '10301', 'resourceManDetail', '资源查看', '', null, '2013-12-08 17:27:50', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1030102', '10301', 'resourceManAdd', '资源添加', '/sysman/resourceAction!toAddResourcePage.action', null, '2013-12-08 17:27:50', '2', '3', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1030103', '10301', 'resourceManEdit', '资源修改', '', null, '2013-12-08 17:27:50', '2', '4', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1030104', '10301', 'resourceManDel', '资源删除', '', null, '2013-12-08 17:27:50', '2', '5', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1030105', '10301', 'resourceManImport', '资源导入', '', null, '2013-12-08 17:27:50', '2', '6', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1030106', '10301', 'resourceManExport', '资源导出', '', null, '2013-12-08 17:27:50', '2', '7', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('104', '1', 'authMan', '授权管理', '', ', index_icon_center,  index_icon_center', '2014-02-13 00:28:32', '1', '4', '1', '菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('10401', '104', 'authManList', '授权管理列表', '', ', menu_icon_access_log_man', '2014-02-13 00:35:03', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('1040101', '10401', 'authUserGroupList', '授权用户组列表', '', ', menu_icon_log_man', '2014-02-13 00:41:52', '2', '1', '1', '功能点', 'closed');
INSERT INTO `t_sys_resource` VALUES ('104010101', '1040101', 'authUserGroupAdd', '增加授权用户组', null, null, '2014-02-13 00:41:55', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('104010102', '1040101', 'authUserGroupRemove', '移除授权用户组', null, null, '2014-02-13 00:59:08', '2', '3', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1040102', '10401', 'authOrgList', '授权机构列表', '', ', menu_icon_biz_man', '2014-02-13 00:59:10', '2', '2', '1', '功能点', 'closed');
INSERT INTO `t_sys_resource` VALUES ('104010201', '1040102', 'authOrgAdd', '增加授权机构', null, null, '2014-02-13 00:59:13', '2', '1', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('104010202', '1040102', 'authOrgRemove', '移除授权机构', null, null, '2014-02-13 00:59:15', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('105', '1', 'userGroupMan', '用户组管理', '/sysman/userGroupAction!toUserGroupListPage.action', 'menu_icon_user_group_man', '2013-12-29 17:56:18', '1', '4', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10501', '105', 'userGroupList', '用户组列表', '/sysman/userGroupAction!toUserGroupListPage.action', '', '2014-02-13 00:07:22', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('1050101', '10501', 'userGroupDetail', '用户组查看', '', '', '2014-02-13 00:07:20', '2', '1', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1050102', '10501', 'userGroupAdd', '用户组添加', '', '', '2014-02-13 00:07:18', '2', '2', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1050103', '10501', 'userGroupAddUser', '用户组加入用户', '', '', '2014-02-13 00:07:15', '2', '3', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1050104', '10501', 'userGroupRemoveUser', '用户组移除用户', '', '', '2014-02-13 00:07:13', '2', '4', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1050105', '10501', 'userGroupEdit', '用户组编辑', '', '', '2014-02-13 00:07:10', '2', '5', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1050106', '10501', 'userGroupDel', '用户组删除', '', '', '2014-02-13 00:07:08', '2', '6', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1050107', '10501', 'userGroupImportTemplateExcel', '用户组导入模板', '', '', '2014-02-13 00:07:05', '2', '7', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1050108', '10501', 'userGroupImport', '用户组导入', '', '', '2014-02-13 00:07:01', '2', '8', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1050109', '10501', 'userGroupExport', '用户组导出', '', '', '2014-02-13 00:11:16', '2', '9', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('106', '1', 'orgInfoMan', '组织机构管理', '/sysman/orgInfoAction!toOrgInfoListPage.action', 'menu_icon_org_man', '2013-12-29 17:56:14', '1', '5', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10601', '106', 'orgInfoList', '机构列表', '/sysman/orgInfoAction!toOrgInfoListPage.action', '', '2014-02-13 00:07:22', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('1060101', '10601', 'orgInfoDetail', '机构查看', '', '', '2014-02-13 00:07:20', '2', '1', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1060102', '10601', 'orgInfoAdd', '机构添加', '', '', '2014-02-13 00:07:18', '2', '2', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1060103', '10601', 'orgInfoAddUser', '机构加入用户', '', '', '2014-02-13 00:07:15', '2', '3', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1060104', '10601', 'orgInfoRemoveUser', '机构移除用户', '', '', '2014-02-13 00:07:13', '2', '4', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1060105', '10601', 'orgInfoEdit', '机构编辑', null, null, '2014-02-13 00:07:10', '2', '5', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1060106', '10601', 'orgInfoDel', '机构删除', '', '', '2014-02-13 00:07:08', '2', '6', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1060107', '10601', 'orgInfoImportTemplateExcel', '机构导入模板', '', '', '2014-02-13 00:07:05', '2', '7', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1060108', '10601', 'orgInfoImport', '机构导入', '', '', '2014-02-13 00:07:01', '2', '8', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('1060109', '10601', 'orgInfoExport', '机构导出', '', '', '2014-02-13 00:11:16', '2', '9', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('107', '1', 'portalMan', '门户管理', '', 'menu_icon_portal_man', '2014-01-01 23:41:26', '1', '6', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10701', '107', 'portalCurrLogoShow', '门户当前LOGO查看', null, null, '2014-02-13 01:03:30', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('10702', '107', 'portalLogoListMore', '更多门户LOGO（列表）', null, null, '2014-02-13 01:05:37', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10703', '107', 'portalLogoUpload', '门户LOGO上传', null, null, '2014-02-13 01:05:37', '2', '3', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10704', '107', 'portalLogoChange', '门户LOGO更换', null, null, '2014-02-13 01:10:34', '2', '4', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('10705', '107', 'portalLogoEdit', '门户LOGO删除', null, null, null, null, null, null, null, null);
INSERT INTO `t_sys_resource` VALUES ('108', '1', 'dicMan', '数据字典管理', '', 'menu_icon_dic_man', '2014-01-02 21:50:27', '1', '7', '1', '数据字典管理', 'closed');
INSERT INTO `t_sys_resource` VALUES ('10801', '108', 'dicDataList', '字典数据列表', null, null, '2014-02-13 01:19:29', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('1080101', '10801', 'dicDataAdd', '字典数据添加', null, null, '2014-02-13 01:19:26', '2', '1', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1080102', '10801', 'dicDataEdit', '字典数据编辑', null, null, '2014-02-13 01:19:24', '2', '2', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1080103', '10801', 'dicDataDel', '字典数据删除', null, null, '2014-02-13 01:19:22', '2', '3', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1080104', '10801', 'dicDataTempleteExcel', '字典数据Excel导入模板', null, null, '2014-02-13 01:19:20', '2', '4', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1080105', '10801', 'dicDataImportExcel', '字典数据导入Excel', null, null, '2014-02-13 01:19:17', '2', '5', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('1080106', '10801', 'dicDataExportExcel', '字典数据导出Excel', null, null, '2014-02-13 01:19:15', '2', '6', '1', '功能点', null);
INSERT INTO `t_sys_resource` VALUES ('109', '1', 'logMan', '日志管理', '', 'menu_icon_log_man', '2013-12-25 17:33:08', '1', '8', '1', '菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('10901', '109', 'authLogMan', '认证日志管理', '', 'menu_icon_access_log_man', '2013-12-23 17:35:25', '1', '1', '1', '子菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('1090101', '10901', 'authLogList', '认证日志列表', '', '', '2013-12-23 17:40:02', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('109010101', '1090101', 'authLogImport', '认证日志导入', '', '', '2013-12-23 17:42:06', '2', '2', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('109010102', '1090101', 'authLogExport', '认证日志导出', '', '', '2013-12-24 17:46:36', '2', '3', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('109010103', '1090101', 'authLogClean', '认证日志清理', '', '', '2013-12-16 17:47:48', '2', '4', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('10902', '109', 'sysLogMan', '系统日志管理', '', 'menu_icon_sys_log_man', '2013-12-24 17:49:00', '1', '2', '1', '子菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('1090201', '10902', 'sysLogList', '系统日志列表', '', '', '2013-12-13 17:50:08', '2', '1', '1', '功能菜单', 'open');
INSERT INTO `t_sys_resource` VALUES ('109020101', '1090201', 'sysLogImport', '系统日志导入', '', '', '2013-12-13 17:50:38', '2', '2', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('109020102', '1090201', 'sysLogExport', '系统日志导出', '', '', '2013-12-13 17:51:35', '2', '3', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('109020103', '1090201', 'sysLogClean', '系统日志清理', '', '', '2013-12-13 17:52:16', '2', '4', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('2', '0', 'bizMan', '业务模块', '', 'menu_icon_biz_man', '2014-01-02 21:55:48', '0', '2', '1', '模块', '');
INSERT INTO `t_sys_resource` VALUES ('201', '2', 'customMan', '客户管理', '', '', '2014-01-02 21:55:53', '1', '1', '1', '菜单', 'closed');
INSERT INTO `t_sys_resource` VALUES ('20101', '201', 'customList', '客户列表', '', '', '2014-01-02 21:55:56', '2', '2', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('20102', '20101', 'customAdd', '客户添加', '', '', '2014-01-02 21:55:58', '2', '3', '1', '功能点', '');
INSERT INTO `t_sys_resource` VALUES ('202', '2', 'orderMan', '订单管理', '', 'menu_icon_user_group_man', '2013-12-29 19:13:59', '1', '2', '1', '菜单', '');
INSERT INTO `t_sys_resource` VALUES ('2c908bcd43bd42610143be0e6d250001', '109', '1111111', '11111111111', '1111', 'index_icon_right_calendar', '2014-01-23 15:44:13', '1', '3', '1', '11111111', 'open');
INSERT INTO `t_sys_resource` VALUES ('2c908bcd43bd42610143be0f83480002', '109010101', '22222', '2222', '2222', 'menu_icon_log_man', '2014-01-23 15:45:24', '1', '1', '1', '2222', 'open');
INSERT INTO `t_sys_resource` VALUES ('2c908bcd442577390144257abcb10001', '109', '123123', '123123', '12123', 'menu_icon_welcome_about', '2014-02-12 17:43:24', '1', '5', '1', '123123', 'open');
INSERT INTO `t_sys_resource` VALUES ('3', '0', 'reportMan', '统计报表管理', '', 'menu_icon_report_man', '2013-12-29 18:59:23', '0', '3', '1', '模块', '');
INSERT INTO `t_sys_resource` VALUES ('402882ef43c4e9090143c53caafd0001', '109', '222222', '2222', '22222', 'index_icon_center, index_icon_center', '2014-01-25 01:12:04', '1', '3', '1', '2222', 'open');
INSERT INTO `t_sys_resource` VALUES ('402882ef43c4e9090143c55d82280002', '109', '333', '3333', '3333', 'menu_icon_welcome_about', '2014-01-25 01:47:56', '1', '4', '1', '33333', 'open');
INSERT INTO `t_sys_role` VALUES ('1', '超级管理员', '1', '2013-11-13 14:11:52', '2014-02-13 02:43:50', '1', '拥有系统所有权限');
INSERT INTO `t_sys_role` VALUES ('2', '系统管理员', '2', '2013-11-18 14:12:28', '2014-02-13 02:43:44', '1', '拥有除授权管理的所有权限');
INSERT INTO `t_sys_role` VALUES ('3', '普通用户', '3', '2013-11-18 14:13:08', '2014-02-19 23:17:46', '1', '拥有除系统管理模块外的访问权限');
INSERT INTO `t_sys_role` VALUES ('4', '123', '2', '2014-02-19 22:02:42', '2014-02-19 23:29:24', '1', '123');
INSERT INTO `t_sys_role` VALUES ('5', '12', '2', '2014-02-19 23:24:15', '2014-02-19 23:29:17', '1', '12');
INSERT INTO `t_sys_role$resource` VALUES ('2', '0');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1');
INSERT INTO `t_sys_role$resource` VALUES ('2', '101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1010101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1010102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1010103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1010104');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1010105');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1010106');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1010107');
INSERT INTO `t_sys_role$resource` VALUES ('2', '102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1020101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1020102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1020103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1020104');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1020105');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1020106');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1020107');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1020108');
INSERT INTO `t_sys_role$resource` VALUES ('2', '103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1030101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1030102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1030103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1030104');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1030105');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1030106');
INSERT INTO `t_sys_role$resource` VALUES ('2', '104');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10401');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1040101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '104010101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '104010102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1040102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '104010201');
INSERT INTO `t_sys_role$resource` VALUES ('2', '104010202');
INSERT INTO `t_sys_role$resource` VALUES ('2', '105');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10501');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1050101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1050102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1050103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1050104');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1050105');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1050106');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1050107');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1050108');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1050109');
INSERT INTO `t_sys_role$resource` VALUES ('2', '106');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10601');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1060101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1060102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1060103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1060104');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1060105');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1060106');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1060107');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1060108');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1060109');
INSERT INTO `t_sys_role$resource` VALUES ('2', '107');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10701');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10702');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10703');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10704');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10705');
INSERT INTO `t_sys_role$resource` VALUES ('2', '108');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10801');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1080101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1080102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1080103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1080104');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1080105');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1080106');
INSERT INTO `t_sys_role$resource` VALUES ('2', '109');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10901');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1090101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '109010101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '109010102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '109010103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '10902');
INSERT INTO `t_sys_role$resource` VALUES ('2', '1090201');
INSERT INTO `t_sys_role$resource` VALUES ('2', '109020101');
INSERT INTO `t_sys_role$resource` VALUES ('2', '109020102');
INSERT INTO `t_sys_role$resource` VALUES ('2', '109020103');
INSERT INTO `t_sys_role$resource` VALUES ('2', '2c908bcd43bd42610143be0e6d250001');
INSERT INTO `t_sys_role$resource` VALUES ('2', '2c908bcd43bd42610143be0f83480002');
INSERT INTO `t_sys_role$resource` VALUES ('2', '2c908bcd442577390144257abcb10001');
INSERT INTO `t_sys_role$resource` VALUES ('2', '3');
INSERT INTO `t_sys_role$resource` VALUES ('2', '402882ef43c4e9090143c53caafd0001');
INSERT INTO `t_sys_role$resource` VALUES ('2', '402882ef43c4e9090143c55d82280002');
INSERT INTO `t_sys_role$resource` VALUES ('1', '0');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1');
INSERT INTO `t_sys_role$resource` VALUES ('1', '101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1010101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1010102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1010103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1010104');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1010105');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1010106');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1010107');
INSERT INTO `t_sys_role$resource` VALUES ('1', '102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1020101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1020102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1020103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1020104');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1020105');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1020106');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1020107');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1020108');
INSERT INTO `t_sys_role$resource` VALUES ('1', '103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1030101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1030102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1030103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1030104');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1030105');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1030106');
INSERT INTO `t_sys_role$resource` VALUES ('1', '104');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10401');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1040101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '104010101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '104010102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1040102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '104010201');
INSERT INTO `t_sys_role$resource` VALUES ('1', '104010202');
INSERT INTO `t_sys_role$resource` VALUES ('1', '105');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10501');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1050101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1050102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1050103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1050104');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1050105');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1050106');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1050107');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1050108');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1050109');
INSERT INTO `t_sys_role$resource` VALUES ('1', '106');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10601');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1060101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1060102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1060103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1060104');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1060105');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1060106');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1060107');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1060108');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1060109');
INSERT INTO `t_sys_role$resource` VALUES ('1', '107');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10701');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10702');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10703');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10704');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10705');
INSERT INTO `t_sys_role$resource` VALUES ('1', '108');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10801');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1080101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1080102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1080103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1080104');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1080105');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1080106');
INSERT INTO `t_sys_role$resource` VALUES ('1', '109');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10901');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1090101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '109010101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '109010102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '109010103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '10902');
INSERT INTO `t_sys_role$resource` VALUES ('1', '1090201');
INSERT INTO `t_sys_role$resource` VALUES ('1', '109020101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '109020102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '109020103');
INSERT INTO `t_sys_role$resource` VALUES ('1', '2');
INSERT INTO `t_sys_role$resource` VALUES ('1', '201');
INSERT INTO `t_sys_role$resource` VALUES ('1', '20101');
INSERT INTO `t_sys_role$resource` VALUES ('1', '20102');
INSERT INTO `t_sys_role$resource` VALUES ('1', '202');
INSERT INTO `t_sys_role$resource` VALUES ('1', '2c908bcd43bd42610143be0e6d250001');
INSERT INTO `t_sys_role$resource` VALUES ('1', '2c908bcd43bd42610143be0f83480002');
INSERT INTO `t_sys_role$resource` VALUES ('1', '2c908bcd442577390144257abcb10001');
INSERT INTO `t_sys_role$resource` VALUES ('1', '3');
INSERT INTO `t_sys_role$resource` VALUES ('1', '402882ef43c4e9090143c53caafd0001');
INSERT INTO `t_sys_role$resource` VALUES ('1', '402882ef43c4e9090143c55d82280002');
INSERT INTO `t_sys_role$resource` VALUES ('3', '0');
INSERT INTO `t_sys_role$resource` VALUES ('3', '2');
INSERT INTO `t_sys_role$resource` VALUES ('3', '201');
INSERT INTO `t_sys_role$resource` VALUES ('3', '20101');
INSERT INTO `t_sys_role$resource` VALUES ('3', '20102');
INSERT INTO `t_sys_role$resource` VALUES ('3', '202');
INSERT INTO `t_sys_role$resource` VALUES ('3', '3');
INSERT INTO `t_sys_role$resource` VALUES ('5', '0');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1');
INSERT INTO `t_sys_role$resource` VALUES ('5', '101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1010101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1010102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1010103');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1010104');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1010105');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1010106');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1010107');
INSERT INTO `t_sys_role$resource` VALUES ('5', '102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1020101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1020102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1020103');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1020104');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1020105');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1020106');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1020107');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1020108');
INSERT INTO `t_sys_role$resource` VALUES ('5', '103');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1030101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1030102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1030103');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1030104');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1030105');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1030106');
INSERT INTO `t_sys_role$resource` VALUES ('5', '104');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10401');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1040101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '104010101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '104010102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1040102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '104010201');
INSERT INTO `t_sys_role$resource` VALUES ('5', '104010202');
INSERT INTO `t_sys_role$resource` VALUES ('5', '105');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10501');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1050101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1050102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1050103');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1050104');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1050105');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1050106');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1050107');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1050108');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1050109');
INSERT INTO `t_sys_role$resource` VALUES ('5', '106');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10601');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1060101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1060102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1060103');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1060104');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1060105');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1060106');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1060107');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1060108');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1060109');
INSERT INTO `t_sys_role$resource` VALUES ('5', '107');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10701');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10702');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10703');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10704');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10705');
INSERT INTO `t_sys_role$resource` VALUES ('5', '108');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10801');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1080101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1080102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1080103');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1080104');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1080105');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1080106');
INSERT INTO `t_sys_role$resource` VALUES ('5', '109');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10901');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1090101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '109010101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '109010102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '109010103');
INSERT INTO `t_sys_role$resource` VALUES ('5', '10902');
INSERT INTO `t_sys_role$resource` VALUES ('5', '1090201');
INSERT INTO `t_sys_role$resource` VALUES ('5', '109020101');
INSERT INTO `t_sys_role$resource` VALUES ('5', '109020102');
INSERT INTO `t_sys_role$resource` VALUES ('5', '109020103');
INSERT INTO `t_sys_role$resource` VALUES ('5', '2c908bcd43bd42610143be0e6d250001');
INSERT INTO `t_sys_role$resource` VALUES ('5', '2c908bcd43bd42610143be0f83480002');
INSERT INTO `t_sys_role$resource` VALUES ('5', '2c908bcd442577390144257abcb10001');
INSERT INTO `t_sys_role$resource` VALUES ('5', '402882ef43c4e9090143c53caafd0001');
INSERT INTO `t_sys_role$resource` VALUES ('5', '402882ef43c4e9090143c55d82280002');
INSERT INTO `t_sys_role$resource` VALUES ('4', '0');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1');
INSERT INTO `t_sys_role$resource` VALUES ('4', '101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1010101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1010102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1010103');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1010104');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1010105');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1010106');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1010107');
INSERT INTO `t_sys_role$resource` VALUES ('4', '102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10201');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1020101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1020102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1020103');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1020104');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1020105');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1020106');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1020107');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1020108');
INSERT INTO `t_sys_role$resource` VALUES ('4', '103');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10301');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1030101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1030102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1030103');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1030104');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1030105');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1030106');
INSERT INTO `t_sys_role$resource` VALUES ('4', '104');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10401');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1040101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '104010101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '104010102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1040102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '104010201');
INSERT INTO `t_sys_role$resource` VALUES ('4', '104010202');
INSERT INTO `t_sys_role$resource` VALUES ('4', '105');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10501');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1050101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1050102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1050103');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1050104');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1050105');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1050106');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1050107');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1050108');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1050109');
INSERT INTO `t_sys_role$resource` VALUES ('4', '106');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10601');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1060101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1060102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1060103');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1060104');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1060105');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1060106');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1060107');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1060108');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1060109');
INSERT INTO `t_sys_role$resource` VALUES ('4', '107');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10701');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10702');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10703');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10704');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10705');
INSERT INTO `t_sys_role$resource` VALUES ('4', '108');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10801');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1080101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1080102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1080103');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1080104');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1080105');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1080106');
INSERT INTO `t_sys_role$resource` VALUES ('4', '109');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10901');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1090101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '109010101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '109010102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '109010103');
INSERT INTO `t_sys_role$resource` VALUES ('4', '10902');
INSERT INTO `t_sys_role$resource` VALUES ('4', '1090201');
INSERT INTO `t_sys_role$resource` VALUES ('4', '109020101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '109020102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '109020103');
INSERT INTO `t_sys_role$resource` VALUES ('4', '2');
INSERT INTO `t_sys_role$resource` VALUES ('4', '201');
INSERT INTO `t_sys_role$resource` VALUES ('4', '20101');
INSERT INTO `t_sys_role$resource` VALUES ('4', '20102');
INSERT INTO `t_sys_role$resource` VALUES ('4', '202');
INSERT INTO `t_sys_role$resource` VALUES ('4', '2c908bcd43bd42610143be0e6d250001');
INSERT INTO `t_sys_role$resource` VALUES ('4', '2c908bcd43bd42610143be0f83480002');
INSERT INTO `t_sys_role$resource` VALUES ('4', '2c908bcd442577390144257abcb10001');
INSERT INTO `t_sys_role$resource` VALUES ('4', '3');
INSERT INTO `t_sys_role$resource` VALUES ('4', '402882ef43c4e9090143c53caafd0001');
INSERT INTO `t_sys_role$resource` VALUES ('4', '402882ef43c4e9090143c55d82280002');
INSERT INTO `t_sys_user` VALUES ('1', 'initAdmin', 'initAdmin', '412506897@qq.com', '男', '12345678911', '2013-11-24 16:02:18', '2013-11-27 16:51:10', '1', '超管，拥有所有权限');
INSERT INTO `t_sys_user` VALUES ('2', 'admin', 'admin', '123121@qq.com', '男', '12345678911', '2013-11-24 16:02:42', '2013-11-27 16:51:14', '1', '管理员，拥有除权限模块的所有权限');
INSERT INTO `t_sys_user` VALUES ('3', 'user', 'user', 'user123@sina.cn', '女', '12345678911', '2013-11-11 16:03:31', '2013-11-20 16:51:16', '1', '普通用户');
INSERT INTO `t_sys_user` VALUES ('4', 'lx', 'lx', 'lx12312@qq.com', '男', '12345678911', '2014-01-14 10:47:21', '2014-02-19 22:27:12', '1', '普通用户');
INSERT INTO `t_sys_user$role` VALUES ('1', '1');
INSERT INTO `t_sys_user$role` VALUES ('3', '3');
INSERT INTO `t_sys_user$role` VALUES ('2', '2');
INSERT INTO `t_sys_user$role` VALUES ('4', '3');
INSERT INTO `t_sys_user$user_group` VALUES ('1', '2c908bcd44493c38014449536b050001');
INSERT INTO `t_sys_user$user_group` VALUES ('2', '402881ee443a199901443a2338510002');
INSERT INTO `t_sys_user$user_group` VALUES ('2', '2c908bcd44493c38014449536b050001');
INSERT INTO `t_sys_user$user_group` VALUES ('3', '2c908bcd44493c38014449536b050001');
INSERT INTO `t_sys_user$user_group` VALUES ('4', '2c908bcd44493c38014449536b050001');
INSERT INTO `t_sys_user$user_group` VALUES ('1', '402881ee443a199901443a2338510002');
INSERT INTO `t_sys_user$user_group` VALUES ('3', '402881ee443a199901443a4e8da40005');
INSERT INTO `t_sys_user$user_group` VALUES ('4', '402881ee443a199901443a4e8da40005');
INSERT INTO `t_sys_user_group` VALUES ('2c908bcd44493c38014449536b050001', 'd53cc8e4-ebbe-4501-9b16-089515d7', '123', '2014-02-19 16:46:45', '2014-02-19 16:46:45', '1', '123');
INSERT INTO `t_sys_user_group` VALUES ('402881e9444fc31701444fc60bf40001', null, 'dd', null, null, null, null);
INSERT INTO `t_sys_user_group` VALUES ('402881ee443a199901443a2338510002', null, '11', '2014-02-16 17:59:50', '2014-02-16 17:59:50', '1', '11');
INSERT INTO `t_sys_user_group` VALUES ('402881ee443a199901443a4e8da40005', '749434fb-4d74-43b5-a2e8-821468f9', '123', '2014-02-16 18:47:10', '2014-02-16 18:47:10', '1', '123');
