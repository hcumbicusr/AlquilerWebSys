<?php
require_once '../../Config.inc.php';
require_once '../../app/models/vehiculo.php';
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
                    $objVehiculo = new Vehiculo();                    
                    $objVehiculo->setId_marca($_POST['id_marca']);
                    $objVehiculo->setId_tipovehiculo($_POST['id_tipovehiculo']);
                    $objVehiculo->setNombre(trim($_POST['nombre']));
                    $objVehiculo->setRendimiento(trim($_POST['rendimiento']));
                    $objVehiculo->setModelo(trim($_POST['modelo']));
                    $objVehiculo->setSerie(trim($_POST['serie']));
                    $objVehiculo->setMotor(trim($_POST['motor']));
                    $objVehiculo->setColor(trim($_POST['color']));
                    $objVehiculo->setPlaca(trim($_POST['placa']));
                    $objVehiculo->setPrecio_h($_POST['precio_h']);
                    $objVehiculo->setHorometro($_POST['horometro']);
                    $objVehiculo->setKilometraje($_POST['kilometraje']);
                    //echo "<pre>";
                    //die(var_dump($_POST));
                    //die(var_dump($objVehiculo->getId_cliente()));
                    
                    if ($objVehiculo->registrarVehiculo())
                    {
                        header("Location: ../../site/panel/adm_reg_vehiculo.php?msj=".Funciones::encodeStrings('ok',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_reg_vehiculo.php?msj=".Funciones::encodeStrings('no',2));                        
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
                    $objVehiculo = new Vehiculo();                    
                    $objVehiculo->setId_marca($_POST['id_marca']);
                    $objVehiculo->setId_tipovehiculo($_POST['id_tipovehiculo']);
                    $objVehiculo->setRendimiento(trim($_POST['rendimiento']));
                    $objVehiculo->setNombre(trim($_POST['nombre']));
                    $objVehiculo->setModelo(trim($_POST['modelo']));
                    $objVehiculo->setSerie(trim($_POST['serie']));
                    $objVehiculo->setMotor(trim($_POST['motor']));
                    $objVehiculo->setColor(trim($_POST['color']));
                    $objVehiculo->setPlaca(trim($_POST['placa']));
                    $objVehiculo->setPrecio_h($_POST['precio_h']);
                    $objVehiculo->setHorometro($_POST['horometro']);
                    $objVehiculo->setKilometraje($_POST['kilometraje']);
                    
                    $objVehiculo->setId_vehiculo(Funciones::decodeStrings($_POST['id_vehiculo'], 2));
                    
                    //die(var_dump($_POST));
                    //die(var_dump($objVehiculo->getId_cliente()));
                    
                    if ($objVehiculo->editarVehiculo())
                    {
                        header("Location: ../../site/panel/adm_list_vehiculos.php");                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_list_vehiculos.php#NO");                        
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
function datosVehiculo($contrato)
{
    $objVehiculo = new Vehiculo();
    $objVehiculo->setId_contrato($contrato);
    return $objVehiculo->datosVehiculo();
}