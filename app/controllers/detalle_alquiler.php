<?php
require_once '../../Config.inc.php';
require_once '../../app/models/detalle_alquiler.php';
require_once '../../configuration/Funciones.php';
require_once '../../configuration/Sesion.php';

function handler()
{
    if (!empty($_GET['event']))
    {
        switch ($_GET['event'])
        {
            case 'registrar_vh': 
                if (!empty($_POST))
                {
                    //die("Llegamos");
                    session_start();
                    $objDetalleAlquiler = new DetalleAlquiler();
                    $objDetalleAlquiler->setId_contrato(Funciones::decodeStrings($_POST['contrato'],2));
                    //$objDetalleAlquiler->setEstado($_POST['estado']);
                    $objDetalleAlquiler->setEstado($_POST['estado']);
                    //$objDetalleAlquiler->setObservacion($_POST['observacion']);
                    if (empty($_POST['observacion']))
                    {
                        $_POST['observacion'] = '';
                    }
                    
                    $objDetalleAlquiler->setObservacion($_POST['observacion']);
                    
                    $objDetalleAlquiler->setId_articulo(0);
                    $objDetalleAlquiler->setId_vehiculoph(Funciones::decodeStrings($_POST['v'],2));
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['fecha_alq']);
                    $fecha = $anio."-".$mes."-".$dia;
                    
                    $objDetalleAlquiler->setFecha($fecha);
                    
                    $objDetalleAlquiler->setPrecio_alq($_POST['precio_alq']);
                                       
                    //------------------------------------------------------------------------------------
                    
                    
                    if ($objDetalleAlquiler->registrarDetalleAlquiler()) 
                    {
                        header("Location: ../../site/panel/adm_reg_alq_vehiculo.php?contrato=".$_POST['contrato']."&v=".$_POST['v']."&msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        header("Location: ../../site/panel/adm_reg_alq_vehiculo.php?contrato=".$_POST['contrato']."&v=".$_POST['v']."&msj=".Funciones::encodeStrings('no',2));
                    }
                    
                    //------------------------------------------------------------------------------------
                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break; 
           case 'registrar_art': 
                if (!empty($_POST))
                {
                    //die("Llegamos");
                    session_start();
                    $objDetalleAlquiler = new DetalleAlquiler();
                    $objDetalleAlquiler->setId_contrato(Funciones::decodeStrings($_POST['contrato'],2));
                    //$objDetalleAlquiler->setEstado($_POST['estado']);
                    if (empty($_POST['estado']))
                    {
                        $_POST['estado'] = '';
                    }
                    
                    $objDetalleAlquiler->setEstado($_POST['estado']);
                    
                     if (empty($_POST['observacion']))
                    {
                        $_POST['observacion'] = '';
                    }
                    $objDetalleAlquiler->setObservacion($_POST['observacion']);
                    $objDetalleAlquiler->setId_vehiculoph(0);
                    $objDetalleAlquiler->setId_articulo(Funciones::decodeStrings($_POST['articulo'],2));
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['fecha_alq']);
                    $fecha = $anio."-".$mes."-".$dia;
                    
                    $objDetalleAlquiler->setFecha($fecha);
                    
                    $objDetalleAlquiler->setPrecio_alq($_POST['precio_alq']);
                    //------------------------------------------------------------------------------------
                    
                    
                    if ($objDetalleAlquiler->registrarDetalleAlquiler_art()) 
                    {
                        header("Location: ../../site/panel/adm_reg_alq_articulo.php?contrato=".$_POST['contrato']."&articulo=".$_POST['articulo']."&msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        header("Location: ../../site/panel/adm_reg_alq_articulo.php?contrato=".$_POST['contrato']."&articulo=".$_POST['articulo']."&msj=".Funciones::encodeStrings('no',2));
                    }
                    
                    //------------------------------------------------------------------------------------

                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break;
            case 'dev_vh': //devolucion de vehiculo
                if (!empty($_POST))
                {
                    session_start();
                    $objDetalleAlquiler = new DetalleAlquiler();
                    
                    //die("Llegamos");
                    //session_start();
                    $objDetalleAlquiler = new DetalleAlquiler();    
                    
                    if (empty($_POST['estado']))
                    {
                        $_POST['estado'] = '';
                    }
                    $objDetalleAlquiler->setEstado($_POST['estado']);                    
                    
                    if (empty($_POST['observacion']))
                    {
                        $_POST['observacion'] = '';
                    }
                    
                    $objDetalleAlquiler->setObservacion($_POST['observacion']);
                    $objDetalleAlquiler->setId_detallealquiler(Funciones::decodeStrings($_POST['det_alq'], 2)); 
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['fecha_dev']);
                    $fecha = $anio."-".$mes."-".$dia;
                    
                    $objDetalleAlquiler->setFecha($fecha);
                    //------------------------------------------------------------------------------------                    
                    
                    if ($objDetalleAlquiler->registrarDevolucionVH()) 
                    {
                        header("Location: ../../site/panel/adm_reg_dev_vehiculo.php?contrato=".$_POST['contrato']."&det_alq=".$_POST['det_alq']."&msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        header("Location: ../../site/panel/adm_reg_dev_vehiculo.php?contrato=".$_POST['contrato']."&det_alq=".$_POST['det_alq']."&msj=".Funciones::encodeStrings('no',2));
                    }
                    
                }else
                {                    
                    header("Location: ../../site/panel/");
                } 
                break;
            case 'dev_art': //devolucion de articulo
                if (!empty($_POST))
                {
                    session_start();
                    $objDetalleAlquiler = new DetalleAlquiler();
                    
                    //die("Llegamos");
                    //session_start();
                    $objDetalleAlquiler = new DetalleAlquiler();                                       
                    $objDetalleAlquiler->setEstado($_POST['estado']);                    
                    $objDetalleAlquiler->setObservacion($_POST['observacion']);
                    $objDetalleAlquiler->setId_detallealquiler(Funciones::decodeStrings($_POST['det_alq'], 2));    
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['fecha_dev']);
                    $fecha = $anio."-".$mes."-".$dia;
                    
                    $objDetalleAlquiler->setFecha($fecha);
                    //------------------------------------------------------------------------------------                    
                    
                    if ($objDetalleAlquiler->registrarDevolucionART()) 
                    {
                        header("Location: ../../site/panel/adm_reg_dev_articulo.php?contrato=".$_POST['contrato']."&det_alq=".$_POST['det_alq']."&msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        header("Location: ../../site/panel/adm_reg_dev_articulo.php?contrato=".$_POST['contrato']."&det_alq=".$_POST['det_alq']."&msj=".Funciones::encodeStrings('no',2));
                    }
                    
                }else
                {                    
                    header("Location: ../../site/panel/");
                } 
                break;
            case 'anula_alq': //anulacion de vehiculo alquilado
                if (!empty($_POST))
                {
                    session_start();
                    $objDetalleAlquiler = new DetalleAlquiler();
                    
                    //die("Llegamos");
                    //session_start();
                    $objDetalleAlquiler = new DetalleAlquiler();
                    $objDetalleAlquiler->setId_detallealquiler(Funciones::decodeStrings($_POST['id_detallealquiler'], 2));                    
                    //------------------------------------------------------------------------------------                    
                    
                    if ($objDetalleAlquiler->anularAlquilerVH()) 
                    {
                        header("Location: ../../site/panel/adm_anula_alquiler.php?contr=".$_POST['id_contrato']."&detal=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        header("Location: ../../site/panel/adm_anula_alquiler.php?contr=".$_POST['id_contrato']."&detal=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('no',2));
                    }
                    
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
function listarAlquilerVH($alquiler)
{
    $objDetalleAlquiler = new DetalleAlquiler();
    $objDetalleAlquiler->setId_alquiler($alquiler);
    return $objDetalleAlquiler->listarAquilerVehiculos();
}

/**
 * @param int $alquiler ID alquiler
 * @todo Lista los vehiculos o artículos alquilados
 */
function datosContrato($alquiler)
{
    $objDetalleAlquiler = new DetalleAlquiler();
    $objDetalleAlquiler->setId_alquiler($alquiler);
    return $objDetalleAlquiler->datosContratoxAlquiler();
}