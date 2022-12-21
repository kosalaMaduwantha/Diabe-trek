CREATE DATABASE  IF NOT EXISTS `physicalact` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `physicalact`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: physicalact
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `fetch_routine_data`
--

DROP TABLE IF EXISTS `fetch_routine_data`;
/*!50001 DROP VIEW IF EXISTS `fetch_routine_data`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `fetch_routine_data` AS SELECT 
 1 AS `week_no`,
 1 AS `month_of`,
 1 AS `year_of`,
 1 AS `day_no`,
 1 AS `activity`,
 1 AS `no_min`,
 1 AS `cus`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `fetch_routine_data`
--

/*!50001 DROP VIEW IF EXISTS `fetch_routine_data`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fetch_routine_data` AS select `w`.`week_no` AS `week_no`,`w`.`month_of` AS `month_of`,`w`.`year_of` AS `year_of`,`d`.`day_no` AS `day_no`,`r`.`activity` AS `activity`,`r`.`no_min` AS `no_min`,`r`.`cus` AS `cus` from ((`week` `w` join `day` `d` on((`w`.`week_no` = `d`.`week_no`))) left join `routine` `r` on((`d`.`day_no` = `r`.`day_no`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'physicalact'
--

--
-- Dumping routines for database 'physicalact'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetAllProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllProducts`(Agec$ int, genderc$ varchar(100), weightc$ float, heightc$ float,
								BloodPressurec$ float, cholestrolc$ float, Glucosec$ float, diabetesc$ int,
								discomfirt_chestc$ int, current_physical_activity_statusc$ int, 
								family_history_heart_diseasec$ int, cigerette_consumptionc$ int,
								prediction_poolc$ int, cus_idc$ int)
BEGIN

	DECLARE v_msg VARCHAR(255);


START TRANSACTION;

	IF EXISTS (SELECT class_id FROM classification WHERE classification.cus_id = cus_idc$) THEN 
		UPDATE classification 
		   SET Age = Agec$, gender = genderc$, weight = weightc$,
			   height= heightc$, BloodPressure = BloodPressurec$, cholestrol = cholestrolc$,
               Glucose = Glucosec$, diabetes = diabetesc$, discomfirt_chest = discomfirt_chestc$,
			   current_physical_activity_status = current_physical_activity_statusc$,
			   family_history_heart_disease = family_history_heart_diseasec$,
			   cigerette_consumption = cigerette_consumptionc$, prediction_pool = prediction_poolc$
		WHERE cus_id = cus_idc$;
        SET v_msg = concat('record is already available and record updated');
	 ELSE 
		INSERT INTO classification
		   SET Age = Agec$, gender = genderc$, weight = weightc$,
			   height= heightc$, BloodPressure = BloodPressurec$, cholestrol = cholestrolc$,
               Glucose = Glucosec$, diabetes = diabetesc$, discomfirt_chest = discomfirt_chestc$,
			   current_physical_activity_status = current_physical_activity_statusc$,
			   family_history_heart_disease = family_history_heart_diseasec$,
			   cigerette_consumption = cigerette_consumptionc$, prediction_pool = prediction_poolc$,
               cus_id = cus_idc$;
		SET v_msg = concat('new record added');
	END IF;
COMMIT;
SELECT v_msg;
       
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `post_routines_day` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `post_routines_day`(week_no$ int, month_of$ int, year_of$ int,
											day_no$ int, activity$ VARCHAR(100), no_min$ int, cus_id$ int)
BEGIN

	DECLARE v_msg VARCHAR(255);



START TRANSACTION;

	IF NOT EXISTS (SELECT week_no FROM week WHERE week.week_no = week_no$) THEN 
		INSERT INTO week
		   SET week_no = week_no$, month_of = month_of$, year_of = year_of$;
		SET v_msg = concat('new record added to week table');
	END IF;
    
	IF NOT EXISTS (SELECT day_no FROM day WHERE day.day_no = day_no$) THEN
		INSERT INTO day
		   SET day_no = day_no$, week_no = week_no$;
		SET v_msg = concat('new record added to day table');
	END IF;
    
	
	INSERT INTO routine
		SET activity = activity$, no_min = no_min$, cus = cus_id$, day_no = day_no$;
	SET v_msg = concat('new record added to routine table');
	
    
COMMIT;
SELECT v_msg;
       
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-09 12:40:35
