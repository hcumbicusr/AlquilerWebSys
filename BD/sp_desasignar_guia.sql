--
-- Definition of procedure `sp_desasignar_guia`
--

DROP PROCEDURE IF EXISTS `sp_desasignar_guia`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION' */ $$
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