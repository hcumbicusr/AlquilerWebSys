-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.6.24


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `abastecimiento`
--

/*!40000 ALTER TABLE `abastecimiento` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `articulo`
--

/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cliente`
--

/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` (`id_cliente`,`id_tipocliente`,`codigo`,`nombre`,`direccion`,`telefono`,`estado`,`f_registro`) VALUES 
 (1,4,'20530184596','ECOSAC AGRICOLA','CARRETERA CHAPAIRA S/N CASERIO RIO SECO PIURA','998261703','A','2015-04-27 10:47:40');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `consumo`
--

/*!40000 ALTER TABLE `consumo` DISABLE KEYS */;
INSERT INTO `consumo` (`id_consumo`,`id_detallealquiler`,`id_operario`,`id_responsable`,`id_detalleabastecimiento`,`fecha`,`nro_guia`,`nro_vale`,`nro_surtidor`,`cant_combustible`,`horometro`,`kilometraje`) VALUES 
 (1,1,31,1,146,'2015-04-21','001-015600','567','22','20.00','45502.00','0.00');
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
  `hora_min` int(11) DEFAULT '0',
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_contrato`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `contrato`
--

/*!40000 ALTER TABLE `contrato` DISABLE KEYS */;
INSERT INTO `contrato` (`id_contrato`,`id_obra`,`id_cliente`,`f_inicio`,`f_fin`,`presupuesto`,`detalle`,`hora_min`,`estado`) VALUES 
 (1,1,1,'2015-03-30 00:00:00','0000-00-00 00:00:00','0.00','',5,'A'),
 (6,6,1,'2015-04-01 00:00:00','2015-05-04 00:00:00','0.00','MI NUEVO CONTRATO PARA CLIENTE',0,'B'),
 (7,6,1,'2015-04-03 00:00:00','0000-00-00 00:00:00','0.00','',0,'A'),
 (8,6,1,'2015-04-03 00:00:00','0000-00-00 00:00:00','0.00','',0,'A'),
 (9,8,1,'2015-04-04 00:00:00','2015-05-04 00:00:00','0.00','',0,'B'),
 (10,8,1,'2015-04-09 00:00:00','0000-00-00 00:00:00','0.00','',0,'A'),
 (11,8,1,'2015-04-13 00:00:00','0000-00-00 00:00:00','0.00','',7,'A'),
 (12,8,1,'2015-05-04 00:00:00','0000-00-00 00:00:00','0.00','',8,'A');
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
  `valoriza` char(2) COLLATE utf8_unicode_ci DEFAULT 'HR',
  `hora_min` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id_controltrabajo`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `controltrabajo`
--

/*!40000 ALTER TABLE `controltrabajo` DISABLE KEYS */;
INSERT INTO `controltrabajo` (`id_controltrabajo`,`id_detallealquiler`,`id_operario`,`id_responsable`,`nro_interno`,`nro_parte`,`fecha`,`lugar_trabajo`,`tarea`,`agua`,`petroleo`,`gasolina`,`ac_motor`,`ac_transmision`,`ac_hidraulico`,`grasa`,`observacion`,`turno`,`descuento`,`horometro_inicio`,`horometro_fin`,`total_h`,`hrs`,`minuto`,`valoriza`,`hora_min`) VALUES 
 (1,2,39,2,0,'15469','2015-03-30','ECOSAC AGRICOLA','CONFORMACION DE MURO TRAMO # 02','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','3580.50','3590.50','10.00',10,0,'HR','0.00'),
 (2,2,39,2,0,'15470','2015-03-30','ECOSAC AGRICOLA','CONFORMACION DE MURO CANAL','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','3590.50','3600.50','10.00',10,0,'HR','0.00'),
 (3,2,39,2,0,'15471','2015-03-31','ECOSAC AGRICOLA','CONFORMACION DE MURO CANAL TRAMO # 02','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','3600.50','3610.50','10.00',10,0,'HR','0.00'),
 (4,2,39,2,0,'15472','2015-03-31','ECOSAC AGRICOLA','EXCAVACION DE RESERVORIO # 06','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','3610.50','3620.50','10.00',10,0,'HR','0.00'),
 (5,2,39,2,0,'15473','2015-04-01','ECOSAC AGRICOLA','ABRIENDO CANAL PARA RESERVORIO Y LEVANTANDO BANQUETA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','3620.50','3629.00','8.50',8,30,'HR','0.00'),
 (6,2,39,2,0,'15474','2015-04-01','ECOSAC AGRICOLA','LEVANTAMIENTO DE BANQUETA REBOMBEO # 06','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','3629.00','3639.00','10.00',10,0,'HR','0.00'),
 (7,2,39,2,0,'15475','2015-04-02','ECOSAC AGRICOLA','SACANDO BANQUETA DE RESERVORIO # 06 Y CONFORMACION DE MURO','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','3639.00','3644.50','5.50',5,30,'HR','0.00'),
 (8,3,26,2,0,'15517','2015-03-30','ECOSAC AGRICOLA','EXCAVACION DE POZA CANAL TRAMO # 01','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','7460.40','7470.40','10.00',10,0,'HR','0.00'),
 (9,3,26,2,0,'15518','2015-03-30','ECOSAC AGRICOLA','EXCAVACION DE ZANJA CANAL TRAMO # 02','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','7470.40','7480.40','10.00',10,0,'HR','0.00'),
 (10,3,26,2,0,'15519','2015-03-31','ECOSAC AGRICOLA','EXCAVACION DE ZANJA CANAL TRAMO # 02','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','7480.40','7490.40','10.00',10,0,'HR','0.00'),
 (11,3,26,2,0,'15520','2015-03-31','ECOSAC AGRICOLA','EXCAVACION DE POZA CANAL TRAMO # 01','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','7490.40','7499.40','9.00',9,0,'HR','0.00'),
 (12,3,26,2,0,'15521','2015-04-01','ECOSAC AGRICOLA','EXCAVACION DE POZA CANAL TRAMO # 01','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','7499.40','7509.40','10.00',10,0,'HR','0.00'),
 (13,3,26,2,0,'15522','2015-04-01','ECOSAC AGRICOLA','EXCAVACION DE POZA CANAL TRAMO # 01','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','7509.40','7519.40','10.00',10,0,'HR','0.00'),
 (14,3,26,2,0,'15523','2015-04-02','ECOSAC AGRICOLA','EXCAVACION DE POZA CANAL TRAMO # 01','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','7519.40','7525.40','6.00',6,0,'HR','0.00'),
 (15,3,26,2,0,'15524','2015-04-02','ECOSAC AGRICOLA','EXCAVACION DE POZA CANAL TRAMO # 01','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','7525.40','7531.40','6.00',6,0,'HR','0.00'),
 (16,1,28,2,0,'15564','2015-03-30','ECOSAC AGRICOLA','ACUMULADO DE MATERIAL PARA CONFORMACION DE MURO','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','6002.50','6012.50','10.00',10,0,'HR','0.00'),
 (17,1,28,2,0,'15565','2015-03-31','ECOSAC AGRICOLA','ESPARCIENDO MATERIAL EN MURO CANAL','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','6012.50','6022.50','10.00',10,0,'HR','0.00'),
 (18,1,28,2,0,'15566','2015-04-01','ECOSAC AGRICOLA','NIVELACION GRUESA Y AMPLIACION DE UVA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','6022.50','6029.50','7.00',7,0,'HR','0.00'),
 (19,1,28,2,0,'15567','2015-04-02','ECOSAC AGRICOLA','AMPLIACION UVA, NIVELACION GRUESA Y CANAL TRAMO # 02','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','6029.50','6036.50','7.00',7,0,'HR','0.00'),
 (20,4,37,2,0,'15042','2015-03-30','ECOSAC AGRICOLA','CONFORMACION DE RESERVORIO CANAL TRAMO # 01','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','5461.50','5467.50','6.00',6,0,'HR','0.00'),
 (21,4,37,2,0,'15043','2015-03-30','ECOSAC AGRICOLA','LEVANTAMIENTO DE MATERIAL DE ESTACION # 06','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','5467.50','5477.50','10.00',10,0,'HR','0.00'),
 (22,4,37,2,0,'15044','2015-03-31','ECOSAC AGRICOLA','LEVANTAMIENTO DE MATERIAL DE ESTACION # 06','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','5477.50','5487.50','10.00',10,0,'HR','0.00'),
 (23,4,37,2,0,'15045','2015-03-31','ECOSAC AGRICOLA','CONFORMACION DE RESERVORIO DEL CANAL TRAMO 01','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','5487.50','5497.50','10.00',10,0,'HR','0.00'),
 (24,4,37,2,0,'15046','2015-04-01','ECOSAC AGRICOLA','LEVANTAMIENTO DE MATERIAL EN RESERVORIO # 05','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','5497.50','5507.50','10.00',10,0,'HR','0.00'),
 (25,4,37,2,0,'15047','2015-04-01','ECOSAC AGRICOLA','MOVIMIENTO DE MATERIAL PARA CONFORMACION DE RESERVORIO # 05','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','5507.50','5517.50','10.00',10,0,'HR','0.00'),
 (26,4,37,2,0,'15048','2015-04-02','ECOSAC AGRICOLA','MOVIMIENTO DE MATERIAL PARA CONFORMACION DE RESERVORIO # 05','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','5517.50','5523.50','6.00',6,0,'HR','0.00'),
 (27,4,37,2,0,'15049','2015-04-02','ECOSAC AGRICOLA','MOVIMIENTO DE MATERIAL PARA CONFORMACION DE RESERVORIO # 05','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','T','0.00','5523.50','5529.50','6.00',6,0,'HR','0.00'),
 (28,1,33,1,23,'43566','2015-04-21','PIURA','NADA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','NADA','M','0.00','34500.00','45505.00','11005.00',11005,0,'HR','0.00'),
 (29,5,31,1,2,'2345','2015-05-01','XXXXXXX','NO HIZO NADA','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','24560.00','24563.00','3.00',3,0,'HM','5.00'),
 (30,5,31,1,2,'2346','2015-05-01','JSJDHAS','OTRA VEZ','0.00','0.00','0.00','0.00','0.00','0.00','0.00','','M','0.00','24563.00','24570.00','7.00',7,0,'HR','0.00');
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
  `fecha` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `nro_guia` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `stock` decimal(10,2) NOT NULL,
  `abastecedor` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vale_combustible` varchar(10) COLLATE utf8_unicode_ci DEFAULT '0',
  `ingreso` char(2) COLLATE utf8_unicode_ci DEFAULT 'MQ',
  PRIMARY KEY (`id_detalleabastecimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detalleabastecimiento`
--

/*!40000 ALTER TABLE `detalleabastecimiento` DISABLE KEYS */;
INSERT INTO `detalleabastecimiento` (`id_detalleabastecimiento`,`id_abastecimiento`,`id_tipocombustible`,`id_vehiculo`,`id_trabajador`,`fecha`,`nro_guia`,`cantidad`,`stock`,`abastecedor`,`vale_combustible`,`ingreso`) VALUES 
 (1,0,1,15,12,'2015-03-21 02:00:00','001-015422','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (2,0,1,15,12,'2015-03-21 02:00:00','001-015421','210.00','210.00','GRIFO SAN PEDRO','0','MQ'),
 (3,0,1,15,12,'2015-03-23 02:00:00','001-015428','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (4,0,1,15,12,'2015-03-23 02:00:00','001-015425','160.00','160.00','GRIFO SAN PEDRO','0','MQ'),
 (5,0,1,15,12,'2015-03-25 02:00:00','001-015436','220.00','220.00','GRIFO SAN PEDRO','0','MQ'),
 (6,0,1,15,12,'2015-03-24 02:00:00','001-015430','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (7,0,1,15,12,'2015-03-25 02:00:00','001-015437','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (8,0,1,16,12,'2015-03-26 02:00:00','001-015439','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (9,0,1,15,12,'2015-03-25 02:00:00','001-015438','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (10,0,1,16,12,'2015-03-26 02:00:00','001-015442','220.00','220.00','GRIFO SAN PEDRO','0','MQ'),
 (11,0,1,16,12,'2015-03-26 02:00:00','001-015441','170.00','170.00','GRIFO SAN PEDRO','0','MQ'),
 (12,0,1,15,12,'2015-03-27 02:00:00','001-015450|','160.00','160.00','GRIFO SAN PEDRO','0','MQ'),
 (13,0,1,15,12,'2015-03-27 02:00:00','001-015453','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (14,0,1,15,12,'2015-03-27 02:00:00','001-015452','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (15,0,1,15,12,'2015-03-28 02:00:00','001-015457','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (16,0,1,15,12,'2015-03-28 02:00:00','001-015456','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (17,0,1,15,12,'2015-03-30 02:00:00','001-015466','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (18,0,1,15,12,'2015-03-31 02:00:00','001-015474','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (19,0,1,15,12,'2015-03-25 02:00:00','001-015435','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (20,0,1,15,12,'2015-03-31 02:00:00','001-015472','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (21,0,1,15,12,'2015-04-14 02:00:00','001-015533','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (22,0,1,15,12,'2015-04-13 02:00:00','001-015527','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (23,0,1,15,12,'2015-04-11 02:00:00','001-015518','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (24,0,1,15,12,'2015-04-11 02:00:00','001-015519','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (25,0,1,15,12,'2015-04-10 02:00:00','001-015514','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (26,0,1,15,12,'2015-04-10 02:00:00','001-015513','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (27,0,1,15,12,'2015-04-09 02:00:00','001/015510','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (28,0,1,15,12,'2015-04-09 02:00:00','001-015509','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (29,0,1,15,12,'2015-04-08 02:00:00','001-015503','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (30,0,1,15,12,'2015-04-07 02:00:00','001-015501','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (31,0,1,15,12,'2015-04-08 02:00:00','001-015505','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (32,0,1,15,12,'2015-03-30 02:00:00','001-015465','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (33,0,1,15,12,'2015-04-01 02:00:00','001-015480','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (34,0,1,15,12,'2015-04-01 02:00:00','001-015481','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (35,0,1,15,12,'2015-04-02 02:00:00','001-015484','120.00','120.00','GRIFO SAN PEDRO','0','MQ'),
 (36,0,1,15,12,'2015-04-02 02:00:00','001-015477','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (37,0,1,15,12,'2015-04-06 02:00:00','001-015496','220.00','220.00','GRIFO SAN PEDRO','0','MQ'),
 (38,0,1,15,12,'2015-04-06 02:00:00','001-015495','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (39,0,1,15,12,'2015-04-07 02:00:00','001-015498','120.00','120.00','GRIFO SAN PEDRO','0','MQ'),
 (40,0,1,15,12,'2015-04-07 02:00:00','001-015497','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (41,0,1,15,12,'2015-03-24 02:00:00','001-015433','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (42,0,1,15,12,'2015-03-23 02:00:00','001-015426','120.00','120.00','GRIFO SAN PEDRO','0','MQ'),
 (43,0,1,15,12,'2015-03-21 02:00:00','001-015420','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (44,0,1,15,12,'2015-03-20 02:00:00','001-015415','220.00','220.00','GRIFO SAN PEDRO','0','MQ'),
 (45,0,1,15,12,'2015-03-20 02:00:00','001-015412','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (46,0,1,15,12,'2015-03-20 02:00:00','001-015416','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (47,0,1,16,6,'2015-03-19 02:00:00','001-015406','280.00','280.00','GRIFO SAN PEDRO','0','MQ'),
 (48,0,1,15,12,'2015-03-19 02:00:00','5407','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (49,0,1,16,6,'2015-03-18 02:00:00','001-015401','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (50,0,1,16,6,'2015-03-18 02:00:00','001-015398','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (51,0,1,15,12,'2015-03-18 02:00:00','001-015403','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (52,0,1,15,12,'2015-03-18 02:00:00','001-015402','230.00','230.00','GRIFO SAN PEDRO','0','MQ'),
 (53,0,1,15,12,'2015-03-18 02:00:00','001-015397','180.00','180.00','GRIFO SAN PEDRO','0','MQ'),
 (54,0,1,15,12,'2015-03-17 02:00:00','001-015393','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (55,0,1,15,12,'2015-03-17 02:00:00','001-015391','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (56,0,1,15,12,'2015-03-07 02:00:00','001-015390','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (57,0,1,15,12,'2015-03-16 02:00:00','001-015382','270.00','270.00','GRIFO SAN PEDRO','0','MQ'),
 (58,0,1,15,12,'2015-03-16 02:00:00','01-015383','140.00','140.00','GRIFO SAN PEDRO','0','MQ'),
 (59,0,1,15,12,'2015-03-16 02:00:00','001-015381','210.00','210.00','GRIFO SAN PEDRO','0','MQ'),
 (60,0,1,15,12,'2015-03-14 02:00:00','001-015370','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (61,0,1,15,12,'2015-03-14 02:00:00','001-015369','190.00','190.00','GRIFO SAN PEDRO','0','MQ'),
 (62,0,1,15,12,'2015-03-13 02:00:00','001-015362','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (63,0,1,15,12,'2015-03-13 02:00:00','001-015365','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (64,0,1,15,12,'2015-03-13 02:00:00','001-015364','210.00','210.00','GRIFO SAN PEDRO','0','MQ'),
 (65,0,1,15,12,'2015-03-12 02:00:00','001-015355','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (66,0,1,15,12,'2015-03-12 02:00:00','001-015359','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (67,0,1,15,12,'2015-03-12 02:00:00','001-015357','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (68,0,1,15,12,'2015-03-11 02:00:00','001-015350','210.00','210.00','GRIFO SAN PEDRO','0','MQ'),
 (69,0,1,15,12,'2015-03-11 02:00:00','001-015349','220.00','220.00','GRIFO SAN PEDRO','0','MQ'),
 (70,0,1,15,12,'2015-03-11 02:00:00','001-015347','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (71,0,1,15,12,'2015-03-10 02:00:00','001-015345','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (72,0,1,15,12,'2015-03-10 02:00:00','001-015344','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (73,0,1,16,12,'2015-03-09 02:00:00','001-015336','230.00','230.00','GRIFO SAN PEDRO','0','MQ'),
 (74,0,1,16,12,'2015-03-09 02:00:00','001-015337','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (75,0,1,16,12,'2015-03-07 02:00:00','001-015323','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (76,0,1,16,12,'2015-03-07 02:00:00','001-015324','190.00','190.00','GRIFO SAN PEDRO','0','MQ'),
 (77,0,1,16,12,'2015-03-07 02:00:00','001-015322','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (78,0,1,16,12,'2015-03-06 02:00:00','001-015310','230.00','230.00','GRIFO SAN PEDRO','0','MQ'),
 (79,0,1,16,12,'2015-03-06 02:00:00','001-015315','190.00','190.00','GRIFO SAN PEDRO','0','MQ'),
 (80,0,1,16,12,'2015-03-06 02:00:00','001-015309','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (81,0,1,16,12,'2015-03-06 02:00:00','001-015308','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (82,0,1,16,12,'2015-03-05 02:00:00','001-015306','240.00','240.00','GRIFO SAN PEDRO','0','MQ'),
 (83,0,1,16,12,'2015-03-05 02:00:00','001-015305','50.00','50.00','GRIFO SAN PEDRO','0','MQ'),
 (84,0,1,16,12,'2015-03-05 02:00:00','001-015303','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (85,0,1,16,12,'2015-03-04 02:00:00','001-015299','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (86,0,1,16,12,'2015-03-04 02:00:00','001-015298','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (87,0,1,16,12,'2015-03-03 02:00:00','001-015288','210.00','210.00','GRIFO SAN PEDRO','0','MQ'),
 (88,0,1,16,12,'2015-03-03 02:00:00','001-015292','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (89,0,1,16,12,'2015-03-02 02:00:00','001-015282','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (90,0,1,16,12,'2015-03-02 02:00:00','001-015283','230.00','230.00','GRIFO SAN PEDRO','0','MQ'),
 (91,0,1,16,12,'2015-02-28 02:00:00','001-015276','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (92,0,1,16,12,'2015-02-28 02:00:00','001-015279','140.00','140.00','GRIFO SAN PEDRO','0','MQ'),
 (93,0,1,16,12,'2015-02-27 02:00:00','001-015268','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (94,0,1,16,12,'2015-02-27 02:00:00','001-015269','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (95,0,1,16,12,'2015-02-27 02:00:00','001-015270','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (96,0,1,16,12,'2015-02-27 02:00:00','001-015272','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (97,0,1,16,12,'2015-02-26 02:00:00','001-015263','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (98,0,1,16,12,'2015-02-26 02:00:00','001-015260','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (99,0,1,15,12,'2015-02-25 02:00:00','001-015256','160.00','160.00','GRIFO SAN PEDRO','0','MQ'),
 (100,0,1,16,12,'2015-02-25 02:00:00','001-015254','240.00','240.00','GRIFO SAN PEDRO','0','MQ'),
 (101,0,1,15,12,'2015-02-24 02:00:00','001-015246','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (102,0,1,15,12,'2015-02-24 02:00:00','001-015247','170.00','170.00','GRIFO SAN PEDRO','0','MQ'),
 (103,0,1,15,12,'2015-02-23 02:00:00','001-015244','180.00','180.00','GRIFO SAN PEDRO','0','MQ'),
 (104,0,1,15,12,'2015-02-23 02:00:00','001-015243','240.00','240.00','GRIFO SAN PEDRO','0','MQ'),
 (105,0,1,15,12,'2015-02-21 02:00:00','001-015241','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (106,0,1,15,12,'2015-02-20 02:00:00','001-015233','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (107,0,1,15,12,'2015-02-20 02:00:00','001-015230','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (108,0,1,15,12,'2015-02-19 02:00:00','001-015223','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (109,0,1,15,12,'2015-02-19 02:00:00','001','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (110,0,1,15,28,'2015-02-18 02:00:00','001-015220','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (111,0,1,15,28,'2015-02-18 02:00:00','001-015218','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (112,0,1,15,28,'2015-02-18 02:00:00','001-015217','110.00','110.00','GRIFO SAN PEDRO','0','MQ'),
 (113,0,1,15,28,'2015-02-17 02:00:00','001-015211','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (114,0,1,15,28,'2015-02-16 02:00:00','001-015204','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (115,0,1,15,12,'2015-02-14 02:00:00','001-015195','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (116,0,1,15,12,'2015-02-13 02:00:00','001-015192','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (117,0,1,15,12,'2015-02-13 02:00:00','001-015193','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (118,0,1,15,12,'2015-02-12 02:00:00','001-015182','230.00','230.00','GRIFO SAN PEDRO','0','MQ'),
 (119,0,1,15,12,'2015-02-11 02:00:00','001-015180','200.00','200.00','GRIFO SAN PEDRO','0','MQ'),
 (120,0,1,15,12,'2015-02-11 02:00:00','001-015178','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (121,0,1,15,12,'2015-02-10 02:00:00','001-015173','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (122,0,1,15,12,'2015-02-10 02:00:00','001-015172','210.00','210.00','GRIFO SAN PEDRO','0','MQ'),
 (123,0,1,15,12,'2015-04-15 02:00:00','001-015536','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (124,0,1,15,12,'2015-04-16 02:00:00','001-015538','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (125,0,1,15,12,'2015-04-16 02:00:00','001-015539','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (126,0,1,15,12,'2015-04-17 02:00:00','001-015541','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (127,0,1,15,12,'2015-04-17 02:00:00','001-015542','230.00','230.00','GRIFO SAN PEDRO','0','MQ'),
 (128,0,1,15,12,'2015-04-18 02:00:00','001-015550','180.00','180.00','GRIFO SAN PEDRO','0','MQ'),
 (129,0,1,15,12,'2015-04-20 02:00:00','001-015562','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (130,0,1,15,35,'2015-04-18 02:00:00','001-015551','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (131,0,1,15,12,'2015-02-09 02:00:00','001-015168','170.00','170.00','GRIFO SAN PEDRO','0','MQ'),
 (132,0,1,15,12,'2015-02-09 02:00:00','001-015166','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (133,0,1,15,12,'2015-02-09 02:00:00','001-015164','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (134,0,1,15,12,'2015-02-07 02:00:00','001-015160','230.00','230.00','GRIFO SAN PEDRO','0','MQ'),
 (135,0,1,15,12,'2015-02-07 02:00:00','001-015162','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (136,0,1,15,12,'2015-02-06 02:00:00','001-015158','180.00','180.00','GRIFO SAN PEDRO','0','MQ'),
 (137,0,1,15,12,'2015-02-06 02:00:00','001-015154','240.00','240.00','GRIFO SAN PEDRO','0','MQ'),
 (138,0,1,15,12,'2015-02-05 02:00:00','001-015151','220.00','220.00','GRIFO SAN PEDRO','0','MQ'),
 (139,0,1,15,12,'2015-02-05 02:00:00','001-015150','130.00','130.00','GRIFO SAN PEDRO','0','MQ'),
 (140,0,1,15,12,'2015-02-04 02:00:00','001-015148','250.00','250.00','GRIFO SAN PEDRO','0','MQ'),
 (141,0,1,16,12,'2015-02-04 02:00:00','001-015144','260.00','260.00','GRIFO SAN PEDRO','0','MQ'),
 (142,0,1,15,35,'2015-04-21 00:00:00','001-015564','130.00','130.00','GRIFO SAN PEDRO','456','MQ'),
 (143,0,1,15,35,'2015-04-21 00:00:00','001-015565','270.00','270.00','GRIFO SAN PEDRO','123456','MQ'),
 (144,0,1,15,12,'2015-04-18 02:00:00','001-015546','150.00','150.00','GRIFO SAN PEDRO','0','MQ'),
 (145,0,1,15,35,'2015-04-21 00:00:00','001-015568','100.00','100.00','GRIFO SAN PEDRO','0','MQ'),
 (146,0,1,16,35,'2015-04-27 00:00:00','001-015600','230.00','210.00','GRIFO SAN PEDRO','026277','MQ'),
 (147,0,1,15,35,'2015-04-15 00:00:00','001-345678','45.00','45.00','GRIFO SAN PEDRO','0','MQ'),
 (148,0,1,30,35,'2015-04-01 00:00:00','000000','24.00','24.00','GRIFO SAN PEDRO','1234567','VH'),
 (151,0,1,31,35,'2015-04-02 00:00:00','000000','12.00','12.00','GRIFO SAN PEDRO','12345678','VH'),
 (152,0,1,33,42,'2015-04-10 00:00:00','000000','10.00','10.00','GRIFO SAN PEDRO','9876543','VH'),
 (153,0,1,30,12,'2015-05-01 00:00:00','000000','8.00','8.00','GRIFO SAN PEDRO','78435','VH');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detallealquiler`
