<?php
require_once '../../Config.inc.php';
require_once '../../app/models/control_trabajo.php';
require_once '../../configuration/Funciones.php';
require_once '../../configuration/Sesion.php';

function handler()
{
    if (!empty($_GET['event']))
    {
        switch ($_GET['event'])
        {
            case 'registrar_parte': 
                if (!empty($_POST))
                {
                    session_start();                    
                    $objControl = new ControlTrabajo();
                    
                    //echo "<pre>";
                    //die(var_dump($_POST));
                    
                    $objControl->setId_vehiculo(Funciones::decodeStrings($_POST['id_detallealquiler'],2));  
                    
                    list($apel,$nom) = explode(",", $_POST['trabajador']);

                    $nombre = trim($apel).trim($nom);
                    
                    $objControl->setId_trabajador($nombre);
                    
                    $objControl->setNro_parte(trim($_POST['nro_parte']));
                    $objControl->setNro_interno($_POST['nro_interno']);
                    
                    list($dia,$mes,$anio) = explode("/",$_POST['fecha']);
                    $fecha = $anio."-".$mes."-".$dia;
                    $objControl->setFecha($fecha);
                    
                    $objControl->setLugar_trabajo(trim($_POST['lugar_trabajo']));
                    $objControl->setTarea(trim($_POST['tarea']));
                    $objControl->setAgua($_POST['agua']);
                    $objControl->setPetroleo($_POST['petroleo']);
                    $objControl->setGasolina($_POST['gasolina']);
                    $objControl->setAc_motor($_POST['ac_motor']);
                    $objControl->setAc_transmision($_POST['ac_transmision']);
                    $objControl->setAc_hidraulico($_POST['ac_hidraulico']);
                    $objControl->setGrasa($_POST['grasa']);
                    $objControl->setObservacion($_POST['observacion']);
                    $objControl->setTurno(trim($_POST['turno']));                                        
                    
                    $objControl->setDescuento($_POST['descuento']); 
                    $dcto =$_POST['descuento'];
                    
                    $objControl->setHorometro_inicio($_POST['horometro_ini']);
                    $objControl->setHorometro_fin($_POST['horometro_fin']);                                        
                    
                    if (empty($dcto)) $dcto = 0;
                    
                    // totalh = (horom_fin - horom_ini) - descuento
                    $th = round(($_POST['horometro_fin'] - $_POST['horometro_ini']) - $dcto,2);
                    
                    $objControl->setTotal_h($th);
                    ////------------------------------------Calculo de horas y minutos -----------------------
                    $h_m = explode(".", $th);
                    $hrs = $h_m[0];
                    $min = 0;
                    //die(var_dump($th));
                    if (!empty($h_m[1]))
                    {
                        $min = (($h_m[1])/10)*60;
                    }
                    $objControl->setHrs($hrs);
                    $objControl->setMin($min);
                    ////------------------------------------Calculo de horas y minutos -----------------------
                    
                    if($_POST['valorizacion'] == 'HR')
                    {
                        $h_min = 0;
                    }else if ($_POST['valorizacion'] == 'HM')
                    {
                        $h_min = $_POST['hora_min_reg'];
                    }
                    
                    $objControl->setValorizacion($_POST['valorizacion']);
                    $objControl->setHora_min($h_min);
                    
                    if ($objControl->registrarParte())
                    {
                        header("Location: ../../site/panel/ct_parte_maquinaria.php?cliente=".$_POST['cliente']."&v=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('ok',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/ct_parte_maquinaria.php?cliente=".$_POST['cliente']."&v=".$_POST['id_detallealquiler']."&msj=".Funciones::encodeStrings('no',2));                        
                    }
                    //die(var_dump($_POST));
                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break;                                        
                
         case 'editar_parte': 
                if (!empty($_POST))
                {
                    session_start();                    
                    $objControl = new ControlTrabajo();
                    $objControl->setId_controltrabajo(Funciones::decodeStrings($_POST['id_controltrabajo'],2));                    
                    $objControl->setNro_parte(trim($_POST['nro_parte']));
                    
                    list($apel,$nom) = explode(",", $_POST['trabajador']);

                    $nombre = trim($apel).trim($nom);
                    
                    $objControl->setId_trabajador($nombre);
                    
                    list($dia,$mes,$anio) = explode("/",$_POST['fecha']);
                    $fecha = $anio."-".$mes."-".$dia;
                    $objControl->setFecha($fecha);
                    $objControl->setLugar_trabajo(trim($_POST['lugar_trabajo']));
                    $objControl->setTarea(trim($_POST['tarea']));
                    $objControl->setAgua($_POST['agua']);
                    $objControl->setPetroleo($_POST['petroleo']);
                    $objControl->setGasolina($_POST['gasolina']);
                    $objControl->setAc_motor($_POST['ac_motor']);
                    $objControl->setAc_transmision($_POST['ac_transmision']);
                    $objControl->setAc_hidraulico($_POST['ac_hidraulico']);
                    $objControl->setGrasa($_POST['grasa']);
                    $objControl->setObservacion($_POST['observacion']);
                    $objControl->setTurno(trim($_POST['turno']));                                        
                    
                    $objControl->setDescuento($_POST['descuento']); 
                    $dcto =$_POST['descuento'];
                    
                    $objControl->setHorometro_inicio($_POST['horometro_ini']);
                    $objControl->setHorometro_fin($_POST['horometro_fin']);
                    
                    if (empty($dcto)) $dcto = 0;
                    
                    // totalh = (horom_fin - horom_ini) - descuento
                    $th = round(($_POST['horometro_fin'] - $_POST['horometro_ini']) - $dcto,2);
                    
                    $objControl->setTotal_h($th);
                    ////------------------------------------Calculo de horas y minutos -----------------------
                    $h_m = explode(".", $th);
                    $hrs = $h_m[0];
                    $min = 0;
                    //die(var_dump($th));
                    if (!empty($h_m[1]))
                    {
                        $min = (($h_m[1])/10)*60;
                    }
                    $objControl->setHrs($hrs);
                    $objControl->setMin($min);
                    ////------------------------------------Calculo de horas y minutos -----------------------
                    
                    if($_POST['valorizacion'] == 'HR')
                    {
                        $h_min = 0;
                    }else if ($_POST['valorizacion'] == 'HM')
                    {
                        $h_min = $_POST['hora_min_reg'];
                    }
                    
                    $objControl->setValorizacion($_POST['valorizacion']);
                    $objControl->setHora_min($h_min);
                    
                    
                    if ($objControl->editarParte())
                    {
                        header("Location: ../../site/panel/ct_list_trabajo.php");                        
                    }else
                    {
                        header("Location: ../../site/panel/ct_list_trabajo.php#NO");                        
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