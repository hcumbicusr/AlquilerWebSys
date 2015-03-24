<?php
include '../Config.inc.php';
if (empty($_POST))
{ ?>
<script>
    setInterval(window.location.href = '../',0);
</script>
<?php }

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();

$nro_comprobante = $_POST['comprobante'];

$query = "SELECT count(*) as n FROM abastecimiento a WHERE nro_comprobante = '$nro_comprobante';";

$result = $objDB->selectManager()->select($con, $query);

echo $result[0]['n'];