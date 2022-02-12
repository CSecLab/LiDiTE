USE scadalts;
-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: scadalts
-- ------------------------------------------------------
-- Server version	10.5.9-MariaDB-1:10.5.9+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category_views_hierarchy`
--

DROP TABLE IF EXISTS `category_views_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_views_hierarchy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`,`parentId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compoundEventDetectors`
--

DROP TABLE IF EXISTS `compoundEventDetectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compoundEventDetectors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `returnToNormal` char(1) NOT NULL,
  `disabled` char(1) NOT NULL,
  `conditionText` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `compoundEventDetectorsUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataPointUsers`
--

DROP TABLE IF EXISTS `dataPointUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataPointUsers` (
  `dataPointId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `permission` int(11) NOT NULL,
  KEY `dataPointUsersFk1` (`dataPointId`),
  KEY `dataPointUsersFk2` (`userId`),
  CONSTRAINT `dataPointUsersFk1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`),
  CONSTRAINT `dataPointUsersFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataPointUsersProfiles`
--

DROP TABLE IF EXISTS `dataPointUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataPointUsersProfiles` (
  `dataPointId` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  `permission` int(11) NOT NULL,
  KEY `dataPointUsersProfilesFk1` (`dataPointId`),
  KEY `dataPointUsersProfilesFk2` (`userProfileId`),
  CONSTRAINT `dataPointUsersProfilesFk1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dataPointUsersProfilesFk2` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataPoints`
--

DROP TABLE IF EXISTS `dataPoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataPoints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `dataSourceId` int(11) NOT NULL,
  `data` longblob NOT NULL,
  `pointName` varchar(250) DEFAULT NULL COMMENT 'copy point name from data',
  `plcAlarmLevel` tinyint(8) DEFAULT NULL COMMENT '1 - FAULT, 2 - ALARM',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dataPointsUn1` (`xid`),
  KEY `dataPointsFk1` (`dataSourceId`),
  CONSTRAINT `dataPointsFk1` FOREIGN KEY (`dataSourceId`) REFERENCES `dataSources` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataSourceUsers`
--

DROP TABLE IF EXISTS `dataSourceUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataSourceUsers` (
  `dataSourceId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  KEY `dataSourceUsersFk1` (`dataSourceId`),
  KEY `dataSourceUsersFk2` (`userId`),
  CONSTRAINT `dataSourceUsersFk1` FOREIGN KEY (`dataSourceId`) REFERENCES `dataSources` (`id`),
  CONSTRAINT `dataSourceUsersFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataSourceUsersProfiles`
--

DROP TABLE IF EXISTS `dataSourceUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataSourceUsersProfiles` (
  `dataSourceId` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  KEY `dataSourceUsersProfilesFk1` (`dataSourceId`),
  KEY `dataSourceUsersProfilesFk2` (`userProfileId`),
  CONSTRAINT `dataSourceUsersProfilesFk1` FOREIGN KEY (`dataSourceId`) REFERENCES `dataSources` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dataSourceUsersProfilesFk2` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataSources`
--

DROP TABLE IF EXISTS `dataSources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataSources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(40) NOT NULL,
  `dataSourceType` int(11) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dataSourcesUn1` (`xid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eventDetectorTemplates`
--

DROP TABLE IF EXISTS `eventDetectorTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventDetectorTemplates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eventHandlers`
--

DROP TABLE IF EXISTS `eventHandlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventHandlers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `eventTypeId` int(11) NOT NULL,
  `eventTypeRef1` int(11) NOT NULL,
  `eventTypeRef2` int(11) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eventHandlersUn1` (`xid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeId` int(11) NOT NULL,
  `typeRef1` int(11) NOT NULL,
  `typeRef2` int(11) NOT NULL,
  `activeTs` bigint(20) NOT NULL,
  `rtnApplicable` char(1) NOT NULL,
  `rtnTs` bigint(20) DEFAULT NULL,
  `rtnCause` int(11) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `message` longtext DEFAULT NULL,
  `ackTs` bigint(20) DEFAULT NULL,
  `ackUserId` int(11) DEFAULT NULL,
  `alternateAckSource` int(11) DEFAULT NULL,
  `shortMessage` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eventsFk1` (`ackUserId`),
  CONSTRAINT `eventsFk1` FOREIGN KEY (`ackUserId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3242 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flexProjects`
--

DROP TABLE IF EXISTS `flexProjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flexProjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `xmlConfig` varchar(16384) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `historyAlarms`
--

DROP TABLE IF EXISTS `historyAlarms`;
/*!50001 DROP VIEW IF EXISTS `historyAlarms`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `historyAlarms` (
  `activeTime` tinyint NOT NULL,
  `inactiveTime` tinyint NOT NULL,
  `acknowledgeTime` tinyint NOT NULL,
  `level` tinyint NOT NULL,
  `name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `liveAlarms`
--

DROP TABLE IF EXISTS `liveAlarms`;
/*!50001 DROP VIEW IF EXISTS `liveAlarms`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `liveAlarms` (
  `id` tinyint NOT NULL,
  `activation-time` tinyint NOT NULL,
  `inactivation-time` tinyint NOT NULL,
  `level` tinyint NOT NULL,
  `name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `mailingListInactive`
--

DROP TABLE IF EXISTS `mailingListInactive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailingListInactive` (
  `mailingListId` int(11) NOT NULL,
  `inactiveInterval` int(11) NOT NULL,
  KEY `mailingListInactiveFk1` (`mailingListId`),
  CONSTRAINT `mailingListInactiveFk1` FOREIGN KEY (`mailingListId`) REFERENCES `mailingLists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailingListMembers`
--

DROP TABLE IF EXISTS `mailingListMembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailingListMembers` (
  `mailingListId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  KEY `mailingListMembersFk1` (`mailingListId`),
  CONSTRAINT `mailingListMembersFk1` FOREIGN KEY (`mailingListId`) REFERENCES `mailingLists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailingLists`
--

DROP TABLE IF EXISTS `mailingLists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailingLists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(40) NOT NULL,
  `cronPattern` varchar(100) DEFAULT NULL COMMENT 'cron pattern',
  `collectInactiveEmails` binary(1) DEFAULT '0' COMMENT 'Collect inactive emails and send when activated',
  `dailyLimitSentEmails` binary(1) DEFAULT '0' COMMENT 'Daily limit sent emails',
  `dailyLimitSentEmailsNumber` int(11) DEFAULT 0 COMMENT 'Daily limit sent emails number',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mailingListsUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `maintenanceEvents`
--

DROP TABLE IF EXISTS `maintenanceEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenanceEvents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `dataSourceId` int(11) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `scheduleType` int(11) NOT NULL,
  `disabled` char(1) NOT NULL,
  `activeYear` int(11) DEFAULT NULL,
  `activeMonth` int(11) DEFAULT NULL,
  `activeDay` int(11) DEFAULT NULL,
  `activeHour` int(11) DEFAULT NULL,
  `activeMinute` int(11) DEFAULT NULL,
  `activeSecond` int(11) DEFAULT NULL,
  `activeCron` varchar(25) DEFAULT NULL,
  `inactiveYear` int(11) DEFAULT NULL,
  `inactiveMonth` int(11) DEFAULT NULL,
  `inactiveDay` int(11) DEFAULT NULL,
  `inactiveHour` int(11) DEFAULT NULL,
  `inactiveMinute` int(11) DEFAULT NULL,
  `inactiveSecond` int(11) DEFAULT NULL,
  `inactiveCron` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `maintenanceEventsUn1` (`xid`),
  KEY `maintenanceEventsFk1` (`dataSourceId`),
  CONSTRAINT `maintenanceEventsFk1` FOREIGN KEY (`dataSourceId`) REFERENCES `dataSources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mangoViewUsers`
--

DROP TABLE IF EXISTS `mangoViewUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mangoViewUsers` (
  `mangoViewId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `accessType` int(11) NOT NULL,
  PRIMARY KEY (`mangoViewId`,`userId`),
  KEY `mangoViewUsersFk2` (`userId`),
  CONSTRAINT `mangoViewUsersFk1` FOREIGN KEY (`mangoViewId`) REFERENCES `mangoViews` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mangoViewUsersFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mangoViews`
--

DROP TABLE IF EXISTS `mangoViews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mangoViews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `background` varchar(255) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `anonymousAccess` int(11) NOT NULL,
  `data` longblob NOT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `modification_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `mangoViewsUn1` (`xid`),
  KEY `mangoViewsFk1` (`userId`),
  CONSTRAINT `mangoViewsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `multi_changes_history`
--

DROP TABLE IF EXISTS `multi_changes_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multi_changes_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `viewAndComponentIdentification` varchar(50) NOT NULL,
  `interpretedState` varchar(50) NOT NULL,
  `ts` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plcAlarms`
--

DROP TABLE IF EXISTS `plcAlarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plcAlarms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dataPointId` int(11) NOT NULL,
  `dataPointXid` varchar(50) DEFAULT NULL,
  `dataPointType` varchar(45) DEFAULT NULL,
  `dataPointName` varchar(45) DEFAULT NULL,
  `activeTime` bigint(20) DEFAULT 0,
  `inactiveTime` bigint(20) DEFAULT 0,
  `acknowledgeTime` bigint(20) DEFAULT 0,
  `level` tinyint(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dataPointId` (`dataPointId`,`inactiveTime`),
  CONSTRAINT `plcAlarms_ibfk_1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pointEventDetectors`
--

DROP TABLE IF EXISTS `pointEventDetectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pointEventDetectors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `dataPointId` int(11) NOT NULL,
  `detectorType` int(11) NOT NULL,
  `alarmLevel` int(11) NOT NULL,
  `stateLimit` double DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `durationType` int(11) DEFAULT NULL,
  `binaryState` char(1) DEFAULT NULL,
  `multistateState` int(11) DEFAULT NULL,
  `changeCount` int(11) DEFAULT NULL,
  `alphanumericState` varchar(128) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pointEventDetectorsUn1` (`xid`,`dataPointId`),
  KEY `pointEventDetectorsFk1` (`dataPointId`),
  CONSTRAINT `pointEventDetectorsFk1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pointHierarchy`
--

DROP TABLE IF EXISTS `pointHierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pointHierarchy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `xid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_xid_point_hierarchy` (`xid`),
  KEY `idx_xid_point_hierarchy` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pointLinks`
--

DROP TABLE IF EXISTS `pointLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pointLinks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `sourcePointId` int(11) NOT NULL,
  `targetPointId` int(11) NOT NULL,
  `script` longtext DEFAULT NULL,
  `eventType` int(11) NOT NULL,
  `disabled` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pointLinksUn1` (`xid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pointValueAnnotations`
--

DROP TABLE IF EXISTS `pointValueAnnotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pointValueAnnotations` (
  `pointValueId` bigint(20) NOT NULL,
  `textPointValueShort` varchar(128) DEFAULT NULL,
  `textPointValueLong` longtext DEFAULT NULL,
  `sourceType` smallint(6) DEFAULT NULL,
  `sourceId` int(11) DEFAULT NULL,
  KEY `pointValueAnnotationsFk1` (`pointValueId`),
  CONSTRAINT `pointValueAnnotationsFk1` FOREIGN KEY (`pointValueId`) REFERENCES `pointValues` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pointValues`
--

DROP TABLE IF EXISTS `pointValues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pointValues` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dataPointId` int(11) NOT NULL,
  `dataType` int(11) NOT NULL,
  `pointValue` double DEFAULT NULL,
  `ts` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pointValuesIdx1` (`ts`,`dataPointId`),
  KEY `pointValuesIdx2` (`dataPointId`,`ts`),
  CONSTRAINT `pointValuesFk1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=168396 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`scadalts`@`%`*/ /*!50003 TRIGGER tri_notify_faults_or_alarms AFTER INSERT ON pointValues 
FOR EACH ROW CALL prc_alarms_notify(new.dataPointId, new.ts, new.pointValue) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publishers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `publishersUn1` (`xid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportInstanceData`
--

DROP TABLE IF EXISTS `reportInstanceData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportInstanceData` (
  `pointValueId` bigint(20) NOT NULL,
  `reportInstancePointId` int(11) NOT NULL,
  `pointValue` double DEFAULT NULL,
  `ts` bigint(20) NOT NULL,
  PRIMARY KEY (`pointValueId`,`reportInstancePointId`),
  KEY `reportInstanceDataFk1` (`reportInstancePointId`),
  CONSTRAINT `reportInstanceDataFk1` FOREIGN KEY (`reportInstancePointId`) REFERENCES `reportInstancePoints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportInstanceDataAnnotations`
--

DROP TABLE IF EXISTS `reportInstanceDataAnnotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportInstanceDataAnnotations` (
  `pointValueId` bigint(20) NOT NULL,
  `reportInstancePointId` int(11) NOT NULL,
  `textPointValueShort` varchar(128) DEFAULT NULL,
  `textPointValueLong` longtext DEFAULT NULL,
  `sourceValue` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`pointValueId`,`reportInstancePointId`),
  CONSTRAINT `reportInstanceDataAnnotationsFk1` FOREIGN KEY (`pointValueId`, `reportInstancePointId`) REFERENCES `reportInstanceData` (`pointValueId`, `reportInstancePointId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportInstanceEvents`
--

DROP TABLE IF EXISTS `reportInstanceEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportInstanceEvents` (
  `eventId` int(11) NOT NULL,
  `reportInstanceId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `typeRef1` int(11) NOT NULL,
  `typeRef2` int(11) NOT NULL,
  `activeTs` bigint(20) NOT NULL,
  `rtnApplicable` char(1) NOT NULL,
  `rtnTs` bigint(20) DEFAULT NULL,
  `rtnCause` int(11) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `message` longtext DEFAULT NULL,
  `ackTs` bigint(20) DEFAULT NULL,
  `ackUsername` varchar(40) DEFAULT NULL,
  `alternateAckSource` int(11) DEFAULT NULL,
  PRIMARY KEY (`eventId`,`reportInstanceId`),
  KEY `reportInstanceEventsFk1` (`reportInstanceId`),
  CONSTRAINT `reportInstanceEventsFk1` FOREIGN KEY (`reportInstanceId`) REFERENCES `reportInstances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportInstancePoints`
--

DROP TABLE IF EXISTS `reportInstancePoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportInstancePoints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reportInstanceId` int(11) NOT NULL,
  `dataSourceName` varchar(40) NOT NULL,
  `pointName` varchar(100) NOT NULL,
  `dataType` int(11) NOT NULL,
  `startValue` varchar(4096) DEFAULT NULL,
  `textRenderer` longblob DEFAULT NULL,
  `colour` varchar(6) DEFAULT NULL,
  `consolidatedChart` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reportInstancePointsFk1` (`reportInstanceId`),
  CONSTRAINT `reportInstancePointsFk1` FOREIGN KEY (`reportInstanceId`) REFERENCES `reportInstances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportInstanceUserComments`
--

DROP TABLE IF EXISTS `reportInstanceUserComments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportInstanceUserComments` (
  `reportInstanceId` int(11) NOT NULL,
  `username` varchar(40) DEFAULT NULL,
  `commentType` int(11) NOT NULL,
  `typeKey` int(11) NOT NULL,
  `ts` bigint(20) NOT NULL,
  `commentText` varchar(1024) NOT NULL,
  KEY `reportInstanceUserCommentsFk1` (`reportInstanceId`),
  CONSTRAINT `reportInstanceUserCommentsFk1` FOREIGN KEY (`reportInstanceId`) REFERENCES `reportInstances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportInstances`
--

DROP TABLE IF EXISTS `reportInstances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportInstances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `includeEvents` int(11) NOT NULL,
  `includeUserComments` char(1) NOT NULL,
  `reportStartTime` bigint(20) NOT NULL,
  `reportEndTime` bigint(20) NOT NULL,
  `runStartTime` bigint(20) DEFAULT NULL,
  `runEndTime` bigint(20) DEFAULT NULL,
  `recordCount` int(11) DEFAULT NULL,
  `preventPurge` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reportInstancesFk1` (`userId`),
  CONSTRAINT `reportInstancesFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reportsFk1` (`userId`),
  CONSTRAINT `reportsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduledEvents`
--

DROP TABLE IF EXISTS `scheduledEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduledEvents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `scheduleType` int(11) NOT NULL,
  `returnToNormal` char(1) NOT NULL,
  `disabled` char(1) NOT NULL,
  `activeYear` int(11) DEFAULT NULL,
  `activeMonth` int(11) DEFAULT NULL,
  `activeDay` int(11) DEFAULT NULL,
  `activeHour` int(11) DEFAULT NULL,
  `activeMinute` int(11) DEFAULT NULL,
  `activeSecond` int(11) DEFAULT NULL,
  `activeCron` varchar(25) DEFAULT NULL,
  `inactiveYear` int(11) DEFAULT NULL,
  `inactiveMonth` int(11) DEFAULT NULL,
  `inactiveDay` int(11) DEFAULT NULL,
  `inactiveHour` int(11) DEFAULT NULL,
  `inactiveMinute` int(11) DEFAULT NULL,
  `inactiveSecond` int(11) DEFAULT NULL,
  `inactiveCron` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `scheduledEventsUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduledExecuteInactiveEvent`
--

DROP TABLE IF EXISTS `scheduledExecuteInactiveEvent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduledExecuteInactiveEvent` (
  `mailingListId` int(11) NOT NULL,
  `sourceEventId` int(11) NOT NULL,
  `eventHandlerId` int(11) NOT NULL,
  UNIQUE KEY `mailingListId` (`mailingListId`,`sourceEventId`,`eventHandlerId`),
  KEY `sourceEventId` (`sourceEventId`),
  KEY `eventHandlerId` (`eventHandlerId`),
  CONSTRAINT `scheduledExecuteInactiveEvent_ibfk_1` FOREIGN KEY (`sourceEventId`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `scheduledExecuteInactiveEvent_ibfk_2` FOREIGN KEY (`mailingListId`) REFERENCES `mailingLists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `scheduledExecuteInactiveEvent_ibfk_3` FOREIGN KEY (`eventHandlerId`) REFERENCES `eventHandlers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_version` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `schema_version_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `xid` varchar(50) NOT NULL,
  `name` varchar(40) NOT NULL,
  `script` varchar(16384) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `scriptsUn1` (`xid`),
  KEY `scriptsFk1` (`userId`),
  CONSTRAINT `scriptsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemSettings`
--

DROP TABLE IF EXISTS `systemSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemSettings` (
  `settingName` varchar(32) NOT NULL,
  `settingValue` longtext DEFAULT NULL,
  PRIMARY KEY (`settingName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatesDetectors`
--

DROP TABLE IF EXISTS `templatesDetectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatesDetectors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `detectorType` int(11) NOT NULL,
  `alarmLevel` int(11) NOT NULL,
  `stateLimit` float DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `durationType` int(11) DEFAULT NULL,
  `binaryState` char(1) DEFAULT NULL,
  `multistateState` int(11) DEFAULT NULL,
  `changeCount` int(11) DEFAULT NULL,
  `alphanumericState` varchar(128) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `threshold` double DEFAULT NULL,
  `eventDetectorTemplateId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatesDetectorsFk1` (`eventDetectorTemplateId`),
  CONSTRAINT `templatesDetectorsFk1` FOREIGN KEY (`eventDetectorTemplateId`) REFERENCES `eventDetectorTemplates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userComments`
--

DROP TABLE IF EXISTS `userComments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userComments` (
  `userId` int(11) DEFAULT NULL,
  `commentType` int(11) NOT NULL,
  `typeKey` int(11) NOT NULL,
  `ts` bigint(20) NOT NULL,
  `commentText` varchar(1024) NOT NULL,
  KEY `userCommentsFk1` (`userId`),
  CONSTRAINT `userCommentsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userEvents`
--

DROP TABLE IF EXISTS `userEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userEvents` (
  `eventId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `silenced` char(1) NOT NULL,
  PRIMARY KEY (`eventId`,`userId`),
  KEY `userEventsFk2` (`userId`),
  CONSTRAINT `userEventsFk1` FOREIGN KEY (`eventId`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userEventsFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `admin` char(1) NOT NULL,
  `disabled` char(1) NOT NULL,
  `lastLogin` bigint(20) DEFAULT NULL,
  `selectedWatchList` int(11) DEFAULT NULL,
  `homeUrl` varchar(255) DEFAULT NULL,
  `receiveAlarmEmails` int(11) NOT NULL,
  `receiveOwnAuditEvents` char(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usersProfiles`
--

DROP TABLE IF EXISTS `usersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usersProfiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usersProfilesUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usersUsersProfiles`
--

DROP TABLE IF EXISTS `usersUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usersUsersProfiles` (
  `userProfileId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  KEY `usersUsersProfilesFk1` (`userProfileId`),
  KEY `usersUsersProfilesFk2` (`userId`),
  CONSTRAINT `usersUsersProfilesFk1` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usersUsersProfilesFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `values_multi_changes_history`
--

DROP TABLE IF EXISTS `values_multi_changes_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `values_multi_changes_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `multiChangesHistoryId` int(11) DEFAULT NULL,
  `valueId` bigint(20) DEFAULT NULL,
  `value` varchar(50) NOT NULL,
  `dataPointId` int(11) DEFAULT NULL,
  `ts` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `viewUsersProfiles`
--

DROP TABLE IF EXISTS `viewUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `viewUsersProfiles` (
  `viewId` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  `permission` int(11) NOT NULL,
  KEY `viewUsersProfilesFk1` (`viewId`),
  KEY `viewUsersProfilesFk2` (`userProfileId`),
  CONSTRAINT `viewUsersProfilesFk1` FOREIGN KEY (`viewId`) REFERENCES `mangoViews` (`id`) ON DELETE CASCADE,
  CONSTRAINT `viewUsersProfilesFk2` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `views_category_views_hierarchy`
--

DROP TABLE IF EXISTS `views_category_views_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_category_views_hierarchy` (
  `view_id` int(11) NOT NULL,
  `folder_views_hierarchy_id` int(11) NOT NULL,
  PRIMARY KEY (`view_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `watchListPoints`
--

DROP TABLE IF EXISTS `watchListPoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchListPoints` (
  `watchListId` int(11) NOT NULL,
  `dataPointId` int(11) NOT NULL,
  `sortOrder` int(11) NOT NULL,
  KEY `watchListPointsFk1` (`watchListId`),
  KEY `watchListPointsFk2` (`dataPointId`),
  CONSTRAINT `watchListPointsFk1` FOREIGN KEY (`watchListId`) REFERENCES `watchLists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `watchListPointsFk2` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `watchListUsers`
--

DROP TABLE IF EXISTS `watchListUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchListUsers` (
  `watchListId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `accessType` int(11) NOT NULL,
  PRIMARY KEY (`watchListId`,`userId`),
  KEY `watchListUsersFk2` (`userId`),
  CONSTRAINT `watchListUsersFk1` FOREIGN KEY (`watchListId`) REFERENCES `watchLists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `watchListUsersFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `watchListUsersProfiles`
--

DROP TABLE IF EXISTS `watchListUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchListUsersProfiles` (
  `watchlistId` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  `permission` int(11) NOT NULL,
  KEY `watchlistUsersProfilesFk1` (`watchlistId`),
  KEY `watchlistUsersProfilesFk2` (`userProfileId`),
  CONSTRAINT `watchlistUsersProfilesFk1` FOREIGN KEY (`watchlistId`) REFERENCES `watchLists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `watchlistUsersProfilesFk2` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `watchLists`
--

DROP TABLE IF EXISTS `watchLists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchLists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `userId` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `watchListsUn1` (`xid`),
  KEY `watchListsFk1` (`userId`),
  CONSTRAINT `watchListsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'scadalts'
--
/*!50003 DROP FUNCTION IF EXISTS `func_fromats_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` FUNCTION `func_fromats_date`(ts BIGINT) RETURNS varchar(19) CHARSET utf8
BEGIN  
	IF(ts = 0) THEN
		RETURN ' ';
	END IF;
    
	IF(ts <> 0) THEN
		RETURN substring(from_unixtime(ts/1000),1,19);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_gen_xid_point_hierarchy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` FUNCTION `func_gen_xid_point_hierarchy`(id INT(10)) RETURNS varchar(100) CHARSET utf8
BEGIN  RETURN CONCAT("DIR_", UNIX_TIMESTAMP(),"_", id); END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_views_hierarchy_add` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` FUNCTION `func_views_hierarchy_add`(a_parentId int(11),a_name CHAR(100)) RETURNS int(11)
BEGIN DECLARE specialty CONDITION FOR SQLSTATE '45000'; IF ( (CHARACTER_LENGTH(a_name)>2) and (CHARACTER_LENGTH(a_name)<100) )  THEN SIGNAL SQLSTATE '01000'; insert into category_views_hierarchy (parentId, name) values ( a_parentId, a_name); return last_insert_id(); ELSE SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='#error.view_hierarchy.add.error1# '; END IF;END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_views_hierarchy_folder_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` FUNCTION `func_views_hierarchy_folder_delete`(a_id int(11)) RETURNS int(11)
BEGIN DELETE FROM category_views_hierarchy WHERE id=a_id; SET SQL_SAFE_UPDATES = 0;UPDATE category_views_hierarchy SET parentId=-1 WHERE parentId=a_id; return a_id; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_views_hierarchy_move_folder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` FUNCTION `func_views_hierarchy_move_folder`(a_id INT, a_new_parent_id INT) RETURNS int(11)
BEGIN UPDATE category_views_hierarchy SET parentId=a_new_parent_id WHERE id=a_id; return a_id; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_views_hierarchy_move_view` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` FUNCTION `func_views_hierarchy_move_view`(a_id INT, a_new_parent_id INT) RETURNS int(11)
BEGIN DECLARE varExistId INT default 0; SELECT view_id into varExistId FROM views_category_views_hierarchy WHERE view_id=a_id; IF varExistId = 0 THEN INSERT INTO views_category_views_hierarchy (view_id, folder_views_hierarchy_id) VALUES (a_id, a_new_parent_id); ELSE UPDATE views_category_views_hierarchy SET folder_views_hierarchy_id=a_new_parent_id WHERE view_id=a_id; END IF; return a_id; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_views_hierarchy_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` FUNCTION `func_views_hierarchy_update`(a_id int(11),a_parentId int(11),a_name CHAR(100)) RETURNS int(11)
BEGIN update category_views_hierarchy set parentId=a_parentId, name=a_name where id=a_id; return a_id; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_views_hierarchy_view_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` FUNCTION `func_views_hierarchy_view_delete`(a_id int(11)) RETURNS int(11)
BEGIN DELETE FROM views_category_views_hierarchy WHERE view_id=a_id; return a_id; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_add_cmp_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` PROCEDURE `prc_add_cmp_history`( in a_userId int(11), in a_viewAndCmpId varchar(50), in a_interpretedState varchar(50), in a_ts bigint(20), in a_list_of_values JSON)
begin declare v_usr_name varchar(50); declare v_multiChangesHistoryId int(11); declare v_length bigint unsigned default JSON_LENGTH(a_list_of_values); declare v_index bigint unsigned default 0; declare v_data_point_id int(11); declare v_data_point_value varchar(50); select username into v_usr_name from users where id=a_userId; insert into multi_changes_history ( userId, username, viewAndComponentIdentification, interpretedState, ts ) values ( a_userId, v_usr_name, a_viewAndCmpId, a_interpretedState, a_ts); select last_insert_id() into v_multiChangesHistoryId; while v_index < v_length DO set v_data_point_value = (select JSON_EXTRACT(a_list_of_values, CONCAT('$[', v_index, '].value'))); set v_data_point_id = (select id from dataPoints where xid=(select JSON_EXTRACT(a_list_of_values, CONCAT('$[',v_index,'].xid')))); insert into values_multi_changes_history ( multiChangesHistoryId, value, dataPointId, ts) values ( v_multiChangesHistoryId, v_data_point_value, v_data_point_id, a_ts ); set v_index = v_index + 1; end while; CREATE TEMPORARY TABLE tmp_to_delete select id from multi_changes_history where viewAndComponentIdentification=a_viewAndCmpId order by ts desc limit 10; delete from multi_changes_history where id not in (select id from tmp_to_delete); DROP TEMPORARY TABLE tmp_to_delete; end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_alarms_notify` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` PROCEDURE `prc_alarms_notify`(IN newDataPointId INT, IN newTs BIGINT, IN newPointValue VARCHAR(45))
BEGIN
	DECLARE PLC_ALARM_LEVEL INT(1);
	DECLARE PRESENT_POINT_VALUE INT(1);
	DECLARE ACTUAL_ID_ROW INT UNSIGNED;
	DECLARE IS_RISING_SLOPE BOOLEAN DEFAULT FALSE;
    DECLARE IS_FALLING_SLOPE BOOLEAN DEFAULT FALSE;

	SELECT plcAlarmLevel INTO PLC_ALARM_LEVEL FROM dataPoints WHERE id = newDataPointId;
    SELECT newPointValue INTO PRESENT_POINT_VALUE;

	IF (PLC_ALARM_LEVEL = 1 OR PLC_ALARM_LEVEl = 2) THEN

		SELECT id INTO ACTUAL_ID_ROW FROM plcAlarms WHERE
			dataPointId = newDataPointId AND
            inactiveTime = 0;

		SET IS_RISING_SLOPE = PRESENT_POINT_VALUE = 1 AND ACTUAL_ID_ROW IS NULL;
        SET IS_FALLING_SLOPE = PRESENT_POINT_VALUE = 0 AND ACTUAL_ID_ROW IS NOT NULL;

        IF (IS_RISING_SLOPE OR IS_FALLING_SLOPE) THEN
			INSERT INTO plcAlarms (
					dataPointId,
					dataPointXid,
					dataPointType,
					dataPointName,
					activeTime,
					inactiveTime,
					acknowledgeTime,
					level
				)
				VALUES (
					newDataPointId,
					(SELECT xid FROM dataPoints WHERE id = newDataPointId),
					PLC_ALARM_LEVEL,
					(SELECT pointName FROM dataPoints WHERE id = newDataPointId),
					newTs,
					0,
					0,
					PLC_ALARM_LEVEL
				) ON DUPLICATE KEY UPDATE
					inactiveTime = newTs;
		END IF;
	END IF;END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_views_category_views_hierarchy_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` PROCEDURE `prc_views_category_views_hierarchy_select`()
BEGIN SELECT * FROM views_category_views_hierarchy Order by view_id ASC;END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_views_hierarchy_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` PROCEDURE `prc_views_hierarchy_select`()
BEGIN SELECT * FROM category_views_hierarchy Order by parentId ASC; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_views_hierarchy_select_node` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scadalts`@`%` PROCEDURE `prc_views_hierarchy_select_node`(a_parent_id INT(11))
BEGIN SELECT * FROM category_views_hierarchy WHERE parentid=a_parent_id; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `historyAlarms`
--

/*!50001 DROP TABLE IF EXISTS `historyAlarms`*/;
/*!50001 DROP VIEW IF EXISTS `historyAlarms`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scadalts`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `historyAlarms` AS select `func_fromats_date`(`plcAlarms`.`activeTime`) AS `activeTime`,`func_fromats_date`(`plcAlarms`.`inactiveTime`) AS `inactiveTime`,`func_fromats_date`(`plcAlarms`.`acknowledgeTime`) AS `acknowledgeTime`,`plcAlarms`.`level` AS `level`,`plcAlarms`.`dataPointName` AS `name` from `plcAlarms` order by `plcAlarms`.`inactiveTime` = 0 desc,`func_fromats_date`(`plcAlarms`.`inactiveTime`) desc,`plcAlarms`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `liveAlarms`
--

/*!50001 DROP TABLE IF EXISTS `liveAlarms`*/;
/*!50001 DROP VIEW IF EXISTS `liveAlarms`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scadalts`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `liveAlarms` AS select `plcAlarms`.`id` AS `id`,`func_fromats_date`(`plcAlarms`.`activeTime`) AS `activation-time`,`func_fromats_date`(`plcAlarms`.`inactiveTime`) AS `inactivation-time`,`plcAlarms`.`dataPointType` AS `level`,`plcAlarms`.`dataPointName` AS `name` from `plcAlarms` where `plcAlarms`.`acknowledgeTime` = 0 and (`plcAlarms`.`inactiveTime` = 0 or `plcAlarms`.`inactiveTime` > unix_timestamp(current_timestamp() - interval 24 hour) * 1000) order by `plcAlarms`.`inactiveTime` = 0 desc,`plcAlarms`.`activeTime` desc,`plcAlarms`.`inactiveTime` desc,`plcAlarms`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-19  9:41:53
-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: scadalts
-- ------------------------------------------------------
-- Server version	10.5.9-MariaDB-1:10.5.9+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `category_views_hierarchy`
--

LOCK TABLES `category_views_hierarchy` WRITE;
/*!40000 ALTER TABLE `category_views_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_views_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `compoundEventDetectors`
--

LOCK TABLES `compoundEventDetectors` WRITE;
/*!40000 ALTER TABLE `compoundEventDetectors` DISABLE KEYS */;
/*!40000 ALTER TABLE `compoundEventDetectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dataPointUsers`
--

LOCK TABLES `dataPointUsers` WRITE;
/*!40000 ALTER TABLE `dataPointUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataPointUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dataPointUsersProfiles`
--

LOCK TABLES `dataPointUsersProfiles` WRITE;
/*!40000 ALTER TABLE `dataPointUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataPointUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dataPoints`
--

LOCK TABLES `dataPoints` WRITE;
/*!40000 ALTER TABLE `dataPoints` DISABLE KEYS */;
INSERT INTO `dataPoints` VALUES (1,'DP_SP1_PWR',1,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870774F00000009010013536F6C61722070616E656C203120706F77657201000D536F6C61722070616E656C2031010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178771100000001010004302E3030010003206B57787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877250000000101001022706F776572223A285B5E2C7D5D2B29000000000301000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF000000300001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Solar panel 1 power',0),(2,'DP_SP1_STEMP',1,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775D00000009010021536F6C61722070616E656C203120737572666163652074656D706572617475726501000D536F6C61722070616E656C2031010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178771100000001010003302E3001000420C2B043787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877330000000101001E22737572666163652D74656D7065726174757265223A285B5E2C7D5D2B29000000000301000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000003E0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Solar panel 1 surface temperature',0),(3,'DP_ES1_STATE',2,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775100000009010014456E657267792073746F7265203120737461746501000E456E657267792073746F72652031010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770700000001010000787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178772600000001010011227374617465223A22285B5E225D2B2922000000000401000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Energy store 1 state',0),(4,'DP_ES1_ENERGY',2,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E0001787077590000000901001C456E657267792073746F7265203120656E657267792073746F72656401000E456E657267792073746F72652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770F00000001010003302E300100025768787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178772D0000000101001822656E657267792D73746F726564223A285B5E2C7D5D2B29000000000301000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000007E0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Energy store 1 energy stored',0),(5,'DP_ES1_CHG',2,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775A0000000901001D456E657267792073746F72652031206368617267652070657263656E7401000E456E657267792073746F72652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178771100000001010005302E3030300100022025787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178772E00000001010019226368617267652D70657263656E74223A285B5E2C7D5D2B29000000000301000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF000000620001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Energy store 1 charge percent',0),(6,'DP_GT1_STATE',3,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870774F000000090100134761732074757262696E65203120737461746501000D4761732074757262696E652031010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770700000001010000787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178772600000001010011227374617465223A22285B5E225D2B2922000000000401000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 state',0),(7,'DP_GT1_IGNITION',3,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775D000000090100214761732074757262696E6520312069676E6974696F6E2076616C7665206F70656E01000D4761732074757262696E652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770700000001010000787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178773C000000010100222269676E6974696F6E2D76616C76652D6F70656E223A28747275657C66616C736529000000000101000566616C736501000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 ignition valve open',0),(8,'DP_GT1_STARTER',3,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775C000000090100204761732074757262696E65203120737461727475702076616C7665206F70656E01000D4761732074757262696E652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770700000001010000787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178773B0000000101002122737461727475702D76616C76652D6F70656E223A28747275657C66616C736529000000000101000566616C736501000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 startup valve open',0),(9,'DP_GT1_GEARBOX',3,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E0001787077590000000901001D4761732074757262696E6520312067656172626F7820656E676167656401000D4761732074757262696E652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770700000001010000787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877380000000101001E2267656172626F782D656E6761676564223A28747275657C66616C736529000000000101000566616C736501000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 gearbox engaged',0),(10,'DP_GT1_RPM',3,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870774D000000090100114761732074757262696E6520312072706D01000D4761732074757262696E652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770F00000001010001300100042072706D787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877230000000101000E2272706D223A285B5E2C7D5D2B29000000000301000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 rpm',0),(11,'DP_GT1_EGT',3,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870774D000000090100114761732074757262696E6520312065677401000D4761732074757262696E652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178771000000001010003302E30010003C2B043787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877230000000101000E22656774223A285B5E2C7D5D2B29000000000301000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000003E0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 egt',0),(12,'DP_GT1_FREQ',3,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E000178707753000000090100174761732074757262696E652031206672657175656E637901000D4761732074757262696E652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178771200000001010005302E30303001000320487A787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178772900000001010014226672657175656E6379223A285B5E2C7D5D2B29000000000301000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000001B0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 frequency',0),(13,'DP_GT1_PWR_ELECTRIC',3,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775A0000000901001E4761732074757262696E65203120706F7765722028656C6563747269632901000D4761732074757262696E652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178771200000001010005302E303030010003206B57787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178772E0000000101001922706F7765722D656C656374726963223A285B5E2C7D5D2B29000000000301000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF000000300001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 power (electric)',0),(14,'DP_GT1_PWR_THERMAL',3,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E0001787077590000000901001D4761732074757262696E65203120706F7765722028746865726D616C2901000D4761732074757262696E652031010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178771200000001010005302E303030010003206B57787073720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E48747470526574726965766572506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000649000A646174615479706549645A000F69676E6F726549664D697373696E674C000A74696D65466F726D617471007E00014C000974696D65526567657871007E00014C000B76616C7565466F726D617471007E00014C000A76616C7565526567657871007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178772D0000000101001822706F7765722D746865726D616C223A285B5E2C7D5D2B29000000000301000001000001000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF000000300001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 power (thermal)',0),(24,'DP_GT1_CMD',6,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E000178707759000000090100154761732074757262696E65203120636F6D6D616E640100154761732074757262696E65203120636F6D6D616E64010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E5669727475616C506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C49000C6368616E676554797065496449000A646174615479706549645A00087365747461626C654C0016616C7465726E617465426F6F6C65616E4368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416C7465726E617465426F6F6C65616E4368616E6765564F3B4C0015616E616C6F67417474726163746F724368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416E616C6F67417474726163746F724368616E6765564F3B4C000E62726F776E69616E4368616E676574003C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F42726F776E69616E4368616E6765564F3B4C0015696E6372656D656E74416E616C6F674368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E74416E616C6F674368616E6765564F3B4C0019696E6372656D656E744D756C746973746174654368616E67657400474C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E744D756C746973746174654368616E6765564F3B4C00086E6F4368616E67657400364C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F4E6F4368616E6765564F3B4C001272616E646F6D416E616C6F674368616E67657400404C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D416E616C6F674368616E6765564F3B4C001372616E646F6D426F6F6C65616E4368616E67657400414C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D426F6F6C65616E4368616E6765564F3B4C001672616E646F6D4D756C746973746174654368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D4D756C746973746174654368616E6765564F3B78720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178770D0000000100000004000000050173720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416C7465726E617465426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF03000078720036636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4368616E676554797065564FFFFFFFFFFFFFFFFF0300014C000A737461727456616C756571007E00017870770B000000010100047472756578770400000001787372003A636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E42726F776E69616E4368616E6765564FFFFFFFFFFFFFFFFF0300034400036D61784400096D61784368616E67654400036D696E7871007E001977070000000101000078771C000000010000000000000000000000000000000000000000000000007873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E74416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300044400066368616E67654400036D61784400036D696E5A0004726F6C6C7871007E001977070000000101000078771D00000001000000000000000000000000000000000000000000000000007873720045636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E744D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300025A0004726F6C6C5B000676616C7565737400025B497871007E001977070000000101000078770400000001757200025B494DBA602676EAB2A50200007870000000007701007873720034636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4E6F4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E001977070000000101000078770400000001787372003E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300024400036D61784400036D696E7871007E00197707000000010100007877140000000100000000000000000000000000000000787372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E0019770B0000000101000474727565787704000000017873720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D4D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300015B000676616C75657371007E00207871007E00197707000000010100007877040000000171007E00237873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416E616C6F67417474726163746F724368616E6765564FFFFFFFFFFFFFFFFF03000349001161747472616374696F6E506F696E7449644400096D61784368616E676544000A766F6C6174696C6974797871007E00197707000000010100007877180000000100000000000000000000000000000000000000057878771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Gas turbine 1 command',0),(25,'DP_ES1_CMD',7,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870776700000009010016456E657267792073746F7265203120636F6D6D616E64010022456E657267792073746F72652031207669727475616C206461746120736F75726365010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E5669727475616C506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C49000C6368616E676554797065496449000A646174615479706549645A00087365747461626C654C0016616C7465726E617465426F6F6C65616E4368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416C7465726E617465426F6F6C65616E4368616E6765564F3B4C0015616E616C6F67417474726163746F724368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416E616C6F67417474726163746F724368616E6765564F3B4C000E62726F776E69616E4368616E676574003C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F42726F776E69616E4368616E6765564F3B4C0015696E6372656D656E74416E616C6F674368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E74416E616C6F674368616E6765564F3B4C0019696E6372656D656E744D756C746973746174654368616E67657400474C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E744D756C746973746174654368616E6765564F3B4C00086E6F4368616E67657400364C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F4E6F4368616E6765564F3B4C001272616E646F6D416E616C6F674368616E67657400404C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D416E616C6F674368616E6765564F3B4C001372616E646F6D426F6F6C65616E4368616E67657400414C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D426F6F6C65616E4368616E6765564F3B4C001672616E646F6D4D756C746973746174654368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D4D756C746973746174654368616E6765564F3B78720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178770D0000000100000004000000050173720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416C7465726E617465426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF03000078720036636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4368616E676554797065564FFFFFFFFFFFFFFFFF0300014C000A737461727456616C756571007E00017870770B000000010100047472756578770400000001787372003A636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E42726F776E69616E4368616E6765564FFFFFFFFFFFFFFFFF0300034400036D61784400096D61784368616E67654400036D696E7871007E001977070000000101000078771C000000010000000000000000000000000000000000000000000000007873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E74416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300044400066368616E67654400036D61784400036D696E5A0004726F6C6C7871007E001977070000000101000078771D00000001000000000000000000000000000000000000000000000000007873720045636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E744D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300025A0004726F6C6C5B000676616C7565737400025B497871007E001977070000000101000078770400000001757200025B494DBA602676EAB2A50200007870000000007701007873720034636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4E6F4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E001977070000000101000078770400000001787372003E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300024400036D61784400036D696E7871007E00197707000000010100007877140000000100000000000000000000000000000000787372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E0019770B0000000101000474727565787704000000017873720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D4D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300015B000676616C75657371007E00207871007E00197707000000010100007877040000000171007E00237873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416E616C6F67417474726163746F724368616E6765564FFFFFFFFFFFFFFFFF03000349001161747472616374696F6E506F696E7449644400096D61784368616E676544000A766F6C6174696C6974797871007E00197707000000010100007877180000000100000000000000000000000000000000000000057878771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Energy store 1 command',0),(26,'DP_ES1_IN',7,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870776500000009010014456E657267792073746F7265203120696E707574010022456E657267792073746F72652031207669727475616C206461746120736F75726365010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E5669727475616C506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C49000C6368616E676554797065496449000A646174615479706549645A00087365747461626C654C0016616C7465726E617465426F6F6C65616E4368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416C7465726E617465426F6F6C65616E4368616E6765564F3B4C0015616E616C6F67417474726163746F724368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416E616C6F67417474726163746F724368616E6765564F3B4C000E62726F776E69616E4368616E676574003C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F42726F776E69616E4368616E6765564F3B4C0015696E6372656D656E74416E616C6F674368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E74416E616C6F674368616E6765564F3B4C0019696E6372656D656E744D756C746973746174654368616E67657400474C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E744D756C746973746174654368616E6765564F3B4C00086E6F4368616E67657400364C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F4E6F4368616E6765564F3B4C001272616E646F6D416E616C6F674368616E67657400404C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D416E616C6F674368616E6765564F3B4C001372616E646F6D426F6F6C65616E4368616E67657400414C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D426F6F6C65616E4368616E6765564F3B4C001672616E646F6D4D756C746973746174654368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D4D756C746973746174654368616E6765564F3B78720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178770D0000000100000003000000050173720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416C7465726E617465426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF03000078720036636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4368616E676554797065564FFFFFFFFFFFFFFFFF0300014C000A737461727456616C756571007E00017870770B000000010100047472756578770400000001787372003A636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E42726F776E69616E4368616E6765564FFFFFFFFFFFFFFFFF0300034400036D61784400096D61784368616E67654400036D696E7871007E001977070000000101000078771C000000010000000000000000000000000000000000000000000000007873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E74416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300044400066368616E67654400036D61784400036D696E5A0004726F6C6C7871007E001977070000000101000078771D00000001000000000000000000000000000000000000000000000000007873720045636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E744D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300025A0004726F6C6C5B000676616C7565737400025B497871007E001977070000000101000078770400000001757200025B494DBA602676EAB2A50200007870000000007701007873720034636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4E6F4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E00197708000000010100013078770400000001787372003E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300024400036D61784400036D696E7871007E00197707000000010100007877140000000100000000000000000000000000000000787372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E0019770B0000000101000474727565787704000000017873720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D4D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300015B000676616C75657371007E00207871007E00197707000000010100007877040000000171007E00237873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416E616C6F67417474726163746F724368616E6765564FFFFFFFFFFFFFFFFF03000349001161747472616374696F6E506F696E7449644400096D61784368616E676544000A766F6C6174696C6974797871007E00197707000000010100007877180000000100000000000000000000000000000000000000057878771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Energy store 1 input',0),(27,'DP_ES1_OUT',7,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870776600000009010015456E657267792073746F72652031206F7574707574010022456E657267792073746F72652031207669727475616C206461746120736F75726365010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E5669727475616C506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C49000C6368616E676554797065496449000A646174615479706549645A00087365747461626C654C0016616C7465726E617465426F6F6C65616E4368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416C7465726E617465426F6F6C65616E4368616E6765564F3B4C0015616E616C6F67417474726163746F724368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416E616C6F67417474726163746F724368616E6765564F3B4C000E62726F776E69616E4368616E676574003C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F42726F776E69616E4368616E6765564F3B4C0015696E6372656D656E74416E616C6F674368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E74416E616C6F674368616E6765564F3B4C0019696E6372656D656E744D756C746973746174654368616E67657400474C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E744D756C746973746174654368616E6765564F3B4C00086E6F4368616E67657400364C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F4E6F4368616E6765564F3B4C001272616E646F6D416E616C6F674368616E67657400404C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D416E616C6F674368616E6765564F3B4C001372616E646F6D426F6F6C65616E4368616E67657400414C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D426F6F6C65616E4368616E6765564F3B4C001672616E646F6D4D756C746973746174654368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D4D756C746973746174654368616E6765564F3B78720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178770D0000000100000003000000050173720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416C7465726E617465426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF03000078720036636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4368616E676554797065564FFFFFFFFFFFFFFFFF0300014C000A737461727456616C756571007E00017870770B000000010100047472756578770400000001787372003A636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E42726F776E69616E4368616E6765564FFFFFFFFFFFFFFFFF0300034400036D61784400096D61784368616E67654400036D696E7871007E001977070000000101000078771C000000010000000000000000000000000000000000000000000000007873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E74416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300044400066368616E67654400036D61784400036D696E5A0004726F6C6C7871007E001977070000000101000078771D00000001000000000000000000000000000000000000000000000000007873720045636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E744D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300025A0004726F6C6C5B000676616C7565737400025B497871007E001977070000000101000078770400000001757200025B494DBA602676EAB2A50200007870000000007701007873720034636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4E6F4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E00197708000000010100013078770400000001787372003E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300024400036D61784400036D696E7871007E00197707000000010100007877140000000100000000000000000000000000000000787372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E0019770B0000000101000474727565787704000000017873720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D4D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300015B000676616C75657371007E00207871007E00197707000000010100007877040000000171007E00237873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416E616C6F67417474726163746F724368616E6765564FFFFFFFFFFFFFFFFF03000349001161747472616374696F6E506F696E7449644400096D61784368616E676544000A766F6C6174696C6974797871007E00197707000000010100007877180000000100000000000000000000000000000000000000057878771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Energy store 1 output',0),(28,'DP_196306',8,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E0001787077650000000901001B436162696E65742044656C66696E6F20636F6E73756D7074696F6E01001B436162696E65742044656C66696E6F20636F6E73756D7074696F6E010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000000000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Delfino consumption',0),(29,'DP_014777',8,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775400000009010016436162696E65742044656C66696E6F2073746174757301000F436162696E65742044656C66696E6F010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000001000000010000000100000000000000000000000100054153434949013FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Delfino status',0),(32,'DP_699088',8,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775600000009010018436162696E65742044656C66696E6F206D6178206C6F616401000F436162696E65742044656C66696E6F010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000100000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Delfino max load',0),(33,'DP_720986',10,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E0001787077650000000901001B436162696E6574204C61676F72696F20636F6E73756D7074696F6E01001B436162696E6574204C61676F72696F20636F6E73756D7074696F6E010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000000000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Lagorio consumption',0),(34,'DP_722458',10,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775B00000009010016436162696E6574204C61676F72696F20737461747573010016436162696E6574204C61676F72696F20737461747573010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000001000000010000000100000000000000000000000100054153434949013FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Lagorio status',0),(35,'DP_452580',10,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775F00000009010018436162696E6574204C61676F72696F206D6178206C6F6164010018436162696E6574204C61676F72696F206D6178206C6F6164010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000100000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Lagorio max load',0),(45,'DP_695275',14,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E0001787077570000000901001A436162696E6574204D617263686920636F6E73756D7074696F6E01000E436162696E6574204D6172636869010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000000000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Marchi consumption',0),(46,'DP_991451',14,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775400000009010017436162696E6574204D6172636869206D6178206C6F616401000E436162696E6574204D6172636869010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000100000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Marchi max load',0),(47,'DP_006726',14,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775200000009010015436162696E6574204D61726368692073746174757301000E436162696E6574204D6172636869010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000001000000010000000100000000000000000000000100054153434949013FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Marchi status',0),(48,'DP_985279',15,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775800000009010018436162696E6574204C6F636174656C6C6920737461747573010011436162696E6574204C6F636174656C6C69010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000001000000010000000100000000000000000000000100054153434949013FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Locatelli status',0),(49,'DP_832510',15,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775D0000000901001D436162696E6574204C6F636174656C6C6920636F6E73756D7074696F6E010011436162696E6574204C6F636174656C6C69010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000000000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Locatelli consumption',0),(50,'DP_300362',15,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775A0000000901001A436162696E6574204C6F636174656C6C69206D6178206C6F6164010011436162696E6574204C6F636174656C6C69010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000100000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Locatelli max load',0),(51,'DP_714271',18,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E0001787077550000000901001B546F74616C206275696C64696E677320636F6E73756D7074696F6E01000B436F6E73756D7074696F6E010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770D00000001010001300100022057787073720039636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6574612E4D657461506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000749000A64617461547970654964490015657865637574696F6E44656C61795365636F6E64735A00087365747461626C6549000B7570646174654576656E744C0007636F6E7465787471007E00034C000673637269707471007E00014C001175706461746543726F6E5061747465726E71007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178770400000004737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000077704000000077372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E000178700000001C74000764656C66696E6F7371007E0012000000217400076C61676F72696F7371007E0012000000317400096C6F636174656C6C697371007E00120000002D7400066D61726368697371007E0012000000367400037365627371007E00120000003774000A6269626C696F746563617371007E00120000003B7400076C6F616467656E7877D90100C676617220746F74616C203D20302E303B0A746F74616C202B3D2064656C66696E6F2E76616C75653B0A746F74616C202B3D206C61676F72696F2E76616C75653B0A746F74616C202B3D206C6F636174656C6C692E76616C75653B0A746F74616C202B3D206D61726368692E76616C75653B0A746F74616C202B3D207365622E76616C75653B0A746F74616C202B3D206269626C696F746563612E76616C75653B0A746F74616C202B3D206C6F616467656E2E76616C75653B0A72657475726E20746F74616C3B0000000300000000000100000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Total buildings consumption',0),(52,'DP_067592',19,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870774E00000009010014436162696E657420534542206D6178206C6F616401000B436162696E657420534542010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000100000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet SEB max load',0),(53,'DP_336698',19,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870774C00000009010012436162696E6574205345422073746174757301000B436162696E657420534542010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000001000000010000000100000000000000000000000100054153434949013FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet SEB status',0),(54,'DP_936782',19,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775100000009010017436162696E65742073656220636F6E73756D7074696F6E01000B436162696E657420534542010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000000000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet seb consumption',0),(55,'DP_920397',20,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775F0000000901001E436162696E6574204269626C696F7465636120636F6E73756D7074696F6E010012436162696E6574204269626C696F74656361010000000000000002000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000000000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Biblioteca consumption',0),(56,'DP_986636',20,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775C0000000901001B436162696E6574204269626C696F74656361206D6178206C6F6164010012436162696E6574204269626C696F74656361010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000004000000020000000100000000000100000000000100054153434949003FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Biblioteca max load',0),(57,'DP_043608',20,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775A00000009010019436162696E6574204269626C696F7465636120737461747573010012436162696E6574204269626C696F74656361010000000000000001000000020000000F00000001000000000000000000000007000000017372002B636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E506C61696E52656E6465726572FFFFFFFFFFFFFFFF0300014C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF03000078707704000000017877070000000101000078707372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C440008616464697469766542000362697449000E6D6F64627573446174615479706544000A6D756C7469706C6965724900066F666673657449000572616E676549000D7265676973746572436F756E745A00107365747461626C654F76657272696465490007736C61766549645A000C736C6176654D6F6E69746F725A000D736F636B65744D6F6E69746F724C00076368617273657471007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000078707704000000017877340000000600000001000000010000000100000000000000000000000100054153434949013FF0000000000000000000000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Cabinet Biblioteca status',0),(58,'DP_415716',18,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E00017870775300000009010019546F74616C2065787465726E616C20706F776572206472617701000B436F6E73756D7074696F6E010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770D00000001010001300100022057787073720039636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6574612E4D657461506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000749000A64617461547970654964490015657865637574696F6E44656C61795365636F6E64735A00087365747461626C6549000B7570646174654576656E744C0007636F6E7465787471007E00034C000673637269707471007E00014C001175706461746543726F6E5061747465726E71007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178770400000004737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000047704000000047372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E0001787000000033740004636F6E737371007E0012000000017400067370317077727371007E00120000000D7400066774317077727371007E00120000001B7400066573316F7574787A0000012101010E76617220736F6C61725F737572706C7573203D20287370317077722E76616C7565202A20313030302E3029202D20636F6E732E76616C75650A0A69662028736F6C61725F737572706C7573203E203029207B0A202072657475726E20302E300A7D0A0A76617220746F74616C203D204D6174682E61627328736F6C61725F737572706C7573290A0A746F74616C202D3D206573316F75742E76616C7565202A20313030302E300A746F74616C202D3D206774317077722E76616C7565202A20313030302E300A0A0A69662028746F74616C203E20313030302E3029207B0A202072657475726E204D6174682E61627328746F74616C290A7D20656C7365207B0A202072657475726E20302E300A7D0000000300000000000100000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Total external power draw',0),(59,'DP_LG_PWR',21,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E0001787077570000000901001A4C6F61642067656E657261746F7220636F6E73756D7074696F6E01000E4C6F61642067656E657261746F72010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770D0000000101000130010002205778707372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E5669727475616C506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000C49000C6368616E676554797065496449000A646174615479706549645A00087365747461626C654C0016616C7465726E617465426F6F6C65616E4368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416C7465726E617465426F6F6C65616E4368616E6765564F3B4C0015616E616C6F67417474726163746F724368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F416E616C6F67417474726163746F724368616E6765564F3B4C000E62726F776E69616E4368616E676574003C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F42726F776E69616E4368616E6765564F3B4C0015696E6372656D656E74416E616C6F674368616E67657400434C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E74416E616C6F674368616E6765564F3B4C0019696E6372656D656E744D756C746973746174654368616E67657400474C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F496E6372656D656E744D756C746973746174654368616E6765564F3B4C00086E6F4368616E67657400364C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F4E6F4368616E6765564F3B4C001272616E646F6D416E616C6F674368616E67657400404C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D416E616C6F674368616E6765564F3B4C001372616E646F6D426F6F6C65616E4368616E67657400414C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D426F6F6C65616E4368616E6765564F3B4C001672616E646F6D4D756C746973746174654368616E67657400444C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F7669727475616C2F52616E646F6D4D756C746973746174654368616E6765564F3B78720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178770D0000000100000003000000050173720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416C7465726E617465426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF03000078720036636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4368616E676554797065564FFFFFFFFFFFFFFFFF0300014C000A737461727456616C756571007E00017870770B000000010100047472756578770400000001787372003A636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E42726F776E69616E4368616E6765564FFFFFFFFFFFFFFFFF0300034400036D61784400096D61784368616E67654400036D696E7871007E001A77070000000101000078771C000000010000000000000000000000000000000000000000000000007873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E74416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300044400066368616E67654400036D61784400036D696E5A0004726F6C6C7871007E001A77070000000101000078771D00000001000000000000000000000000000000000000000000000000007873720045636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E496E6372656D656E744D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300025A0004726F6C6C5B000676616C7565737400025B497871007E001A77070000000101000078770400000001757200025B494DBA602676EAB2A50200007870000000007701007873720034636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E4E6F4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E001A770A00000001010003302E3078770400000001787372003E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D416E616C6F674368616E6765564FFFFFFFFFFFFFFFFF0300024400036D61784400036D696E7871007E001A7707000000010100007877140000000100000000000000000000000000000000787372003F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D426F6F6C65616E4368616E6765564FFFFFFFFFFFFFFFFF0300007871007E001A770B0000000101000474727565787704000000017873720042636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E52616E646F6D4D756C746973746174654368616E6765564FFFFFFFFFFFFFFFFF0300015B000676616C75657371007E00217871007E001A7707000000010100007877040000000171007E00247873720041636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E416E616C6F67417474726163746F724368616E6765564FFFFFFFFFFFFFFFFF03000349001161747472616374696F6E506F696E7449644400096D61784368616E676544000A766F6C6174696C6974797871007E001A7707000000010100007877180000000100000000000000000000000000000000000000377878771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Load generator consumption',0),(60,'DP_214005',18,0xACED000573720022636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E44617461506F696E74564FFFFFFFFFFFFFFFFF03002049000C64617461536F75726365496449001064617461536F7572636554797065496449001064656661756C74436163686553697A655A00146469736361726445787472656D6556616C75657344001064697363617264486967684C696D697444000F646973636172644C6F774C696D69745A0007656E61626C6564490010656E67696E656572696E67556E6974734900026964490015696E74657276616C4C6F6767696E67506572696F64490019696E74657276616C4C6F6767696E67506572696F6454797065490013696E74657276616C4C6F6767696E675479706549000B6C6F6767696E675479706549000D706F696E74466F6C646572496449000B7075726765506572696F644900097075726765547970655A00087365747461626C65440009746F6C6572616E63654C000B6368617274436F6C6F75727400124C6A6176612F6C616E672F537472696E673B4C000D636861727452656E646572657274002E4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F63686172742F436861727452656E64657265723B4C0008636F6D6D656E74737400104C6A6176612F7574696C2F4C6973743B4C000E64617461536F757263654E616D6571007E00014C000D64617461536F7572636558696471007E00014C000B6465736372697074696F6E71007E00014C000A6465766963654E616D6571007E00014C000E6576656E744465746563746F727371007E00034C00116576656E745465787452656E64657265727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F6576656E742F4576656E745465787452656E64657265723B4C00096C61737456616C75657400314C636F6D2F7365726F746F6E696E2F6D616E676F2F72742F64617461496D6167652F506F696E7456616C756554696D653B4C00046E616D6571007E00014C000C706F696E744C6F6361746F727400324C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F506F696E744C6F6361746F72564F3B4C000C7465787452656E646572657274002C4C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F746578742F5465787452656E64657265723B4C000378696471007E0001787077470000000901000D536F6C6172206465666963697401000B436F6E73756D7074696F6E010000000000000002000000020000000F00000001000000000000000000000007000000017372002C636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E416E616C6F6752656E6465726572FFFFFFFFFFFFFFFF0300034C0006666F726D617471007E00014C000E666F726D6174496E7374616E63657400194C6A6176612F746578742F446563696D616C466F726D61743B4C000673756666697871007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E746578742E426173655465787452656E6465726572FFFFFFFFFFFFFFFF030000787077040000000178770D00000001010001300100022057787073720039636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6574612E4D657461506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF03000749000A64617461547970654964490015657865637574696F6E44656C61795365636F6E64735A00087365747461626C6549000B7570646174654576656E744C0007636F6E7465787471007E00034C000673637269707471007E00014C001175706461746543726F6E5061747465726E71007E000178720038636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E4162737472616374506F696E744C6F6361746F72564FFFFFFFFFFFFFFFFF030000787077040000000178770400000004737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E0001787000000033740004636F6E737371007E001200000001740005736F6C617278777E01006B7661722076616C7565203D2028736F6C61722E76616C7565202A20313030302E3029202D20636F6E732E76616C75653B0A6966202876616C7565203C20302E3029207B0A202072657475726E204D6174682E6162732876616C7565293B0A7D0A72657475726E20302E303B0000000300000000000100000000000078771D0000000100FFEFFFFFFFFFFFFF7FEFFFFFFFFFFFFF0000005F0001000073720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E4E6F6E654576656E7452656E6465726572FFFFFFFFFFFFFFFF03000078720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E6576656E742E426173654576656E745465787452656E6465726572FFFFFFFFFFFFFFFF0300007870770400000001787704000000017878,'Solar deficit',0);
/*!40000 ALTER TABLE `dataPoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dataSourceUsers`
--

LOCK TABLES `dataSourceUsers` WRITE;
/*!40000 ALTER TABLE `dataSourceUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataSourceUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dataSourceUsersProfiles`
--

LOCK TABLES `dataSourceUsersProfiles` WRITE;
/*!40000 ALTER TABLE `dataSourceUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataSourceUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dataSources`
--

LOCK TABLES `dataSources` WRITE;
/*!40000 ALTER TABLE `dataSources` DISABLE KEYS */;
INSERT INTO `dataSources` VALUES (1,'DS_SP1','Solar panel 1',11,0xACED000573720040636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E4874747052657472696576657244617461536F75726365564FFFFFFFFFFFFFFFFF030009490007726574726965735A000473746F7049000E74696D656F75745365636F6E6473490010757064617465506572696F645479706549000D757064617465506572696F64734C000870617373776F72647400124C6A6176612F6C616E672F537472696E673B4C000C726561637469766174696F6E7400274C6F72672F73636164615F6C74732F64732F6D6F64656C2F526561637469766174696F6E44733B4C000375726C71007E00014C0008757365726E616D6571007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D6571007E00014C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0001787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000002737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000017371007E0009000000007371007E00090000000271007E000C787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078776200000002010037687474703A2F2F66726F6E74656E642F6170692F322F7468696E67732F4644543A736F6C61722D70616E656C2D312F66656174757265730100076261636B656E64010006736563726574000000010000000A0000001E0000000200737200256F72672E73636164615F6C74732E64732E6D6F64656C2E526561637469766174696F6E44737A86D40741683C890200035A0005736C6565705300047479706553000576616C75657870000000000178),(2,'DS_ES1','Energy store 1',11,0xACED000573720040636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E4874747052657472696576657244617461536F75726365564FFFFFFFFFFFFFFFFF030009490007726574726965735A000473746F7049000E74696D656F75745365636F6E6473490010757064617465506572696F645479706549000D757064617465506572696F64734C000870617373776F72647400124C6A6176612F6C616E672F537472696E673B4C000C726561637469766174696F6E7400274C6F72672F73636164615F6C74732F64732F6D6F64656C2F526561637469766174696F6E44733B4C000375726C71007E00014C0008757365726E616D6571007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D6571007E00014C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0001787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000002737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000017371007E0009000000007371007E00090000000271007E000C787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078776300000002010038687474703A2F2F66726F6E74656E642F6170692F322F7468696E67732F4644543A656E657267792D73746F72652D312F66656174757265730100076261636B656E6401000673656372657400000001000000010000001E0000000200737200256F72672E73636164615F6C74732E64732E6D6F64656C2E526561637469766174696F6E44737A86D40741683C890200035A0005736C6565705300047479706553000576616C75657870000000000178),(3,'DS_GT1','Gas turbine 1',11,0xACED000573720040636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E687474702E4874747052657472696576657244617461536F75726365564FFFFFFFFFFFFFFFFF030009490007726574726965735A000473746F7049000E74696D656F75745365636F6E6473490010757064617465506572696F645479706549000D757064617465506572696F64734C000870617373776F72647400124C6A6176612F6C616E672F537472696E673B4C000C726561637469766174696F6E7400274C6F72672F73636164615F6C74732F64732F6D6F64656C2F526561637469766174696F6E44733B4C000375726C71007E00014C0008757365726E616D6571007E00017872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D6571007E00014C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0001787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000002737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000017371007E0009000000007371007E00090000000271007E000C787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078776400000002010039687474703A2F2F66726F6E74656E642F6170692F322F7468696E67732F4644543A6761732D67656E657261746F722D312F66656174757265730100076261636B656E6401000673656372657400000001000000010000001E0000000200737200256F72672E73636164615F6C74732E64732E6D6F64656C2E526561637469766174696F6E44737A86D40741683C890200035A0005736C6565705300047479706553000576616C75657870000000000178),(6,'DS_GT1_CMDS','Gas turbine 1 virtual data source',1,0xACED00057372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E5669727475616C44617461536F75726365564FFFFFFFFFFFFFFFFF030002490010757064617465506572696F645479706549000D757064617465506572696F64737872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0003787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078770C00000002000000030000001878),(7,'DS_ES1_CMD','Energy store 1 virtual data source',1,0xACED00057372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E5669727475616C44617461536F75726365564FFFFFFFFFFFFFFFFF030002490010757064617465506572696F645479706549000D757064617465506572696F64737872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0003787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078770C00000002000000030000001878),(8,'DS_146308','Cabinet Delfino',3,0xACED00057372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564FFFFFFFFFFFFFFFFF0300055A0018637265617465536F636B65744D6F6E69746F72506F696E745A000C656E63617073756C61746564490004706F72744C0004686F73747400124C6A6176612F6C616E672F537472696E673B4C000D7472616E73706F72745479706574004D4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F6D6F646275732F4D6F64627573497044617461536F75726365564F245472616E73706F7274547970653B7872003B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F6462757344617461536F75726365564FFFFFFFFFFFFFFFFF03000A5A0011636F6E746967756F7573426174636865735A0018637265617465536C6176654D6F6E69746F72506F696E747349000F6D617852656164426974436F756E744900146D6178526561645265676973746572436F756E744900156D617857726974655265676973746572436F756E745A00087175616E74697A654900077265747269657349000774696D656F7574490010757064617465506572696F645479706549000D757064617465506572696F64737872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D6571007E00014C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0001787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078772300000007000000010000000A00000001F4000000020000000007D00000007D00000078787704000000037E72004B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564F245472616E73706F72745479706500000000000000001200007872000E6A6176612E6C616E672E456E756D00000000000000001200007870740003544350771801000F636162696E65745F64656C66696E6F000001F6000078),(10,'DS_753486','Cabinet Lagorio',3,0xACED00057372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564FFFFFFFFFFFFFFFFF0300055A0018637265617465536F636B65744D6F6E69746F72506F696E745A000C656E63617073756C61746564490004706F72744C0004686F73747400124C6A6176612F6C616E672F537472696E673B4C000D7472616E73706F72745479706574004D4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F6D6F646275732F4D6F64627573497044617461536F75726365564F245472616E73706F7274547970653B7872003B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F6462757344617461536F75726365564FFFFFFFFFFFFFFFFF03000A5A0011636F6E746967756F7573426174636865735A0018637265617465536C6176654D6F6E69746F72506F696E747349000F6D617852656164426974436F756E744900146D6178526561645265676973746572436F756E744900156D617857726974655265676973746572436F756E745A00087175616E74697A654900077265747269657349000774696D656F7574490010757064617465506572696F645479706549000D757064617465506572696F64737872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D6571007E00014C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0001787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078772300000007000000010000000A00000001F4000000020000000007D00000007D00000078787704000000037E72004B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564F245472616E73706F72745479706500000000000000001200007872000E6A6176612E6C616E672E456E756D00000000000000001200007870740003544350771801000F636162696E65745F6C61676F72696F000001F6000078),(14,'DS_032311','Cabinet Marchi',3,0xACED00057372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564FFFFFFFFFFFFFFFFF0300055A0018637265617465536F636B65744D6F6E69746F72506F696E745A000C656E63617073756C61746564490004706F72744C0004686F73747400124C6A6176612F6C616E672F537472696E673B4C000D7472616E73706F72745479706574004D4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F6D6F646275732F4D6F64627573497044617461536F75726365564F245472616E73706F7274547970653B7872003B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F6462757344617461536F75726365564FFFFFFFFFFFFFFFFF03000A5A0011636F6E746967756F7573426174636865735A0018637265617465536C6176654D6F6E69746F72506F696E747349000F6D617852656164426974436F756E744900146D6178526561645265676973746572436F756E744900156D617857726974655265676973746572436F756E745A00087175616E74697A654900077265747269657349000774696D656F7574490010757064617465506572696F645479706549000D757064617465506572696F64737872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D6571007E00014C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0001787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078772300000007000000010000000A00000001F4000000020000000007D00000007D00000078787704000000037E72004B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564F245472616E73706F72745479706500000000000000001200007872000E6A6176612E6C616E672E456E756D00000000000000001200007870740003544350771701000E636162696E65745F6D6172636869000001F6000078),(15,'DS_491583','Cabinet Locatelli',3,0xACED00057372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564FFFFFFFFFFFFFFFFF0300055A0018637265617465536F636B65744D6F6E69746F72506F696E745A000C656E63617073756C61746564490004706F72744C0004686F73747400124C6A6176612F6C616E672F537472696E673B4C000D7472616E73706F72745479706574004D4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F6D6F646275732F4D6F64627573497044617461536F75726365564F245472616E73706F7274547970653B7872003B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F6462757344617461536F75726365564FFFFFFFFFFFFFFFFF03000A5A0011636F6E746967756F7573426174636865735A0018637265617465536C6176654D6F6E69746F72506F696E747349000F6D617852656164426974436F756E744900146D6178526561645265676973746572436F756E744900156D617857726974655265676973746572436F756E745A00087175616E74697A654900077265747269657349000774696D656F7574490010757064617465506572696F645479706549000D757064617465506572696F64737872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D6571007E00014C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0001787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078772300000007000000010000000A00000001F4000000020000000007D00000007D00000078787704000000037E72004B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564F245472616E73706F72745479706500000000000000001200007872000E6A6176612E6C616E672E456E756D00000000000000001200007870740003544350771A010011636162696E65745F6C6F636174656C6C69000001F6000078),(18,'DS_942229','Consumption',9,0xACED000573720037636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6574612E4D65746144617461536F75726365564FFFFFFFFFFFFFFFFF0300007872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0003787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C02000078707877040000000178),(19,'DS_436392','Cabinet SEB',3,0xACED00057372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564FFFFFFFFFFFFFFFFF0300055A0018637265617465536F636B65744D6F6E69746F72506F696E745A000C656E63617073756C61746564490004706F72744C0004686F73747400124C6A6176612F6C616E672F537472696E673B4C000D7472616E73706F72745479706574004D4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F6D6F646275732F4D6F64627573497044617461536F75726365564F245472616E73706F7274547970653B7872003B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F6462757344617461536F75726365564FFFFFFFFFFFFFFFFF03000A5A0011636F6E746967756F7573426174636865735A0018637265617465536C6176654D6F6E69746F72506F696E747349000F6D617852656164426974436F756E744900146D6178526561645265676973746572436F756E744900156D617857726974655265676973746572436F756E745A00087175616E74697A654900077265747269657349000774696D656F7574490010757064617465506572696F645479706549000D757064617465506572696F64737872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D6571007E00014C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0001787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078772300000007000000010000000A00000001F4000000020000000007D00000007D00000078787704000000037E72004B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564F245472616E73706F72745479706500000000000000001200007872000E6A6176612E6C616E672E456E756D00000000000000001200007870740003544350771401000B636162696E65745F736562000001F6000078),(20,'DS_895909','Cabinet Biblioteca',3,0xACED00057372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564FFFFFFFFFFFFFFFFF0300055A0018637265617465536F636B65744D6F6E69746F72506F696E745A000C656E63617073756C61746564490004706F72744C0004686F73747400124C6A6176612F6C616E672F537472696E673B4C000D7472616E73706F72745479706574004D4C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F64617461536F757263652F6D6F646275732F4D6F64627573497044617461536F75726365564F245472616E73706F7274547970653B7872003B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F6462757344617461536F75726365564FFFFFFFFFFFFFFFFF03000A5A0011636F6E746967756F7573426174636865735A0018637265617465536C6176654D6F6E69746F72506F696E747349000F6D617852656164426974436F756E744900146D6178526561645265676973746572436F756E744900156D617857726974655265676973746572436F756E745A00087175616E74697A654900077265747269657349000774696D656F7574490010757064617465506572696F645479706549000D757064617465506572696F64737872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D6571007E00014C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0001787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078772300000007000000010000000A00000001F4000000020000000007D00000007D00000078787704000000037E72004B636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E6D6F646275732E4D6F64627573497044617461536F75726365564F245472616E73706F72745479706500000000000000001200007872000E6A6176612E6C616E672E456E756D00000000000000001200007870740003544350771B010012636162696E65745F6269626C696F74656361000001F6000078),(21,'DS_679787','Load generator',1,0xACED00057372003D636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E7669727475616C2E5669727475616C44617461536F75726365564FFFFFFFFFFFFFFFFF030002490010757064617465506572696F645479706549000D757064617465506572696F64737872002E636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E64617461536F757263652E44617461536F75726365564FFFFFFFFFFFFFFFFF0300065A0007656E61626C656449000269644C000B616C61726D4C6576656C7374000F4C6A6176612F7574696C2F4D61703B4C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000573746174657400214C6F72672F73636164615F6C74732F64732F73746174652F49537461746544733B4C000378696471007E0003787077050000000201737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000077080000001000000000787372002E6F72672E73636164615F6C74732E64732E73746174652E557365724368616E6765456E61626C6553746174654473162808A62679867C020000787078770C00000002000000030000001878);
/*!40000 ALTER TABLE `dataSources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `eventDetectorTemplates`
--

LOCK TABLES `eventDetectorTemplates` WRITE;
/*!40000 ALTER TABLE `eventDetectorTemplates` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventDetectorTemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `eventHandlers`
--

LOCK TABLES `eventHandlers` WRITE;
/*!40000 ALTER TABLE `eventHandlers` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventHandlers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `flexProjects`
--

LOCK TABLES `flexProjects` WRITE;
/*!40000 ALTER TABLE `flexProjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexProjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mailingListInactive`
--

LOCK TABLES `mailingListInactive` WRITE;
/*!40000 ALTER TABLE `mailingListInactive` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailingListInactive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mailingListMembers`
--

LOCK TABLES `mailingListMembers` WRITE;
/*!40000 ALTER TABLE `mailingListMembers` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailingListMembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mailingLists`
--

LOCK TABLES `mailingLists` WRITE;
/*!40000 ALTER TABLE `mailingLists` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailingLists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `maintenanceEvents`
--

LOCK TABLES `maintenanceEvents` WRITE;
/*!40000 ALTER TABLE `maintenanceEvents` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenanceEvents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mangoViewUsers`
--

LOCK TABLES `mangoViewUsers` WRITE;
/*!40000 ALTER TABLE `mangoViewUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `mangoViewUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mangoViews`
--

LOCK TABLES `mangoViews` WRITE;
/*!40000 ALTER TABLE `mangoViews` DISABLE KEYS */;
INSERT INTO `mangoViews` VALUES (1,'GV_SUMMARY','Summary','uploads/1.png',1,0,0xACED00057372001D636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E56696577FFFFFFFFFFFFFFFF03000849000F616E6F6E796D6F757341636365737349000269644900067573657249644C00126261636B67726F756E6446696C656E616D657400124C6A6176612F6C616E672F537472696E673B4C00046E616D6571007E00014C000E76696577436F6D706F6E656E74737400104C6A6176612F7574696C2F4C6973743B4C000976696577557365727371007E00024C000378696471007E00017870770400000001737200296A6176612E7574696C2E636F6E63757272656E742E436F70794F6E577269746541727261794C697374785D9FD546AB90C3030000787077040000003D7372003A636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E636F6D706F6E656E742E44796E616D696347726170686963436F6D706F6E656E74FFFFFFFFFFFFFFFF0300045A000B646973706C6179546578744400036D61784400036D696E4C000C64796E616D6963496D6167657400274C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F44796E616D6963496D6167653B78720031636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E636F6D706F6E656E742E506F696E74436F6D706F6E656E74FFFFFFFFFFFFFFFF0300075A000F646973706C6179436F6E74726F6C735A00107365747461626C654F766572726964655A000576616C69645A000776697369626C654C0011626B6764436F6C6F724F7665727269646571007E00014C000964617461506F696E747400244C636F6D2F7365726F746F6E696E2F6D616E676F2F766F2F44617461506F696E74564F3B4C000C6E616D654F7665727269646571007E000178720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E636F6D706F6E656E742E56696577436F6D706F6E656E74FFFFFFFFFFFFFFFF030005490005696E64657849000178490001794C0008696453756666697871007E00014C00057374796C6571007E0001787077110000000100000001000000028F000000B9787710000000010000000A010000000100000078771C000000010100044469616C000000000000000040F86A000000000001787371007E000677110000000100000002000000035B000000BA787710000000010000000B010000000100000078771C000000010100044469616C0000000000000000408450000000000001787371007E00067711000000010000000300000002AB00000164787710000000010000000D010000000100000078772100000001010009536D616C6C4469616C0000000000000000405180000000000001787371007E000677110000000100000004000000030900000164787710000000010000000C010000000100000078772100000001010009536D616C6C4469616C0000000000000000404900000000000001787371007E000677110000000100000005000000037700000168787710000000010000000E010000000100000078772100000001010009536D616C6C4469616C0000000000000000405E000000000000017873720039636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E636F6D706F6E656E742E42696E61727947726170686963436F6D706F6E656E74FFFFFFFFFFFFFFFF0300024900086F6E65496D6167654900097A65726F496D61676578720034636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E636F6D706F6E656E742E496D616765536574436F6D706F6E656E74FFFFFFFFFFFFFFFF0300025A000B646973706C6179546578744C0008696D6167655365747400234C636F6D2F7365726F746F6E696E2F6D616E676F2F766965772F496D6167655365743B7871007E000877110000000100000006000000032B000001D47877100000000100000009010000000100000078770E000000010100064C65647331360078770C000000010000000300000004787371007E001077110000000100000007000000033D000001D47877100000000100000009010000000100000078770E000000010100064C65647331360078770C0000000100000007000000067873720037636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E636F6D706F6E656E742E53696D706C65506F696E74436F6D706F6E656E74FFFFFFFFFFFFFFFF0300025A0010646973706C6179506F696E744E616D654C000E7374796C6541747472696275746571007E00017871007E00087711000000010000000800000002FD000000A4787710000000010000000601000000010000007877080000000301010000787372003362722E6F72672E736361646162722E766965772E636F6D706F6E656E742E536372697074427574746F6E436F6D706F6E656E74FFFFFFFFFFFFFFFF0300024C000973637269707458696471007E00014C00047465787471007E000178720030636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E636F6D706F6E656E742E48746D6C436F6D706F6E656E74FFFFFFFFFFFFFFFF0300014C0007636F6E74656E7471007E00017871007E000A77110000000100000009000000036B000001C37877510000000101004A3C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F4754315F535441525422293B273E53544152543C2F627574746F6E3E7877680000000101004A3C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F4754315F535441525422293B273E53544152543C2F627574746F6E3E01000C53435F4754315F53544152540100055354415254787371007E00177711000000010000000A000000036F000001E878774F000000010100483C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F4754315F53544F5022293B273E53544F503C2F627574746F6E3E787764000000010100483C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F4754315F53544F5022293B273E53544F503C2F627574746F6E3E01000B53435F4754315F53544F5001000453544F50787371007E00187711000000010000000B00000002D0000001D67877160000000101000F47656172626F7820656E6761676564787371007E00187711000000010000000C00000002F7000001C47877110000000101000A4675656C2076616C7665787371007E00187711000000010000000D00000002F7000001F27877140000000101000D537461727475702076616C7665787371007E00107711000000010000000E000000032C000001C27877100000000100000007010000000100000078770E000000010100064C65647331360078770C000000010000000300000004787371007E00107711000000010000000F0000000339000001ED787710000000010000000801000000010000007877160000000101000E426C696E6B696E674C69676874730078770C000000010000000100000000787371007E00187711000000010000001000000002CE0000011378770A0000000101000352504D787371007E001877110000000100000011000000039D0000011678770A00000001010003454754787371007E001077110000000100000012000000033E000001C27877100000000100000007010000000100000078770E000000010100064C65647331360078770C000000010000000700000006787371007E001877110000000100000013000000035A0000016078770E00000001010007546865726D616C787371007E00187711000000010000001400000002EF0000015D78770F00000001010008456C656374726963787371007E00157711000000010000001500000002E10000000D787710000000010000000301000000010000007877080000000301010000787371007E00067711000000010000001600000002FA00000022787710000000010000000501000000010000007877270000000101000F486F72697A6F6E74616C4C6576656C0000000000000000405900000000000001787371007E00067711000000010000001700000003A9000000067877100000000100000004010000000100000078772100000001010009536D616C6C4469616C000000000000000041024F800000000001787371007E00067711000000010000001800000002F40000023B7877100000000100000001010000000100000078771C000000010100044469616C0000000000000000406F40000000000001787371007E000677110000000100000019000000039E0000025C787710000000010000000201000000010000007877250000000101000D566572746963616C4C6576656C0000000000000000404900000000000001787371007E00187711000000010000001A0000000352000002257877140000000101000D536F6C61722070616E656C2031787371007E00157711000000010000001B000000022900000041787710000000010000001A01000000010000007877080000000301010000787371007E00177711000000010000001C000000031D0000003A78774A000000010100433C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F35393031363422293B273E2B3C2F627574746F6E3E78775A000000010100433C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F35393031363422293B273E2B3C2F627574746F6E3E01000953435F3539303136340100012B787371007E00177711000000010000001D000000035E0000003A78774A000000010100433C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F35383839383822293B273E2D3C2F627574746F6E3E78775A000000010100433C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F35383839383822293B273E2D3C2F627574746F6E3E01000953435F3538383938380100012D787371007E00177711000000010000001E00000002C10000003B78774D000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F39363035393022293B273E5A65726F3C2F627574746F6E3E787760000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F39363035393022293B273E5A65726F3C2F627574746F6E3E01000953435F3936303539300100045A65726F787371007E00157711000000010000001F000000022800000064787710000000010000001B01000000010000007877080000000301010000787371007E00177711000000010000002000000002C10000005D78774D000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F30393238323422293B273E5A65726F3C2F627574746F6E3E787760000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F30393238323422293B273E5A65726F3C2F627574746F6E3E01000953435F3039323832340100045A65726F787371007E001777110000000100000021000000031B0000005C78774A000000010100433C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F37333630323022293B273E2B3C2F627574746F6E3E78775A000000010100433C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F37333630323022293B273E2B3C2F627574746F6E3E01000953435F3733363032300100012B787371007E001777110000000100000022000000035E0000005C78774A000000010100433C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F39363637333022293B273E2D3C2F627574746F6E3E78775A000000010100433C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F39363637333022293B273E2D3C2F627574746F6E3E01000953435F3936363733300100012D787371007E001577110000000100000023000000010A00000116787710000000010000001C0100000001000000787706000000030000787371007E001577110000000100000024000000017F0000018978771000000001000000210100000001000000787706000000030000787371007E00157711000000010000002500000001230000028978771000000001000000310100000001000000787706000000030000787371007E00157711000000010000002600000001A4000001DA787710000000010000002D0100000001000000787706000000030000787372002D62722E6F72672E736361646162722E766965772E636F6D706F6E656E742E427574746F6E436F6D706F6E656E74FFFFFFFFFFFFFFFF03000449000668656967687449000577696474684C000C7768656E4F66664C6162656C71007E00014C000B7768656E4F6E4C6162656C71007E000178720032636F6D2E7365726F746F6E696E2E6D616E676F2E766965772E636F6D706F6E656E742E536372697074436F6D706F6E656E74FFFFFFFFFFFFFFFF0300014C000673637269707471007E00017871007E000877110000000100000027000000010E00000125787710000000010000001D0100000001000000787A0000016B000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B787A0000017E000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B0100034F46460100024F4E0000000000000000787371007E00377711000000010000002800000001830000019878771000000001000000220100000001000000787A0000016B000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B787A0000017E000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B0100034F46460100024F4E0000000000000000787371007E00377711000000010000002900000001AF000001EB787710000000010000002F0100000001000000787A0000016B000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B787A0000017E000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B0100034F46460100024F4E0000000000000000787371007E00377711000000010000002A000000012B0000029878771000000001000000300100000001000000787A0000016B000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B787A0000017E000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B0100034F46460100024F4E0000000000000000787371007E00107711000000010000002B000000011100000106787710000000010000001D010000000100000078770E000000010100064C65647331360078770C000000010000000800000004787371007E00107711000000010000002C0000000188000001787877100000000100000022010000000100000078770E000000010100064C65647331360078770C000000010000000800000004787371007E00107711000000010000002D00000001B0000001C9787710000000010000002F010000000100000078770E000000010100064C65647331360078770C000000010000000800000004787371007E00107711000000010000002E0000000132000002777877100000000100000030010000000100000078770E000000010100064C65647331360078770C000000010000000800000004787371007E00157711000000010000002F00000001210000003A787710000000010000003301000000010000007877080000000301010000787371007E00157711000000010000003000000000CA000000A878771000000001000000360100000001000000787706000000030000787371007E00377711000000010000003100000000CD000000B878771000000001000000350100000001000000787A0000016B000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B787A0000017E000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B0100034F46460100024F4E0000000000000000787371007E00107711000000010000003200000000D2000000977877100000000100000035010000000100000078770E000000010100064C65647331360078770C000000010000000800000004787371007E00157711000000010000003300000000880000015C78771000000001000000370100000001000000787706000000030000787371007E003777110000000100000034000000008B0000016B78771000000001000000390100000001000000787A0000016B000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B787A0000017E000000010101647661722073203D2027273B6966202876616C756529202073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F464627206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2066616C7365293B72657475726E2066616C73653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B20656C73652073202B3D20223C696E70757420747970653D27627574746F6E272076616C75653D274F4E27206F6E636C69636B3D276D616E676F2E766965772E736574506F696E7428222B20706F696E742E6964202B222C222B20706F696E74436F6D706F6E656E742E6964202B222C2074727565293B72657475726E20747275653B27207374796C653D276261636B67726F756E642D636F6C6F723A3B272F3E223B2072657475726E20733B0100034F46460100024F4E0000000000000000787371007E00107711000000010000003500000000920000014A7877100000000100000039010000000100000078770E000000010100064C65647331360078770C000000010000000800000004787372002B62722E6F72672E736361646162722E766965772E636F6D706F6E656E742E4C696E6B436F6D706F6E656E74FFFFFFFFFFFFFFFF0300024C00046C696E6B71007E00014C00047465787471007E00017871007E00187711000000010000003600000001410000005078773F000000010100383C6120687265663D27687474703A2F2F3132372E302E302E313A38303832273E5365652061637469766520776F726B666C6F77733C2F613E787764000000010100333C6120687265663D27687474703A2F2F31302E302E302E3233273E5365652061637469766520776F726B666C6F77733C2F613E010010687474703A2F2F31302E302E302E32330100145365652061637469766520776F726B666C6F7773787371007E001577110000000100000037000000011D00000014787710000000010000003A01000000010000007877080000000301010000787371007E001577110000000100000038000000019B000000A0787710000000010000003B01000000010000007877080000000301010000787371007E0017771100000001000000390000000178000000B778774D000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F33333034303622293B273E2D316B573C2F627574746F6E3E787760000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F33333034303622293B273E2D316B573C2F627574746F6E3E01000953435F3333303430360100042D316B57787371007E00177711000000010000003A0000000218000000B778774D000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F39363034303122293B273E2B316B573C2F627574746F6E3E787760000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F39363034303122293B273E2B316B573C2F627574746F6E3E01000953435F3936303430310100042B316B57787371007E00177711000000010000003B00000001C9000000B878774D000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F30393037303222293B273E5A65726F3C2F627574746F6E3E787760000000010100463C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F30393037303222293B273E5A65726F3C2F627574746F6E3E01000953435F3039303730320100045A65726F787371007E00177711000000010000003C00000001A9000000D97877540000000101004D3C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F36343230353922293B273E4D6174636820736F6C61723C2F627574746F6E3E78776E0000000101004D3C627574746F6E206F6E636C69636B3D276D616E676F2E766965772E65786563757465536372697074282253435F36343230353922293B273E4D6174636820736F6C61723C2F627574746F6E3E01000953435F36343230353901000B4D6174636820736F6C6172787371007E00157711000000010000003D000000011E00000027787710000000010000003C01000000010000007877080000000301010000787878,1024,768,'2021-05-24 15:17:28');
/*!40000 ALTER TABLE `mangoViews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `multi_changes_history`
--

LOCK TABLES `multi_changes_history` WRITE;
/*!40000 ALTER TABLE `multi_changes_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `multi_changes_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `plcAlarms`
--

LOCK TABLES `plcAlarms` WRITE;
/*!40000 ALTER TABLE `plcAlarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `plcAlarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pointEventDetectors`
--

LOCK TABLES `pointEventDetectors` WRITE;
/*!40000 ALTER TABLE `pointEventDetectors` DISABLE KEYS */;
INSERT INTO `pointEventDetectors` VALUES (3,'PED_518005','Battery almost empty',5,2,0,10,0,1,'N',0,2,NULL,0),(5,'PED_726664','Battery almost full',5,1,0,90,0,1,'N',0,2,NULL,0);
/*!40000 ALTER TABLE `pointEventDetectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pointHierarchy`
--

LOCK TABLES `pointHierarchy` WRITE;
/*!40000 ALTER TABLE `pointHierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `pointHierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pointLinks`
--

LOCK TABLES `pointLinks` WRITE;
/*!40000 ALTER TABLE `pointLinks` DISABLE KEYS */;
INSERT INTO `pointLinks` VALUES (1,'PL_078470',26,25,'return \"TAKE \" + source.value',2,'N'),(2,'PL_708123',27,25,'return \"GIVE \" + source.value',2,'N');
/*!40000 ALTER TABLE `pointLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
INSERT INTO `publishers` VALUES (1,'PUB_GT1_CMDS',0xACED000573720036636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E7075626C6973682E6874747053656E6465722E4874747053656E646572564FFFFFFFFFFFFFFFFF03000949000A64617465466F726D61745A00127261697365526573756C745761726E696E675A00077573654A534F4E5A0007757365506F73744C000870617373776F72647400124C6A6176612F6C616E672F537472696E673B4C000D737461746963486561646572737400104C6A6176612F7574696C2F4C6973743B4C0010737461746963506172616D657465727371007E00024C000375726C71007E00014C0008757365726E616D6571007E00017872002A636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E7075626C6973682E5075626C6973686572564FFFFFFFFFFFFFFFFF03000A49001063616368655761726E696E6753697A655A000B6368616E6765734F6E6C795A0007656E61626C656449000269645A000C73656E64536E617073686F74490016736E617073686F7453656E64506572696F6454797065490013736E617073686F7453656E64506572696F64734C00046E616D6571007E00014C0006706F696E747371007E00024C000378696471007E0001787077240000000201001C4761732074757262696E65203120446974746F20436F6D6D616E647301737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000177040000000173720035636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E7075626C6973682E6874747053656E6465722E48747470506F696E74564FFFFFFFFFFFFFFFFF0300025A0010696E636C75646554696D657374616D704C000D706172616D657465724E616D6571007E00017872002F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E7075626C6973682E5075626C6973686564506F696E74564FFFFFFFFFFFFFFFFF03000149000B64617461506F696E74496478707708000000010000001878770B00000001010003636D64007878770E000000006400000000020000000578776300000004010047687474703A2F2F66726F6E74656E642F6170692F322F7468696E67732F4644543A6761732D67656E657261746F722D312F696E626F782F6D657373616765732F636F6D6D616E640100076261636B656E6401000673656372657401017371007E000500000000770400000000787371007E000500000000770400000000787705000000000178),(2,'PUB_ES1_CMD',0xACED000573720036636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E7075626C6973682E6874747053656E6465722E4874747053656E646572564FFFFFFFFFFFFFFFFF03000949000A64617465466F726D61745A00127261697365526573756C745761726E696E675A00077573654A534F4E5A0007757365506F73744C000870617373776F72647400124C6A6176612F6C616E672F537472696E673B4C000D737461746963486561646572737400104C6A6176612F7574696C2F4C6973743B4C0010737461746963506172616D657465727371007E00024C000375726C71007E00014C0008757365726E616D6571007E00017872002A636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E7075626C6973682E5075626C6973686572564FFFFFFFFFFFFFFFFF03000A49001063616368655761726E696E6753697A655A000B6368616E6765734F6E6C795A0007656E61626C656449000269645A000C73656E64536E617073686F74490016736E617073686F7453656E64506572696F6454797065490013736E617073686F7453656E64506572696F64734C00046E616D6571007E00014C0006706F696E747371007E00024C000378696471007E0001787077250000000201001D456E657267792073746F7265203120446974746F20636F6D6D616E647301737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000177040000000173720035636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E7075626C6973682E6874747053656E6465722E48747470506F696E74564FFFFFFFFFFFFFFFFF0300025A0010696E636C75646554696D657374616D704C000D706172616D657465724E616D6571007E00017872002F636F6D2E7365726F746F6E696E2E6D616E676F2E766F2E7075626C6973682E5075626C6973686564506F696E74564FFFFFFFFFFFFFFFFF03000149000B64617461506F696E74496478707708000000010000001978770B00000001010003636D64007878770E000000006400000000020000000578776200000004010046687474703A2F2F66726F6E74656E642F6170692F322F7468696E67732F4644543A656E657267792D73746F72652D312F696E626F782F6D657373616765732F636F6D6D616E640100076261636B656E6401000673656372657401017371007E000500000000770400000000787371007E000500000000770400000000787705000000000178);
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reportInstanceData`
--

LOCK TABLES `reportInstanceData` WRITE;
/*!40000 ALTER TABLE `reportInstanceData` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstanceData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reportInstanceDataAnnotations`
--

LOCK TABLES `reportInstanceDataAnnotations` WRITE;
/*!40000 ALTER TABLE `reportInstanceDataAnnotations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstanceDataAnnotations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reportInstanceEvents`
--

LOCK TABLES `reportInstanceEvents` WRITE;
/*!40000 ALTER TABLE `reportInstanceEvents` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstanceEvents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reportInstancePoints`
--

LOCK TABLES `reportInstancePoints` WRITE;
/*!40000 ALTER TABLE `reportInstancePoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstancePoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reportInstanceUserComments`
--

LOCK TABLES `reportInstanceUserComments` WRITE;
/*!40000 ALTER TABLE `reportInstanceUserComments` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstanceUserComments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reportInstances`
--

LOCK TABLES `reportInstances` WRITE;
/*!40000 ALTER TABLE `reportInstances` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `scheduledEvents`
--

LOCK TABLES `scheduledEvents` WRITE;
/*!40000 ALTER TABLE `scheduledEvents` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduledEvents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `scheduledExecuteInactiveEvent`
--

LOCK TABLES `scheduledExecuteInactiveEvent` WRITE;
/*!40000 ALTER TABLE `scheduledExecuteInactiveEvent` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduledExecuteInactiveEvent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `schema_version`
--

LOCK TABLES `schema_version` WRITE;
/*!40000 ALTER TABLE `schema_version` DISABLE KEYS */;
INSERT INTO `schema_version` VALUES (1,'1','BaseVersion','JDBC','org.scada_lts.dao.migration.mysql.V1__BaseVersion',NULL,'scadalts','2021-02-26 11:23:32',34245,1),(2,'1.1','ViewsHierarchy','JDBC','org.scada_lts.dao.migration.mysql.V1_1__ViewsHierarchy',NULL,'scadalts','2021-02-26 11:23:34',1327,1),(3,'1.2','SetViewSizeProperties','JDBC','org.scada_lts.dao.migration.mysql.V1_2__SetViewSizeProperties',NULL,'scadalts','2021-02-26 11:23:34',91,1),(4,'1.3','SetXidPointHierarchy','JDBC','org.scada_lts.dao.migration.mysql.V1_3__SetXidPointHierarchy',NULL,'scadalts','2021-02-26 11:23:34',354,1),(5,'2.0','CMP history','JDBC','org.scada_lts.dao.migration.mysql.V2_0__CMP_history',NULL,'scadalts','2021-02-26 11:23:34',123,1),(6,'2.3','FaultsAndAlarms','JDBC','org.scada_lts.dao.migration.mysql.V2_3__FaultsAndAlarms',NULL,'scadalts','2021-02-26 11:23:35',621,1),(7,'2.4','','JDBC','org.scada_lts.dao.migration.mysql.V2_4__',NULL,'scadalts','2021-02-26 11:23:35',76,1),(8,'2.5','ScheduledExecuteInactiveEvent','JDBC','org.scada_lts.dao.migration.mysql.V2_5__ScheduledExecuteInactiveEvent',NULL,'scadalts','2021-02-26 11:23:36',483,1),(9,'2.6','','JDBC','org.scada_lts.dao.migration.mysql.V2_6__',NULL,'scadalts','2021-03-29 10:01:31',1795,1);
/*!40000 ALTER TABLE `schema_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
INSERT INTO `scripts` VALUES (1,1,'SC_GT1_START','Gas turbine 1 startup','if (state.value == \'OFF\') {\n  cmd.writeDataPoint(\'DP_GT1_CMD\', \"START\");\n}',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E000378700000000674000573746174657371007E0007000000187400056774636D64787371007E0005000000017704000000017371007E000700000002740003636D647878),(2,1,'SC_GT1_STOP','Gas turbine 1 shutdown','if (state.value == \'GENERATING\') {\n  cmd.writeDataPoint(\'DP_GT1_CMD\', \"STOP\");\n}',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E00037870000000187400056470636D647371007E0007000000067400057374617465787371007E0005000000017704000000017371007E000700000002740003636D647878),(4,1,'SC_092824','Energy store 1 stop output','dscmd.writeDataPoint(\'DP_ES1_OUT\', 0);',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E000378700000001B7400066F75747075747371007E000700000019740003636D64787371007E0005000000017704000000017371007E0007000000027400056473636D647878),(5,1,'SC_590164','Energy store 1 increase input','var dp_name = \'DP_ES1_IN\';\nvar dp_value = input.value;\nif (!dp_value) {\n  dscmd.writeDataPoint(dp_name, 1);\n} else if (dp_value < 200) {\n  dscmd.writeDataPoint(dp_name, dp_value + 1);\n}',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E0003787000000019740003636D647371007E00070000001A740005696E707574787371007E0005000000017704000000017371007E0007000000027400056473636D647878),(6,1,'SC_588988','Energy store 1 decrease input','var dp_name = \'DP_ES1_IN\';\nvar dp_value = input.value;\nif (!dp_value) {\n  dscmd.writeDataPoint(dp_name, 0);\n} else if (dp_value > 0) {\n  dscmd.writeDataPoint(dp_name, dp_value - 1);\n}',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E0003787000000019740003636D647371007E00070000001A740005696E707574787371007E0005000000017704000000017371007E0007000000027400056473636D647878),(7,1,'SC_736020','Energy store 1 increase output','var dp_name = \'DP_ES1_OUT\';\nvar dp_value = output.value;\nif (!dp_value) {\n  dscmd.writeDataPoint(dp_name, 1);\n} else if (dp_value < 200) {\n  dscmd.writeDataPoint(dp_name, dp_value + 1);\n}',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E0003787000000019740003636D647371007E00070000001B7400066F7574707574787371007E0005000000017704000000017371007E0007000000027400056473636D647878),(8,1,'SC_966730','Energy store 1 decrease output','var dp_name = \'DP_ES1_OUT\';\nvar dp_value = output.value;\nif (!dp_value) {\n  dscmd.writeDataPoint(dp_name, 0);\n} else if (dp_value > 0) {\n  dscmd.writeDataPoint(dp_name, dp_value - 1);\n}',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E0003787000000019740003636D647371007E00070000001B7400066F7574707574787371007E0005000000017704000000017371007E0007000000027400056473636D647878),(9,1,'SC_960590','Energy store 1 stop input','dscmd.writeDataPoint(\'DP_ES1_IN\', 0);',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E0003787000000019740003636D647371007E00070000001A740005696E707574787371007E0005000000017704000000017371007E0007000000027400056473636D647878),(10,1,'SC_483658','Energy store 1 check charge status','if (chg.value > 90 && input.value > 0) {\n  dscmd.writeDataPoint(\'DP_ES1_IN\', 0);\n}\nif (chg.value < 10 && output.value > 0) {\n  dscmd.writeDataPoint(\'DP_ES1_OUT\', 0);\n}',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000047704000000047372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E0003787000000019740003636D647371007E00070000001A740005696E7075747371007E00070000001B7400066F75747075747371007E000700000005740003636867787371007E0005000000017704000000017371007E0007000000027400056473636D647878),(11,1,'SC_330406','Load generator reduce','dpcmd.writeDataPoint(\'DP_LG_PWR\', loadgen.value - 1000.0);',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000017704000000017372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E000378700000003B7400076C6F616467656E787371007E0005000000017704000000017371007E0007000000027400056470636D647878),(12,1,'SC_960401','Load generator increase','dpcmd.writeDataPoint(\'DP_LG_PWR\', loadgen.value + 1000.0);',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000017704000000017372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E000378700000003B7400076C6F616467656E787371007E0005000000017704000000017371007E0007000000027400056470636D647878),(13,1,'SC_090702','Load generator stop','dpcmd.writeDataPoint(\'DP_LG_PWR\', 0.0);',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000017704000000017372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E000378700000003B7400076C6F616467656E787371007E0005000000017704000000017371007E0007000000027400056470636D647878),(14,1,'SC_642059','Load generator match solar','dpcmd.writeDataPoint(\'DP_LG_PWR\', solar.value * 1000.0);',0xACED00057372003262722E6F72672E736361646162722E766F2E736372697074696E672E436F6E7465787475616C697A6564536372697074564FFFFFFFFFFFFFFFFF0300024C00106F626A656374734F6E436F6E746578747400104C6A6176612F7574696C2F4C6973743B4C000F706F696E74734F6E436F6E7465787471007E00017872002462722E6F72672E736361646162722E766F2E736372697074696E672E536372697074564FFFFFFFFFFFFFFFFF03000549000269644900067573657249644C00046E616D657400124C6A6176612F6C616E672F537472696E673B4C000673637269707471007E00034C000378696471007E0003787078770400000001737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000027704000000027372001D636F6D2E7365726F746F6E696E2E64622E496E7456616C756550616972FFFFFFFFFFFFFFFF0200024900036B65794C000576616C756571007E0003787000000001740005736F6C61727371007E00070000003B7400076C6F616467656E787371007E0005000000017704000000017371007E0007000000027400056470636D647878);
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `systemSettings`
--

LOCK TABLES `systemSettings` WRITE;
/*!40000 ALTER TABLE `systemSettings` DISABLE KEYS */;
INSERT INTO `systemSettings` VALUES ('databaseSchemaVersion','2.5.0'),('servletContextPath','/ScadaLTS');
/*!40000 ALTER TABLE `systemSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `templatesDetectors`
--

LOCK TABLES `templatesDetectors` WRITE;
/*!40000 ALTER TABLE `templatesDetectors` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatesDetectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `userComments`
--

LOCK TABLES `userComments` WRITE;
/*!40000 ALTER TABLE `userComments` DISABLE KEYS */;
/*!40000 ALTER TABLE `userComments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `userEvents`
--

LOCK TABLES `userEvents` WRITE;
/*!40000 ALTER TABLE `userEvents` DISABLE KEYS */;
INSERT INTO `userEvents` VALUES (1,1,'Y'),(2,1,'Y'),(3,1,'Y'),(4,1,'N'),(5,1,'N'),(6,1,'N'),(7,1,'Y'),(8,1,'Y'),(9,1,'Y'),(10,1,'Y'),(11,1,'Y'),(12,1,'Y'),(13,1,'Y'),(14,1,'Y'),(15,1,'N'),(16,1,'N'),(17,1,'N'),(18,1,'N'),(19,1,'N'),(20,1,'N'),(21,1,'N'),(22,1,'N'),(23,1,'Y'),(24,1,'Y'),(25,1,'Y'),(26,1,'Y'),(27,1,'Y'),(28,1,'Y'),(29,1,'Y'),(30,1,'Y'),(31,1,'Y'),(39,1,'Y'),(42,1,'N'),(43,1,'N'),(44,1,'N'),(45,1,'N'),(46,1,'N'),(47,1,'N'),(48,1,'N'),(49,1,'N'),(50,1,'N'),(51,1,'N'),(52,1,'N'),(53,1,'N'),(54,1,'N'),(55,1,'N'),(56,1,'N'),(57,1,'N'),(58,1,'N'),(59,1,'N'),(60,1,'N'),(61,1,'N'),(62,1,'N'),(63,1,'N'),(64,1,'N'),(65,1,'N'),(66,1,'N'),(67,1,'N'),(68,1,'N'),(69,1,'N'),(70,1,'N'),(71,1,'N'),(72,1,'N'),(73,1,'N'),(74,1,'N'),(75,1,'N'),(76,1,'N'),(77,1,'N'),(78,1,'N'),(79,1,'N'),(80,1,'N'),(81,1,'N'),(82,1,'N'),(83,1,'N'),(84,1,'N'),(85,1,'N'),(86,1,'N'),(87,1,'N'),(88,1,'N'),(89,1,'N'),(90,1,'N'),(91,1,'N'),(92,1,'N'),(93,1,'N'),(94,1,'N'),(95,1,'N'),(96,1,'N'),(97,1,'N'),(98,1,'N'),(99,1,'N'),(100,1,'N'),(101,1,'N'),(102,1,'N'),(103,1,'N'),(104,1,'N'),(105,1,'N'),(106,1,'N'),(107,1,'N'),(108,1,'N'),(109,1,'N'),(110,1,'N'),(111,1,'N'),(112,1,'N'),(113,1,'N'),(114,1,'N'),(115,1,'N'),(116,1,'N'),(117,1,'N'),(118,1,'N'),(119,1,'N'),(120,1,'N'),(121,1,'N'),(122,1,'N'),(123,1,'N'),(124,1,'N'),(125,1,'N'),(126,1,'N'),(127,1,'N'),(128,1,'N'),(129,1,'N'),(130,1,'N'),(131,1,'N'),(132,1,'N'),(133,1,'N'),(134,1,'N'),(135,1,'N'),(136,1,'N'),(137,1,'N'),(138,1,'N'),(139,1,'N'),(140,1,'N'),(141,1,'N'),(142,1,'N'),(143,1,'N'),(144,1,'N'),(145,1,'N'),(146,1,'N'),(147,1,'N'),(148,1,'N'),(149,1,'N'),(150,1,'N'),(151,1,'N'),(152,1,'N'),(153,1,'N'),(154,1,'N'),(155,1,'N'),(156,1,'N'),(157,1,'N'),(158,1,'N'),(159,1,'N'),(160,1,'N'),(161,1,'N'),(162,1,'N'),(163,1,'N'),(164,1,'N'),(165,1,'N'),(166,1,'N'),(167,1,'N'),(168,1,'N'),(169,1,'N'),(170,1,'N'),(171,1,'N'),(172,1,'N'),(173,1,'N'),(174,1,'N'),(175,1,'N'),(176,1,'N'),(177,1,'N'),(178,1,'N'),(179,1,'N'),(180,1,'N'),(181,1,'N'),(182,1,'N'),(183,1,'N'),(184,1,'N'),(185,1,'N'),(186,1,'N'),(187,1,'N'),(188,1,'N'),(189,1,'N'),(190,1,'N'),(191,1,'N'),(192,1,'N'),(193,1,'N'),(194,1,'N'),(195,1,'N'),(196,1,'N'),(197,1,'N'),(198,1,'N'),(199,1,'N'),(200,1,'N'),(201,1,'N'),(202,1,'N'),(203,1,'N'),(204,1,'N'),(205,1,'N'),(206,1,'N'),(207,1,'N'),(208,1,'N'),(209,1,'N'),(210,1,'N'),(211,1,'N'),(212,1,'N'),(213,1,'N'),(214,1,'N'),(215,1,'N'),(216,1,'N'),(217,1,'N'),(218,1,'N'),(219,1,'N'),(220,1,'N'),(221,1,'N'),(222,1,'N'),(223,1,'N'),(224,1,'N'),(225,1,'N'),(226,1,'N'),(227,1,'N'),(228,1,'N'),(229,1,'N'),(230,1,'N'),(231,1,'N'),(232,1,'N'),(233,1,'N'),(234,1,'N'),(235,1,'N'),(236,1,'N'),(237,1,'N'),(238,1,'N'),(239,1,'N'),(240,1,'N'),(241,1,'N'),(242,1,'N'),(243,1,'N'),(244,1,'N'),(245,1,'N'),(246,1,'N'),(247,1,'N'),(248,1,'N'),(249,1,'N'),(250,1,'N'),(251,1,'N'),(252,1,'N'),(253,1,'N'),(254,1,'N'),(255,1,'N'),(256,1,'N'),(257,1,'N'),(258,1,'N'),(259,1,'N'),(260,1,'N'),(261,1,'N'),(262,1,'N'),(263,1,'N'),(264,1,'N'),(265,1,'N'),(266,1,'N'),(267,1,'N'),(268,1,'N'),(269,1,'N'),(270,1,'N'),(271,1,'N'),(272,1,'N'),(273,1,'N'),(274,1,'N'),(275,1,'N'),(276,1,'N'),(277,1,'N'),(278,1,'N'),(279,1,'N'),(280,1,'N'),(281,1,'N'),(282,1,'N'),(283,1,'N'),(284,1,'N'),(285,1,'N'),(286,1,'N'),(287,1,'N'),(288,1,'N'),(289,1,'N'),(290,1,'N'),(291,1,'N'),(292,1,'N'),(293,1,'N'),(294,1,'N'),(295,1,'N'),(296,1,'N'),(297,1,'N'),(298,1,'N'),(299,1,'N'),(300,1,'N'),(301,1,'N'),(302,1,'N'),(303,1,'N'),(304,1,'N'),(305,1,'N'),(306,1,'N'),(307,1,'N'),(308,1,'N'),(309,1,'N'),(310,1,'N'),(311,1,'N'),(312,1,'N'),(313,1,'N'),(314,1,'N'),(315,1,'N'),(316,1,'N'),(317,1,'N'),(318,1,'N'),(319,1,'N'),(320,1,'N'),(321,1,'N'),(322,1,'N'),(323,1,'N'),(324,1,'N'),(325,1,'N'),(326,1,'N'),(327,1,'N'),(328,1,'N'),(329,1,'N'),(330,1,'N'),(331,1,'N'),(332,1,'N'),(333,1,'N'),(334,1,'N'),(335,1,'N'),(336,1,'N'),(337,1,'N'),(338,1,'N'),(339,1,'N'),(340,1,'N'),(341,1,'N'),(342,1,'N'),(343,1,'N'),(344,1,'N'),(345,1,'N'),(346,1,'N'),(347,1,'N'),(348,1,'N'),(349,1,'N'),(350,1,'N'),(351,1,'N'),(352,1,'N'),(353,1,'N'),(354,1,'N'),(355,1,'N'),(356,1,'N'),(357,1,'N'),(358,1,'N'),(359,1,'N'),(360,1,'N'),(361,1,'N'),(362,1,'N'),(363,1,'N'),(364,1,'N'),(365,1,'N'),(366,1,'N'),(367,1,'N'),(368,1,'N'),(369,1,'N'),(370,1,'N'),(371,1,'N'),(372,1,'N'),(373,1,'N'),(374,1,'N'),(375,1,'N'),(376,1,'N'),(377,1,'N'),(378,1,'N'),(379,1,'N'),(380,1,'N'),(381,1,'N'),(382,1,'N'),(383,1,'N'),(384,1,'N'),(385,1,'N'),(386,1,'N'),(387,1,'N'),(388,1,'N'),(389,1,'N'),(390,1,'N'),(391,1,'N'),(392,1,'N'),(393,1,'N'),(394,1,'N'),(395,1,'N'),(396,1,'N'),(397,1,'N'),(398,1,'N'),(399,1,'N'),(400,1,'N'),(401,1,'N'),(402,1,'N'),(403,1,'N'),(404,1,'N'),(405,1,'N'),(406,1,'N'),(407,1,'N'),(408,1,'N'),(409,1,'N'),(410,1,'N'),(411,1,'N'),(412,1,'N'),(413,1,'N'),(414,1,'N'),(415,1,'N'),(416,1,'N'),(417,1,'N'),(418,1,'N'),(419,1,'N'),(420,1,'N'),(421,1,'N'),(422,1,'N'),(423,1,'N'),(424,1,'N'),(425,1,'N'),(426,1,'N'),(427,1,'N'),(428,1,'N'),(429,1,'N'),(430,1,'N'),(431,1,'N'),(432,1,'N'),(433,1,'N'),(434,1,'N'),(435,1,'N'),(436,1,'N'),(437,1,'N'),(438,1,'N'),(439,1,'N'),(440,1,'N'),(441,1,'N'),(442,1,'N'),(443,1,'N'),(444,1,'N'),(445,1,'N'),(446,1,'N'),(447,1,'N'),(448,1,'N'),(449,1,'N'),(450,1,'N'),(451,1,'N'),(452,1,'N'),(453,1,'N'),(454,1,'N'),(455,1,'N'),(456,1,'N'),(457,1,'N'),(458,1,'N'),(459,1,'N'),(460,1,'N'),(461,1,'N'),(462,1,'N'),(463,1,'N'),(464,1,'N'),(465,1,'N'),(466,1,'N'),(467,1,'N'),(468,1,'N'),(469,1,'N'),(470,1,'N'),(471,1,'N'),(472,1,'N'),(473,1,'N'),(474,1,'N'),(475,1,'N'),(476,1,'N'),(477,1,'N'),(478,1,'N'),(479,1,'N'),(480,1,'N'),(481,1,'N'),(482,1,'N'),(483,1,'N'),(484,1,'N'),(485,1,'N'),(486,1,'N'),(487,1,'N'),(488,1,'N'),(489,1,'N'),(490,1,'N'),(491,1,'N'),(492,1,'N'),(493,1,'N'),(494,1,'N'),(495,1,'N'),(496,1,'N'),(497,1,'N'),(498,1,'N'),(499,1,'N'),(500,1,'N'),(501,1,'N'),(502,1,'N'),(503,1,'N'),(504,1,'N'),(505,1,'N'),(506,1,'N'),(507,1,'N'),(508,1,'N'),(509,1,'N'),(510,1,'N'),(511,1,'N'),(512,1,'N'),(513,1,'N'),(514,1,'N'),(515,1,'N'),(516,1,'N'),(517,1,'N'),(518,1,'N'),(519,1,'N'),(520,1,'N'),(521,1,'N'),(522,1,'N'),(523,1,'N'),(524,1,'N'),(525,1,'N'),(526,1,'N'),(527,1,'N'),(528,1,'N'),(529,1,'N'),(530,1,'N'),(531,1,'N'),(532,1,'N'),(533,1,'N'),(534,1,'N'),(535,1,'N'),(536,1,'N'),(537,1,'N'),(538,1,'N'),(539,1,'N'),(540,1,'N'),(541,1,'N'),(542,1,'N'),(543,1,'N'),(544,1,'N'),(545,1,'N'),(546,1,'N'),(547,1,'N'),(548,1,'N'),(549,1,'N'),(550,1,'N'),(551,1,'N'),(552,1,'N'),(553,1,'N'),(554,1,'N'),(555,1,'N'),(556,1,'N'),(557,1,'N'),(558,1,'N'),(559,1,'N'),(560,1,'N'),(561,1,'N'),(562,1,'N'),(563,1,'N'),(564,1,'N'),(565,1,'N'),(566,1,'N'),(567,1,'N'),(568,1,'N'),(569,1,'N'),(570,1,'N'),(571,1,'N'),(572,1,'N'),(573,1,'N'),(574,1,'N'),(575,1,'N'),(576,1,'N'),(577,1,'N'),(578,1,'N'),(579,1,'N'),(580,1,'N'),(581,1,'N'),(582,1,'N'),(583,1,'N'),(584,1,'N'),(585,1,'N'),(586,1,'N'),(587,1,'N'),(588,1,'N'),(589,1,'N'),(590,1,'N'),(591,1,'N'),(592,1,'N'),(593,1,'N'),(594,1,'N'),(595,1,'N'),(596,1,'N'),(597,1,'N'),(598,1,'N'),(599,1,'N'),(600,1,'N'),(601,1,'N'),(602,1,'N'),(603,1,'N'),(604,1,'N'),(605,1,'N'),(606,1,'N'),(607,1,'N'),(608,1,'N'),(609,1,'N'),(610,1,'N'),(611,1,'N'),(612,1,'N'),(613,1,'N'),(614,1,'N'),(615,1,'N'),(616,1,'N'),(617,1,'N'),(618,1,'N'),(619,1,'N'),(620,1,'N'),(621,1,'N'),(622,1,'N'),(623,1,'N'),(624,1,'N'),(625,1,'N'),(626,1,'N'),(627,1,'N'),(628,1,'N'),(629,1,'N'),(630,1,'N'),(631,1,'N'),(632,1,'N'),(633,1,'N'),(634,1,'N'),(635,1,'N'),(636,1,'N'),(637,1,'N'),(638,1,'N'),(639,1,'N'),(640,1,'N'),(641,1,'N'),(642,1,'N'),(643,1,'N'),(644,1,'N'),(645,1,'N'),(646,1,'N'),(647,1,'N'),(648,1,'N'),(649,1,'N'),(650,1,'N'),(651,1,'N'),(652,1,'N'),(653,1,'N'),(654,1,'N'),(655,1,'N'),(656,1,'N'),(657,1,'N'),(658,1,'N'),(659,1,'N'),(660,1,'N'),(661,1,'N'),(662,1,'N'),(663,1,'N'),(664,1,'N'),(665,1,'N'),(666,1,'N'),(667,1,'N'),(668,1,'N'),(669,1,'N'),(670,1,'N'),(671,1,'N'),(672,1,'N'),(673,1,'N'),(674,1,'N'),(675,1,'N'),(676,1,'N'),(677,1,'N'),(678,1,'N'),(679,1,'N'),(680,1,'N'),(681,1,'N'),(682,1,'N'),(683,1,'N'),(684,1,'N'),(685,1,'N'),(686,1,'N'),(687,1,'N'),(688,1,'N'),(689,1,'N'),(690,1,'N'),(691,1,'N'),(692,1,'N'),(693,1,'N'),(694,1,'N'),(695,1,'N'),(696,1,'N'),(697,1,'N'),(698,1,'N'),(699,1,'N'),(700,1,'N'),(701,1,'N'),(702,1,'N'),(703,1,'N'),(704,1,'N'),(705,1,'N'),(706,1,'N'),(707,1,'N'),(708,1,'N'),(709,1,'N'),(710,1,'N'),(711,1,'N'),(712,1,'N'),(713,1,'N'),(714,1,'N'),(715,1,'N'),(716,1,'N'),(717,1,'N'),(718,1,'N'),(719,1,'N'),(720,1,'N'),(721,1,'N'),(722,1,'N'),(723,1,'N'),(724,1,'N'),(725,1,'N'),(726,1,'N'),(727,1,'N'),(728,1,'N'),(729,1,'N'),(730,1,'N'),(731,1,'N'),(732,1,'N'),(733,1,'N'),(734,1,'N'),(735,1,'N'),(736,1,'N'),(737,1,'N'),(738,1,'N'),(739,1,'N'),(740,1,'N'),(741,1,'N'),(742,1,'N'),(743,1,'N'),(744,1,'N'),(745,1,'N'),(746,1,'N'),(747,1,'N'),(748,1,'N'),(749,1,'N'),(750,1,'N'),(751,1,'N'),(752,1,'N'),(753,1,'N'),(754,1,'N'),(755,1,'N'),(756,1,'N'),(757,1,'N'),(758,1,'N'),(759,1,'N'),(760,1,'N'),(761,1,'N'),(762,1,'N'),(763,1,'N'),(764,1,'N'),(765,1,'N'),(766,1,'N'),(767,1,'N'),(768,1,'N'),(769,1,'N'),(770,1,'N'),(771,1,'N'),(772,1,'N'),(773,1,'N'),(774,1,'N'),(775,1,'N'),(776,1,'N'),(777,1,'N'),(778,1,'N'),(779,1,'N'),(780,1,'N'),(781,1,'N'),(782,1,'N'),(783,1,'N'),(784,1,'N'),(785,1,'N'),(786,1,'N'),(787,1,'N'),(788,1,'N'),(789,1,'N'),(790,1,'N'),(791,1,'N'),(792,1,'N'),(793,1,'N'),(794,1,'N'),(795,1,'N'),(796,1,'N'),(797,1,'N'),(798,1,'N'),(799,1,'N'),(800,1,'N'),(801,1,'N'),(802,1,'N'),(803,1,'N'),(804,1,'N'),(805,1,'N'),(806,1,'N'),(807,1,'N'),(808,1,'N'),(809,1,'N'),(810,1,'N'),(811,1,'N'),(812,1,'N'),(813,1,'N'),(814,1,'N'),(815,1,'N'),(816,1,'N'),(817,1,'N'),(818,1,'N'),(819,1,'N'),(820,1,'N'),(821,1,'N'),(822,1,'N'),(823,1,'N'),(824,1,'N'),(825,1,'N'),(826,1,'N'),(827,1,'N'),(828,1,'N'),(829,1,'N'),(830,1,'N'),(831,1,'N'),(832,1,'N'),(833,1,'N'),(834,1,'N'),(835,1,'N'),(836,1,'N'),(837,1,'N'),(838,1,'N'),(839,1,'N'),(840,1,'N'),(841,1,'N'),(842,1,'N'),(843,1,'N'),(844,1,'N'),(845,1,'N'),(846,1,'N'),(847,1,'N'),(848,1,'N'),(849,1,'N'),(850,1,'N'),(851,1,'N'),(852,1,'N'),(853,1,'N'),(854,1,'N'),(855,1,'N'),(856,1,'N'),(857,1,'N'),(858,1,'N'),(859,1,'N'),(860,1,'N'),(861,1,'N'),(862,1,'N'),(863,1,'N'),(864,1,'N'),(865,1,'N'),(866,1,'N'),(867,1,'N'),(868,1,'N'),(869,1,'N'),(870,1,'N'),(871,1,'N'),(872,1,'N'),(873,1,'N'),(874,1,'N'),(875,1,'N'),(876,1,'N'),(877,1,'N'),(878,1,'N'),(879,1,'N'),(880,1,'N'),(881,1,'N'),(882,1,'N'),(883,1,'N'),(884,1,'N'),(885,1,'N'),(886,1,'N'),(887,1,'N'),(888,1,'N'),(889,1,'N'),(890,1,'N'),(891,1,'N'),(892,1,'N'),(893,1,'N'),(894,1,'N'),(895,1,'N'),(896,1,'N'),(897,1,'N'),(898,1,'N'),(899,1,'N'),(900,1,'N'),(901,1,'N'),(902,1,'N'),(903,1,'N'),(904,1,'N'),(905,1,'N'),(906,1,'N'),(907,1,'N'),(908,1,'N'),(909,1,'N'),(910,1,'N'),(911,1,'N'),(912,1,'N'),(913,1,'N'),(914,1,'N'),(915,1,'N'),(916,1,'N'),(917,1,'N'),(918,1,'N'),(919,1,'N'),(920,1,'N'),(921,1,'N'),(922,1,'N'),(923,1,'N'),(924,1,'N'),(925,1,'N'),(926,1,'N'),(927,1,'N'),(928,1,'N'),(929,1,'N'),(930,1,'N'),(931,1,'N'),(932,1,'N'),(933,1,'N'),(934,1,'N'),(935,1,'N'),(936,1,'N'),(937,1,'N'),(938,1,'N'),(939,1,'N'),(940,1,'N'),(941,1,'N'),(942,1,'N'),(943,1,'N'),(944,1,'N'),(945,1,'N'),(946,1,'N'),(947,1,'N'),(948,1,'N'),(949,1,'N'),(950,1,'N'),(951,1,'N'),(952,1,'N'),(953,1,'N'),(954,1,'N'),(955,1,'N'),(956,1,'N'),(957,1,'N'),(958,1,'N'),(959,1,'N'),(960,1,'N'),(961,1,'N'),(962,1,'N'),(963,1,'N'),(964,1,'N'),(965,1,'N'),(966,1,'N'),(967,1,'N'),(968,1,'N'),(969,1,'N'),(970,1,'N'),(971,1,'N'),(972,1,'N'),(973,1,'N'),(974,1,'N'),(975,1,'N'),(976,1,'N'),(977,1,'N'),(978,1,'N'),(979,1,'N'),(980,1,'N'),(981,1,'N'),(982,1,'N'),(983,1,'N'),(984,1,'N'),(985,1,'N'),(986,1,'N'),(987,1,'N'),(988,1,'N'),(989,1,'N'),(990,1,'N'),(991,1,'N'),(992,1,'N'),(993,1,'N'),(994,1,'N'),(995,1,'N'),(996,1,'N'),(997,1,'N'),(998,1,'N'),(999,1,'N'),(1000,1,'N'),(1001,1,'N'),(1002,1,'N'),(1003,1,'N'),(1004,1,'N'),(1005,1,'N'),(1006,1,'N'),(1007,1,'N'),(1008,1,'N'),(1009,1,'N'),(1010,1,'N'),(1011,1,'N'),(1012,1,'N'),(1013,1,'N'),(1014,1,'N'),(1015,1,'N'),(1016,1,'N'),(1017,1,'N'),(1018,1,'N'),(1019,1,'N'),(1020,1,'N'),(1021,1,'N'),(1022,1,'N'),(1023,1,'N'),(1024,1,'N'),(1025,1,'N'),(1026,1,'N'),(1027,1,'N'),(1028,1,'N'),(1029,1,'N'),(1030,1,'N'),(1031,1,'N'),(1032,1,'N'),(1033,1,'N'),(1034,1,'N'),(1035,1,'N'),(1036,1,'N'),(1037,1,'N'),(1038,1,'N'),(1039,1,'N'),(1040,1,'N'),(1041,1,'N'),(1042,1,'N'),(1043,1,'N'),(1044,1,'N'),(1045,1,'N'),(1046,1,'N'),(1047,1,'N'),(1048,1,'N'),(1049,1,'N'),(1050,1,'N'),(1051,1,'N'),(1052,1,'N'),(1053,1,'N'),(1054,1,'N'),(1055,1,'N'),(1056,1,'N'),(1057,1,'N'),(1058,1,'N'),(1059,1,'N'),(1060,1,'N'),(1061,1,'N'),(1062,1,'N'),(1063,1,'N'),(1064,1,'N'),(1065,1,'N'),(1066,1,'N'),(1067,1,'N'),(1068,1,'N'),(1069,1,'N'),(1070,1,'N'),(1071,1,'N'),(1072,1,'N'),(1073,1,'N'),(1074,1,'N'),(1075,1,'N'),(1076,1,'N'),(1077,1,'N'),(1078,1,'N'),(1079,1,'N'),(1080,1,'N'),(1081,1,'N'),(1082,1,'N'),(1083,1,'N'),(1084,1,'N'),(1085,1,'N'),(1086,1,'N'),(1087,1,'N'),(1088,1,'N'),(1089,1,'N'),(1090,1,'N'),(1091,1,'N'),(1092,1,'N'),(1093,1,'N'),(1094,1,'N'),(1095,1,'N'),(1096,1,'N'),(1097,1,'N'),(1098,1,'N'),(1099,1,'N'),(1100,1,'N'),(1101,1,'N'),(1102,1,'N'),(1103,1,'N'),(1104,1,'N'),(1105,1,'N'),(1106,1,'N'),(1107,1,'N'),(1108,1,'N'),(1109,1,'N'),(1110,1,'N'),(1111,1,'N'),(1112,1,'N'),(1113,1,'N'),(1114,1,'N'),(1115,1,'N'),(1116,1,'N'),(1117,1,'N'),(1118,1,'N'),(1119,1,'N'),(1120,1,'N'),(1121,1,'N'),(1122,1,'N'),(1123,1,'N'),(1124,1,'N'),(1125,1,'N'),(1126,1,'N'),(1127,1,'N'),(1128,1,'N'),(1129,1,'N'),(1130,1,'N'),(1131,1,'N'),(1132,1,'N'),(1133,1,'N'),(1134,1,'N'),(1135,1,'N'),(1136,1,'N'),(1137,1,'N'),(1138,1,'N'),(1139,1,'N'),(1140,1,'N'),(1141,1,'N'),(1142,1,'N'),(1143,1,'N'),(1144,1,'N'),(1145,1,'N'),(1146,1,'N'),(1147,1,'N'),(1148,1,'N'),(1149,1,'N'),(1150,1,'N'),(1151,1,'N'),(1152,1,'N'),(1153,1,'N'),(1154,1,'N'),(1155,1,'N'),(1156,1,'N'),(1157,1,'N'),(1158,1,'N'),(1159,1,'N'),(1160,1,'N'),(1161,1,'N'),(1162,1,'N'),(1163,1,'N'),(1164,1,'N'),(1165,1,'N'),(1166,1,'N'),(1167,1,'N'),(1168,1,'N'),(1169,1,'N'),(1170,1,'N'),(1171,1,'N'),(1172,1,'N'),(1173,1,'N'),(1174,1,'N'),(1175,1,'N'),(1176,1,'N'),(1177,1,'N'),(1178,1,'N'),(1179,1,'N'),(1180,1,'N'),(1181,1,'N'),(1182,1,'N'),(1183,1,'N'),(1184,1,'N'),(1185,1,'N'),(1186,1,'N'),(1187,1,'N'),(1188,1,'N'),(1189,1,'N'),(1190,1,'N'),(1191,1,'N'),(1192,1,'N'),(1193,1,'N'),(1194,1,'N'),(1195,1,'N'),(1196,1,'N'),(1197,1,'N'),(1198,1,'N'),(1199,1,'N'),(1200,1,'N'),(1201,1,'N'),(1202,1,'N'),(1203,1,'N'),(1204,1,'N'),(1205,1,'N'),(1206,1,'N'),(1207,1,'N'),(1208,1,'N'),(1209,1,'N'),(1210,1,'N'),(1211,1,'N'),(1212,1,'N'),(1213,1,'N'),(1214,1,'N'),(1215,1,'N'),(1216,1,'N'),(1217,1,'N'),(1218,1,'N'),(1219,1,'N'),(1220,1,'N'),(1221,1,'N'),(1222,1,'N'),(1223,1,'N'),(1224,1,'N'),(1225,1,'N'),(1226,1,'N'),(1227,1,'N'),(1228,1,'N'),(1229,1,'N'),(1230,1,'N'),(1231,1,'N'),(1232,1,'N'),(1233,1,'N'),(1234,1,'N'),(1236,1,'N'),(1237,1,'N'),(1238,1,'N'),(1239,1,'N'),(1240,1,'N'),(1241,1,'N'),(1242,1,'N'),(1243,1,'N'),(1244,1,'N'),(1245,1,'N'),(1246,1,'N'),(1247,1,'N'),(1248,1,'N'),(1249,1,'N'),(1250,1,'N'),(1251,1,'N'),(1252,1,'N'),(1253,1,'N'),(1254,1,'N'),(1255,1,'N'),(1256,1,'N'),(1257,1,'N'),(1258,1,'N'),(1259,1,'N'),(1260,1,'N'),(1261,1,'N'),(1262,1,'N'),(1263,1,'N'),(1264,1,'N'),(1265,1,'N'),(1266,1,'N'),(1267,1,'N'),(1268,1,'N'),(1269,1,'N'),(1270,1,'N'),(1271,1,'N'),(1272,1,'N'),(1273,1,'N'),(1274,1,'N'),(1275,1,'N'),(1276,1,'N'),(1277,1,'N'),(1278,1,'N'),(1279,1,'N'),(1280,1,'N'),(1281,1,'N'),(1282,1,'N'),(1283,1,'N'),(1284,1,'N'),(1285,1,'N'),(1286,1,'N'),(1287,1,'N'),(1288,1,'N'),(1289,1,'N'),(1290,1,'N'),(1291,1,'N'),(1292,1,'N'),(1293,1,'N'),(1294,1,'N'),(1295,1,'N'),(1296,1,'N'),(1297,1,'N'),(1298,1,'N'),(1299,1,'N'),(1300,1,'N'),(1301,1,'N'),(1302,1,'N'),(1303,1,'N'),(1304,1,'N'),(1305,1,'N'),(1306,1,'N'),(1307,1,'N'),(1308,1,'N'),(1309,1,'N'),(1310,1,'N'),(1311,1,'N'),(1312,1,'N'),(1313,1,'N'),(1314,1,'N'),(1315,1,'N'),(1316,1,'N'),(1317,1,'N'),(1318,1,'N'),(1319,1,'N'),(1320,1,'N'),(1321,1,'N'),(1322,1,'N'),(1323,1,'N'),(1324,1,'N'),(1325,1,'N'),(1326,1,'N'),(1327,1,'N'),(1328,1,'N'),(1329,1,'N'),(1330,1,'N'),(1331,1,'N'),(1332,1,'N'),(1333,1,'N'),(1334,1,'N'),(1335,1,'N'),(1336,1,'N'),(1337,1,'N'),(1338,1,'N'),(1339,1,'N'),(1340,1,'N'),(1341,1,'N'),(1342,1,'N'),(1343,1,'N'),(1344,1,'N'),(1345,1,'N'),(1346,1,'N'),(1347,1,'N'),(1348,1,'N'),(1349,1,'N'),(1350,1,'N'),(1351,1,'N'),(1352,1,'N'),(1353,1,'N'),(1354,1,'N'),(1355,1,'N'),(1356,1,'N'),(1357,1,'N'),(1358,1,'N'),(1359,1,'N'),(1360,1,'N'),(1361,1,'N'),(1362,1,'N'),(1363,1,'N'),(1364,1,'N'),(1365,1,'N'),(1366,1,'N'),(1367,1,'N'),(1368,1,'N'),(1369,1,'N'),(1370,1,'N'),(1371,1,'N'),(1372,1,'N'),(1373,1,'N'),(1374,1,'N'),(1375,1,'N'),(1376,1,'N'),(1377,1,'N'),(1378,1,'N'),(1379,1,'N'),(1380,1,'N'),(1381,1,'N'),(1382,1,'N'),(1383,1,'N'),(1384,1,'N'),(1385,1,'N'),(1386,1,'N'),(1387,1,'N'),(1388,1,'N'),(1389,1,'N'),(1390,1,'N'),(1391,1,'N'),(1392,1,'N'),(1393,1,'N'),(1394,1,'N'),(1395,1,'N'),(1396,1,'N'),(1397,1,'N'),(1398,1,'N'),(1399,1,'N'),(1400,1,'N'),(1401,1,'N'),(1402,1,'N'),(1403,1,'N'),(1404,1,'N'),(1405,1,'N'),(1406,1,'N'),(1407,1,'N'),(1408,1,'N'),(1409,1,'N'),(1410,1,'N'),(1411,1,'N'),(1412,1,'N'),(1413,1,'N'),(1414,1,'N'),(1415,1,'N'),(1416,1,'N'),(1417,1,'N'),(1418,1,'N'),(1419,1,'N'),(1420,1,'N'),(1421,1,'N'),(1422,1,'N'),(1423,1,'N'),(1424,1,'N'),(1425,1,'N'),(1426,1,'N'),(1427,1,'N'),(1428,1,'N'),(1429,1,'N'),(1430,1,'N'),(1431,1,'N'),(1432,1,'N'),(1433,1,'N'),(1434,1,'N'),(1435,1,'N'),(1436,1,'N'),(1437,1,'N'),(1438,1,'N'),(1439,1,'N'),(1440,1,'N'),(1441,1,'N'),(1442,1,'N'),(1443,1,'N'),(1444,1,'N'),(1445,1,'N'),(1446,1,'N'),(1447,1,'N'),(1448,1,'N'),(1449,1,'N'),(1450,1,'N'),(1451,1,'N'),(1452,1,'N'),(1453,1,'N'),(1454,1,'N'),(1455,1,'N'),(1456,1,'N'),(1457,1,'N'),(1458,1,'N'),(1459,1,'N'),(1460,1,'N'),(1461,1,'N'),(1462,1,'N'),(1463,1,'N'),(1464,1,'N'),(1465,1,'N'),(1466,1,'N'),(1467,1,'N'),(1468,1,'N'),(1469,1,'N'),(1470,1,'N'),(1471,1,'N'),(1472,1,'N'),(1473,1,'N'),(1474,1,'N'),(1475,1,'N'),(1476,1,'N'),(1477,1,'N'),(1478,1,'N'),(1479,1,'N'),(1480,1,'N'),(1481,1,'N'),(1482,1,'N'),(1483,1,'N'),(1484,1,'N'),(1485,1,'N'),(1486,1,'N'),(1487,1,'N'),(1488,1,'N'),(1489,1,'N'),(1490,1,'N'),(1491,1,'N'),(1492,1,'N'),(1493,1,'N'),(1494,1,'N'),(1495,1,'N'),(1496,1,'N'),(1497,1,'N'),(1498,1,'N'),(1499,1,'N'),(1500,1,'N'),(1501,1,'N'),(1502,1,'N'),(1503,1,'N'),(1504,1,'N'),(1505,1,'N'),(1506,1,'N'),(1507,1,'N'),(1508,1,'N'),(1509,1,'N'),(1510,1,'N'),(1511,1,'N'),(1512,1,'N'),(1513,1,'N'),(1514,1,'N'),(1515,1,'N'),(1516,1,'N'),(1517,1,'N'),(1518,1,'N'),(1519,1,'N'),(1520,1,'N'),(1521,1,'N'),(1522,1,'N'),(1523,1,'N'),(1524,1,'N'),(1525,1,'N'),(1526,1,'N'),(1527,1,'N'),(1528,1,'N'),(1529,1,'N'),(1530,1,'N'),(1531,1,'N'),(1532,1,'N'),(1533,1,'N'),(1534,1,'N'),(1535,1,'N'),(1536,1,'N'),(1537,1,'N'),(1538,1,'N'),(1539,1,'N'),(1540,1,'N'),(1541,1,'N'),(1542,1,'N'),(1543,1,'N'),(1544,1,'N'),(1545,1,'N'),(1546,1,'N'),(1547,1,'N'),(1548,1,'N'),(1549,1,'N'),(1550,1,'N'),(1551,1,'N'),(1552,1,'N'),(1553,1,'N'),(1554,1,'N'),(1555,1,'N'),(1556,1,'N'),(1557,1,'N'),(1558,1,'N'),(1559,1,'N'),(1560,1,'N'),(1561,1,'N'),(1562,1,'N'),(1563,1,'N'),(1564,1,'N'),(1565,1,'N'),(1566,1,'N'),(1567,1,'N'),(1568,1,'N'),(1569,1,'N'),(1570,1,'N'),(1571,1,'N'),(1572,1,'N'),(1573,1,'N'),(1574,1,'N'),(1575,1,'N'),(1576,1,'N'),(1577,1,'N'),(1578,1,'N'),(1579,1,'N'),(1580,1,'N'),(1581,1,'N'),(1582,1,'N'),(1583,1,'N'),(1584,1,'N'),(1585,1,'N'),(1586,1,'N'),(1587,1,'N'),(1588,1,'N'),(1589,1,'N'),(1590,1,'N'),(1591,1,'N'),(1592,1,'N'),(1593,1,'N'),(1594,1,'N'),(1595,1,'N'),(1596,1,'N'),(1597,1,'N'),(1598,1,'N'),(1599,1,'N'),(1600,1,'N'),(1601,1,'N'),(1602,1,'N'),(1603,1,'N'),(1604,1,'N'),(1605,1,'N'),(1606,1,'N'),(1607,1,'N'),(1608,1,'N'),(1609,1,'N'),(1610,1,'N'),(1611,1,'N'),(1612,1,'N'),(1613,1,'N'),(1614,1,'N'),(1615,1,'N'),(1616,1,'N'),(1617,1,'N'),(1618,1,'N'),(1619,1,'N'),(1620,1,'N'),(1621,1,'N'),(1622,1,'N'),(1623,1,'N'),(1624,1,'N'),(1625,1,'N'),(1626,1,'N'),(1627,1,'N'),(1628,1,'N'),(1629,1,'N'),(1630,1,'N'),(1631,1,'N'),(1632,1,'N'),(1633,1,'N'),(1634,1,'N'),(1635,1,'N'),(1636,1,'N'),(1637,1,'N'),(1638,1,'N'),(1639,1,'N'),(1640,1,'N'),(1641,1,'N'),(1642,1,'N'),(1643,1,'N'),(1644,1,'N'),(1645,1,'N'),(1646,1,'N'),(1647,1,'N'),(1648,1,'N'),(1649,1,'N'),(1650,1,'N'),(1651,1,'N'),(1652,1,'N'),(1653,1,'N'),(1654,1,'N'),(1655,1,'N'),(1656,1,'N'),(1657,1,'N'),(1658,1,'N'),(1659,1,'N'),(1660,1,'N'),(1661,1,'N'),(1662,1,'N'),(1663,1,'N'),(1664,1,'N'),(1665,1,'N'),(1666,1,'N'),(1667,1,'N'),(1668,1,'N'),(1669,1,'N'),(1670,1,'N'),(1671,1,'N'),(1672,1,'N'),(1673,1,'N'),(1674,1,'N'),(1675,1,'N'),(1676,1,'N'),(1677,1,'N'),(1678,1,'N'),(1679,1,'N'),(1680,1,'N'),(1681,1,'N'),(1682,1,'N'),(1683,1,'N'),(1684,1,'N'),(1685,1,'N'),(1686,1,'N'),(1687,1,'N'),(1688,1,'N'),(1689,1,'N'),(1690,1,'N'),(1691,1,'N'),(1692,1,'N'),(1693,1,'N'),(1694,1,'N'),(1695,1,'N'),(1696,1,'N'),(1697,1,'N'),(1698,1,'N'),(1699,1,'N'),(1700,1,'N'),(1701,1,'N'),(1702,1,'N'),(1703,1,'N'),(1704,1,'N'),(1705,1,'N'),(1706,1,'N'),(1707,1,'N'),(1708,1,'N'),(1709,1,'N'),(1710,1,'N'),(1711,1,'N'),(1712,1,'N'),(1713,1,'N'),(1714,1,'N'),(1715,1,'N'),(1716,1,'N'),(1717,1,'N'),(1718,1,'N'),(1719,1,'N'),(1720,1,'N'),(1721,1,'N'),(1722,1,'N'),(1723,1,'N'),(1724,1,'N'),(1725,1,'N'),(1726,1,'N'),(1727,1,'N'),(1728,1,'N'),(1729,1,'N'),(1730,1,'N'),(1731,1,'N'),(1732,1,'N'),(1733,1,'N'),(1734,1,'N'),(1735,1,'N'),(1736,1,'N'),(1737,1,'N'),(1738,1,'N'),(1739,1,'N'),(1740,1,'N'),(1741,1,'N'),(1742,1,'N'),(1743,1,'N'),(1744,1,'N'),(1745,1,'N'),(1746,1,'N'),(1747,1,'N'),(1748,1,'N'),(1749,1,'N'),(1750,1,'N'),(1751,1,'N'),(1752,1,'N'),(1753,1,'N'),(1754,1,'N'),(1755,1,'N'),(1756,1,'N'),(1757,1,'N'),(1758,1,'N'),(1759,1,'N'),(1760,1,'N'),(1761,1,'N'),(1762,1,'N'),(1763,1,'N'),(1764,1,'N'),(1765,1,'N'),(1766,1,'N'),(1767,1,'N'),(1768,1,'N'),(1769,1,'N'),(1770,1,'N'),(1771,1,'N'),(1772,1,'N'),(1773,1,'N'),(1774,1,'N'),(1775,1,'N'),(1776,1,'N'),(1777,1,'N'),(1778,1,'N'),(1779,1,'N'),(1780,1,'N'),(1781,1,'N'),(1782,1,'N'),(1783,1,'N'),(1784,1,'N'),(1785,1,'N'),(1786,1,'N'),(1787,1,'N'),(1788,1,'N'),(1789,1,'N'),(1790,1,'N'),(1791,1,'N'),(1792,1,'N'),(1793,1,'N'),(1794,1,'N'),(1795,1,'N'),(1796,1,'N'),(1797,1,'N'),(1798,1,'N'),(1799,1,'N'),(1800,1,'N'),(1801,1,'N'),(1802,1,'N'),(1803,1,'N'),(1804,1,'N'),(1805,1,'N'),(1806,1,'N'),(1807,1,'N'),(1808,1,'N'),(1809,1,'N'),(1810,1,'N'),(1811,1,'N'),(1812,1,'N'),(1813,1,'N'),(1814,1,'N'),(1815,1,'N'),(1816,1,'N'),(1817,1,'N'),(1818,1,'N'),(1819,1,'N'),(1820,1,'N'),(1821,1,'N'),(1822,1,'N'),(1823,1,'N'),(1824,1,'N'),(1825,1,'N'),(1826,1,'N'),(1827,1,'N'),(1828,1,'N'),(1829,1,'N'),(1830,1,'N'),(1831,1,'N'),(1832,1,'N'),(1833,1,'N'),(1834,1,'N'),(1835,1,'N'),(1836,1,'N'),(1837,1,'N'),(1838,1,'N'),(1839,1,'N'),(1840,1,'N'),(1841,1,'N'),(1842,1,'N'),(1843,1,'N'),(1844,1,'N'),(1845,1,'N'),(1846,1,'N'),(1847,1,'N'),(1848,1,'N'),(1849,1,'N'),(1850,1,'N'),(1851,1,'N'),(1852,1,'N'),(1853,1,'N'),(1854,1,'N'),(1855,1,'N'),(1856,1,'N'),(1857,1,'N'),(1858,1,'N'),(1859,1,'N'),(1860,1,'N'),(1861,1,'N'),(1862,1,'N'),(1863,1,'N'),(1864,1,'N'),(1865,1,'N'),(1866,1,'N'),(1867,1,'N'),(1868,1,'N'),(1869,1,'N'),(1870,1,'N'),(1871,1,'N'),(1872,1,'N'),(1873,1,'N'),(1874,1,'N'),(1875,1,'N'),(1876,1,'N'),(1877,1,'N'),(1878,1,'N'),(1879,1,'N'),(1880,1,'N'),(1881,1,'N'),(1882,1,'N'),(1883,1,'N'),(1884,1,'N'),(1885,1,'N'),(1886,1,'N'),(1887,1,'N'),(1888,1,'N'),(1889,1,'N'),(1890,1,'N'),(1891,1,'N'),(1892,1,'N'),(1893,1,'N'),(1894,1,'N'),(1895,1,'N'),(1896,1,'N'),(1897,1,'N'),(1898,1,'N'),(1899,1,'N'),(1900,1,'N'),(1901,1,'N'),(1902,1,'N'),(1903,1,'N'),(1904,1,'N'),(1905,1,'N'),(1906,1,'N'),(1907,1,'N'),(1908,1,'N'),(1909,1,'N'),(1910,1,'N'),(1911,1,'N'),(1912,1,'N'),(1913,1,'N'),(1914,1,'N'),(1915,1,'N'),(1916,1,'N'),(1917,1,'N'),(1918,1,'N'),(1919,1,'N'),(1920,1,'N'),(1921,1,'N'),(1922,1,'N'),(1923,1,'N'),(1924,1,'N'),(1925,1,'N'),(1926,1,'N'),(1927,1,'N'),(1928,1,'N'),(1929,1,'N'),(1930,1,'N'),(1931,1,'N'),(1932,1,'N'),(1933,1,'N'),(1934,1,'N'),(1935,1,'N'),(1936,1,'N'),(1937,1,'N'),(1938,1,'N'),(1939,1,'N'),(1940,1,'N'),(1941,1,'N'),(1942,1,'N'),(1943,1,'N'),(1944,1,'N'),(1945,1,'N'),(1946,1,'N'),(1947,1,'N'),(1948,1,'N'),(1949,1,'N'),(1950,1,'N'),(1951,1,'N'),(1952,1,'N'),(1953,1,'N'),(1954,1,'N'),(1955,1,'N'),(1956,1,'N'),(1957,1,'N'),(1958,1,'N'),(1959,1,'N'),(1960,1,'N'),(1961,1,'N'),(1962,1,'N'),(1963,1,'N'),(1964,1,'N'),(1965,1,'N'),(1966,1,'N'),(1967,1,'N'),(1968,1,'N'),(1969,1,'N'),(1970,1,'N'),(1971,1,'N'),(1972,1,'N'),(1973,1,'N'),(1974,1,'N'),(1975,1,'N'),(1976,1,'N'),(1977,1,'N'),(1978,1,'N'),(1979,1,'N'),(1980,1,'N'),(1981,1,'N'),(1982,1,'N'),(1983,1,'N'),(1984,1,'N'),(1985,1,'N'),(1986,1,'N'),(1987,1,'N'),(1988,1,'N'),(1989,1,'N'),(1990,1,'N'),(1991,1,'N'),(1992,1,'N'),(1993,1,'N'),(1994,1,'N'),(1995,1,'N'),(1996,1,'N'),(1997,1,'N'),(1998,1,'N'),(1999,1,'N'),(2000,1,'N'),(2001,1,'N'),(2002,1,'N'),(2003,1,'N'),(2004,1,'N'),(2005,1,'N'),(2006,1,'N'),(2007,1,'N'),(2008,1,'N'),(2009,1,'N'),(2010,1,'N'),(2011,1,'N'),(2012,1,'N'),(2013,1,'N'),(2014,1,'N'),(2015,1,'N'),(2016,1,'N'),(2017,1,'N'),(2018,1,'N'),(2019,1,'N'),(2020,1,'N'),(2021,1,'N'),(2022,1,'N'),(2023,1,'N'),(2024,1,'N'),(2025,1,'N'),(2026,1,'N'),(2027,1,'N'),(2028,1,'N'),(2029,1,'N'),(2030,1,'N'),(2031,1,'N'),(2032,1,'N'),(2033,1,'N'),(2034,1,'N'),(2035,1,'N'),(2036,1,'N'),(2037,1,'N'),(2038,1,'N'),(2039,1,'N'),(2040,1,'N'),(2041,1,'N'),(2042,1,'N'),(2043,1,'N'),(2044,1,'N'),(2045,1,'N'),(2046,1,'N'),(2047,1,'N'),(2048,1,'N'),(2049,1,'N'),(2050,1,'N'),(2051,1,'N'),(2052,1,'N'),(2053,1,'N'),(2054,1,'N'),(2055,1,'N'),(2056,1,'N'),(2057,1,'N'),(2058,1,'N'),(2059,1,'N'),(2060,1,'N'),(2061,1,'N'),(2062,1,'N'),(2063,1,'N'),(2064,1,'N'),(2065,1,'N'),(2066,1,'N'),(2067,1,'N'),(2068,1,'N'),(2069,1,'N'),(2070,1,'N'),(2071,1,'N'),(2072,1,'N'),(2073,1,'N'),(2074,1,'N'),(2075,1,'N'),(2076,1,'N'),(2077,1,'N'),(2078,1,'N'),(2079,1,'N'),(2080,1,'N'),(2081,1,'N'),(2082,1,'N'),(2083,1,'N'),(2084,1,'N'),(2085,1,'N'),(2086,1,'N'),(2087,1,'N'),(2088,1,'N'),(2089,1,'N'),(2090,1,'N'),(2091,1,'N'),(2092,1,'N'),(2093,1,'N'),(2094,1,'N'),(2095,1,'N'),(2096,1,'N'),(2097,1,'N'),(2098,1,'N'),(2099,1,'N'),(2100,1,'N'),(2101,1,'N'),(2102,1,'N'),(2103,1,'N'),(2104,1,'N'),(2105,1,'N'),(2106,1,'N'),(2107,1,'N'),(2108,1,'N'),(2109,1,'N'),(2110,1,'N'),(2111,1,'N'),(2112,1,'N'),(2113,1,'N'),(2114,1,'N'),(2115,1,'N'),(2116,1,'N'),(2117,1,'N'),(2118,1,'N'),(2119,1,'N'),(2120,1,'N'),(2121,1,'N'),(2122,1,'N'),(2123,1,'N'),(2124,1,'N'),(2125,1,'N'),(2126,1,'N'),(2127,1,'N'),(2128,1,'N'),(2129,1,'N'),(2130,1,'N'),(2131,1,'N'),(2132,1,'N'),(2133,1,'N'),(2134,1,'N'),(2135,1,'N'),(2136,1,'N'),(2137,1,'N'),(2138,1,'N'),(2139,1,'N'),(2140,1,'N'),(2141,1,'N'),(2142,1,'N'),(2143,1,'N'),(2144,1,'N'),(2145,1,'N'),(2146,1,'N'),(2147,1,'N'),(2148,1,'N'),(2149,1,'N'),(2150,1,'N'),(2151,1,'N'),(2152,1,'N'),(2153,1,'N'),(2154,1,'N'),(2155,1,'N'),(2156,1,'N'),(2157,1,'N'),(2158,1,'N'),(2159,1,'N'),(2160,1,'N'),(2161,1,'N'),(2162,1,'N'),(2163,1,'N'),(2164,1,'N'),(2165,1,'N'),(2166,1,'N'),(2167,1,'N'),(2168,1,'N'),(2169,1,'N'),(2170,1,'N'),(2171,1,'N'),(2172,1,'N'),(2173,1,'N'),(2174,1,'N'),(2175,1,'N'),(2176,1,'N'),(2177,1,'N'),(2178,1,'N'),(2179,1,'N'),(2180,1,'N'),(2181,1,'N'),(2182,1,'N'),(2183,1,'N'),(2184,1,'N'),(2185,1,'N'),(2186,1,'N'),(2187,1,'N'),(2188,1,'N'),(2189,1,'N'),(2190,1,'N'),(2191,1,'N'),(2192,1,'N'),(2193,1,'N'),(2194,1,'N'),(2195,1,'N'),(2196,1,'N'),(2197,1,'N'),(2198,1,'N'),(2199,1,'N'),(2200,1,'N'),(2201,1,'N'),(2202,1,'N'),(2203,1,'N'),(2204,1,'N'),(2205,1,'N'),(2206,1,'N'),(2207,1,'N'),(2208,1,'N'),(2209,1,'N'),(2210,1,'N'),(2211,1,'N'),(2212,1,'N'),(2213,1,'N'),(2214,1,'N'),(2215,1,'N'),(2216,1,'N'),(2217,1,'N'),(2218,1,'N'),(2219,1,'N'),(2220,1,'N'),(2221,1,'N'),(2222,1,'N'),(2223,1,'N'),(2224,1,'N'),(2225,1,'N'),(2226,1,'N'),(2227,1,'N'),(2228,1,'N'),(2229,1,'N'),(2230,1,'N'),(2231,1,'N'),(2232,1,'N'),(2233,1,'N'),(2234,1,'N'),(2235,1,'N'),(2236,1,'N'),(2237,1,'N'),(2238,1,'N'),(2239,1,'N'),(2240,1,'N'),(2241,1,'N'),(2242,1,'N'),(2243,1,'N'),(2244,1,'N'),(2245,1,'N'),(2246,1,'N'),(2247,1,'N'),(2248,1,'N'),(2249,1,'N'),(2250,1,'N'),(2251,1,'N'),(2252,1,'N'),(2253,1,'N'),(2254,1,'N'),(2255,1,'N'),(2256,1,'N'),(2257,1,'N'),(2258,1,'N'),(2259,1,'N'),(2260,1,'N'),(2261,1,'N'),(2262,1,'N'),(2263,1,'N'),(2264,1,'N'),(2265,1,'N'),(2266,1,'N'),(2267,1,'N'),(2268,1,'N'),(2269,1,'N'),(2270,1,'N'),(2271,1,'N'),(2272,1,'N'),(2273,1,'N'),(2274,1,'N'),(2275,1,'N'),(2276,1,'N'),(2277,1,'N'),(2278,1,'N'),(2279,1,'N'),(2280,1,'N'),(2281,1,'N'),(2282,1,'N'),(2283,1,'N'),(2284,1,'N'),(2285,1,'N'),(2286,1,'N'),(2287,1,'N'),(2288,1,'N'),(2289,1,'N'),(2290,1,'N'),(2291,1,'N'),(2292,1,'N'),(2293,1,'N'),(2294,1,'N'),(2295,1,'N'),(2296,1,'N'),(2297,1,'N'),(2298,1,'N'),(2299,1,'N'),(2300,1,'N'),(2301,1,'N'),(2302,1,'N'),(2303,1,'N'),(2304,1,'N'),(2305,1,'N'),(2306,1,'N'),(2307,1,'N'),(2308,1,'N'),(2309,1,'N'),(2310,1,'N'),(2311,1,'N'),(2312,1,'N'),(2313,1,'N'),(2314,1,'N'),(2315,1,'N'),(2316,1,'N'),(2317,1,'N'),(2318,1,'N'),(2319,1,'N'),(2320,1,'N'),(2321,1,'N'),(2322,1,'N'),(2323,1,'N'),(2324,1,'N'),(2325,1,'N'),(2326,1,'N'),(2327,1,'N'),(2328,1,'N'),(2329,1,'N'),(2330,1,'N'),(2331,1,'N'),(2332,1,'N'),(2333,1,'N'),(2334,1,'N'),(2335,1,'N'),(2336,1,'N'),(2337,1,'N'),(2338,1,'N'),(2339,1,'N'),(2340,1,'N'),(2341,1,'N'),(2342,1,'N'),(2343,1,'N'),(2344,1,'N'),(2345,1,'N'),(2346,1,'N'),(2347,1,'N'),(2348,1,'N'),(2349,1,'N'),(2350,1,'N'),(2351,1,'N'),(2352,1,'N'),(2353,1,'N'),(2354,1,'N'),(2355,1,'N'),(2356,1,'N'),(2357,1,'N'),(2358,1,'N'),(2359,1,'N'),(2360,1,'N'),(2361,1,'N'),(2362,1,'N'),(2363,1,'N'),(2364,1,'N'),(2365,1,'N'),(2366,1,'N'),(2367,1,'N'),(2368,1,'N'),(2369,1,'N'),(2370,1,'N'),(2371,1,'N'),(2372,1,'N'),(2373,1,'N'),(2374,1,'N'),(2375,1,'N'),(2376,1,'N'),(2377,1,'N'),(2378,1,'N'),(2379,1,'N'),(2380,1,'N'),(2381,1,'N'),(2382,1,'N'),(2383,1,'N'),(2384,1,'N'),(2385,1,'N'),(2386,1,'N'),(2387,1,'N'),(2388,1,'N'),(2389,1,'N'),(2390,1,'N'),(2391,1,'N'),(2392,1,'N'),(2393,1,'N'),(2394,1,'N'),(2395,1,'N'),(2396,1,'N'),(2397,1,'N'),(2398,1,'N'),(2399,1,'N'),(2400,1,'N'),(2401,1,'N'),(2402,1,'N'),(2403,1,'N'),(2404,1,'N'),(2405,1,'N'),(2406,1,'N'),(2407,1,'N'),(2408,1,'N'),(2409,1,'N'),(2410,1,'N'),(2411,1,'N'),(2412,1,'N'),(2413,1,'N'),(2414,1,'N'),(2415,1,'N'),(2416,1,'N'),(2417,1,'N'),(2418,1,'N'),(2419,1,'N'),(2420,1,'N'),(2421,1,'N'),(2422,1,'N'),(2423,1,'N'),(2424,1,'N'),(2425,1,'N'),(2426,1,'N'),(2427,1,'N'),(2428,1,'N'),(2429,1,'N'),(2430,1,'N'),(2431,1,'N'),(2432,1,'N'),(2433,1,'N'),(2434,1,'N'),(2435,1,'N'),(2436,1,'N'),(2437,1,'N'),(2438,1,'N'),(2439,1,'N'),(2440,1,'N'),(2441,1,'N'),(2442,1,'N'),(2443,1,'N'),(2444,1,'N'),(2445,1,'N'),(2446,1,'N'),(2447,1,'N'),(2448,1,'N'),(2449,1,'N'),(2450,1,'N'),(2451,1,'N'),(2452,1,'N'),(2453,1,'N'),(2454,1,'N'),(2455,1,'N'),(2456,1,'N'),(2457,1,'N'),(2458,1,'N'),(2459,1,'N'),(2460,1,'N'),(2461,1,'N'),(2462,1,'N'),(2463,1,'N'),(2464,1,'N'),(2465,1,'N'),(2466,1,'N'),(2467,1,'N'),(2468,1,'N'),(2469,1,'N'),(2470,1,'N'),(2471,1,'N'),(2472,1,'N'),(2473,1,'N'),(2474,1,'N'),(2475,1,'N'),(2476,1,'N'),(2477,1,'N'),(2478,1,'N'),(2479,1,'N'),(2480,1,'N'),(2481,1,'N'),(2482,1,'N'),(2483,1,'N'),(2484,1,'N'),(2485,1,'N'),(2486,1,'N'),(2487,1,'N'),(2488,1,'N'),(2489,1,'N'),(2490,1,'N'),(2491,1,'N'),(2492,1,'N'),(2493,1,'N'),(2494,1,'N'),(2495,1,'N'),(2496,1,'N'),(2497,1,'N'),(2498,1,'N'),(2499,1,'N'),(2500,1,'N'),(2501,1,'N'),(2502,1,'N'),(2503,1,'N'),(2504,1,'N'),(2505,1,'N'),(2506,1,'N'),(2507,1,'N'),(2508,1,'N'),(2509,1,'N'),(2510,1,'N'),(2511,1,'N'),(2512,1,'N'),(2513,1,'N'),(2514,1,'N'),(2515,1,'N'),(2516,1,'N'),(2517,1,'N'),(2518,1,'N'),(2519,1,'N'),(2520,1,'N'),(2521,1,'N'),(2522,1,'N'),(2523,1,'N'),(2524,1,'N'),(2525,1,'N'),(2526,1,'N'),(2527,1,'N'),(2528,1,'N'),(2529,1,'N'),(2530,1,'N'),(2531,1,'N'),(2532,1,'N'),(2533,1,'N'),(2534,1,'N'),(2535,1,'N'),(2536,1,'N'),(2537,1,'N'),(2538,1,'N'),(2539,1,'N'),(2540,1,'N'),(2541,1,'N'),(2542,1,'N'),(2543,1,'N'),(2544,1,'N'),(2545,1,'N'),(2546,1,'N'),(2547,1,'N'),(2548,1,'N'),(2549,1,'N'),(2550,1,'N'),(2551,1,'N'),(2552,1,'N'),(2553,1,'N'),(2554,1,'N'),(2555,1,'N'),(2556,1,'N'),(2557,1,'N'),(2558,1,'N'),(2559,1,'N'),(2560,1,'N'),(2561,1,'N'),(2562,1,'N'),(2563,1,'N'),(2564,1,'N'),(2565,1,'N'),(2566,1,'N'),(2567,1,'N'),(2568,1,'N'),(2569,1,'N'),(2570,1,'N'),(2571,1,'N'),(2572,1,'N'),(2573,1,'N'),(2574,1,'N'),(2575,1,'N'),(2576,1,'N'),(2577,1,'N'),(2578,1,'N'),(2579,1,'N'),(2580,1,'N'),(2581,1,'N'),(2582,1,'N'),(2583,1,'N'),(2584,1,'N'),(2585,1,'N'),(2586,1,'N'),(2587,1,'N'),(2588,1,'N'),(2589,1,'N'),(2590,1,'N'),(2591,1,'N'),(2592,1,'N'),(2593,1,'N'),(2594,1,'N'),(2595,1,'N'),(2596,1,'N'),(2597,1,'N'),(2598,1,'N'),(2599,1,'N'),(2600,1,'N'),(2601,1,'N'),(2602,1,'N'),(2603,1,'N'),(2604,1,'N'),(2605,1,'N'),(2606,1,'N'),(2607,1,'N'),(2608,1,'N'),(2609,1,'N'),(2610,1,'N'),(2611,1,'N'),(2612,1,'N'),(2613,1,'N'),(2614,1,'N'),(2615,1,'N'),(2616,1,'N'),(2617,1,'N'),(2618,1,'N'),(2619,1,'N'),(2620,1,'N'),(2621,1,'N'),(2622,1,'N'),(2623,1,'N'),(2624,1,'N'),(2625,1,'N'),(2626,1,'N'),(2627,1,'N'),(2628,1,'N'),(2629,1,'N'),(2630,1,'N'),(2631,1,'N'),(2632,1,'N'),(2633,1,'N'),(2634,1,'N'),(2635,1,'N'),(2636,1,'N'),(2637,1,'N'),(2638,1,'N'),(2639,1,'N'),(2640,1,'N'),(2641,1,'N'),(2642,1,'N'),(2643,1,'N'),(2644,1,'N'),(2645,1,'N'),(2646,1,'N'),(2647,1,'N'),(2648,1,'N'),(2649,1,'N'),(2650,1,'N'),(2651,1,'N'),(2652,1,'N'),(2653,1,'N'),(2654,1,'N'),(2655,1,'N'),(2656,1,'N'),(2657,1,'N'),(2658,1,'N'),(2659,1,'N'),(2660,1,'N'),(2661,1,'N'),(2662,1,'N'),(2663,1,'N'),(2664,1,'N'),(2665,1,'N'),(2666,1,'N'),(2667,1,'N'),(2668,1,'N'),(2669,1,'N'),(2670,1,'N'),(2671,1,'N'),(2672,1,'N'),(2673,1,'N'),(2674,1,'N'),(2675,1,'N'),(2676,1,'N'),(2677,1,'N'),(2678,1,'N'),(2679,1,'N'),(2680,1,'N'),(2681,1,'N'),(2682,1,'N'),(2683,1,'N'),(2684,1,'N'),(2685,1,'N'),(2686,1,'N'),(2687,1,'N'),(2688,1,'N'),(2689,1,'N'),(2690,1,'N'),(2691,1,'N'),(2692,1,'N'),(2693,1,'N'),(2694,1,'N'),(2695,1,'N'),(2696,1,'N'),(2697,1,'N'),(2698,1,'N'),(2699,1,'N'),(2700,1,'N'),(2701,1,'N'),(2702,1,'N'),(2703,1,'N'),(2704,1,'N'),(2705,1,'N'),(2706,1,'N'),(2707,1,'N'),(2708,1,'N'),(2709,1,'N'),(2710,1,'N'),(2711,1,'N'),(2712,1,'N'),(2713,1,'N'),(2714,1,'N'),(2715,1,'N'),(2716,1,'N'),(2717,1,'N'),(2718,1,'N'),(2719,1,'N'),(2720,1,'N'),(2721,1,'N'),(2722,1,'N'),(2723,1,'N'),(2724,1,'N'),(2725,1,'N'),(2726,1,'N'),(2727,1,'N'),(2728,1,'N'),(2729,1,'N'),(2730,1,'N'),(2731,1,'N'),(2732,1,'N'),(2733,1,'N'),(2734,1,'N'),(2735,1,'N'),(2736,1,'N'),(2737,1,'N'),(2738,1,'N'),(2739,1,'N'),(2740,1,'N'),(2741,1,'N'),(2742,1,'N'),(2743,1,'N'),(2744,1,'N'),(2745,1,'N'),(2746,1,'N'),(2747,1,'N'),(2748,1,'N'),(2749,1,'N'),(2750,1,'N'),(2751,1,'N'),(2752,1,'N'),(2753,1,'N'),(2754,1,'N'),(2755,1,'N'),(2756,1,'N'),(2757,1,'N'),(2758,1,'N'),(2759,1,'N'),(2760,1,'N'),(2761,1,'N'),(2762,1,'N'),(2763,1,'N'),(2764,1,'N'),(2765,1,'N'),(2766,1,'N'),(2767,1,'N'),(2768,1,'N'),(2769,1,'N'),(2770,1,'N'),(2771,1,'N'),(2772,1,'N'),(2773,1,'N'),(2774,1,'N'),(2775,1,'N'),(2776,1,'N'),(2777,1,'N'),(2778,1,'N'),(2779,1,'N'),(2780,1,'N'),(2781,1,'N'),(2782,1,'N'),(2783,1,'N'),(2784,1,'N'),(2785,1,'N'),(2786,1,'N'),(2787,1,'N'),(2788,1,'N'),(2789,1,'N'),(2790,1,'N'),(2791,1,'N'),(2792,1,'N'),(2793,1,'N'),(2794,1,'N'),(2795,1,'N'),(2796,1,'N'),(2797,1,'N'),(2798,1,'N'),(2799,1,'N'),(2800,1,'N'),(2801,1,'N'),(2802,1,'N'),(2803,1,'N'),(2804,1,'N'),(2805,1,'N'),(2806,1,'N'),(2807,1,'N'),(2808,1,'N'),(2809,1,'N'),(2810,1,'N'),(2811,1,'N'),(2812,1,'N'),(2813,1,'N'),(2814,1,'N'),(2815,1,'N'),(2816,1,'N'),(2817,1,'N'),(2818,1,'N'),(2819,1,'N'),(2820,1,'N'),(2821,1,'N'),(2822,1,'N'),(2823,1,'N'),(2824,1,'N'),(2825,1,'N'),(2826,1,'N'),(2827,1,'N'),(2828,1,'N'),(2829,1,'N'),(2830,1,'N'),(2831,1,'N'),(2832,1,'N'),(2833,1,'N'),(2834,1,'N'),(2835,1,'N'),(2836,1,'N'),(2837,1,'N'),(2838,1,'N'),(2839,1,'N'),(2840,1,'N'),(2841,1,'N'),(2842,1,'N'),(2843,1,'N'),(2844,1,'N'),(2845,1,'N'),(2846,1,'N'),(2847,1,'N'),(2848,1,'N'),(2849,1,'N'),(2850,1,'N'),(2851,1,'N'),(2852,1,'N'),(2853,1,'N'),(2854,1,'N'),(2855,1,'N'),(2856,1,'N'),(2857,1,'N'),(2858,1,'N'),(2859,1,'N'),(2860,1,'N'),(2861,1,'N'),(2862,1,'N'),(2863,1,'N'),(2864,1,'N'),(2865,1,'N'),(2866,1,'N'),(2867,1,'N'),(2868,1,'N'),(2869,1,'N'),(2870,1,'N'),(2871,1,'N'),(2872,1,'N'),(2873,1,'N'),(2874,1,'N'),(2875,1,'N'),(2876,1,'N'),(2877,1,'N'),(2878,1,'N'),(2879,1,'N'),(2880,1,'N'),(2881,1,'N'),(2882,1,'N'),(2883,1,'N'),(2884,1,'N'),(2885,1,'N'),(2886,1,'N'),(2887,1,'N'),(2888,1,'N'),(2889,1,'N'),(2890,1,'N'),(2891,1,'N'),(2892,1,'N'),(2893,1,'N'),(2894,1,'N'),(2895,1,'N'),(2896,1,'N'),(2897,1,'N'),(2898,1,'N'),(2899,1,'N'),(2900,1,'N'),(2901,1,'N'),(2902,1,'N'),(2903,1,'N'),(2904,1,'N'),(2905,1,'N'),(2906,1,'N'),(2907,1,'N'),(2908,1,'N'),(2909,1,'N'),(2910,1,'N'),(2911,1,'N'),(2912,1,'N'),(2913,1,'N'),(2914,1,'N'),(2915,1,'N'),(2916,1,'N'),(2917,1,'N'),(2918,1,'N'),(2919,1,'N'),(2920,1,'N'),(2921,1,'N'),(2922,1,'N'),(2923,1,'N'),(2924,1,'N'),(2925,1,'N'),(2926,1,'N'),(2927,1,'N'),(2928,1,'N'),(2929,1,'N'),(2930,1,'N'),(2931,1,'N'),(2932,1,'N'),(2933,1,'N'),(2934,1,'N'),(2935,1,'N'),(2936,1,'N'),(2937,1,'N'),(2938,1,'N'),(2939,1,'N'),(2940,1,'N'),(2941,1,'N'),(2942,1,'N'),(2943,1,'N'),(2944,1,'N'),(2945,1,'N'),(2946,1,'N'),(2947,1,'N'),(2948,1,'N'),(2949,1,'N'),(2950,1,'N'),(2951,1,'N'),(2952,1,'N'),(2953,1,'N'),(2954,1,'N'),(2955,1,'N'),(2956,1,'N'),(2957,1,'N'),(2958,1,'N'),(2959,1,'N'),(2960,1,'N'),(2961,1,'N'),(2962,1,'N'),(2963,1,'N'),(2964,1,'N'),(2965,1,'N'),(2966,1,'N'),(2967,1,'N'),(2968,1,'N'),(2969,1,'N'),(2970,1,'N'),(2971,1,'N'),(2972,1,'N'),(2973,1,'N'),(2974,1,'N'),(2975,1,'N'),(2976,1,'N'),(2977,1,'N'),(2978,1,'N'),(2979,1,'N'),(2980,1,'N'),(2981,1,'N'),(2982,1,'N'),(2983,1,'N'),(2984,1,'N'),(2985,1,'N'),(2986,1,'N'),(2987,1,'N'),(2988,1,'N'),(2989,1,'N'),(2990,1,'N'),(2991,1,'N'),(2992,1,'N'),(2993,1,'N'),(2994,1,'N'),(2995,1,'N'),(2996,1,'N'),(2997,1,'N'),(2998,1,'N'),(2999,1,'N'),(3000,1,'N'),(3001,1,'N'),(3002,1,'N'),(3003,1,'N'),(3004,1,'N'),(3005,1,'N'),(3006,1,'N'),(3007,1,'N'),(3008,1,'N'),(3009,1,'N'),(3010,1,'N'),(3011,1,'N'),(3012,1,'N'),(3013,1,'N'),(3014,1,'N'),(3015,1,'N'),(3016,1,'N'),(3017,1,'N'),(3018,1,'N'),(3019,1,'N'),(3020,1,'N'),(3021,1,'N'),(3022,1,'N'),(3023,1,'N'),(3024,1,'N'),(3025,1,'N'),(3026,1,'N'),(3027,1,'N'),(3028,1,'N'),(3029,1,'N'),(3030,1,'N'),(3031,1,'N'),(3032,1,'N'),(3033,1,'N'),(3034,1,'N'),(3035,1,'N'),(3036,1,'N'),(3037,1,'N'),(3038,1,'N'),(3039,1,'N'),(3040,1,'N'),(3041,1,'N'),(3042,1,'N'),(3043,1,'N'),(3044,1,'N'),(3045,1,'N'),(3046,1,'N'),(3047,1,'N'),(3048,1,'N'),(3049,1,'N'),(3050,1,'N'),(3051,1,'N'),(3052,1,'N'),(3053,1,'N'),(3054,1,'N'),(3055,1,'N'),(3056,1,'N'),(3057,1,'N'),(3058,1,'N'),(3059,1,'N'),(3060,1,'N'),(3061,1,'N'),(3062,1,'N'),(3063,1,'N'),(3064,1,'N'),(3065,1,'N'),(3066,1,'N'),(3067,1,'N'),(3068,1,'N'),(3069,1,'N'),(3070,1,'N'),(3071,1,'N'),(3072,1,'N'),(3073,1,'N'),(3074,1,'N'),(3075,1,'N'),(3076,1,'N'),(3077,1,'N'),(3078,1,'N'),(3079,1,'N'),(3080,1,'N'),(3081,1,'N'),(3082,1,'N'),(3083,1,'N'),(3084,1,'N'),(3085,1,'N'),(3086,1,'N'),(3087,1,'N'),(3088,1,'N'),(3089,1,'N'),(3090,1,'N'),(3091,1,'N'),(3092,1,'N'),(3093,1,'N'),(3094,1,'N'),(3095,1,'N'),(3096,1,'N'),(3097,1,'N'),(3098,1,'N'),(3099,1,'N'),(3100,1,'N'),(3101,1,'N'),(3102,1,'N'),(3103,1,'N'),(3104,1,'N'),(3105,1,'N'),(3106,1,'N'),(3107,1,'N'),(3108,1,'N'),(3109,1,'N'),(3110,1,'N'),(3111,1,'N'),(3112,1,'N'),(3113,1,'N'),(3114,1,'N'),(3115,1,'N'),(3116,1,'N'),(3117,1,'N'),(3118,1,'N'),(3119,1,'N'),(3120,1,'N'),(3121,1,'N'),(3122,1,'N'),(3123,1,'N'),(3124,1,'N'),(3125,1,'N'),(3126,1,'N'),(3127,1,'N'),(3128,1,'N'),(3129,1,'N'),(3130,1,'N'),(3131,1,'N'),(3132,1,'N'),(3133,1,'N'),(3134,1,'N'),(3135,1,'N'),(3136,1,'N'),(3137,1,'N'),(3138,1,'N'),(3139,1,'N'),(3140,1,'N'),(3141,1,'N'),(3142,1,'N'),(3143,1,'N'),(3144,1,'N'),(3145,1,'N'),(3146,1,'N'),(3147,1,'N'),(3148,1,'N'),(3149,1,'N'),(3150,1,'N'),(3151,1,'N'),(3152,1,'N'),(3153,1,'N'),(3154,1,'N'),(3155,1,'N'),(3156,1,'N'),(3157,1,'N'),(3158,1,'N'),(3159,1,'N'),(3160,1,'N'),(3161,1,'N'),(3162,1,'N'),(3163,1,'N'),(3164,1,'N'),(3165,1,'N'),(3166,1,'N'),(3167,1,'N'),(3168,1,'N'),(3169,1,'N'),(3170,1,'N'),(3171,1,'N'),(3172,1,'N'),(3173,1,'N'),(3174,1,'N'),(3175,1,'N'),(3176,1,'N'),(3177,1,'N'),(3178,1,'N'),(3179,1,'N'),(3180,1,'N'),(3181,1,'N'),(3182,1,'N'),(3183,1,'N'),(3184,1,'N'),(3185,1,'N'),(3186,1,'N'),(3187,1,'N'),(3188,1,'N'),(3189,1,'N'),(3190,1,'N'),(3191,1,'N'),(3192,1,'N'),(3193,1,'N'),(3194,1,'N'),(3195,1,'N'),(3196,1,'N'),(3197,1,'N'),(3198,1,'N'),(3199,1,'N'),(3200,1,'N'),(3201,1,'N'),(3202,1,'N'),(3203,1,'N'),(3204,1,'N'),(3205,1,'N'),(3206,1,'N'),(3207,1,'N'),(3208,1,'N'),(3209,1,'N'),(3210,1,'N'),(3211,1,'N'),(3212,1,'N'),(3213,1,'N'),(3214,1,'N'),(3215,1,'N'),(3216,1,'N'),(3217,1,'N'),(3218,1,'N'),(3219,1,'N'),(3220,1,'N'),(3221,1,'N'),(3222,1,'N'),(3223,1,'N'),(3224,1,'N'),(3225,1,'N'),(3226,1,'N'),(3227,1,'N'),(3228,1,'N'),(3229,1,'N'),(3230,1,'N'),(3231,1,'N'),(3232,1,'N'),(3233,1,'N'),(3234,1,'N'),(3235,1,'N'),(3236,1,'N'),(3237,1,'N'),(3238,1,'N'),(3239,1,'N'),(3240,1,'N'),(3241,1,'N');
/*!40000 ALTER TABLE `userEvents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','0DPiKuNIrrVmD8IUCuw1hQxNqZc=','admin@yourMangoDomain.com','','Y','N',1624095710639,4,'',0,'N');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usersProfiles`
--

LOCK TABLES `usersProfiles` WRITE;
/*!40000 ALTER TABLE `usersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `usersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usersUsersProfiles`
--

LOCK TABLES `usersUsersProfiles` WRITE;
/*!40000 ALTER TABLE `usersUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `usersUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `values_multi_changes_history`
--

LOCK TABLES `values_multi_changes_history` WRITE;
/*!40000 ALTER TABLE `values_multi_changes_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `values_multi_changes_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `viewUsersProfiles`
--

LOCK TABLES `viewUsersProfiles` WRITE;
/*!40000 ALTER TABLE `viewUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `viewUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `views_category_views_hierarchy`
--

LOCK TABLES `views_category_views_hierarchy` WRITE;
/*!40000 ALTER TABLE `views_category_views_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `views_category_views_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `watchListPoints`
--

LOCK TABLES `watchListPoints` WRITE;
/*!40000 ALTER TABLE `watchListPoints` DISABLE KEYS */;
INSERT INTO `watchListPoints` VALUES (1,1,0),(1,2,1),(3,6,0),(3,8,1),(3,7,2),(3,9,3),(3,10,4),(3,11,5),(3,14,6),(3,13,7),(3,12,8),(3,24,9),(2,3,0),(2,4,1),(2,5,2),(2,25,3),(2,26,4),(2,27,5),(4,28,0),(4,32,1),(4,29,2),(4,33,3),(4,35,4),(4,34,5),(4,45,6),(4,46,7),(4,47,8),(4,49,9),(4,50,10),(4,48,11),(4,54,12),(4,52,13),(4,53,14),(4,55,15),(4,56,16),(4,57,17),(4,51,18),(4,59,19);
/*!40000 ALTER TABLE `watchListPoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `watchListUsers`
--

LOCK TABLES `watchListUsers` WRITE;
/*!40000 ALTER TABLE `watchListUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchListUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `watchListUsersProfiles`
--

LOCK TABLES `watchListUsersProfiles` WRITE;
/*!40000 ALTER TABLE `watchListUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchListUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `watchLists`
--

LOCK TABLES `watchLists` WRITE;
/*!40000 ALTER TABLE `watchLists` DISABLE KEYS */;
INSERT INTO `watchLists` VALUES (1,'WL_758368',1,'Solar panel 1'),(2,'WL_547379',1,'Energy store 1'),(3,'WL_354248',1,'Gas turbine 1'),(4,'WL_901425',1,'Cabinets');
/*!40000 ALTER TABLE `watchLists` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-19  9:41:54
