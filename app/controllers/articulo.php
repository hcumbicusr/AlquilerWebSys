<?php
require_once '../../Config.inc.php';
require_once '../../app/models/articulo.php';
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
                    $objArticulo = new Articulo();                    
                    $objArticulo->setId_almacen($_POST['id_almacen']);
                    $objArticulo->setId_tipoarticulo($_POST['id_tipoarticulo']);
                    $objArticulo->setNombre(Funciones::reemplazaEspeciales(trim($_POST['nombre'])));                    
                    $objArticulo->setSerie(trim($_POST['serie']));
                    $objArticulo->setDescripcion(Funciones::reemplazaEspeciales(trim($_POST['descripcion'])));                    
                    $objArticulo->setPrecio_alq($_POST['precio_alq']);
                    
                    //die(var_dump($_POST));
                    //die(var_dump($objArticulo->getId_cliente()));
                    
                    if ($objArticulo->registrarArticulo())
                    {
                        header("Location: ../../site/panel/adm_reg_articulos.php?msj=".Funciones::encodeStrings('ok',2));                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_reg_articulos.php?msj=".Funciones::encodeStrings('no',2));                        
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
                    $objArticulo = new Articulo();                    
                    $objArticulo->setId_almacen($_POST['id_almacen']);
                    $objArticulo->setId_tipoarticulo($_POST['id_tipoarticulo']);
                    $objArticulo->setNombre(Funciones::reemplazaEspeciales(trim($_POST['nombre'])));                    
                    $objArticulo->setSerie(trim($_POST['serie']));
                    $objArticulo->setDescripcion(Funciones::reemplazaEspeciales(trim($_POST['descripcion'])));                    
                    $objArticulo->setPrecio_alq($_POST['precio_alq']);
                    
                    $objArticulo->setId_articulo(Funciones::decodeStrings($_POST['id_articulo'], 2));
                    
                    //die(var_dump($_POST));
                    //die(var_dump($objArticulo->getId_cliente()));
                    
                    if ($objArticulo->editarArticulo())
                    {
                        header("Location: ../../site/panel/adm_list_articulos.php");                        
                    }else
                    {
                        header("Location: ../../site/panel/adm_list_articulos.php#NO");                        
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
function datosArticulo($contrato)
{
    $objArticulo = new Articulo();
    $objArticulo->setId_contrato($contrato);
    return $objArticulo->datosArticulo();
}