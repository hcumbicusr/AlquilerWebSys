<?php
include '../Config.inc.php';
if (empty($_POST))
{ ?>
<script>
    setInterval(window.location.href = '../',0);
</script>
<?php }

$event = $_POST['event'];

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
session_start();

switch ($event) {
    case 'nombre':
        @list($apel,$nom) = explode(",", $_POST['nombre']);
        $nombre = trim($apel).trim($nom);        
        $query = "SELECT count(id_trabajador) as n FROM trabajador WHERE concat(apellidos,nombres) = '$nombre'";        
        $result = $objDB->selectManager()->select($con, $query);        
        echo intval($result[0]['n']);              
        break; 
    
    case 'guia':
        $guia = $_POST['nombre'];        
        $query = "SELECT count(*) as n FROM detalleabastecimiento WHERE nro_guia = '$guia'";
        $result = $objDB->selectManager()->select($con, $query);
        echo intval($result[0]['n']);
        break;
    case 'guia2':
        $guia = $_POST['nombre'];   
        if (empty(trim($guia)))
        {
            $guia = 'X';
        }
        $query = "SELECT count(*) as n FROM detalleabastecimiento WHERE nro_guia = '$guia'";
        $result = $objDB->selectManager()->select($con, $query);
        if (empty(trim($_POST['nombre'])))
        {
            echo 2;
        }else
        {
            echo intval($result[0]['n']);
        }        
        break;
    case 'placa':
        $placa = $_POST['nombre'];        
        $query = "SELECT count(*) as n FROM vehiculo WHERE id_tipovehiculo = 5 AND placa = '$placa'";        
        $result = $objDB->selectManager()->select($con, $query);
        echo intval($result[0]['n']);
        break;
    case 'licencia':
        $licencia = $_POST['nombre'];  
        if (empty(trim($licencia)))
        {
            $licencia = 'X';
        }
        $query = "SELECT count(*) as n FROM trabajador WHERE nro_licencia = '$licencia'";
        $result = $objDB->selectManager()->select($con, $query);
        echo intval($result[0]['n']);
        break;
  case 'comprobante':
        $comprob = $_POST['nombre'];  
        if (empty(trim($comprob)))
        {
            $comprob = 'X';
        }
        $query = "SELECT count(*) as n FROM abastecimiento WHERE nro_comprobante = '$comprob'";
        $result = $objDB->selectManager()->select($con, $query);
        if (empty(trim($_POST['nombre'])))
        {
            echo 2;
        }else
        {
            echo intval($result[0]['n']);
        } 
        break;
}