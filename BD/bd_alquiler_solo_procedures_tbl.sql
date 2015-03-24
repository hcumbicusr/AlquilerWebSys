-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-03-2015 a las 11:56:56
-- Versión del servidor: 5.6.16
-- Versión de PHP: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `bd_alquiler`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_anular_alquiler_vehiculo`;

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_anular_alquiler_vehiculo`(
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

end if;

END$$

DROP PROCEDURE IF EXISTS `sp_asignar_guias_fechas`;

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_asignar_guias_fechas`(
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

set salida = n;

CALL sp_regs(id_usuario_i,concat('ASIGNA:GUIAS->COMPROBANTE[',comprobante,']'),'detalleabastecimiento,abastecimiento',ip,nav,so);

else

set salida = 0;

end if;

END$$

DROP PROCEDURE IF EXISTS `sp_cierre_sesion`;

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_cierre_sesion`(
in id_usuario_i int,
in ip varchar(16),
in nav varchar(50),
in so varchar(50)
)
BEGIN

UPDATE usuario SET f_cierre_sesion = now() WHERE id_usuario = id_usuario_i;

CALL sp_regs(id_usuario_i,concat('CIERRE SESION USER ID: ',id_usuario_i),'notificamant',ip,nav,so);

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_combo`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_crear_usuario`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_datos_contrato`(
in id_contrato_i int
)
BEGIN

SELECT c.codigo, c.nombre as cliente, o.nombre as obra
FROM contrato cn
INNER JOIN cliente c ON cn.id_cliente = c.id_cliente
INNER JOIN obra o ON cn.id_obra = o.id_obra
WHERE id_contrato = id_contrato_i;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_datos_contrato_x_alquiler`(
in id_contrato_i int
)
BEGIN

##### alquiler = contrato /// para no modificar backend PHP

SELECT c.codigo, c.nombre as cliente, o.nombre as obra
FROM contrato cn
INNER JOIN cliente c ON cn.id_cliente = c.id_cliente
INNER JOIN obra o ON cn.id_obra = o.id_obra
WHERE id_contrato = id_contrato_i;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_datos_cuenta_banco_empresa`()
BEGIN

SELECT
e.`razon_social` as banco,
e.`nombre` as descripcion,
e.`descripcion` as cuenta
FROM empresa e
WHERE ref_codigo <> '0' AND ref_codigo = 'P0001';

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_datos_notificaciones`(

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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_datos_vehiculo`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_datos_vehiculo_v`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_desasignar_guia`(
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

SELECT id_abastecimiento into id_abast FROM detalleabastecimiento WHERE id_detalleabastecimiento = id_det_abast_i;
SELECT cantidad into cantidad_g FROM detalleabastecimiento WHERE id_detalleabastecimiento = id_det_abast_i;

UPDATE detalleabastecimiento SET id_abastecimiento = 0 WHERE id_detalleabastecimiento = id_det_abast_i;

UPDATE abastecimiento SET cantidad_guia = (cantidad_guia - cantidad_g) WHERE id_abastecimiento = id_abast;

set salida = 'OK';

CALL sp_regs(id_usuario_i,'DESASIGNA GUIA','detalleabastecimeinto,abastecimiento',ip,nav,so);


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_abastecimiento`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_articulo`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_cliente`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_contrato`(
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



END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_control_combustible`(
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

set salida = 'OK';

CALL sp_regs(id_usuario_i,concat('EDITAR CONSUMO: ',id_consumo_i),'consumo,detalleabastecimiento',ip,nav,so);

end if; -- fin igualdad


end if;  -- si el operario existe

else -- parte para vale

  set  salida = 'PARTE';

end if; -- exite parte para vale

end if; -- si existe el nuevo nro guia


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_detalle_abastecimiento`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_obra`(
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




END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_parte_maquinaria`(
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

  SET salida = 'OK';

CALL sp_regs(id_usuario_i,concat('EDITAR PARTE MAQUINARIA: ',id_parted),'controltrabajo',ip,nav,so);

end if;


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_tipo`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_trabajador`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_editar_vehiculo`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_alquiler_articulos`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_alquiler_vehiculos`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_articulos`()
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_articulo_ID`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_cliente`()
BEGIN

SELECT c.id_cliente,  t.nombre as tipocliente,c.codigo,c.nombre,c.direccion,c.telefono,c.estado,c.f_registro
FROM cliente c
INNER JOIN tipocliente t ON c.id_tipocliente = t.id_tipocliente
ORDER BY c.f_registro desc, nombre asc;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_clientes_con_alquiler`()
BEGIN

SELECT c.*,o.nombre as obra,t.nombre as tipoobra,con.id_contrato,con.f_inicio,con.f_fin
FROM cliente c
INNER JOIN contrato con ON c.id_cliente = con.id_cliente
INNER JOIN obra o ON con.id_obra = o.id_obra
INNER JOIN tipoobra t ON o.id_tipoobra = t.id_tipoobra
INNER JOIN detallealquiler da ON con.id_contrato = da.id_contrato
WHERE con.estado = 'A'

GROUP BY con.id_contrato
ORDER BY con.id_contrato DESC;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_cliente_contrato`()
BEGIN
-- valorizacion: noimporta la obra
-- el calculo se hace entre fechas sin importar la obra que se haya ejecutado
SELECT distinct(c.id_cliente), t.nombre as tipocliente,c.codigo,
c.nombre,c.direccion,c.telefono,c.estado,c.f_registro
FROM cliente c
INNER JOIN tipocliente t ON c.id_tipocliente = t.id_tipocliente
INNER JOIN contrato con ON c.id_cliente = con.id_cliente
ORDER BY c.f_registro desc, nombre asc;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_cliente_ID`(
in id_cliente_i int
)
BEGIN


SELECT c.id_cliente, t.id_tipocliente, t.nombre as tipocliente,c.codigo,c.nombre,c.direccion,c.telefono,c.estado,c.f_registro
FROM cliente c
INNER JOIN tipocliente t ON c.id_tipocliente = t.id_tipocliente

WHERE id_cliente = id_cliente_i;


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_comprobantes`()
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_comprobante_ID`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_contrato`()
BEGIN

SELECT c.id_contrato,o.nombre as obra,cl.nombre as cliente,c.f_inicio,c.f_fin,
c.presupuesto,c.detalle,es.nombre as estado,da.id_detallealquiler
FROM contrato c
INNER JOIN obra o ON c.id_obra = o.id_obra
INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente
INNER JOIN estado es ON c.estado = es.id_estado

LEFT JOIN detallealquiler da ON c.id_contrato = da.id_contrato

GROUP BY c.id_contrato
ORDER BY c.id_contrato DESC;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_contrato_ID`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_guias`()
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_guias_sin_asignar`()
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_guia_ID`(
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



END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_mantenimientos`(
in id_vehiculo_i int
)
BEGIN

SELECT * FROM mantenimiento m
WHERE id_vehiculo = id_vehiculo_i;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_obras`()
BEGIN

SELECT o.id_obra,t.nombre as tipoobra,o.nombre as obra,o.fecha, e.nombre as estado
FROM obra o
INNER JOIN tipoobra t ON t.id_tipoobra = o.id_tipoobra
INNER JOIN estado e ON e.id_estado = o.estado;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_obra_ID`(
in id_obra_i int
)
BEGIN

SELECT o.id_obra, t.id_tipoobra, t.nombre as tipoobra,o.nombre as obra,o.fecha, e.nombre as estado
FROM obra o
INNER JOIN tipoobra t ON t.id_tipoobra = o.id_tipoobra
INNER JOIN estado e ON e.id_estado = o.estado
WHERE id_obra  = id_obra_i;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_operario_x_vehiculo`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_registro_consumo`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_registro_consumo_ID`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_registro_parted`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_registro_parted_ID`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_tipos`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_tipos_ID`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_todo_alquiler_activo_x_contrato`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_trabajadores`(

)
BEGIN

SELECT t.id_trabajador,t.apellidos, t.nombres, t.fecha_nac, t.dni,t.ruc,t.telefono,t.nro_licencia,t.estado,
u.nombre as usuario, tu.nombre as tipo,u.f_registro,u.f_cierre_sesion,u.cambio_clave
FROM trabajador t
INNER JOIN usuario u ON t.id_trabajador = u.id_trabajador
INNER JOIN tipousuario tu ON u.id_tipousuario = tu.id_tipousuario
ORDER BY t.apellidos asc, t.nombres asc;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_trabajador_ID`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_vehiculos`()
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_vehiculos_trabajando`()
BEGIN

SELECT v.* FROM vehiculo v
INNER JOIN detallealquiler da ON v.id_vehiculo = da.id_vehiculo
INNER JOIN trabvehiculo tv ON da.id_detallealquiler = tv.id_detallealquiler
WHERE v.estado = 'C';

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_vehiculos_x_contrato`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_listar_vehiculo_ID`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_abastecimiento`(
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

  set salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG abastecimiento combustible','abastecimiento',ip,nav,so);

end if;

end if;


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_articulos`(
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

		CALL sp_regs(id_usuario_i,'REG ARTICULOS','articulo',ip,nav,so);

		set salida = 'OK';

	end if;

end if;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_asigna_operario`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_cliente`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_contrato`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_control_combustible`(
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

  set salida = 'OK';

  CALL sp_regs(id_usuario_i,'REG CONSUMO DE COMBUSTUBLE','consumo,detalleabastecimiento',ip,nav,so);

end if;

else
  ## la cantidad excede al total de la guia
  set salida = CONCAT('NO:',st-cant_combustible_i);

end if; ### fin condicion de cantidades

end if; ## nro_vale

else -- parte para vale

  set salida = 'PARTE';

end if; -- existe parte para vale

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_detalle_abastecimiento`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_detalle_alquiler_ar`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_detalle_alquiler_v`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_devolucion_articulo`(
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

  CALL sp_regs(id_usuario_i,'REG DEVOL VARTICULO','devolucion',ip,nav,so);

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
END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_devolucion_vehiculo`(
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

SELECT ifnull(count(*),0) into n FROM devolucion
WHERE id_detallealquiler = id_detallealquiler_i;

SELECT ifnull(count(*),0) into m FROM detallealquiler
WHERE id_detallealquiler = id_detallealquiler_i AND id_vehiculo <> 0;

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


end if; ## n= 1

end if; ## n = 0

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_flete`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_mantenimiento`(
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

end if;

end if;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_notifica_mant`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_obra`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_parte_maquinaria`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_tipo`(
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
WHEN 'TRABAJADOR' THEN INSERT INTO tipotrabajador VALUES(NULL, UPPER(nombre_i));
WHEN 'USUARIO' THEN INSERT INTO tipousuario VALUES(NULL, UPPER(nombre_i));
WHEN 'VEHICULO' THEN INSERT INTO tipovehiculo VALUES(NULL,UPPER(nombre_i), estado_i);
WHEN 'MARCA' THEN INSERT INTO marca VALUES(NULL, UPPER(nombre_i),estado_i);
END CASE;

set salida = 'OK';

CALL sp_regs(id_usuario_i,concat('REGISTRO TIPO: ',UPPER(nombre_i)),tabla_i,ip,nav,so);

-- WHEN '' THEN INSERT INTO VALUES(NULL,);

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_trabajador`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_registro_vehiculos`(
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

		CALL sp_regs(id_usuario_i,'REG VEHICULOS','vehiculo, vehiculoph',ip,nav,so);

		set salida = 'OK';

	end if;

end if;

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_regs`(
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_REP_consumo_detal`(
in id_detallealquiler_i int
)
BEGIN

-- con tabla controltrabajo ... partes
SELECT
cl.nombre as cliente,
o.nombre as obra,
concat( substr(v.nombre,1,7),' ',substr(m.nombre,1,3),' [',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as vehiculo,
concat(t.apellidos,', ',t.nombres) as operario,
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

END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_REP_rendimiento`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_REP_valorizacion_cliente`(
in id_cliente_i int,
in desde date,
in hasta date
)
BEGIN

SELECT
da.id_detallealquiler,
v.id_vehiculo,
concat(
v.nombre,' [ ',
substr(m.nombre,1,3),' ',
v.modelo,' ',
v.serie,' ]') as vehiculo,
cl.nombre as cliente,
SUM(c.total_h) as total_horas,
v.precio_alq,
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
(da.fecha BETWEEN desde AND hasta)

GROUP BY da.id_detallealquiler;
#GROUP BY c.nro_parte;



END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_REP_valorizacion_cliente_flete`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_sesion`(
in usuario_i varchar(30),
in clave_i varchar(40),
in ip_cli varchar(16),
in nav_cli varchar(50),
in so_cli varchar(50)
)
BEGIN

DECLARE n INT;

set n = 0;

SELECT u.id_usuario, u.nombre, tu.nombre as tipo,f_ultimo_acceso,
t.apellidos, t.nombres, t.fecha_nac, t.dni
FROM usuario u
INNER JOIN trabajador t ON u.id_trabajador = t.id_trabajador
INNER JOIN tipousuario tu ON u.id_tipousuario = tu.id_tipousuario
WHERE u.estado = 'A' AND t.estado = 'A' AND (u.nombre = usuario_i OR t.dni = usuario_i)
AND u.clave = clave_i AND tu.nombre <> 'OPERARIO';
##### los operarios no tienen acceso al sistema

SELECT u.id_usuario into n
FROM usuario u
INNER JOIN trabajador t ON u.id_trabajador = t.id_trabajador
INNER JOIN tipousuario tu ON u.id_tipousuario = tu.id_tipousuario
WHERE u.estado = 'A' AND t.estado = 'A' AND (u.nombre = usuario_i OR t.dni = usuario_i)
AND u.clave = clave_i AND tu.nombre <> 'OPERARIO';

UPDATE usuario SET f_ultimo_acceso = now() WHERE id_usuario = n;

if (n > 0) then
  CALL sp_regs(n,'INICION SESION','usuario',ip_cli, nav_cli,so_cli);
end if;


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_vehiculo_asignacion_op`(
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


END$$

CREATE DEFINER=`diverc0l`@`localhost` PROCEDURE `sp_vehiculo_trabajador_asig`(
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

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mantenimiento`
--

CREATE TABLE IF NOT EXISTS `mantenimiento` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `mantenimiento`
--

INSERT INTO `mantenimiento` (`id_mantenimiento`, `id_vehiculo`, `causa`, `descripcion`, `lugar_averia`, `lugar_mant`, `horometro`, `kilometraje`, `f_ingreso`, `f_salida`, `estado_actual`, `costo`) VALUES
(1, 6, 'MANTENIMIENTO MENSUAL', 'MANTENIMIENTO PREVENTIVO', '', 'MECÁNICA XY', '4000.00', '0.00', '2014-12-01', '2014-12-02', 'MUY BIEN', '0.00'),
(2, 34, 'EJEMPLO', 'EJEMPLO', 'EJEMPLO', 'EJEMPLO', '2300.00', '3490.00', '2014-12-31', '2014-12-31', 'BIEN', '0.00'),
(3, 4, 'MOTIVO DE PRUEBA PARA MANTENINIENTO', '', '', 'HUACA DE LA CRUZ', '2863.70', '0.00', '2014-12-10', '2014-12-10', 'REPARADO', '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partemant`
--

CREATE TABLE IF NOT EXISTS `partemant` (
  `id_partemant` int(11) NOT NULL AUTO_INCREMENT,
  `id_controltrabajo` int(11) NOT NULL,
  `id_mantenimiento` int(11) NOT NULL,
  `fecha_reg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_partemant`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `partemant`
--

INSERT INTO `partemant` (`id_partemant`, `id_controltrabajo`, `id_mantenimiento`, `fecha_reg`) VALUES
(1, 11, 3, '2015-03-23 05:38:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partevale`
--

CREATE TABLE IF NOT EXISTS `partevale` (
  `id_partevale` int(11) NOT NULL AUTO_INCREMENT,
  `id_controltrabajo` int(11) NOT NULL,
  `id_consumo` int(11) NOT NULL,
  `fechar_reg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_partevale`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipocliente`
--

CREATE TABLE IF NOT EXISTS `tipocliente` (
  `id_tipocliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipocliente`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `tipocliente`
--

INSERT INTO `tipocliente` (`id_tipocliente`, `nombre`, `estado`) VALUES
(1, 'TIPO CLIENTE A', 'A'),
(2, 'TIPO CLIENTE B', 'A'),
(3, 'TIPO CLIENTE C', 'A'),
(4, 'CLIENTE STANDARD', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoobra`
--

CREATE TABLE IF NOT EXISTS `tipoobra` (
  `id_tipoobra` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id_tipoobra`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `tipoobra`
--

INSERT INTO `tipoobra` (`id_tipoobra`, `nombre`, `estado`) VALUES
(1, 'TIPO OBRA A', 'A'),
(2, 'TIPO OBRA B', 'A'),
(3, 'OBRA STANDARD', 'A');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
