<?php
require_once '../../Config.inc.php';
require_once '../../app/models/trabajador.php';
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
                    $objTrabajador = new Trabajador();
                    $objTrabajador->setId_usuario($_SESSION['id_usuario']); // usuario que ha registrado al trabajdor
                    $objTrabajador->setApellidos(trim($_POST['apellidos']));
                    $objTrabajador->setNombres(trim($_POST['nombres']));
                    $objTrabajador->setDni(trim($_POST['dni']));
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['fecha_nac']);
                    $fecha = $anio."-".$mes."-".$dia;
                    
                    $objTrabajador->setFecha_nac(trim($fecha));
                    
                    $objTrabajador->setRuc(trim($_POST['ruc']));
                    $objTrabajador->setTelefono(trim($_POST['telefono']));                    
                    $objTrabajador->setId_tipousuario($_POST['id_tipousuario']);  
                    $objTrabajador->setId_tipotrabajador($_POST['id_tipotrabajador']);
                    $objTrabajador->setNro_licencia($_POST['nro_licencia']);
                    
                    //die(var_dump($_POST));
                    
                    if ($objTrabajador->registrarTrabajador())
                    {
                        header("Location: ../../site/panel/adm_registro_trabajador.php?msj=".Funciones::encodeStrings('ok',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_registro_trabajador.php?msj=".Funciones::encodeStrings('no',2));                        
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
                    $objTrabajador = new Trabajador();
                    $objTrabajador->setId_usuario($_SESSION['id_usuario']); // usuario que ha registrado al trabajdor
                    $objTrabajador->setApellidos(trim($_POST['apellidos']));
                    $objTrabajador->setNombres(trim($_POST['nombres']));
                    $objTrabajador->setDni(trim($_POST['dni']));
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['fecha_nac']);
                    $fecha_nac = $anio."-".$mes."-".$dia;
                    
                    $objTrabajador->setFecha_nac(trim($fecha_nac));
                    
                    $objTrabajador->setRuc(trim($_POST['ruc']));
                    $objTrabajador->setTelefono(trim($_POST['telefono']));                    
                    $objTrabajador->setId_tipousuario($_POST['id_tipousuario']);  
                    $objTrabajador->setId_tipotrabajador($_POST['id_tipotrabajador']);
                    $objTrabajador->setNro_licencia($_POST['nro_licencia']);
                    
                    $objTrabajador->setId_trabajador(Funciones::decodeStrings($_POST['id_trabajador'], 2));
                    
                    //die(var_dump($_POST));
                    
                    if ($objTrabajador->editarTrabajador())
                    {
                        header("Location: ../../site/panel/adm_list_trabajadores.php");
                    }else
                    {
                        header("Location: ../../site/panel/adm_list_trabajadores.php#NO");                        
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