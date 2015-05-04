<?php
session_start();
if (empty($_SESSION['sessionID']))
{
    header("Location: ../");
}
if (empty($_GET['cliente']) || empty($_GET['desde']) || empty($_GET['hasta']))
{
    header("Location: ../site/panel/REP_valorizacion.php");
}
include_once('../app/models/pdf_valorizacion.php');

//header('Content-type: application/pdf');
//header('Content-Disposition: attachment; filename="valorizacion.pdf"');

$pdf = new PDF();
//Agreagamos la pagina 
$pdf->AddPage();
/*
 * Traemos los valores que se neceitan para el llenado de datos de un array 
 * de la funcion que lista los resultados de la consulta de las tablas 
 */
require_once '../Config.inc.php';
include_once '../configuration/Funciones.php';
$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
$id= Funciones::decodeStrings($_GET['cliente'], 2);

list($dia,$mes,$anio) = explode("/", $_GET['desde']);
$desde = $anio."-".$mes."-".$dia;
//die(var_dump($desde));

list($dia,$mes,$anio) = explode("/", $_GET['hasta']);
$hasta = $anio."-".$mes."-".$dia;

$input = "$id,'$desde','$hasta'";

$query = "SELECT
        c.id_cliente,
        c.codigo,
        c.nombre
        FROM cliente c
        INNER JOIN contrato ct ON c.id_cliente = ct.id_cliente
        INNER JOIN detallealquiler da ON ct.id_contrato = da.id_contrato
        WHERE c.id_cliente = $id
        GROUP BY c.id_cliente";
$cabecera = $objDB->selectManager()->select($con, $query); //array 2 dimensiones DATOS GENERALES

$misDatos = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_cliente", $input); //DATOS DE LA TABLA

$con = $objDB->selectManager()->connect();
$flete = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_cliente_flete", $input); //DATOS DE LA TABLA

$con = $objDB->selectManager()->connect();
$cuentas = $objDB->selectManager()->spSelect($con, "sp_datos_cuenta_banco_empresa");

//Enviamos y Mostramos los datos del PDF 
//------------------- NOTA; Tener en cuenta paso de datos de FLETE
$pdf->tablaHorizontal($misDatos,$cabecera,$cuentas,$flete); // 4to parametro Datos de Flete
 //Salida al navegador

$pdf->Output('Valorizacion_acumulada_de_'.  str_replace(' ', '_', $cabecera[0]['nombre']).'_'.(date("dmYHis")).'.pdf','I');