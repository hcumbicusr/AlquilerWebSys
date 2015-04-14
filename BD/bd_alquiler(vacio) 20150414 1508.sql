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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cliente`
--

/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `consumo`
--

/*!40000 ALTER TABLE `consumo` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `contrato`
--

/*!40000 ALTER TABLE `contrato` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `controltrabajo`
--

/*!40000 ALTER TABLE `controltrabajo` DISABLE KEYS */;
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
  PRIMARY KEY (`id_detalleabastecimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detalleabastecimiento`
--

/*!40000 ALTER TABLE `detalleabastecimiento` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detallealquiler`
--

/*!40000 ALTER TABLE `detallealquiler` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `devolucion`
--

/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
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
 (1,1,1,'250.00','10.00','H','REQUIERE CAMBIO DE ACEITE','2015-02-20 15:45:17','A'),
 (2,2,5,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-20 15:45:17','A'),
 (3,2,6,'10000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-20 15:45:17','A'),
 (4,4,1,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-20 15:45:17','A'),
 (5,4,2,'5000.00','10.00','KM','REQUIERE NANTENIMIENTO','2015-02-20 15:45:17','A'),
 (6,4,3,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:12:00','A'),
 (7,4,4,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:14:57','A'),
 (8,4,5,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:14:57','A'),
 (9,4,6,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:14:57','A'),
 (10,4,7,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:14:57','A'),
 (11,4,8,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:14:57','A'),
 (12,4,9,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:14:57','A'),
 (13,1,1,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:16:52','A'),
 (14,3,2,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:16:52','A'),
 (15,3,3,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:16:52','A'),
 (16,3,4,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:16:52','A'),
 (17,3,5,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:16:52','A'),
 (18,3,6,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:16:52','A'),
 (19,3,7,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:16:52','A'),
 (20,3,8,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:16:52','A'),
 (21,3,9,'5000.00','10.00','KM','REQUIERE MANTENIMIENTO','2015-02-21 04:16:52','A'),
 (22,1,2,'5000.00','10.00','H','REQUIERE MANTENIMIENTO','2015-03-03 04:03:55','A');
/*!40000 ALTER TABLE `notificamant` ENABLE KEYS */;


--
-- Definition of table `obra`
--

DROP TABLE IF EXISTS `obra`;
CREATE TABLE `obra` (
  `id_obra` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipoobra` int(11) NOT NULL,
  `nombre` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_obra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `obra`
--

/*!40000 ALTER TABLE `obra` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partevale`
--

/*!40000 ALTER TABLE `partevale` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `regs`
--

/*!40000 ALTER TABLE `regs` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipotrabajador`
--

/*!40000 ALTER TABLE `tipotrabajador` DISABLE KEYS */;
INSERT INTO `tipotrabajador` (`id_tipotrabajador`,`nombre`,`estado`) VALUES 
 (1,'OPERADOR','A'),
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
 (1,'OPERADOR','A'),
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trabajador`
--

/*!40000 ALTER TABLE `trabajador` DISABLE KEYS */;
INSERT INTO `trabajador` (`id_trabajador`,`id_tipotrabajador`,`apellidos`,`nombres`,`fecha_nac`,`dni`,`ruc`,`telefono`,`nro_licencia`,`estado`) VALUES 
 (1,0,'ADMIN','ADMIN','0000-00-00','00000000','0000000000','000000000','00000000','A');
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transporte`
--

/*!40000 ALTER TABLE `transporte` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `usuario`
--

/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id_usuario`,`id_trabajador`,`id_tipousuario`,`nombre`,`clave`,`estado`,`f_registro`,`f_modificacion`,`f_ultimo_acceso`,`f_cierre_sesion`,`cambio_clave`) VALUES 
 (1,1,3,'admin','e10adc3949ba59abbe56e057f20f883e','A','2015-02-08 17:43:51','2015-03-09 02:40:06','2015-04-14 15:05:36','2015-04-14 15:06:09',1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `vehiculo`
--

/*!40000 ALTER TABLE `vehiculo` DISABLE KEYS */;
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_finalizar_contrato`(IN `id_usuario_i` INT, IN `ip` VARCHAR(16), IN `nav` VARCHAR(50), IN `so` VARCHAR(50), IN `id_contrato_i` INT, IN `presupuesto_i` DECIMAL(10,2), IN `observacion_i` VARCHAR(400), IN `fecha_fin_i` TIMESTAMP, OUT `salida` VARCHAR(10))
    DETERMINISTIC
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
UPDATE obra SET estado = 'B' WHERE id_obra = @obra;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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
-- Definition of procedure `sp_listar_guias_fechas`
--

DROP PROCEDURE IF EXISTS `sp_listar_guias_fechas`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_guias_fechas`(
in f_desde date,
in f_hasta date
)
BEGIN

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
con.fecha as fecha_abast,
concat( vh.`nombre`,'[',ifnull(vh.modelo,''),'][',ifnull(vh.serie,''),'][',ifnull(vh.placa,''),']' ) as vehiculo,
con.nro_vale,
con.cant_combustible,
con.horometro,
concat(tr.apellidos,', ',tr.nombres) as operario,
d.`stock`,

ifnull(a.`nro_comprobante`,'SIN ASIGNAR') as estado_g,

c.`nombre` as tipocombustible,
concat(v.nombre,' /MOD: ',ifnull(v.modelo,''),' /SERIE: ',ifnull(v.serie,''),' /PLACA: ',ifnull(v.placa,'')) as vehiculo_surt,
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

WHERE date(d.fecha) BETWEEN f_desde AND f_hasta
ORDER BY d.fecha ASC, d.id_detalleabastecimiento ASC;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sp_listar_guias_sin_asignar`
--

DROP PROCEDURE IF EXISTS `sp_listar_guias_sin_asignar`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

SELECT count(*) into n FROM detalleabastecimiento WHERE nro_guia = nro_guia_i;

## abastecimeinto dario con guias de remision
## luego estas guias son agrupadas en solo id_abasteciemiento
## que se vincula a una factura o comprobante

SELECT ifnull(id_vehiculo,0) into id_v FROM vehiculo v
INNER JOIN tipovehiculo tv ON v.id_tipovehiculo = tv.id_tipovehiculo
WHERE placa = nro_placa_i AND tv.nombre = 'SURTIDOR';
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

  COMMIT;

  set salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG DETALLE ABASTECIMIENTO','detalleabastecimiento',ip,nav,so);

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  ROLLBACK;
END;

START TRANSACTION;

set n = 0;

SELECT count(id_trabajador) into n FROM trabajador
WHERE dni = dni_i
or concat(apellidos,nombres) = concat(apellidos_i,nombres_i)
or nro_licencia = nro_licencia_i;

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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_consumo_detal`(IN `id_detallealquiler_i` INT)
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_group_vehiculo_obra`(IN `id_cliente_i` INT, IN `desde` DATE, IN `hasta` DATE, IN `id_vehiculo_i` INT, IN `id_obra_i` INT)
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

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_REP_valorizacion_group_vh_resumen`(IN `id_cliente_i` INT, IN `desde` DATE, IN `hasta` DATE, IN `id_vehiculo_i` INT)
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
c.tarea as labor
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