--

/*!40000 ALTER TABLE `detallealquiler` DISABLE KEYS */;
INSERT INTO `detallealquiler` (`id_detallealquiler`,`id_contrato`,`id_vehiculo`,`id_articulo`,`precio_alq`,`fecha`,`estado`,`observacion`,`est_alq`) VALUES 
 (1,1,2,0,'550.00','2015-03-30 02:00:00','','','A'),
 (2,1,10,0,'240.00','2015-03-30 02:00:00','','','A'),
 (3,1,7,0,'440.00','2015-03-30 02:00:00','','','A'),
 (4,1,8,0,'300.00','2015-03-30 02:00:00','','','A'),
 (5,9,18,0,'259.00','2015-04-04 00:00:00','','','B');
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
  `observacion` varchar(400) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_devolucion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `devolucion`
--

/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
INSERT INTO `devolucion` (`id_devolucion`,`id_detallealquiler`,`fecha`,`estado`,`observacion`) VALUES 
 (4,5,'2015-05-04 00:00:00','','FINALIZACIÓN DE CONTRARO: ');
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mantenimiento`
--

/*!40000 ALTER TABLE `mantenimiento` DISABLE KEYS */;
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
 (1,1,1,'250.00','10.00','H','REQUIERE CAMBIO DE ACEITE','2015-02-20 17:45:17','A'),
 (2,2,5,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-20 17:45:17','A'),
 (3,2,6,'10000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-20 17:45:17','A'),
 (4,4,1,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-20 17:45:17','A'),
 (5,4,2,'5000.00','10.00','KM','REQUIERE NANTENIMIENTO','2015-02-20 17:45:17','A'),
 (6,4,3,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:12:00','A'),
 (7,4,4,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:14:57','A'),
 (8,4,5,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:14:57','A'),
 (9,4,6,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:14:57','A'),
 (10,4,7,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:14:57','A'),
 (11,4,8,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:14:57','A'),
 (12,4,9,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:14:57','A'),
 (13,1,1,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:16:52','A'),
 (14,3,2,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:16:52','A'),
 (15,3,3,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:16:52','A'),
 (16,3,4,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:16:52','A'),
 (17,3,5,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:16:52','A'),
 (18,3,6,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:16:52','A'),
 (19,3,7,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:16:52','A'),
 (20,3,8,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:16:52','A'),
 (21,3,9,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 06:16:52','A'),
 (22,1,2,'5000.00','10.00','H','REQUIERE MANTENIMIENTO','2015-03-03 06:03:55','A');
/*!40000 ALTER TABLE `notificamant` ENABLE KEYS */;


--
-- Definition of table `obra`
--

DROP TABLE IF EXISTS `obra`;
CREATE TABLE `obra` (
  `id_obra` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_obra`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `obra`
--

/*!40000 ALTER TABLE `obra` DISABLE KEYS */;
INSERT INTO `obra` (`id_obra`,`nombre`,`fecha`) VALUES 
 (1,'MOVIMIENTO DE TIERRAS. \r\nCONFORMACION DE MURO','2015-04-28 10:02:36'),
 (6,'OBRA PARA CLIENTE PRIVADO.','2015-04-29 14:57:00'),
 (8,'OBRA PARA SECTOR PRIVADO.','2015-04-29 19:01:10');
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partemant`
--

/*!40000 ALTER TABLE `partemant` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partevale`
--

/*!40000 ALTER TABLE `partevale` DISABLE KEYS */;
INSERT INTO `partevale` (`id_partevale`,`id_controltrabajo`,`id_consumo`,`fechar_reg`) VALUES 
 (1,28,1,'2015-05-04 11:45:56');
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
) ENGINE=InnoDB AUTO_INCREMENT=639 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `regs`
--

