/*
MySQL Data Transfer
Source Host: localhost
Source Database: spring_secuirty_v_1
Target Host: localhost
Target Database: spring_secuirty_v_1
Date: 2013-11-5 0:01:26
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `createTime` datetime DEFAULT NULL,
  `statu` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
