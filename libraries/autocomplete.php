<?php
//include '../Config.inc.php';

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
// solo operarios
$query = "SELECT concat(apellidos,', ',nombres) as trabajador FROM trabajador WHERE id_tipotrabajador = 1 ORDER BY apellidos, nombres";

$result = $objDB->selectManager()->select($con, $query);
//echo "".count($result);

$arreglo = array();

if (count($result) == 0)
{
    array_push($arreglo, "No hay datos");    
}else {
    for ($i = 0; $i < count($result); $i++) {
        array_push($arreglo, $result[$i]['trabajador']);
    }
}