/*!40000 ALTER TABLE `regs` DISABLE KEYS */;
INSERT INTO `regs` (`id`,`id_usuario`,`fecha`,`accion`,`tablas_afectadas`,`ip_cliente`,`nav_cliente`,`so_cliente`) VALUES 
 (1,1,'2015-04-15 09:59:04','INICIO SESION: ADMIN  CORRECTO','USUARIO','190.113.208.57','Google Chrome','Linux'),
 (2,1,'2015-04-15 10:11:48','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (3,1,'2015-04-15 10:13:07','GENERACION DE USUARIO PARA TRAB: 2','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (4,2,'2015-04-15 10:14:49','INICIO SESION: ABARRAGAN63  CORRECTO','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (5,1,'2015-04-15 10:35:18','GENERACION DE USUARIO PARA TRAB: 3','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (6,1,'2015-04-15 10:36:54','GENERACION DE USUARIO PARA TRAB: 4','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (7,1,'2015-04-15 10:47:29','CIERRE SESION USER ID: 1','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (8,3,'2015-04-15 10:47:33','INICIO SESION: JVEGA09  CORRECTO','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (9,3,'2015-04-15 10:47:57','CIERRE SESION USER ID: 3','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (10,1,'2015-04-15 10:47:59','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (11,1,'2015-04-15 10:50:00','REGISTRO TIPO: ASISTENTE ADMINISTRATIVO','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (12,1,'2015-04-15 10:50:11','REGISTRO TIPO: ASISTENTE ADMINISTRATIVO','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (13,1,'2015-04-15 10:53:17','GENERACION DE USUARIO PARA TRAB: 5','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (14,3,'2015-04-15 10:57:09','INICIO SESION: JVEGA09  CORRECTO','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (15,2,'2015-04-15 10:58:45','CIERRE SESION USER ID: 2','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (16,1,'2015-04-15 10:58:55','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (17,1,'2015-04-15 10:59:02','REGISTRO TIPO: JEFE DE OPERADORES','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (18,1,'2015-04-15 11:00:02','REGISTRO TIPO: JEFE DE OPERADORES','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (19,1,'2015-04-15 11:03:29','GENERACION DE USUARIO PARA TRAB: 6','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (20,1,'2015-04-15 11:04:06','REGISTRO TIPO: ASISTENTE CONTABLE','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (21,1,'2015-04-15 11:04:22','REGISTRO TIPO: ASISTENTE CONTABLE','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (22,1,'2015-04-15 11:06:35','GENERACION DE USUARIO PARA TRAB: 7','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (23,1,'2015-04-15 11:07:41','GENERACION DE USUARIO PARA TRAB: 8','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (24,1,'2015-04-15 11:09:32','GENERACION DE USUARIO PARA TRAB: 9','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (25,1,'2015-04-15 11:11:19','GENERACION DE USUARIO PARA TRAB: 10','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (26,1,'2015-04-15 11:12:30','REGISTRO TIPO: SOLDADOR','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (27,1,'2015-04-15 11:12:48','REGISTRO TIPO: SOLDADOR','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (28,1,'2015-04-15 11:14:16','GENERACION DE USUARIO PARA TRAB: 11','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (29,1,'2015-04-15 11:16:01','GENERACION DE USUARIO PARA TRAB: 12','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (30,1,'2015-04-15 11:19:23','REGISTRO TIPO: APOYO LOGISTICO','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (31,1,'2015-04-15 11:19:41','REGISTRO TIPO: APOYO LOGISTICO','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (32,1,'2015-04-15 11:21:45','GENERACION DE USUARIO PARA TRAB: 13','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (33,1,'2015-04-15 11:24:45','EDITAR TRABAJADOR12','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (34,1,'2015-04-15 11:25:04','REG VEHICULOS','VEHICULO, VEHICULOPH','181.67.202.56','Google Chrome','Windows'),
 (35,1,'2015-04-15 11:26:22','GENERACION DE USUARIO PARA TRAB: 14','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (36,1,'2015-04-15 11:27:22','REGISTRO TIPO: ASISTENTE DE TALLER','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (37,1,'2015-04-15 11:27:32','REG VEHICULOS','VEHICULO, VEHICULOPH','181.67.202.56','Google Chrome','Windows'),
 (38,1,'2015-04-15 11:27:47','REGISTRO TIPO: ASISTENTE DE TALLER','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (39,1,'2015-04-15 11:29:44','GENERACION DE USUARIO PARA TRAB: 15','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (40,1,'2015-04-15 11:30:15','REG VEHICULOS','VEHICULO, VEHICULOPH','181.67.202.56','Google Chrome','Windows'),
 (41,1,'2015-04-15 11:31:06','GENERACION DE USUARIO PARA TRAB: 16','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (42,1,'2015-04-15 11:32:11','REGISTRO TIPO: SUPERVISOR DE CAMPO','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (43,1,'2015-04-15 11:32:36','REG VEHICULOS','VEHICULO, VEHICULOPH','181.67.202.56','Google Chrome','Windows'),
 (44,1,'2015-04-15 11:33:02','REGISTRO TIPO: SUPERVISOR DE CAMPO','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (45,1,'2015-04-15 11:33:58','REG VEHICULOS','VEHICULO, VEHICULOPH','181.67.202.56','Google Chrome','Windows'),
 (46,1,'2015-04-15 11:34:01','GENERACION DE USUARIO PARA TRAB: 17','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (47,1,'2015-04-15 11:35:15','REGISTRO TIPO: CONTADOR','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (48,1,'2015-04-15 11:35:27','REGISTRO TIPO: CONTADOR','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (49,1,'2015-04-15 11:36:09','REG VEHICULOS','VEHICULO, VEHICULOPH','181.67.202.56','Google Chrome','Windows'),
 (50,1,'2015-04-15 11:36:29','GENERACION DE USUARIO PARA TRAB: 18','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (51,1,'2015-04-15 11:36:54','REGISTRO TIPO: SUB GERENTE','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (52,1,'2015-04-15 11:37:12','REGISTRO TIPO: SUB GERENTE','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (53,1,'2015-04-15 11:39:20','REG VEHICULOS','VEHICULO, VEHICULOPH','181.67.202.56','Google Chrome','Windows'),
 (54,1,'2015-04-15 11:39:39','GENERACION DE USUARIO PARA TRAB: 19','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (55,1,'2015-04-15 11:40:35','REGISTRO TIPO: GERENTE GENERAL','TRABAJADOR','181.67.202.56','Google Chrome','Windows'),
 (56,1,'2015-04-15 11:40:51','REGISTRO TIPO: GERENTE GENERAL','USUARIO','181.67.202.56','Google Chrome','Windows'),
 (57,1,'2015-04-15 11:42:35','REG VEHICULOS','VEHICULO, VEHICULOPH','181.67.202.56','Google Chrome','Windows'),
 (58,1,'2015-04-15 11:44:00','GENERACION DE USUARIO PARA TRAB: 20','TRABAJADOR,USUARIO','181.67.202.56','Google Chrome','Windows'),
 (59,1,'2015-04-15 11:44:20','REG VEHICULOS','VEHICULO, VEHICULOPH','181.67.202.56','Google Chrome','Windows'),
 (60,1,'2015-04-15 11:52:19','REG VEHICULOS','VEHICULO, VEHICULOPH','190.237.62.230','Google Chrome','Windows'),
 (61,1,'2015-04-15 11:56:10','GENERACION DE USUARIO PARA TRAB: 21','TRABAJADOR,USUARIO','190.237.62.230','Google Chrome','Windows'),
 (62,1,'2015-04-15 11:56:41','CIERRE SESION USER ID: 1','USUARIO','190.237.62.230','Google Chrome','Windows'),
 (63,1,'2015-04-15 11:58:43','REG VEHICULOS','VEHICULO, VEHICULOPH','190.237.62.230','Google Chrome','Windows'),
 (64,1,'2015-04-15 12:00:36','REG VEHICULOS','VEHICULO, VEHICULOPH','190.237.62.230','Google Chrome','Windows'),
 (65,1,'2015-04-15 12:03:33','REG VEHICULOS','VEHICULO, VEHICULOPH','190.237.62.230','Google Chrome','Windows'),
 (66,1,'2015-04-15 12:04:56','REG VEHICULOS','VEHICULO, VEHICULOPH','190.237.62.230','Google Chrome','Windows'),
 (67,1,'2015-04-16 07:44:41','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (68,1,'2015-04-16 07:45:41','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (69,18,'2015-04-16 07:45:49','INICIO SESION: MLEON22  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (70,18,'2015-04-16 07:55:58','CIERRE SESION USER ID: 18','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (71,1,'2015-04-16 07:56:09','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (72,1,'2015-04-16 07:56:30','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (73,7,'2015-04-16 07:56:36','INICIO SESION: CBALLADARES50  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (74,7,'2015-04-16 07:59:18','CIERRE SESION USER ID: 7','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (75,0,'2015-04-16 07:59:29','INICIO SESION: CBALLADARES09  FALLIDO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (76,1,'2015-04-16 07:59:35','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (77,1,'2015-04-16 07:59:49','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (78,7,'2015-04-16 07:59:55','INICIO SESION: CBALLADARES50  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (79,1,'2015-04-16 08:00:07','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (80,1,'2015-04-16 08:00:19','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (81,4,'2015-04-16 08:00:23','INICIO SESION: ALEON91  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (82,4,'2015-04-16 08:02:29','CIERRE SESION USER ID: 4','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (83,1,'2015-04-16 08:02:33','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (84,1,'2015-04-16 08:02:46','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (85,2,'2015-04-16 08:02:51','INICIO SESION: ABARRAGAN63  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (86,2,'2015-04-16 08:03:02','CIERRE SESION USER ID: 2','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (87,1,'2015-04-16 08:03:05','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (88,1,'2015-04-16 08:03:15','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (89,5,'2015-04-16 08:03:20','INICIO SESION: JALVA15  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (90,1,'2015-04-16 09:05:11','INICIO SESION: ADMIN  CORRECTO','USUARIO','190.237.62.211','Google Chrome','Windows'),
 (91,1,'2015-04-16 09:11:26','INICIO SESION: ADMIN  CORRECTO','USUARIO','190.113.209.198','Google Chrome','Linux'),
 (92,1,'2015-04-16 09:11:30','GENERACION DE USUARIO PARA TRAB: 22','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (93,1,'2015-04-16 09:12:35','CIERRE SESION USER ID: 1','USUARIO','190.113.209.198','Google Chrome','Linux'),
 (94,1,'2015-04-16 09:13:37','GENERACION DE USUARIO PARA TRAB: 23','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (95,1,'2015-04-16 09:14:45','REGISTRO TIPO: ADMINISTRACION','TRABAJADOR','181.65.10.110','Google Chrome','Windows'),
 (96,1,'2015-04-16 09:16:07','REGISTRO TIPO: OFICINISTA','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (97,1,'2015-04-16 09:17:24','REGISTRO TIPO: ADMINISTRADORA','TRABAJADOR','181.65.10.110','Google Chrome','Windows'),
 (98,1,'2015-04-16 09:23:40','GENERACION DE USUARIO PARA TRAB: 24','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (99,1,'2015-04-16 09:25:08','GENERACION DE USUARIO PARA TRAB: 25','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (100,1,'2015-04-16 09:26:41','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (101,1,'2015-04-16 09:27:18','EDITAR VEHICULO: 2','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (102,1,'2015-04-16 09:27:32','GENERACION DE USUARIO PARA TRAB: 26','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (103,1,'2015-04-16 09:27:41','EDITAR VEHICULO: 6','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (104,1,'2015-04-16 09:27:59','EDITAR VEHICULO: 5','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (105,1,'2015-04-16 09:28:11','GENERACION DE USUARIO PARA TRAB: 27','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (106,1,'2015-04-16 09:28:13','EDITAR VEHICULO: 1','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (107,1,'2015-04-16 09:28:29','EDITAR VEHICULO: 11','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (108,1,'2015-04-16 09:28:49','GENERACION DE USUARIO PARA TRAB: 28','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (109,1,'2015-04-16 09:28:53','EDITAR VEHICULO: 4','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (110,1,'2015-04-16 09:29:05','EDITAR VEHICULO: 7','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (111,1,'2015-04-16 09:29:19','EDITAR VEHICULO: 10','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (112,1,'2015-04-16 09:29:30','EDITAR VEHICULO: 9','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (113,1,'2015-04-16 09:29:39','EDITAR VEHICULO: 8','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (114,1,'2015-04-16 09:29:48','EDITAR VEHICULO: 3','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (115,1,'2015-04-16 09:29:55','GENERACION DE USUARIO PARA TRAB: 29','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (116,1,'2015-04-16 09:30:17','EDITAR VEHICULO: 14','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (117,1,'2015-04-16 09:30:52','EDITAR VEHICULO: 7','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (118,1,'2015-04-16 09:31:23','GENERACION DE USUARIO PARA TRAB: 30','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (119,1,'2015-04-16 09:31:23','EDITAR VEHICULO: 6','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (120,1,'2015-04-16 09:31:48','EDITAR VEHICULO: 13','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (121,1,'2015-04-16 09:32:04','GENERACION DE USUARIO PARA TRAB: 31','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (122,1,'2015-04-16 09:32:27','REGISTRO TIPO: VIGILANTE','TRABAJADOR','181.65.10.110','Google Chrome','Windows'),
 (123,1,'2015-04-16 09:35:38','REGISTRO TIPO: PLANTA','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (124,1,'2015-04-16 09:36:49','GENERACION DE USUARIO PARA TRAB: 32','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (125,1,'2015-04-16 09:37:55','GENERACION DE USUARIO PARA TRAB: 33','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (126,1,'2015-04-16 09:38:39','GENERACION DE USUARIO PARA TRAB: 34','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (127,1,'2015-04-16 09:39:31','GENERACION DE USUARIO PARA TRAB: 35','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (128,1,'2015-04-16 09:40:43','REGISTRO TIPO: ASISTENTE LOGISTICO','TRABAJADOR','181.65.10.110','Google Chrome','Windows'),
 (129,1,'2015-04-16 09:41:36','GENERACION DE USUARIO PARA TRAB: 36','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (130,1,'2015-04-16 09:42:09','EDITAR TRABAJADOR36','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (131,1,'2015-04-16 09:43:02','GENERACION DE USUARIO PARA TRAB: 37','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (132,1,'2015-04-16 09:43:29','GENERACION DE USUARIO PARA TRAB: 38','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (133,1,'2015-04-16 09:44:05','GENERACION DE USUARIO PARA TRAB: 39','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (134,1,'2015-04-16 09:44:45','GENERACION DE USUARIO PARA TRAB: 40','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (135,1,'2015-04-16 09:45:49','GENERACION DE USUARIO PARA TRAB: 41','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (136,1,'2015-04-16 09:46:58','GENERACION DE USUARIO PARA TRAB: 42','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (137,1,'2015-04-16 09:47:36','GENERACION DE USUARIO PARA TRAB: 43','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (138,1,'2015-04-16 09:50:13','REGISTRO TIPO: APOYO ADMINISTRATIVO','TRABAJADOR','181.65.10.110','Google Chrome','Windows'),
 (139,1,'2015-04-16 09:51:03','GENERACION DE USUARIO PARA TRAB: 44','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (140,1,'2015-04-16 09:52:05','REGISTRO TIPO: APOYO DE CAMPO','TRABAJADOR','181.65.10.110','Google Chrome','Windows'),
 (141,1,'2015-04-16 09:53:23','GENERACION DE USUARIO PARA TRAB: 45','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (142,1,'2015-04-16 09:55:28','EDITAR TRABAJADOR3','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (143,1,'2015-04-16 09:56:41','EDITAR TRABAJADOR2','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (144,1,'2015-04-16 09:57:40','EDITAR TRABAJADOR2','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (145,1,'2015-04-16 09:58:45','EDITAR TRABAJADOR5','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (146,1,'2015-04-16 09:59:18','EDITAR TRABAJADOR10','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (147,1,'2015-04-16 10:00:06','EDITAR TRABAJADOR8','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (148,1,'2015-04-16 10:00:56','EDITAR TRABAJADOR6','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (149,1,'2015-04-16 10:01:40','EDITAR TRABAJADOR18','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (150,1,'2015-04-16 10:02:36','EDITAR TRABAJADOR15','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (151,1,'2015-04-16 10:03:15','EDITAR TRABAJADOR7','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (152,1,'2015-04-16 10:04:14','EDITAR TRABAJADOR2','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (153,1,'2015-04-16 10:05:14','EDITAR TRABAJADOR11','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (154,1,'2015-04-16 10:05:37','EDITAR TRABAJADOR19','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (155,1,'2015-04-16 10:06:27','EDITAR TRABAJADOR17','TRABAJADOR,USUARIO','181.65.10.110','Google Chrome','Windows'),
 (156,1,'2015-04-16 10:06:52','UPDATE TIPO: ASISTENTE ADMINISTRATIVO','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (157,1,'2015-04-16 10:07:10','UPDATE TIPO: ASISTENTE CONTABLE','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (158,1,'2015-04-16 10:07:22','UPDATE TIPO: SOLDADOR','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (159,1,'2015-04-16 10:07:34','UPDATE TIPO: APOYO LOGISTICO','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (160,1,'2015-04-16 10:07:50','UPDATE TIPO: ASISTENTE DE TALLER','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (161,1,'2015-04-16 10:08:11','UPDATE TIPO: CONTADOR','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (162,1,'2015-04-16 10:08:22','UPDATE TIPO: SUB GERENTE','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (163,1,'2015-04-16 10:08:35','UPDATE TIPO: GERENTE GENERAL','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (164,1,'2015-04-16 10:21:36','CIERRE SESION USER ID: 1','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (165,3,'2015-04-16 10:21:56','INICIO SESION: JVEGA09  CORRECTO','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (166,3,'2015-04-16 10:22:46','CIERRE SESION USER ID: 3','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (167,3,'2015-04-16 10:23:00','INICIO SESION: JVEGA09  CORRECTO','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (168,1,'2015-04-16 10:29:34','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (169,1,'2015-04-16 10:32:01','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (170,1,'2015-04-16 10:33:39','EDITAR VEHICULO: 15','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (171,3,'2015-04-16 10:35:00','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (172,3,'2015-04-16 10:36:26','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (173,3,'2015-04-16 10:38:32','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (174,3,'2015-04-16 10:40:30','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (175,3,'2015-04-16 10:42:17','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (176,3,'2015-04-16 10:43:14','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (177,3,'2015-04-16 10:44:05','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (178,1,'2015-04-16 10:46:40','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (179,3,'2015-04-16 10:47:41','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (180,3,'2015-04-16 10:50:29','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (181,1,'2015-04-16 10:53:55','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (182,3,'2015-04-16 10:54:24','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (183,3,'2015-04-16 10:56:36','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (184,1,'2015-04-16 10:57:22','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (185,1,'2015-04-16 10:59:04','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (186,1,'2015-04-16 11:00:38','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (187,1,'2015-04-16 11:04:42','REGISTRO TIPO: REMOLCADOR','VEHICULO','181.65.10.110','Google Chrome','Windows'),
 (188,1,'2015-04-16 11:07:08','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (189,1,'2015-04-16 11:11:58','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (190,1,'2015-04-16 11:13:42','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (191,1,'2015-04-16 11:17:35','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (192,1,'2015-04-16 11:24:08','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (193,1,'2015-04-16 11:26:43','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (194,1,'2015-04-16 11:28:46','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (195,1,'2015-04-16 11:37:28','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (196,1,'2015-04-16 11:38:15','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (197,1,'2015-04-16 11:39:17','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (198,1,'2015-04-16 11:45:11','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (199,1,'2015-04-16 11:47:23','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (200,1,'2015-04-16 11:49:18','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (201,1,'2015-04-16 11:52:06','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (202,1,'2015-04-16 11:57:53','REGISTRO TIPO: CISTERNA','VEHICULO','181.65.10.110','Google Chrome','Windows'),
 (203,1,'2015-04-16 11:59:43','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (204,1,'2015-04-16 12:01:14','REG VEHICULOS','VEHICULO, VEHICULOPH','181.65.10.110','Google Chrome','Windows'),
 (205,3,'2015-04-16 12:12:07','INICIO SESION: JVEGA09  CORRECTO','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (206,1,'2015-04-16 12:20:02','CIERRE SESION USER ID: 1','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (207,3,'2015-04-16 12:20:17','INICIO SESION: JVEGA09  CORRECTO','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (208,3,'2015-04-16 12:23:23','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (209,3,'2015-04-16 12:25:52','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (210,3,'2015-04-16 12:27:18','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (211,3,'2015-04-16 12:30:04','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (212,3,'2015-04-16 12:33:07','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.65.10.110','Google Chrome','Windows'),
 (213,3,'2015-04-16 12:35:14','CIERRE SESION USER ID: 3','USUARIO','181.65.10.110','Google Chrome','Windows'),
 (214,1,'2015-04-17 10:53:54','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (215,1,'2015-04-17 10:54:47','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (216,3,'2015-04-17 11:57:20','INICIO SESION: JVEGA09  CORRECTO','USUARIO','190.237.62.212','Google Chrome','Windows'),
 (217,3,'2015-04-17 16:27:42','INICIO SESION: JVEGA09  CORRECTO','USUARIO','190.237.62.212','Google Chrome','Windows'),
 (218,3,'2015-04-17 16:28:46','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (219,3,'2015-04-17 16:29:31','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (220,3,'2015-04-17 16:30:23','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (221,3,'2015-04-17 16:31:39','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (222,3,'2015-04-17 16:32:42','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (223,3,'2015-04-17 16:34:27','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (224,3,'2015-04-17 16:35:06','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (225,3,'2015-04-17 16:36:52','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (226,3,'2015-04-17 16:41:49','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (227,3,'2015-04-17 16:42:27','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (228,3,'2015-04-17 16:43:08','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (229,3,'2015-04-17 16:43:40','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (230,3,'2015-04-17 16:47:43','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (231,3,'2015-04-17 16:48:14','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (232,3,'2015-04-17 16:49:08','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.237.62.212','Google Chrome','Windows'),
 (233,3,'2015-04-17 16:59:46','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (234,3,'2015-04-17 17:02:23','CIERRE SESION USER ID: 3','USUARIO','201.240.232.19','Google Chrome','Windows'),
 (235,3,'2015-04-17 17:03:26','INICIO SESION: JVEGA09  CORRECTO','USUARIO','201.240.232.19','Google Chrome','Windows'),
 (236,3,'2015-04-17 17:04:11','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (237,3,'2015-04-17 17:05:03','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (238,3,'2015-04-17 17:05:36','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (239,3,'2015-04-17 17:06:38','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (240,3,'2015-04-17 17:07:19','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (241,3,'2015-04-17 17:08:13','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (242,3,'2015-04-17 17:08:56','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (243,3,'2015-04-17 17:09:23','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (244,3,'2015-04-17 17:21:57','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (245,3,'2015-04-17 17:22:30','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (246,3,'2015-04-17 17:23:02','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (247,3,'2015-04-17 17:23:31','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (248,3,'2015-04-17 17:24:04','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (249,3,'2015-04-17 17:24:58','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (250,1,'2015-04-17 17:26:55','INICIO SESION: ADMIN  CORRECTO','USUARIO','201.240.232.19','Navegador desconocido','Windows'),
 (251,1,'2015-04-17 17:27:27','EDITAR TRABAJADOR6','TRABAJADOR,USUARIO','201.240.232.19','Navegador desconocido','Windows'),
 (252,3,'2015-04-17 17:28:21','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (253,3,'2015-04-17 17:28:55','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (254,3,'2015-04-17 17:29:30','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (255,3,'2015-04-17 17:30:16','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (256,3,'2015-04-17 17:30:54','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (257,3,'2015-04-17 17:31:22','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (258,3,'2015-04-17 17:32:13','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (259,3,'2015-04-17 17:32:54','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (260,3,'2015-04-17 17:33:24','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (261,3,'2015-04-17 17:33:57','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (262,3,'2015-04-17 17:34:30','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (263,3,'2015-04-17 17:35:04','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (264,3,'2015-04-17 17:35:42','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (265,3,'2015-04-17 17:36:18','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (266,3,'2015-04-17 17:36:53','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (267,3,'2015-04-17 17:37:39','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (268,3,'2015-04-17 17:38:21','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (269,3,'2015-04-17 17:38:58','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (270,3,'2015-04-17 17:39:41','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (271,3,'2015-04-17 17:40:05','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (272,3,'2015-04-17 17:41:02','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (273,3,'2015-04-17 17:41:35','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (274,3,'2015-04-17 17:42:07','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (275,3,'2015-04-17 17:42:41','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (276,3,'2015-04-17 17:44:03','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (277,3,'2015-04-17 17:44:30','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (278,3,'2015-04-17 17:46:04','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (279,3,'2015-04-17 17:46:29','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (280,3,'2015-04-17 17:47:01','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (281,3,'2015-04-17 17:47:27','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (282,3,'2015-04-17 17:47:58','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (283,3,'2015-04-17 17:48:31','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (284,3,'2015-04-17 17:49:17','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (285,3,'2015-04-17 17:49:46','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (286,3,'2015-04-17 17:50:29','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (287,3,'2015-04-17 17:51:02','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (288,3,'2015-04-17 17:51:41','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (289,3,'2015-04-17 17:52:20','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (290,3,'2015-04-17 17:53:01','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (291,3,'2015-04-17 17:53:48','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (292,3,'2015-04-17 17:54:32','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (293,3,'2015-04-17 17:55:17','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (294,3,'2015-04-17 17:55:55','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (295,3,'2015-04-17 17:57:11','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','201.240.232.19','Google Chrome','Windows'),
 (296,0,'2015-04-18 09:49:26','INICIO SESION: ADMIN  FALLIDO','USUARIO','179.7.68.25','Google Chrome','Windows'),
 (297,1,'2015-04-18 09:49:28','INICIO SESION: ADMIN  CORRECTO','USUARIO','179.7.68.25','Google Chrome','Windows'),
 (298,1,'2015-04-18 09:52:11','CIERRE SESION USER ID: 1','USUARIO','179.7.68.25','Google Chrome','Windows'),
 (299,3,'2015-04-20 09:13:07','INICIO SESION: JVEGA09  CORRECTO','USUARIO','190.238.129.142','Google Chrome','Windows'),
 (300,3,'2015-04-20 09:17:15','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (301,3,'2015-04-20 09:18:00','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (302,3,'2015-04-20 09:19:16','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (303,3,'2015-04-20 09:20:02','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (304,3,'2015-04-20 09:20:48','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (305,3,'2015-04-20 09:21:27','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (306,3,'2015-04-20 09:22:11','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (307,3,'2015-04-20 09:22:53','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (308,3,'2015-04-20 09:23:40','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (309,3,'2015-04-20 09:24:27','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (310,3,'2015-04-20 09:26:15','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (311,3,'2015-04-20 09:27:37','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.238.129.142','Google Chrome','Windows'),
 (312,3,'2015-04-20 09:47:11','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (313,3,'2015-04-20 09:47:40','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (314,3,'2015-04-20 09:48:42','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (315,3,'2015-04-20 09:49:19','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (316,3,'2015-04-20 09:50:24','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (317,3,'2015-04-20 09:51:14','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (318,3,'2015-04-20 09:54:04','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (319,3,'2015-04-20 09:54:42','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (320,3,'2015-04-20 09:56:12','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (321,3,'2015-04-20 09:56:50','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (322,3,'2015-04-20 09:58:29','CIERRE SESION USER ID: 3','USUARIO','181.67.155.131','Google Chrome','Windows'),
 (323,1,'2015-04-20 09:58:41','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.67.155.131','Google Chrome','Windows'),
 (324,1,'2015-04-20 10:00:34','CIERRE SESION USER ID: 1','USUARIO','181.67.155.131','Google Chrome','Windows'),
 (325,3,'2015-04-20 10:00:44','INICIO SESION: JVEGA09  CORRECTO','USUARIO','181.67.155.131','Google Chrome','Windows'),
 (326,3,'2015-04-20 10:03:40','MODIFICA GUIA','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (327,1,'2015-04-20 10:14:08','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (328,3,'2015-04-20 10:25:18','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (329,3,'2015-04-20 10:25:59','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (330,3,'2015-04-20 10:27:12','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (331,3,'2015-04-20 10:28:14','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (332,3,'2015-04-20 10:30:48','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (333,3,'2015-04-20 10:31:22','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (334,3,'2015-04-20 10:31:53','MODIFICA GUIA','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (335,3,'2015-04-20 10:33:25','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (336,3,'2015-04-20 10:34:07','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (337,3,'2015-04-20 10:35:43','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (338,3,'2015-04-20 10:36:44','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.67.155.131','Google Chrome','Windows'),
 (339,1,'2015-04-20 10:57:47','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (340,3,'2015-04-21 08:39:48','INICIO SESION: JVEGA09  CORRECTO','USUARIO','190.41.76.88','Google Chrome','Windows'),
 (341,3,'2015-04-21 08:43:51','CIERRE SESION USER ID: 3','USUARIO','190.41.76.88','Google Chrome','Windows'),
 (342,4,'2015-04-21 08:44:01','INICIO SESION: ALEON91  CORRECTO','USUARIO','190.41.76.88','Google Chrome','Windows'),
 (343,4,'2015-04-21 08:44:47','CIERRE SESION USER ID: 4','USUARIO','190.41.76.88','Google Chrome','Windows'),
 (344,3,'2015-04-21 08:45:05','INICIO SESION: JVEGA09  CORRECTO','USUARIO','190.41.76.88','Google Chrome','Windows'),
 (345,3,'2015-04-21 08:45:05','INICIO SESION: JVEGA09  CORRECTO','USUARIO','190.41.76.88','Google Chrome','Windows'),
 (346,3,'2015-04-21 08:45:58','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (347,3,'2015-04-21 08:46:55','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (348,3,'2015-04-21 08:47:35','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (349,3,'2015-04-21 08:49:13','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (350,3,'2015-04-21 08:49:51','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (351,3,'2015-04-21 08:50:59','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (352,1,'2015-04-21 09:02:51','INICIO SESION: ADMIN  CORRECTO','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (353,1,'2015-04-21 09:03:53','CIERRE SESION USER ID: 1','USUARIO','200.60.47.66','Google Chrome','Windows'),
 (354,3,'2015-04-21 10:17:13','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (355,3,'2015-04-21 10:18:22','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (356,3,'2015-04-21 10:20:45','MODIFICA GUIA = 59','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (357,3,'2015-04-21 10:30:02','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (358,3,'2015-04-21 10:30:39','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (359,3,'2015-04-21 10:31:32','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (360,3,'2015-04-21 10:32:14','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (361,3,'2015-04-21 10:32:56','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (362,3,'2015-04-21 10:33:32','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (363,3,'2015-04-21 10:34:16','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (364,3,'2015-04-21 10:35:00','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (365,3,'2015-04-21 10:35:53','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (366,3,'2015-04-21 10:36:32','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (367,3,'2015-04-21 10:37:19','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','190.41.76.88','Google Chrome','Windows'),
 (368,3,'2015-04-21 12:30:23','CIERRE SESION USER ID: 3','USUARIO','190.41.76.88','Google Chrome','Windows'),
 (369,3,'2015-04-22 10:54:53','INICIO SESION: JVEGA09  CORRECTO','USUARIO','181.64.174.221','Google Chrome','Windows'),
 (370,3,'2015-04-22 10:56:01','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.64.174.221','Google Chrome','Windows'),
 (371,3,'2015-04-22 10:57:19','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.64.174.221','Google Chrome','Windows'),
 (372,3,'2015-04-22 10:58:21','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.64.174.221','Google Chrome','Windows'),
 (373,3,'2015-04-22 11:09:49','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','181.64.174.221','Google Chrome','Windows'),
 (374,1,'2015-04-22 21:01:28','INICIO SESION: ADMIN  CORRECTO','USUARIO','190.113.210.124','Google Chrome','Linux'),
 (375,2,'2015-04-24 17:21:58','INICIO SESION: ABARRAGAN63  CORRECTO','USUARIO','181.66.45.11','Google Chrome','Windows'),
 (376,2,'2015-04-24 17:30:23','CIERRE SESION USER ID: 2','USUARIO','181.66.45.11','Google Chrome','Windows'),
 (377,1,'2015-04-27 10:30:25','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.66.45.11','Google Chrome','Windows'),
 (378,1,'2015-04-27 10:37:35','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.66.45.11','Google Chrome','Windows'),
 (379,1,'2015-04-27 10:47:40','REGISTRO CLIENTE: ECOSAC AGRICOLA','CLIENTE','181.66.45.11','Google Chrome','Windows'),
 (380,1,'2015-04-27 11:00:28','CIERRE SESION USER ID: 1','USUARIO','181.66.45.11','Google Chrome','Windows'),
 (381,2,'2015-04-27 11:00:41','INICIO SESION: ABARRAGAN63  CORRECTO','USUARIO','181.66.45.11','Google Chrome','Windows'),
 (382,2,'2015-04-27 11:01:54','CIERRE SESION USER ID: 2','USUARIO','181.66.45.11','Google Chrome','Windows'),
 (383,1,'2015-04-27 11:02:02','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.66.45.11','Google Chrome','Windows'),
 (384,4,'2015-04-28 09:40:35','INICIO SESION: ALEON91  CORRECTO','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (385,4,'2015-04-28 09:43:20','CIERRE SESION USER ID: 4','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (386,2,'2015-04-28 09:45:17','INICIO SESION: ABARRAGAN63  CORRECTO','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (387,2,'2015-04-28 09:45:40','CIERRE SESION USER ID: 2','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (388,1,'2015-04-28 09:45:49','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (389,4,'2015-04-28 10:01:50','INICIO SESION: ALEON91  CORRECTO','USUARIO','181.67.225.109','Safari','Mac'),
 (390,1,'2015-04-28 10:02:36','REG OBRA','OBRA','181.67.225.109','Google Chrome','Windows'),
 (391,4,'2015-04-28 10:04:16','CIERRE SESION USER ID: 4','USUARIO','181.67.225.109','Safari','Mac'),
 (392,1,'2015-04-28 10:06:04','REG CONTRATO','CONTRATO','181.67.225.109','Google Chrome','Windows'),
 (393,1,'2015-04-28 10:06:12','CIERRE SESION USER ID: 1','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (394,2,'2015-04-28 10:06:41','INICIO SESION: ABARRAGAN63  CORRECTO','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (395,2,'2015-04-28 10:09:16','CIERRE SESION USER ID: 2','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (396,1,'2015-04-28 10:09:29','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (397,1,'2015-04-28 10:10:42','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','181.67.225.109','Google Chrome','Windows'),
 (398,1,'2015-04-28 10:11:00','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','181.67.225.109','Google Chrome','Windows'),
 (399,1,'2015-04-28 10:11:30','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','181.67.225.109','Google Chrome','Windows'),
 (400,1,'2015-04-28 10:11:48','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','181.67.225.109','Google Chrome','Windows'),
 (401,1,'2015-04-28 10:12:22','CIERRE SESION USER ID: 1','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (402,2,'2015-04-28 10:12:29','INICIO SESION: ABARRAGAN63  CORRECTO','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (403,2,'2015-04-28 10:14:42','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (404,2,'2015-04-28 10:23:07','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (405,2,'2015-04-28 10:24:02','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (406,2,'2015-04-28 10:24:49','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (407,2,'2015-04-28 10:28:59','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (408,2,'2015-04-28 10:30:16','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (409,2,'2015-04-28 10:31:42','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (410,2,'2015-04-28 10:33:28','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (411,2,'2015-04-28 10:34:35','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (412,2,'2015-04-28 10:35:26','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (413,2,'2015-04-28 10:36:48','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (414,2,'2015-04-28 10:37:28','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (415,2,'2015-04-28 10:38:20','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (416,2,'2015-04-28 10:39:02','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (417,2,'2015-04-28 10:39:54','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (418,2,'2015-04-28 10:41:43','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (419,2,'2015-04-28 10:44:10','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (420,2,'2015-04-28 10:45:04','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (421,2,'2015-04-28 10:46:14','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (422,2,'2015-04-28 10:51:08','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (423,2,'2015-04-28 10:52:15','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (424,2,'2015-04-28 10:53:52','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (425,2,'2015-04-28 10:56:06','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (426,2,'2015-04-28 10:57:03','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (427,2,'2015-04-28 10:57:57','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (428,2,'2015-04-28 10:59:21','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (429,2,'2015-04-28 11:00:04','REG PARTE MAQUINARIA','CONTROLTRABAJO','181.67.225.109','Google Chrome','Windows'),
 (430,2,'2015-04-28 11:01:17','CIERRE SESION USER ID: 2','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (431,1,'2015-04-28 11:01:48','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (432,4,'2015-04-28 11:29:50','INICIO SESION: ALEON91  CORRECTO','USUARIO','181.67.225.109','Safari','Mac'),
 (433,3,'2015-04-28 11:43:51','INICIO SESION: JVEGA09  CORRECTO','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (434,3,'2015-04-28 12:14:29','CIERRE SESION USER ID: 3','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (435,1,'2015-04-28 12:14:57','INICIO SESION: ADMIN  CORRECTO','USUARIO','181.67.225.109','Google Chrome','Windows'),
 (436,1,'2015-04-28 13:22:44','INICIO SESION: ADMIN  CORRECTO','USUARIO','::1','Google Chrome','Windows'),
 (437,1,'2015-04-29 12:21:53','INICIO SESION: ADMIN  CORRECTO','USUARIO','::1','Google Chrome','Windows'),
 (438,1,'2015-04-29 13:25:00','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (440,1,'2015-04-29 14:37:27','REG OBRA (OBRA EXISTENTE): OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (441,1,'2015-04-29 14:37:36','REG OBRA (OBRA EXISTENTE): OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (442,1,'2015-04-29 14:38:17','REG OBRA (OBRA EXISTENTE): OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (443,1,'2015-04-29 14:39:02','REG OBRA (OBRA EXISTENTE): OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (445,1,'2015-04-29 14:40:52','REG OBRA (OBRA EXISTENTE): OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (450,1,'2015-04-29 14:57:00','REG OBRA: OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (451,1,'2015-04-29 14:57:10','REG OBRA (OBRA EXISTENTE): OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (452,1,'2015-04-29 15:02:24','REG OBRA (OBRA EXISTENTE): OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (453,1,'2015-04-29 15:02:24','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (455,1,'2015-04-29 15:05:30','REG OBRA (OBRA EXISTENTE): OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (456,1,'2015-04-29 15:05:30','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (458,1,'2015-04-29 15:06:16','REG OBRA (OBRA EXISTENTE): OBRA PARA CLIENTE PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (459,1,'2015-04-29 15:06:17','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (461,1,'2015-04-29 19:01:11','REG OBRA: OBRA PARA SECTOR PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (462,1,'2015-04-29 19:01:11','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (463,1,'2015-04-29 19:15:10','REG OBRA (OBRA EXISTENTE): OBRA PARA SECTOR PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (464,1,'2015-04-29 19:15:10','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (465,1,'2015-04-29 19:26:01','REG OBRA (OBRA EXISTENTE): OBRA PARA SECTOR PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (466,1,'2015-04-29 19:26:01','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (467,1,'2015-04-29 20:40:11','REG DETALLE ABASTECIMIENTO','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (468,1,'2015-04-29 21:48:06','INICIO SESION: ADMIN  CORRECTO','USUARIO','::1','Google Chrome','Windows'),
 (469,1,'2015-04-29 22:35:41','INICIO SESION: ADMIN  CORRECTO','USUARIO','::1','Google Chrome','Windows'),
 (470,1,'2015-04-30 09:29:42','MODIFICA GUIA = 145','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (471,1,'2015-04-30 09:30:52','MODIFICA GUIA = 143','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (472,1,'2015-04-30 09:35:22','MODIFICA GUIA = 143','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (473,1,'2015-04-30 09:35:32','MODIFICA GUIA = 143','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (474,1,'2015-04-30 09:35:43','MODIFICA GUIA = 143','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (475,1,'2015-04-30 09:37:29','REG DETALLE ABASTECIMIENTO [MQ]','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (476,1,'2015-04-30 09:39:02','MODIFICA GUIA = 147','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (477,1,'2015-04-30 10:43:45','REG DETALLE ABASTECIMIENTO [VH]','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (478,1,'2015-04-30 11:00:33','REG DETALLE ABASTECIMIENTO [VH]','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (479,1,'2015-04-30 12:11:29','INICIO SESION: ADMIN  CORRECTO','USUARIO','::1','Google Chrome','Windows'),
 (480,0,'2015-04-30 12:48:01','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Google Chrome','Windows'),
 (481,0,'2015-04-30 12:51:56','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (482,0,'2015-04-30 12:51:57','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (483,0,'2015-04-30 12:51:58','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (484,0,'2015-04-30 12:51:59','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (485,0,'2015-04-30 12:51:59','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (486,0,'2015-04-30 12:51:59','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (487,0,'2015-04-30 12:51:59','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (488,0,'2015-04-30 12:52:00','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (489,0,'2015-04-30 12:52:00','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (490,0,'2015-04-30 12:52:03','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (491,0,'2015-04-30 12:52:06','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (492,0,'2015-04-30 12:52:06','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (493,0,'2015-04-30 12:52:06','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (494,0,'2015-04-30 12:52:07','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (495,0,'2015-04-30 12:52:07','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (496,0,'2015-04-30 12:52:07','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (497,0,'2015-04-30 12:52:07','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (498,0,'2015-04-30 12:52:08','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (499,0,'2015-04-30 12:52:08','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (500,0,'2015-04-30 12:52:08','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (501,0,'2015-04-30 12:52:08','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (502,0,'2015-04-30 12:52:08','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (503,0,'2015-04-30 12:52:08','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (504,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (505,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (506,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (507,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (508,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (509,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (510,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (511,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (512,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (513,0,'2015-04-30 12:52:09','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (514,0,'2015-04-30 12:52:10','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (515,0,'2015-04-30 12:52:10','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (516,0,'2015-04-30 12:52:10','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (517,0,'2015-04-30 12:52:10','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (518,0,'2015-04-30 12:52:10','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (519,0,'2015-04-30 12:52:11','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (520,0,'2015-04-30 12:52:11','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (521,0,'2015-04-30 12:52:15','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (522,0,'2015-04-30 12:52:16','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (523,0,'2015-04-30 12:52:16','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (524,0,'2015-04-30 12:52:16','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (525,0,'2015-04-30 12:52:16','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (526,0,'2015-04-30 12:52:16','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (527,0,'2015-04-30 12:52:16','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (528,0,'2015-04-30 12:52:17','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (529,0,'2015-04-30 12:52:17','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (530,0,'2015-04-30 12:52:17','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (531,0,'2015-04-30 12:52:17','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (532,0,'2015-04-30 12:52:18','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (533,0,'2015-04-30 12:52:18','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (534,0,'2015-04-30 12:52:19','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (535,0,'2015-04-30 12:52:19','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (536,0,'2015-04-30 12:52:19','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (537,0,'2015-04-30 12:52:19','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (538,0,'2015-04-30 12:52:19','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (539,0,'2015-04-30 12:52:20','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (540,0,'2015-04-30 12:52:20','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (541,0,'2015-04-30 12:52:24','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (542,0,'2015-04-30 12:52:26','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows');
INSERT INTO `regs` (`id`,`id_usuario`,`fecha`,`accion`,`tablas_afectadas`,`ip_cliente`,`nav_cliente`,`so_cliente`) VALUES 
 (543,0,'2015-04-30 12:52:28','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (544,0,'2015-04-30 12:52:29','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (545,0,'2015-04-30 12:52:30','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (546,0,'2015-04-30 12:52:35','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (547,0,'2015-04-30 12:52:36','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (548,0,'2015-04-30 12:52:36','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (549,0,'2015-04-30 12:52:40','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (550,0,'2015-04-30 12:52:41','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (551,0,'2015-04-30 12:52:41','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (552,0,'2015-04-30 12:52:42','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (553,0,'2015-04-30 12:52:42','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (554,0,'2015-04-30 12:52:43','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (555,0,'2015-04-30 12:52:49','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (556,0,'2015-04-30 12:52:49','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (557,0,'2015-04-30 12:52:50','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (558,0,'2015-04-30 12:52:50','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (559,0,'2015-04-30 12:52:51','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (560,0,'2015-04-30 12:52:51','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (561,0,'2015-04-30 12:52:51','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (562,0,'2015-04-30 12:52:51','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (563,1,'2015-04-30 12:55:05','REG DETALLE ABASTECIMIENTO [VH]','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (564,0,'2015-04-30 12:56:34','INICIO SESION: USER  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (565,0,'2015-04-30 12:56:35','INICIO SESION: 999999.9  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (566,0,'2015-04-30 12:56:37','INICIO SESION: 999999.9 OR 1=1  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (567,0,'2015-04-30 12:56:41','INICIO SESION: 1  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (568,0,'2015-04-30 12:56:42','INICIO SESION: USER AND 1=1  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (569,0,'2015-04-30 12:56:42','INICIO SESION: USER AND 1>1  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (570,0,'2015-04-30 12:56:43','INICIO SESION: 0  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (571,0,'2015-04-30 12:56:44','INICIO SESION: 0  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (572,0,'2015-04-30 12:56:45','INICIO SESION: USER\" AND \"X\"=\"X  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (573,0,'2015-04-30 12:56:46','INICIO SESION: USER\" AND \"X\"=\"Y  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (574,0,'2015-04-30 12:56:46','INICIO SESION: 9999 AND 1=1  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (575,0,'2015-04-30 12:56:48','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (576,0,'2015-04-30 12:56:48','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (577,0,'2015-04-30 12:56:49','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (578,0,'2015-04-30 12:56:49','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (579,0,'2015-04-30 12:56:50','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (580,0,'2015-04-30 12:56:50','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (581,0,'2015-04-30 12:56:51','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (582,0,'2015-04-30 12:56:52','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (583,0,'2015-04-30 12:56:53','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (584,0,'2015-04-30 12:56:59','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (585,0,'2015-04-30 12:57:04','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (586,0,'2015-04-30 12:57:07','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (587,0,'2015-04-30 12:57:11','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (588,0,'2015-04-30 12:57:18','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (589,0,'2015-04-30 12:57:20','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (590,0,'2015-04-30 12:57:31','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (591,0,'2015-04-30 12:57:31','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (592,0,'2015-04-30 12:57:32','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (593,0,'2015-04-30 12:57:32','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (594,0,'2015-04-30 12:57:32','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (595,0,'2015-04-30 12:57:33','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (596,0,'2015-04-30 12:57:33','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (597,0,'2015-04-30 12:57:34','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (598,0,'2015-04-30 12:57:35','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (599,0,'2015-04-30 12:57:37','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (600,0,'2015-04-30 12:57:37','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (601,0,'2015-04-30 12:57:38','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (602,0,'2015-04-30 12:57:38','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (603,0,'2015-04-30 12:57:38','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (604,0,'2015-04-30 12:57:43','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (605,0,'2015-04-30 12:57:43','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (606,0,'2015-04-30 12:57:44','INICIO SESION: 999999.9 UNION ALL SELECT 0X31  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (607,0,'2015-04-30 12:59:00','INICIO SESION: USER AND(SELECT 1 FROM(SELECT   FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (608,0,'2015-04-30 12:59:02','INICIO SESION: USER AND(SELECT 1 FROM(SELECT   FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (609,0,'2015-04-30 12:59:07','INICIO SESION: USER AND IF(1=1,BENCHMARK(4520  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (610,0,'2015-04-30 12:59:07','INICIO SESION: 0  FALLIDO','USUARIO','192.168.5.22','Internet Explorer','Windows'),
 (611,0,'2015-04-30 13:46:36','INICIO SESION: 1  FALLIDO','USUARIO','192.168.5.22','Google Chrome','Windows'),
 (612,0,'2015-04-30 13:47:04','INICIO SESION: ); SELECT 1 --- AA  FALLIDO','USUARIO','192.168.5.22','Google Chrome','Windows'),
 (613,0,'2015-04-30 13:47:14','INICIO SESION: ); SELECT 1 --- AA  FALLIDO','USUARIO','192.168.5.22','Google Chrome','Windows'),
 (614,1,'2015-05-03 11:15:09','INICIO SESION: ADMIN  CORRECTO','USUARIO','::1','Google Chrome','Windows'),
 (615,1,'2015-05-03 11:39:19','MODIFICA GUIA = 146','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (616,1,'2015-05-03 12:10:27','MODIFICA GUIA = 152','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (617,1,'2015-05-03 12:26:00','MODIFICA GUIA = 146','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (618,1,'2015-05-03 12:26:07','MODIFICA GUIA = 152','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (619,1,'2015-05-03 15:31:13','REG DETALLE ABASTECIMIENTO [VH]','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (620,1,'2015-05-03 16:56:20','EDITAR CONTRATO: 1','CONTRATO','::1','Google Chrome','Windows'),
 (621,1,'2015-05-03 18:10:17','REGISTRO DE ALQUILER','DETALLEALQUILER,ALQUILER,VEHICULO','::1','Google Chrome','Windows'),
 (622,1,'2015-05-03 19:41:07','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (623,1,'2015-05-03 19:43:01','REG PARTE MAQUINARIA','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (624,1,'2015-05-03 22:02:12','EDITAR PARTE MAQUINARIA: 29','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (625,1,'2015-05-03 22:09:21','EDITAR PARTE MAQUINARIA: 30','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (626,1,'2015-05-04 08:03:44','INICIO SESION: ADMIN  CORRECTO','USUARIO','::1','Google Chrome','Windows'),
 (627,1,'2015-05-04 10:43:11','REG OBRA (OBRA EXISTENTE): OBRA PARA SECTOR PRIVADO.','OBRA','::1','Google Chrome','Windows'),
 (628,1,'2015-05-04 10:43:11','REG CONTRATO','CONTRATO','::1','Google Chrome','Windows'),
 (629,1,'2015-05-04 10:48:57','FINALIZACIÓN DEL CONTRATO: 9','VEHICULO,ARTICULO,DETALLEALQUILER,TRABVEHICULO,DEVOLUCION,OBRA,CONTRATO','::1','Google Chrome','Windows'),
 (630,1,'2015-05-04 10:49:48','EDITAR CONTRATO: 7','CONTRATO','::1','Google Chrome','Windows'),
 (631,1,'2015-05-04 10:50:07','FINALIZACIÓN DEL CONTRATO: 6','VEHICULO,ARTICULO,DETALLEALQUILER,TRABVEHICULO,DEVOLUCION,OBRA,CONTRATO','::1','Google Chrome','Windows'),
 (632,1,'2015-05-04 10:53:48','REG CONSUMO DE COMBUSTUBLE','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (633,1,'2015-05-04 11:16:16','MODIFICA GUIA = 146','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (634,1,'2015-05-04 11:44:33','EDITAR CONSUMO: 1','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (635,1,'2015-05-04 11:45:19','EDITAR CONSUMO: 1','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (636,1,'2015-05-04 11:45:56','EDITAR CONSUMO: 1','CONSUMO,DETALLEABASTECIMIENTO','::1','Google Chrome','Windows'),
 (637,1,'2015-05-04 11:46:09','EDITAR PARTE MAQUINARIA: 30','CONTROLTRABAJO','::1','Google Chrome','Windows'),
 (638,1,'2015-05-04 11:50:31','MODIFICA GUIA = 142','DETALLEABASTECIMIENTO','::1','Google Chrome','Windows');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipoarticulo`
--

/*!40000 ALTER TABLE `tipoarticulo` DISABLE KEYS */;
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
 (1,'TIPO CLIENTE A','B'),
 (2,'TIPO CLIENTE B','B'),
 (3,'TIPO CLIENTE C','B'),
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
-- Definition of table `tipotrabajador`
--

DROP TABLE IF EXISTS `tipotrabajador`;
CREATE TABLE `tipotrabajador` (
  `id_tipotrabajador` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipotrabajador`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipotrabajador`
--

/*!40000 ALTER TABLE `tipotrabajador` DISABLE KEYS */;
INSERT INTO `tipotrabajador` (`id_tipotrabajador`,`nombre`,`estado`) VALUES 
 (1,'OPERADOR','A'),
 (2,'CONTROLADOR','A'),
 (3,'SUPERVISOR','A'),
 (5,'ASISTENTE ADMINISTRA','A'),
 (6,'JEFE DE OPERADORES','A'),
 (7,'ASISTENTE CONTABLE','A'),
 (8,'SOLDADOR','A'),
 (9,'APOYO LOGISTICO','A'),
 (10,'ASISTENTE DE TALLER','A'),
 (11,'SUPERVISOR DE CAMPO','A'),
 (12,'CONTADOR','A'),
 (13,'SUB GERENTE','A'),
 (14,'GERENTE GENERAL','A'),
 (15,'ADMINISTRACION','A'),
 (16,'ADMINISTRADORA','A'),
 (17,'VIGILANTE','A'),
 (18,'ASISTENTE LOGISTICO','A'),
 (19,'APOYO ADMINISTRATIVO','A'),
 (20,'APOYO DE CAMPO','A');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipousuario`
--

/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` (`id_tipousuario`,`nombre`,`estado`) VALUES 
 (1,'OPERADOR','A'),
 (2,'CONTROLADOR','A'),
 (3,'ADMINISTRADOR','A'),
 (4,'ASISTENTE ADMINISTRATIVO','B'),
 (5,'JEFE DE OPERADORES','A'),
 (6,'ASISTENTE CONTABLE','B'),
 (7,'SOLDADOR','B'),
 (8,'APOYO LOGISTICO','B'),
 (9,'ASISTENTE DE TALLER','B'),
 (10,'SUPERVISOR DE CAMPO','A'),
 (11,'CONTADOR','B'),
 (12,'SUB GERENTE','B'),
 (13,'GERENTE GENERAL','B'),
 (14,'OFICINISTA','A'),
 (15,'PLANTA','A');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipovehiculo`
--

/*!40000 ALTER TABLE `tipovehiculo` DISABLE KEYS */;
INSERT INTO `tipovehiculo` (`id_tipovehiculo`,`nombre`,`estado`) VALUES 
 (1,'MAQUINARIA PESADA','A'),
 (2,'VOLQUETES','A'),
 (3,'CAMIONES','A'),
 (4,'CAMIONETAS','A'),
 (5,'SURTIDOR','A'),
 (6,'REMOLCADOR','A'),
 (7,'CISTERNA','A');
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trabajador`
--

/*!40000 ALTER TABLE `trabajador` DISABLE KEYS */;
INSERT INTO `trabajador` (`id_trabajador`,`id_tipotrabajador`,`apellidos`,`nombres`,`fecha_nac`,`dni`,`ruc`,`telefono`,`nro_licencia`,`estado`) VALUES 
 (1,0,'ADMIN','ADMIN','0000-00-00','00000000','0000000000','000000000','00000000','A'),
 (2,19,'BARRAGAN IGLESIAS','ANDRÉS','1992-05-29','47169563','','','','A'),
 (3,19,'VEGA SANDOVAL','JOSÉ CARLOS','1991-05-02','47026209','','','b47026209','A'),
 (4,3,'LEON OSORES','ANDRÉS ANTENOR','2015-04-01','71086191','','','','A'),
 (5,5,'ALVA NEIRA','JOSE ROBERTO JAVIER','2015-04-03','07794415','','','','A'),
 (6,6,'BALLADARES OYOLA','GASPAR INOCENCIO','2015-04-08','00235345','','','B00235345','A'),
 (7,7,'BALLADARES GALVEZ','CESAR AUGUSTO','2015-03-29','71739950','','','','A'),
 (8,7,'COVEÑAS CHERO','GLADIS SUSANA','2015-04-15','40480616','','','','A'),
 (9,1,'CRISANTO CHERO','EUGENIO','2015-04-05','17581419','','','','A'),
 (10,5,'DIAZ GOICOCHEA','DANNY DOMINIC','2015-03-29','41974168','','','','A'),
 (11,8,'DIOSES SILVA','WILMER ARSENIO','2015-03-31','46797807','','','','A'),
 (12,1,'GALVEZ ALBURQUEQUE','AUGUSTO','2015-04-01','43546309','','','b43546309','A'),
 (13,9,'CALDERON SANCHEZ','ALONSO','2015-04-15','74243285','','961699306','B74243285','A'),
 (14,1,'GALVEZ ALBURQUEQUE','JAVIER','1987-07-29','44890258','','','B44890258','A'),
 (15,10,'GALVEZ CAMACHO','LUIS GUSTAVO','2015-04-07','47690240','','','','A'),
 (16,1,'GUERRERO CASTILLO','JOSE','2015-03-30','02837871','','','B02837871','A'),
 (17,11,'LEON RAMIREZ','LUIS ANTONIO','2015-03-29','02648687','','','','A'),
 (18,12,'LEON OSORES','MARIA ALEJANDRA','2015-04-14','42117922','','','','A'),
 (19,13,'LEON OSORES','LUIS MIGUEL','2015-04-13','43230607','','','','A'),
 (20,11,'LEON RAMIREZ','ERNESTO ANTENOR','2015-04-15','02616160','','','','A'),
 (21,1,'MERINO AGUILAR','PEDRO ISIDRO','2015-04-15','46212764','','','','A'),
 (22,1,'MORALES GONZALES','JIMY CARLOS','2015-04-16','44214611','','','B44214611','A'),
 (23,1,'MORE RAMOS','ANTONIO','2015-04-16','02718343','','','B02718343','A'),
 (24,16,'OSORES ORTEGA','MARIA DEL PILAR','2015-04-16','02642604','','','B02642604','A'),
 (25,1,'RAMOS INGA','FIDEL','2015-04-16','80548063','','','B80548063','A'),
 (26,1,'RAMOS INGA','SANTOS','2015-04-16','03509415','','','B03509415','A'),
 (27,1,'RAMOS INGA','JOSE ANDRES','2015-03-29','42847857','','','B42847857','A'),
 (28,1,'RAMOS INGA','PEDRO','2015-03-30','44361019','','','B44361019','A'),
 (29,5,'SAAVEDRA CALLIRGOS','HECTOR HUGO','2015-04-05','02612041','','','B02612041','A'),
 (30,1,'SANDOVAL SILVA','ELMER','2015-04-16','73340923','','','B73340923','A'),
 (31,1,'SANTIAGO MARCELO','LUIS ALBERTO','2015-04-16','45787541','','','B45787541','A'),
 (32,17,'SOJO SOSA','ALCIDES RODOLFO','2015-04-16','02691336','','','B02691336','A'),
 (33,1,'SULLON RAMOS','ELMER RONALD','2015-04-16','47343575','','','B47343575','A'),
 (34,1,'TORRES IMAN','JOSE REYES','2015-04-16','02724799','','','B02724799','A'),
 (35,1,'TORRES REQUENA','LUIS','2015-04-16','46546921','','','B46546921','A'),
 (36,18,'TIMANA CHANGANAQUE','CLAUDIO','2015-04-16','40992589','','','B40992589','A'),
 (37,1,'VALENCIA COVEÑAS','ROBERTO CARLOS','2015-04-16','47461790','','','B47461790','A'),
 (38,1,'VALENCIA YOVERA','CESAR','2015-04-16','46201375','','','B46201375','A'),
 (39,1,'VALENCIA YOVERA','EDWIN','2015-04-16','44719597','','','B44719597','A'),
 (40,1,'VALENCIA YOVERA','JHONNY','2015-04-16','43507501','','','B43507501','A'),
 (41,7,'YARLEQUE ZAPATA','GERARDO FABIAN','2015-04-16','47588720','','','','A'),
 (42,1,'ZAPATA GOMEZ','MIGUEL GUSTAVO','2015-04-16','43441641','','','B43441641','A'),
 (43,1,'GOMEZ SILVA','JOSE','2015-04-16','02683050','','','B02683050','A'),
 (44,19,'MARQUEZ TIMANA','JOSE ALEJANDRO','2015-04-16','70382123','','','','A'),
 (45,20,'TORRES FERNANDEZ','WILMER','2015-04-16','12345678','','','','A');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trabvehiculo`
--

/*!40000 ALTER TABLE `trabvehiculo` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transporte`
--

/*!40000 ALTER TABLE `transporte` DISABLE KEYS */;
INSERT INTO `transporte` (`id_transporte`,`id_detallealquiler`,`concepto`,`observacion`,`fecha`,`monto`) VALUES 
 (1,1,'MOVILIZACIÓN','','2015-02-19 00:00:00','1500.00');
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `usuario`
--

/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id_usuario`,`id_trabajador`,`id_tipousuario`,`nombre`,`clave`,`estado`,`f_registro`,`f_modificacion`,`f_ultimo_acceso`,`f_cierre_sesion`,`cambio_clave`) VALUES 
 (1,1,3,'admin','e10adc3949ba59abbe56e057f20f883e','A','2015-02-08 19:43:51','2015-03-09 04:40:06','2015-05-04 08:03:43','2015-04-28 10:12:22',1),
 (2,2,2,'abarragan63','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 10:13:07','2015-04-16 10:04:14','2015-04-28 10:12:29','2015-04-28 11:01:17',0),
 (3,3,2,'jvega09','2e4f660b0cea8e4d5bd820ce02d50d66','A','2015-04-15 10:35:18','2015-04-16 10:22:37','2015-04-28 11:43:51','2015-04-28 12:14:29',1),
 (4,4,3,'aleon91','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 10:36:54','0000-00-00 00:00:00','2015-04-28 11:29:50','2015-04-28 10:04:16',0),
 (5,5,14,'jalva15','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 10:53:17','2015-04-16 09:58:45','2015-04-16 08:03:20','0000-00-00 00:00:00',0),
 (6,6,1,'gballadares45','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:03:29','2015-04-17 17:27:27','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (7,7,14,'cballadares50','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:06:35','2015-04-16 10:03:15','2015-04-16 07:59:55','2015-04-16 07:59:18',0),
 (8,8,14,'gcoveñas16','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:07:41','2015-04-16 10:00:06','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (9,9,1,'ecrisanto19','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:09:32','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (10,10,14,'ddiaz68','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:11:19','2015-04-16 09:59:18','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (11,11,15,'wdioses07','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:14:16','2015-04-16 10:05:14','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (12,12,1,'agalvez09','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:16:01','2015-04-15 11:24:45','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (13,13,2,'acalderon85','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:21:45','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (14,14,1,'jgalvez58','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:26:22','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (15,15,15,'lgalvez40','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:29:44','2015-04-16 10:02:36','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (16,16,1,'jguerrero71','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:31:06','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (17,17,10,'lleon87','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:34:01','2015-04-16 10:06:27','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (18,18,14,'mleon22','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:36:29','2015-04-16 10:01:40','2015-04-16 07:45:49','2015-04-16 07:55:58',0),
 (19,19,14,'lleon07','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:39:39','2015-04-16 10:05:37','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (20,20,10,'eleon60','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:44:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (21,21,1,'pmerino64','e10adc3949ba59abbe56e057f20f883e','A','2015-04-15 11:56:10','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (22,22,1,'jmorales11','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:11:30','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (23,23,1,'amore43','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:13:37','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (24,24,14,'mosores04','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:23:40','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (25,25,1,'framos63','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:25:08','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (26,26,1,'sramos15','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:27:32','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (27,27,1,'jramos57','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:28:11','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (28,28,1,'pramos19','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:28:49','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (29,29,14,'hsaavedra41','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:29:55','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (30,30,1,'esandoval23','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:31:23','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (31,31,1,'lsantiago41','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:32:04','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (32,32,15,'asojo36','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:36:49','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (33,33,1,'esullon75','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:37:55','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (34,34,1,'jtorres99','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:38:39','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (35,35,1,'ltorres21','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:39:31','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (36,36,14,'ctimana89','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:41:36','2015-04-16 09:42:09','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (37,37,1,'rvalencia90','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:43:02','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (38,38,1,'cvalencia75','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:43:29','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (39,39,1,'evalencia97','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:44:05','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (40,40,1,'jvalencia01','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:44:45','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (41,41,14,'gyarleque20','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:45:49','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (42,42,1,'mzapata41','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:46:58','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (43,43,1,'jgomez50','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:47:36','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (44,44,14,'jmarquez23','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:51:03','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0),
 (45,45,15,'wtorres78','e10adc3949ba59abbe56e057f20f883e','A','2015-04-16 09:53:23','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `vehiculo`
--

/*!40000 ALTER TABLE `vehiculo` DISABLE KEYS */;
INSERT INTO `vehiculo` (`id_vehiculo`,`id_marca`,`id_tipovehiculo`,`nombre`,`modelo`,`serie`,`motor`,`color`,`placa`,`rendimiento`,`estado`,`horometro_ac`,`kilometraje_ac`,`precio_alq`) VALUES 
 (1,1,1,'TRACTOR D8T #01','D8T','J8B03317','TXGO5157','AMARILLA','J8B03317','0.000','A','3540.00','3540.00','550.00'),
 (2,1,1,'TRACTOR D8T #02','D8T','J8B03072','TXG03883','AMARILLA','J8B03072','0.000','C','45505.00','6044.00','550.00'),
 (3,1,1,'TRACTOR D7-RII #01','D7-RII','AEC01830','07ZR23926','AMARILLO','AEC01830','0.000','A','13436.00','13436.00','420.00'),
 (4,1,1,'TRACTOR D7-RII #02','D7-RII','AEC02001','07ZR24462','AMARILLO','AEC02001','0.0000','A','9259.00','9259.00','420.00'),
 (5,1,1,'TRACTOR D7-RII #03','D7-RII','AEC01909','07ZR24215','AMARILLO','AEC01909','0.000','A','10454.00','10454.00','420.00'),
 (6,1,1,'EXCAVADORA 336DL #01','336DL','OM4T01576','0THX37070','AMARILLO','OM4T01576','0.0000','A','7248.00','7248.00','440.00'),
 (7,1,1,'EXCAVADORA 336DL #02','336DL','0M4T01252','OTHX34817','AMARILLO','0M4T01252','0.000','C','7592.00','7592.00','440.00'),
 (8,1,1,'EXCAVADORA 324DL','324DL','DFP01154','KHX41907','AMARILLO','DFP01154','0.000','C','5785.00','5785.00','0.00'),
 (9,1,1,'EXCAVADORA 320C #01','320C','0FBA-01122','7JK-59396','AMARILLO','0FBA-01122','0.000','A','4078.00','4078.00','240.00'),
 (10,1,1,'EXCAVADORA 320C #02','320C','0FBA-03503','07JK-05242','AMARILLO','0FBA-03503','0.000','C','8786.00','8786.00','240.00'),
 (11,1,1,'EXCAVADORA 320C #03','320CL','SBN02008','MAE10063','AMARILLO','SBN02008','0.000','A','3704.30','3704.30','240.00'),
 (12,1,1,'CARGADOR FRONTAL','938H','JKM01803','G9G04934','AMARILLO','JKM01803','0.000','A','3096.00','3096.00','240.00'),
 (13,1,1,'RETROEXCAVADORA 420D #01','420D','FDP18886','CRS01348','AMARILLO','FDP18886','0.000','A','7160.00','7160.00','160.00'),
 (14,1,1,'RETROEXCAVADORA 420D #02','420D','FDP25563','CRS28385','AMARILLO','FDP25563','0.000','A','7593.00','7593.00','160.00'),
 (15,5,5,'CAMIONETA VERDE SURTIDOR','RICH','LJNTGUBS5FN006218','0-71248','VERDE','P3H-833','0.0','A','0.00','0.00','0.00'),
 (16,5,5,'CAMIONETA AZUL SURTIDOR','RICH','LJNTGUBS7FN006219','0-80252','AZUL','P3H-810','0.00','A','0.00','0.00','0.00'),
 (17,5,2,'VOLQUETE #01','DFL3251A W','LGAX4DD39D3809805','87614060','BLANCO','P3G-742','0.000','A','0.00','0.00','0.00'),
 (18,5,2,'VOLQUETE #02','DFL3251A W','LGAX4DD30D3809854','87612813','BLANCO','P3D-898','0.000','D','24569.00','0.00','0.00'),
 (19,5,2,'VOLQUETE #03','DFL3251A W','LGAX4DD35D3809848','87612817','BLANCO','P3D-885','0.000','A','0.00','0.00','0.00'),
 (20,6,6,'REMOLCADOR','CXU613E','1M1AW07YXFM048198','MP8-1067792','BLANCO','AAO-915','0.000','A','0.00','0.00','0.00'),
 (21,6,2,'VOLQUETE #01.','GU813E','1M2AX18C2FM028478','MP8-1061863','BLANCO','AAY-840','0.000','A','0.00','0.00','0.00'),
 (22,6,2,'VOLQUETE #02.','GU813E','1M2AX18C7FM027908','MP8-1056812','BLANCO','ABA-852','0.000','A','0.00','0.00','0.00'),
 (23,5,4,'CAMIONETA PLATA','RICH','LJNTGUBS9FN006223','0-71236','PLATA','P3H-837','0.000','A','0.00','0.00','0.00'),
 (24,4,4,'CAMIONETA BLANCA #01','L200','MMBJNKB40ED015100','4D56UCEP3173','BLANCO','P3C-771','0.000','A','0.00','0.00','0.00'),
 (25,4,4,'CAMIONETA BLANCA #02','L200','MMBJNKB408F002364','4D56UCAZ6216','BLANCO','P2W-833','0.000','A','0.00','0.00','0.00'),
 (26,4,4,'CAMIONETA BLANCA #03','L200','MMBJNKB40CD061059','4D56UCDU0435','BLANCO','P2K-786','0.000','A','0.00','0.00','0.00'),
 (27,7,4,'CAMIONETA PICK','SILVERADO','3GCPK9E35BG235234','XXXXXXXXXXXXXX','GRIS','P2J-926','0.000','A','0.00','0.00','0.00'),
 (28,3,4,'CAMIONETA RURAL #01','SORENTO','KNAKU811DE5450737','GAKEDH777497','GRIS','P2G-253','0.000','A','0.00','0.00','0.00'),
 (29,3,4,'CAMIONETA RURAL #02','SORENTO','KNAKU811BC5214551','G4KEBH761906','GRIS','P1N-388','0.000','A','0.00','0.00','0.00'),
 (30,3,3,'CAMIONSITO','K-2700','J2477581','XXXXXXXXXXXXXX','BLANCO','P2W-828','0.000','A','0.00','0.00','0.00'),
 (31,4,4,'CAMIONETA GRIS OSCURO-METALICO','L200','MMBJNKB40CD059332','4D56UCDT1531','GRIS OSCUR','P2F-772','0.0000','A','0.00','0.00','0.00'),
 (32,8,7,'CISTERNA','F-350','1FDKF38M2PNA09761','1FDKF38M2PNA09761','BLANCO','P2U-886','0.000','A','0.00','0.00','0.00'),
 (33,9,4,'CAMIONETA MAZDA','B-2600','JM7UFY065V0122656','XXXXXXXXXXXXXX','VERDE PETR','B4J-831','0.000','A','0.00','0.00','0.00');
/*!40000 ALTER TABLE `vehiculo` ENABLE KEYS */;


--
-- Definition of procedure `sp_anular_alquiler_vehiculo`
--

DROP PROCEDURE IF EXISTS `sp_anular_alquiler_vehiculo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_combo`(IN `tabla` VARCHAR(50))
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
  when 'tipotrabajador' THEN SELECT id_tipotrabajador as id, nombre FROM tipotrabajador WHERE estado = 'A';
  when 'tipousuario' THEN SELECT id_tipousuario as id, nombre FROM tipousuario WHERE estado = 'A';
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
                                 WHERE tt.nombre <> 'OPERADOR' AND t.estado = 'A' ORDER BY t.apellidos;
  ## operarios que no tengan un trabajo asignado
  WHEN 'operario' THEN SELECT t.id_trabajador as id,CONCAT(t.apellidos,', ',t.nombres) as nombre FROM trabajador t
                                 INNER JOIN tipotrabajador tt ON tt.id_tipotrabajador = t.id_tipotrabajador
                                 LEFT JOIN trabvehiculo tv ON t.id_trabajador = tv.id_trabajador
                                 WHERE tt.nombre = 'OPERADOR' AND t.estado = 'A'
                                 AND t.id_trabajador NOT IN (SELECT id_trabajador FROM trabvehiculo WHERE estado = 'A')
                                 GROUP BY t.id_trabajador ORDER BY t.apellidos;

  WHEN 'operador' THEN SELECT t.id_trabajador as id,CONCAT(t.apellidos,', ',t.nombres) as nombre FROM trabajador t
                                 INNER JOIN tipotrabajador tt ON tt.id_tipotrabajador = t.id_tipotrabajador
                                 LEFT JOIN trabvehiculo tv ON t.id_trabajador = tv.id_trabajador
                                 WHERE tt.nombre = 'OPERADOR' AND t.estado = 'A'
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
fechar_reg = now()
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
IN `id_usuario_i` INT,
IN `ip` VARCHAR(16),
IN `nav` VARCHAR(50),
IN `so` VARCHAR(50),
IN `id_detalleabastecimiento_i` INT,
IN `id_tipocombustible_i` INT,
IN `fecha_i` TIMESTAMP,
IN `nro_guia_i` VARCHAR(20),
IN `cantidad_i` DECIMAL(10,2),
IN `abastecedor_i` VARCHAR(200),
IN `nro_licencia_i` VARCHAR(15),
IN `placa_i` VARCHAR(15),
IN vale_combustible_i varchar(10),
OUT `salida` VARCHAR(10)
)
BEGIN

DECLARE vehiculo int;
DECLARE conductor int;

select id_vehiculo into vehiculo from vehiculo where upper(placa) = upper(placa_i);

select id_trabajador into conductor from trabajador where upper(nro_licencia) = upper(nro_licencia_i);

if (vehiculo > 0 AND conductor > 0) then

UPDATE detalleabastecimiento SET
id_tipocombustible = id_tipocombustible_i,
fecha = fecha_i,
nro_guia = UPPER(nro_guia_i),
cantidad = UPPER(cantidad_i),
abastecedor = UPPER(abastecedor_i),
id_vehiculo = vehiculo,
vale_combustible = vale_combustible_i,

id_trabajador = conductor
WHERE id_detalleabastecimiento = id_detalleabastecimiento_i;

-- ---------------------------
CALL sp_regs(id_usuario_i,concat('MODIFICA GUIA = ',id_detalleabastecimiento_i),
'detalleabastecimiento',ip,nav,so);

  set salida = 'OK';


end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_editar_obra`
--

DROP PROCEDURE IF EXISTS `sp_editar_obra`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
in valoriza_i char(2),
in hora_min_i decimal(10,2),
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
minuto = min_i,
valoriza = valoriza_i,
hora_min = hora_min_i

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
IN `id_usuario_i` INT,
IN `ip` VARCHAR(16),
IN `nav` VARCHAR(50),
IN `so` VARCHAR(50),
IN `id_contrato_i` INT,
IN `presupuesto_i` DECIMAL(10,2),
IN `observacion_i` VARCHAR(400),
IN `fecha_fin_i` TIMESTAMP,
OUT `salida` VARCHAR(10))
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
  UPDATE detallealquiler SET est_alq = 'B' WHERE id_detallealquiler = id_det AND est_alq = 'A';
  -- cambia estado a trabvehiculo
  UPDATE trabvehiculo SET f_fin = fecha_fin_i, estado = 'B' WHERE id_detallealquiler = id_det AND estado = 'A';
  -- registrar en tbl devolucion
  INSERT INTO devolucion VALUES(NULL,id_det,fecha_fin_i,'',concat('FINALIZACIÓN DE CONTRARO',': ',UPPER(observacion_i)));

END LOOP;

CLOSE cur_detalle;

-- obtiene la obra
SET @obra = (SELECT id_obra FROM contrato WHERE id_contrato = id_contrato_i);

-- cambia estado a obra
-- UPDATE obra SET estado = 'B' WHERE id_obra = @obra;

-- datos de contrato
UPDATE contrato SET f_fin = fecha_fin_i, presupuesto = ifnull(presupuesto_i,0), estado = 'B'
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
-- Definition of procedure `sp_historial_maquinaria_fechas`
--

DROP PROCEDURE IF EXISTS `sp_historial_maquinaria_fechas`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_historial_maquinaria_fechas`(
in id_v int,
in f_desde date,
in f_hasta date
)
BEGIN

SELECT
distinct(c.`id_controltrabajo`),
c.`fecha`,
cl.nombre as cliente,
o.nombre as obra,
da.precio_alq,
concat( v.`nombre`,'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre_c,
concat( substr(v.`nombre`,1,4),'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre,
concat(tr_o.apellidos,', ',tr_o.nombres) as operario,
concat(tr_r.apellidos,', ',tr_r.nombres) as responsable,
c.`nro_interno`,
c.`nro_parte`,
c.`lugar_trabajo`,
c.`tarea`,
c.`agua`,
c.`petroleo`,
c.`gasolina`,
c.`ac_motor`,
c.`ac_transmision`,
c.`ac_hidraulico`,
c.`grasa`,
ifnull(con.nro_vale,'SIN CONSUMO') as nro_vale,
ifnull(con.cant_combustible,0) as cant_combustible,
ifnull(con.horometro,0) as horom_abast,
c.`observacion`,
CASE
WHEN c.turno = 'M' THEN 'MAÑANA'
WHEN c.turno = 'T' THEN 'TARDE'
WHEN c.turno = 'C' THEN 'COMPLETO'
END as turno,
c.`descuento`,
c.`horometro_inicio`,
c.`horometro_fin`,
c.`total_h`,
c.`hrs`,
c.`minuto`
FROM controltrabajo c
INNER JOIN detallealquiler da ON c.id_detallealquiler = da.id_detallealquiler
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN marca m ON v.id_marca = v.id_marca
INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
INNER JOIN trabajador tr_o ON c.id_operario = tr_o.id_trabajador
INNER JOIN trabajador tr_r ON c.id_responsable = tr_r.id_trabajador

INNER JOIN contrato ct ON da.id_contrato = ct.id_contrato
INNER JOIN obra o ON ct.id_obra = o.id_obra
INNER JOIN cliente cl ON ct.id_cliente = cl.id_cliente

LEFT JOIN partevale pv ON c.id_controltrabajo = pv.id_controltrabajo
LEFT JOIN consumo con ON pv.id_consumo = con.id_consumo

WHERE v.id_vehiculo = id_v AND date(c.fecha) BETWEEN f_desde AND f_hasta
ORDER BY c.fecha, c.nro_parte, cl.nombre;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_horometro_anterior`
--

DROP PROCEDURE IF EXISTS `sp_horometro_anterior`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
da.observacion
-- t.id_transporte
#tv.id_trabvehiculo,
#tv.estado as estado_trab
FROM detallealquiler da

INNER JOIN vehiculo v ON v.id_vehiculo = da.id_vehiculo
INNER JOIN contrato c ON c.id_contrato = da.id_contrato
INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente
INNER JOIN obra o ON c.id_obra = o.id_obra

#LEFT JOIN trabvehiculo tv ON da.id_detallealquiler = tv.id_detallealquiler
-- LEFT JOIN transporte t ON da.id_detallealquiler = t.id_detallealquiler

WHERE da.id_contrato = id_contrato_i AND da.est_alq = 'A';

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_articulos`
--

DROP PROCEDURE IF EXISTS `sp_listar_articulos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

SELECT c.*,o.nombre as obra,con.id_contrato,con.estado as estado_con,con.f_inicio,con.f_fin
FROM cliente c
INNER JOIN contrato con ON c.id_cliente = con.id_cliente
INNER JOIN obra o ON con.id_obra = o.id_obra
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
-- Definition of procedure `sp_listar_consumo_combustible`
--

DROP PROCEDURE IF EXISTS `sp_listar_consumo_combustible`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_consumo_combustible`(
in id_usuario_i int
)
BEGIN

##
# fecha, obra, n operacion, n guia, n vale,
# n surtidor, vehiculo, marca, cant comb, tipo comb,
# horom_kilom

SELECT
c.fecha,
o.nombre as obra,
c.nro_operacion,
c.nro_guia,
c.nro_vale,
c.nro_surtidor,
c.cant_combustible,
c.horom_kilom,
tv.nombre as tipovehiculo,
concat(v.nombre,'/MOD:',v.modelo,'/SER:',v.serie) as vehiculo,
m.nombre as marca,
tc.nombre as tipocombustible
FROM consumo c
INNER JOIN trabvehiculo trab ON c.id_trabvehiculo = trab.id_trabvehiculo
INNER JOIN vehiculoph vph ON trab.id_vehiculoph = vph.id_vehiculoph
INNER JOIN vehiculo v ON vph.id_vehiculo = v.id_vehiculo
INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

INNER JOIN detallealquiler da ON vph.id_vehiculoph = da.id_vehiculoph
INNER JOIN alquiler al ON da.id_alquiler = al.id_alquiler
INNER JOIN contrato con ON al.id_contrato = con.id_contrato
INNER JOIN obra o ON con.id_obra = o.id_obra

INNER JOIN tipocombustible tc ON c.id_tipocombustible = tc.id_tipocombustible

INNER JOIN trabajador t ON trab.id_trabajador = t.id_trabajador
INNER JOIN usuario u ON t.id_trabajador = u.id_trabajador

WHERE u.id_usuario = id_usuario_i;



END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_contrato`
--

DROP PROCEDURE IF EXISTS `sp_listar_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
ORDER BY c.estado, es.nombre DESC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_contrato_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_contrato_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
-- Definition of procedure `sp_listar_control_trabajo`
--

DROP PROCEDURE IF EXISTS `sp_listar_control_trabajo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_control_trabajo`(
in id_usuario_i int
)
BEGIN

SELECT
ct.fecha,
ct.nro_parte,
ct.lugar_trabajo,
ct.tarea,
concat(v.nombre,'/MOD:',v.modelo,'/SER:',v.serie) as vehiculo,
ct.horometro_inicio,
ct.horometro_fin,
ct.total_h
FROM controltrabajo ct
INNER JOIN trabvehiculo trab ON ct.id_trabvehiculo = trab.id_trabvehiculo
INNER JOIN vehiculoph vph ON trab.id_vehiculoph = vph.id_vehiculoph

INNER JOIN vehiculo v ON vph.id_vehiculo = v.id_vehiculo
INNER JOIN trabajador t ON trab.id_trabajador = t.id_trabajador
INNER JOIN usuario u ON t.id_trabajador = u.id_trabajador
WHERE u.id_usuario = id_usuario_i;

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
d.abastecedor,
CASE d.vale_combustible
WHEN 0 THEN 'FALTANTE'
ELSE d.vale_combustible
END AS vale_combustible,
d.ingreso

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
-- Definition of procedure `sp_listar_guias_fechas`
--

DROP PROCEDURE IF EXISTS `sp_listar_guias_fechas`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_guias_fechas`(
in f_desde date,
in f_hasta date,
in param char(2)
)
BEGIN

if (param = 'MQ') then --  el reporte es para guias de consumo

SELECT
-- muestra solo las guías que presentan almenos un consumo
d.`id_detalleabastecimiento`,
-- d.`id_abastecimiento`,
date(d.`fecha`) as fecha_compra,
tc.nombre as tipo_comprobante,
a.`nro_comprobante`,
a.nro_operacion_ch,
d.`nro_guia`,
d.`cantidad`,
'GLNS' as unidad,
date(con.fecha) as fecha_abast,
vh.`nombre` as vehiculo,
con.nro_vale,
con.cant_combustible,
con.horometro,
concat(tr.apellidos,', ',tr.nombres) as operario,
d.`stock`,

ifnull(a.`nro_comprobante`,'SIN ASIGNAR') as estado_g,

c.`nombre` as tipocombustible,
v.nombre as vehiculo_surt,
concat(t.`apellidos`,', ',t.`nombres`) as conductor,

d.abastecedor
FROM detalleabastecimiento d
LEFT JOIN abastecimiento a ON d.id_abastecimiento = a.id_abastecimiento

INNER JOIN tipocombustible c ON d.id_tipocombustible = c.id_tipocombustible
INNER JOIN trabajador t ON t.id_trabajador = d.id_trabajador
INNER JOIN vehiculo v ON v.id_vehiculo = d.id_vehiculo

-- SOLO muestra las guías que posean almenos un consumo
INNER JOIN consumo con ON d.id_detalleabastecimiento = con.id_detalleabastecimiento
LEFT JOIN tipocomprobante tc ON a.id_tipocomprobante = tc.id_tipocomprobante
LEFT JOIN detallealquiler da ON con.id_detallealquiler = da.id_detallealquiler
LEFT JOIN vehiculo vh ON da.id_vehiculo = vh.id_vehiculo
LEFT JOIN trabajador tr ON con.id_operario = tr.id_trabajador

WHERE (date(d.fecha) BETWEEN f_desde AND f_hasta)
AND ingreso = 'MQ'
ORDER BY d.fecha ASC, d.id_detalleabastecimiento ASC;

else -- VH si el reporte es para vales de consumo

SELECT
-- muestra todos los vales de consumo
d.`id_detalleabastecimiento`,
-- d.`id_abastecimiento`,
date(d.`fecha`) as fecha_compra,
d.`vale_combustible`,
d.`cantidad`,
'GLNS' as unidad,
date(d.fecha) as fecha_abast,
vh.`nombre` as vehiculo,

c.`nombre` as tipocombustible,
concat(t.`apellidos`,', ',t.`nombres`) as conductor,

d.abastecedor
FROM detalleabastecimiento d

INNER JOIN tipocombustible c ON d.id_tipocombustible = c.id_tipocombustible
INNER JOIN trabajador t ON t.id_trabajador = d.id_trabajador

LEFT JOIN vehiculo vh ON d.id_vehiculo = vh.id_vehiculo

WHERE (date(d.fecha) BETWEEN f_desde AND f_hasta)
AND ingreso = 'VH'
ORDER BY d.fecha ASC, d.id_detalleabastecimiento ASC;

end if;

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
d.vale_combustible,
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_guia_ID`(IN `id_det_abast` INT)
BEGIN

SELECT
d.`id_detalleabastecimiento`,
d.`id_abastecimiento`,
a.`nro_comprobante`,
ifnull(a.`nro_comprobante`,'SIN ASIGNAR') as estado_g,
c.id_tipocombustible,
c.`nombre` as tipocombustible,
upper(v.placa) as placa,
concat(v.nombre,' /MOD: ',ifnull(v.modelo,''),' /SERIE: ',ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo,
upper(t.nro_licencia) as nro_licencia,
concat(t.`apellidos`,', ',t.`nombres`) as conductor,
substr(d.`fecha`,1,10) as fecha,
d.`nro_guia`,
d.`cantidad`,
d.`stock`,
d.abastecedor,
CASE d.vale_combustible
WHEN 0 THEN 'FALTANTE'
ELSE d.vale_combustible
END AS vale_combustible

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

SELECT o.id_obra,o.nombre as obra,o.fecha
FROM obra o;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_obra_ID`
--

DROP PROCEDURE IF EXISTS `sp_listar_obra_ID`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
-- Definition of procedure `sp_listar_partes_x_contrato`
--

DROP PROCEDURE IF EXISTS `sp_listar_partes_x_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_partes_x_contrato`(
in id_contrato_i int
)
BEGIN

declare id_tr int;

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

WHERE da.id_contrato = id_contrato_i

ORDER BY ct.fecha DESC, ct.nro_parte DESC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_partes_x_fechas`
--

DROP PROCEDURE IF EXISTS `sp_listar_partes_x_fechas`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_partes_x_fechas`(
in f_desde date,
in f_hasta date
)
BEGIN

declare id_tr int;

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

WHERE ct.fecha BETWEEN f_desde AND f_hasta

ORDER BY ct.fecha DESC, ct.nro_parte DESC;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_registro_consumo`
--

DROP PROCEDURE IF EXISTS `sp_listar_registro_consumo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo,
ct.valoriza,
ct.hora_min
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_vehiculos`()
BEGIN

SELECT v.id_vehiculo,m.nombre as marca,tv.nombre as tipovehiculo,v.nombre,
v.modelo,v.serie,v.motor,v.color,v.placa,e.nombre as estado,v.precio_alq as precio_hora,
count(mt.id_mantenimiento) as n_mant, count(ct.nro_parte) as n_parte
FROM vehiculo v
LEFT JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
LEFT JOIN marca m ON v.id_marca = m.id_marca
INNER JOIN estado e ON v.estado = e.id_estado

LEFT JOIN mantenimiento mt ON v.id_vehiculo = mt.id_vehiculo
LEFT JOIN detallealquiler da ON v.id_vehiculo = da.id_vehiculo
LEFT JOIN controltrabajo ct ON da.id_detallealquiler = ct.id_detallealquiler

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
-- Definition of procedure `sp_listar_vehiculos_x_cliente`
--

DROP PROCEDURE IF EXISTS `sp_listar_vehiculos_x_cliente`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_vehiculos_x_cliente`(
in id_cliente_i int
)
BEGIN

SELECT t.*,concat(tr.apellidos,', ',tr.nombres) as operario,v.nombre,v.modelo,v.serie,v.motor,v.color,v.placa
FROM trabvehiculo t
INNER JOIN detallealquiler da ON t.id_detallealquiler = da.id_detallealquiler
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN contrato con ON da.id_contrato = con.id_contrato
INNER JOIN trabajador tr ON tr.id_trabajador = t.id_trabajador
WHERE con.id_cliente = id_cliente_i
ORDER BY t.estado,t.id_trabvehiculo desc;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_vehiculos_x_contrato`
--

DROP PROCEDURE IF EXISTS `sp_listar_vehiculos_x_contrato`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
-- Definition of procedure `sp_registro_asigna_operador`
--

DROP PROCEDURE IF EXISTS `sp_registro_asigna_operador`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_asigna_operador`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_vehiculoph_i int,
in id_trabajador_i int
)
BEGIN


DECLARE n int;
DECLARE fecha timestamp;

set fecha = now();

SELECT count(*) into n FROM trabvehiculo
WHERE id_vehiculoph = id_vehiculoph_i
AND id_trabajador = id_trabajador_i
AND (estado = 'A');

if (n = 0) then

INSERT INTO trabvehiculo VALUES
(
  NULL,
  id_vehiculoph_i,
  id_trabajador_i,
  fecha,
  NULL
  );

CALL sp_regs(id_usuario_i,'ASIGNACION VEHICULO OPERADOR','trabvehiculo',ip,nav,so);

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_asigna_operario`
--

DROP PROCEDURE IF EXISTS `sp_registro_asigna_operario`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

  SET id_c = id;

  CALL sp_regs(id_usuario_i,concat('REGISTRO CLIENTE: ',UPPER(nombre_i)),'cliente',ip,nav,so);

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
in obra_i varchar(400),
in id_cliente_i int,
in f_inicio_i timestamp,
in f_fin_i timestamp,
in presupuesto_i decimal(10,2),
in detalle_i varchar(400),
in hora_min_i int,
out salida varchar(10)
)
BEGIN

DECLARE n int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

## n se puede realizar un contrato si la fecha y el cliente es el mismo
###################################
SELECT COUNT(id_contrato) INTO n FROM contrato
WHERE id_cliente = id_cliente_i AND f_inicio = timestamp(f_inicio_i);

CALL sp_registro_obra(id_usuario_i,ip,nav,so,obra_i,@id_obra);

if ( n = 0 AND @id_obra > 0 ) then

INSERT INTO contrato VALUES(
NULL,
@id_obra,
id_cliente_i,
f_inicio_i,
f_fin_i,
presupuesto_i,
UPPER(detalle_i),
hora_min_i,
DEFAULT
);

SELECT COUNT(id_contrato) INTO n FROM contrato
WHERE id_obra = @id_obra AND id_cliente = id_cliente_i AND timestamp(f_inicio) = timestamp(f_inicio_i);

if (n > 0) then

  COMMIT;

  set salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG CONTRATO','contrato',ip,nav,so);

else

  ROLLBACK;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
in vale_combustible_i varchar(10),
in ingreso_i char(2),
out salida varchar(10)
)
BEGIN

DECLARE id_v,id_t int;
DECLARE n int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

if (ingreso_i = 'MQ') then
  SELECT count(*) into n FROM detalleabastecimiento
  WHERE nro_guia = nro_guia_i OR vale_combustible = vale_combustible_i;

## abastecimeinto dario con guias de remision
## luego estas guias son agrupadas en solo id_abasteciemiento
## que se vincula a una factura o comprobante

  SELECT ifnull(id_vehiculo,0) into id_v FROM vehiculo v
  INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
  WHERE placa = nro_placa_i AND tv.nombre = 'SURTIDOR';
  ### ESTADO = G ==> RESERVADO

else

  SELECT count(*) into n FROM detalleabastecimiento
  WHERE vale_combustible = vale_combustible_i;

  SELECT ifnull(id_vehiculo,0) into id_v FROM vehiculo v
  WHERE placa = nro_placa_i;

end if;

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
UPPER(abastecedor_i),
vale_combustible_i,
UPPER(ingreso_i)
);

if (ingreso_i = 'MQ') then

  SELECT count(*) into n FROM detalleabastecimiento WHERE nro_guia = nro_guia_i;
else

  SELECT count(*) into n FROM detalleabastecimiento WHERE vale_combustible = vale_combustible_i;

end if;

if (n = 1) then

  COMMIT;

  set salida = 'OK';

  CALL sp_regs(id_usuario_i,concat('REG DETALLE ABASTECIMIENTO [',ingreso_i,']'),'detalleabastecimiento',ip,nav,so);

else

  ROLLBACK;

end if;

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_detalle_alquiler`
--

DROP PROCEDURE IF EXISTS `sp_registro_detalle_alquiler`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_detalle_alquiler`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50),
in id_contrato_i int,
in id_vehiculo_i int,
in id_articulo_i int,
in estado_i varchar(50),
in observacion_i varchar(200)
)
BEGIN

DECLARE id_tbl int;
DECLARE est char(1);

SET id_tbl = 0;


SELECT id_alquiler into id_tbl FROM alquiler
WHERE id_contrato = id_contrato_i AND substr(fecha,1,10) = curdate();




SELECT estado into est FROM vehiculo
WHERE id_vehiculo = id_vehiculo_i;


if (id_tbl = 0) then


INSERT INTO alquiler VALUES(
NULL,
id_contrato_i,
now()
);


SELECT id_alquiler into id_tbl FROM alquiler
WHERE id_contrato = id_contrato_i AND substr(fecha,1,10) = curdate();

if (est = 'A') then

	
	INSERT INTO detallealquiler VALUES(
	NULL,
	id_tbl,
	id_vehiculo_i,
	id_articulo_i,
	now(),
	UPPER(estado_i),
	UPPER(observacion_i)
	);

	
	
	
	
	
	UPDATE vehiculo SET estado = 'C' WHERE id_vehiculo = id_vehiculo_i;

end if;


else

if (est = 'A') then
	
	INSERT INTO detallealquiler VALUES(
	NULL,
	id_tbl,
	id_vehiculo_i,
	id_articulo_i,
	now(),
	UPPER(estado_i),
	UPPER(observacion_i)
	);

	
	
	
	
	
	UPDATE vehiculo SET estado = 'C' WHERE id_vehiculo = id_vehiculo_i;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
in precio_alq_i decimal(10,2),
out salida varchar(10)
)
BEGIN

DECLARE est char(1);
declare n int;
DECLARE precio_a decimal(10,2);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

######## se realiza el alquiler del vehiculo o articulo en el mismo ID_ALQUILER
###alquiler genera la relacion entre contrato y detalle_alquiler

SELECT a.estado into est FROM articulo a
WHERE a.id_articulo = id_articulo_i;

-- SELECT a.precio_alq into precio_a FROM articulo a WHERE a.id_articulo = id_articulo_i;

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
  precio_alq_i,
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

    COMMIT;

    set salida = 'OK';

    CALL sp_regs(id_usuario_i,'REGISTRO DE ALQUILER','detallealquiler,alquiler,articulo',ip,nav,so);

  else

    ROLLBACK;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
in precio_alq_i decimal(10,2),
out salida varchar(10)
)
BEGIN

DECLARE est char(1);
declare n int;
DECLARE precio_a decimal(10,2);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

######## se realiza el alquiler del vehiculo o articulo en el mismo ID_ALQUILER
###alquiler genera la relacion entre contrato y detalle_alquiler

SELECT v.estado into est FROM vehiculo v
WHERE v.id_vehiculo = id_vehiculo_i;


-- SELECT v.precio_alq into precio_a FROM vehiculo v WHERE v.id_vehiculo = id_vehiculo_i;

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
  precio_alq_i,
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

    COMMIT;

    SET salida = 'OK';

    CALL sp_regs(id_usuario_i,'REGISTRO DE ALQUILER','detallealquiler,alquiler,vehiculo',ip,nav,so);

  else

    ROLLBACK;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

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

  COMMIT;

  SET salida = 'OK';

  CALL sp_regs(id_usuario_i,'UPDATE','articulo,detallealquiler',ip,nav,so);

else

  ROLLBACK;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
-- SELECT ifnull(count(*),0) into n FROM transporte WHERE id_detallealquiler = id_detallealquiler_i;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;

END;

START TRANSACTION;

set n = 0;

if (n = 0) then


  INSERT INTO transporte VALUES(
  NULL,
  id_detallealquiler_i,
  upper(concepto_i),
  upper(observacion_i),
  fecha_i,
  monto_i
  );

--  SELECT count(*) into n FROM transporte WHERE id_detallealquiler = id_detallealquiler_i;

  COMMIT;

  set salida = 'OK';

end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_registro_mantenimiento`
--

DROP PROCEDURE IF EXISTS `sp_registro_mantenimiento`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

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

  COMMIT;


  set salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG NOTIFICACION','notificamant',ip,nav,so);

else

  ROLLBACK;

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
in nombre_i varchar(400),
out salida int
)
BEGIN

DECLARE n, id_obra_a int;
DECLARE fecha_a timestamp;

SET fecha_a = now();

SELECT count(id_obra) into n FROM obra WHERE nombre = upper(nombre_i);

if ( n = 0 ) then

  INSERT INTO obra VALUES
  (
  NULL,
  upper(nombre_i),
  fecha_a
  );

  SELECT id_obra into id_obra_a FROM obra WHERE nombre = upper(nombre_i) AND fecha = fecha_a;

  set salida = id_obra_a;

  CALL sp_regs(id_usuario_i,concat('REG OBRA: ',UPPER(nombre_i)),'obra',ip,nav,so);

else

  SELECT id_obra into id_obra_a FROM obra WHERE nombre = upper(nombre_i);

  set salida = id_obra_a;

  CALL sp_regs(id_usuario_i,concat('REG OBRA (Obra existente): ',UPPER(nombre_i)),'obra',ip,nav,so);

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
in valoriza_i char(2),
in hora_min_i decimal(10,2),
out salida varchar(10)
)
BEGIN
## 9,'::1','Firefox','Windows',2,'023944','sechura','superficie zzxy',30129,30239,110
DECLARE id_responsable_a int;
DECLARE id_operario_a int;

DECLARE n int;
DECLARE m int;
DECLARE id_v int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

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
min_i,
valoriza_i,
hora_min_i
);


SELECT ifnull(count(*),0) into n FROM controltrabajo
WHERE id_detallealquiler = id_detalle_i
AND id_operario = id_operario_a
AND nro_parte = UPPER(nro_parte_i);

if (n = 1) then


  UPDATE vehiculo SET horometro_ac = horom_fin_i
  WHERE id_vehiculo = id_v
  AND horometro_ac < horom_fin_i;

  COMMIT;

  SET salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG PARTE MAQUINARIA','controltrabajo',ip,nav,so);

else

  ROLLBACK;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_trabajador`(IN `id_usuario_i` INT, IN `ip` VARCHAR(16), IN `nav` VARCHAR(50), IN `so` VARCHAR(50), IN `apellidos_i` VARCHAR(50), IN `nombres_i` VARCHAR(50), IN `fecha_nac_i` DATE, IN `dni_i` VARCHAR(10), IN `ruc_i` VARCHAR(15), IN `telefono_i` VARCHAR(20), IN `id_tipo_u_i` INT, IN `id_tipotrabajador_i` INT, IN `nro_licencia_i` VARCHAR(15), OUT `salida` VARCHAR(10))
BEGIN

DECLARE n int;
DECLARE id_t int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

set n = 0;

SELECT count(id_trabajador) into n FROM trabajador
WHERE dni = dni_i
or concat(apellidos,nombres) = concat(apellidos_i,nombres_i);
-- or nro_licencia = nro_licencia_i;

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

    COMMIT;

    SET salida = @s;

  else

    ROLLBACK;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
IN `id_detallealquiler_i` INT
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
GROUP BY c.nro_parte
ORDER BY c.fecha, c.nro_parte;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_REP_rendimiento`
--

DROP PROCEDURE IF EXISTS `sp_REP_rendimiento`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
v.nombre as vehiculo,
cl.nombre as cliente,
CASE c.valoriza
WHEN 'HM' THEN SUM(c.hora_min)
WHEN 'HR' THEN SUM(c.total_h)
END
 as total_horas,
da.precio_alq,
ROUND(SUM(c.total_h) * da.precio_alq,2) as total

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
v.nombre) as concepto,
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
v.nombre as vehiculo,
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
da.precio_alq,
c.valoriza,
c.hora_min
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
v.nombre as vehiculo,
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
da.precio_alq
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
v.nombre as vehiculo,
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
da.precio_alq
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
IN `id_cliente_i` INT,
IN `desde` DATE,
IN `hasta` DATE,
IN `id_vehiculo_i` INT,
IN `id_obra_i` INT)
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
da.precio_alq,
c.valoriza,
c.hora_min
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

GROUP BY c.id_controltrabajo
ORDER BY c.fecha, c.nro_parte;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_group_vh_resumen`(IN `id_cliente_i` INT, IN `desde` DATE, IN `hasta` DATE, IN `id_vehiculo_i` INT)
BEGIN

SELECT
da.id_detallealquiler,
v.id_vehiculo,
v.nombre as vehiculo,
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
da.precio_alq,
c.tarea as labor,
c.valoriza,
c.hora_min
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

GROUP BY c.id_controltrabajo
ORDER BY c.fecha, c.nro_parte;
#GROUP BY c.nro_parte;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_sesion`
--

DROP PROCEDURE IF EXISTS `sp_sesion`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

CALL sp_regs(n,concat('INICIO SESION: ',usuario_i,'  ', @band),'usuario',ip_cli, nav_cli,so_cli);

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_valorizacion_cliente`
--

DROP PROCEDURE IF EXISTS `sp_valorizacion_cliente`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_valorizacion_cliente`(
in id_cliente_i int,
in desde date,
in hasta date
)
BEGIN

SELECT
da.id_detallealquiler,
v.id_vehiculo,
concat(
v.nombre,' ',
substr(m.nombre,1,3),
v.modelo,' ',
v.serie,' ') as vehiculo,
cl.nombre as cliente,
SUM(c.total_h) as total_horas,
v.precio_alq,
ROUND(SUM(c.total_h) * v.precio_alq,2) as total

FROM controltrabajo c
INNER JOIN trabvehiculo trab ON c.id_trabvehiculo = trab.id_trabvehiculo

INNER JOIN detallealquiler da ON trab.id_detallealquiler = da.id_detallealquiler
INNER JOIN vehiculo v ON da.id_vehiculo = v.id_vehiculo
INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = v.id_tipovehiculo
INNER JOIN marca m ON v.id_marca = m.id_marca

#INNER JOIN trabajador t ON trab.id_trabajador = t.id_trabajador

INNER JOIN contrato ct ON da.id_contrato = ct.id_contrato
INNER JOIN cliente cl ON ct.id_cliente = cl.id_cliente

#condicion WHERE fechas and CLIENTE
WHERE cl.id_cliente = id_cliente_i AND
(da.fecha BETWEEN desde AND hasta)

GROUP BY da.id_detallealquiler;
#GROUP BY c.nro_parte;



END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_vehiculo_asignacion_op`
--

DROP PROCEDURE IF EXISTS `sp_vehiculo_asignacion_op`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
