<?php
include '../Config.inc.php';
if (empty($_POST))
{ ?>
<script>
    setInterval(window.location.href = '../',0);
</script>
<?php }

$id_cliente = $_POST['cliente'];

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
session_start();
   
$query = "SELECT c.id_cliente,  t.nombre as tipocliente,c.codigo,c.nombre,c.direccion,
c.telefono,c.estado,c.f_registro, count(cn.id_contrato) as nro_contratos
FROM cliente c
INNER JOIN tipocliente t ON c.id_tipocliente = t.id_tipocliente
LEFT JOIN contrato cn ON c.id_cliente = cn.id_cliente

WHERE c.id_cliente = $id_cliente
GROUP BY c.id_cliente";

$result = $objDB->selectManager()->select($con, $query);
echo json_encode($result);