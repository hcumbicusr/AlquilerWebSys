<?php
require_once '../../Config.inc.php';
require_once '../../app/models/tipo.php';
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
                    $objTipo = new Tipo();                    
                    $objTipo->setNombre(trim($_POST['nombre']));
                    $objTipo->setEstado(trim($_POST['estado']));
                    $objTipo->setNombre_tabla(trim($_POST['tipo']));
                    
                    //die(var_dump($_POST));
                    //die(var_dump($objContrato->getId_cliente()));
                    
                    if ($objTipo->registrarTipo())
                    {
                        header("Location: ../../site/panel/adm_reg_tipos.php?msj=".Funciones::encodeStrings('ok',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_reg_tipos.php?msj=".Funciones::encodeStrings('no',2));                        
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
                    $objTipo = new Tipo();                    
                    $objTipo->setNombre(trim($_POST['nombre']));
                    $objTipo->setEstado(trim($_POST['estado']));                    
                    $objTipo->setId_tipo(trim(Funciones::decodeStrings($_POST['id'], 2))); 
                    $objTipo->setNombre_tabla(trim(Funciones::decodeStrings($_POST['ntab'], 2))); 
                    
                    //die(var_dump($_POST));
                    //die(var_dump($objContrato->getId_cliente()));
                    
                    if ($objTipo->editarTipo())
                    {
                        header("Location: ../../site/panel/adm_list_tipos.php");                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_list_tipos.php#NO_"+$objTipo->getNombre_tabla());
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