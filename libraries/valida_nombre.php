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
        $guia = str_replace(' ','',$_POST['nombre']);        
        $query = "SELECT count(*) as n FROM detalleabastecimiento WHERE nro_guia = '$guia'";
        $result = $objDB->selectManager()->select($con, $query);
        echo intval($result[0]['n']);
        break;
    case 'guia2':
        $guia = str_replace(' ','',$_POST['nombre']);        
        if (empty($guia) || $guia == '' || $guia == ' ')
        {
            $guia = 'X';
        }
        $query = "SELECT count(*) as n FROM detalleabastecimiento WHERE nro_guia = '$guia'";
        //echo $query; die();
        $result = $objDB->selectManager()->select($con, $query);
        
        if ($guia == 'X')
        {
            echo 2;
        }else
        {
            echo intval($result[0]['n']);
        }        
        break;
    case 'placa':
        $placa = str_replace(' ','',$_POST['nombre']);        
        $query = "SELECT count(*) as n FROM vehiculo WHERE id_tipovehiculo = 5 AND placa = '$placa'";        
        $result = $objDB->selectManager()->select($con, $query);
        echo intval($result[0]['n']);
        break;
    case 'licencia':
        $licencia = str_replace(' ','',$_POST['nombre']);        
        if (empty($licencia) || $licencia == '' || $licencia == ' ')
        {
            $licencia = 'X';
        }
        $query = "SELECT count(*) as n FROM trabajador WHERE nro_licencia = '$licencia'";
        $result = $objDB->selectManager()->select($con, $query);
        echo intval($result[0]['n']);
        break;
  case 'comprobante':
        $comprob = str_replace(' ','',$_POST['nombre']);        
        if (empty($comprob) || $comprob == '' || $comprob == ' ')
        {
            $comprob = 'X';
        }
        $query = "SELECT count(*) as n FROM abastecimiento WHERE nro_comprobante = '$comprob'";
        $result = $objDB->selectManager()->select($con, $query);
        if ($comprob == 'X')
        {
            echo 2;
        }else
        {
            echo intval($result[0]['n']);
        } 
        break;
    case 'parte': //valida si exite el parte diario
        $parte = str_replace(' ','',$_POST['nombre']);        
        $query = "SELECT count(*) as n FROM controltrabajo WHERE nro_parte = '$parte'";        
        $result = $objDB->selectManager()->select($con, $query);
        echo intval($result[0]['n']);
        break;
    case 'vale': //valida si exite el vale de consumo del vehiculo
        $vale = str_replace(' ','',$_POST['nombre']);        
        $query = "SELECT count(*) as n FROM consumo WHERE nro_vale = '$vale'";        
        $result = $objDB->selectManager()->select($con, $query);
        echo intval($result[0]['n']);
        break;
    case 'trabajador': //valida si exite el trabajador DNI
        $dni = str_replace(' ','',$_POST['nombre']);        
        $query = "SELECT count(*) as n FROM trabajador WHERE dni = '$dni'";        
        $result = $objDB->selectManager()->select($con, $query);
        echo intval($result[0]['n']);
        break;
    
    case 'vale_comb': //valida si exite el vale_combustible
        $vale = str_replace(' ','',$_POST['vale_comb']);        
        if (empty($vale) || $vale == '' || $vale == ' ')
        {
            $vale = 'X';
        }
        $query = "SELECT count(*) as n FROM detalleabastecimiento WHERE vale_combustible = '$vale'";
        //echo $query; die();
        $result = $objDB->selectManager()->select($con, $query);
        
        if ($vale == 'X')
        {
            echo 2;
        }else
        {
            echo intval($result[0]['n']);
        }
        break;
        
   case 'placa_v': //valida placa vehiculo
        $placa = str_replace(' ','',$_POST['nombre']);        
        if (empty($placa) || $placa == '' || $placa == ' ')
        {
            $placa = 'X';
        }
        $query = "SELECT count(*) as n FROM vehiculo WHERE placa = '$placa'";
        //echo $query; die();
        $result = $objDB->selectManager()->select($con, $query);
        
        if ($placa == 'X')
        {
            echo 2;
        }else
        {
            echo intval($result[0]['n']);
        }
        break;
}