-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: HostHub
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agenzia`
--

DROP TABLE IF EXISTS `agenzia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agenzia` (
  `id_agenzia` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `partita_iva` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `indirizzo_sede` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Descrizione` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id_agenzia`),
  UNIQUE KEY `partita_iva` (`partita_iva`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agenzia`
--

LOCK TABLES `agenzia` WRITE;
/*!40000 ALTER TABLE `agenzia` DISABLE KEYS */;
INSERT INTO `agenzia` VALUES (1,'Roma Tours','10000000001','info@romatours.it','+39 06123456','Via Roma 1','Tour della capitale'),(2,'Milano Events','10000000002','contact@milanoevents.it','+39 02123456','Via Milano 2','Eventi e design'),(3,'Napoli Experience','10000000003','hello@napoliexp.it','+39 08123456','Via Napoli 3','Gusti e tradizioni'),(4,'Firenze Arte','10000000004','arte@firenzearte.it','+39 05512345','Via Firenze 4','Tour dei musei'),(5,'Venezia Magica','10000000005','tour@veneziamagica.it','+39 04112345','Via Venezia 5','Giri in gondola'),(6,'Sicily Explore','10000000006','info@sicilyexplore.it','+39 09112345','Via Palermo 6','Esplora la Sicilia'),(7,'Piemonte Gusto','10000000007','food@piemontegusto.it','+39 01112345','Via Torino 7','Degustazioni vino'),(8,'Genoa Sea','10000000008','sea@genoasea.it','+39 01012345','Via Genova 8','Gite in barca'),(9,'Bologna Food','10000000009','taste@bolognafood.it','+39 05112345','Via Bologna 9','Tour gastronomici'),(10,'Verona Love','10000000010','love@veronatours.it','+39 04512345','Via Verona 10','Itinerari romantici');
/*!40000 ALTER TABLE `agenzia` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Integrita_Dati_Agenzia` BEFORE INSERT ON `agenzia` FOR EACH ROW BEGIN
    
    IF NEW.email NOT LIKE '%_@__%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Formato email dell''agenzia non valido.';
    END IF;

    
    IF NEW.telefono IS NOT NULL AND NEW.telefono NOT REGEXP '^[+0-9 ]+$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il numero di telefono dell''agenzia può contenere solo numeri, spazi e +.';
    END IF;

    
    IF LENGTH(NEW.partita_iva) != 11 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: La Partita IVA deve contenere esattamente 11 caratteri.';
    END IF;
    
    
    IF NEW.partita_iva NOT REGEXP '^[0-9]+$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: La Partita IVA deve contenere esclusivamente numeri.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alloggio`
--

DROP TABLE IF EXISTS `alloggio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alloggio` (
  `id_alloggio` int NOT NULL AUTO_INCREMENT,
  `titolo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `descrizione` text COLLATE utf8mb4_general_ci,
  `indirizzo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `prezzo_notte` decimal(10,2) DEFAULT NULL,
  `capienza` int DEFAULT NULL,
  `tipo_alloggio` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `numero_camere` int DEFAULT NULL,
  `numero_letti` int DEFAULT NULL,
  `numero_bagni` int DEFAULT NULL,
  `id_host` int DEFAULT NULL,
  `id_citta` int DEFAULT NULL,
  PRIMARY KEY (`id_alloggio`),
  KEY `id_host` (`id_host`),
  KEY `id_citta` (`id_citta`),
  CONSTRAINT `alloggio_ibfk_1` FOREIGN KEY (`id_host`) REFERENCES `host` (`id_host`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `alloggio_ibfk_2` FOREIGN KEY (`id_citta`) REFERENCES `citta` (`id_citta`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alloggio`
--

LOCK TABLES `alloggio` WRITE;
/*!40000 ALTER TABLE `alloggio` DISABLE KEYS */;
INSERT INTO `alloggio` VALUES (1,'Attico Vista Colosseo','Splendido attico','Via dei Fori 1',150.00,4,'Appartamento',2,2,1,1,1),(2,'Loft in Navigli','Moderno e luminoso','Ripa Ticinese 5',120.00,2,'Loft',1,1,1,2,2),(3,'Casa sul Golfo','Vista mare','Via Partenope 10',90.00,5,'Appartamento',3,4,2,1,3),(4,'Baita in Centro','Stile rustico','Via Po 20',85.00,3,'Casa indipendente',2,2,1,4,4),(5,'Camera agli Uffizi','Accogliente','Piazza Signoria 2',70.00,2,'Stanza privata',1,1,1,1,5),(6,'Palazzo Veneziano','Affresco storico','San Marco 100',250.00,6,'Villa',4,4,3,6,6),(7,'Student Room','Economica e centrale','Via Zamboni 50',40.00,1,'Stanza privata',1,1,1,7,7),(8,'Villa Monreale','Con piscina','Via Roma 100',300.00,10,'Villa',5,6,4,8,8),(9,'Porto Antico Flat','Vicino acquario','Via del Molo 3',95.00,4,'Appartamento',2,2,1,9,9),(10,'Romeo Balcony','Romantico rifugio','Via Mazzini 12',110.00,2,'Appartamento',1,1,1,10,10),(11,'Camera con vista sulla Torre di Pisa','Camera elegante con vista sulla Torre pendente, arredi classici e atmosfera accogliente nel cuore di Pisa.','Centro storico',120.00,2,'Camera privata',1,1,1,1,11),(12,'Casa storica nel centro di Siena','Alloggio in edificio storico con facciata in pietra, dettagli tradizionali e posizione ideale per visitare Siena.','Centro storico',130.00,4,'Casa vacanze',2,2,1,1,12),(13,'Appartamento luminoso a Bari Vecchia','Appartamento accogliente con balcone fiorito e vista sui vicoli del centro storico di Bari.','Bari Vecchia',110.00,3,'Appartamento',1,2,1,1,13),(14,'Loft panoramico a Catania','Loft moderno con grandi vetrate, vista sull’Etna e ambienti ampi e luminosi.','Centro città',145.00,4,'Loft',2,2,1,1,14),(15,'Camera panoramica a Trieste','Alloggio luminoso con vista sul mare e arredi moderni, ideale per un soggiorno rilassante.','Centro città',95.00,2,'Camera privata',1,1,1,1,15),(16,'Appartamento elegante a Padova','Appartamento con travi a vista e affaccio sul centro storico, perfetto per coppie o piccoli gruppi.','Centro storico',120.00,4,'Appartamento',2,2,1,1,16),(17,'Casa rustica a Perugia','Alloggio in stile tradizionale con vista sulle colline umbre e atmosfera accogliente.','Zona collinare',110.00,4,'Casa vacanze',2,3,1,1,17),(18,'Dimora storica a Lecce','Elegante alloggio in pietra leccese con arredi classici e ambiente raffinato.','Centro storico',135.00,2,'Suite',1,1,1,1,18),(19,'Casa nei Sassi di Matera','Alloggio caratteristico scavato nella pietra, con interni suggestivi e atmosfera unica.','Sassi di Matera',145.00,4,'Casa tipica',2,2,1,1,19),(20,'Appartamento vista mare a Rimini','Alloggio moderno e luminoso vicino alla spiaggia, con terrazza e vista sul mare.','Lungomare',130.00,4,'Appartamento',2,2,1,1,20),(21,'Suite panoramica sul Lago di Como','Alloggio elegante con balcone e vista diretta sul lago, ideale per soggiorni romantici.','Lungolago',180.00,2,'Suite',1,1,1,1,21),(22,'Casa accogliente a Lucca','Appartamento dallo stile toscano con interni caldi e vista sul verde.','Centro storico',105.00,4,'Appartamento',2,2,1,1,22),(23,'Loft gastronomico a Parma','Alloggio spazioso con cucina moderna e dettagli eleganti, ideale per vivere il centro cittadino.','Centro città',115.00,4,'Loft',2,2,1,1,23),(24,'Loft moderno a Modena','Ambiente industrial chic con grandi vetrate, spazi aperti e design contemporaneo.','Zona centrale',125.00,4,'Loft',2,2,2,1,24),(25,'Camera artistica a Ravenna','Alloggio luminoso con dettagli ispirati ai mosaici ravennati e arredi curati.','Centro storico',100.00,2,'Camera privata',1,1,1,1,25),(26,'Chalet elegante a Trento','Alloggio in stile alpino con grandi finestre, vista sulle montagne e interni in legno.','Zona panoramica',160.00,4,'Chalet',2,2,1,1,26),(27,'Appartamento alpino a Bolzano','Appartamento luminoso con vista sulle Dolomiti, perfetto per soggiorni in montagna.','Centro città',170.00,4,'Appartamento',2,2,1,1,27),(28,'Terrazza sul mare a Cagliari','Alloggio con ampia terrazza vista mare, ideale per vacanze rilassanti in Sardegna.','Zona mare',150.00,4,'Appartamento',2,2,1,1,28),(29,'Loft sul porto di Olbia','Alloggio luminoso con vista sul porto e interni chiari in stile marinaro.','Zona porto',140.00,4,'Loft',2,2,1,1,29),(30,'Appartamento vista mare a Salerno','Alloggio moderno con balcone panoramico sul mare e ambienti luminosi.','Lungomare',135.00,4,'Appartamento',2,2,1,1,30),(31,'Villa panoramica ad Amalfi','Alloggio con terrazza vista Costiera Amalfitana, circondato da fiori e atmosfera mediterranea.','Zona panoramica',210.00,5,'Villa',3,3,2,1,31),(32,'Dimora medievale ad Assisi','Camera accogliente in edificio storico con pareti in pietra e arredi semplici.','Centro storico',95.00,2,'Camera privata',1,1,1,1,32),(33,'Chalet sulla neve ad Aosta','Chalet indipendente immerso nella neve, con vista sulle montagne e interni caldi.','Zona montana',190.00,4,'Chalet',2,2,1,1,33),(34,'Casa storica a Bergamo','Alloggio in borgo antico con architettura in pietra e atmosfera medievale.','Città Alta',120.00,3,'Casa vacanze',2,2,1,1,34),(35,'Camera musicale a Cremona','Alloggio luminoso con dettagli musicali e vista sul centro storico.','Centro storico',90.00,2,'Camera privata',1,1,1,1,35),(36,'Appartamento sul lago a Mantova','Alloggio con balcone e vista sull’acqua, ideale per visitare il centro di Mantova.','Zona lago',115.00,4,'Appartamento',2,2,1,1,36),(37,'Studio con biciclette a Ferrara','Monolocale accogliente in stile urbano, perfetto per esplorare Ferrara in bicicletta.','Centro storico',85.00,2,'Monolocale',1,1,1,1,37),(38,'Camera artistica a Urbino','Alloggio semplice e luminoso con scrivania, ideale per soggiorni culturali.','Centro storico',80.00,2,'Camera privata',1,1,1,1,38),(39,'Appartamento sul porto di Ancona','Alloggio con balcone panoramico sul porto, ideale per soggiorni vicino al mare.','Zona porto',120.00,3,'Appartamento',1,2,1,1,39),(40,'Casa sui canali di Livorno','Appartamento luminoso con vista sui canali storici di Livorno e atmosfera marinara.','Quartiere Venezia',110.00,4,'Appartamento',2,2,1,1,40);
/*!40000 ALTER TABLE `alloggio` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Controllo_Prezzi_Negativi_Alloggio` BEFORE INSERT ON `alloggio` FOR EACH ROW BEGIN
    IF NEW.prezzo_notte <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il prezzo per notte deve essere maggiore di zero.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add agenzia',7,'add_agenzia'),(26,'Can change agenzia',7,'change_agenzia'),(27,'Can delete agenzia',7,'delete_agenzia'),(28,'Can view agenzia',7,'view_agenzia'),(29,'Can add alloggio',8,'add_alloggio'),(30,'Can change alloggio',8,'change_alloggio'),(31,'Can delete alloggio',8,'delete_alloggio'),(32,'Can view alloggio',8,'view_alloggio'),(33,'Can add auth group',9,'add_authgroup'),(34,'Can change auth group',9,'change_authgroup'),(35,'Can delete auth group',9,'delete_authgroup'),(36,'Can view auth group',9,'view_authgroup'),(37,'Can add auth group permissions',10,'add_authgrouppermissions'),(38,'Can change auth group permissions',10,'change_authgrouppermissions'),(39,'Can delete auth group permissions',10,'delete_authgrouppermissions'),(40,'Can view auth group permissions',10,'view_authgrouppermissions'),(41,'Can add auth permission',11,'add_authpermission'),(42,'Can change auth permission',11,'change_authpermission'),(43,'Can delete auth permission',11,'delete_authpermission'),(44,'Can view auth permission',11,'view_authpermission'),(45,'Can add auth user',12,'add_authuser'),(46,'Can change auth user',12,'change_authuser'),(47,'Can delete auth user',12,'delete_authuser'),(48,'Can view auth user',12,'view_authuser'),(49,'Can add auth user groups',13,'add_authusergroups'),(50,'Can change auth user groups',13,'change_authusergroups'),(51,'Can delete auth user groups',13,'delete_authusergroups'),(52,'Can view auth user groups',13,'view_authusergroups'),(53,'Can add auth user user permissions',14,'add_authuseruserpermissions'),(54,'Can change auth user user permissions',14,'change_authuseruserpermissions'),(55,'Can delete auth user user permissions',14,'delete_authuseruserpermissions'),(56,'Can view auth user user permissions',14,'view_authuseruserpermissions'),(57,'Can add badge',15,'add_badge'),(58,'Can change badge',15,'change_badge'),(59,'Can delete badge',15,'delete_badge'),(60,'Can view badge',15,'view_badge'),(61,'Can add citta',16,'add_citta'),(62,'Can change citta',16,'change_citta'),(63,'Can delete citta',16,'delete_citta'),(64,'Can view citta',16,'view_citta'),(65,'Can add django admin log',17,'add_djangoadminlog'),(66,'Can change django admin log',17,'change_djangoadminlog'),(67,'Can delete django admin log',17,'delete_djangoadminlog'),(68,'Can view django admin log',17,'view_djangoadminlog'),(69,'Can add django content type',18,'add_djangocontenttype'),(70,'Can change django content type',18,'change_djangocontenttype'),(71,'Can delete django content type',18,'delete_djangocontenttype'),(72,'Can view django content type',18,'view_djangocontenttype'),(73,'Can add django migrations',19,'add_djangomigrations'),(74,'Can change django migrations',19,'change_djangomigrations'),(75,'Can delete django migrations',19,'delete_djangomigrations'),(76,'Can view django migrations',19,'view_djangomigrations'),(77,'Can add django session',20,'add_djangosession'),(78,'Can change django session',20,'change_djangosession'),(79,'Can delete django session',20,'delete_djangosession'),(80,'Can view django session',20,'view_djangosession'),(81,'Can add esperienze',21,'add_esperienze'),(82,'Can change esperienze',21,'change_esperienze'),(83,'Can delete esperienze',21,'delete_esperienze'),(84,'Can view esperienze',21,'view_esperienze'),(85,'Can add utente',34,'add_utente'),(86,'Can change utente',34,'change_utente'),(87,'Can delete utente',34,'delete_utente'),(88,'Can view utente',34,'view_utente'),(89,'Can add lingua',23,'add_lingua'),(90,'Can change lingua',23,'change_lingua'),(91,'Can delete lingua',23,'delete_lingua'),(92,'Can view lingua',23,'view_lingua'),(93,'Can add offre',24,'add_offre'),(94,'Can change offre',24,'change_offre'),(95,'Can delete offre',24,'delete_offre'),(96,'Can view offre',24,'view_offre'),(97,'Can add ottiene',25,'add_ottiene'),(98,'Can change ottiene',25,'change_ottiene'),(99,'Can delete ottiene',25,'delete_ottiene'),(100,'Can view ottiene',25,'view_ottiene'),(101,'Can add parla agenzia',26,'add_parlaagenzia'),(102,'Can change parla agenzia',26,'change_parlaagenzia'),(103,'Can delete parla agenzia',26,'delete_parlaagenzia'),(104,'Can view parla agenzia',26,'view_parlaagenzia'),(105,'Can add parla host',27,'add_parlahost'),(106,'Can change parla host',27,'change_parlahost'),(107,'Can delete parla host',27,'delete_parlahost'),(108,'Can view parla host',27,'view_parlahost'),(109,'Can add prenotazione alloggio',28,'add_prenotazionealloggio'),(110,'Can change prenotazione alloggio',28,'change_prenotazionealloggio'),(111,'Can delete prenotazione alloggio',28,'delete_prenotazionealloggio'),(112,'Can view prenotazione alloggio',28,'view_prenotazionealloggio'),(113,'Can add prenotazione esperienze',29,'add_prenotazioneesperienze'),(114,'Can change prenotazione esperienze',29,'change_prenotazioneesperienze'),(115,'Can delete prenotazione esperienze',29,'delete_prenotazioneesperienze'),(116,'Can view prenotazione esperienze',29,'view_prenotazioneesperienze'),(117,'Can add punti interesse',30,'add_puntiinteresse'),(118,'Can change punti interesse',30,'change_puntiinteresse'),(119,'Can delete punti interesse',30,'delete_puntiinteresse'),(120,'Can view punti interesse',30,'view_puntiinteresse'),(121,'Can add recensione alloggio',31,'add_recensionealloggio'),(122,'Can change recensione alloggio',31,'change_recensionealloggio'),(123,'Can delete recensione alloggio',31,'delete_recensionealloggio'),(124,'Can view recensione alloggio',31,'view_recensionealloggio'),(125,'Can add recensione esperienze',32,'add_recensioneesperienze'),(126,'Can change recensione esperienze',32,'change_recensioneesperienze'),(127,'Can delete recensione esperienze',32,'delete_recensioneesperienze'),(128,'Can view recensione esperienze',32,'view_recensioneesperienze'),(129,'Can add servizio',33,'add_servizio'),(130,'Can change servizio',33,'change_servizio'),(131,'Can delete servizio',33,'delete_servizio'),(132,'Can view servizio',33,'view_servizio'),(133,'Can add vista alloggi con servizi',35,'add_vistaalloggiconservizi'),(134,'Can change vista alloggi con servizi',35,'change_vistaalloggiconservizi'),(135,'Can delete vista alloggi con servizi',35,'delete_vistaalloggiconservizi'),(136,'Can view vista alloggi con servizi',35,'view_vistaalloggiconservizi'),(137,'Can add vista classifica alloggi',36,'add_vistaclassificaalloggi'),(138,'Can change vista classifica alloggi',36,'change_vistaclassificaalloggi'),(139,'Can delete vista classifica alloggi',36,'delete_vistaclassificaalloggi'),(140,'Can view vista classifica alloggi',36,'view_vistaclassificaalloggi'),(141,'Can add vista classifica esperienze',37,'add_vistaclassificaesperienze'),(142,'Can change vista classifica esperienze',37,'change_vistaclassificaesperienze'),(143,'Can delete vista classifica esperienze',37,'delete_vistaclassificaesperienze'),(144,'Can view vista classifica esperienze',37,'view_vistaclassificaesperienze'),(145,'Can add vista dashboard guadagni agenzia',38,'add_vistadashboardguadagniagenzia'),(146,'Can change vista dashboard guadagni agenzia',38,'change_vistadashboardguadagniagenzia'),(147,'Can delete vista dashboard guadagni agenzia',38,'delete_vistadashboardguadagniagenzia'),(148,'Can view vista dashboard guadagni agenzia',38,'view_vistadashboardguadagniagenzia'),(149,'Can add vista dashboard guadagni host',39,'add_vistadashboardguadagnihost'),(150,'Can change vista dashboard guadagni host',39,'change_vistadashboardguadagnihost'),(151,'Can delete vista dashboard guadagni host',39,'delete_vistadashboardguadagnihost'),(152,'Can view vista dashboard guadagni host',39,'view_vistadashboardguadagnihost'),(153,'Can add vista dettaglio prenotazione ospite',40,'add_vistadettaglioprenotazioneospite'),(154,'Can change vista dettaglio prenotazione ospite',40,'change_vistadettaglioprenotazioneospite'),(155,'Can delete vista dettaglio prenotazione ospite',40,'delete_vistadettaglioprenotazioneospite'),(156,'Can view vista dettaglio prenotazione ospite',40,'view_vistadettaglioprenotazioneospite'),(157,'Can add vista esplora dintorni',41,'add_vistaesploradintorni'),(158,'Can change vista esplora dintorni',41,'change_vistaesploradintorni'),(159,'Can delete vista esplora dintorni',41,'delete_vistaesploradintorni'),(160,'Can view vista esplora dintorni',41,'view_vistaesploradintorni'),(161,'Can add vista fatturazione prenotazioni',42,'add_vistafatturazioneprenotazioni'),(162,'Can change vista fatturazione prenotazioni',42,'change_vistafatturazioneprenotazioni'),(163,'Can delete vista fatturazione prenotazioni',42,'delete_vistafatturazioneprenotazioni'),(164,'Can view vista fatturazione prenotazioni',42,'view_vistafatturazioneprenotazioni'),(165,'Can add vista prenotazioni da recensire',43,'add_vistaprenotazionidarecensire'),(166,'Can change vista prenotazioni da recensire',43,'change_vistaprenotazionidarecensire'),(167,'Can delete vista prenotazioni da recensire',43,'delete_vistaprenotazionidarecensire'),(168,'Can view vista prenotazioni da recensire',43,'view_vistaprenotazionidarecensire'),(169,'Can add vista profilo agenzia completo',44,'add_vistaprofiloagenziacompleto'),(170,'Can change vista profilo agenzia completo',44,'change_vistaprofiloagenziacompleto'),(171,'Can delete vista profilo agenzia completo',44,'delete_vistaprofiloagenziacompleto'),(172,'Can view vista profilo agenzia completo',44,'view_vistaprofiloagenziacompleto'),(173,'Can add vista profilo host completo',45,'add_vistaprofilohostcompleto'),(174,'Can change vista profilo host completo',45,'change_vistaprofilohostcompleto'),(175,'Can delete vista profilo host completo',45,'delete_vistaprofilohostcompleto'),(176,'Can view vista profilo host completo',45,'view_vistaprofilohostcompleto'),(177,'Can add vista profilo ospite crm',46,'add_vistaprofiloospitecrm'),(178,'Can change vista profilo ospite crm',46,'change_vistaprofiloospitecrm'),(179,'Can delete vista profilo ospite crm',46,'delete_vistaprofiloospitecrm'),(180,'Can view vista profilo ospite crm',46,'view_vistaprofiloospitecrm'),(181,'Can add vista statistiche servizi',47,'add_vistastatisticheservizi'),(182,'Can change vista statistiche servizi',47,'change_vistastatisticheservizi'),(183,'Can delete vista statistiche servizi',47,'delete_vistastatisticheservizi'),(184,'Can view vista statistiche servizi',47,'view_vistastatisticheservizi'),(185,'Can add vista top destinazioni',48,'add_vistatopdestinazioni'),(186,'Can change vista top destinazioni',48,'change_vistatopdestinazioni'),(187,'Can delete vista top destinazioni',48,'delete_vistatopdestinazioni'),(188,'Can view vista top destinazioni',48,'view_vistatopdestinazioni'),(189,'Can add host',22,'add_host'),(190,'Can change host',22,'change_host'),(191,'Can delete host',22,'delete_host'),(192,'Can view host',22,'view_host');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1200000$yhcTgde2SwmCST2axVKrZN$aFKGN6zG2Dnb9MFr/H/IvhUnT7/S7CebYrR7nRInyQQ=','2026-05-28 19:16:22.279197',1,'Salvatore','','','salvatorenapolitano051@gmail.com',1,1,'2026-05-17 22:15:33.225089');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badge`
--

DROP TABLE IF EXISTS `badge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `badge` (
  `id_badge` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `descrizione` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id_badge`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badge`
--

LOCK TABLES `badge` WRITE;
/*!40000 ALTER TABLE `badge` DISABLE KEYS */;
INSERT INTO `badge` VALUES (1,'Superhost','Host eccezionale con ottime recensioni'),(2,'Risposta Rapida','Risponde ai messaggi entro 1 ora'),(3,'Pulizia Impeccabile','Gli ospiti lodano sempre la pulizia'),(4,'Posizione Perfetta','Alloggi situati nei migliori quartieri'),(5,'Host Storico','Sulla piattaforma da più di 5 anni'),(6,'Eco-friendly','Alloggio a basso impatto ambientale'),(7,'Pet-friendly','Gli animali domestici sono sempre i benvenuti'),(8,'Novità','Nuovo host sulla piattaforma'),(9,'Guida Locale','Offre i migliori consigli sulla città'),(10,'Esperienza Top','Le sue esperienze sono le più prenotate');
/*!40000 ALTER TABLE `badge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citta`
--

DROP TABLE IF EXISTS `citta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citta` (
  `id_citta` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `nazione` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `regione` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_citta`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citta`
--

LOCK TABLES `citta` WRITE;
/*!40000 ALTER TABLE `citta` DISABLE KEYS */;
INSERT INTO `citta` VALUES (1,'Roma','Italia','Lazio'),(2,'Milano','Italia','Lombardia'),(3,'Napoli','Italia','Campania'),(4,'Torino','Italia','Piemonte'),(5,'Firenze','Italia','Toscana'),(6,'Venezia','Italia','Veneto'),(7,'Bologna','Italia','Emilia-Romagna'),(8,'Palermo','Italia','Sicilia'),(9,'Genova','Italia','Liguria'),(10,'Verona','Italia','Veneto'),(11,'Pisa','Italia','Toscana'),(12,'Siena','Italia','Toscana'),(13,'Bari','Italia','Puglia'),(14,'Catania','Italia','Sicilia'),(15,'Trieste','Italia','Friuli-Venezia Giulia'),(16,'Padova','Italia','Veneto'),(17,'Perugia','Italia','Umbria'),(18,'Lecce','Italia','Puglia'),(19,'Matera','Italia','Basilicata'),(20,'Rimini','Italia','Emilia-Romagna'),(21,'Como','Italia','Lombardia'),(22,'Lucca','Italia','Toscana'),(23,'Parma','Italia','Emilia-Romagna'),(24,'Modena','Italia','Emilia-Romagna'),(25,'Ravenna','Italia','Emilia-Romagna'),(26,'Trento','Italia','Trentino-Alto Adige'),(27,'Bolzano','Italia','Trentino-Alto Adige'),(28,'Cagliari','Italia','Sardegna'),(29,'Olbia','Italia','Sardegna'),(30,'Salerno','Italia','Campania'),(31,'Amalfi','Italia','Campania'),(32,'Assisi','Italia','Umbria'),(33,'Aosta','Italia','Valle d\'Aosta'),(34,'Bergamo','Italia','Lombardia'),(35,'Cremona','Italia','Lombardia'),(36,'Mantova','Italia','Lombardia'),(37,'Ferrara','Italia','Emilia-Romagna'),(38,'Urbino','Italia','Marche'),(39,'Ancona','Italia','Marche'),(40,'Livorno','Italia','Toscana');
/*!40000 ALTER TABLE `citta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2026-05-17 22:16:23.975022','10','Chiara Russo (chiara.russo@email.it)',2,'[{\"changed\": {\"fields\": [\"Password hash\"]}}]',34,1),(2,'2026-05-17 22:16:48.549671','1','Mario Rossi (mario.rossi@email.it)',2,'[{\"changed\": {\"fields\": [\"Password hash\"]}}]',34,1),(3,'2026-05-28 19:17:35.921126','3','Casa sul Golfo (Appartamento)',2,'[{\"changed\": {\"fields\": [\"Id host\"]}}]',8,1),(4,'2026-05-28 19:18:09.134897','5','Camera agli Uffizi (Stanza privata)',2,'[{\"changed\": {\"fields\": [\"Id host\"]}}]',8,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'core','agenzia'),(8,'core','alloggio'),(9,'core','authgroup'),(10,'core','authgrouppermissions'),(11,'core','authpermission'),(12,'core','authuser'),(13,'core','authusergroups'),(14,'core','authuseruserpermissions'),(15,'core','badge'),(16,'core','citta'),(17,'core','djangoadminlog'),(18,'core','djangocontenttype'),(19,'core','djangomigrations'),(20,'core','djangosession'),(21,'core','esperienze'),(22,'core','host'),(23,'core','lingua'),(24,'core','offre'),(25,'core','ottiene'),(26,'core','parlaagenzia'),(27,'core','parlahost'),(28,'core','prenotazionealloggio'),(29,'core','prenotazioneesperienze'),(30,'core','puntiinteresse'),(31,'core','recensionealloggio'),(32,'core','recensioneesperienze'),(33,'core','servizio'),(34,'core','utente'),(35,'core','vistaalloggiconservizi'),(36,'core','vistaclassificaalloggi'),(37,'core','vistaclassificaesperienze'),(38,'core','vistadashboardguadagniagenzia'),(39,'core','vistadashboardguadagnihost'),(40,'core','vistadettaglioprenotazioneospite'),(41,'core','vistaesploradintorni'),(42,'core','vistafatturazioneprenotazioni'),(43,'core','vistaprenotazionidarecensire'),(44,'core','vistaprofiloagenziacompleto'),(45,'core','vistaprofilohostcompleto'),(46,'core','vistaprofiloospitecrm'),(47,'core','vistastatisticheservizi'),(48,'core','vistatopdestinazioni'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-05-17 21:52:22.052145'),(2,'auth','0001_initial','2026-05-17 21:52:23.399217'),(3,'admin','0001_initial','2026-05-17 21:52:23.678029'),(4,'admin','0002_logentry_remove_auto_add','2026-05-17 21:52:23.691764'),(5,'admin','0003_logentry_add_action_flag_choices','2026-05-17 21:52:23.702753'),(6,'contenttypes','0002_remove_content_type_name','2026-05-17 21:52:23.890287'),(7,'auth','0002_alter_permission_name_max_length','2026-05-17 21:52:24.012500'),(8,'auth','0003_alter_user_email_max_length','2026-05-17 21:52:24.040971'),(9,'auth','0004_alter_user_username_opts','2026-05-17 21:52:24.050986'),(10,'auth','0005_alter_user_last_login_null','2026-05-17 21:52:24.139634'),(11,'auth','0006_require_contenttypes_0002','2026-05-17 21:52:24.146560'),(12,'auth','0007_alter_validators_add_error_messages','2026-05-17 21:52:24.157078'),(13,'auth','0008_alter_user_username_max_length','2026-05-17 21:52:24.288695'),(14,'auth','0009_alter_user_last_name_max_length','2026-05-17 21:52:24.402754'),(15,'auth','0010_alter_group_name_max_length','2026-05-17 21:52:24.428935'),(16,'auth','0011_update_proxy_permissions','2026-05-17 21:52:24.442446'),(17,'auth','0012_alter_user_first_name_max_length','2026-05-17 21:52:24.549714'),(18,'core','0001_initial','2026-05-17 21:52:24.626300'),(19,'sessions','0001_initial','2026-05-17 21:52:24.706863');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2prd3806m8xbnxfrwueox3tx2wq5xutq','.eJxVjMsOgyAURP_lro0RESkuu_cbyAWuxT4g4bFq-u-txi5czpw584ZaKBTSq4OJNf8U4otgghnTGqGBNWsfc4GppEoNaKzF65op7RowOHUG7YPCBtwdwy22NoaSVtNuk_aguZ2jo-f12J4OPGb_s0e7mEUgF8zYXhqF1DF34cRVz4xTl96NyB1bunFQVvYMnbAK1d4JOUj4fAGBIUm2:1wSgDO:E8Bm-eBIie0uPxG_hD17QbuxZm0WouKhj9D_tFq2O7U','2026-06-11 19:16:22.285942'),('pb6471gqg52ttal1gi1b2ysxvufs9xll','eyJ1dGVudGVfaWQiOjExLCJ1dGVudGVfbm9tZSI6IlNvZmlhIiwiaXNfaG9zdCI6ZmFsc2V9:1wQPZN:Y1liT9hSSvVbx3RwbhRct6t5GcIhNXFqE92FCxMh9og','2026-06-05 13:05:41.025161');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `esperienze`
--

DROP TABLE IF EXISTS `esperienze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `esperienze` (
  `id_esperienza` int NOT NULL AUTO_INCREMENT,
  `titolo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `descrizione` text COLLATE utf8mb4_general_ci,
  `prezzo` decimal(10,2) DEFAULT NULL,
  `durata` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `categoria` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `capienza_massima` int DEFAULT NULL,
  `luogo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_agenzia` int DEFAULT NULL,
  PRIMARY KEY (`id_esperienza`),
  KEY `id_agenzia` (`id_agenzia`),
  CONSTRAINT `esperienze_ibfk_1` FOREIGN KEY (`id_agenzia`) REFERENCES `agenzia` (`id_agenzia`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `esperienze`
--

LOCK TABLES `esperienze` WRITE;
/*!40000 ALTER TABLE `esperienze` DISABLE KEYS */;
INSERT INTO `esperienze` VALUES (1,'Tour del Colosseo','Visita guidata completa',45.00,'3 ore','Cultura',20,'Roma',1),(2,'Corso di Pasta','Impara a fare la pasta fresca',60.00,'4 ore','Cucina',10,'Roma',1),(3,'Giro in Navigli','Aperitivo in barca',35.00,'2 ore','Intrattenimento',15,'Milano',2),(4,'Street Food Tour','Assaggia la vera pizza fitta',40.00,'3 ore','Cibo',12,'Napoli',3),(5,'Visita Uffizi','Salta la fila al museo',50.00,'2.5 ore','Arte',8,'Firenze',4),(6,'Giro in Gondola','Tour romantico dei canali',80.00,'1 ora','Romantico',6,'Venezia',5),(7,'Degustazione Vini','Vini dell Etna',55.00,'3 ore','Degustazione',10,'Palermo',6),(8,'Caccia al Tartufo','Con cani addestrati',90.00,'4 ore','Natura',8,'Torino',7),(9,'Whale Watching','Avvistamento balene',70.00,'5 ore','Natura',30,'Genova',8),(10,'Tour di Giulietta','Sui passi di Shakespeare',30.00,'2 ore','Cultura',15,'Verona',10),(11,'Tour di Piazza dei Miracoli a Pisa','Visita guidata alla Piazza dei Miracoli con la Torre pendente, il Duomo e i principali monumenti storici di Pisa.',45.00,'2 ore','Arte e cultura',25,'Pisa',4),(12,'Corteo storico delle contrade di Siena','Esperienza nel centro storico di Siena tra tradizioni medievali, contrade, bandiere e atmosfera del Palio.',50.00,'2 ore','Tradizioni locali',30,'Siena',4),(13,'Laboratorio di orecchiette a Bari','Laboratorio gastronomico dedicato alla preparazione della pasta fresca pugliese, con dimostrazione e degustazione finale.',55.00,'2 ore','Enogastronomia',15,'Bari',3),(14,'Escursione sull’Etna da Catania','Trekking guidato sull’Etna tra paesaggi vulcanici, crateri e viste panoramiche sulla Sicilia orientale.',70.00,'4 ore','Natura e trekking',18,'Catania',6),(15,'Tour storico tra i caffè di Trieste','Passeggiata guidata nel centro di Trieste con sosta nei caffè storici e racconto della tradizione mitteleuropea.',35.00,'2 ore','Tour culturale',20,'Trieste',5),(16,'Visita guidata nel centro di Padova','Percorso tra piazze, chiese e monumenti del centro storico di Padova con guida locale.',40.00,'2 ore','Arte e cultura',25,'Padova',5),(17,'Percorso sotterraneo a Perugia','Esperienza guidata tra vicoli medievali, archi e passaggi sotterranei della città di Perugia.',38.00,'2 ore','Tour storico',18,'Perugia',1),(18,'Passeggiata barocca a Lecce','Tour nel centro storico di Lecce alla scoperta delle chiese, dei palazzi e dell’architettura barocca.',42.00,'2 ore','Arte e cultura',25,'Lecce',3),(19,'Matera by night','Visita serale dei Sassi di Matera con panorami suggestivi e racconti sulla storia della città.',45.00,'2 ore','Tour panoramico',20,'Matera',3),(20,'Bike tour sul lungomare di Rimini','Tour in bicicletta lungo il mare di Rimini, tra spiagge, parchi e scorci panoramici.',30.00,'2 ore','Sport e natura',15,'Rimini',9),(21,'Giro in barca sul Lago di Como','Esperienza in barca sul Lago di Como con vista sulle ville storiche e sui paesaggi montani.',75.00,'1 ora e 30 minuti','Escursione in barca',10,'Como',2),(22,'Bike tour sulle mura di Lucca','Percorso in bicicletta sulle mura storiche di Lucca e nei principali punti panoramici della città.',32.00,'2 ore','Sport e cultura',15,'Lucca',4),(23,'Degustazione gastronomica a Parma','Esperienza dedicata ai sapori tipici di Parma con salumi, formaggi e prodotti locali.',55.00,'2 ore','Enogastronomia',18,'Parma',9),(24,'Tour motori e sapori a Modena','Esperienza tra tradizione automobilistica, aceto balsamico e paesaggi modenesi.',70.00,'3 ore','Enogastronomia',15,'Modena',9),(25,'Visita ai mosaici di Ravenna','Tour guidato nei luoghi più importanti di Ravenna alla scoperta dei celebri mosaici bizantini.',48.00,'2 ore','Arte e cultura',25,'Ravenna',9),(26,'Tour panoramico di Trento','Passeggiata guidata nel centro di Trento con vista sulle montagne e visita ai principali monumenti.',40.00,'2 ore','Tour culturale',25,'Trento',10),(27,'Escursione sulle Dolomiti da Bolzano','Trekking panoramico tra sentieri alpini, prati e vedute spettacolari sulle Dolomiti.',65.00,'4 ore','Natura e trekking',12,'Bolzano',10),(28,'Passeggiata al tramonto a Cagliari','Tour panoramico lungo la costa di Cagliari con vista sul mare e sui punti più suggestivi della città.',38.00,'2 ore','Tour panoramico',20,'Cagliari',6),(29,'Snorkeling nelle acque di Olbia','Esperienza di snorkeling in acque cristalline con guida e osservazione dei fondali marini.',60.00,'3 ore','Mare e natura',12,'Olbia',6),(30,'Passeggiata serale a Salerno','Tour sul lungomare di Salerno tra luci, panorama marino e atmosfera serale.',35.00,'2 ore','Tour serale',25,'Salerno',3),(31,'Tour in barca ad Amalfi','Escursione in barca lungo la Costiera Amalfitana con vista su borghi, scogliere e mare cristallino.',85.00,'2 ore','Escursione in barca',10,'Amalfi',3),(32,'Tour spirituale ad Assisi','Visita guidata nel centro storico di Assisi tra basiliche, vicoli medievali e luoghi francescani.',45.00,'2 ore','Tour religioso',25,'Assisi',1),(33,'Visita panoramica ad Aosta','Tour del centro storico di Aosta con vista sulle montagne e sui monumenti di epoca romana.',42.00,'2 ore','Tour culturale',20,'Aosta',7),(34,'Passeggiata medievale a Bergamo Alta','Percorso guidato tra vicoli, piazze e scorci storici della Città Alta di Bergamo.',40.00,'2 ore','Tour storico',25,'Bergamo',2),(35,'Laboratorio di liuteria a Cremona','Esperienza in bottega alla scoperta della tradizione dei violini e dell’artigianato cremonese.',60.00,'2 ore','Artigianato',12,'Cremona',2),(36,'Tour artistico di Mantova','Visita guidata nel centro storico di Mantova tra palazzi, piazze e architetture rinascimentali.',42.00,'2 ore','Arte e cultura',25,'Mantova',10),(37,'Ferrara in bicicletta','Tour in bici nel centro storico di Ferrara tra strade medievali, palazzi e mura cittadine.',32.00,'2 ore','Sport e cultura',15,'Ferrara',9),(38,'Visita culturale a Urbino','Tour guidato nella città rinascimentale di Urbino, tra panorami collinari e luoghi d’arte.',45.00,'2 ore','Arte e cultura',20,'Urbino',4),(39,'Tour panoramico di Ancona','Passeggiata guidata tra porto, belvederi e scorci sul mare della città di Ancona.',38.00,'2 ore','Tour panoramico',20,'Ancona',8),(40,'Giro in barca nei canali di Livorno','Esperienza in barca nei canali storici del quartiere Venezia di Livorno.',50.00,'1 ora e 30 minuti','Escursione in barca',12,'Livorno',4);
/*!40000 ALTER TABLE `esperienze` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `host` (
  `id_host` int NOT NULL,
  `descrizione_profilo` text COLLATE utf8mb4_general_ci,
  `data_attivazione` date DEFAULT NULL,
  PRIMARY KEY (`id_host`),
  CONSTRAINT `host_ibfk_1` FOREIGN KEY (`id_host`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host`
--

LOCK TABLES `host` WRITE;
/*!40000 ALTER TABLE `host` DISABLE KEYS */;
INSERT INTO `host` VALUES (1,'Amo viaggiare e ospitare persone','2025-01-11'),(2,'Appassionata di design e arredamento','2025-01-16'),(3,'Sempre disponibile per i miei ospiti','2025-02-21'),(4,'Adoro condividere la mia cultura','2025-03-06'),(5,'Esperto di cucina locale','2025-03-13'),(6,'Host professionista dal 2015','2025-04-19'),(7,'Gestisco splendide ville al mare','2025-05-23'),(8,'Mi piace fare nuove amicizie','2025-07-01'),(9,'Attento ai dettagli e alla pulizia','2025-07-15'),(10,'Offro soggiorni indimenticabili','2025-08-02');
/*!40000 ALTER TABLE `host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lingua`
--

DROP TABLE IF EXISTS `lingua`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lingua` (
  `id_lingua` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_lingua`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lingua`
--

LOCK TABLES `lingua` WRITE;
/*!40000 ALTER TABLE `lingua` DISABLE KEYS */;
INSERT INTO `lingua` VALUES (8,'Arabo'),(7,'Cinese'),(4,'Francese'),(6,'Giapponese'),(2,'Inglese'),(1,'Italiano'),(9,'Portoghese'),(10,'Russo'),(3,'Spagnolo'),(5,'Tedesco');
/*!40000 ALTER TABLE `lingua` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offre`
--

DROP TABLE IF EXISTS `offre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offre` (
  `id_alloggio` int NOT NULL,
  `id_servizio` int NOT NULL,
  PRIMARY KEY (`id_alloggio`,`id_servizio`),
  KEY `id_servizio` (`id_servizio`),
  CONSTRAINT `offre_ibfk_1` FOREIGN KEY (`id_alloggio`) REFERENCES `alloggio` (`id_alloggio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `offre_ibfk_2` FOREIGN KEY (`id_servizio`) REFERENCES `servizio` (`id_servizio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offre`
--

LOCK TABLES `offre` WRITE;
/*!40000 ALTER TABLE `offre` DISABLE KEYS */;
INSERT INTO `offre` VALUES (1,1),(2,1),(4,1),(5,1),(7,1),(1,2),(3,3),(9,3),(6,5),(8,5);
/*!40000 ALTER TABLE `offre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ottiene`
--

DROP TABLE IF EXISTS `ottiene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ottiene` (
  `id_host` int NOT NULL,
  `id_badge` int NOT NULL,
  `data_ottenimento` date DEFAULT NULL,
  PRIMARY KEY (`id_host`,`id_badge`),
  KEY `id_badge` (`id_badge`),
  CONSTRAINT `ottiene_ibfk_1` FOREIGN KEY (`id_host`) REFERENCES `host` (`id_host`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ottiene_ibfk_2` FOREIGN KEY (`id_badge`) REFERENCES `badge` (`id_badge`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ottiene`
--

LOCK TABLES `ottiene` WRITE;
/*!40000 ALTER TABLE `ottiene` DISABLE KEYS */;
INSERT INTO `ottiene` VALUES (1,1,'2025-06-01'),(2,2,'2025-07-01'),(3,3,'2025-08-01'),(4,4,'2025-09-01'),(5,5,'2025-10-01'),(6,6,'2025-11-01'),(7,7,'2025-12-01'),(8,8,'2026-01-01'),(9,9,'2026-02-01'),(10,10,'2026-03-01');
/*!40000 ALTER TABLE `ottiene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parla_agenzia`
--

DROP TABLE IF EXISTS `parla_agenzia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parla_agenzia` (
  `id_agenzia` int NOT NULL,
  `id_lingua` int NOT NULL,
  PRIMARY KEY (`id_agenzia`,`id_lingua`),
  KEY `id_lingua` (`id_lingua`),
  CONSTRAINT `parla_agenzia_ibfk_1` FOREIGN KEY (`id_agenzia`) REFERENCES `agenzia` (`id_agenzia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parla_agenzia_ibfk_2` FOREIGN KEY (`id_lingua`) REFERENCES `lingua` (`id_lingua`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parla_agenzia`
--

LOCK TABLES `parla_agenzia` WRITE;
/*!40000 ALTER TABLE `parla_agenzia` DISABLE KEYS */;
INSERT INTO `parla_agenzia` VALUES (1,1),(3,1),(7,1),(1,2),(2,2),(6,2),(8,2),(9,3),(4,4),(5,5);
/*!40000 ALTER TABLE `parla_agenzia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parla_host`
--

DROP TABLE IF EXISTS `parla_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parla_host` (
  `id_host` int NOT NULL,
  `id_lingua` int NOT NULL,
  PRIMARY KEY (`id_host`,`id_lingua`),
  KEY `id_lingua` (`id_lingua`),
  CONSTRAINT `parla_host_ibfk_1` FOREIGN KEY (`id_host`) REFERENCES `host` (`id_host`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parla_host_ibfk_2` FOREIGN KEY (`id_lingua`) REFERENCES `lingua` (`id_lingua`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parla_host`
--

LOCK TABLES `parla_host` WRITE;
/*!40000 ALTER TABLE `parla_host` DISABLE KEYS */;
INSERT INTO `parla_host` VALUES (1,1),(5,1),(8,1),(1,2),(2,2),(6,2),(9,2),(3,3),(4,4),(7,5);
/*!40000 ALTER TABLE `parla_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prenotazione_alloggio`
--

DROP TABLE IF EXISTS `prenotazione_alloggio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenotazione_alloggio` (
  `id_prenotazione` int NOT NULL AUTO_INCREMENT,
  `data_prenotazione` date DEFAULT NULL,
  `check_in` date DEFAULT NULL,
  `check_out` date DEFAULT NULL,
  `numero_ospiti` int DEFAULT NULL,
  `prezzo_totale` decimal(10,2) DEFAULT NULL,
  `stato` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `codice_conferma` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_utente` int DEFAULT NULL,
  `id_alloggio` int DEFAULT NULL,
  PRIMARY KEY (`id_prenotazione`),
  UNIQUE KEY `codice_conferma` (`codice_conferma`),
  KEY `id_utente` (`id_utente`),
  KEY `id_alloggio` (`id_alloggio`),
  CONSTRAINT `prenotazione_alloggio_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `prenotazione_alloggio_ibfk_2` FOREIGN KEY (`id_alloggio`) REFERENCES `alloggio` (`id_alloggio`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenotazione_alloggio`
--

LOCK TABLES `prenotazione_alloggio` WRITE;
/*!40000 ALTER TABLE `prenotazione_alloggio` DISABLE KEYS */;
INSERT INTO `prenotazione_alloggio` VALUES (1,'2025-10-01','2025-11-01','2025-11-05',2,600.00,'Completata','BKNG-2026-398DF1',2,1),(2,'2025-10-05','2025-11-10','2025-11-12',1,240.00,'Completata','BKNG-2026-CC5174',3,2),(3,'2025-10-10','2025-12-01','2025-12-07',4,540.00,'Completata','BKNG-2026-778AAD',4,3),(4,'2025-11-01','2025-12-15','2025-12-20',2,425.00,'Completata','BKNG-2026-2F7530',5,4),(5,'2025-11-15','2026-01-05','2026-01-08',2,210.00,'Completata','BKNG-2026-539351',6,5),(6,'2025-12-01','2026-01-10','2026-01-15',5,1250.00,'Completata','BKNG-2026-E3DE1A',7,6),(7,'2025-12-10','2026-02-01','2026-02-28',1,1080.00,'Completata','BKNG-2026-C04290',8,7),(8,'2026-01-05','2026-02-10','2026-02-17',8,2100.00,'Completata','BKNG-2026-CF78C2',9,8),(9,'2026-01-20','2026-03-01','2026-03-05',3,380.00,'Completata','BKNG-2026-2C4035',10,9),(10,'2026-02-01','2026-03-10','2026-03-12',2,220.00,'Completata','BKNG-2026-042EF0',1,10),(11,'2026-05-18','2026-05-18','2026-05-19',3,150.00,'Confermata','FD06C517',1,1),(12,'2026-05-18','2026-07-15','2026-07-25',4,900.00,'Confermata','D3223397',11,3),(13,'2026-05-22','2026-05-25','2026-05-27',3,300.00,'Confermata','010B7F76',11,1);
/*!40000 ALTER TABLE `prenotazione_alloggio` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Calcolo_Prezzo_Totale_Alloggio` BEFORE INSERT ON `prenotazione_alloggio` FOR EACH ROW BEGIN
    DECLARE prezzo_giornaliero DECIMAL(10,2);
    DECLARE giorni INT;

    
    SELECT prezzo_notte INTO prezzo_giornaliero
    FROM alloggio
    WHERE id_alloggio = NEW.id_alloggio;

    
    SET giorni = DATEDIFF(NEW.check_out, NEW.check_in);

    IF giorni > 0 THEN
        SET NEW.prezzo_totale = prezzo_giornaliero * giorni;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il check-out deve essere successivo al check-in.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Controllo_Capienza_Alloggio` BEFORE INSERT ON `prenotazione_alloggio` FOR EACH ROW BEGIN
    DECLARE capienza_max INT;

    
    SELECT capienza INTO capienza_max
    FROM alloggio
    WHERE id_alloggio = NEW.id_alloggio;

    
    IF NEW.numero_ospiti > capienza_max THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il numero di ospiti supera la capienza massima di questo alloggio.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Controllo_Date_Sensate_Alloggio` BEFORE INSERT ON `prenotazione_alloggio` FOR EACH ROW BEGIN
    
    IF NEW.check_in < NEW.data_prenotazione THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: La data di check-in non può essere nel passato rispetto alla data di prenotazione.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Generazione_Codice_Conferma` BEFORE INSERT ON `prenotazione_alloggio` FOR EACH ROW BEGIN
    
    IF NEW.codice_conferma IS NULL OR NEW.codice_conferma = '' THEN
        
        SET NEW.codice_conferma = CONCAT('BKNG-', DATE_FORMAT(NOW(), '%Y'), '-', UPPER(SUBSTRING(MD5(RAND()), 1, 6)));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Prevenzione_Sovrapposizione_Date` BEFORE INSERT ON `prenotazione_alloggio` FOR EACH ROW BEGIN
    DECLARE conteggio INT;

    
    SELECT COUNT(*) INTO conteggio
    FROM prenotazione_alloggio
    WHERE id_alloggio = NEW.id_alloggio
      AND stato = 'Confermata'
      AND (NEW.check_in < check_out AND NEW.check_out > check_in);

    IF conteggio > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: L''alloggio è già prenotato per queste date.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `prenotazione_esperienze`
--

DROP TABLE IF EXISTS `prenotazione_esperienze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenotazione_esperienze` (
  `id_prenotazione_esperienza` int NOT NULL AUTO_INCREMENT,
  `data_prenotazione` date DEFAULT NULL,
  `data_esperienza` date DEFAULT NULL,
  `numero_partecipanti` int DEFAULT NULL,
  `prezzo_totale` decimal(10,2) DEFAULT NULL,
  `stato` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_utente` int DEFAULT NULL,
  `id_esperienza` int DEFAULT NULL,
  PRIMARY KEY (`id_prenotazione_esperienza`),
  KEY `id_utente` (`id_utente`),
  KEY `id_esperienza` (`id_esperienza`),
  CONSTRAINT `prenotazione_esperienze_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `prenotazione_esperienze_ibfk_2` FOREIGN KEY (`id_esperienza`) REFERENCES `esperienze` (`id_esperienza`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenotazione_esperienze`
--

LOCK TABLES `prenotazione_esperienze` WRITE;
/*!40000 ALTER TABLE `prenotazione_esperienze` DISABLE KEYS */;
INSERT INTO `prenotazione_esperienze` VALUES (1,'2025-10-01','2025-11-02',2,90.00,'Completata',2,1),(2,'2025-10-05','2025-11-11',1,60.00,'Completata',3,2),(3,'2025-10-10','2025-12-02',4,140.00,'Completata',4,3),(4,'2025-11-01','2025-12-16',2,80.00,'Completata',5,4),(5,'2025-11-15','2026-01-06',2,100.00,'Completata',6,5),(6,'2025-12-01','2026-01-11',2,160.00,'Completata',7,6),(7,'2025-12-10','2026-02-05',1,55.00,'Completata',8,7),(8,'2026-01-05','2026-02-12',4,360.00,'Completata',9,8),(9,'2026-01-20','2026-03-02',3,210.00,'Completata',10,9),(10,'2026-02-01','2026-03-11',2,60.00,'Completata',1,10),(11,'2026-05-18','2026-05-19',2,90.00,'Confermata',1,1),(12,'2026-05-18','2026-07-20',4,160.00,'Confermata',11,4);
/*!40000 ALTER TABLE `prenotazione_esperienze` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Calcolo_Prezzo_Totale_Esperienza` BEFORE INSERT ON `prenotazione_esperienze` FOR EACH ROW BEGIN
    DECLARE costo_singolo DECIMAL(10,2);

    
    SELECT prezzo INTO costo_singolo
    FROM esperienze
    WHERE id_esperienza = NEW.id_esperienza;

    
    SET NEW.prezzo_totale = costo_singolo * NEW.numero_partecipanti;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Controllo_Capienza_Esperienza` BEFORE INSERT ON `prenotazione_esperienze` FOR EACH ROW BEGIN
    DECLARE capienza_max_esp INT;

    
    SELECT capienza_massima INTO capienza_max_esp
    FROM esperienze
    WHERE id_esperienza = NEW.id_esperienza;

    
    IF NEW.numero_partecipanti > capienza_max_esp THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il numero di partecipanti supera la capienza massima prevista per questa esperienza.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Controllo_Date_Sensate_Esperienza` BEFORE INSERT ON `prenotazione_esperienze` FOR EACH ROW BEGIN
    
    IF NEW.data_esperienza < NEW.data_prenotazione THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: La data dell''esperienza non può essere nel passato rispetto alla data di prenotazione.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `punti_interesse`
--

DROP TABLE IF EXISTS `punti_interesse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `punti_interesse` (
  `id_punto_interesse` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `descrizione` text COLLATE utf8mb4_general_ci,
  `categoria` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_citta` int DEFAULT NULL,
  PRIMARY KEY (`id_punto_interesse`),
  KEY `id_citta` (`id_citta`),
  CONSTRAINT `punti_interesse_ibfk_1` FOREIGN KEY (`id_citta`) REFERENCES `citta` (`id_citta`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `punti_interesse`
--

LOCK TABLES `punti_interesse` WRITE;
/*!40000 ALTER TABLE `punti_interesse` DISABLE KEYS */;
INSERT INTO `punti_interesse` VALUES (1,'Colosseo','Anfiteatro romano','Monumento',1),(2,'Duomo di Milano','Cattedrale gotica','Monumento',2),(3,'Maschio Angioino','Castello storico','Monumento',3),(4,'Mole Antonelliana','Simbolo di Torino','Monumento',4),(5,'Uffizi','Galleria d arte','Museo',5),(6,'Piazza San Marco','Piazza principale','Piazza',6),(7,'Torri degli Asinelli','Torre medievale','Monumento',7),(8,'Teatro Massimo','Teatro storico','Teatro',8),(9,'Acquario di Genova','Grande acquario','Attrazione',9),(10,'Arena di Verona','Anfiteatro romano','Monumento',10);
/*!40000 ALTER TABLE `punti_interesse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recensione_alloggio`
--

DROP TABLE IF EXISTS `recensione_alloggio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recensione_alloggio` (
  `id_recensione` int NOT NULL AUTO_INCREMENT,
  `voto` int DEFAULT NULL,
  `commento` text COLLATE utf8mb4_general_ci,
  `data_recensione` date DEFAULT NULL,
  `id_prenotazione` int DEFAULT NULL,
  PRIMARY KEY (`id_recensione`),
  UNIQUE KEY `id_prenotazione` (`id_prenotazione`),
  CONSTRAINT `recensione_alloggio_ibfk_1` FOREIGN KEY (`id_prenotazione`) REFERENCES `prenotazione_alloggio` (`id_prenotazione`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recensione_alloggio`
--

LOCK TABLES `recensione_alloggio` WRITE;
/*!40000 ALTER TABLE `recensione_alloggio` DISABLE KEYS */;
INSERT INTO `recensione_alloggio` VALUES (1,5,'Vista mozzafiato, perfetto!','2025-11-06',1),(2,4,'Molto carino ma rumoroso','2025-11-13',2),(3,5,'Casa enorme e pulita','2025-12-08',3),(4,5,'Accoglienza fantastica','2025-12-21',4),(5,3,'Ok ma manca la tv','2026-01-09',5),(6,5,'Un sogno veneziano','2026-01-16',6),(7,4,'Ottimo rapporto qualità prezzo','2026-03-01',7),(8,5,'Piscina meravigliosa','2026-02-18',8),(9,4,'Posizione comoda','2026-03-06',9),(10,5,'Weekend super romantico','2026-03-13',10);
/*!40000 ALTER TABLE `recensione_alloggio` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Controllo_Voto_Alloggio` BEFORE INSERT ON `recensione_alloggio` FOR EACH ROW BEGIN
    
    IF NEW.voto < 1 OR NEW.voto > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il voto della recensione alloggio deve essere un numero compreso tra 1 e 5.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Recensione_Solo_Dopo_Checkout` BEFORE INSERT ON `recensione_alloggio` FOR EACH ROW BEGIN
    DECLARE data_fine_soggiorno DATE;

    
    SELECT check_out INTO data_fine_soggiorno
    FROM prenotazione_alloggio
    WHERE id_prenotazione = NEW.id_prenotazione;

    
    IF NEW.data_recensione <= data_fine_soggiorno THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Puoi recensire l''alloggio solo DOPO aver fatto il check-out.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `recensione_esperienze`
--

DROP TABLE IF EXISTS `recensione_esperienze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recensione_esperienze` (
  `id_recensione_esperienza` int NOT NULL AUTO_INCREMENT,
  `voto` int DEFAULT NULL,
  `commento` text COLLATE utf8mb4_general_ci,
  `data_recensione` date DEFAULT NULL,
  `id_prenotazione_esperienza` int DEFAULT NULL,
  PRIMARY KEY (`id_recensione_esperienza`),
  UNIQUE KEY `id_prenotazione_esperienza` (`id_prenotazione_esperienza`),
  CONSTRAINT `recensione_esperienze_ibfk_1` FOREIGN KEY (`id_prenotazione_esperienza`) REFERENCES `prenotazione_esperienze` (`id_prenotazione_esperienza`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recensione_esperienze`
--

LOCK TABLES `recensione_esperienze` WRITE;
/*!40000 ALTER TABLE `recensione_esperienze` DISABLE KEYS */;
INSERT INTO `recensione_esperienze` VALUES (1,5,'Guida preparatissima','2025-11-03',1),(2,4,'Divertente e gustoso','2025-11-12',2),(3,5,'Ottimo aperitivo','2025-12-03',3),(4,5,'Cibo delizioso!','2025-12-17',4),(5,4,'Molta fila, ma bello','2026-01-07',5),(6,5,'Da fare una volta nella vita','2026-01-12',6),(7,5,'Vini eccellenti','2026-02-06',7),(8,4,'I cani erano bravissimi','2026-02-13',8),(9,5,'Viste tantissime balene!','2026-03-03',9),(10,5,'Tour molto interessante','2026-03-12',10);
/*!40000 ALTER TABLE `recensione_esperienze` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Controllo_Voto_Esperienza` BEFORE INSERT ON `recensione_esperienze` FOR EACH ROW BEGIN
    
    IF NEW.voto < 1 OR NEW.voto > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il voto dell''esperienza deve essere un numero compreso tra 1 e 5.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `servizio`
--

DROP TABLE IF EXISTS `servizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servizio` (
  `id_servizio` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `descrizione` text COLLATE utf8mb4_general_ci,
  `categoria` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_servizio`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servizio`
--

LOCK TABLES `servizio` WRITE;
/*!40000 ALTER TABLE `servizio` DISABLE KEYS */;
INSERT INTO `servizio` VALUES (1,'Wi-Fi','Connessione internet veloce','Essenziali'),(2,'Aria Condizionata','Climatizzatore freddo/caldo','Comfort'),(3,'Cucina','Cucina completamente attrezzata','Essenziali'),(4,'Parcheggio','Posto auto privato','Trasporti'),(5,'Piscina','Piscina privata o condivisa','Lusso'),(6,'Lavatrice','Lavatrice in casa','Essenziali'),(7,'TV','Smart TV con Netflix','Intrattenimento'),(8,'Ascensore','Ascensore nel palazzo','Accessibilità'),(9,'Colazione','Colazione inclusa nel prezzo','Cibo'),(10,'Idromassaggio','Vasca idromassaggio','Lusso');
/*!40000 ALTER TABLE `servizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `id_utente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `cognome` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_registrazione` date DEFAULT NULL,
  PRIMARY KEY (`id_utente`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES (1,'Mario','Rossi','mario.rossi@email.it','pbkdf2_sha256$1200000$NHyU4OPd7b5rtB5hTKDumP$WdnqolzzI/E6SXvQEb1yFzr+/7HFTSYub7ZJK2doNjM=','+39 3331234567','2025-01-10'),(2,'Giulia','Bianchi','giulia.b@email.it','pbkdf2_sha256$1200000$wuMi2XXIhhNbkHrV0ONrd8$SWN+Zk+uU6CFBYsRYQIfzwKmA/gWU8GQfkOUYUVL+N0=','+39 3332345678','2025-01-15'),(3,'Luca','Verdi','luca.verdi@email.it','pbkdf2_sha256$1200000$hfccl1uudcEwyavmyMnyJ0$42Ih8MX0xlSNVbFolNyq1Ac3PEn+kkw4mlLX9nYXUwE=','+39 3333456789','2025-02-20'),(4,'Anna','Neri','anna.neri@email.it','pbkdf2_sha256$1200000$ZqArSiawu8NXFUqdGYiSs4$7p2W6+rzyvRS0KquAICFa0figCX1pyPGhBMBIuZh300=','+39 3334567890','2025-03-05'),(5,'Paolo','Gialli','paolo.g@email.it','pbkdf2_sha256$1200000$s9StNj0I3znTcaHeIi8H4n$i9LiFh55bVVyNGYaU7CkmaOPnskl0m507E2LdIFCVdg=','+39 3335678901','2025-03-12'),(6,'Elena','Marrone','elena.m@email.it','pbkdf2_sha256$1200000$aFUtq8N9SbmjaB82caoPqn$0p+kHi2FSJzvTfS1UFJnm2I+wMDw76M7k7bNVsoHQLw=','+39 3336789012','2025-04-18'),(7,'Marco','Viola','marco.v@email.it','pbkdf2_sha256$1200000$Bdt9PiPD2t3HS0g2DgnZRJ$2lJ5H8wK5CQx2btQ1Y+KMIzKSiLTLRjQJFewN2fiNuE=','+39 3337890123','2025-05-22'),(8,'Sara','Blu','sara.blu@email.it','pbkdf2_sha256$1200000$DxRGNX3sJQbWfKt1K4u1QP$EhJgN453pEKNLJep+WOlIIUvCpgtdOgkztA1XYcPCwQ=','+39 3338901234','2025-06-30'),(9,'Davide','Gallo','davide.gallo@email.it','pbkdf2_sha256$1200000$zo7xzB5t4JUFG6BxrtoXuZ$6xLAu2vs7BDf3lgjae87VglGyFCZv1hn+FohD+xc4Mg=','+39 3339012345','2025-07-14'),(10,'Chiara','Russo','chiara.russo@email.it','pbkdf2_sha256$1200000$TBm0tzRE1mrt1RV35yJ0Pe$AOOma5HcJHR/yBkHopSG6qDFPCkuTiTIAU5Tb20Jb2g=','+39 3330123456','2025-08-01'),(11,'Sofia','Casati','sofiacasati@gmail.com','pbkdf2_sha256$1200000$n1PKSEA3lL3Sa5dmTf3fil$nfaSilubdcnql9GtSQlaJzKjrczsX8SgwmdYUgPEPrc=','3759184571','2026-05-18');
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sasa`@`localhost`*/ /*!50003 TRIGGER `Trigger_Integrita_Dati_Utente` BEFORE INSERT ON `utente` FOR EACH ROW BEGIN
    
    IF NEW.email NOT LIKE '%_@__%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Formato email non valido. Inserisci un indirizzo corretto (es. nome@dominio.it).';
    END IF;

    
    IF NEW.telefono IS NOT NULL AND NEW.telefono NOT REGEXP '^[+0-9 ]+$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il numero di telefono può contenere solo numeri, spazi e il simbolo +.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vista_alloggi_con_servizi`
--

DROP TABLE IF EXISTS `vista_alloggi_con_servizi`;
/*!50001 DROP VIEW IF EXISTS `vista_alloggi_con_servizi`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_alloggi_con_servizi` AS SELECT 
 1 AS `id_alloggio`,
 1 AS `titolo`,
 1 AS `prezzo_notte`,
 1 AS `tipo_alloggio`,
 1 AS `id_citta`,
 1 AS `servizi_offerti`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_classifica_alloggi`
--

DROP TABLE IF EXISTS `vista_classifica_alloggi`;
/*!50001 DROP VIEW IF EXISTS `vista_classifica_alloggi`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_classifica_alloggi` AS SELECT 
 1 AS `id_alloggio`,
 1 AS `titolo`,
 1 AS `tipo_alloggio`,
 1 AS `citta`,
 1 AS `media_voti`,
 1 AS `numero_recensioni`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_classifica_esperienze`
--

DROP TABLE IF EXISTS `vista_classifica_esperienze`;
/*!50001 DROP VIEW IF EXISTS `vista_classifica_esperienze`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_classifica_esperienze` AS SELECT 
 1 AS `id_esperienza`,
 1 AS `titolo`,
 1 AS `categoria`,
 1 AS `media_voti`,
 1 AS `numero_recensioni`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_dashboard_guadagni_agenzia`
--

DROP TABLE IF EXISTS `vista_dashboard_guadagni_agenzia`;
/*!50001 DROP VIEW IF EXISTS `vista_dashboard_guadagni_agenzia`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_dashboard_guadagni_agenzia` AS SELECT 
 1 AS `id_agenzia`,
 1 AS `nome_agenzia`,
 1 AS `numero_prenotazioni_totali`,
 1 AS `totale_guadagnato_euro`,
 1 AS `totale_partecipanti`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_dashboard_guadagni_host`
--

DROP TABLE IF EXISTS `vista_dashboard_guadagni_host`;
/*!50001 DROP VIEW IF EXISTS `vista_dashboard_guadagni_host`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_dashboard_guadagni_host` AS SELECT 
 1 AS `id_host`,
 1 AS `nome`,
 1 AS `cognome`,
 1 AS `numero_prenotazioni_totali`,
 1 AS `totale_guadagnato_euro`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_dettaglio_prenotazione_ospite`
--

DROP TABLE IF EXISTS `vista_dettaglio_prenotazione_ospite`;
/*!50001 DROP VIEW IF EXISTS `vista_dettaglio_prenotazione_ospite`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_dettaglio_prenotazione_ospite` AS SELECT 
 1 AS `id_prenotazione`,
 1 AS `ospite_id`,
 1 AS `nome_alloggio`,
 1 AS `citta_alloggio`,
 1 AS `check_in`,
 1 AS `check_out`,
 1 AS `prezzo_totale`,
 1 AS `stato`,
 1 AS `codice_conferma`,
 1 AS `nome_host`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_esplora_dintorni`
--

DROP TABLE IF EXISTS `vista_esplora_dintorni`;
/*!50001 DROP VIEW IF EXISTS `vista_esplora_dintorni`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_esplora_dintorni` AS SELECT 
 1 AS `id_alloggio`,
 1 AS `nome_alloggio`,
 1 AS `citta`,
 1 AS `punto_interesse`,
 1 AS `categoria`,
 1 AS `descrizione`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_fatturazione_prenotazioni`
--

DROP TABLE IF EXISTS `vista_fatturazione_prenotazioni`;
/*!50001 DROP VIEW IF EXISTS `vista_fatturazione_prenotazioni`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_fatturazione_prenotazioni` AS SELECT 
 1 AS `id_prenotazione`,
 1 AS `codice_conferma`,
 1 AS `data_prenotazione`,
 1 AS `nome_ospite`,
 1 AS `cognome_ospite`,
 1 AS `alloggio_prenotato`,
 1 AS `nome_host_proprietario`,
 1 AS `cognome_host_proprietario`,
 1 AS `prezzo_totale`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_prenotazioni_da_recensire`
--

DROP TABLE IF EXISTS `vista_prenotazioni_da_recensire`;
/*!50001 DROP VIEW IF EXISTS `vista_prenotazioni_da_recensire`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_prenotazioni_da_recensire` AS SELECT 
 1 AS `id_prenotazione`,
 1 AS `codice_conferma`,
 1 AS `nome_ospite`,
 1 AS `email_ospite`,
 1 AS `nome_alloggio`,
 1 AS `check_out`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_profilo_agenzia_completo`
--

DROP TABLE IF EXISTS `vista_profilo_agenzia_completo`;
/*!50001 DROP VIEW IF EXISTS `vista_profilo_agenzia_completo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_profilo_agenzia_completo` AS SELECT 
 1 AS `id_agenzia`,
 1 AS `nome`,
 1 AS `email`,
 1 AS `telefono`,
 1 AS `lingue_parlate`,
 1 AS `numero_esperienze_offerte`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_profilo_host_completo`
--

DROP TABLE IF EXISTS `vista_profilo_host_completo`;
/*!50001 DROP VIEW IF EXISTS `vista_profilo_host_completo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_profilo_host_completo` AS SELECT 
 1 AS `id_utente`,
 1 AS `nome`,
 1 AS `cognome`,
 1 AS `descrizione_profilo`,
 1 AS `data_attivazione`,
 1 AS `lingue_parlate`,
 1 AS `badge_ottenuti`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_profilo_ospite_crm`
--

DROP TABLE IF EXISTS `vista_profilo_ospite_crm`;
/*!50001 DROP VIEW IF EXISTS `vista_profilo_ospite_crm`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_profilo_ospite_crm` AS SELECT 
 1 AS `id_utente`,
 1 AS `nome`,
 1 AS `cognome`,
 1 AS `email`,
 1 AS `soggiorni_effettuati`,
 1 AS `esperienze_svolte`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_statistiche_servizi`
--

DROP TABLE IF EXISTS `vista_statistiche_servizi`;
/*!50001 DROP VIEW IF EXISTS `vista_statistiche_servizi`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_statistiche_servizi` AS SELECT 
 1 AS `id_servizio`,
 1 AS `nome_servizio`,
 1 AS `categoria`,
 1 AS `numero_alloggi_che_lo_offrono`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_top_destinazioni`
--

DROP TABLE IF EXISTS `vista_top_destinazioni`;
/*!50001 DROP VIEW IF EXISTS `vista_top_destinazioni`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_top_destinazioni` AS SELECT 
 1 AS `id_citta`,
 1 AS `citta`,
 1 AS `nazione`,
 1 AS `numero_alloggi_disponibili`,
 1 AS `numero_prenotazioni_totali`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vista_alloggi_con_servizi`
--

/*!50001 DROP VIEW IF EXISTS `vista_alloggi_con_servizi`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_alloggi_con_servizi` AS select `a`.`id_alloggio` AS `id_alloggio`,`a`.`titolo` AS `titolo`,`a`.`prezzo_notte` AS `prezzo_notte`,`a`.`tipo_alloggio` AS `tipo_alloggio`,`a`.`id_citta` AS `id_citta`,group_concat(`s`.`nome` separator ', ') AS `servizi_offerti` from ((`alloggio` `a` left join `offre` `o` on((`a`.`id_alloggio` = `o`.`id_alloggio`))) left join `servizio` `s` on((`o`.`id_servizio` = `s`.`id_servizio`))) group by `a`.`id_alloggio` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_classifica_alloggi`
--

/*!50001 DROP VIEW IF EXISTS `vista_classifica_alloggi`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_classifica_alloggi` AS select `a`.`id_alloggio` AS `id_alloggio`,`a`.`titolo` AS `titolo`,`a`.`tipo_alloggio` AS `tipo_alloggio`,`c`.`nome` AS `citta`,round(avg(`r`.`voto`),1) AS `media_voti`,count(`r`.`id_recensione`) AS `numero_recensioni` from (((`alloggio` `a` join `citta` `c` on((`a`.`id_citta` = `c`.`id_citta`))) left join `prenotazione_alloggio` `p` on((`a`.`id_alloggio` = `p`.`id_alloggio`))) left join `recensione_alloggio` `r` on((`p`.`id_prenotazione` = `r`.`id_prenotazione`))) group by `a`.`id_alloggio` order by round(avg(`r`.`voto`),1) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_classifica_esperienze`
--

/*!50001 DROP VIEW IF EXISTS `vista_classifica_esperienze`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_classifica_esperienze` AS select `e`.`id_esperienza` AS `id_esperienza`,`e`.`titolo` AS `titolo`,`e`.`categoria` AS `categoria`,round(avg(`r`.`voto`),1) AS `media_voti`,count(`r`.`id_recensione_esperienza`) AS `numero_recensioni` from ((`esperienze` `e` left join `prenotazione_esperienze` `pe` on((`e`.`id_esperienza` = `pe`.`id_esperienza`))) left join `recensione_esperienze` `r` on((`pe`.`id_prenotazione_esperienza` = `r`.`id_prenotazione_esperienza`))) group by `e`.`id_esperienza` order by round(avg(`r`.`voto`),1) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_dashboard_guadagni_agenzia`
--

/*!50001 DROP VIEW IF EXISTS `vista_dashboard_guadagni_agenzia`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_dashboard_guadagni_agenzia` AS select `ag`.`id_agenzia` AS `id_agenzia`,`ag`.`nome` AS `nome_agenzia`,count(`pe`.`id_prenotazione_esperienza`) AS `numero_prenotazioni_totali`,sum(`pe`.`prezzo_totale`) AS `totale_guadagnato_euro`,sum(`pe`.`numero_partecipanti`) AS `totale_partecipanti` from ((`agenzia` `ag` join `esperienze` `e` on((`ag`.`id_agenzia` = `e`.`id_agenzia`))) join `prenotazione_esperienze` `pe` on((`e`.`id_esperienza` = `pe`.`id_esperienza`))) where ((`pe`.`stato` = 'Confermata') or (`pe`.`stato` = 'Completata')) group by `ag`.`id_agenzia` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_dashboard_guadagni_host`
--

/*!50001 DROP VIEW IF EXISTS `vista_dashboard_guadagni_host`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_dashboard_guadagni_host` AS select `h`.`id_host` AS `id_host`,`u`.`nome` AS `nome`,`u`.`cognome` AS `cognome`,count(`p`.`id_prenotazione`) AS `numero_prenotazioni_totali`,sum(`p`.`prezzo_totale`) AS `totale_guadagnato_euro` from (((`host` `h` join `utente` `u` on((`h`.`id_host` = `u`.`id_utente`))) join `alloggio` `a` on((`h`.`id_host` = `a`.`id_host`))) join `prenotazione_alloggio` `p` on((`a`.`id_alloggio` = `p`.`id_alloggio`))) where ((`p`.`stato` = 'Confermata') or (`p`.`stato` = 'Completata')) group by `h`.`id_host` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_dettaglio_prenotazione_ospite`
--

/*!50001 DROP VIEW IF EXISTS `vista_dettaglio_prenotazione_ospite`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_dettaglio_prenotazione_ospite` AS select `p`.`id_prenotazione` AS `id_prenotazione`,`p`.`id_utente` AS `ospite_id`,`a`.`titolo` AS `nome_alloggio`,`c`.`nome` AS `citta_alloggio`,`p`.`check_in` AS `check_in`,`p`.`check_out` AS `check_out`,`p`.`prezzo_totale` AS `prezzo_totale`,`p`.`stato` AS `stato`,`p`.`codice_conferma` AS `codice_conferma`,`uh`.`nome` AS `nome_host` from (((`prenotazione_alloggio` `p` join `alloggio` `a` on((`p`.`id_alloggio` = `a`.`id_alloggio`))) join `citta` `c` on((`a`.`id_citta` = `c`.`id_citta`))) join `utente` `uh` on((`a`.`id_host` = `uh`.`id_utente`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_esplora_dintorni`
--

/*!50001 DROP VIEW IF EXISTS `vista_esplora_dintorni`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_esplora_dintorni` AS select `a`.`id_alloggio` AS `id_alloggio`,`a`.`titolo` AS `nome_alloggio`,`c`.`nome` AS `citta`,`pi`.`nome` AS `punto_interesse`,`pi`.`categoria` AS `categoria`,`pi`.`descrizione` AS `descrizione` from ((`alloggio` `a` join `citta` `c` on((`a`.`id_citta` = `c`.`id_citta`))) join `punti_interesse` `pi` on((`c`.`id_citta` = `pi`.`id_citta`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_fatturazione_prenotazioni`
--

/*!50001 DROP VIEW IF EXISTS `vista_fatturazione_prenotazioni`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_fatturazione_prenotazioni` AS select `pa`.`id_prenotazione` AS `id_prenotazione`,`pa`.`codice_conferma` AS `codice_conferma`,`pa`.`data_prenotazione` AS `data_prenotazione`,`u_ospite`.`nome` AS `nome_ospite`,`u_ospite`.`cognome` AS `cognome_ospite`,`a`.`titolo` AS `alloggio_prenotato`,`u_host`.`nome` AS `nome_host_proprietario`,`u_host`.`cognome` AS `cognome_host_proprietario`,`pa`.`prezzo_totale` AS `prezzo_totale` from (((`prenotazione_alloggio` `pa` join `utente` `u_ospite` on((`pa`.`id_utente` = `u_ospite`.`id_utente`))) join `alloggio` `a` on((`pa`.`id_alloggio` = `a`.`id_alloggio`))) join `utente` `u_host` on((`a`.`id_host` = `u_host`.`id_utente`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_prenotazioni_da_recensire`
--

/*!50001 DROP VIEW IF EXISTS `vista_prenotazioni_da_recensire`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_prenotazioni_da_recensire` AS select `pa`.`id_prenotazione` AS `id_prenotazione`,`pa`.`codice_conferma` AS `codice_conferma`,`u`.`nome` AS `nome_ospite`,`u`.`email` AS `email_ospite`,`a`.`titolo` AS `nome_alloggio`,`pa`.`check_out` AS `check_out` from (((`prenotazione_alloggio` `pa` join `utente` `u` on((`pa`.`id_utente` = `u`.`id_utente`))) join `alloggio` `a` on((`pa`.`id_alloggio` = `a`.`id_alloggio`))) left join `recensione_alloggio` `ra` on((`pa`.`id_prenotazione` = `ra`.`id_prenotazione`))) where (((`pa`.`stato` = 'Completata') or (`pa`.`check_out` < curdate())) and (`ra`.`id_recensione` is null)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_profilo_agenzia_completo`
--

/*!50001 DROP VIEW IF EXISTS `vista_profilo_agenzia_completo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_profilo_agenzia_completo` AS select `ag`.`id_agenzia` AS `id_agenzia`,`ag`.`nome` AS `nome`,`ag`.`email` AS `email`,`ag`.`telefono` AS `telefono`,group_concat(distinct `l`.`nome` separator ', ') AS `lingue_parlate`,count(distinct `e`.`id_esperienza`) AS `numero_esperienze_offerte` from (((`agenzia` `ag` left join `parla_agenzia` `pa` on((`ag`.`id_agenzia` = `pa`.`id_agenzia`))) left join `lingua` `l` on((`pa`.`id_lingua` = `l`.`id_lingua`))) left join `esperienze` `e` on((`ag`.`id_agenzia` = `e`.`id_agenzia`))) group by `ag`.`id_agenzia` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_profilo_host_completo`
--

/*!50001 DROP VIEW IF EXISTS `vista_profilo_host_completo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_profilo_host_completo` AS select `u`.`id_utente` AS `id_utente`,`u`.`nome` AS `nome`,`u`.`cognome` AS `cognome`,`h`.`descrizione_profilo` AS `descrizione_profilo`,`h`.`data_attivazione` AS `data_attivazione`,group_concat(distinct `l`.`nome` separator ', ') AS `lingue_parlate`,group_concat(distinct `b`.`nome` separator ', ') AS `badge_ottenuti` from (((((`host` `h` join `utente` `u` on((`h`.`id_host` = `u`.`id_utente`))) left join `parla_host` `ph` on((`h`.`id_host` = `ph`.`id_host`))) left join `lingua` `l` on((`ph`.`id_lingua` = `l`.`id_lingua`))) left join `ottiene` `o` on((`h`.`id_host` = `o`.`id_host`))) left join `badge` `b` on((`o`.`id_badge` = `b`.`id_badge`))) group by `h`.`id_host` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_profilo_ospite_crm`
--

/*!50001 DROP VIEW IF EXISTS `vista_profilo_ospite_crm`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_profilo_ospite_crm` AS select `u`.`id_utente` AS `id_utente`,`u`.`nome` AS `nome`,`u`.`cognome` AS `cognome`,`u`.`email` AS `email`,count(distinct `pa`.`id_prenotazione`) AS `soggiorni_effettuati`,count(distinct `pe`.`id_prenotazione_esperienza`) AS `esperienze_svolte` from ((`utente` `u` left join `prenotazione_alloggio` `pa` on((`u`.`id_utente` = `pa`.`id_utente`))) left join `prenotazione_esperienze` `pe` on((`u`.`id_utente` = `pe`.`id_utente`))) group by `u`.`id_utente` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_statistiche_servizi`
--

/*!50001 DROP VIEW IF EXISTS `vista_statistiche_servizi`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_statistiche_servizi` AS select `s`.`id_servizio` AS `id_servizio`,`s`.`nome` AS `nome_servizio`,`s`.`categoria` AS `categoria`,count(`o`.`id_alloggio`) AS `numero_alloggi_che_lo_offrono` from (`servizio` `s` left join `offre` `o` on((`s`.`id_servizio` = `o`.`id_servizio`))) group by `s`.`id_servizio` order by count(`o`.`id_alloggio`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_top_destinazioni`
--

/*!50001 DROP VIEW IF EXISTS `vista_top_destinazioni`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_top_destinazioni` AS select `c`.`id_citta` AS `id_citta`,`c`.`nome` AS `citta`,`c`.`nazione` AS `nazione`,count(distinct `a`.`id_alloggio`) AS `numero_alloggi_disponibili`,count(`p`.`id_prenotazione`) AS `numero_prenotazioni_totali` from ((`citta` `c` left join `alloggio` `a` on((`c`.`id_citta` = `a`.`id_citta`))) left join `prenotazione_alloggio` `p` on((`a`.`id_alloggio` = `p`.`id_alloggio`))) group by `c`.`id_citta` order by count(`p`.`id_prenotazione`) desc */;
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

-- Dump completed on 2026-05-29 10:48:53
