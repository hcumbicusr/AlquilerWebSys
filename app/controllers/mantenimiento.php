<?php
require_once '../../Config.inc.php';
require_once '../../app/models/mantenimiento.php';
require_once '../../configuration/Funciones.php';
require_once '../../configuration/Sesion.php';

function handler()
{
    if (!empty($_GET['event']))
    {
        switch ($_GET['event'])
        {
            case 'registrar_mant': 
                if (!empty($_POST))
                {
                    session_start();
                    $objMant = new Mantenimiento();                    
                   $objMant->setId_vehiculo(Funciones::decodeStrings($_POST['id_vehiculo'],2));
                   $objMant->setCausa(trim($_POST['motivo']));
                   $objMant->setDescripcion(trim($_POST['descripcion']));
                   $objMant->setLugar_av(trim($_POST['lugar_av']));
                   $objMant->setLugar_mant(trim($_POST['lugar_mant']));
                   
                   list($dia,$mes,$anio) = explode("/", $_POST['f_ingreso']);
                   $entrada = $anio."-".$mes."-".$dia;
                    
                   list($dia,$mes,$anio) = explode("/", $_POST['f_salida']);
                   $salida = $anio."-".$mes."-".$dia;
                   
                   $objMant->setF_ingreso(trim($entrada));
                   $objMant->setF_salida(trim($salida));
                   
                   
                   $objMant->setHorometro(trim($_POST['horometro']));
                   $objMant->setKilometraje(trim($_POST['kilometraje']));
                   $objMant->setEstado_actual(trim($_POST['estado']));
                   $objMant->setCosto($_POST['costo']);
                   
                   $v = $_POST['id_vehiculo'];
                   
                    if ($objMant->registrarMantenimiento())
                    {
                        //die(" SI ".  var_dump($ret));
                        header("Location: ../../site/panel/ct_registro_mantenimiento.php?v=$v&msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        //die("NO");
                        header("Location: ../../site/panel/ct_registro_mantenimiento.php?v=$v&msj=".Funciones::encodeStrings('no',2));
                    }
                    //die(var_dump($_POST));
                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break;                                                                                          
        }
    }
}

handler();