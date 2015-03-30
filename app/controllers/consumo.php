<?php
require_once '../../Config.inc.php';
require_once '../../app/models/consumo.php';
require_once '../../configuration/Funciones.php';
require_once '../../configuration/Sesion.php';

function handler()
{
    if (!empty($_GET['event']))
    {
        switch ($_GET['event'])
        {
            case 'registrar_consumo': 
                if (!empty($_POST))
                {
                    session_start();
                    $objConsumo = new Consumo();
                   $objConsumo->setId_vehiculo(Funciones::decodeStrings($_POST['id_detallealquiler'],2)); 
                   
                   list($apel,$nom) = explode(",", $_POST['trabajador']);

                   $nombre = trim($apel).trim($nom);
                   $nombre = str_replace(' ', '', $nombre);

                   //die(var_dump($nombre));
                   
                   $objConsumo->setId_trabajador($nombre);  //nombre completo del trabajador                   
                   $objConsumo->setNro_guia(trim($_POST['nro_guia']));
                   $objConsumo->setNro_vale(trim($_POST['nro_vale']));
                   $objConsumo->setNro_surtidor(trim($_POST['nro_surtidor']));
                   $objConsumo->setCant_combustible($_POST['cant_comb']);
                   $objConsumo->setHorometro($_POST['horometro']); 
                   $objConsumo->setKilometraje($_POST['kilometraje']);
                   
                   list($dia,$mes,$anio) = explode("/", $_POST['fecha']);

                   $fecha = $anio."-".$mes."-".$dia;
                   $objConsumo->setFecha($fecha);
                   
                   $ret = $objConsumo->registrarConsumoComb();
                               
                   //die(var_dump($ret));
                   
                    if ($ret == 'OK')
                    {
                        //die(" SI ".  var_dump($ret));
                        header("Location: ../../site/panel/ct_control_combustible.php?cliente=".$_POST['cliente']."&v=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('ok',2));                        
                    }else if(is_string($ret) && $ret == 'NO')
                    {
                       //die(" NRP ".  var_dump($ret));
                        header("Location: ../../site/panel/ct_control_combustible.php?cliente=".$_POST['cliente']."&v=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings($ret,2));
                    }else if (is_string($ret) && $ret == 'PARTE')
                    {
                        header("Location: ../../site/panel/ct_control_combustible.php?cliente=".$_POST['cliente']."&v=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings($ret,2));
                    }else
                    {
                        //die("NO");
                        header("Location: ../../site/panel/ct_control_combustible.php?cliente=".$_POST['cliente']."&v=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('no',2));                        
                    }
                    //die(var_dump($_POST));
                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break;
                
         case 'editar_consumo': 
                if (!empty($_POST))
                {
                    session_start();
                    $objConsumo = new Consumo();
                   $objConsumo->setId_consumo(Funciones::decodeStrings($_POST['id_consumo'],2));                                      
                   $objConsumo->setNro_guia(trim($_POST['nro_guia']));
                   $objConsumo->setNro_vale(trim($_POST['nro_vale_i']));
                   $objConsumo->setNro_surtidor(trim($_POST['nro_surtidor']));
                   $objConsumo->setCant_combustible($_POST['cant_comb']);
                   $objConsumo->setHorometro($_POST['horometro']); 
                   $objConsumo->setKilometraje($_POST['kilometraje']);
                   
                   list($apel,$nom) = explode(",", $_POST['trabajador']);

                   $nombre = trim($apel).trim($nom);
                   $nombre = str_replace(' ', '', $nombre);

                   //die(var_dump($nombre));
                   
                   $objConsumo->setId_trabajador($nombre);  //nombre completo del trabajador       
                   
                   list($dia,$mes,$anio) = explode("/", $_POST['fecha']);

                   $fecha = $anio."-".$mes."-".$dia;
                   $objConsumo->setFecha($fecha);                                      
                   
                   //die(var_dump($ret));
                   $ret = $objConsumo->editarConsumoComb();
                   
                    if ($ret)
                    {
                        //die(" SI ".  var_dump($ret));
                        header("Location: ../../site/panel/ct_list_combustible.php");                        
                    }else if (is_string($ret) && $ret == 'PARTE'){
                        header("Location: ../../site/panel/ct_list_combustible.php#PARTE"); 
                    }else
                    {
                        //die("NO");
                        header("Location: ../../site/panel/ct_list_combustible.php#NO");                        
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