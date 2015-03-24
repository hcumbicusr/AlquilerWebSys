<?php
require_once '../../Config.inc.php';
require_once '../../app/models/contrato.php';
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
                    $objContrato = new Contrato();
                    $objContrato->setId_cliente(Funciones::decodeStrings($_POST['id_cliente'],2));
                    $objContrato->setId_obra($_POST['id_obra']);
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['f_inicio']);
                    $desde = $anio."-".$mes."-".$dia;
                    
                    if (empty($_POST['f_fin'])) // f_fin no establecida
                    {
                        $objContrato->setF_fin('0000-00-00');
                    }else
                    {
                        list($dia,$mes,$anio) = explode("/", $_POST['f_fin']);
                        $hasta = $anio."-".$mes."-".$dia;

                        $objContrato->setF_inicio($desde);

                        $objContrato->setF_fin($hasta);
                    }     
                    
                    if (empty($_POST['presupuesto']))
                    {
                        $objContrato->setPresupuesto(0);
                    }else
                    {
                        $objContrato->setPresupuesto($_POST['presupuesto']);
                    }
                                        
                    $objContrato->setDetalle(trim($_POST['detalle']));
                    
                    //die(var_dump($_POST));
                    //die(var_dump($objContrato->getId_cliente()));
                    
                    if ($objContrato->registrarNuevoContrato())
                    {
                        header("Location: ../../site/panel/adm_crear_contrato.php?cliente=".$_POST['id_cliente']."&msj=".Funciones::encodeStrings('ok',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_crear_contrato.php?cliente=".$_POST['id_cliente']."&msj=".Funciones::encodeStrings('no',2));                        
                    }
                    //die(var_dump($_POST));
                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break; 
               
         case 'editar': 
                if (!empty($_POST))
                {
                    session_start();
                    $objContrato = new Contrato();
                    list($dia,$mes,$anio) = explode("/", $_POST['f_inicio']);
                    $f_inicio = $anio."-".$mes."-".$dia;                  
                    $objContrato->setF_inicio($f_inicio);
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['f_fin']);
                    $f_fin = $anio."-".$mes."-".$dia;                                        
                    
                    $objContrato->setF_fin($f_fin);
                    $objContrato->setPresupuesto($_POST['presupuesto']);
                    $objContrato->setDetalle(trim($_POST['detalle']));
                    $objContrato->setId_contrato(Funciones::decodeStrings($_POST['id_contrato'], 2));
                    
                    //die(var_dump($_POST));
                    //die(var_dump($objContrato->getId_cliente()));
                    
                    if ($objContrato->editarContrato())
                    {
                        header("Location: ../../site/panel/adm_list_contratos.php");                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_list_contratos.php#NO");                        
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
 * @param int $alquiler ID alquiler
 * @todo Lista los vehiculos o artículos alquilados
 */
function datosContrato($contrato)
{
    $objContrato = new Contrato();
    $objContrato->setId_contrato($contrato);
    return $objContrato->datosContrato();
}