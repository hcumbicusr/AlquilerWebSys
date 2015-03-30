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

END $$