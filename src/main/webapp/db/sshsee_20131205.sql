/*
MySQL Data Transfer
Source Host: localhost
Source Database: sshsee
Target Host: localhost
Target Database: sshsee
Date: 2013-12-6 1:32:49
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for t_sys_access_log
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_access_log`;
CREATE TABLE `t_sys_access_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `loginTime` datetime DEFAULT NULL,
  `logoutTime` datetime DEFAULT NULL,
  `logoutType` int(1) DEFAULT NULL,
  `loginIp` varchar(255) DEFAULT NULL,
  `sessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_function
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_function`;
CREATE TABLE `t_sys_function` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `functionName` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `functionIcon` varchar(255) DEFAULT NULL,
  `nodeId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `statu` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_node
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_node`;
CREATE TABLE `t_sys_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nodeCode` varchar(255) DEFAULT NULL,
  `parentCode` varchar(255) DEFAULT NULL,
  `nodeName` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `statu` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_operation_log`;
CREATE TABLE `t_sys_operation_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `operationTime` datetime DEFAULT NULL,
  `operationType` int(11) DEFAULT NULL,
  `operationUrl` varchar(255) DEFAULT NULL,
  `operationContent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role`;
CREATE TABLE `t_sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID，唯一字段',
  `roleName` varchar(255) DEFAULT NULL COMMENT '色角名称',
  `roleType` varchar(255) DEFAULT 'NULL' COMMENT '角色类型',
  `createTime` datetime DEFAULT NULL COMMENT '建时时间',
  `state` int(11) DEFAULT NULL COMMENT '角色状态；0：禁用；1：启用',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_role$node
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role$node`;
CREATE TABLE `t_sys_role$node` (
  `roleId` int(11) DEFAULT NULL,
  `nodeId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE `t_sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `telphone` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `lastUpdateTime` datetime DEFAULT NULL,
  `statu` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_user$role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user$role`;
CREATE TABLE `t_sys_user$role` (
  `userId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `t_sys_role` VALUES ('1', '超级管理员', '1', '2013-11-13 14:11:52', '1', '拥有系统所有权限');
INSERT INTO `t_sys_role` VALUES ('2', '系统管理员', '2', '2013-11-18 14:12:28', '1', '拥有除授权管理的所有权限');
INSERT INTO `t_sys_role` VALUES ('3', '普通用户', '3', '2013-11-18 14:13:08', '1', '拥有除系统管理模块外的访问权限');
INSERT INTO `t_sys_user` VALUES ('1', 'superadmin', 'superadmin', '412506897@qq.com', '男', '1231231231', '2013-11-24 16:02:18', '2013-11-27 16:51:10', '1', '超管，拥有所有权限');
INSERT INTO `t_sys_user` VALUES ('2', 'admin', 'admin', '123121@qq.com', '男', '1231231231', '2013-11-24 16:02:42', '2013-11-27 16:51:14', '1', '管理员，拥有除权限模块的所有权限');
INSERT INTO `t_sys_user` VALUES ('3', 'user', 'user', 'user123@sina.cn', '女', '1231231231', '2013-11-11 16:03:31', '2013-11-20 16:51:16', '1', '普通用户');
INSERT INTO `t_sys_user` VALUES ('4', 'lx', 'lx', 'lx12312@qq.com', '男', '1231231231', '2013-11-10 16:03:53', '2013-11-27 16:51:25', '1', '普通用户');
