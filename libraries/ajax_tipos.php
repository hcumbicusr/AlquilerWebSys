<?php
include '../Config.inc.php';
include '../configuration/Funciones.php';

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();

$input = $_GET['nombre'];

$result = $objDB->selectManager()->spSelect($con, "sp_listar_tipos","'$input'");

$datos = array();

//die(var_dump($result));

if (!$result)
{
    echo 0;
}else 
{
    for ($i = 0; $i < count($result); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>        
        <td><?php echo $result[$i]['nombre']; ?></td>
        <td>
            <a class="btn btn-primary" href="adm_edit_tipos.php?tipo=<?php echo Funciones::encodeStrings($_GET['nombre'], 2); ?>&id=<?php echo Funciones::encodeStrings($result[$i]['id'], 2); ?>">Editar</a>
        </td>
    </tr>
     
   <?php }
}

//die (var_dump($result) );