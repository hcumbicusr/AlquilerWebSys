-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.6.16


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema bd_alquiler
--

CREATE DATABASE IF NOT EXISTS bd_alquiler;
USE bd_alquiler;

--
-- Definition of table `abastecimiento`
--

DROP TABLE IF EXISTS `abastecimiento`;
CREATE TABLE `abastecimiento` (
  `id_abastecimiento` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipocomprobante` int(11) NOT NULL,
  `id_tipocombustible` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nro_comprobante` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nro_operacion_ch` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abastecedor` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `precio_u` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `cantidad_guia` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_abastecimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `abastecimiento`
--

/*!40000 ALTER TABLE `abastecimiento` DISABLE KEYS */;
INSERT INTO `abastecimiento` (`id_abastecimiento`,`id_tipocomprobante`,`id_tipocombustible`,`fecha`,`nro_comprobante`,`nro_operacion_ch`,`abastecedor`,`cantidad`,`precio_u`,`total`,`cantidad_guia`) VALUES 
 (1,1,1,'2015-02-28 00:00:00','003-0077170','TRANSFERENCIA','ABASTECEDOR A','3720.00','13.02','48434.40','0.00'),
 (2,2,1,'2015-03-22 00:00:00','003-0077171','23914','GRIFO PARA PRUEBA EN LOCAL','400.00','13.00','5200.00','170.00'),
 (3,1,1,'2015-02-28 00:00:00','003-0077172','15248','GRIFO PARA PRUEBA EN LOCAL','200.00','13.01','2602.00','50.00');
/*!40000 ALTER TABLE `abastecimiento` ENABLE KEYS */;


--
-- Definition of table `almacen`
--

DROP TABLE IF EXISTS `almacen`;
CREATE TABLE `almacen` (
  `id_almacen` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccion` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_almacen`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `almacen`
--

/*!40000 ALTER TABLE `almacen` DISABLE KEYS */;
INSERT INTO `almacen` (`id_almacen`,`codigo`,`nombre`,`direccion`,`telefono`,`estado`) VALUES 
 (1,'A01','ALMACÉN A','DIRECCIÓN ALMACÉN A',NULL,'A'),
 (2,'A02','ALMACÉN B','DIRECCIÓN ALMACÉN B',NULL,'A');
/*!40000 ALTER TABLE `almacen` ENABLE KEYS */;


--
-- Definition of table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
CREATE TABLE `articulo` (
  `id_articulo` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipoarticulo` int(11) NOT NULL,
  `id_almacen` int(11) NOT NULL,
  `serie` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descripcion` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `precio_alq` decimal(10,2) NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_articulo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `articulo`
--

/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` (`id_articulo`,`id_tipoarticulo`,`id_almacen`,`serie`,`nombre`,`descripcion`,`precio_alq`,`estado`) VALUES 
 (1,1,1,'00001','ARTÍCULO NRO 1','ARTÍCULO NRO 1','120.00','A'),
 (2,1,1,'00002','ARTÍCULO NRO 2','ARTÍCULO NRO 2','125.00','A'),
 (3,1,1,'00003','ARTÍCULO NRO 3','ARTÍCULO NRO 3','130.00','A'),
 (4,2,2,'ser0215','NUEVO ARTICULO DE PRUEBA N 01','ARTI 01','123.00','A');
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;


--
-- Definition of table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipocliente` int(11) NOT NULL,
  `codigo` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `direccion` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  `f_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cliente`
--

/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` (`id_cliente`,`id_tipocliente`,`codigo`,`nombre`,`direccion`,`telefono`,`estado`,`f_registro`) VALUES 
 (1,1,'2010233456','CLIENTE A','PIURA - PIURA - PIURA','073293949','A','2015-03-03 00:33:03'),
 (2,2,'2013203040','CLIENTE B','PIURA - PIURA - CASTILLA','073473647','A','2015-03-03 00:33:54'),
 (3,1,'2011923845','CLIENTE C','SULLANA','07329495','A','2015-03-03 00:35:01'),
 (4,4,'2134233423','GRUPO CONSTRUCTOR ABC','ZONA INDUSTRIAL PIURA','203040','A','2015-03-25 23:09:12');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;


--
-- Definition of table `consumo`
--

DROP TABLE IF EXISTS `consumo`;
CREATE TABLE `consumo` (
  `id_consumo` int(11) NOT NULL AUTO_INCREMENT,
  `id_detallealquiler` int(11) NOT NULL,
  `id_operario` int(11) NOT NULL,
  `id_responsable` int(11) NOT NULL,
  `id_detalleabastecimiento` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `nro_guia` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nro_vale` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nro_surtidor` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cant_combustible` decimal(10,2) NOT NULL,
  `horometro` decimal(10,2) DEFAULT NULL,
  `kilometraje` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_consumo`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `consumo`
--

/*!40000 ALTER TABLE `consumo` DISABLE KEYS */;
INSERT INTO `consumo` (`id_consumo`,`id_detallealquiler`,`id_operario`,`id_responsable`,`id_detalleabastecimiento`,`fecha`,`nro_guia`,`nro_vale`,`nro_surtidor`,`cant_combustible`,`horometro`,`kilometraje`) VALUES 
 (1,1,3,1,1,'2014-12-02','001-014737','2580','SURTIDOR N 1','70.00','6173.30','0.00'),
 (2,2,7,1,1,'2014-12-02','001-014737','2581','SURTIDOR N 1','11.10','232342.00','0.00'),
 (3,3,2,1,1,'2014-12-02','001-014737','2582','SURTIDOR N 1','62.00','12651.80','0.00'),
 (4,4,5,1,1,'2014-12-02','001-014737','2583','SURTIDOR N 1','118.60','4430.10','0.00'),
 (5,5,16,1,2,'2014-12-02','001-014753','2584','SURTIDOR N 1','79.90','2681.90','0.00'),
 (6,6,11,1,2,'2014-12-03','001-014753','2585','SURTIDOR N 1','5.80','481.30','0.00'),
 (7,2,7,1,2,'2014-12-03','001-014753','2586','SURTIDOR N 1','10.00','232646.00','0.00'),
 (8,4,5,1,3,'2014-12-03','001-014769','2587','SURTIDOR N 1','100.40','4447.10','0.00'),
 (9,5,16,1,3,'2014-12-03','001-014769','2588','SURTIDOR N 1','73.00','2702.40','0.00'),
 (10,3,2,1,4,'2014-12-04','001-014772','2589','SURTIDOR N 1','104.50','12667.10','0.00'),
 (11,6,11,1,4,'2014-12-04','001-014772','2590','SURTIDOR N 1','12.00','487.60','0.00'),
 (12,5,16,1,5,'2014-12-04','001-014780','2591','SURTIDOR N 1','65.80','2720.90','0.00'),
 (13,2,7,1,5,'2014-12-04','001-014780','2592','SURTIDOR N 1','11.50','23300.20','0.00'),
 (14,5,16,1,6,'2014-12-05','001-014784','2593','SURTIDOR N 1','60.80','2737.60','0.00'),
 (15,3,2,1,6,'2014-12-05','001-014784','2594','SURTIDOR N 1','127.00','12683.30','0.00'),
 (16,6,11,1,7,'2014-12-05','001-014789','2595','SURTIDOR N 1','15.00','499.40','0.00'),
 (17,6,11,1,7,'2014-12-05','001-014789','2596','SURTIDOR N 1','17.30','525.30','0.00'),
 (18,4,5,1,7,'2014-12-05','001-014789','2597','SURTIDOR N 1','20.00','4460.30','0.00'),
 (19,4,5,1,8,'2014-12-06','001-014804','2851','SURTIDOR N 1','120.20','4469.80','0.00'),
 (20,5,16,1,8,'2014-12-06','001-014804','2852','SURTIDOR N 1','96.10','2747.60','0.00'),
 (21,3,2,1,9,'2014-12-06','001-014798','2598','SURTIDOR N 1','39.00','12689.30','0.00'),
 (22,6,11,1,9,'2014-12-06','001-014798','2599','SURTIDOR N 1','5.50','504.00','0.00'),
 (23,7,10,1,9,'2014-12-08','001-014798','2619','SURTIDOR N 1','10.00','68940.00','0.00'),
 (24,8,17,1,9,'2014-12-08','001-014798','2620','SURTIDOR N 1','15.50','0.00','0.00'),
 (25,8,17,1,9,'2014-12-08','001-014798','2618','SURTIDOR N 1','13.00','533.10','0.00'),
 (26,5,16,1,10,'2014-12-09','001-014818','2853','SURTIDOR N 1','62.50','2780.40','0.00'),
 (27,4,5,1,10,'2014-12-09','001-014818','2854','SURTIDOR N 1','100.60','4490.50','0.00'),
 (28,8,17,1,10,'2014-12-09','001-014818','2855','SURTIDOR N 1','12.70','800.20','0.00'),
 (29,6,11,1,11,'2014-12-10','002-0018739','2857','SURTIDOR N 1','15.00','514.40','0.00'),
 (30,3,2,1,11,'2014-12-10','002-0018739','2858','SURTIDOR N 1','96.00','12703.40','0.00'),
 (31,5,16,1,12,'2014-12-13','001-014847','2867','SURTIDOR N 1','71.10','2841.20','0.00'),
 (32,4,5,1,12,'2014-12-13','001-014847','2868','SURTIDOR N 1','98.70','4551.10','0.00'),
 (33,3,2,1,13,'2014-12-15','001-014849','2869','SURTIDOR N 1','118.80','12729.30','0.00'),
 (34,6,11,1,13,'2014-12-15','001-014849','2870','SURTIDOR N 1','18.00','535.20','0.00'),
 (35,4,5,1,13,'2014-12-15','001-014849','2871','SURTIDOR N 1','48.30','4567.00','0.00'),
 (36,4,5,1,14,'2014-12-15','001-014855','2872','SURTIDOR N 1','92.50','4577.00','0.00'),
 (37,2,7,1,14,'2014-12-16','001-014855','2873','SURTIDOR N 1','12.50','233653.00','0.00'),
 (38,4,5,1,15,'2014-12-17','001-014862','2874','SURTIDOR N 1','105.20','4592.00','0.00'),
 (39,6,11,1,15,'2014-12-17','001-014862','2875','SURTIDOR N 1','19.50','547.80','0.00'),
 (40,3,2,1,15,'2014-12-17','001-014862','2876','SURTIDOR N 1','109.00','12745.90','0.00'),
 (41,2,7,1,16,'2014-12-17','001-014860','2877','SURTIDOR N 1','13.20','23399.40','0.00'),
 (42,4,5,1,17,'2014-12-18','001-014880','2878','SURTIDOR N 1','107.80','4612.40','0.00'),
 (43,5,16,1,17,'2014-12-18','001-014880','2879','SURTIDOR N 1','28.30','2850.30','0.00'),
 (44,4,5,1,17,'2014-12-19','001-014880','2880','SURTIDOR N 1','36.60','4626.50','0.00'),
 (45,6,11,1,18,'2014-12-19','001-0148885','2881','SURTIDOR N 1','22.00','562.70','0.00'),
 (46,3,2,1,18,'2014-12-19','001-0148885','2882','SURTIDOR N 1','127.60','12763.30','0.00'),
 (47,4,5,1,19,'2014-12-19','001-014887','2883','SURTIDOR N 1','101.00','4636.00','0.00'),
 (48,4,5,1,19,'2014-12-19','001-014887','2884','SURTIDOR N 1','62.80','4646.00','0.00'),
 (49,2,7,1,19,'2014-12-19','001-014887','2885','SURTIDOR N 1','12.00','23434.30','0.00'),
 (50,8,17,1,19,'2014-12-19','001-014887','2886','SURTIDOR N 1','18.00','479.00','0.00'),
 (51,3,2,1,20,'2014-12-22','001-014890','2887','SURTIDOR N 1','66.00','12772.30','0.00'),
 (52,6,11,1,20,'2014-12-22','001-014890','2888','SURTIDOR N 1','17.00','572.30','0.00'),
 (53,4,5,1,20,'2014-12-22','001-014890','2889','SURTIDOR N 1','70.50','4659.20','0.00'),
 (54,4,5,1,21,'2014-12-22','001-014893','2890','SURTIDOR N 1','77.50','4672.00','0.00'),
 (55,2,7,1,21,'2014-12-22','001-014893','2891','SURTIDOR N 1','9.70','23463.70','0.00'),
 (56,6,11,1,22,'2014-12-23','001-0148998','2892','SURTIDOR N 1','17.50','583.00','0.00'),
 (57,3,2,1,22,'2014-12-23','001-0148998','2893','SURTIDOR N 1','74.80','12783.40','0.00'),
 (58,8,17,1,22,'2014-12-24','001-0148998','2894','SURTIDOR N 1','7.80','660.00','0.00'),
 (59,4,5,1,23,'2014-12-24','001-014907','2895','SURTIDOR N 1','126.00','4691.30','0.00'),
 (60,7,10,1,23,'2014-12-24','001-014907','2896','SURTIDOR N 1','11.90','71609.00','0.00'),
 (61,6,11,1,24,'2014-12-26','001-014912','2897','SURTIDOR N 1','20.00','594.40','0.00'),
 (62,3,2,1,24,'2014-12-26','001-014912','2898','SURTIDOR N 1','72.00','12793.10','0.00'),
 (63,6,11,1,25,'2014-12-27','001-014915','2899','SURTIDOR N 1','8.90','598.90','0.00'),
 (64,3,2,1,25,'2014-12-27','001-014915','3301','SURTIDOR N 1','45.00','12799.30','0.00'),
 (65,6,11,1,25,'2014-12-27','001-014915','3302','SURTIDOR N 1','11.00','604.50','0.00'),
 (66,6,11,1,26,'2014-12-31','001-014923','3303','SURTIDOR N 1','12.00','525.30','0.00'),
 (67,3,2,1,26,'2014-12-31','001-014923','3304','SURTIDOR N 1','92.00','12812.30','0.00'),
 (68,6,11,1,26,'2014-12-31','001-014923','3305','SURTIDOR N 1','5.50','609.50','0.00'),
 (69,12,8,1,26,'2015-01-01','001-014923','12121','12','10.00','2000.00','0.00'),
 (70,11,4,1,26,'2015-01-01','001-014923','12122','010','25.00','2002.00','0.00'),
 (71,13,8,1,26,'2015-02-25','001-014923','12123','15','15.00','2007.00','0.00'),
 (72,14,11,1,27,'2015-01-03','002-0018740','0001','SURTIDOR N1','30.00','1202.00','0.00'),
 (73,14,11,1,27,'2015-01-05','002-0018740','002','SURTIDOR N 1','9.70','1210.60','0.00'),
 (74,14,11,1,27,'2015-01-05','002-0018740','003','SURTIDOR N 1','12.00','1215.40','0.00'),
 (75,19,10,1,21,'2014-12-29','001-014893','01229','SURTIDOR N 1','10.00','1193.00','0.00'),
 (76,19,10,1,25,'2014-12-30','001-014915','01230','SURTIDOR N 1','15.00','1198.00','0.00');
/*!40000 ALTER TABLE `consumo` ENABLE KEYS */;


--
-- Definition of table `contrato`
--

DROP TABLE IF EXISTS `contrato`;
CREATE TABLE `contrato` (
  `id_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `id_obra` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `f_inicio` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `f_fin` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `presupuesto` decimal(10,2) DEFAULT '0.00',
  `detalle` varchar(400) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_contrato`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `contrato`
--

/*!40000 ALTER TABLE `contrato` DISABLE KEYS */;
INSERT INTO `contrato` (`id_contrato`,`id_obra`,`id_cliente`,`f_inicio`,`f_fin`,`presupuesto`,`detalle`,`estado`) VALUES 
 (1,1,1,'2015-01-01 00:00:00','2015-03-08 00:00:00','25000.00','','A'),
 (2,2,2,'2014-11-08 00:00:00','2015-03-31 00:00:00','65000.00','','A'),
 (3,3,2,'2014-12-08 00:00:00','2015-01-31 00:00:00','64500.00','','A'),
 (4,5,4,'2015-03-01 00:00:00','2015-03-26 00:00:00','0.00','DESCRIPCIÓN INICIAL DE CONTRATO','B');
/*!40000 ALTER TABLE `contrato` ENABLE KEYS */;


--
-- Definition of table `controltrabajo`
--

DROP TABLE IF EXISTS `controltrabajo`;
CREATE TABLE `controltrabajo` (
  `id_controltrabajo` int(11) NOT NULL AUTO_INCREMENT,
  `id_detallealquiler` int(11) NOT NULL,
  `id_operario` int(11) NOT NULL,
  `id_responsable` int(11) DEFAULT NULL,
  `nro_interno` int(11) NOT NULL DEFAULT '0',
  `nro_parte` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `lugar_trabajo` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tarea` varchar(400) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agua` decimal(10,2) NOT NULL DEFAULT '0.00',
  `petroleo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `gasolina` decimal(10,2) NOT NULL DEFAULT '0.00',
  `ac_motor` decimal(10,2) DEFAULT '0.00',
  `ac_transmision` decimal(10,2) DEFAULT '0.00',
  `ac_hidraulico` decimal(10,2) DEFAULT '0.00',
  `grasa` decimal(10,2) DEFAULT '0.00',
  `observacion` varchar(400) COLLATE utf8_unicode_ci DEFAULT NULL,
  `turno` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'C',
  `descuento` decimal(10,2) DEFAULT NULL,
  `horometro_inicio` decimal(10,2) NOT NULL,
  `horometro_fin` decimal(10,2) NOT NULL,
  `total_h` decimal(10,2) NOT NULL,
  `hrs` int(11) NOT NULL DEFAULT '0',
  `minuto` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_controltrabajo`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `controltrabajo`
--

/*!40000 ALTER TABLE `controltrabajo` DISABLE KEYS */;
INSERT INTO `controltrabajo` (`id_controltrabajo`,`id_detallealquiler`,`id_operario`,`id_responsable`,`nro_interno`,`nro_parte`,`fecha`,`lugar_trabajo`,`tarea`,`agua`,`petroleo`,`gasolina`,`ac_motor`,`ac_transmision`,`ac_hidraulico`,`grasa`,`observacion`,`turno`,`descuento`,`horometro_inicio`,`horometro_fin`,`total_h`,`hrs`,`minuto`) VALUES 
 (1,3,2,1,1,'14502','2014-12-10','OBRA NIVELACIÓN BANANO','NIVELACION EN AREA PARA BANANO','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACION EN AREA PARA BANANO					\r\n','M','0.00','12800.00','12802.50','2.50',2,30),
 (2,3,2,1,1,'14503','2014-12-12','NIVELACION EN AREA PARA BANANO','NIVELACION EN AREA PARA BANANO','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACION EN AREA PARA BANANO					\r\n','M','0.00','12804.00','12812.50','8.50',8,30),
 (3,3,2,1,1,'14504','2014-12-13','NIVELACION EN AREA PARA BANANO','NIVELACION EN AREA PARA BANANO','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACION EN AREA PARA BANANO					\r\n','C','0.00','12812.50','12823.50','11.00',11,0),
 (4,3,2,1,1,'14505','2014-12-14','NIVELACION EN AREA PARA BANANO','NIVELACION EN AREA PARA BANANO','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACION EN AREA PARA BANANO					\r\n','C','0.00','12823.50','12834.50','11.00',11,0),
 (5,3,2,1,1,'14514','2014-12-24','NIVELACION EN AREA PARA BANANO','NIVELACION EN AREA PARA BANANO','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACION EN AREA PARA BANANO					\r\n','C','0.00','12834.50','12841.00','6.50',6,30),
 (6,6,11,1,1,'10245','2014-12-15','NIVELACIÓN FINA','NIVELACIÓN FINA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACIÓN FINA 						\r\n','C','0.00','610.00','616.00','6.00',6,0),
 (7,6,11,1,1,'10246','2014-12-16','NIVELACIÓN FINA','NIVELACIÓN FINA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACIÓN FINA 						\r\n','M','0.00','616.00','618.20','2.20',2,12),
 (8,6,11,1,1,'10247','2014-12-17','NIVELACIÓN FINA','NIVELACIÓN FINA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACIÓN FINA 						\r\n','C','0.00','618.20','624.70','6.50',6,30),
 (9,6,11,1,1,'10248','2014-12-19','NIVELACIÓN FINA','NIVELACIÓN FINA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACIÓN FINA 						\r\n','C','0.00','624.70','631.90','7.20',7,12),
 (10,6,11,1,1,'10249','2014-12-20','NIVELACIÓN FINA','NIVELACIÓN FINA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACIÓN FINA 						\r\n','C','0.00','631.90','642.20','10.30',10,18),
 (11,5,16,1,2,'10241','2014-12-10','NIVELACIÓN FINA','NIVELACIÓN FINA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACIÓN FINA 						\r\n','M','0.00','2860.00','2863.70','3.70',3,42),
 (12,5,16,1,2,'10242','2014-12-12','NIVELACIÓN FINA','NIVELACIÓN FINA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NIVELACIÓN FINA 						','M','0.00','2863.70','2865.70','2.00',2,0),
 (13,4,5,1,4,'14212','2014-12-12','EXCAVACION PARA TUBERIA','EXCAVACION PARA TUBERIA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','EXCAVACION PARA TUBERIA 						\r\n','C','0.00','4691.30','4700.30','9.00',9,0),
 (14,4,5,1,4,'14213','2014-12-13','EXCAVACION PARA TUBERIA','EXCAVACION PARA TUBERIA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','EXCAVACION PARA TUBERIA 						\r\n','C','0.00','4700.30','4711.00','10.70',10,42),
 (15,4,5,1,4,'14214','2014-12-14','EXCAVACION PARA TUBERIA','EXCAVACION PARA TUBERIA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','EXCAVACION PARA TUBERIA 						\r\n','C','0.00','4711.00','4722.40','11.40',11,24),
 (16,12,8,1,12,'12001','2015-01-01','NOMBRE DEL LUGAR','NIVELACION FINA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','2000.00','2004.00','4.00',4,0),
 (17,11,4,1,2,'12002','2015-01-01','LUGAR DE TRABAJO PARA NIV FINA EXCAVADORA SOBRE ORUGAS NRO 01','NIVELACION','0.00','25.00','0.00','0.00','0.00','0.00','0.00','','C','0.00','2000.00','2010.00','10.00',10,0),
 (18,13,8,1,12,'12003','2015-02-25','LUGAR','NIVELACION MANGO','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','2006.00','2011.00','5.00',5,0),
 (19,14,11,1,15,'15001','2015-01-03','PAMPA','UNA LABOR DE ESTA OBRA XY','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','C','0.00','1200.00','1209.00','9.00',9,0),
 (20,14,11,1,14,'15002','2015-01-05','PAMPA','LABOR DE ESTA MAQUINARIA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','1210.00','1214.30','4.30',4,18),
 (21,14,11,1,17,'15003','2015-01-05','PAMPASSS','ALGUNA LABOR ENCOMENDADA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','1214.30','1219.90','5.60',5,36),
 (22,19,10,1,25,'141209','2014-12-29','PAMPA DE TRABJO','NIVE FINA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','1193.00','1196.00','3.00',3,0),
 (23,19,10,1,26,'141210','2014-12-30','OTRO LUGAR','LABOR DE TRABAJO','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','C','0.00','1196.00','1202.00','6.00',6,0);
/*!40000 ALTER TABLE `controltrabajo` ENABLE KEYS */;


--
-- Definition of table `detalleabastecimiento`
--

DROP TABLE IF EXISTS `detalleabastecimiento`;
CREATE TABLE `detalleabastecimiento` (
  `id_detalleabastecimiento` int(11) NOT NULL AUTO_INCREMENT,
  `id_abastecimiento` int(11) NOT NULL DEFAULT '0',
  `id_tipocombustible` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `id_trabajador` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nro_guia` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `stock` decimal(10,2) NOT NULL,
  `abastecedor` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_detalleabastecimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detalleabastecimiento`
--

/*!40000 ALTER TABLE `detalleabastecimiento` DISABLE KEYS */;
INSERT INTO `detalleabastecimiento` (`id_detalleabastecimiento`,`id_abastecimiento`,`id_tipocombustible`,`id_vehiculo`,`id_trabajador`,`fecha`,`nro_guia`,`cantidad`,`stock`,`abastecedor`) VALUES 
 (1,0,1,38,16,'2014-11-29 00:00:00','001-014737','300.00','38.30','ABASTECEDOR A'),
 (2,0,1,38,17,'2014-12-02 00:00:00','001-014753','170.00','74.30','ABASTECEDOR A'),
 (3,0,1,38,17,'2014-12-03 00:00:00','001-014769','180.00','6.60','ABASTECEDOR A'),
 (4,0,1,38,17,'2014-12-04 00:00:00','001-014772','120.00','3.50','ABASTECEDOR A'),
 (5,0,1,38,17,'2014-12-04 00:00:00','001-014780','80.00','2.70','ABASTECEDOR A'),
 (6,0,1,38,17,'2014-12-05 00:00:00','001-014784','170.00','-17.80','ABASTECEDOR A'),
 (7,0,1,38,17,'2014-12-05 00:00:00','001-014789','50.00','-2.30','ABASTECEDOR A'),
 (8,0,1,38,17,'2014-12-06 00:00:00','001-014804','210.00','-6.30','ABASTECEDOR A'),
 (9,0,1,38,17,'2014-12-06 00:00:00','001-014798','100.00','17.00','ABASTECEDOR A'),
 (10,0,1,38,17,'2014-12-09 00:00:00','001-014818','200.00','24.20','ABASTECEDOR A'),
 (11,0,1,38,17,'2014-12-10 00:00:00','002-0018739','80.00','-31.00','ABASTECEDOR A'),
 (12,0,1,38,17,'2014-12-13 00:00:00','001-014847','200.00','30.20','ABASTECEDOR A'),
 (13,0,1,38,17,'2014-12-15 00:00:00','001-014849','170.00','-15.10','ABASTECEDOR A'),
 (14,0,1,38,17,'2014-12-15 00:00:00','001-014855','200.00','95.00','ABASTECEDOR A'),
 (15,0,1,38,17,'2014-12-17 00:00:00','001-014862','130.00','-103.70','ABASTECEDOR A'),
 (16,0,1,38,17,'2014-12-17 00:00:00','001-014860','50.00','36.80','ABASTECEDOR A'),
 (17,0,1,38,17,'2014-12-18 00:00:00','001-014880','150.00','-22.70','ABASTECEDOR A'),
 (18,0,1,38,17,'2014-12-19 00:00:00','001-0148885','150.00','0.40','ABASTECEDOR A'),
 (19,0,1,38,17,'2014-12-19 00:00:00','001-014887','200.00','6.20','ABASTECEDOR A'),
 (20,0,1,38,17,'2014-12-22 00:00:00','001-014890','100.00','-53.50','ABASTECEDOR A'),
 (21,0,1,38,17,'2014-12-22 00:00:00','001-014893','150.00','52.80','ABASTECEDOR A'),
 (22,0,1,38,17,'2014-12-23 00:00:00','001-0148998','100.00','-0.10','ABASTECEDOR A'),
 (23,0,1,38,17,'2014-12-24 00:00:00','001-014907','120.00','-17.90','ABASTECEDOR A'),
 (24,0,1,38,17,'2014-12-24 00:00:00','001-014912','60.00','-32.00','ABASTECEDOR A'),
 (25,0,1,38,17,'2014-12-27 00:00:00','001-014915','80.00','0.10','ABASTECEDOR A'),
 (26,0,1,38,17,'2014-12-31 00:00:00','001-014923','200.00','40.50','ABASTECEDOR A'),
 (27,2,1,38,17,'2015-01-03 00:00:00','002-0018740','170.00','118.30','GRIFO PARA PRUEBA EN LOCAL'),
 (28,3,1,38,5,'2015-01-06 00:00:00','002-0018741','50.00','50.00','GRIFO');
/*!40000 ALTER TABLE `detalleabastecimiento` ENABLE KEYS */;


--
-- Definition of table `detallealquiler`
--

DROP TABLE IF EXISTS `detallealquiler`;
CREATE TABLE `detallealquiler` (
  `id_detallealquiler` int(11) NOT NULL AUTO_INCREMENT,
  `id_contrato` int(11) NOT NULL,
  `id_vehiculo` int(11) DEFAULT '0',
  `id_articulo` int(11) DEFAULT '0',
  `precio_alq` decimal(10,2) NOT NULL DEFAULT '0.00',
  `fecha` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `estado` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `observacion` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `est_alq` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_detallealquiler`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detallealquiler`
--

/*!40000 ALTER TABLE `detallealquiler` DISABLE KEYS */;
INSERT INTO `detallealquiler` (`id_detallealquiler`,`id_contrato`,`id_vehiculo`,`id_articulo`,`precio_alq`,`fecha`,`estado`,`observacion`,`est_alq`) VALUES 
 (1,1,1,0,'240.00','2014-12-01 00:00:00','','TRACTOR SOBRE ORUGAS','A'),
 (2,1,23,0,'240.00','2014-12-01 00:00:00','','CAMION KIA','A'),
 (3,1,9,0,'240.00','2014-12-01 00:00:00','','TRACTOR SOBRE ORUGAS N 1','A'),
 (4,1,6,0,'240.00','2014-12-01 00:00:00','','EXCAVADORA CAT 324D N. 04','A'),
 (5,2,4,0,'240.00','2014-12-02 00:00:00','','EXCAVADORA CAT 320C # 02\r\n','A'),
 (6,2,15,0,'240.00','2014-12-01 00:00:00','','TRACTOR FIAT ALLIS N. 01','A'),
 (7,3,25,0,'240.00','2014-12-08 00:00:00','','CAMION KIA P2K-786','A'),
 (8,3,26,0,'240.00','2014-12-08 00:00:00','','CAMIONETA P3C-771','A'),
 (9,2,33,0,'240.00','2015-03-08 15:51:05','','CAMIÓN /MOD: /SERIE: /PLACA: P3D-898,\r\n CLIENTE B / CORTE Y NIVELACION EN AREA PARA MANGO ','I'),
 (10,3,19,0,'240.00','2015-03-09 02:36:31','','TRACTOR AGRÍCOLA NRO 03 /MOD: 7066DT /SERIE: 8045-06 /PLACA','B'),
 (11,3,3,0,'240.00','2014-12-08 00:00:00','','TRABAJO FUERTE','A'),
 (12,3,19,0,'240.00','2015-03-24 13:45:30','','PARA NIVELACIÓN FINA','B'),
 (13,2,19,0,'240.00','2015-02-25 00:00:00','','TRASLADO DE OBRA NIVELACION - CORTE Y NIVELACION EN AREA PARA MANGO ','A'),
 (14,4,17,0,'240.00','2015-03-01 00:00:00','','TRABAJO SOBRE OBRA DE PRUEBA N1','B'),
 (15,4,22,0,'240.00','2015-03-01 00:00:00','','PARA MOVILIZACIÓN','B'),
 (16,4,32,0,'240.00','2015-03-01 00:00:00','','PARA TRABAJO DE CARGA','B'),
 (17,4,34,0,'240.00','2015-03-01 00:00:00','','XYZ UNA LABOR','I'),
 (18,4,27,0,'240.00','2015-03-01 00:00:00','','MOVILIDAD DEL INGENIERO A CARGO DE LA OBRA','B'),
 (19,3,17,0,'240.00','2014-12-08 00:00:00','','NIVELACION FINA','A');
/*!40000 ALTER TABLE `detallealquiler` ENABLE KEYS */;


--
-- Definition of table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
CREATE TABLE `devolucion` (
  `id_devolucion` int(11) NOT NULL AUTO_INCREMENT,
  `id_detallealquiler` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `observacion` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_devolucion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `devolucion`
--

/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
INSERT INTO `devolucion` (`id_devolucion`,`id_detallealquiler`,`fecha`,`estado`,`observacion`) VALUES 
 (1,10,'2015-03-02 00:00:00','','XX'),
 (2,12,'2015-02-24 00:00:00','','SE CAMBIA DE OBRA A CORTE Y NIVELACION EN AREA PARA MANGO'),
 (3,16,'2015-03-26 00:00:00','','ELECCIÓN POR EQUIVOCACIÓN'),
 (4,15,'2015-03-26 00:00:00','','SE PRUEBA LA DEVOLUCION'),
 (5,14,'2015-03-26 00:00:00','','FINALIZACIÓN DE CONTRARO'),
 (6,18,'2015-03-26 00:00:00','','FINALIZACIÓN DE CONTRARO');
/*!40000 ALTER TABLE `devolucion` ENABLE KEYS */;


--
-- Definition of table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
CREATE TABLE `empresa` (
  `id_empresa` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(5) DEFAULT NULL,
  `ref_codigo` varchar(5) DEFAULT NULL,
  `razon_social` varchar(400) DEFAULT NULL,
  `nombre` varchar(400) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_empresa`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `empresa`
--

/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` (`id_empresa`,`codigo`,`ref_codigo`,`razon_social`,`nombre`,`descripcion`) VALUES 
 (1,'P0001','0','PIURAMAQ S.R.L.','PIURAMAQ S.R.L.','PIURAMAQ S.R.L.'),
 (2,'0','P0001','BANCO SCOTIABANK','Nro. Cuenta Moneda Nacional','2396980'),
 (3,'0','P0001','BANCO SCOTIABANK','Nro. Cuenta Moneda Nacional Interbancario (CCI)','009-330-000002396980-21'),
 (4,'0','P0001','BANCO DE LA NACIÓN','Nro. Cuenta Detracciones','631088554');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;


--
-- Definition of table `estado`
--

DROP TABLE IF EXISTS `estado`;
CREATE TABLE `estado` (
  `id_estado` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `estado`
--

/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` (`id_estado`,`nombre`,`estado`) VALUES 
 ('A','ACTIVO','A'),
 ('B','INACTIVO','A'),
 ('C','ALQUILADO','A'),
 ('D','DISPONIBLE','A'),
 ('E','MANTENIMIENTO','A'),
 ('F','AVERIADO','A'),
 ('G','RESERVADO','A'),
 ('H','CONTRATADO','A'),
 ('I','ANULADO','A');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;


--
-- Definition of table `mantenimiento`
--

DROP TABLE IF EXISTS `mantenimiento`;
CREATE TABLE `mantenimiento` (
  `id_mantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `id_vehiculo` int(11) NOT NULL,
  `causa` varchar(200) NOT NULL,
  `descripcion` varchar(400) DEFAULT NULL,
  `lugar_averia` varchar(200) DEFAULT NULL,
  `lugar_mant` varchar(200) NOT NULL,
  `horometro` decimal(10,2) NOT NULL DEFAULT '0.00',
  `kilometraje` decimal(10,2) NOT NULL DEFAULT '0.00',
  `f_ingreso` date NOT NULL,
  `f_salida` date NOT NULL,
  `estado_actual` varchar(200) NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_mantenimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mantenimiento`
--

/*!40000 ALTER TABLE `mantenimiento` DISABLE KEYS */;
INSERT INTO `mantenimiento` (`id_mantenimiento`,`id_vehiculo`,`causa`,`descripcion`,`lugar_averia`,`lugar_mant`,`horometro`,`kilometraje`,`f_ingreso`,`f_salida`,`estado_actual`,`costo`) VALUES 
 (1,6,'MANTENIMIENTO MENSUAL','MANTENIMIENTO PREVENTIVO','','MECÁNICA XY','4000.00','0.00','2014-12-01','2014-12-02','MUY BIEN','0.00'),
 (2,34,'EJEMPLO','EJEMPLO','EJEMPLO','EJEMPLO','2300.00','3490.00','2014-12-31','2014-12-31','BIEN','0.00'),
 (3,4,'MOTIVO DE PRUEBA PARA MANTENINIENTO','','','HUACA DE LA CRUZ','2863.70','0.00','2014-12-10','2014-12-10','REPARADO','0.00'),
 (4,17,'MANTENIMIENTO FIN DE JORNADA','MANTENIMIENTO FIN DE JORNADA RETROEXCAVADORA NRO 02[420D][FDP25583][ ]','','PLATAFORMA','1209.00','1500.00','2015-01-03','2015-01-04','MANTENIMIENTO PREVENTIVO','0.00');
/*!40000 ALTER TABLE `mantenimiento` ENABLE KEYS */;


--
-- Definition of table `marca`
--

DROP TABLE IF EXISTS `marca`;
CREATE TABLE `marca` (
  `id_marca` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_marca`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `marca`
--

/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` (`id_marca`,`nombre`,`estado`) VALUES 
 (1,'CATERPILLAR','A'),
 (2,'FIAT ALLIS','A'),
 (3,'KIA','A'),
 (4,'MITSUBISHI','A'),
 (5,'DONGFENG','A'),
 (6,'MACK','A'),
 (7,'CHEVROLET','A'),
 (8,'FORD','A'),
 (9,'MAZDA','A'),
 (10,'SURTIDOR','A');
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;


--
-- Definition of table `notificamant`
--

DROP TABLE IF EXISTS `notificamant`;
CREATE TABLE `notificamant` (
  `id_notificamant` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipovehiculo` int(11) NOT NULL,
  `id_marca` int(11) NOT NULL,
  `intervalo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `notifica_val` decimal(10,2) NOT NULL DEFAULT '10.00',
  `unidad` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'H',
  `notificacion` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `f_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_notificamant`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `notificamant`
--

/*!40000 ALTER TABLE `notificamant` DISABLE KEYS */;
INSERT INTO `notificamant` (`id_notificamant`,`id_tipovehiculo`,`id_marca`,`intervalo`,`notifica_val`,`unidad`,`notificacion`,`f_registro`,`estado`) VALUES 
 (1,1,1,'250.00','10.00','H','REQUIERE CAMBIO DE ACEITE','2015-02-20 12:45:17','A'),
 (2,2,5,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-20 12:45:17','A'),
 (3,2,6,'10000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-20 12:45:17','A'),
 (4,4,1,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-20 12:45:17','A'),
 (5,4,2,'5000.00','10.00','KM','REQUIERE NANTENIMIENTO','2015-02-20 12:45:17','A'),
 (6,4,3,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:12:00','A'),
 (7,4,4,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:14:57','A'),
 (8,4,5,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:14:57','A'),
 (9,4,6,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:14:57','A'),
 (10,4,7,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:14:57','A'),
 (11,4,8,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:14:57','A'),
 (12,4,9,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:14:57','A'),
 (13,1,1,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:16:52','A'),
 (14,3,2,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:16:52','A'),
 (15,3,3,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:16:52','A'),
 (16,3,4,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:16:52','A'),
 (17,3,5,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:16:52','A'),
 (18,3,6,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:16:52','A'),
 (19,3,7,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:16:52','A'),
 (20,3,8,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:16:52','A'),
 (21,3,9,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 01:16:52','A'),
 (22,1,2,'5000.00','10.00','H','REQUIERE MANTENIMIENTO','2015-03-03 01:03:55','A');
/*!40000 ALTER TABLE `notificamant` ENABLE KEYS */;


--
-- Definition of table `obra`
--

DROP TABLE IF EXISTS `obra`;
CREATE TABLE `obra` (
  `id_obra` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipoobra` int(11) NOT NULL,
  `nombre` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_obra`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `obra`
--

/*!40000 ALTER TABLE `obra` DISABLE KEYS */;
INSERT INTO `obra` (`id_obra`,`id_tipoobra`,`nombre`,`fecha`,`estado`) VALUES 
 (1,1,'NIVELACION EN AREA PARA BANANO','2015-03-08 15:45:25','H'),
 (2,1,'CORTE Y NIVELACION EN AREA PARA MANGO','2015-03-06 08:48:50','H'),
 (3,1,'NIVELACIÓN FINA','2015-03-03 00:11:52','H'),
 (4,1,'EXCAVACIÓN PARA TUBERÍA','2015-03-17 02:28:55','A'),
 (5,3,'OBRA REALIZADA PARA PRUEBAS N°01','2015-03-25 22:43:46','B');
/*!40000 ALTER TABLE `obra` ENABLE KEYS */;


--
-- Definition of table `partemant`
--

DROP TABLE IF EXISTS `partemant`;
CREATE TABLE `partemant` (
  `id_partemant` int(11) NOT NULL AUTO_INCREMENT,
  `id_controltrabajo` int(11) NOT NULL,
  `id_mantenimiento` int(11) NOT NULL,
  `fecha_reg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_partemant`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partemant`
--

/*!40000 ALTER TABLE `partemant` DISABLE KEYS */;
INSERT INTO `partemant` (`id_partemant`,`id_controltrabajo`,`id_mantenimiento`,`fecha_reg`) VALUES 
 (1,11,3,'2015-03-23 00:38:25'),
 (2,19,4,'2015-03-26 08:22:05');
/*!40000 ALTER TABLE `partemant` ENABLE KEYS */;


--
-- Definition of table `partevale`
--

DROP TABLE IF EXISTS `partevale`;
CREATE TABLE `partevale` (
  `id_partevale` int(11) NOT NULL AUTO_INCREMENT,
  `id_controltrabajo` int(11) NOT NULL,
  `id_consumo` int(11) NOT NULL,
  `fechar_reg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_partevale`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partevale`
--

/*!40000 ALTER TABLE `partevale` DISABLE KEYS */;
INSERT INTO `partevale` (`id_partevale`,`id_controltrabajo`,`id_consumo`,`fechar_reg`) VALUES 
 (1,16,69,'2015-03-24 13:05:01'),
 (2,17,70,'2015-03-24 13:30:22'),
 (3,18,71,'2015-03-24 14:28:01'),
 (4,19,72,'2015-03-26 00:51:15'),
 (5,20,73,'2015-03-26 00:58:52'),
 (6,21,74,'2015-03-26 01:05:59'),
 (7,22,75,'2015-03-26 13:42:57'),
 (8,23,76,'2015-03-26 13:46:43');
/*!40000 ALTER TABLE `partevale` ENABLE KEYS */;


--
-- Definition of table `regs`
--

DROP TABLE IF EXISTS `regs`;
CREATE TABLE `regs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accion` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `tablas_afectadas` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip_cliente` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nav_cliente` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `so_cliente` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `regs`
--

/*!40000 ALTER TABLE `regs` DISABLE KEYS */;
INSERT INTO `regs` (`id`,`id_usuario`,`fecha`,`accion`,`tablas_afectadas`,`ip_cliente`,`nav_cliente`,`so_cliente`) VALUES 
 (1,1,'2015-03-02 22:50:56','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (2,1,'2015-03-02 23:01:06','GENERACION DE USUARIO PARA TRAB: 2','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (3,1,'2015-03-02 23:02:15','GENERACION DE USUARIO PARA TRAB: 3','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (4,1,'2015-03-02 23:03:15','GENERACION DE USUARIO PARA TRAB: 4','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (5,1,'2015-03-02 23:04:15','GENERACION DE USUARIO PARA TRAB: 5','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (6,1,'2015-03-02 23:06:41','GENERACION DE USUARIO PARA TRAB: 6','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (7,1,'2015-03-02 23:08:28','GENERACION DE USUARIO PARA TRAB: 7','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (8,1,'2015-03-02 23:09:05','GENERACION DE USUARIO PARA TRAB: 8','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (9,1,'2015-03-02 23:10:04','GENERACION DE USUARIO PARA TRAB: 9','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (10,1,'2015-03-02 23:11:29','GENERACION DE USUARIO PARA TRAB: 10','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (11,1,'2015-03-02 23:11:59','GENERACION DE USUARIO PARA TRAB: 11','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (12,1,'2015-03-02 23:13:02','GENERACION DE USUARIO PARA TRAB: 12','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (13,1,'2015-03-02 23:13:38','GENERACION DE USUARIO PARA TRAB: 13','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (14,1,'2015-03-02 23:14:21','GENERACION DE USUARIO PARA TRAB: 14','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (15,1,'2015-03-02 23:14:54','GENERACION DE USUARIO PARA TRAB: 15','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (16,1,'2015-03-03 00:11:17','REG OBRA','OBRA','::1','Google Chrome','Windows'),
 (17,1,'2015-03-03 00:11:35','REG OBRA','OBRA','::1','Google Chrome','Windows'),
 (18,1,'2015-03-03 00:11:52','REG OBRA','OBRA','::1','Google Chrome','Windows'),
 (19,1,'2015-03-03 00:12:35','REG OBRA','OBRA','::1','Google Chrome','Windows'),
 (20,1,'2015-03-03 00:33:03','REGISTRO CLIENTE: CLIENTE A','CLIENTE','::1','Google Chrome','Windows'),
 (21,1,'2015-03-03 00:33:54','REGISTRO CLIENTE: CLIENTE B','CLIENTE','::1','Google Chrome','Windows'),
 (22,1,'2015-03-03 00:35:01','REGISTRO CLIENTE: CLIENTE C','CLIENTE','::1','Google Chrome','Windows'),
 (23,1,'2015-03-03 00:39:03','REG ARTICULOS','ARTICULO','::1','Google Chrome','Windows'),
 (24,1,'2015-03-03 00:39:27','REG ARTICULOS','ARTICULO','::1','Google Chrome','Windows'),
 (25,1,'2015-03-03 00:39:45','REG ARTICULOS','ARTICULO','::1','Google Chrome','Windows'),
 (26,1,'2015-03-03 01:56:45','GENERACION DE USUARIO PARA TRAB: 16','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (27,1,'2015-03-03 01:57:25','GENERACION DE USUARIO PARA TRAB: 17','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (28,1,'2015-03-03 02:11:32','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (29,1,'2015-03-03 02:13:24','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (30,1,'2015-03-03 02:17:06','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (31,1,'2015-03-03 02:21:00','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (32,1,'2015-03-03 02:22:13','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (33,1,'2015-03-03 02:23:25','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (34,1,'2015-03-03 02:23:53','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (35,1,'2015-03-03 02:24:55','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (36,1,'2015-03-03 02:25:56','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (37,1,'2015-03-03 02:26:37','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (38,1,'2015-03-03 02:27:16','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (39,1,'2015-03-03 02:27:54','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (40,1,'2015-03-03 02:28:24','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (41,1,'2015-03-03 02:29:01','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (42,1,'2015-03-03 02:29:36','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (43,1,'2015-03-03 02:30:45','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (44,1,'2015-03-03 02:31:18','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (45,1,'2015-03-03 02:31:49','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (46,1,'2015-03-03 02:32:12','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (47,1,'2015-03-03 02:33:04','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (48,1,'2015-03-03 02:33:41','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (49,1,'2015-03-03 02:34:14','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (50,1,'2015-03-03 02:35:02','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (51,1,'2015-03-03 02:35:29','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (52,1,'2015-03-03 02:37:47','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (53,1,'2015-03-03 02:38:13','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (54,1,'2015-03-03 02:51:15','REG ABASTECIMIENTO COMBUSTIBLE','ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (55,1,'2015-03-03 08:27:00','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (56,1,'2015-03-03 10:18:37','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (57,1,'2015-03-03 18:48:27','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (58,1,'2015-03-03 18:51:39','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (59,1,'2015-03-03 18:52:50','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (60,1,'2015-03-03 18:53:28','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (61,1,'2015-03-03 18:54:59','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (62,1,'2015-03-03 19:07:57','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (63,1,'2015-03-03 19:09:15','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (64,1,'2015-03-03 22:46:24','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (65,1,'2015-03-03 22:56:07','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (66,1,'2015-03-03 22:57:12','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (67,1,'2015-03-03 22:57:39','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (68,1,'2015-03-03 23:03:58','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (69,1,'2015-03-03 23:09:48','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (70,1,'2015-03-03 23:13:27','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (71,1,'2015-03-03 23:17:01','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (72,1,'2015-03-03 23:19:07','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (73,1,'2015-03-03 23:23:14','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (74,1,'2015-03-04 00:04:36','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (75,1,'2015-03-04 00:07:51','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (76,1,'2015-03-04 00:10:15','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (77,1,'2015-03-04 00:12:05','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (78,1,'2015-03-04 00:13:38','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (79,1,'2015-03-04 00:19:39','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (80,1,'2015-03-04 00:19:52','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (81,1,'2015-03-04 00:49:30','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (82,1,'2015-03-04 00:51:23','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (83,1,'2015-03-04 00:54:31','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (84,1,'2015-03-04 01:04:56','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (85,1,'2015-03-04 01:06:50','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (86,1,'2015-03-04 01:11:55','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (87,1,'2015-03-04 01:16:31','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (88,1,'2015-03-04 01:28:40','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (89,1,'2015-03-04 01:30:04','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (90,1,'2015-03-04 01:32:47','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (91,1,'2015-03-04 01:34:59','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (92,1,'2015-03-04 01:41:31','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (93,1,'2015-03-04 01:42:36','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (94,1,'2015-03-04 01:43:56','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (95,1,'2015-03-04 01:46:19','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (96,1,'2015-03-04 01:49:39','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (97,1,'2015-03-04 01:53:44','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (98,1,'2015-03-04 01:54:39','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (99,1,'2015-03-04 01:56:00','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (100,1,'2015-03-04 01:57:26','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (101,1,'2015-03-04 01:59:06','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (102,1,'2015-03-04 02:02:19','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (103,1,'2015-03-04 02:03:30','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (104,1,'2015-03-04 02:04:25','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (105,1,'2015-03-04 02:19:33','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (106,1,'2015-03-04 02:27:03','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (107,1,'2015-03-04 02:31:34','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (108,1,'2015-03-04 02:33:49','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (109,1,'2015-03-04 02:35:12','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (110,1,'2015-03-04 02:36:11','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (111,1,'2015-03-04 02:36:57','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (112,1,'2015-03-04 02:39:56','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (113,1,'2015-03-04 02:41:36','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (114,1,'2015-03-04 02:43:02','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (115,1,'2015-03-04 02:43:51','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (116,1,'2015-03-04 02:44:33','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (117,1,'2015-03-04 02:47:31','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (118,1,'2015-03-04 02:48:49','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (119,1,'2015-03-04 02:49:43','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (120,1,'2015-03-04 02:50:31','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (121,1,'2015-03-04 02:52:11','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (122,1,'2015-03-04 02:53:07','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (123,1,'2015-03-04 02:54:13','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (124,1,'2015-03-04 02:58:32','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (125,1,'2015-03-04 02:59:26','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (126,1,'2015-03-04 03:00:38','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (127,1,'2015-03-04 03:01:44','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (128,1,'2015-03-04 03:03:04','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (129,1,'2015-03-04 03:04:03','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (130,1,'2015-03-04 03:05:13','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (131,1,'2015-03-04 03:06:19','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (132,1,'2015-03-04 03:09:42','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (133,1,'2015-03-04 03:10:51','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (134,1,'2015-03-04 03:12:56','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (135,1,'2015-03-04 03:14:00','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (136,1,'2015-03-04 03:15:31','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (137,1,'2015-03-04 03:17:12','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (138,1,'2015-03-04 03:20:04','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (139,1,'2015-03-04 03:21:19','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (140,1,'2015-03-04 03:23:04','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (141,1,'2015-03-04 03:25:50','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (142,1,'2015-03-04 03:26:59','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (143,1,'2015-03-04 03:28:18','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (144,1,'2015-03-04 03:29:53','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (145,1,'2015-03-04 03:46:04','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (146,1,'2015-03-04 03:50:02','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (147,1,'2015-03-04 03:53:31','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (148,1,'2015-03-04 03:54:46','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (149,1,'2015-03-04 03:58:29','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (150,1,'2015-03-04 04:07:57','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (151,1,'2015-03-04 04:09:30','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (152,1,'2015-03-04 04:11:17','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (153,1,'2015-03-04 04:12:41','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (154,1,'2015-03-04 04:14:06','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (155,1,'2015-03-04 04:17:08','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (156,1,'2015-03-04 04:18:31','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (157,1,'2015-03-04 04:22:30','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (158,1,'2015-03-04 04:25:12','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (159,1,'2015-03-04 04:26:47','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (160,1,'2015-03-04 06:20:13','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (161,1,'2015-03-04 20:07:08','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (162,1,'2015-03-04 21:51:09','ASIGNA:GUIAS->COMPROBANTE[003-0077170]','DETALLEABASTECIMIENTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (163,1,'2015-03-05 00:46:17','REG MANTENIMIENTO','MANTENIMIENTO','::1','Google Chrome','Windows'),
 (164,1,'2015-03-05 01:08:11','INICION SESION','USUARIO','::1','Firefox','Windows'),
 (165,1,'2015-03-05 01:10:54','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Firefox','Windows'),
 (166,1,'2015-03-05 02:27:00','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (167,1,'2015-03-05 02:31:16','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (168,1,'2015-03-05 02:31:29','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (169,1,'2015-03-05 02:31:48','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (170,1,'2015-03-05 03:33:15','MODIFICA GUIA','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (171,1,'2015-03-05 03:33:24','MODIFICA GUIA','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (172,1,'2015-03-05 03:34:08','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (173,1,'2015-03-05 23:08:25','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (174,1,'2015-03-06 01:05:42','EDITAR TRABAJADOR12','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (175,1,'2015-03-06 01:06:44','EDITAR TRABAJADOR12','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (176,1,'2015-03-06 01:07:21','EDITAR TRABAJADOR12','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (177,1,'2015-03-06 01:07:21','EDITAR TRABAJADOR12','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (178,1,'2015-03-06 01:10:49','EDITAR TRABAJADOR12','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (179,1,'2015-03-06 01:11:24','EDITAR TRABAJADOR12','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (180,1,'2015-03-06 01:12:59','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (181,1,'2015-03-06 08:13:07','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (182,1,'2015-03-06 08:17:01','EDITAR TRABAJADOR3','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (183,1,'2015-03-06 08:48:22','EDITAR OBRA: 1','OBRA','::1','Google Chrome','Windows'),
 (184,1,'2015-03-06 08:48:33','EDITAR OBRA: 2','OBRA','::1','Google Chrome','Windows'),
 (185,1,'2015-03-06 08:48:39','EDITAR OBRA: 1','OBRA','::1','Google Chrome','Windows'),
 (186,1,'2015-03-06 08:48:45','EDITAR OBRA: 1','OBRA','::1','Google Chrome','Windows'),
 (187,1,'2015-03-06 08:48:50','EDITAR OBRA: 2','OBRA','::1','Google Chrome','Windows'),
 (188,1,'2015-03-06 09:32:09','EDITAR CLIENTE: 3','CLIENTE','::1','Google Chrome','Windows'),
 (189,1,'2015-03-06 09:32:16','EDITAR CLIENTE: 3','CLIENTE','::1','Google Chrome','Windows'),
 (190,1,'2015-03-06 09:32:41','EDITAR CLIENTE: 2','CLIENTE','::1','Google Chrome','Windows'),
 (191,1,'2015-03-06 09:32:55','EDITAR CLIENTE: 2','CLIENTE','::1','Google Chrome','Windows'),
 (192,1,'2015-03-06 11:03:48','EDITAR CONTRATO: 3','CONTRATO','::1','Google Chrome','Windows'),
 (193,1,'2015-03-06 11:04:16','EDITAR CONTRATO: 3','CONTRATO','::1','Google Chrome','Windows'),
 (194,1,'2015-03-06 12:06:58','REG VEHICULOS','VEHICULO, VEHICULOPH','::1','Google Chrome','Windows'),
 (195,1,'2015-03-06 12:26:05','EDITAR VEHICULO: 38','VEHICULO, VEHICULOPH','::1','Google Chrome','Windows'),
 (196,1,'2015-03-06 12:26:30','EDITAR VEHICULO: 38','VEHICULO, VEHICULOPH','::1','Google Chrome','Windows'),
 (197,1,'2015-03-06 13:44:50','EDITAR ARTICULO: 1','ARTICULO','::1','Google Chrome','Windows'),
 (198,1,'2015-03-06 13:45:03','EDITAR ARTICULO: 1','ARTICULO','::1','Google Chrome','Windows'),
 (199,1,'2015-03-06 14:58:10','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (200,1,'2015-03-06 17:07:26','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (201,1,'2015-03-06 17:49:20','EDITAR PARTE MAQUINARIA15','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (202,1,'2015-03-06 18:10:18','EDITAR PARTE MAQUINARIA15','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (203,1,'2015-03-06 18:10:46','EDITAR PARTE MAQUINARIA15','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (204,1,'2015-03-06 18:52:54','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (205,1,'2015-03-07 15:20:10','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (206,1,'2015-03-07 17:42:06','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (207,1,'2015-03-07 17:44:58','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (208,1,'2015-03-07 17:46:38','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (209,1,'2015-03-07 17:51:48','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (210,1,'2015-03-07 17:53:51','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (211,1,'2015-03-07 17:54:36','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (212,1,'2015-03-07 17:55:18','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (213,1,'2015-03-07 18:46:21','EDITAR ABASTECIMIENTO: 1','ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (214,1,'2015-03-07 18:46:52','EDITAR ABASTECIMIENTO: 1','ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (215,1,'2015-03-07 18:47:02','EDITAR ABASTECIMIENTO: 1','ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (216,1,'2015-03-07 19:48:15','REGISTRO TIPO: TIPO CLIENTE C','CLIENTE','::1','Google Chrome','Windows'),
 (217,1,'2015-03-07 19:55:11','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (218,1,'2015-03-07 19:55:43','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (219,1,'2015-03-07 21:30:51','GENERACION DE USUARIO PARA TRAB: 18','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (220,1,'2015-03-07 21:44:09','EDITAR TRABAJADOR18','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (221,18,'2015-03-07 21:44:38','INICION SESION','USUARIO','::1','Firefox','Windows'),
 (222,1,'2015-03-08 05:58:06','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (223,1,'2015-03-08 06:03:23','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (224,1,'2015-03-08 12:54:52','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (225,1,'2015-03-08 13:42:08','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (226,1,'2015-03-08 14:33:14','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (227,1,'2015-03-08 14:37:42','EDITAR CONSUMO: 67','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (228,1,'2015-03-08 15:13:07','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (229,1,'2015-03-08 15:13:45','EDITAR CONSUMO: 68','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (230,1,'2015-03-08 15:42:11','EDITAR PARTE MAQUINARIA5','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (231,1,'2015-03-08 15:43:03','EDITAR PARTE MAQUINARIA5','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (232,1,'2015-03-08 15:43:14','EDITAR PARTE MAQUINARIA5','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (233,1,'2015-03-08 15:45:19','EDITAR OBRA: 1','OBRA','::1','Google Chrome','Windows'),
 (234,1,'2015-03-08 15:45:25','EDITAR OBRA: 1','OBRA','::1','Google Chrome','Windows'),
 (235,1,'2015-03-08 15:48:18','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (236,1,'2015-03-08 15:51:05','ANULAR ALQUILER','DETALEALQUILER, VEHICULO','::1','Google Chrome','Windows'),
 (237,1,'2015-03-08 16:02:09','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (238,1,'2015-03-08 16:02:12','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (239,1,'2015-03-08 16:02:14','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (240,1,'2015-03-09 01:56:08','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (241,1,'2015-03-09 01:57:40','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (242,1,'2015-03-09 02:06:35','EDITAR CONSUMO: 70','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (243,1,'2015-03-09 02:08:47','EDITAR PARTE MAQUINARIA: 5','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (244,1,'2015-03-09 02:08:58','EDITAR PARTE MAQUINARIA: 5','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (245,1,'2015-03-09 02:15:32','REG MANTENIMIENTO','MANTENIMIENTO','::1','Google Chrome','Windows'),
 (246,1,'2015-03-09 02:17:06','EDITAR VEHICULO: 38','VEHICULO, VEHICULOPH','::1','Google Chrome','Windows'),
 (247,1,'2015-03-09 02:18:24','REG VEHICULOS','VEHICULO, VEHICULOPH','::1','Google Chrome','Windows'),
 (248,1,'2015-03-09 02:19:24','EDITAR VEHICULO: 44','VEHICULO, VEHICULOPH','::1','Google Chrome','Windows'),
 (249,1,'2015-03-09 02:21:20','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (250,1,'2015-03-09 02:30:36','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (251,1,'2015-03-09 02:36:31','REG DEVOL VEHICULO','DEVOLUCION','::1','Google Chrome','Windows'),
 (252,1,'2015-03-09 02:36:31','UPDATE','VEHICULO,TRABVEHICULO,DETALLEALQUILER','::1','Google Chrome','Windows'),
 (253,1,'2015-03-09 02:38:20','EDITAR ABASTECIMIENTO: 1','ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (254,1,'2015-03-09 02:38:27','EDITAR ABASTECIMIENTO: 1','ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (255,1,'2015-03-09 02:39:08','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (256,1,'2015-03-09 02:43:57','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (257,1,'2015-03-09 02:44:05','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (258,1,'2015-03-09 02:44:46','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (259,18,'2015-03-09 02:44:49','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (260,18,'2015-03-09 02:45:34','CIERRE SESION USER ID: 18','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (261,1,'2015-03-09 08:18:36','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (262,1,'2015-03-09 09:17:34','EDITAR PARTE MAQUINARIA: 5','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (263,18,'2015-03-09 09:47:20','INICION SESION','USUARIO','::1','Firefox','Windows'),
 (264,18,'2015-03-09 14:59:26','CIERRE SESION USER ID: 18','NOTIFICAMANT','::1','Firefox','Windows'),
 (265,1,'2015-03-09 16:00:34','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (266,1,'2015-03-09 18:08:31','REGISTRO TIPO: ABASTECEDOR','MARCA','::1','Google Chrome','Windows'),
 (267,1,'2015-03-14 19:50:02','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (268,1,'2015-03-16 22:42:27','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (269,1,'2015-03-17 02:28:48','EDITAR OBRA: 4','OBRA','::1','Google Chrome','Windows'),
 (270,1,'2015-03-17 02:28:55','EDITAR OBRA: 4','OBRA','::1','Google Chrome','Windows'),
 (271,1,'2015-03-22 10:21:33','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (272,1,'2015-03-22 12:49:27','REGISTRO TIPO: CLIENTE STANDARD','CLIENTE','::1','Google Chrome','Windows'),
 (273,1,'2015-03-22 12:51:00','REGISTRO TIPO: OBRA STANDARD','OBRA','::1','Google Chrome','Windows'),
 (274,1,'2015-03-22 13:15:20','UPDATE TIPO: TIPO ARTICULO ES','ARTICULO','::1','Google Chrome','Windows'),
 (275,1,'2015-03-22 13:15:57','UPDATE TIPO: TIPO ARTICULO ES','ARTICULO','::1','Google Chrome','Windows'),
 (276,1,'2015-03-22 13:16:11','UPDATE TIPO: TIPO ARTICULO E','ARTICULO','::1','Google Chrome','Windows'),
 (277,1,'2015-03-22 15:04:26','UPDATE TIPO: OBRA STANDARD','OBRA','::1','Google Chrome','Windows'),
 (278,1,'2015-03-22 16:22:53','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (279,1,'2015-03-22 18:13:17','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (280,1,'2015-03-22 18:29:59','REG ABASTECIMIENTO COMBUSTIBLE','ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (281,1,'2015-03-23 00:38:25','REG MANTENIMIENTO','MANTENIMIENTO','::1','Google Chrome','Windows'),
 (282,1,'2015-03-23 20:52:45','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (283,1,'2015-03-24 00:53:50','EDITAR CLIENTE: 2','CLIENTE','::1','Google Chrome','Windows'),
 (284,1,'2015-03-24 02:09:55','INICION SESION','USUARIO','::1','Firefox','Windows'),
 (285,1,'2015-03-24 02:20:54','INICION SESION','USUARIO','::1','Safari','Windows'),
 (286,1,'2015-03-24 02:23:46','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Safari','Windows'),
 (287,1,'2015-03-24 12:06:31','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (288,1,'2015-03-24 12:11:26','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (289,1,'2015-03-24 12:26:54','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (290,1,'2015-03-24 12:37:33','EDITAR PARTE MAQUINARIA: 16','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (291,1,'2015-03-24 12:53:26','EDITAR PARTE MAQUINARIA: 16','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (292,1,'2015-03-24 12:54:20','EDITAR PARTE MAQUINARIA: 16','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (293,1,'2015-03-24 13:05:01','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (294,1,'2015-03-24 13:28:55','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (295,1,'2015-03-24 13:30:22','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (296,1,'2015-03-24 13:45:30','REG DEVOL VEHICULO','DEVOLUCION','::1','Google Chrome','Windows'),
 (297,1,'2015-03-24 13:45:30','UPDATE','VEHICULO,TRABVEHICULO,DETALLEALQUILER','::1','Google Chrome','Windows'),
 (298,1,'2015-03-24 13:50:34','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (299,1,'2015-03-24 14:17:28','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (300,1,'2015-03-24 14:28:01','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (301,1,'2015-03-25 00:47:08','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (302,1,'2015-03-25 08:09:39','INICION SESION','USUARIO','192.168.5.199','Google Chrome','Linux'),
 (303,1,'2015-03-25 13:02:49','INICION SESION','USUARIO','192.168.5.220','Google Chrome','Windows'),
 (304,1,'2015-03-25 13:08:42','CIERRE SESION USER ID: 1','NOTIFICAMANT','192.168.5.220','Google Chrome','Windows'),
 (305,18,'2015-03-25 13:12:43','INICION SESION','USUARIO','::1','Firefox','Windows'),
 (306,18,'2015-03-25 13:15:49','EDITAR ABASTECIMIENTO: 2','ABASTECIMIENTO','::1','Firefox','Windows'),
 (307,18,'2015-03-25 13:16:02','EDITAR ABASTECIMIENTO: 2','ABASTECIMIENTO','::1','Firefox','Windows'),
 (308,18,'2015-03-25 13:18:42','CIERRE SESION USER ID: 18','NOTIFICAMANT','::1','Firefox','Windows'),
 (309,1,'2015-03-25 15:35:33','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (310,1,'2015-03-25 15:36:07','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (311,1,'2015-03-25 15:36:32','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (312,1,'2015-03-25 22:13:28','REGISTRO TIPO: SUPERVISOR','TRABAJADOR','::1','Google Chrome','Windows'),
 (313,1,'2015-03-25 22:13:46','UPDATE TIPO: SUPERVISORA','TRABAJADOR','::1','Google Chrome','Windows'),
 (314,1,'2015-03-25 22:13:54','UPDATE TIPO: SUPERVISORA','TRABAJADOR','::1','Google Chrome','Windows'),
 (315,1,'2015-03-25 22:14:08','UPDATE TIPO: SUPERVISOR','TRABAJADOR','::1','Google Chrome','Windows'),
 (316,1,'2015-03-25 22:29:32','GENERACION DE USUARIO PARA TRAB: 19','TRABAJADOR,USUARIO','::1','Google Chrome','Windows'),
 (317,19,'2015-03-25 22:31:17','INICION SESION','USUARIO','::1','Safari','Windows'),
 (318,19,'2015-03-25 22:34:10','CIERRE SESION USER ID: 19','NOTIFICAMANT','::1','Safari','Windows'),
 (319,1,'2015-03-25 22:41:58','REG OBRA','OBRA','::1','Google Chrome','Windows'),
 (320,1,'2015-03-25 22:43:39','EDITAR OBRA: 5','OBRA','::1','Google Chrome','Windows'),
 (321,1,'2015-03-25 22:43:46','EDITAR OBRA: 5','OBRA','::1','Google Chrome','Windows'),
 (322,1,'2015-03-25 23:09:12','REGISTRO CLIENTE: GRUPO CONSTRUCTOR ABC','CLIENTE','::1','Google Chrome','Windows'),
 (323,1,'2015-03-26 00:03:42','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (324,1,'2015-03-26 00:05:03','EDITAR CONTRATO: 4','CONTRATO','::1','Google Chrome','Windows'),
 (325,1,'2015-03-26 00:05:19','EDITAR CONTRATO: 4','CONTRATO','::1','Google Chrome','Windows'),
 (326,1,'2015-03-26 00:08:19','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (327,1,'2015-03-26 00:09:26','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (328,1,'2015-03-26 00:10:14','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (329,1,'2015-03-26 00:13:49','REG DEVOL VEHICULO','DEVOLUCION','::1','Google Chrome','Windows'),
 (330,1,'2015-03-26 00:13:49','UPDATE','VEHICULO,TRABVEHICULO,DETALLEALQUILER','::1','Google Chrome','Windows'),
 (331,1,'2015-03-26 00:15:23','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (332,1,'2015-03-26 00:15:41','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (333,1,'2015-03-26 00:19:25','ASIGNACION VEHICULO OPERADOR','TRABVEHICULO','::1','Google Chrome','Windows'),
 (334,1,'2015-03-26 00:26:39','REG DEVOL VEHICULO','DEVOLUCION','::1','Google Chrome','Windows'),
 (335,1,'2015-03-26 00:26:39','UPDATE','VEHICULO,TRABVEHICULO,DETALLEALQUILER','::1','Google Chrome','Windows'),
 (336,1,'2015-03-26 00:29:55','ANULAR ALQUILER','DETALEALQUILER, VEHICULO','::1','Google Chrome','Windows'),
 (337,1,'2015-03-26 00:33:34','MODIFICA GUIA','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (338,1,'2015-03-26 00:47:54','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (339,1,'2015-03-26 00:51:16','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (340,1,'2015-03-26 00:56:15','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (341,1,'2015-03-26 00:58:52','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (342,1,'2015-03-26 01:04:55','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (343,1,'2015-03-26 01:05:59','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (344,1,'2015-03-26 01:10:58','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (345,1,'2015-03-26 08:11:56','REG VEHICULOS','VEHICULO, VEHICULOPH','::1','Google Chrome','Windows'),
 (346,1,'2015-03-26 08:22:05','REG MANTENIMIENTO','MANTENIMIENTO','::1','Google Chrome','Windows'),
 (347,1,'2015-03-26 08:25:10','EDITAR ARTICULO: 2','ARTICULO','::1','Google Chrome','Windows'),
 (348,1,'2015-03-26 08:25:26','EDITAR ARTICULO: 2','ARTICULO','::1','Google Chrome','Windows'),
 (349,1,'2015-03-26 08:28:38','REG ARTICULOS','ARTICULO','::1','Google Chrome','Windows'),
 (350,1,'2015-03-26 08:29:45','EDITAR ABASTECIMIENTO: 1','ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (351,1,'2015-03-26 08:41:16','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (352,1,'2015-03-26 08:46:24','REG ABASTECIMIENTO COMBUSTIBLE','ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (353,1,'2015-03-26 08:50:20','ASIGNA:GUIAS->COMPROBANTE[003-0077172]','DETALLEABASTECIMIENTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (354,1,'2015-03-26 08:50:42','ASIGNA:GUIAS->COMPROBANTE[003-0077172]','DETALLEABASTECIMIENTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (355,1,'2015-03-26 08:54:36','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (356,1,'2015-03-26 08:54:52','ASIGNA:GUIAS->COMPROBANTE[003-0077172]','DETALLEABASTECIMIENTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (357,1,'2015-03-26 08:57:13','DESASIGNA GUIA','DETALLEABASTECIMEINTO,ABASTECIMIENTO','::1','Google Chrome','Windows'),
 (358,1,'2015-03-26 09:15:56','EDITAR PARTE MAQUINARIA: 17','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (359,1,'2015-03-26 09:32:26','FINALIZACIÓN DEL CONTRATO: 4','VEHICULO,ARTICULO,DETALLEALQUILER,TRABVEHICULO,DEVOLUCION,OBRA,CONTRATO','::1','Google Chrome','Windows'),
 (360,1,'2015-03-26 09:51:04','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (361,1,'2015-03-26 11:09:53','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (362,1,'2015-03-26 13:29:39','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (363,1,'2015-03-26 13:41:14','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (364,1,'2015-03-26 13:42:57','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (365,1,'2015-03-26 13:44:07','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (366,1,'2015-03-26 13:46:43','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (367,1,'2015-03-26 14:08:50','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (368,1,'2015-03-27 09:48:17','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (369,1,'2015-03-28 21:15:12','INICION SESION','USUARIO','::1','Google Chrome','Windows'),
 (370,0,'2015-03-29 00:32:36','INICION SESION','USUARIO: HCUMBICUSR','','',''),
 (371,0,'2015-03-29 00:36:47','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (372,0,'2015-03-29 00:39:02','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (373,0,'2015-03-29 00:39:03','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (374,0,'2015-03-29 00:39:03','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (375,0,'2015-03-29 00:39:04','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (376,0,'2015-03-29 00:39:04','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (377,0,'2015-03-29 00:39:04','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (378,0,'2015-03-29 00:40:27','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (379,0,'2015-03-29 00:40:30','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (380,0,'2015-03-29 00:41:55','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (381,0,'2015-03-29 00:41:56','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (382,0,'2015-03-29 00:41:57','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (383,0,'2015-03-29 00:44:38','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (384,0,'2015-03-29 00:47:02','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (385,0,'2015-03-29 00:47:03','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR','','',''),
 (386,0,'2015-03-29 00:48:02','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR241014','','',''),
 (387,0,'2015-03-29 00:48:32','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR241014','','',''),
 (388,0,'2015-03-29 00:49:16','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR241014','','',''),
 (389,0,'2015-03-29 00:49:38','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR241014','','',''),
 (390,1,'2015-03-29 00:51:23','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (391,0,'2015-03-29 00:51:27','INICIO SESION: FALLIDO','USUARIO: ADMIN','::1','Google Chrome','Windows'),
 (392,1,'2015-03-29 00:51:37','INICIO SESION: CORRECTO','USUARIO: ADMIN','::1','Google Chrome','Windows'),
 (393,1,'2015-03-29 00:53:50','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (394,0,'2015-03-29 00:54:00','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR102414','::1','Google Chrome','Windows'),
 (395,0,'2015-03-29 00:54:14','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR241014','::1','Google Chrome','Windows'),
 (396,20,'2015-03-29 01:02:49','CIERRE SESION USER ID: 20','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (397,20,'2015-03-29 01:03:59','INICIO SESION: CORRECTO','USUARIO: HCUMBICUSR241014','::1','Google Chrome','Windows'),
 (398,20,'2015-03-29 01:07:53','CIERRE SESION USER ID: 20','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (399,20,'2015-03-29 01:10:08','INICIO SESION: CORRECTO','USUARIO: HCUMBICUSR241014','::1','Google Chrome','Windows'),
 (400,20,'2015-03-29 01:10:29','CIERRE SESION USER ID: 20','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (401,1,'2015-03-29 01:10:33','INICIO SESION: CORRECTO','USUARIO: ADMIN','::1','Google Chrome','Windows'),
 (402,1,'2015-03-29 01:11:19','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (403,0,'2015-03-29 01:11:30','INICIO SESION: FALLIDO','USUARIO: HCUMBICUSR241014','::1','Google Chrome','Windows'),
 (404,20,'2015-03-29 01:11:45','INICIO SESION: CORRECTO','USUARIO: HCUMBICUSR241014','::1','Google Chrome','Windows'),
 (405,20,'2015-03-29 01:13:54','CIERRE SESION USER ID: 20','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (406,1,'2015-03-29 01:14:15','INICIO SESION: CORRECTO','USUARIO: ADMIN','::1','Google Chrome','Windows'),
 (407,1,'2015-03-29 01:14:38','CIERRE SESION USER ID: 1','NOTIFICAMANT','::1','Google Chrome','Windows'),
 (408,1,'2015-03-29 01:25:31','INICIO SESION: CORRECTO','USUARIO: ADMIN','::1','Google Chrome','Windows'),
 (409,1,'2015-03-29 01:43:07','CIERRE SESION USER ID: 1','USUARIO','::1','Google Chrome','Windows');
/*!40000 ALTER TABLE `regs` ENABLE KEYS */;


--
-- Definition of table `tipoarticulo`
--

DROP TABLE IF EXISTS `tipoarticulo`;
CREATE TABLE `tipoarticulo` (
  `id_tipoarticulo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipoarticulo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipoarticulo`
--

/*!40000 ALTER TABLE `tipoarticulo` DISABLE KEYS */;
INSERT INTO `tipoarticulo` (`id_tipoarticulo`,`nombre`,`estado`) VALUES 
 (1,'TIPO ARTICULO A','A'),
 (2,'TIPO ARTICULO B','A'),
 (3,'TIPO ARTICULO C','A'),
 (4,'TIPO ARTICULO D','A'),
 (5,'TIPO ARTICULO E','A');
/*!40000 ALTER TABLE `tipoarticulo` ENABLE KEYS */;


--
-- Definition of table `tipocliente`
--

DROP TABLE IF EXISTS `tipocliente`;
CREATE TABLE `tipocliente` (
  `id_tipocliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipocliente`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipocliente`
--

/*!40000 ALTER TABLE `tipocliente` DISABLE KEYS */;
INSERT INTO `tipocliente` (`id_tipocliente`,`nombre`,`estado`) VALUES 
 (1,'TIPO CLIENTE A','A'),
 (2,'TIPO CLIENTE B','A'),
 (3,'TIPO CLIENTE C','A'),
 (4,'CLIENTE STANDARD','A');
/*!40000 ALTER TABLE `tipocliente` ENABLE KEYS */;


--
-- Definition of table `tipocombustible`
--

DROP TABLE IF EXISTS `tipocombustible`;
CREATE TABLE `tipocombustible` (
  `id_tipocombustible` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `unidad` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'GLNS',
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipocombustible`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipocombustible`
--

/*!40000 ALTER TABLE `tipocombustible` DISABLE KEYS */;
INSERT INTO `tipocombustible` (`id_tipocombustible`,`nombre`,`unidad`,`estado`) VALUES 
 (1,'PETRÓLEO','GLNS','A'),
 (2,'GASOLINA','GLNS','A'),
 (3,'GAS','GLNS','B');
/*!40000 ALTER TABLE `tipocombustible` ENABLE KEYS */;


--
-- Definition of table `tipocomprobante`
--

DROP TABLE IF EXISTS `tipocomprobante`;
CREATE TABLE `tipocomprobante` (
  `id_tipocomprobante` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipocomprobante`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipocomprobante`
--

/*!40000 ALTER TABLE `tipocomprobante` DISABLE KEYS */;
INSERT INTO `tipocomprobante` (`id_tipocomprobante`,`nombre`,`estado`) VALUES 
 (1,'FACTURA','A'),
 (2,'BOLETA','A'),
 (3,'TICKET','A');
/*!40000 ALTER TABLE `tipocomprobante` ENABLE KEYS */;


--
-- Definition of table `tipoobra`
--

DROP TABLE IF EXISTS `tipoobra`;
CREATE TABLE `tipoobra` (
  `id_tipoobra` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipoobra`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipoobra`
--

/*!40000 ALTER TABLE `tipoobra` DISABLE KEYS */;
INSERT INTO `tipoobra` (`id_tipoobra`,`nombre`,`estado`) VALUES 
 (1,'TIPO OBRA A','A'),
 (2,'TIPO OBRA B','A'),
 (3,'OBRA STANDARD','A');
/*!40000 ALTER TABLE `tipoobra` ENABLE KEYS */;


--
-- Definition of table `tipotrabajador`
--

DROP TABLE IF EXISTS `tipotrabajador`;
CREATE TABLE `tipotrabajador` (
  `id_tipotrabajador` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipotrabajador`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipotrabajador`
--

/*!40000 ALTER TABLE `tipotrabajador` DISABLE KEYS */;
INSERT INTO `tipotrabajador` (`id_tipotrabajador`,`nombre`,`estado`) VALUES 
 (1,'OPERARIO','A'),
 (2,'CONTROLADOR','A'),
 (3,'SUPERVISOR','A');
/*!40000 ALTER TABLE `tipotrabajador` ENABLE KEYS */;


--
-- Definition of table `tipousuario`
--

DROP TABLE IF EXISTS `tipousuario`;
CREATE TABLE `tipousuario` (
  `id_tipousuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipousuario`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipousuario`
--

/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` (`id_tipousuario`,`nombre`,`estado`) VALUES 
 (1,'OPERARIO','A'),
 (2,'CONTROLADOR','A'),
 (3,'ADMINISTRADOR','A');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;


--
-- Definition of table `tipovehiculo`
--

DROP TABLE IF EXISTS `tipovehiculo`;
CREATE TABLE `tipovehiculo` (
  `id_tipovehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipovehiculo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipovehiculo`
--

/*!40000 ALTER TABLE `tipovehiculo` DISABLE KEYS */;
INSERT INTO `tipovehiculo` (`id_tipovehiculo`,`nombre`,`estado`) VALUES 
 (1,'MAQUINARIA PESADA','A'),
 (2,'VOLQUETES','A'),
 (3,'CAMIONES','A'),
 (4,'CAMIONETAS','A'),
 (5,'SURTIDOR','A');
/*!40000 ALTER TABLE `tipovehiculo` ENABLE KEYS */;


--
-- Definition of table `trabajador`
--

DROP TABLE IF EXISTS `trabajador`;
CREATE TABLE `trabajador` (
  `id_trabajador` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipotrabajador` int(11) NOT NULL DEFAULT '1',
  `apellidos` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `nombres` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fecha_nac` date DEFAULT NULL,
  `dni` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `ruc` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nro_licencia` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_trabajador`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trabajador`
--

/*!40000 ALTER TABLE `trabajador` DISABLE KEYS */;
INSERT INTO `trabajador` (`id_trabajador`,`id_tipotrabajador`,`apellidos`,`nombres`,`fecha_nac`,`dni`,`ruc`,`telefono`,`nro_licencia`,`estado`) VALUES 
 (1,0,'ADMIN','ADMIN','0000-00-00','00000000','0000000000','000000000','00000000','A'),
 (2,1,'RAMOS INGA','FIDEL','1980-04-04','11111111','','','01','A'),
 (3,1,'GÁLVEZ ALBURQUEQUE','JAVIER','1980-05-05','22222222','','','02','A'),
 (4,1,'SANTIAGO MARCELO','LUIS','1980-03-03','33333333','','','03','A'),
 (5,1,'MERINO AGUILAR','PEDRO','1985-03-09','44444444','','','04','A'),
 (6,1,'VALENCIA','JHONY','1977-02-01','55555555','','','05','A'),
 (7,1,'VALENCIA','ROBERTO','1985-03-29','66666666','','','06','A'),
 (8,1,'MORALES','JIMMY','1982-08-31','77777777','','','07','A'),
 (9,1,'RAMOS','RONALD','1990-06-27','88888888','','','08','A'),
 (10,1,'RAMOS','PEDRO','1986-08-29','99999999','','','09','A'),
 (11,1,'RAMOS','SANTOS','1986-05-28','10101010','','','10','A'),
 (12,1,'CHAVEZ','DARWIN','1987-07-29','20202020','','','11','A'),
 (13,1,'CHAVEZ','JOSÉ','1984-07-27','30303030','','','12','A'),
 (14,1,'CURAY ABAD','PEDRO','1984-08-27','40404040','','','13','A'),
 (15,1,'HIDALGO','PEDRO','1980-03-13','50505050','','','14','A'),
 (16,1,'REYES','JOSÉ','1985-06-24','12121212','','','15','A'),
 (17,1,'GUERRERO','JOSÉ','1973-09-24','13131313','','','16','A'),
 (18,2,'MONTERO RUÍZ','EDGARD','1977-12-29','03029485','','','','A'),
 (19,3,'SALAZAR MEDINA','ÁNGEL','1987-03-10','03067233','','','','A');
/*!40000 ALTER TABLE `trabajador` ENABLE KEYS */;


--
-- Definition of table `trabvehiculo`
--

DROP TABLE IF EXISTS `trabvehiculo`;
CREATE TABLE `trabvehiculo` (
  `id_trabvehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `id_detallealquiler` int(11) NOT NULL,
  `id_trabajador` int(11) NOT NULL,
  `f_inicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `f_fin` timestamp NULL DEFAULT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_trabvehiculo`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trabvehiculo`
--

/*!40000 ALTER TABLE `trabvehiculo` DISABLE KEYS */;
INSERT INTO `trabvehiculo` (`id_trabvehiculo`,`id_detallealquiler`,`id_trabajador`,`f_inicio`,`f_fin`,`estado`) VALUES 
 (1,1,2,'2014-12-04 00:00:00',NULL,'B'),
 (2,1,3,'2014-12-01 00:00:00',NULL,'A'),
 (3,3,2,'2014-12-03 00:00:00',NULL,'A'),
 (4,4,5,'2014-12-02 00:00:00',NULL,'A'),
 (5,7,10,'2014-12-09 00:00:00',NULL,'A'),
 (6,8,17,'2014-12-08 00:00:00',NULL,'A'),
 (7,2,7,'2014-12-02 00:00:00',NULL,'A'),
 (8,6,11,'2014-12-03 00:00:00',NULL,'A'),
 (9,5,16,'2014-12-08 00:00:00',NULL,'A'),
 (10,10,8,'2014-11-29 00:00:00','2015-03-02 00:00:00','B'),
 (11,15,4,'2015-01-01 00:00:00','2015-03-26 00:00:00','B');
/*!40000 ALTER TABLE `trabvehiculo` ENABLE KEYS */;


--
-- Definition of table `transporte`
--

DROP TABLE IF EXISTS `transporte`;
CREATE TABLE `transporte` (
  `id_transporte` int(11) NOT NULL AUTO_INCREMENT,
  `id_detallealquiler` int(11) NOT NULL,
  `concepto` varchar(200) DEFAULT NULL,
  `observacion` varchar(400) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `monto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_transporte`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transporte`
--

/*!40000 ALTER TABLE `transporte` DISABLE KEYS */;
INSERT INTO `transporte` (`id_transporte`,`id_detallealquiler`,`concepto`,`observacion`,`fecha`,`monto`) VALUES 
 (1,10,'MOVILIZACIÓN','NADA','2014-12-30 00:00:00','1200.00'),
 (2,14,'MOVILIZACIÓN','UNA OBSERVACIÓN DE MOVILIZACIÓN','2015-01-02 00:00:00','1200.00');
/*!40000 ALTER TABLE `transporte` ENABLE KEYS */;


--
-- Definition of table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_trabajador` int(11) NOT NULL,
  `id_tipousuario` int(11) NOT NULL,
  `nombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `clave` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  `f_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `f_modificacion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `f_ultimo_acceso` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `f_cierre_sesion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cambio_clave` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `usuario`
--

/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id_usuario`,`id_trabajador`,`id_tipousuario`,`nombre`,`clave`,`estado`,`f_registro`,`f_modificacion`,`f_ultimo_acceso`,`f_cierre_sesion`,`cambio_clave`) VALUES 
 (1,1,3,'admin','e10adc3949ba59abbe56e057f20f883e','A','2015-02-08 14:43:51','2015-03-09 02:40:06','2015-03-29 01:25:31','2015-03-29 01:43:07',1),
 (2,2,1,'framos11','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:01:06','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (3,3,1,'jgalvez22','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:02:14','2015-03-06 08:17:01','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (4,4,1,'lsantiago33','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:03:15','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (5,5,1,'pmerino44','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:04:15','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (6,6,1,'j55','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:06:41','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (7,7,1,'r66','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:08:28','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (8,8,1,'j77','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:09:05','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (9,9,1,'r88','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:10:03','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (10,10,1,'p99','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:11:29','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (11,11,1,'s10','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:11:59','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (12,12,1,'d20','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:13:02','2015-03-06 01:11:24','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (13,13,1,'j30','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:13:38','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (14,14,1,'pcuray40','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:14:21','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (15,15,1,'p50','e10adc3949ba59abbe56e057f20f883e','A','2015-03-02 23:14:54','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (16,16,1,'j12','e10adc3949ba59abbe56e057f20f883e','A','2015-03-03 01:56:45','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (17,17,1,'j13','e10adc3949ba59abbe56e057f20f883e','A','2015-03-03 01:57:25','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (18,18,2,'emontero85','e10adc3949ba59abbe56e057f20f883e','A','2015-03-07 21:30:50','2015-03-07 21:44:08','2015-03-25 13:12:43','2015-03-25 13:18:42',0),
 (19,19,3,'asalazar33','e10adc3949ba59abbe56e057f20f883e','A','2015-03-25 22:29:32','0000-00-00 00:00:00','2015-03-25 22:31:17','2015-03-25 22:34:10',0),
 (20,0,0,'hcumbicusr241014','219dc1b0ebd8fb9b5a9fa672b13f919f','S','2015-03-28 21:04:44','0000-00-00 00:00:00','2015-03-29 01:11:45','2015-03-29 01:13:53',1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;


--
-- Definition of table `vehiculo`
--

DROP TABLE IF EXISTS `vehiculo`;
CREATE TABLE `vehiculo` (
  `id_vehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `id_marca` int(11) NOT NULL,
  `id_tipovehiculo` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `modelo` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `serie` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `motor` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `placa` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rendimiento` varchar(10) COLLATE utf8_unicode_ci DEFAULT '0',
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  `horometro_ac` decimal(10,2) NOT NULL,
  `kilometraje_ac` decimal(10,2) NOT NULL,
  `precio_alq` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_vehiculo`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `vehiculo`
--

/*!40000 ALTER TABLE `vehiculo` DISABLE KEYS */;
INSERT INTO `vehiculo` (`id_vehiculo`,`id_marca`,`id_tipovehiculo`,`nombre`,`modelo`,`serie`,`motor`,`color`,`placa`,`rendimiento`,`estado`,`horometro_ac`,`kilometraje_ac`,`precio_alq`) VALUES 
 (1,1,1,'TRACTOR SOBRE ORUGAS','D7G','92E-2876','55-6777',' ',' ','0','C','2034.00','1234.00','240.00'),
 (2,9,4,'CAMIONETA',' ',' ',' ',' ','B4J-831','0','A','0.00','0.00','240.00'),
 (3,1,1,'EXCAVADORA SOBRE ORUGAS Nro 01','320 C','0FBA-01122','7JK-59396',' ',' ','0','C','2010.00','0.00','240.00'),
 (4,1,1,'EXCAVADORA SOBRE ORUGAS Nro 02','320 C','0FBA-03503','07JK-05242',' ',' ','0','C','2865.70','0.00','240.00'),
 (5,1,1,'EXCAVADORA SOBRE ORUGAS Nro 03','320 CL','SBN02008','MAE10063',' ',' ','0','A','2065.50','1500.00','240.00'),
 (6,1,1,'EXCAVADORA SOBRE ORUGAS Nro 04','324 DL','DFP01154','KHX41907',' ',' ','0','C','4722.40','0.00','240.00'),
 (7,1,1,'EXCAVADORA SOBRE ORUGAS Nro 01','336DL','M4T01576','THX37070',' ',' ','0','A','0.00','0.00','240.00'),
 (8,1,1,'EXCAVADORA SOBRE ORUGAS Nro 02','336DL','M4T01252','THX34817',' ',' ','0','A','0.00','0.00','240.00'),
 (9,1,1,'TRACTOR SOBRE ORUGAS Nro 01','D7RII','0AEC01830','07ZR23926',' ',' ','0','C','12841.00','0.00','240.00'),
 (10,1,1,'TRACTOR SOBRE ORUGAS Nro 02','D7RII','0AEC02001','07ZR24462',' ',' ','0','A','2345.60','3452.50','240.00'),
 (12,1,1,'TRACTOR SOBRE ORUGAS Nro 03','D7RII','0AEC01909','07ZR24215',' ',' ','0','A','34900.00','0.00','240.00'),
 (13,1,1,'TRACTOR SOBRE ORUGAS Nro 01','D8T','J8B03317','TXG05157',' ',' ','0','A','0.00','0.00','240.00'),
 (14,1,1,'TRACTOR SOBRE ORUGAS Nro 02','D8T','J8B03072','TXG03883',' ',' ','0','A','0.00','0.00','240.00'),
 (15,2,1,'TRACTOR SOBRE ORUGAS C/RIPPER','FD9-FA-120','8065.25.096','',' ',' ','0','C','642.20','0.00','240.00'),
 (16,1,1,'RETROEXCAVADORA Nro 01','420D','FDP18886','CRS01348',' ',' ','0','A','0.00','0.00','240.00'),
 (17,1,1,'RETROEXCAVADORA Nro 02','420D','FDP25583','CRS28385',' ',' ','0','C','1219.90','0.00','240.00'),
 (18,2,1,'TRACTOR AGRÍCOLA Nro 01','7066DT','286218',' ',' ',' ','0','A','0.00','0.00','240.00'),
 (19,2,1,'TRACTOR AGRÍCOLA Nro 03','7066DT','8045-06','*071343*',' ',' ','0','C','2011.00','0.00','240.00'),
 (20,2,1,'TRACTOR AGRÍCOLA Nro 04','7066DT','8045-06','*307-454287*',' ',' ','0','A','0.00','0.00','240.00'),
 (21,1,1,'CARGADOR FRONTAL','938H','JKM01803','G9G04934',' ',' ','0','A','23006.00','1200.00','240.00'),
 (22,8,3,'CAMIÓN',' ',' ','',' ','P2U-886','0','D','0.00','0.00','240.00'),
 (23,3,3,'CAMIÓN',' ',' ','',' ','P2W-828','0','C','233653.00','0.00','240.00'),
 (24,4,4,'CAMIONETA',' ',' ','',' ','P2W-833','0','A','0.00','0.00','240.00'),
 (25,4,4,'CAMIONETA',' ',' ','',' ','P2K-786','0','C','71609.00','0.00','240.00'),
 (26,4,4,'CAMIONETA',' ',' ','',' ','P3C-771','0','C','660.00','0.00','240.00'),
 (27,3,4,'CAMIONETA',' ',' ','',' ','P2G-253','0','D','0.00','0.00','240.00'),
 (28,7,4,'CAMIONETA',' ',' ','',' ','P2J-926','0','A','0.00','0.00','240.00'),
 (29,3,4,'CAMIONETA',' ',' ','',' ','P1N-388','0','A','0.00','0.00','240.00'),
 (30,3,4,'CAMIONETA',' ',' ','',' ','P1L-247','0','A','0.00','0.00','240.00'),
 (31,4,4,'CAMIONETA',' ',' ','',' ','P2F-772','0','A','0.00','0.00','240.00'),
 (32,5,3,'CAMIÓN',' ',' ','',' ','P3G-742','0','D','0.00','0.00','240.00'),
 (33,5,3,'CAMIÓN',' ',' ','',' ','P3D-898','0','D','0.00','0.00','240.00'),
 (34,5,3,'CAMIÓN',' ',' ','',' ','P3D-885','0','D','0.00','0.00','240.00'),
 (35,6,3,'CAMIÓN',' ',' ','',' ','AAY-840','0','A','0.00','0.00','240.00'),
 (36,6,3,'CAMIÓN',' ',' ','',' ','ABA-852','0','A','0.00','0.00','240.00'),
 (37,6,2,'REMOLCADOR',' ',' ','',' ','AAO-915','0','A','0.00','0.00','240.00'),
 (38,3,5,'VECHÍCULO SURTIDOR','SURTIDOR','SURTID','SURTID','SURTID','P3H-833','0','G','0.00','0.00','240.00'),
 (42,2,1,'TRACTOR AGRÍCOLA Nro 02','7066DT','286218',' ',' ',' ','0','A','0.00','0.00','240.00'),
 (43,1,1,'MAQUINARIA  MOD 3 DE PRUEBA CAT001','MOD3','SER0001','MOT0001','AMARILLO C','000-00','0.26','A','0.00','0.00','245.00');
/*!40000 ALTER TABLE `vehiculo` ENABLE KEYS */;


--
-- Definition of procedure `sp_anular_alquiler_vehiculo`
--

DROP PROCEDURE IF EXISTS `sp_anular_alquiler_vehiculo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_anular_alquiler_vehiculo`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_detallealquiler_i int,
out salida varchar(10)
)
BEGIN

DECLARE id_v int;
DECLARE est_a char(1);
DECLARE est_b char(1);

-- handler para Transaccion
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

-- inicio de transaccion
START TRANSACTION;

## estado actual del alquiler
SELECT est_alq into est_a FROM detallealquiler WHERE id_detallealquiler = id_detallealquiler_i;

# se obtiene el id del vehiculo
SELECT id_vehiculo into id_v FROM detallealquiler WHERE id_detallealquiler = id_detallealquiler_i;

## estado ==> I = ANULADO
UPDATE detallealquiler SET est_alq = 'I' WHERE id_detallealquiler = id_detallealquiler_i;

### se devuelve el estado del vehiculo a ==>> D => disponible
UPDATE vehiculo SET estado = 'D'WHERE id_vehiculo = id_v;

## estado anulado del alquiler
SELECT estado into est_b FROM detallealquiler WHERE id_detallealquiler = id_detallealquiler_i;


if (est_a <> est_b) then

  SET salida = 'OK';

  CALL sp_regs(id_usuario_i,'ANULAR ALQUILER','detalealquiler, vehiculo',ip,nav,so);

  -- todo bien
  COMMIT;
else
  -- algo mal
  ROLLBACK;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_asignar_guias_fechas`
--

DROP PROCEDURE IF EXISTS `sp_asignar_guias_fechas`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignar_guias_fechas`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in comprobante varchar(25),
in desde date,
in hasta date,
out salida int
)
BEGIN

DECLARE id_a int;
declare n int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

SELECT ifnull(id_abastecimiento,0) into id_a FROM abastecimiento WHERE nro_comprobante = comprobante;

if (id_a > 0) then

UPDATE detalleabastecimiento SET id_abastecimiento = id_a
WHERE (id_abastecimiento = 0) AND (date(fecha) BETWEEN date(desde) AND date(hasta));

SELECT ifnull(count(*),0) into n FROM detalleabastecimiento
WHERE (id_abastecimiento = id_a) AND (date(fecha) BETWEEN date(desde) AND date(hasta));

UPDATE abastecimiento
SET cantidad_guia =
(SELECT SUM(cantidad) FROM detalleabastecimiento
WHERE id_abastecimiento = id_a) WHERE id_abastecimiento = id_a;

COMMIT;

set salida = n;

CALL sp_regs(id_usuario_i,concat('ASIGNA:GUIAS->COMPROBANTE[',comprobante,']'),'detalleabastecimiento,abastecimiento',ip,nav,so);

else

ROLLBACK;

set salida = 0;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_cierre_sesion`
--

DROP PROCEDURE IF EXISTS `sp_cierre_sesion`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cierre_sesion`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50)
)
BEGIN

UPDATE usuario SET f_cierre_sesion = now() WHERE id_usuario = id_usuario_i;

CALL sp_regs(id_usuario_i,concat('CIERRE SESION USER ID: ',id_usuario_i),'usuario',ip,nav,so);

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_combo`
--

DROP PROCEDURE IF EXISTS `sp_combo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_combo`(
in tabla varchar(50)
)
BEGIN

CASE lower(tabla)

  WHEN 'almacen' THEN SELECT id_almacen as id, nombre FROM almacen WHERE estado = 'A';
  WHEN 'marca' THEN SELECT id_marca as id, nombre FROM marca WHERE estado = 'A';
  WHEN 'tipoarticulo' THEN SELECT id_tipoarticulo as id, nombre FROM tipoarticulo WHERE estado = 'A';
  WHEN 'cliente' THEN SELECT id_tipocliente as id, nombre FROM tipocliente WHERE estado = 'A';
  WHEN 'tipocombustible' THEN SELECT id_tipocombustible as id, nombre FROM tipocombustible WHERE estado = 'A';
  WHEN 'tipocomprobante' THEN SELECT id_tipocomprobante as id, nombre FROM tipocomprobante WHERE estado = 'A';
  WHEN 'obra' THEN SELECT id_obra as id, nombre FROM obra WHERE estado = 'A';
  WHEN 'tipoobra' THEN SELECT id_tipoobra as id, nombre FROM tipoobra WHERE estado = 'A';
  when 'tipotrabajador' THEN SELECT id_tipotrabajador as id, nombre FROM tipotrabajador;
  when 'tipousuario' THEN SELECT id_tipousuario as id, nombre FROM tipousuario;
  when 'estado' THEN SELECT id_estado as id, nombre FROM estado WHERE estado = 'A';
  #############vehiculos que tiene un contrato
  WHEN 'vehiculo' THEN SELECT id_vehiculo as id, CONCAT(ifnull(nombre,''),' ',ifnull(modelo,''),' ',ifnull(color,''),' ',ifnull(placa,''),' ',ifnull(serie,'')) as nombre FROM vehiculo WHERE estado = 'C';

  ############# vehiculo cuyo tipo = surtidor
  WHEN 'vehiculo_s' THEN SELECT v.id_vehiculo as id, CONCAT(ifnull(v.nombre,''),' ',ifnull(v.modelo,''),' ',ifnull(v.color,''),' ',ifnull(v.placa,''),' ',ifnull(v.serie,'')) as nombre
  FROM vehiculo v
  INNER JOIN tipovehiculo tv ON tv.id_tipovehiculo = v.id_tipovehiculo
  WHERE tv.nombre = 'SURTIDOR';

  ##################vehiculos que se encuentran disponibles
  WHEN 'vehiculo_d' THEN SELECT id_vehiculo as id, CONCAT(ifnull(nombre,''),' ',ifnull(modelo,''),' ',ifnull(color,''),' ',ifnull(placa,''),' ',ifnull(serie,'')) as nombre FROM vehiculo WHERE estado = 'D';

  WHEN 'tipovehiculo' THEN SELECT id_tipovehiculo as id, nombre FROM tipovehiculo WHERE estado = 'A';

  WHEN 'responsable' THEN SELECT t.id_trabajador as id,CONCAT(t.apellidos,', ',t.nombres) as nombre FROM trabajador t
                                 INNER JOIN tipotrabajador tt ON tt.id_tipotrabajador = t.id_tipotrabajador
                                 WHERE tt.nombre <> 'OPERARIO' AND t.estado = 'A' ORDER BY t.apellidos;
  ## operarios que no tengan un trabajo asignado
  WHEN 'operario' THEN SELECT t.id_trabajador as id,CONCAT(t.apellidos,', ',t.nombres) as nombre FROM trabajador t
                                 INNER JOIN tipotrabajador tt ON tt.id_tipotrabajador = t.id_tipotrabajador
                                 LEFT JOIN trabvehiculo tv ON t.id_trabajador = tv.id_trabajador
                                 WHERE tt.nombre = 'OPERARIO' AND t.estado = 'A'
                                 AND t.id_trabajador NOT IN (SELECT id_trabajador FROM trabvehiculo WHERE estado = 'A')
                                 GROUP BY t.id_trabajador ORDER BY t.apellidos;
  ELSE SELECT NULL;

END CASE;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_crear_usuario`
--

DROP PROCEDURE IF EXISTS `sp_crear_usuario`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_usuario`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_trabajador_i int,
in id_tipo_u_i int,
out salida varchar(10)
)
BEGIN

DECLARE usu varchar(30);
DECLARE n int;

set n = 0;

SELECT lower( concat( substr(nombres,1,1), substr(apellidos,1,locate(' ',apellidos)-1), substr(dni,7,8) ) ) INTO usu
FROM trabajador
WHERE id_trabajador = id_trabajador_i;

SET usu = REPLACE (usu,'á','a');
SET usu = REPLACE (usu,'é','e');
SET usu = REPLACE (usu,'í','i');
SET usu = REPLACE (usu,'ó','o');
SET usu = REPLACE (usu,'ú','u');

INSERT INTO usuario VALUES
(
NULL,
id_trabajador_i,
id_tipo_u_i,
usu,
md5(123456),
DEFAULT,
DEFAULT,
'',
'',
'',
DEFAULT
);

select count(id_usuario) into n FROM usuario
WHERE id_trabajador = id_trabajador_i;

if (n = 1) then

  CALL sp_regs(id_usuario_i,concat('GENERACION DE USUARIO PARA TRAB: ',id_trabajador_i),'TRABAJADOR,USUARIO',ip,nav,so);

  set salida = 'OK';

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_datos_contrato`
--

DROP PROCEDURE IF EXISTS `sp_datos_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_datos_contrato`(
in id_contrato_i int
)
BEGIN

SELECT c.codigo, c.nombre as cliente, o.nombre as obra
FROM contrato cn
INNER JOIN cliente c ON cn.id_cliente = c.id_cliente
INNER JOIN obra o ON cn.id_obra = o.id_obra
WHERE id_contrato = id_contrato_i;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_datos_contrato_x_alquiler`
--

DROP PROCEDURE IF EXISTS `sp_datos_contrato_x_alquiler`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_datos_contrato_x_alquiler`(
in id_contrato_i int
)
BEGIN

##### alquiler = contrato /// para no modificar backend PHP

SELECT c.codigo, c.nombre as cliente, o.nombre as obra
FROM contrato cn
INNER JOIN cliente c ON cn.id_cliente = c.id_cliente
INNER JOIN obra o ON cn.id_obra = o.id_obra
WHERE id_contrato = id_contrato_i;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_datos_cuenta_banco_empresa`
--

DROP PROCEDURE IF EXISTS `sp_datos_cuenta_banco_empresa`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_datos_cuenta_banco_empresa`()
BEGIN

SELECT
e.`razon_social` as banco,
e.`nombre` as descripcion,
e.`descripcion` as cuenta
FROM empresa e
WHERE ref_codigo <> '0' AND ref_codigo = 'P0001';

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_datos_notificaciones`
--

DROP PROCEDURE IF EXISTS `sp_datos_notificaciones`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_datos_notificaciones`(

)
BEGIN

##------------------vehiculos que se encuantran trabajando----------------------------------
 /*
SELECT
v.`id_vehiculo`,
tv.nombre as tipovehiculo,
m.nombre as marca,
concat( v.`nombre`,'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre_c,
concat( substr(v.`nombre`,1,4),'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre,
v.horometro_ac,
v.kilometraje_ac,
n.intervalo,
n.notifica_val,
n.unidad,
n.notificacion
FROM vehiculo v
INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

INNER JOIN detallealquiler da ON da.id_vehiculo = v.id_vehiculo
INNER JOIN trabvehiculo trab ON da.id_detallealquiler = trab.id_detallealquiler
INNER JOIN consumo c ON trab.id_trabvehiculo = c.id_trabvehiculo

LEFT JOIN notificamant n ON concat(n.id_tipovehiculo,n.id_marca) = concat(v.id_tipovehiculo,v.id_marca)

GROUP BY v.id_vehiculo;
*/

##-----------------todos los vehiculos-------------------------------------------------------

SELECT
v.`id_vehiculo`,
tv.nombre as tipovehiculo,
ifnull(m.nombre,'') as marca,
concat( v.`nombre`,'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre_c,
concat( substr(v.`nombre`,1,4),'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre,
v.horometro_ac,
v.kilometraje_ac,
ifnull(n.intervalo,10) as intervalo,
ifnull(n.notifica_val,10) as notifica_val,
ifnull(n.unidad,'KM') as unidad,
ifnull(n.notificacion,'') as notificacion
FROM vehiculo v

INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
LEFT JOIN marca m ON v.id_marca = m.id_marca

LEFT JOIN notificamant n ON concat(n.id_tipovehiculo,n.id_marca) = concat(v.id_tipovehiculo,v.id_marca)

GROUP BY v.id_vehiculo;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_datos_vehiculo`
--

DROP PROCEDURE IF EXISTS `sp_datos_vehiculo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_datos_vehiculo`(
in id_detalle_i int
)
BEGIN

SELECT
da.id_detallealquiler,
v.`id_vehiculo`,
tv.nombre as tipovehiculo,
m.nombre as marca,
concat( v.`nombre`,'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre_c,

concat( substr(v.`nombre`,1,4),'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre
FROM detallealquiler da
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

WHERE da.id_detallealquiler = id_detalle_i

ORDER BY v.nombre ASC;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_datos_vehiculo_v`
--

DROP PROCEDURE IF EXISTS `sp_datos_vehiculo_v`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_datos_vehiculo_v`(
in id_vehiculo_i int
)
BEGIN

SELECT
v.`id_vehiculo`,
tv.nombre as tipovehiculo,
m.nombre as marca,
concat( v.`nombre`,'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre_c,
concat( substr(v.`nombre`,1,4),'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre
FROM vehiculo v
INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

WHERE v.id_vehiculo = id_vehiculo_i

ORDER BY v.nombre ASC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_desasignar_guia`
--

DROP PROCEDURE IF EXISTS `sp_desasignar_guia`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_desasignar_guia`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_det_abast_i int,
out salida varchar(10)
)
BEGIN

DECLARE id_abast int;
DECLARE cantidad_g decimal(10,2);

-- handler para Transaccion
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

-- inicio de transaccion
START TRANSACTION;

SELECT id_abastecimiento into id_abast FROM detalleabastecimiento WHERE id_detalleabastecimiento = id_det_abast_i;
SELECT cantidad into cantidad_g FROM detalleabastecimiento WHERE id_detalleabastecimiento = id_det_abast_i;

UPDATE detalleabastecimiento SET id_abastecimiento = 0 WHERE id_detalleabastecimiento = id_det_abast_i;

UPDATE abastecimiento SET cantidad_guia = (cantidad_guia - cantidad_g) WHERE id_abastecimiento = id_abast;

COMMIT;

set salida = 'OK';

CALL sp_regs(id_usuario_i,'DESASIGNA GUIA','detalleabastecimeinto,abastecimiento',ip,nav,so);


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_abastecimiento`
--

DROP PROCEDURE IF EXISTS `sp_editar_abastecimiento`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_abastecimiento`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_abast int,
in id_tipocomprobante_i int,
in id_tipocombustible_i int,
in fecha_i timestamp,
in nro_comprobante_i varchar(20),
in nro_operacion_ch_i varchar(25),
in abastecedor_i varchar(200),
in cantidad_i decimal(10,2),
in precio_u_i decimal(10,2),
in total_i decimal(10,2),
out salida varchar(10)
)
BEGIN

UPDATE abastecimiento SET
id_tipocomprobante = id_tipocomprobante_i,
id_tipocombustible = id_tipocombustible_i,
fecha = fecha_i,
nro_comprobante = nro_comprobante_i,
abastecedor = UPPER(abastecedor_i),
cantidad = cantidad_i,
precio_u = precio_u_i,
total = total_i

WHERE id_abastecimiento = id_abast;


set salida = 'OK';

  CALL sp_regs(id_usuario_i,concat('EDITAR abastecimiento: ', id_abast),'abastecimiento',ip,nav,so);


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_articulo`
--

DROP PROCEDURE IF EXISTS `sp_editar_articulo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_articulo`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_articulo_i int,
in id_tipoarticulo_i int,
in id_almacen_i int,
in serie_i varchar(20),
in nombre_i varchar(100),
in descripcion_i varchar(300),
in precio_alq_i decimal(10,2),
out salida varchar(10)
)
BEGIN

UPDATE articulo SET

id_tipoarticulo = id_tipoarticulo_i,
id_almacen = id_almacen_i,
serie = UPPER(serie_i),
nombre = UPPER(nombre_i),
descripcion = UPPER(descripcion_i),
precio_alq = precio_alq_i

WHERE id_articulo = id_articulo_i;

		set salida = 'OK';

CALL sp_regs(id_usuario_i,concat('EDITAR ARTICULO: ', id_articulo_i),'articulo',ip,nav,so);


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_cliente`
--

DROP PROCEDURE IF EXISTS `sp_editar_cliente`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_cliente`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_cliente_i int,
in id_tipocliente_i int,
in codigo_i varchar(15),
in nombre_i varchar(100),
in direccion_i varchar(200),
in telefono_i varchar(20),
out salida varchar(10)
)
BEGIN

UPDATE cliente SET
id_tipocliente = id_tipocliente_i,
codigo = codigo_i,
nombre = UPPER(nombre_i),
direccion = UPPER(direccion_i),
telefono = UPPER(telefono_i)
WHERE id_cliente = id_cliente_i;

  SET salida = 'OK';

  CALL sp_regs(id_usuario_i,concat('EDITAR CLIENTE: ',id_cliente_i),'cliente',ip,nav,so);


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_contrato`
--

DROP PROCEDURE IF EXISTS `sp_editar_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_contrato`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_contrato_i int,
in f_inicio_i timestamp,
in f_fin_i timestamp,
in presupuesto_i decimal(10,2),
in detalle_i varchar(400),
out salida varchar(10)
)
BEGIN


UPDATE contrato SET f_inicio = f_inicio_i,
f_fin = f_fin_i,
presupuesto = presupuesto_i,
detalle = UPPER(detalle_i)
WHERE id_contrato = id_contrato_i;

  set salida = 'OK';

CALL sp_regs(id_usuario_i,CONCAT('EDITAR CONTRATO: ',id_contrato_i),'contrato',ip,nav,so);



END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_control_combustible`
--

DROP PROCEDURE IF EXISTS `sp_editar_control_combustible`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_control_combustible`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_consumo_i int,
in trabajador_i varchar(200),
in fecha_i timestamp,
in nro_guia_i varchar(20),
in nro_vale_i varchar(20),
in nro_surtidor_i varchar(20),
in cant_combustible_i decimal(10,2),
in horometro_i decimal(10,2),
in kilometraje_i decimal(10,2),
out salida varchar(20)
)
BEGIN

DECLARE nro_guia_an varchar(20);
DECLARE id_operario_a int;
DECLARE id_det_an int;
DECLARE id_det_nv int;
DECLARE cantidad decimal(10,2);
DECLARE cant_an decimal(10,2);
DECLARE id_detalle_a int;
DECLARE id_ct int;
DECLARE nro_parte_a varchar(20); -- se almacena el nro_operacion al que pertence el vale

-- handler para Transaccion
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

-- inicio de transaccion
START TRANSACTION;

SELECT id_detalleabastecimiento INTO id_det_nv FROM detalleabastecimiento WHERE nro_guia = nro_guia_i;

if (id_det_nv > 0) then   -- si existe el nuevo nro guia

-- SELECT nro_guia INTO nro_guia_an FROM consumo WHERE id_consumo = id_consumo_i;

SELECT id_detalleabastecimiento INTO id_det_an FROM consumo WHERE id_consumo = id_consumo_i;

SELECT cant_combustible INTO cant_an FROM consumo WHERE id_consumo = id_consumo_i;

SELECT id_trabajador into id_operario_a FROM trabajador WHERE replace(concat(apellidos,nombres),' ','') = UPPER(trabajador_i);

SELECT id_detallealquiler into id_detalle_a FROM consumo WHERE id_consumo = id_consumo_i;

-- selecciona el nro de parte diario al que pertenece el vale ingresado
-- es obligatorio registrar primero el parte diario
SELECT
c.nro_parte into nro_parte_a
FROM controltrabajo c
WHERE c.id_detallealquiler = id_detalle_a AND
fecha = date(fecha_i) AND
(horometro_i BETWEEN horometro_inicio AND horometro_fin );

-- se obtiene el id_controltrabajo
select id_controltrabajo into id_ct FROM controltrabajo WHERE nro_parte = nro_parte_a;
-- existe el operario
-- existe el parte diario

if (id_ct > 0) then -- valida si existe el parte para este vale

if (id_operario_a > 0) then

UPDATE consumo SET
fecha = fecha_i,
nro_surtidor = nro_surtidor_i,
id_operario = id_operario_a,
cant_combustible = cant_combustible_i,
horometro = horometro_i,
kilometraje = kilometraje_i,
nro_guia = nro_guia_i,
nro_vale = nro_vale_i,
id_detalleabastecimiento = id_det_nv

WHERE id_consumo = id_consumo_i;

-- se actualiza la asignacion del vale al parte diario
UPDATE partevale SET
id_controltrabajo = id_ct,
fecha_reg = now()
WHERE id_consumo = id_consumo_i;


if (id_det_nv = id_det_an) then -- si son iguales

-- cantidad_nueva - cantidad_anterior
set cantidad = cant_combustible_i - cant_an;

UPDATE detalleabastecimiento SET
stock = stock - cantidad
WHERE id_detalleabastecimiento = id_det_nv;

  COMMIT;

  set salida = 'OK';

CALL sp_regs(id_usuario_i,concat('EDITAR CONSUMO: ',id_consumo_i),'consumo,detalleabastecimiento',ip,nav,so);

else -- si son diferentes

-- detalle anterior
UPDATE detalleabastecimiento SET
stock = stock + cant_an
WHERE id_detalleabastecimiento = id_det_an;

-- detalle nuevo
UPDATE detalleabastecimiento SET
stock = stock - cant_combustible_i
WHERE id_detalleabastecimiento = id_det_nv;

  COMMIT;

set salida = 'OK';

CALL sp_regs(id_usuario_i,concat('EDITAR CONSUMO: ',id_consumo_i),'consumo,detalleabastecimiento',ip,nav,so);

end if; -- fin igualdad


end if;  -- si el operario existe

else -- parte para vale

  ROLLBACK;
  set  salida = 'PARTE';

end if; -- exite parte para vale

end if; -- si existe el nuevo nro guia


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_detalle_abastecimiento`
--

DROP PROCEDURE IF EXISTS `sp_editar_detalle_abastecimiento`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_detalle_abastecimiento`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_detalleabastecimiento_i int,
in id_tipocombustible_i int,
in fecha_i timestamp,
in nro_guia_i varchar(20),
in cantidad_i decimal(10,2),
in abastecedor_i varchar(200),
out salida varchar(10)
)
BEGIN


UPDATE detalleabastecimiento SET
id_tipocombustible = id_tipocombustible_i,
fecha = fecha_i,
nro_guia = UPPER(nro_guia_i),
cantidad = UPPER(cantidad_i),
abastecedor = UPPER(abastecedor_i)
WHERE id_detalleabastecimiento = id_detalleabastecimiento_i;

-- ---------------------------
CALL sp_regs(id_usuario_i,'MODIFICA GUIA','detalleabastecimiento',ip,nav,so);

  set salida = 'OK';

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_obra`
--

DROP PROCEDURE IF EXISTS `sp_editar_obra`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_obra`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_obra_i int,
in id_tipo_obra_i int,
in nombre_i varchar(200),
out salida varchar(10)
)
BEGIN


UPDATE obra SET id_tipoobra = id_tipo_obra_i,
nombre = UPPER(nombre_i),
fecha = now()
WHERE id_obra = id_obra_i;

  set salida = 'OK';

  CALL sp_regs(id_usuario_i,concat('EDITAR OBRA: ',id_obra_i),'obra',ip,nav,so);




END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_parte_maquinaria`
--

DROP PROCEDURE IF EXISTS `sp_editar_parte_maquinaria`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_parte_maquinaria`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_parted int,
in trabajador_i varchar(200),
in nro_parte_i varchar(20),
in fecha_i timestamp,
in lugar_trabajo_i varchar(200),
in tarea_i varchar(400),
in agua_i decimal(10,2),
in petroleo_i decimal(10,2),
in gasolina_i decimal(10,2),
in ac_motor_i decimal(10,2),
in ac_transmision_i decimal(10,2),
in ac_hidraulico_i decimal(10,2),
in grasa_i decimal(10,2),
in observacion_i varchar(400),
in turno_i char(1),
in descuento_i decimal(10,2),
in horom_inicio_i decimal(10,2),
in horom_fin_i decimal(10,2),
in total_h_i decimal(10,2),
in hrs_i int,
in min_i int,
out salida varchar(10)
)
BEGIN

DECLARE id_operario_a int;

-- handler para Transaccion
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

-- inicio de transaccion
START TRANSACTION;

SELECT id_trabajador into id_operario_a from trabajador WHERE concat(apellidos,nombres) = UPPER(trabajador_i);

if (id_operario_a > 0 ) then

UPDATE controltrabajo c SET

id_operario = id_operario_a,
nro_parte = nro_parte_i,
fecha = fecha_i,
lugar_trabajo = UPPER(lugar_trabajo_i),
tarea = UPPER(tarea_i),
agua = agua_i,
petroleo = petroleo_i,
gasolina = gasolina_i,
ac_motor = ac_motor_i,
ac_transmision = ac_transmision_i,
ac_hidraulico =ac_hidraulico_i,
grasa = grasa_i,
observacion = observacion_i,
turno = UPPER(turno_i),
descuento = descuento_i,
horometro_inicio = horom_inicio_i,
horometro_fin = horom_fin_i,
total_h = total_h_i,
hrs = hrs_i,
minuto = min_i

WHERE id_controltrabajo = id_parted;

  COMMIT;

  SET salida = 'OK';

CALL sp_regs(id_usuario_i,concat('EDITAR PARTE MAQUINARIA: ',id_parted),'controltrabajo',ip,nav,so);

end if;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_tipo`
--

DROP PROCEDURE IF EXISTS `sp_editar_tipo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_tipo`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_tipo_i int,
in nombre_i varchar(200),
in tabla_i varchar(60),
in estado_i char(1),
out salida varchar(10)
)
BEGIN

CASE tabla_i
WHEN 'ARTICULO' THEN UPDATE tipoarticulo SET nombre = upper(nombre_i),estado = estado_i WHERE id_tipoarticulo = id_tipo_i;
WHEN 'CLIENTE' THEN UPDATE tipocliente SET nombre = upper(nombre_i),estado = estado_i WHERE id_tipocliente = id_tipo_i;
WHEN 'COMBUSTIBLE' THEN UPDATE tipocombustible SET nombre = upper(nombre_i),estado = estado_i WHERE id_tipocombustible = id_tipo_i;
WHEN 'COMPROBANTE' THEN UPDATE tipocomprobante SET nombre = upper(nombre_i),estado = estado_i WHERE id_tipocomprobante = id_tipo_i;
WHEN 'OBRA' THEN UPDATE tipoobra SET nombre = upper(nombre_i),estado = estado_i WHERE id_tipoobra = id_tipo_i;
WHEN 'TRABAJADOR' THEN UPDATE tipotrabajador SET nombre = upper(nombre_i),estado = estado_i WHERE id_tipotrabajador = id_tipo_i;
WHEN 'USUARIO' THEN UPDATE tipousuario SET nombre = upper(nombre_i),estado = estado_i WHERE id_tipousuario = id_tipo_i;
WHEN 'VEHICULO' THEN UPDATE tipovehiculo SET nombre = upper(nombre_i),estado = estado_i WHERE id_tipovehiculo = id_tipo_i;
WHEN 'MARCA' THEN UPDATE marca SET nombre = upper(nombre_i),estado = estado_i WHERE id_marca = id_tipo_i;
END CASE;

set salida = 'OK';

CALL sp_regs(id_usuario_i,concat('UPDATE TIPO: ',UPPER(nombre_i)),tabla_i,ip,nav,so);


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_trabajador`
--

DROP PROCEDURE IF EXISTS `sp_editar_trabajador`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_trabajador`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_trab_i int,
in apellidos_i varchar(50),
in nombres_i varchar(50),
in fecha_nac_i date,
in dni_i varchar(10),
in ruc_i varchar(15),
in telefono_i varchar(20),
in id_tipo_u_i int,
in id_tipotrabajador_i int,
in nro_licencia_i varchar(15),
out salida varchar(10)
)
BEGIN

DECLARE usu varchar(30);

UPDATE trabajador SET id_tipotrabajador = id_tipotrabajador_i,
apellidos = UPPER(apellidos_i),
nombres = UPPER(nombres_i),
fecha_nac = fecha_nac_i,
dni = dni_i,
ruc = ruc_i,
telefono = telefono_i,
nro_licencia = nro_licencia_i

WHERE id_trabajador = id_trab_i;


SELECT lower( concat( substr(nombres,1,1), substr(apellidos,1,locate(' ',apellidos)-1), substr(dni,7,8) ) ) INTO usu
FROM trabajador
WHERE id_trabajador = id_trab_i;

SET usu = REPLACE (usu,'á','a');
SET usu = REPLACE (usu,'é','e');
SET usu = REPLACE (usu,'í','i');
SET usu = REPLACE (usu,'ó','o');
SET usu = REPLACE (usu,'ú','u');

UPDATE usuario SET nombre = usu, f_modificacion = now(), id_tipousuario = id_tipo_u_i
WHERE id_trabajador = id_trab_i;

  set salida = 'OK';

CALL sp_regs(id_usuario_i,concat('EDITAR TRABAJADOR',id_trab_i),'TRABAJADOR,USUARIO',ip,nav,so);


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_vehiculo`
--

DROP PROCEDURE IF EXISTS `sp_editar_vehiculo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_vehiculo`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_vehiculo_i int,
in id_marca_i int,
in id_tipovehiculo_i int,
in rendimiento_i varchar(10),
in nombre_i varchar(100),
in modelo_i varchar(10),
in serie_i varchar(20),
in motor_i varchar(20),
in color_i varchar(10),
in placa_i varchar(10),
in precio_h decimal(10,2),
in horometro_i decimal(10,2),
in kilometraje_i decimal(10,2),
out salida varchar(10)
)
BEGIN

UPDATE vehiculo SET

id_marca = id_marca_i,
id_tipovehiculo = id_tipovehiculo_i,
nombre = UPPER(nombre_i),
modelo = UPPER(modelo_i),
serie = UPPER(serie_i),
motor = UPPER(motor_i),
color = UPPER(color_i),
placa = UPPER(placa_i),
horometro_ac = horometro_i,
kilometraje_ac = kilometraje_i,
precio_alq = precio_h,
rendimiento = rendimiento_i

WHERE id_vehiculo = id_vehiculo_i;

		set salida = 'OK';

CALL sp_regs(id_usuario_i,concat('EDITAR VEHICULO: ',id_vehiculo_i),'vehiculo, vehiculoph',ip,nav,so);


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_finalizar_contrato`
--

DROP PROCEDURE IF EXISTS `sp_finalizar_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_finalizar_contrato`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_contrato_i int,
in presupuesto_i decimal(10,2),
in observacion_i varchar(200),
in fecha_fin_i timestamp,
out salida varchar(10)
)
BEGIN

DECLARE done INT DEFAULT FALSE; -- estado del cursor
DECLARE id_det,id_vh,id_art int; -- VARIABLES PARA EL CURSOR

-- cursor
-- los detalles del contrato cuyo estado sea ACTiVO = A
DECLARE cur_detalle CURSOR FOR
SELECT id_detallealquiler, id_vehiculo, id_articulo FROM detallealquiler
WHERE id_contrato = id_contrato_i AND est_alq = 'A';

-- Declaración de un manejador de error tipo NOT FOUND
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

-- handler para Transaccion
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

-- inicio de transaccion
START TRANSACTION;

-- apertura de cursor
OPEN cur_detalle;

-- bucle de lectura del cursor
read_loop: LOOP

  FETCH cur_detalle INTO id_det,id_vh,id_art; -- asigno cada clave

  IF done THEN
    LEAVE read_loop;
  END IF;

  -- MODIFICACION DE TABLAS
  -- cambia estado a vehiculos
  UPDATE vehiculo SET estado = 'D' WHERE id_vehiculo = id_vh;
  -- cambia estado a artculo
  UPDATE articulo SET estado = 'D' WHERE id_articulo = id_art;
  -- cambia estado a detallealquiler
  UPDATE detallealquiler SET est_alq = 'B' WHERE id_detallealquiler = id_det;
  -- cambia estado a trabvehiculo
  UPDATE trabvehiculo SET f_fin = fecha_fin_i, estado = 'B' WHERE id_detallealquiler = id_det AND estado = 'A';
  -- registrar en tbl devolucion
  INSERT INTO devolucion VALUES(NULL,id_det,fecha_fin_i,'','FINALIZACIÓN DE CONTRARO');

END LOOP;

CLOSE cur_detalle;

-- obtiene la obra
SET @obra = (SELECT id_obra FROM contrato WHERE id_contrato = id_contrato_i);

-- cambia estado a obra
UPDATE obra SET estado = 'B' WHERE id_obra = @obra;

-- datos de contrato
UPDATE contrato SET f_fin = fecha_fin_i, presupuesto = ifnull(presupuesto_i,0), detalle = observacion_i, estado = 'B'
WHERE id_contrato = id_contrato_i;

-- verifica cambios
SET @val = (SELECT count(*) FROM contrato WHERE id_contrato = id_contrato_i AND f_fin = fecha_fin_i);

if (@val = 1) then
  COMMIT;
  SET salida = 'OK';
  CALL sp_regs(id_usuario_i,concat('FINALIZACIÓN DEL CONTRATO: ',id_contrato_i),
  'vehiculo,articulo,detallealquiler,trabvehiculo,devolucion,obra,contrato',ip,nav,so);
else
  ROLLBACK;
end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_horometro_anterior`
--

DROP PROCEDURE IF EXISTS `sp_horometro_anterior`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_horometro_anterior`(
in fecha_actual_alq date,
in id_vh int
)
BEGIN

SET @fecha_actual_alq = fecha_actual_alq;
SET @id_vh = id_vh;
SET @detalle_ant = (SELECT da.id_detallealquiler FROM detallealquiler da
WHERE da.id_vehiculo = @id_vh AND da.fecha < @fecha_actual_alq ORDER BY da.fecha DESC LIMIT 1);
-- se obtiene el ultimo consumo (HOROMETRO) del detalle
-- select @detalle_ant;
SET @horom_ant = (SELECT MAX(horometro) FROM consumo WHERE id_detallealquiler = @detalle_ant);
SET @petroleo = (SELECT cant_combustible FROM consumo WHERE id_detallealquiler = @detalle_ant AND horometro = @horom_ant);
select ROUND(ifnull(@petroleo,0),2) as petroleo, ROUND(ifnull(@horom_ant,0),2) as horom_ant;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_alquiler_articulos`
--

DROP PROCEDURE IF EXISTS `sp_listar_alquiler_articulos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_alquiler_articulos`(
in id_contrato_i int
)
BEGIN

## alquiler = contrato // para no modificar Backend PHP

SELECT cl.codigo as cod_cli,cl.nombre as cliente_cli,o.nombre as obra,
c.f_inicio,c.f_fin,
da.id_detallealquiler,a.id_articulo,a.nombre as articulo,a.serie,da.precio_alq,
da.fecha,da.estado,da.observacion
FROM detallealquiler da
INNER JOIN articulo a ON a.id_articulo = da.id_articulo
INNER JOIN contrato c ON c.id_contrato = da.id_contrato
INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente
INNER JOIN obra o ON c.id_obra = o.id_obra
WHERE da.id_contrato = id_contrato_i AND da.est_alq = 'A';

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_alquiler_vehiculos`
--

DROP PROCEDURE IF EXISTS `sp_listar_alquiler_vehiculos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_alquiler_vehiculos`(
in id_contrato_i int
)
BEGIN

SELECT
da.id_detallealquiler,
cl.codigo as cod_cli,
cl.nombre as cliente_cli,
o.nombre as obra,
c.f_inicio,
c.f_fin,

v.id_vehiculo,
v.nombre as vehiculo,
v.modelo,
v.serie,
v.placa,
da.precio_alq as precio_hora,
da.fecha,
da.estado,
da.observacion,
t.id_transporte
#tv.id_trabvehiculo,
#tv.estado as estado_trab
FROM detallealquiler da
INNER JOIN vehiculo v ON v.id_vehiculo = da.id_vehiculo
INNER JOIN contrato c ON c.id_contrato = da.id_contrato
INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente
INNER JOIN obra o ON c.id_obra = o.id_obra

#LEFT JOIN trabvehiculo tv ON da.id_detallealquiler = tv.id_detallealquiler
LEFT JOIN transporte t ON da.id_detallealquiler = t.id_detallealquiler

WHERE da.id_contrato = id_contrato_i AND da.est_alq = 'A';

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_articulos`
--

DROP PROCEDURE IF EXISTS `sp_listar_articulos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_articulos`()
BEGIN

SELECT
a.id_articulo,
ta.nombre as tipoarticulo,
a.serie,a.nombre,a.descripcion,
a.precio_alq,
e.nombre as estado
FROM articulo a
INNER JOIN tipoarticulo ta ON a.id_tipoarticulo = ta.id_tipoarticulo
INNER JOIN estado e  ON a.estado = e.id_estado
ORDER BY e.id_estado asc, a.nombre asc;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_articulo_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_articulo_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_articulo_ID`(
in id_articulo_i int
)
BEGIN

SELECT
a.id_articulo,
ta.id_tipoarticulo,
ta.nombre as tipoarticulo,
a.id_almacen,
a.serie,a.nombre,a.descripcion,
a.precio_alq,
e.nombre as estado
FROM articulo a
INNER JOIN tipoarticulo ta ON a.id_tipoarticulo = ta.id_tipoarticulo
INNER JOIN estado e  ON a.estado = e.id_estado

WHERE a.id_articulo = id_articulo_i;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_cliente`
--

DROP PROCEDURE IF EXISTS `sp_listar_cliente`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_cliente`()
BEGIN

SELECT c.id_cliente,  t.nombre as tipocliente,c.codigo,c.nombre,c.direccion,c.telefono,c.estado,c.f_registro
FROM cliente c
INNER JOIN tipocliente t ON c.id_tipocliente = t.id_tipocliente
ORDER BY c.f_registro desc, nombre asc;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_clientes_con_alquiler`
--

DROP PROCEDURE IF EXISTS `sp_listar_clientes_con_alquiler`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_clientes_con_alquiler`()
BEGIN

SELECT c.*,o.nombre as obra,t.nombre as tipoobra,con.id_contrato,con.estado as estado_con,con.f_inicio,con.f_fin
FROM cliente c
INNER JOIN contrato con ON c.id_cliente = con.id_cliente
INNER JOIN obra o ON con.id_obra = o.id_obra
INNER JOIN tipoobra t ON o.id_tipoobra = t.id_tipoobra
INNER JOIN detallealquiler da ON con.id_contrato = da.id_contrato
-- WHERE con.estado = 'A'

GROUP BY con.id_contrato
ORDER BY con.estado, con.id_contrato DESC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_cliente_contrato`
--

DROP PROCEDURE IF EXISTS `sp_listar_cliente_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_cliente_contrato`()
BEGIN
-- valorizacion: noimporta la obra
-- el calculo se hace entre fechas sin importar la obra que se haya ejecutado
SELECT distinct(c.id_cliente), t.nombre as tipocliente,c.codigo,
c.nombre,c.direccion,c.telefono,c.estado,c.f_registro
FROM cliente c
INNER JOIN tipocliente t ON c.id_tipocliente = t.id_tipocliente
INNER JOIN contrato con ON c.id_cliente = con.id_cliente
ORDER BY c.f_registro desc, nombre asc;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_cliente_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_cliente_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_cliente_ID`(
in id_cliente_i int
)
BEGIN


SELECT c.id_cliente, t.id_tipocliente, t.nombre as tipocliente,c.codigo,c.nombre,c.direccion,c.telefono,c.estado,c.f_registro
FROM cliente c
INNER JOIN tipocliente t ON c.id_tipocliente = t.id_tipocliente

WHERE id_cliente = id_cliente_i;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_comprobantes`
--

DROP PROCEDURE IF EXISTS `sp_listar_comprobantes`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_comprobantes`()
BEGIN

SELECT
a.`id_abastecimiento`,
t.`nombre` as tipocomprobante,
c.`nombre` as tipocombustible,
substr(a.`fecha`,1,10) as fecha,
a.`nro_comprobante`,
a.`nro_operacion_ch`,
a.`abastecedor`,
a.`cantidad`,
a.`precio_u`,
a.`total`,
a.`cantidad_guia`
FROM abastecimiento a
INNER JOIN tipocomprobante t ON t.id_tipocomprobante = a.id_tipocomprobante
INNER JOIN tipocombustible c ON c.id_tipocombustible = a.id_tipocombustible
ORDER BY a.fecha DESC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_comprobante_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_comprobante_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_comprobante_ID`(
in id_abast int
)
BEGIN


SELECT
a.`id_abastecimiento`,
t.id_tipocomprobante,
t.`nombre` as tipocomprobante,
c.id_tipocombustible,
c.`nombre` as tipocombustible,
substr(a.`fecha`,1,10) as fecha,
a.`nro_comprobante`,
a.`nro_operacion_ch`,
a.`abastecedor`,
a.`cantidad`,
a.`precio_u`,
a.`total`,
a.`cantidad_guia`
FROM abastecimiento a
INNER JOIN tipocomprobante t ON t.id_tipocomprobante = a.id_tipocomprobante
INNER JOIN tipocombustible c ON c.id_tipocombustible = a.id_tipocombustible
WHERE a.id_abastecimiento = id_abast;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_contrato`
--

DROP PROCEDURE IF EXISTS `sp_listar_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_contrato`()
BEGIN

SELECT c.id_contrato,o.nombre as obra,cl.nombre as cliente,c.f_inicio,c.f_fin,
c.presupuesto,c.detalle,es.nombre as estado,da.id_detallealquiler
FROM contrato c
INNER JOIN obra o ON c.id_obra = o.id_obra
INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente
INNER JOIN estado es ON c.estado = es.id_estado

LEFT JOIN detallealquiler da ON c.id_contrato = da.id_contrato

-- estado no sea inactivo
-- WHERE c.estado <> 'B'

GROUP BY c.id_contrato
ORDER BY c.id_contrato, es.nombre DESC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_contrato_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_contrato_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_contrato_ID`(
in id_contrato_i int
)
BEGIN


SELECT c.id_contrato,o.nombre as obra,cl.nombre as cliente,date(c.f_inicio) as f_inicio,date(c.f_fin) as f_fin,
c.presupuesto,c.detalle,es.nombre as estado,da.id_detallealquiler
FROM contrato c
INNER JOIN obra o ON c.id_obra = o.id_obra
INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente
INNER JOIN estado es ON c.estado = es.id_estado

LEFT JOIN detallealquiler da ON c.id_contrato = da.id_contrato

WHERE c.id_contrato = id_contrato_i

GROUP BY c.id_contrato;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_guias`
--

DROP PROCEDURE IF EXISTS `sp_listar_guias`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_guias`()
BEGIN

SELECT
d.`id_detalleabastecimiento`,
d.`id_abastecimiento`,
a.`nro_comprobante`,
ifnull(a.`nro_comprobante`,'SIN ASIGNAR') as estado_g,
c.`nombre` as tipocombustible,
concat(v.nombre,' /MOD: ',ifnull(v.modelo,''),' /SERIE: ',ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo,
concat(t.`apellidos`,', ',t.`nombres`) as conductor,
substr(d.`fecha`,1,10) as fecha,
d.`nro_guia`,
d.`cantidad`,
d.`stock`,
d.abastecedor
FROM detalleabastecimiento d
LEFT JOIN abastecimiento a ON d.id_abastecimiento = a.id_abastecimiento
INNER JOIN tipocombustible c ON d.id_tipocombustible = c.id_tipocombustible
INNER JOIN trabajador t ON t.id_trabajador = d.id_trabajador
INNER JOIN vehiculo v ON v.id_vehiculo = d.id_vehiculo
ORDER BY d.fecha DESC, a.nro_comprobante ASC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_guias_sin_asignar`
--

DROP PROCEDURE IF EXISTS `sp_listar_guias_sin_asignar`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_guias_sin_asignar`()
BEGIN

SELECT
d.`id_detalleabastecimiento`,
d.`id_abastecimiento`,
a.`nro_comprobante`,
ifnull(a.`nro_comprobante`,'SIN ASIGNAR') as estado_g,
c.`nombre` as tipocombustible,
concat(v.nombre,' /MOD: ',ifnull(v.modelo,''),' /SERIE: ',ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo,
concat(t.`apellidos`,', ',t.`nombres`) as conductor,
substr(d.`fecha`,1,10) as fecha,
d.`nro_guia`,
d.`cantidad`,
d.`stock`,
d.abastecedor
FROM detalleabastecimiento d
LEFT JOIN abastecimiento a ON d.id_abastecimiento = a.id_abastecimiento
INNER JOIN tipocombustible c ON d.id_tipocombustible = c.id_tipocombustible
INNER JOIN trabajador t ON t.id_trabajador = d.id_trabajador
INNER JOIN vehiculo v ON v.id_vehiculo = d.id_vehiculo
WHERE d.id_abastecimiento = 0
ORDER BY d.fecha DESC, a.nro_comprobante ASC;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_guia_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_guia_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_guia_ID`(
in id_det_abast int
)
BEGIN

SELECT
d.`id_detalleabastecimiento`,
d.`id_abastecimiento`,
a.`nro_comprobante`,
ifnull(a.`nro_comprobante`,'SIN ASIGNAR') as estado_g,
c.id_tipocombustible,
c.`nombre` as tipocombustible,
concat(v.nombre,' /MOD: ',ifnull(v.modelo,''),' /SERIE: ',ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo,
concat(t.`apellidos`,', ',t.`nombres`) as conductor,
substr(d.`fecha`,1,10) as fecha,
d.`nro_guia`,
d.`cantidad`,
d.`stock`,
d.abastecedor
FROM detalleabastecimiento d
LEFT JOIN abastecimiento a ON d.id_abastecimiento = a.id_abastecimiento
INNER JOIN tipocombustible c ON d.id_tipocombustible = c.id_tipocombustible
INNER JOIN trabajador t ON t.id_trabajador = d.id_trabajador
INNER JOIN vehiculo v ON v.id_vehiculo = d.id_vehiculo
WHERE d.id_detalleabastecimiento = id_det_abast
ORDER BY d.fecha DESC, a.nro_comprobante ASC;



END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_mantenimientos`
--

DROP PROCEDURE IF EXISTS `sp_listar_mantenimientos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_mantenimientos`(
in id_vehiculo_i int
)
BEGIN

SELECT * FROM mantenimiento m
WHERE id_vehiculo = id_vehiculo_i;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_obras`
--

DROP PROCEDURE IF EXISTS `sp_listar_obras`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_obras`()
BEGIN

SELECT o.id_obra,t.nombre as tipoobra,o.nombre as obra,o.fecha, e.nombre as estado
FROM obra o
INNER JOIN tipoobra t ON t.id_tipoobra = o.id_tipoobra
INNER JOIN estado e ON e.id_estado = o.estado;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_obra_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_obra_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_obra_ID`(
in id_obra_i int
)
BEGIN

SELECT o.id_obra, t.id_tipoobra, t.nombre as tipoobra,o.nombre as obra,o.fecha, e.nombre as estado
FROM obra o
INNER JOIN tipoobra t ON t.id_tipoobra = o.id_tipoobra
INNER JOIN estado e ON e.id_estado = o.estado
WHERE id_obra  = id_obra_i;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_operario_x_vehiculo`
--

DROP PROCEDURE IF EXISTS `sp_listar_operario_x_vehiculo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_operario_x_vehiculo`(
in id_trabvehiculo_i int
)
BEGIN


SELECT v.id_vehiculo,
 t.id_trabvehiculo,
 concat(tr.apellidos,', ',tr.nombres) as operario,
concat(v.nombre,' /MOD: ',ifnull(v.modelo,''),' /SERIE: ',ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo
FROM trabvehiculo t
INNER JOIN detallealquiler da ON t.id_detallealquiler = da.id_detallealquiler
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN trabajador tr ON t.id_trabajador = tr.id_trabajador
WHERE t.id_trabvehiculo = id_trabvehiculo_i AND t.estado = 'A';


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_registro_consumo`
--

DROP PROCEDURE IF EXISTS `sp_listar_registro_consumo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_registro_consumo`(
)
BEGIN

##
# fecha, obra, n operacion, n guia, n vale,
# n surtidor, vehiculo, marca, cant comb, tipo comb,
# horom_kilom

DECLARE id_tr int;

-- SELECT id_trabajador into id_tr FROM usuario WHERE id_usuario = id_usuario_i;

SELECT
c.id_consumo,
c.fecha,
c.nro_guia,
c.nro_vale,
c.nro_surtidor,
c.cant_combustible,
c.horometro,
c.kilometraje,
concat(t_i.apellidos,', ',t_i.nombres) as controlador,
concat(t.apellidos,', ',t.nombres) as operario,
concat(v.nombre,'/MOD: ',ifnull(v.modelo,''),'/SER: ',
ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo
-- cl.codigo,
-- cl.nombre as cliente,
-- o.nombre as obra

FROM consumo c
INNER JOIN trabajador t ON t.id_trabajador = c.id_operario
INNER JOIN detallealquiler da ON da.id_detallealquiler = c.id_detallealquiler
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo

-- LEFT JOIN detallealquiler da ON v.id_vehiculo = v.id_vehiculo
-- INNER JOIN contrato con ON da.id_contrato = con.id_contrato
-- INNER JOIN cliente cl ON con.id_cliente = cl.id_cliente
-- INNER JOIN obra o ON con.id_obra = o.id_obra


-- responsable del registro
INNER JOIN trabajador t_i ON c.id_responsable = t_i.id_trabajador

GROUP BY c.nro_vale
-- WHERE c.id_responsable = id_tr
ORDER BY c.fecha DESC, nro_vale desc;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_registro_consumo_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_registro_consumo_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_registro_consumo_ID`(
in id_consumo_i int
)
BEGIN

SELECT
c.id_consumo,
c.fecha,
c.nro_guia,
c.nro_vale,
c.nro_surtidor,
c.cant_combustible,
c.horometro,
c.kilometraje,
concat(t_i.apellidos,', ',t_i.nombres) as controlador,
concat(t.apellidos,', ',t.nombres) as operario,
concat(v.nombre,'/MOD: ',ifnull(v.modelo,''),'/SER: ',
ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo
-- cl.codigo,
-- cl.nombre as cliente,
-- o.nombre as obra

FROM consumo c
INNER JOIN trabajador t ON t.id_trabajador = c.id_operario
-- INNER JOIN detallealquiler da ON trab.id_detallealquiler = da.id_detallealquiler
INNER JOIN detallealquiler da ON da.id_detallealquiler = c.id_detallealquiler
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo

-- INNER JOIN contrato con ON da.id_contrato = con.id_contrato
-- INNER JOIN cliente cl ON con.id_cliente = cl.id_cliente
-- INNER JOIN obra o ON con.id_obra = o.id_obra


-- responsable del registro
INNER JOIN trabajador t_i ON c.id_responsable = t_i.id_trabajador

WHERE c.id_consumo = id_consumo_i;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_registro_parted`
--

DROP PROCEDURE IF EXISTS `sp_listar_registro_parted`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_registro_parted`(
)
BEGIN

declare id_tr int;


-- SELECT id_trabajador into id_tr FROM usuario WHERE id_usuario = id_usuario_i;

SELECT
ct.id_controltrabajo,
ct.fecha,
ct.nro_parte,
ct.lugar_trabajo,
ct.tarea,
ct.horometro_inicio,
ct.horometro_fin,
ct.total_h,
case ct.turno
when 'M' then 'MAÑANA'
when 'T' then 'TARDE'
when 'C' then 'COMPLETO'
end as turno,
concat(t_i.apellidos,', ',t_i.nombres) as controlador,
concat(t.apellidos,', ',t.nombres) as operario,
concat(v.nombre,'/MOD: ',ifnull(v.modelo,''),'/SER: ',
ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo
-- cl.codigo,
-- cl.nombre as cliente,
-- o.nombre as obra

FROM controltrabajo ct
-- INNER JOIN trabvehiculo trab ON trab.id_trabvehiculo = ct.id_trabvehiculo
INNER JOIN trabajador t ON t.id_trabajador = ct.id_operario
-- INNER JOIN detallealquiler da ON trab.id_detallealquiler = da.id_detallealquiler
INNER JOIN detallealquiler da ON da.id_detallealquiler = ct.id_detallealquiler
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo

-- INNER JOIN contrato con ON da.id_contrato = con.id_contrato
-- INNER JOIN cliente cl ON con.id_cliente = cl.id_cliente
-- INNER JOIN obra o ON con.id_obra = o.id_obra

-- responsable del registro
INNER JOIN trabajador t_i ON ct.id_responsable = t_i.id_trabajador

-- WHERE ct.id_responsable = id_tr

ORDER BY ct.fecha DESC, ct.nro_parte DESC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_registro_parted_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_registro_parted_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_registro_parted_ID`(
in id_controltrab_i int
)
BEGIN


SELECT
ct.id_controltrabajo,
ct.fecha,
ct.nro_parte,
ct.lugar_trabajo,
ct.tarea,
ct.horometro_inicio,
ct.horometro_fin,
ct.agua,
ct.petroleo,
ct.gasolina,
ct.ac_motor,
ct.ac_transmision,
ct.ac_hidraulico,
ct.grasa,
ct.observacion,
ct.turno,
ct.descuento,
ct.total_h,
ct.turno,
concat(t_i.apellidos,', ',t_i.nombres) as controlador,
concat(t.apellidos,', ',t.nombres) as operario,
concat(v.nombre,'/MOD: ',ifnull(v.modelo,''),'/SER: ',
ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo
-- cl.codigo,
-- cl.nombre as cliente,
-- o.nombre as obra

FROM controltrabajo ct
-- INNER JOIN trabvehiculo trab ON trab.id_trabvehiculo = ct.id_trabvehiculo
INNER JOIN trabajador t ON t.id_trabajador = ct.id_operario
-- INNER JOIN detallealquiler da ON trab.id_detallealquiler = da.id_detallealquiler
INNER JOIN detallealquiler da ON da.id_detallealquiler = ct.id_detallealquiler
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo

-- INNER JOIN contrato con ON da.id_contrato = con.id_contrato
-- INNER JOIN cliente cl ON con.id_cliente = cl.id_cliente
-- INNER JOIN obra o ON con.id_obra = o.id_obra

-- responsable del registro
INNER JOIN trabajador t_i ON ct.id_responsable = t_i.id_trabajador
WHERE ct.id_controltrabajo = id_controltrab_i;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_tipos`
--

DROP PROCEDURE IF EXISTS `sp_listar_tipos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_tipos`(
in tabla_i varchar(50)
)
BEGIN

CASE tabla_i
WHEN 'ARTICULO' THEN SELECT *,id_tipoarticulo as id FROM tipoarticulo;
WHEN 'CLIENTE' THEN SELECT *,id_tipocliente as id FROM tipocliente;
WHEN 'COMBUSTIBLE' THEN SELECT *,id_tipocombustible as id FROM tipocombustible;
WHEN 'COMPROBANTE' THEN SELECT *,id_tipocomprobante as id FROM tipocomprobante;
WHEN 'OBRA' THEN SELECT *,id_tipoobra as id FROM tipoobra;
WHEN 'TRABAJADOR' THEN SELECT *,id_tipotrabajador as id FROM tipotrabajador;
WHEN 'USUARIO' THEN SELECT *,id_tipousuario as id FROM tipousuario;
WHEN 'VEHICULO' THEN SELECT *,id_tipovehiculo as id FROM tipovehiculo;
WHEN 'MARCA' THEN SELECT *,id_marca as id FROM marca;
END CASE;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_tipos_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_tipos_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_tipos_ID`(
in tabla_i varchar(50),
in id_registro_i int
)
BEGIN

CASE tabla_i
WHEN 'ARTICULO' THEN SELECT *,id_tipoarticulo as id FROM tipoarticulo WHERE id_tipoarticulo = id_registro_i;
WHEN 'CLIENTE' THEN SELECT *,id_tipocliente as id FROM tipocliente WHERE id_tipocliente = id_registro_i;
WHEN 'COMBUSTIBLE' THEN SELECT *,id_tipocombustible as id FROM tipocombustible WHERE id_tipocombustible = id_registro_i;
WHEN 'COMPROBANTE' THEN SELECT *,id_tipocomprobante as id FROM tipocomprobante WHERE id_tipocomprobante = id_registro_i;
WHEN 'OBRA' THEN SELECT *,id_tipoobra as id FROM tipoobra WHERE id_tipoobra = id_registro_i;
WHEN 'TRABAJADOR' THEN SELECT *,id_tipotrabajador as id FROM tipotrabajador WHERE id_tipotrabajador = id_registro_i;
WHEN 'USUARIO' THEN SELECT *,id_tipousuario as id FROM tipousuario WHERE id_tipousuario = id_registro_i;
WHEN 'VEHICULO' THEN SELECT *,id_tipovehiculo as id FROM tipovehiculo WHERE id_tipovehiculo = id_registro_i;
WHEN 'MARCA' THEN SELECT *,id_marca as id FROM marca WHERE id_marca = id_registro_i;
END CASE;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_todo_alquiler_activo_x_contrato`
--

DROP PROCEDURE IF EXISTS `sp_listar_todo_alquiler_activo_x_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_todo_alquiler_activo_x_contrato`(
in id_contrato_i int
)
BEGIN


select con.id_contrato,da.*,es.nombre as estado_alq,a.nombre as articulo,a.serie as serie_a,
v.nombre as vehiculo,v.modelo,v.serie as serie_v,v.placa
from detallealquiler da
inner join contrato con on da.id_contrato = con.id_contrato
inner join estado es on da.est_alq = es.id_estado
left join articulo a on da.id_articulo = a.id_articulo
left join vehiculo v on da.id_vehiculo = v.id_vehiculo
WHERE con.id_contrato = id_contrato_i
ORDER BY da.estado desc, da.id_vehiculo DESC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_trabajadores`
--

DROP PROCEDURE IF EXISTS `sp_listar_trabajadores`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_trabajadores`(

)
BEGIN

SELECT t.id_trabajador,t.apellidos, t.nombres, t.fecha_nac, t.dni,t.ruc,t.telefono,t.nro_licencia,t.estado,
u.nombre as usuario, tu.nombre as tipo,tt.nombre as tipo_trab,u.f_registro,u.f_cierre_sesion,u.cambio_clave
FROM trabajador t
INNER JOIN usuario u ON t.id_trabajador = u.id_trabajador
INNER JOIN tipousuario tu ON u.id_tipousuario = tu.id_tipousuario
LEFT JOIN tipotrabajador tt ON t.id_tipotrabajador = tt.id_tipotrabajador
ORDER BY tu.nombre, t.apellidos asc, t.nombres asc;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_trabajador_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_trabajador_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_trabajador_ID`(
in id_trabajador_i int
)
BEGIN


SELECT t.id_trabajador,t.apellidos, t.nombres, t.fecha_nac, t.dni,t.ruc,t.telefono,t.nro_licencia,t.estado,
tt.id_tipotrabajador,
u.nombre as usuario, tu.id_tipousuario, tu.nombre as tipo,u.f_registro,u.f_cierre_sesion,u.cambio_clave
FROM trabajador t
INNER JOIN usuario u ON t.id_trabajador = u.id_trabajador
INNER JOIN tipousuario tu ON u.id_tipousuario = tu.id_tipousuario
INNER JOIN tipotrabajador tt ON tt.id_tipotrabajador = t.id_tipotrabajador

-- no lista el ADMIN = usuario ADMIN  general
WHERE t.id_trabajador= id_trabajador_i AND t.id_trabajador <> 1;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_vehiculos`
--

DROP PROCEDURE IF EXISTS `sp_listar_vehiculos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_vehiculos`()
BEGIN

SELECT v.id_vehiculo,m.nombre as marca,tv.nombre as tipovehiculo,v.nombre,
v.modelo,v.serie,v.motor,v.color,v.placa,e.nombre as estado,v.precio_alq as precio_hora,
count(mt.id_mantenimiento) as n_mant
FROM vehiculo v
LEFT JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
LEFT JOIN marca m ON v.id_marca = m.id_marca
INNER JOIN estado e ON v.estado = e.id_estado

LEFT JOIN mantenimiento mt ON v.id_vehiculo = mt.id_vehiculo

GROUP BY v.id_vehiculo

ORDER BY e.nombre asc, tv.nombre asc;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_vehiculos_trabajando`
--

DROP PROCEDURE IF EXISTS `sp_listar_vehiculos_trabajando`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_vehiculos_trabajando`()
BEGIN

SELECT v.* FROM vehiculo v
INNER JOIN detallealquiler da ON v.id_vehiculo = da.id_vehiculo
INNER JOIN trabvehiculo tv ON da.id_detallealquiler = tv.id_detallealquiler
WHERE v.estado = 'C';

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_vehiculos_x_contrato`
--

DROP PROCEDURE IF EXISTS `sp_listar_vehiculos_x_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_vehiculos_x_contrato`(
in id_contrato_i int
)
BEGIN

SELECT da.*,
cl.nombre as cliente,
o.nombre as obra,
-- concat(tr.apellidos,', ',tr.nombres) as operario,
concat( v.`nombre`,'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre_c,
concat( substr(v.`nombre`,1,4),'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre
FROM detallealquiler da
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca
INNER JOIN contrato con ON da.id_contrato = con.id_contrato
INNER JOIN cliente cl ON con.id_cliente = cl.id_cliente
INNER JOIN obra o ON con.id_obra = o.id_obra
-- INNER JOIN trabajador tr ON tr.id_trabajador = t.id_trabajador
WHERE con.id_contrato = id_contrato_i
ORDER BY da.id_detallealquiler;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_vehiculo_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_vehiculo_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_vehiculo_ID`(
in id_vehiculo_i int
)
BEGIN

SELECT v.id_vehiculo,m.id_marca,m.nombre as marca,tv.id_tipovehiculo,tv.nombre as tipovehiculo,v.nombre,
v.modelo,v.serie,v.motor,v.color,v.placa,e.nombre as estado,v.precio_alq as precio_hora,
horometro_ac,kilometraje_ac,v.rendimiento,
count(mt.id_mantenimiento) as n_mant
FROM vehiculo v
LEFT JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
LEFT JOIN marca m ON v.id_marca = m.id_marca
INNER JOIN estado e ON v.estado = e.id_estado

LEFT JOIN mantenimiento mt ON v.id_vehiculo = mt.id_vehiculo

WHERE v.id_vehiculo = id_vehiculo_i

GROUP BY v.id_vehiculo;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_abastecimiento`
--

DROP PROCEDURE IF EXISTS `sp_registro_abastecimiento`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_abastecimiento`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_tipocomprobante_i int,
in id_tipocombustible_i int,
in fecha_i timestamp,
in nro_comprobante_i varchar(20),
in nro_operacion_ch_i varchar(25),
in abastecedor_i varchar(200),
in cantidad_i decimal(10,2),
in precio_u_i decimal(10,2),
in total_i decimal(10,2),
out salida varchar(10)
)
BEGIN

DECLARE n int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

##### VAlidacion por nro_comprobante

SELECT ifnull(count(*),0) into n FROM abastecimiento
WHERE nro_comprobante = UPPER(nro_comprobante_i);

if (n = 0) then

INSERT INTO abastecimiento VALUES
(
NULL,
id_tipocomprobante_i,
id_tipocombustible_i,
fecha_i,
UPPER(nro_comprobante_i),
UPPER(nro_operacion_ch_i),
UPPER(abastecedor_i),
cantidad_i,
precio_u_i,
total_i,
0
);

SELECT ifnull(count(*),0) into n FROM abastecimiento
WHERE nro_comprobante = UPPER(nro_comprobante_i);

if (n = 1) then

  COMMIT;

  set salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG abastecimiento combustible','abastecimiento',ip,nav,so);

else

  ROLLBACK;

end if;

end if;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_articulos`
--

DROP PROCEDURE IF EXISTS `sp_registro_articulos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_articulos`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_tipoarticulo_i int,
in id_almacen_i int,
in serie_i varchar(20),
in nombre_i varchar(100),
in descripcion_i varchar(300),
in precio_alq_i decimal(10,2),
out salida varchar(10)
)
BEGIN

DECLARE n int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

SELECT count(*) into n FROM articulo
WHERE serie = serie_i;

if (n = 0 ) then

	INSERT INTO articulo VALUES
	(
	NULL,
	id_tipoarticulo_i,
	id_almacen_i,
	serie_i,
	upper(nombre_i),
	upper(descripcion_i),
	precio_alq_i,
	DEFAULT
	);

	SELECT count(*) into n FROM articulo
	WHERE serie = serie_i;

	if (n = 1) then 

    COMMIT;
    set salida = 'OK';
  	CALL sp_regs(id_usuario_i,'REG ARTICULOS','articulo',ip,nav,so);

  else

    ROLLBACK;

	end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_asigna_operario`
--

DROP PROCEDURE IF EXISTS `sp_registro_asigna_operario`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_asigna_operario`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_detallealquiler_i int,
in id_trabajador_i int,
in fecha_i timestamp,
out salida varchar(10)
)
BEGIN

DECLARE n int;
DECLARE id_t int;

SELECT count(*) into n FROM trabvehiculo
WHERE id_detallealquiler = id_detallealquiler_i
AND id_trabajador = id_trabajador_i

AND estado = 'A';

if (n = 0 AND id_trabajador_i > 0) then
#### cuando se ingresa un nuevo operario y se desactiva le anterior
SELECT
 ifnull(count(tv.id_trabvehiculo),0) into id_t
FROM detallealquiler d
INNER JOIN vehiculo v ON v.id_vehiculo = d.id_vehiculo
LEFT JOIN trabvehiculo tv ON d.id_detallealquiler = tv.id_detallealquiler
#LEFT JOIN trabajador t ON tv.id_trabajador = t.id_trabajador
WHERE d.id_detallealquiler = id_detallealquiler_i AND tv.estado = 'A';

if (id_t > 0) then

  UPDATE trabvehiculo SET estado = 'B' WHERE id_detallealquiler = id_detallealquiler_i;

end if;

INSERT INTO trabvehiculo VALUES
(
  NULL,
  id_detallealquiler_i,
  id_trabajador_i,
  fecha_i,
  NULL,
  DEFAULT
  );

  SELECT count(*) into n FROM trabvehiculo
  WHERE id_detallealquiler = id_detallealquiler_i
  AND id_trabajador = id_trabajador_i
  AND estado = 'A';

  if (n = 1) then

    CALL sp_regs(id_usuario_i,'ASIGNACION VEHICULO OPERADOR','trabvehiculo',ip,nav,so);

    set salida = 'OK';

  end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_cliente`
--

DROP PROCEDURE IF EXISTS `sp_registro_cliente`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_cliente`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_tipocliente_i int,
in codigo_i varchar(15),
in nombre_i varchar(100),
in direccion_i varchar(200),
in telefono_i varchar(20),
out id_c int
)
BEGIN

DECLARE id int;

INSERT INTO cliente VALUES
(
NULL,
id_tipocliente_i,
codigo_i,
UPPER(nombre_i),
UPPER(direccion_i),
telefono_i,
DEFAULT,
DEFAULT
);

SELECT id_cliente into id FROM cliente WHERE UPPER(nombre_i) = nombre AND codigo_i = codigo;

if (id > 0) then

  CALL sp_regs(id_usuario_i,concat('REGISTRO CLIENTE: ',UPPER(nombre_i)),'cliente',ip,nav,so);
  SET id_c = id;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_contrato`
--

DROP PROCEDURE IF EXISTS `sp_registro_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_contrato`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_obra_i int,
in id_cliente_i int,
in f_inicio_i timestamp,
in f_fin_i timestamp,
in presupuesto_i decimal(10,2),
in detalle_i varchar(400),
out salida varchar(10)
)
BEGIN

DECLARE n int;

SET n = 0;

## n se puede realizar un contrato si la obra y el cliente es el mismo
###################################
SELECT COUNT(id_contrato) INTO n FROM contrato
WHERE id_obra = id_obra_i AND id_cliente = id_cliente_i;

if ( n = 0 ) then

INSERT INTO contrato VALUES(
NULL,
id_obra_i,
id_cliente_i,
f_inicio_i,
f_fin_i,
presupuesto_i,
UPPER(detalle_i),
DEFAULT
);

SELECT COUNT(id_contrato) INTO n FROM contrato
WHERE id_obra = id_obra_i AND id_cliente = id_cliente_i;

if (n = 1) then

  UPDATE obra SET estado = 'H' WHERE id_obra = id_obra_i;

  CALL sp_regs(id_usuario_i,'REG CONTRATO','contrato',ip,nav,so);

  set salida = 'OK';

end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_control_combustible`
--

DROP PROCEDURE IF EXISTS `sp_registro_control_combustible`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_control_combustible`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_detalle_i int,
in trabajador_i varchar(200),
in fecha_i timestamp,
in nro_guia_i varchar(20),
in nro_vale_i varchar(20),
in nro_surtidor_i varchar(20),
in cant_combustible_i decimal(10,2),
in horometro_i decimal(10,2),
in kilometraje_i decimal(10,2),
out salida varchar(20)
)
BEGIN

DECLARE id_responsable_a int;
DECLARE id_operario_a int;
DECLARE id_detabas_a int;
DECLARE n int;
DECLARE n_g int;
DECLARE id_vh int;
DECLARE id_v int;
DECLARE id_ct int;
DECLARE id_con int;

DECLARE st decimal(10,2); ##Cantidad consumida de una guia
DECLARE cant_abast decimal(10,2); ## cantidad total comprada en una guia
DECLARE nro_parte_a varchar(20); -- se almacena el nro_operacion al que pertence el vale


-- handler para Transaccion
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

-- inicio de transaccion
START TRANSACTION;

-- -->>>> esta regla sera obviada por cuestiones de registro inmediato
-- solo se aplica si las guias son ngresadas de manera consecutiva en el acto
-- para este caso se tendria que modificar el procedimiento que registre las guias
-- en donde se debe de sumar el stock con el nuevo ingreso de combustible
SELECT stock into st FROM detalleabastecimiento WHERE nro_guia = nro_guia_i;

SELECT count(*) into n FROM consumo WHERE nro_vale = nro_vale_i;

SELECT count(*) into n_g  FROM detalleabastecimiento WHERE nro_guia = UPPER(nro_guia_i);

SELECT id_trabajador into id_operario_a FROM trabajador WHERE replace(concat(apellidos,nombres),' ','') = UPPER(trabajador_i);

-- selecciona el nro de parte diario al que pertenece el vale ingresado
-- es obligatorio registrar primero el parte diario
SELECT
c.nro_parte into nro_parte_a
FROM controltrabajo c
WHERE c.id_detallealquiler = id_detalle_i AND
fecha = date(fecha_i) AND
(horometro_i BETWEEN horometro_inicio AND horometro_fin )
ORDER BY c.id_controltrabajo DESC
LIMIT 1; -- de haber 2 toma el ultimo parte registrado

-- se obtiene el id_controltrabajo
select id_controltrabajo into id_ct FROM controltrabajo WHERE nro_parte = nro_parte_a;

/*
condicion:
- no estar registrado el vale
- debe existir la guia de abastecimeinto
- debe existir el operario
- debe estar registrado el parte diario //Control trabajo
*/

if (id_ct > 0) then -- valida si existe el parte para este vale

if (n = 0 AND n_g = 1 AND id_operario_a > 0 ) then

-- validacion CORRECTA --> if (cant_combustible_i <= st) then
-- se obvia esta validacion con:
if (cant_combustible_i = cant_combustible_i) then

#####  trae el id_detalleabastecimiento
SELECT id_detalleabastecimiento into id_detabas_a FROM detalleabastecimiento WHERE nro_guia = nro_guia_i;

### traer id_responsable = trabajador que ha registrado ese vale
SELECT id_trabajador into id_responsable_a FROM usuario WHERE id_usuario = id_usuario_i;

INSERT INTO consumo
VALUES(
NULL,
id_detalle_i,
id_operario_a,
id_responsable_a,
id_detabas_a,
fecha_i,
UPPER(nro_guia_i),
UPPER(nro_vale_i),
UPPER(nro_surtidor_i),
cant_combustible_i,
horometro_i,
kilometraje_i
);

SELECT count(*) into n FROM consumo
WHERE id_operario = id_operario_a
AND id_detallealquiler = id_detalle_i
AND date(fecha) = date(fecha_i)
AND nro_vale = UPPER(nro_vale_i);

select id_vehiculo into id_v FROM detallealquiler WHERE id_detallealquiler = id_detalle_i;


if (n = 1) then

  -- id_consumo
  SELECT id_consumo into id_con FROM consumo
  WHERE id_operario = id_operario_a
  AND id_detallealquiler = id_detalle_i
  AND date(fecha) = date(fecha_i)
  AND nro_vale = UPPER(nro_vale_i);

  -- insercion en tabla partevale::: se liga el vale al parte al cual pertenece
  INSERT INTO partevale VALUES(
  NULL,
  id_ct,
  id_con,
  now()
  );
  -- --------------

  UPDATE detalleabastecimiento SET stock = stock-cant_combustible_i
  WHERE id_detalleabastecimiento = id_detabas_a;

  UPDATE vehiculo SET horometro_ac = horometro_i
  WHERE id_vehiculo = id_v
  AND horometro_ac < horometro_i;

  UPDATE vehiculo SET kilometraje_ac = kilometraje_i
  WHERE id_vehiculo = id_v
  AND kilometraje_ac < kilometraje_i;

  -- todo bien
  COMMIT;

  set salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG CONSUMO DE COMBUSTUBLE','consumo,detalleabastecimiento',ip,nav,so);

end if;

else
  ROLLBACK;
  ## la cantidad excede al total de la guia
  set salida = CONCAT('NO:',st-cant_combustible_i);

end if; ### fin condicion de cantidades

end if; ## nro_vale

else -- parte para vale

  ROLLBACK;
  set salida = 'PARTE';

end if; -- existe parte para vale

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_detalle_abastecimiento`
--

DROP PROCEDURE IF EXISTS `sp_registro_detalle_abastecimiento`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_detalle_abastecimiento`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_tipocombustible_i int,
in nro_placa_i varchar(15),
in nro_licencia_i varchar(15),
in fecha_i timestamp,
in nro_guia_i varchar(20),
in cantidad_i decimal(10,2),
in abastecedor_i varchar(200),
out salida varchar(10)
)
BEGIN

DECLARE id_v,id_t int;
DECLARE n int;

SELECT ifnull(count(*),0) into n FROM detalleabastecimiento WHERE nro_guia = nro_guia_i;

## abastecimeinto dario con guias de remision
## luego estas guias son agrupadas en solo id_abasteciemiento
## que se vincula a una factura o comprobante

SELECT ifnull(id_vehiculo,0) into id_v FROM vehiculo
WHERE placa = nro_placa_i AND estado = 'G';
### ESTADO = G ==> RESERVADO

SELECT ifnull(id_trabajador,0) into id_t FROM trabajador
WHERE UPPER(nro_licencia) = UPPER(nro_licencia_i)
AND estado = 'A';

if (n = 0 AND id_v > 0 AND id_t > 0) then

INSERT INTO detalleabastecimiento VALUES
(
NULL,
0,
id_tipocombustible_i,
id_v,
id_t,
fecha_i,
UPPER(nro_guia_i),
cantidad_i,
cantidad_i,
UPPER(abastecedor_i)
);

SELECT count(*) into n FROM detalleabastecimiento WHERE nro_guia = nro_guia_i;

if (n = 1) then

  CALL sp_regs(id_usuario_i,'REG DETALLE ABASTECIMIENTO','detalleabastecimiento',ip,nav,so);

  set salida = 'OK';

end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_detalle_alquiler_ar`
--

DROP PROCEDURE IF EXISTS `sp_registro_detalle_alquiler_ar`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_detalle_alquiler_ar`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_contrato_i int,
in id_vehiculo_i int,
in id_articulo_i int,
in fecha_i timestamp,
in estado_i varchar(50),
in observacion_i varchar(200),
out salida varchar(10)
)
BEGIN

DECLARE est char(1);
declare n int;
DECLARE precio_a decimal(10,2);


######## se realiza el alquiler del vehiculo o articulo en el mismo ID_ALQUILER
###alquiler genera la relacion entre contrato y detalle_alquiler

SELECT a.estado into est FROM articulo a
WHERE a.id_articulo = id_articulo_i;

SELECT a.precio_alq into precio_a FROM articulo a
WHERE a.id_articulo = id_articulo_i;

#################################

SELECT count(*) into n FROM detallealquiler
  WHERE id_articulo = id_articulo_i
  AND id_contrato = id_contrato_i
  AND est_alq = 'A';

if (est = 'A' OR est = 'D') = 1 then

if (  n = 0 ) then

	INSERT INTO detallealquiler VALUES(
	NULL,
	id_contrato_i,
	id_vehiculo_i,
	id_articulo_i,
  precio_a,
	fecha_i,
	UPPER(estado_i),
	UPPER(observacion_i),
  DEFAULT
	);

  SELECT count(*) into n FROM detallealquiler
  WHERE id_articulo = id_articulo_i
  AND id_contrato = id_contrato_i
  AND est_alq = 'A';

  if (n = 1) then

	  UPDATE articulo SET estado = 'C' WHERE id_articulo = id_articulo_i;

    CALL sp_regs(id_usuario_i,'REGISTRO DE ALQUILER','detallealquiler,alquiler,articulo',ip,nav,so);

    set salida = 'OK';

  end if;

end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_detalle_alquiler_v`
--

DROP PROCEDURE IF EXISTS `sp_registro_detalle_alquiler_v`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_detalle_alquiler_v`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_contrato_i int,
in id_vehiculo_i int,
in id_articulo_i int,
in fecha_i timestamp,
in estado_i varchar(50),
in observacion_i varchar(200),
out salida varchar(10)
)
BEGIN

DECLARE est char(1);
declare n int;
DECLARE precio_a decimal(10,2);

######## se realiza el alquiler del vehiculo o articulo en el mismo ID_ALQUILER
###alquiler genera la relacion entre contrato y detalle_alquiler

SELECT v.estado into est FROM vehiculo v
WHERE v.id_vehiculo = id_vehiculo_i;

SELECT v.precio_alq into precio_a FROM vehiculo v
WHERE v.id_vehiculo = id_vehiculo_i;

#################################

SELECT count(*) into n FROM detallealquiler
  WHERE id_vehiculo = id_vehiculo_i
  AND id_contrato = id_contrato_i
  AND est_alq = 'A';

if (est = 'A' OR est = 'D') = 1 then

if ( n = 0 ) then

	INSERT INTO detallealquiler VALUES(
	NULL,
	id_contrato_i,
	id_vehiculo_i,
	id_articulo_i,
  precio_a,
	fecha_i,
	UPPER(estado_i),
	UPPER(observacion_i),
  DEFAULT
	);

  SELECT count(*) into n FROM detallealquiler
  WHERE id_vehiculo = id_vehiculo_i
  AND id_contrato = id_contrato_i
  AND est_alq = 'A';

  if (n = 1) then

	  UPDATE vehiculo SET estado = 'C' WHERE id_vehiculo = id_vehiculo_i;

    CALL sp_regs(id_usuario_i,'REGISTRO DE ALQUILER','detallealquiler,alquiler,vehiculo',ip,nav,so);

    SET salida = 'OK';

  end if;

end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_devolucion_articulo`
--

DROP PROCEDURE IF EXISTS `sp_registro_devolucion_articulo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_devolucion_articulo`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_detallealquiler_i int,
in estado_i varchar(50),
in observacion_i varchar(200),
in fecha_i timestamp,
out salida varchar(10)
)
BEGIN

DECLARE n int;
DECLARE m int;
DECLARE id_a int;
DECLARE id_trabv int;

SELECT ifnull(count(*),0) into n FROM devolucion
WHERE id_detallealquiler = id_detallealquiler_i;

SELECT ifnull(count(*),0) into m FROM detallealquiler
WHERE id_detallealquiler = id_detallealquiler_i AND id_articulo <> 0;

if (n = 0 AND m = 1) then

INSERT INTO devolucion VALUES
(
NULL,
id_detallealquiler_i,
fecha_i,
upper(estado_i),
upper(observacion_i)
);

SELECT count(*) into n FROM devolucion
WHERE id_detallealquiler = id_detallealquiler_i;


if (n = 1) then

  CALL sp_regs(id_usuario_i,'REG DEVOL ARTICULO','devolucion',ip,nav,so);

  SELECT id_articulo into id_a FROM articulo
  WHERE id_articulo IN (SELECT id_articulo FROM detallealquiler
  WHERE id_detallealquiler =  id_detallealquiler_i);

  #1###actualiza estado de articulo C -> D -> Disponible
  UPDATE articulo SET estado = 'D' WHERE id_articulo = id_a;

  #3###actualiza estado de detallealquiler est_alq A -> B
  UPDATE detallealquiler SET est_alq = 'B' WHERE id_detallealquiler = id_detallealquiler_i;

  SET salida = 'OK';

  CALL sp_regs(id_usuario_i,'UPDATE','articulo,detallealquiler',ip,nav,so);


end if; ## n= 1

end if; ## n = 0
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_devolucion_vehiculo`
--

DROP PROCEDURE IF EXISTS `sp_registro_devolucion_vehiculo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_devolucion_vehiculo`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_detallealquiler_i int,
in estado_i varchar(50),
in observacion_i varchar(200),
in fecha_i timestamp,
out salida varchar(10)
)
BEGIN

DECLARE n int;
DECLARE m int;
DECLARE id_v int;
DECLARE id_trabv int;

-- handler para Transaccion
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

SELECT ifnull(count(*),0) into n FROM devolucion
WHERE id_detallealquiler = id_detallealquiler_i;

SELECT ifnull(count(*),0) into m FROM detallealquiler
WHERE id_detallealquiler = id_detallealquiler_i AND id_vehiculo <> 0;

-- inicio de transaccion
START TRANSACTION;

if (n = 0 AND m = 1) then

INSERT INTO devolucion VALUES
(
NULL,
id_detallealquiler_i,
fecha_i,
upper(estado_i),
upper(observacion_i)
);

SELECT count(*) into n FROM devolucion
WHERE id_detallealquiler = id_detallealquiler_i;


if (n = 1) then

  CALL sp_regs(id_usuario_i,'REG DEVOL VEHICULO','devolucion',ip,nav,so);

  SELECT id_vehiculo into id_v FROM vehiculo
  WHERE id_vehiculo IN (SELECT id_vehiculo FROM detallealquiler
  WHERE id_detallealquiler =  id_detallealquiler_i);

  #1###actualiza estado de vehiculo C -> D -> Disponible
  UPDATE vehiculo SET estado = 'D' WHERE id_vehiculo = id_v;

  SELECT id_trabvehiculo into id_trabv FROM trabvehiculo t
  WHERE id_detallealquiler = id_detallealquiler_i AND t.estado = 'A';

  #2###actualiza estado de trabvehiculo A->B /// fecha = now()
  UPDATE trabvehiculo SET estado = 'B', f_fin = fecha_i WHERE id_trabvehiculo = id_trabv;

  #3###actualiza estado de detallealquiler est_alq A -> B
  UPDATE detallealquiler SET est_alq = 'B' WHERE id_detallealquiler = id_detallealquiler_i;

  SET salida = 'OK';

  CALL sp_regs(id_usuario_i,'UPDATE','vehiculo,trabvehiculo,detallealquiler',ip,nav,so);

  -- todo bien
  COMMIT;

else
  -- algo mal
  ROLLBACK;

end if; ## n= 1

end if; ## n = 0

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_flete`
--

DROP PROCEDURE IF EXISTS `sp_registro_flete`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_flete`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_detallealquiler_i int,
in concepto_i varchar(200),
in observacion_i varchar(400),
in fecha_i timestamp,
in monto_i decimal(10,2),
out salida varchar(10)
)
BEGIN

DECLARE n int;

######## UNA SOLA MOVILIZACION POR CADA VEHICULO
SELECT ifnull(count(*),0) into n FROM transporte WHERE id_detallealquiler = id_detallealquiler_i;

if (n = 0) then


  INSERT INTO transporte VALUES(
  NULL,
  id_detallealquiler_i,
  upper(concepto_i),
  upper(observacion_i),
  fecha_i,
  monto_i
  );

  SELECT ifnull(count(*),0) into n FROM transporte WHERE id_detallealquiler = id_detallealquiler_i;

  if (n = 1) then

    set salida = 'OK';

  end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_mantenimiento`
--

DROP PROCEDURE IF EXISTS `sp_registro_mantenimiento`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_mantenimiento`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_vehiculo_i int,
in causa_i varchar(200),
in descripcion_i varchar(400),
in lugar_averia_i varchar(200),
in lugar_mant_i varchar(200),
in horometro_i decimal(10,2),
in kilometraje_i decimal(10,2),
in f_ingreso_i date,
in f_salida_i date,
in estado_actual_i varchar(200),
in costo_i decimal(10,2),
out salida varchar(10)
)
BEGIN

DECLARE n int;
DECLARE id_ct int;
DECLARE id_mant int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

SELECT count(*) into n FROM mantenimiento
WHERE concat(id_vehiculo,causa,lugar_averia,f_ingreso) = UPPER(concat(id_vehiculo_i,causa_i,lugar_averia_i,f_ingreso_i) );

-- se obtiene el id_controltrabajo para registrarlo en tabla >>> partemant
-- es obligatorio registrar primero el parte diario
SELECT
c.id_controltrabajo into id_ct
FROM controltrabajo c
INNER JOIN detallealquiler da ON c.id_detallealquiler = da.id_detallealquiler
-- INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
WHERE da.id_vehiculo = id_vehiculo_i AND
(horometro_i BETWEEN c.horometro_inicio AND c.horometro_fin )
ORDER BY c.id_controltrabajo
LIMIT 1; -- en caso de haber dos, toma el primer parte diario registrado


if ((f_salida_i >= f_ingreso_i) AND n = 0 )then

INSERT INTO  mantenimiento VALUES
(
NULL,
id_vehiculo_i,
UPPER(causa_i),
UPPER(descripcion_i),
UPPER(lugar_averia_i),
UPPER(lugar_mant_i),
horometro_i,
kilometraje_i,
f_ingreso_i,
f_salida_i,
UPPER(estado_actual_i),
costo_i
);

SELECT count(*) into n FROM mantenimiento
WHERE concat(id_vehiculo,causa,lugar_averia,f_ingreso) = UPPER(concat(id_vehiculo_i,causa_i,lugar_averia_i,f_ingreso_i) );

SELECT id_mantenimiento into id_mant FROM mantenimiento
WHERE concat(id_vehiculo,causa,lugar_averia,f_ingreso) = UPPER(concat(id_vehiculo_i,causa_i,lugar_averia_i,f_ingreso_i) );


if (n = 1) then

  COMMIT;

    set salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG mantenimiento','mantenimiento',ip,nav,so);

  -- registro la relacion con parte diario
  if (id_ct > 0) then
    INSERT INTO partemant VALUES
    (
    NULL,
    id_ct,
    id_mant,
    now()
    );
  end if;
else

  ROLLBACK;

end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_notifica_mant`
--

DROP PROCEDURE IF EXISTS `sp_registro_notifica_mant`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_notifica_mant`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_tipovehiculo_i int,
in id_marca_i int,
in intervalo_i decimal(10,2),
in notifica_val_i decimal(10,2),
in unidad_i varchar(10),
in notificacion_i varchar(400),
out salida varchar(10)
)
BEGIN

DECLARE n int;

SELECT count(*) into n FROM notificamant
WHERE id_tipovehiculo = id_tipovehiculo_i
and id_marca = id_marca_i;

if (n = 0) then

INSERT INTO notificamant VALUES
(
NULL,
id_tipovehiculo_i,
id_marca_i,
intervalo_i,
notifica_val_i,
UPPER(unidad_i),
UPPER(notificacion_i),
now(),
DEFAULT
);

SELECT count(*) into n FROM notificamant
WHERE id_tipovehiculo = id_tipovehiculo_i
and id_marca = id_marca_i;

if (n = 1 ) then

  CALL sp_regs(id_usuario_i,'REG NOTIFICACION','notificamant',ip,nav,so);

  set salida = 'OK';

end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_obra`
--

DROP PROCEDURE IF EXISTS `sp_registro_obra`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_obra`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_tipo_obra_i int,
in nombre_i varchar(200),
out salida varchar(10)
)
BEGIN

DECLARE n int;
DECLARE fecha_a timestamp;

SET fecha_a = now();

INSERT INTO obra VALUES
(
NULL,
id_tipo_obra_i,
upper(nombre_i),
fecha_a,
DEFAULT
);

SELECT count(*) into n FROM obra WHERE nombre = upper(nombre_i) and fecha = fecha_a;

if (n = 1) then

  CALL sp_regs(id_usuario_i,'REG OBRA','obra',ip,nav,so);

  set salida = 'OK';

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_parte_maquinaria`
--

DROP PROCEDURE IF EXISTS `sp_registro_parte_maquinaria`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_parte_maquinaria`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_detalle_i int,
in trabajador_i varchar(200),
in nro_interno_i int,
in nro_parte_i varchar(20),
in fecha_i timestamp,
in lugar_trabajo_i varchar(200),
in tarea_i varchar(400),
in agua_i decimal(10,2),
in petroleo_i decimal(10,2),
in gasolina_i decimal(10,2),
in ac_motor_i decimal(10,2),
in ac_transmision_i decimal(10,2),
in ac_hidraulico_i decimal(10,2),
in grasa_i decimal(10,2),
in observacion_i varchar(400),
in turno_i char(1),
in descuento_i decimal(10,2),
in horom_inicio_i decimal(10,2),
in horom_fin_i decimal(10,2),
in total_h_i decimal(10,2),
in hrs_i int,
in min_i int,
out salida varchar(10)
)
BEGIN
## 9,'::1','Firefox','Windows',2,'023944','sechura','superficie zzxy',30129,30239,110
DECLARE id_responsable_a int;
DECLARE id_operario_a int;

DECLARE n int;
DECLARE m int;
DECLARE id_v int;

SELECT id_trabajador into id_responsable_a FROM usuario WHERE id_usuario = id_usuario_i;

SELECT id_trabajador into id_operario_a FROM trabajador WHERE concat(apellidos,nombres) = UPPER(trabajador_i);

SELECT ifnull(count(id_controltrabajo),0) into n FROM controltrabajo
WHERE nro_parte = nro_parte_i;


SELECT id_vehiculo into id_v FROM detallealquiler WHERE id_detallealquiler = id_detalle_i;

-- Si puede haber más de un parte diario por vehiculo

-- SELECT count(id_controltrabajo) into m FROM controltrabajo
-- WHERE concat(id_trabvehiculo,fecha) = concat(id_trabvehiculo_i,fecha_i);

if (n = 0 AND id_operario_a > 0) then

INSERT INTO controltrabajo
VALUES(
NULL,
id_detalle_i,
id_operario_a,
id_responsable_a,
nro_interno_i,
UPPER(nro_parte_i),
fecha_i,
UPPER(lugar_trabajo_i),
UPPER(tarea_i),
agua_i,
petroleo_i,
gasolina_i,
ac_motor_i,
ac_transmision_i,
ac_hidraulico_i,
grasa_i,
UPPER(observacion_i),
UPPER(turno_i),
descuento_i,
horom_inicio_i,
horom_fin_i,
total_h_i,
hrs_i,
min_i
);


SELECT ifnull(count(*),0) into n FROM controltrabajo
WHERE id_detallealquiler = id_detalle_i
AND id_operario = id_operario_a
AND nro_parte = UPPER(nro_parte_i);

if (n = 1) then


  UPDATE vehiculo SET horometro_ac = horom_fin_i
  WHERE id_vehiculo = id_v
  AND horometro_ac < horom_fin_i;

  SET salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG PARTE MAQUINARIA','controltrabajo',ip,nav,so);

end if;

end if; ## valida por nro parte

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_tipo`
--

DROP PROCEDURE IF EXISTS `sp_registro_tipo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_tipo`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in nombre_i varchar(200),
in tabla_i varchar(60),
in estado_i char(1),
out salida varchar(10)
)
BEGIN

CASE tabla_i
WHEN 'ARTICULO' THEN INSERT INTO tipoarticulo VALUES(NULL,UPPER(nombre_i),estado_i);
WHEN 'CLIENTE' THEN INSERT INTO tipocliente VALUES(NULL, UPPER(nombre_i), estado_i);
WHEN 'COMBUSTIBLE' THEN INSERT INTO tipocombustible VALUES(NULL, UPPER(nombre_i), DEFAULT,estado_i);
WHEN 'COMPROBANTE' THEN INSERT INTO tipocomprobante VALUES(NULL, UPPER(nombre_i), estado_i);
WHEN 'OBRA' THEN INSERT INTO tipoobra VALUES(NULL, UPPER(nombre_i), estado_i);
WHEN 'TRABAJADOR' THEN INSERT INTO tipotrabajador VALUES(NULL, UPPER(nombre_i),estado_i);
WHEN 'USUARIO' THEN INSERT INTO tipousuario VALUES(NULL, UPPER(nombre_i),estado_i);
WHEN 'VEHICULO' THEN INSERT INTO tipovehiculo VALUES(NULL,UPPER(nombre_i), estado_i);
WHEN 'MARCA' THEN INSERT INTO marca VALUES(NULL, UPPER(nombre_i),estado_i);
END CASE;

set salida = 'OK';

CALL sp_regs(id_usuario_i,concat('REGISTRO TIPO: ',UPPER(nombre_i)),tabla_i,ip,nav,so);

-- WHEN '' THEN INSERT INTO VALUES(NULL,);

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_trabajador`
--

DROP PROCEDURE IF EXISTS `sp_registro_trabajador`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_trabajador`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in apellidos_i varchar(50),
in nombres_i varchar(50),
in fecha_nac_i date,
in dni_i varchar(10),
in ruc_i varchar(15),
in telefono_i varchar(20),
in id_tipo_u_i int,
in id_tipotrabajador_i int,
in nro_licencia_i varchar(15),
out salida varchar(10)
)
BEGIN

DECLARE n int;
DECLARE id_t int;

set n = 0;

SELECT count(id_trabajador) into n FROM trabajador
WHERE dni = dni_i or concat(apellidos,nombres) = concat(apellidos_i,nombres_i);

if (n = 0) then

INSERT INTO trabajador VALUES
(
NULL,
id_tipotrabajador_i,
UPPER(apellidos_i),
UPPER(nombres_i),
fecha_nac_i,
dni_i,
ruc_i,
telefono_i,
UPPER(nro_licencia_i),
DEFAULT
);

SELECT id_trabajador into id_t FROM trabajador
WHERE dni = dni_i;

if (id_t > 0) then

  CALL sp_crear_usuario(id_usuario_i,ip,nav,so,id_t,id_tipo_u_i,@s);

  if (@s is not null) then
    SET salida = @s;
  end if;

end if;
#else

#select concat('algo mal=>',n);

end if;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_vehiculos`
--

DROP PROCEDURE IF EXISTS `sp_registro_vehiculos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_vehiculos`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_marca_i int,
in id_tipovehiculo_i int,
in rendimiento_i varchar(10),
in nombre_i varchar(100),
in modelo_i varchar(10),
in serie_i varchar(20),
in motor_i varchar(20),
in color_i varchar(10),
in placa_i varchar(10),
in precio_h decimal(10,2),
in horometro_i decimal(10,2),
in kilometraje_i decimal(10,2),
out salida varchar(10)
)
BEGIN

DECLARE n int;
DECLARE id_v int;
DECLARE tv varchar(30);
DECLARE est char(1);

-- handler para Transaccion
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

-- placas diferentes
SELECT count(*) into n FROM vehiculo
WHERE placa = upper(ifnull(placa_i,'x'));

#SEgun datos la SERIE puede repetirse.... Preguntar

######### seregistran todos sin excepcion, hasta tener datos completos de los vehiculos

SELECT nombre as tv FROM tipovehiculo WHERE id_tipovehiculo = id_tipovehiculo_i;

if (tv = 'SURTIDOR') then
  set est = 'G'; #### estado será RESERVADO /no se permite alquiler
else
  set est = 'A'; ## estado A Activo / se puede alquilar
end if;

-- SELECT count(id_vehiculo) into n FROM vehiculo	WHERE concat(serie,motor,placa) = UPPER(concat(serie_i,motor_i,placa_i));

if (n = 0) then

	INSERT INTO vehiculo VALUES
	(
	NULL,
	id_marca_i,
	id_tipovehiculo_i,
	upper(nombre_i),
	upper(modelo_i),
	upper(serie_i),
	upper(motor_i),
	upper(color_i),
	upper(placa_i),
  upper(rendimiento_i),
	est,
  horometro_i,
  kilometraje_i,
  precio_h
	);

	SELECT count(id_vehiculo) into n FROM vehiculo
	WHERE concat(serie,motor,placa) = UPPER(concat(serie_i,motor_i,placa_i));

	if (n = 1) then

    COMMIT;

		CALL sp_regs(id_usuario_i,'REG VEHICULOS','vehiculo, vehiculoph',ip,nav,so);

		set salida = 'OK';

  else
    ROLLBACK;

	end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_regs`
--

DROP PROCEDURE IF EXISTS `sp_regs`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_regs`(
in id_usuario_i int,
in accion_i varchar(200),
in tablas_afectadas_i varchar(200),
in ip_cliente_i varchar(16),
in nav_cliente_i varchar(50),
in so_cliente_i varchar(50)
)
BEGIN

INSERT INTO regs VALUES (NULL, id_usuario_i, now(), upper(accion_i), upper(tablas_afectadas_i),
ip_cliente_i,nav_cliente_i, so_cliente_i);

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_consumo_detal`
--

DROP PROCEDURE IF EXISTS `sp_REP_consumo_detal`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_consumo_detal`(
in id_detallealquiler_i int
)
BEGIN

-- con tabla controltrabajo ... partes
SELECT
cl.nombre as cliente,
o.nombre as obra,
v.id_vehiculo,
concat( substr(v.nombre,1,7),' ',substr(m.nombre,1,3),' [',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as vehiculo,
concat(t.apellidos,', ',t.nombres) as operario,
da.fecha as f_alquiler, 
c.fecha,
c.nro_parte,
c.hrs,
c.minuto,
c.total_h,
-- c.petroleo,
ifnull(cm.cant_combustible,0) as petroleo,
ifnull(cm.horometro,0) as horom_abast,
c.horometro_inicio,
c.horometro_fin,
ifnull(man.lugar_mant,'') as lugar_mant

FROM controltrabajo c
INNER JOIN detallealquiler da ON da.id_detallealquiler = c.id_detallealquiler
LEFT JOIN trabajador t ON t.id_trabajador = c.id_operario
INNER JOIN contrato con ON da.id_contrato = con.id_contrato
INNER JOIN cliente cl ON cl.id_cliente = con.id_cliente
INNER JOIN obra o ON con.id_obra = o.id_obra
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

-- enlaces a partevale INNER JOIN
LEFT JOIN partevale pv ON pv.id_controltrabajo = c.id_controltrabajo
-- enlaces a partevale -> consumo LEFT JOIN
LEFT JOIN consumo cm ON cm.id_consumo = pv.id_consumo

-- mantenimientos --> partemant
LEFT JOIN partemant pm ON pm.id_controltrabajo = c.id_controltrabajo
-- mantenimientos --> mantenimiento
LEFT JOIN mantenimiento man ON man.id_mantenimiento = pm.id_mantenimiento

WHERE c.id_detallealquiler = id_detallealquiler_i
GROUP BY c.nro_parte;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_rendimiento`
--

DROP PROCEDURE IF EXISTS `sp_REP_rendimiento`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_rendimiento`(
in f_desde date,
in f_hasta date,
in id_vehiculo_i int
)
BEGIN

 -- REndimeinto de las maquinarias
SELECT
-- c.`id_controltrabajo`,
concat(t.apellidos,', ',t.nombres) as operario,
-- v.id_vehiculo,
concat( substr(v.`nombre`,1,4),'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as vehiculo,
c.`fecha` as f_parte,
-- cn.fecha as f_abast,
c.`nro_parte`,
c.`hrs`,
c.`minuto`,
c.`total_h`,
-- c.turno,
-- c.`petroleo`,
cn.cant_combustible as petroleo,
cn.horometro as horom_abast,
c.`horometro_inicio`,
c.`horometro_fin`,
concat(ma.lugar_averia,' / ',
ma.lugar_mant,' / ',
ma.descripcion) as mantenimiento

FROM controltrabajo c
INNER JOIN trabvehiculo tv ON tv.id_trabvehiculo = c.id_trabvehiculo
LEFT JOIN trabajador t ON tv.id_trabajador = t.id_trabajador
INNER JOIN detallealquiler da ON tv.id_detallealquiler = da.id_detallealquiler
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
LEFT JOIN mantenimiento ma ON v.id_vehiculo = ma.id_vehiculo
LEFT JOIN consumo cn ON tv.id_trabvehiculo = cn.id_trabvehiculo

 WHERE
-- ----------------------> DESCOMENTAR

-- (cn.horometro BETWEEN c.`horometro_inicio` AND c.`horometro_fin`)
-- AND
 c.fecha BETWEEN f_desde AND f_hasta
 AND
 v.id_vehiculo = id_vehiculo_i
  GROUP BY c.nro_parte
 ORDER BY c.fecha ASC, cn.horometro ASC;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_valorizacion_cliente`
--

DROP PROCEDURE IF EXISTS `sp_REP_valorizacion_cliente`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_cliente`(
in id_cliente_i int,
in desde date,
in hasta date
)
BEGIN

SELECT
da.id_detallealquiler,
v.id_vehiculo,
concat(
v.nombre,'[',
substr(m.nombre,1,3),' ',
ifnull(v.modelo,''),' ',
ifnull(v.serie,''),']') as vehiculo,
cl.nombre as cliente,
SUM(c.total_h) as total_horas,
da.precio_alq,
ROUND(SUM(c.total_h) * v.precio_alq,2) as total

FROM detallealquiler da
-- INNER JOIN trabvehiculo trab ON c.id_trabvehiculo = trab.id_trabvehiculo
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

INNER JOIN contrato ct ON da.id_contrato = ct.id_contrato
INNER JOIN cliente cl ON ct.id_cliente = cl.id_cliente

INNER JOIN controltrabajo c ON c.id_detallealquiler = da.id_detallealquiler
-- INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = v.id_tipovehiculo


#INNER JOIN trabajador t ON trab.id_trabajador = t.id_trabajador

#condicion WHERE fechas and CLIENTE
WHERE cl.id_cliente = id_cliente_i AND
-- cambiado de FECHA detallealquiler --->a---> FECHA controltrabajo
(c.fecha BETWEEN desde AND hasta)

GROUP BY da.id_vehiculo;
-- GROUP BY da.id_detallealquiler;
#GROUP BY c.nro_parte;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_valorizacion_cliente_flete`
--

DROP PROCEDURE IF EXISTS `sp_REP_valorizacion_cliente_flete`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_cliente_flete`(
in id_cliente_i int,
in desde date,
in hasta date
)
BEGIN

SELECT
t.`id_transporte`,
t.`id_detallealquiler`,
concat(
t.`concepto`,' ',
v.nombre,' [ ',
substr(m.nombre,1,3),' ',
v.modelo,' ',
v.serie,' ]') as concepto,
t.`observacion`,
t.`fecha`,
t.`monto`
FROM transporte t
INNER JOIN detallealquiler da ON t.id_detallealquiler = da.id_detallealquiler
INNER JOIN contrato c on da.id_contrato = c.id_contrato
INNER JOIN vehiculo v on v.id_vehiculo = da.id_vehiculo
INNER JOIN marca m ON m.id_marca = v.id_marca
WHERE (t.fecha BETWEEN desde AND hasta) AND c.id_cliente = id_cliente_i;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_valorizacion_cliente_obra_xls`
--

DROP PROCEDURE IF EXISTS `sp_REP_valorizacion_cliente_obra_xls`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_cliente_obra_xls`(
in id_cliente_i int,
in desde date,
in hasta date
)
BEGIN

SELECT
da.id_detallealquiler,
v.id_vehiculo,
concat(
v.nombre,'[',
substr(m.nombre,1,3),' ',
ifnull(v.modelo,''),' ',
ifnull(v.serie,''),']') as vehiculo,
concat(t.apellidos,', ',t.nombres) as operario,
ob.id_obra,
ob.nombre as obra,
cl.codigo,
cl.nombre as cliente,
c.fecha,
c.nro_parte,
c.hrs as horas,
c.minuto as minutos,
c.total_h as total_horas,
c.horometro_inicio,
c.horometro_fin,
v.precio_alq
-- ROUND(SUM(c.total_h) * v.precio_alq,2) as total

FROM detallealquiler da

INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

INNER JOIN contrato ct ON da.id_contrato = ct.id_contrato
INNER JOIN cliente cl ON ct.id_cliente = cl.id_cliente
INNER JOIN obra ob ON ct.id_obra = ob.id_obra

INNER JOIN controltrabajo c ON c.id_detallealquiler = da.id_detallealquiler
-- INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = v.id_tipovehiculo
INNER JOIN trabajador t ON c.id_operario = t.id_trabajador

#condicion WHERE fechas and CLIENTE
WHERE cl.id_cliente = id_cliente_i AND
-- cambiado de FECHA detallealquiler --->a---> FECHA controltrabajo
(c.fecha BETWEEN desde AND hasta)

GROUP BY c.id_controltrabajo;
#GROUP BY c.nro_parte;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_valorizacion_group_obra`
--

DROP PROCEDURE IF EXISTS `sp_REP_valorizacion_group_obra`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_group_obra`(
in id_cliente_i int,
in desde date,
in hasta date,
in id_vehiculo_i int
)
BEGIN

SELECT
da.id_detallealquiler,
v.id_vehiculo,
concat(
v.nombre,'[',
substr(m.nombre,1,3),' ',
ifnull(v.modelo,''),' ',
ifnull(v.serie,''),']') as vehiculo,
concat(t.apellidos,', ',t.nombres) as operario,
ob.id_obra,
ob.nombre as obra,
cl.codigo,
cl.nombre as cliente,
c.fecha,
c.nro_parte,
c.hrs as horas,
c.minuto as minutos,
c.total_h as total_horas,
v.precio_alq
-- ROUND(SUM(c.total_h) * v.precio_alq,2) as total

FROM detallealquiler da

INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

INNER JOIN contrato ct ON da.id_contrato = ct.id_contrato
INNER JOIN cliente cl ON ct.id_cliente = cl.id_cliente
INNER JOIN obra ob ON ct.id_obra = ob.id_obra

INNER JOIN controltrabajo c ON c.id_detallealquiler = da.id_detallealquiler
-- INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = v.id_tipovehiculo
INNER JOIN trabajador t ON c.id_operario = t.id_trabajador

#condicion WHERE fechas and CLIENTE
WHERE cl.id_cliente = id_cliente_i AND da.id_vehiculo = id_vehiculo_i AND
-- cambiado de FECHA detallealquiler --->a---> FECHA controltrabajo
(c.fecha BETWEEN desde AND hasta)

GROUP BY ob.id_obra;
#GROUP BY c.nro_parte;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_valorizacion_group_vehiculo`
--

DROP PROCEDURE IF EXISTS `sp_REP_valorizacion_group_vehiculo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_group_vehiculo`(
in id_cliente_i int,
in desde date,
in hasta date
)
BEGIN

SELECT
da.id_detallealquiler,
v.id_vehiculo,
concat(
v.nombre,'[',
substr(m.nombre,1,3),' ',
ifnull(v.modelo,''),' ',
ifnull(v.serie,''),']') as vehiculo,
concat(
substr(v.nombre,1,6),'-',substr(v.nombre,-6),' ',
substr(m.nombre,1,3),' ',
ifnull(v.modelo,''),' ',
ifnull(v.serie,'')) as vehiculo_c,
concat(t.apellidos,', ',t.nombres) as operario,
ob.nombre as obra,
cl.codigo,
cl.nombre as cliente,
c.fecha,
c.nro_parte,
c.hrs as horas,
c.minuto as minutos,
c.total_h as total_horas,
v.precio_alq
-- ROUND(SUM(c.total_h) * v.precio_alq,2) as total

FROM detallealquiler da

INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

INNER JOIN contrato ct ON da.id_contrato = ct.id_contrato
INNER JOIN cliente cl ON ct.id_cliente = cl.id_cliente
INNER JOIN obra ob ON ct.id_obra = ob.id_obra

INNER JOIN controltrabajo c ON c.id_detallealquiler = da.id_detallealquiler
-- INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = v.id_tipovehiculo
INNER JOIN trabajador t ON c.id_operario = t.id_trabajador

#condicion WHERE fechas and CLIENTE
WHERE cl.id_cliente = id_cliente_i AND
-- cambiado de FECHA detallealquiler --->a---> FECHA controltrabajo
(c.fecha BETWEEN desde AND hasta)

GROUP BY da.id_vehiculo;
#GROUP BY c.nro_parte;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_valorizacion_group_vehiculo_obra`
--

DROP PROCEDURE IF EXISTS `sp_REP_valorizacion_group_vehiculo_obra`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_group_vehiculo_obra`(
in id_cliente_i int,
in desde date,
in hasta date,
in id_vehiculo_i int,
in id_obra_i int
)
BEGIN

SELECT
da.id_detallealquiler,
v.id_vehiculo,
concat(
v.nombre,'[',
substr(m.nombre,1,3),' ',
ifnull(v.modelo,''),' ',
ifnull(v.serie,''),']') as vehiculo,
concat(t.apellidos,', ',t.nombres) as operario,
ob.nombre as obra,
cl.codigo,
cl.nombre as cliente,
c.fecha,
c.nro_parte,
c.hrs as horas,
c.minuto as minutos,
c.total_h as total_horas,
c.horometro_inicio,
c.horometro_fin,
v.precio_alq
-- ROUND(SUM(c.total_h) * v.precio_alq,2) as total

FROM detallealquiler da

INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

INNER JOIN contrato ct ON da.id_contrato = ct.id_contrato
INNER JOIN cliente cl ON ct.id_cliente = cl.id_cliente
INNER JOIN obra ob ON ct.id_obra = ob.id_obra

INNER JOIN controltrabajo c ON c.id_detallealquiler = da.id_detallealquiler
-- INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = v.id_tipovehiculo
INNER JOIN trabajador t ON c.id_operario = t.id_trabajador

#condicion WHERE fechas and CLIENTE
WHERE cl.id_cliente = id_cliente_i AND ob.id_obra = id_obra_i AND da.id_vehiculo = id_vehiculo_i AND
-- cambiado de FECHA detallealquiler --->a---> FECHA controltrabajo
(c.fecha BETWEEN desde AND hasta)

GROUP BY c.id_controltrabajo;
#GROUP BY c.nro_parte;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_valorizacion_group_vh_resumen`
--

DROP PROCEDURE IF EXISTS `sp_REP_valorizacion_group_vh_resumen`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_group_vh_resumen`(
in id_cliente_i int,
in desde date,
in hasta date,
in id_vehiculo_i int
)
BEGIN

SELECT
da.id_detallealquiler,
v.id_vehiculo,
concat(
v.nombre,'[',
substr(m.nombre,1,3),' ',
ifnull(v.modelo,''),' ',
ifnull(v.serie,''),']') as vehiculo,
concat(t.apellidos,', ',t.nombres) as operario,
ob.nombre as obra,
cl.codigo,
cl.nombre as cliente,
c.fecha,
c.nro_parte,
c.hrs as horas,
c.minuto as minutos,
c.total_h as total_horas,
c.horometro_inicio,
c.horometro_fin,
v.precio_alq,
da.observacion as labor
-- ROUND(SUM(c.total_h) * v.precio_alq,2) as total

FROM detallealquiler da

INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

INNER JOIN contrato ct ON da.id_contrato = ct.id_contrato
INNER JOIN cliente cl ON ct.id_cliente = cl.id_cliente
INNER JOIN obra ob ON ct.id_obra = ob.id_obra

INNER JOIN controltrabajo c ON c.id_detallealquiler = da.id_detallealquiler
-- INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = v.id_tipovehiculo
INNER JOIN trabajador t ON c.id_operario = t.id_trabajador

#condicion WHERE fechas and CLIENTE
WHERE cl.id_cliente = id_cliente_i AND da.id_vehiculo = id_vehiculo_i AND
-- cambiado de FECHA detallealquiler --->a---> FECHA controltrabajo
(c.fecha BETWEEN desde AND hasta)

GROUP BY c.id_controltrabajo;
#GROUP BY c.nro_parte;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_sesion`
--

DROP PROCEDURE IF EXISTS `sp_sesion`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_sesion`(
in usuario_i varchar(30),
in clave_i varchar(40),
in ip_cli varchar(16),
in nav_cli varchar(50),
in so_cli varchar(50)
)
BEGIN

DECLARE n INT;

set n = 0;

SELECT u.id_usuario, u.nombre, ifnull(tu.nombre,'SA') as tipo,f_ultimo_acceso,
ifnull(t.apellidos,'SA') as apellidos, ifnull(t.nombres,'SA') as nombres, t.fecha_nac, t.dni
FROM usuario u
LEFT JOIN trabajador t ON u.id_trabajador = t.id_trabajador
LEFT JOIN tipousuario tu ON u.id_tipousuario = tu.id_tipousuario
WHERE (u.estado = 'A' OR u.estado = 'S') AND ifnull(t.estado,'A') = 'A'
AND (u.nombre = usuario_i OR ifnull(t.dni,'') = usuario_i)
AND u.clave = clave_i AND ifnull(tu.nombre, 'SA') <> 'OPERARIO';
##### los operarios no tienen acceso al sistema

SELECT u.id_usuario into n
FROM usuario u
LEFT JOIN trabajador t ON u.id_trabajador = t.id_trabajador
LEFT JOIN tipousuario tu ON u.id_tipousuario = tu.id_tipousuario
WHERE (u.estado = 'A' OR u.estado = 'S') AND ifnull(t.estado,'A') = 'A'
AND (u.nombre = usuario_i OR ifnull(t.dni,'') = usuario_i)
AND u.clave = clave_i AND ifnull(tu.nombre, 'SA') <> 'OPERARIO';

UPDATE usuario SET f_ultimo_acceso = now() WHERE id_usuario = n;

set @band = '';
if (n = 0) then
  set @band = 'FALLIDO';
else
  set @band = 'CORRECTO';
end if;

CALL sp_regs(n,concat('INICIO SESION: ', @band),concat('usuario: ',usuario_i),ip_cli, nav_cli,so_cli);

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_vehiculo_asignacion_op`
--

DROP PROCEDURE IF EXISTS `sp_vehiculo_asignacion_op`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_vehiculo_asignacion_op`(
in id_detal_i int
)
BEGIN

SELECT v.id_vehiculo,
v.nombre as vehiculo,
v.color, v.modelo,v.serie,v.motor,
v.placa,
m.nombre as marca, tv.nombre as tipovehiculo
FROM vehiculo v
INNER JOIN marca m ON v.id_marca = m.id_marca
INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
INNER JOIN detallealquiler da ON da.id_vehiculo = v.id_vehiculo

WHERE da.id_detallealquiler = id_detal_i;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_vehiculo_trabajador_asig`
--

DROP PROCEDURE IF EXISTS `sp_vehiculo_trabajador_asig`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_vehiculo_trabajador_asig`(
in id_usuario_i int
)
BEGIN

declare id_trab int;

SELECT id_trabajador into id_trab FROM usuario WHERE id_usuario = id_usuario_i;

SELECT v.id_vehiculo as id,tv.id_trabvehiculo, CONCAT(ifnull(v.nombre,''),' ',ifnull(v.modelo,''),' ',
ifnull(v.color,''),' ',ifnull(v.placa,''),' ',ifnull(v.serie,'')) as nombre
  FROM vehiculo v
  INNER JOIN detallealquiler da ON v.id_vehiculo = da.id_vehiculo
  INNER JOIN trabvehiculo tv ON da.id_detallealquiler = tv.id_detallealquiler
  WHERE tv.id_trabajador = id_trab;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
