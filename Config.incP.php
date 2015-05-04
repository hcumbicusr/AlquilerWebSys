<?php
/**
 * Este archivo contiene las variables de configuracion de la aplicacion
 * @package ucvBiblioteca
 * @subpackage application
*/
header('Content-Type: text/html; charset=UTF-8');
//error_reporting(E_ERROR);
ini_set("display_errors", false);
error_reporting(0);
//seteo la fecha segun la region
date_default_timezone_set('America/Lima');

/**
*@var name
*/
$config['titleApplication']="Sistema Web de Alquiler de Maquinarias";
/**
*@var name
*/
$config['nameApplication']="AlquilerWebSys";
/**
 * @var email
 */
$config['emailDeveloper']="hcumbicusr@gmail.com";
/**
 * @var host ruta completa
 */
$config['host']=$_SERVER['HTTP_HOST'];
/**
 * @var path ruta raiz directorio
 */
$config['path']=$_SERVER["DOCUMENT_ROOT"]."/".$config['nameApplication'];
/**
 * @var hostname
 */
$config['hostnameDataBase']="localhost";
//$config['hostnameDataBase']="www.divercole.com";
/**
 * @var name database
 */
// $config['nameDataBase']="diverc0l_alquiler";
$config['nameDataBase']="bd_alquiler";
/**
 * @var user
 */
// $config['userDataBase']="diverc0l_admin";
$config['userDataBase']="alquilerpiuramaq";
/**
 * @var password
 */
// $config['passwordDataBase']="@hcumbicusr123";
$config['passwordDataBase']="Alquiler2015";
/**
 * @var management
 */
$config['managerDataBase']="mysqli";
/**
 * @var typeUserAdmin
 */
$config['typeUserAdmin']='ADMINISTRADOR';

/**
 * @var typeUserOper
 */
$config['typeUserOper']='OPERARIO';

/**
 * @var typeUserContr
 */
$config['typeUserContr']='CONTROLADOR';

/**
 * @var sessionTime in seg
 */
$config['sessionTime']= 2400;
/**
 * @var entorno : 1-> Desarrollo; 2-> Produccion
 */
$config['entorno']= 2;
/**
 * @var IGV
 */
$config['igv']= 18; // 18%

/**
 * @var DETRACCION
 */
$config['detraccion']= 10; // 10%


/**
 * @var DETRACCION FLETE
 */
$config['detraccion_f']= 4; // 4%

/**
 * @var MUESTRA NOTIFICACIONES DE VEHICULOS
 * se ingresa el porcentaje minimo para mostrar
 */
$config['muestraVH']= 40; // MAYORES a 40%

/**
 * @var charset
 */
$config['charset']= 'UTF-8';
/**
 * @var language
 */
$config['language']= 'es-ES';

/**
 * Requiere del archivo db.php para funcionar
 */

require_once 'configuration/db.php';
/**
 * Requiere del archivo config.php para funcionar
 */
require_once 'configuration/config.php';
