<?php
require_once '../../Config.inc.php';
require_once '../../app/models/obra.php';
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
                    $objObra = new Obra();       
                    if (empty($_POST['id_tipoobra']))
                    {
                        $objObra->setId_tipoobra(3);// 3 -> STANDARD
                    }else
                    {
                        $objObra->setId_tipoobra($_POST['id_tipoobra']); 
                    }
                    
                    $objObra->setNombre(trim($_POST['nombre']));
                    
                    //die(var_dump($_POST));
                    //die(var_dump($objContrato->getId_cliente()));
                    
                    if ($objObra->registrarObra())
                    {
                        header("Location: ../../site/panel/adm_reg_obra.php?msj=".Funciones::encodeStrings('ok',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_reg_obra.php?msj=".Funciones::encodeStrings('no',2));                        
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
                    $objObra = new Obra();                    
                    $objObra->setId_tipoobra($_POST['id_tipoobra']);                    
                    $objObra->setNombre(trim($_POST['nombre']));
                    $objObra->setId_obra(Funciones::decodeStrings($_POST['id_obra'], 2));
                    
                    //die(var_dump($_POST));
                    //die(var_dump($objContrato->getId_cliente()));
                    
                    if ($objObra->editarObra())
                    {
                        header("Location: ../../site/panel/adm_list_obras.php");                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_list_obras.php#NO");                        
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