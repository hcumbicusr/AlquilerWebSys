<?php
require_once '../../Config.inc.php';
require_once '../../app/models/cliente.php';
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
                    $objCliente = new Cliente();
                    $objCliente->setNombre(trim($_POST['nombre']));
                    
                    if (empty($_POST['id_tipocliente']))
                    {
                        $objCliente->setId_tipocliente(4); //4 = STANDARD
                    }else
                    {
                        $objCliente->setId_tipocliente($_POST['id_tipocliente']);
                    }
                    
                    $objCliente->setCodigo(trim($_POST['codigo']));
                    $objCliente->setDireccion(trim($_POST['direccion']));
                    $objCliente->setTelefono(trim($_POST['telefono']));
                    
                    //die(var_dump($_POST));
                    
                    $reg = $objCliente->registrarCliente();
                    
                    if ($reg == false)
                    {
                        header("Location: ../../site/panel/adm_registro_cliente.php?msj=".Funciones::encodeStrings('no',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_registro_cliente.php?id=$reg&msj=".Funciones::encodeStrings('ok',2));
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
                    $objCliente = new Cliente();
                    $objCliente->setNombre(trim($_POST['nombre']));
                    $objCliente->setId_tipocliente($_POST['id_tipocliente']);
                    $objCliente->setCodigo(trim($_POST['codigo']));
                    $objCliente->setDireccion(trim($_POST['direccion']));
                    $objCliente->setTelefono(trim($_POST['telefono']));
                    $objCliente->setId_cliente(Funciones::decodeStrings($_POST['id_cliente'], 2));
                    
                    //die(var_dump($_POST));
                    
                    
                    if ($objCliente->editarCliente())
                    {
                        header("Location: ../../site/panel/adm_list_clientes.php");                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_list_clientes.php#NO");
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