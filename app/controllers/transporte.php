<?php
require_once '../../Config.inc.php';
require_once '../../app/models/transporte.php';
require_once '../../configuration/Funciones.php';
require_once '../../configuration/Sesion.php';

function handler()
{
    if (!empty($_GET['event']))
    {
        switch ($_GET['event'])
        {
            case 'registrar': 
                if (!empty($_POST))
                {
                    session_start();
                    $objTransporte = new Transporte();                    
                    $objTransporte->setId_detallealquiler(Funciones::decodeStrings($_POST['id_detallealquiler'], 2));
                    $objTransporte->setConcepto(trim($_POST['concepto']));
                    $objTransporte->setObservacion(trim($_POST['observacion']));
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['fecha']);
                    $fecha = $anio."-".$mes."-".$dia;
                    
                    $objTransporte->setFecha($fecha);
                    $objTransporte->setMonto($_POST['monto']);
                    
                    if ($objTransporte->registrarFlete())
                    {
                        header("Location: ../../site/panel/adm_transporte_maquinaria.php?contr=".$_POST['id_contrato']."&detal=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('ok',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_transporte_maquinaria.php?contr=".$_POST['id_contrato']."&detal=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('no',2));                        
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