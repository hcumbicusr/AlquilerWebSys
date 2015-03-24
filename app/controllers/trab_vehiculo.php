<?php
require_once '../../Config.inc.php';
require_once '../../app/models/trab_vehiculo.php';
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
                    $objTrabV = new TrabVehiculo();                  
                    // ----- se ingresa e id_detallealquiler
                    $objTrabV->setId_vehiculoph(Funciones::decodeStrings($_POST['id_detallealquiler'], 2));
                    $objTrabV->setId_trabajador($_POST['id_trabajador']);            
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['fecha']);
                    $fecha = $anio."-".$mes."-".$dia;
                    
                    $objTrabV->setF_inicio($fecha);                                        
                    
                    if ($objTrabV->registrarAsignacionTrab())
                    {
                        header("Location: ../../site/panel/adm_asigna_op.php?contr=".$_POST['id_contrato']."&detal=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('ok',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_asigna_op.php?contr=".$_POST['id_contrato']."&detal=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('no',2));                        
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

/**
 * @param int $alquiler ID vehiculoph
 * @todo datos de vehiculo
 */
function datosVechiculoAsigna($vehiculoph)
{
    $objTrabV = new TrabVehiculo();
    $objTrabV->setId_vehiculoph($vehiculoph);
    return $objTrabV->datosAsignacionV_O();
}