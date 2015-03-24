<?php
require_once '../../Config.inc.php';
require_once '../../app/models/abastecimiento.php';
require_once '../../configuration/Funciones.php';
require_once '../../configuration/Sesion.php';

function handler()
{
    if (!empty($_GET['event']))
    {
        switch ($_GET['event'])
        {
            case 'registrar_comp': 
                if (!empty($_POST))
                {
                    session_start();
                    $objAbast = new Abastecimiento();                    
                   $objAbast->setId_tipocomprobante($_POST['id_tipocomprobante']);
                   $objAbast->setId_tipocombustible($_POST['id_tipocombustible']);
                   
                   list($dia,$mes,$anio) = explode("/", $_POST['fecha']);
                    $fecha = $anio."-".$mes."-".$dia;
                   
                   $objAbast->setFecha($fecha);
                   
                   $objAbast->setNro_comprobante(trim($_POST['nro_comprobanteReg']));
                   $objAbast->setNro_operacion_ch(trim($_POST['nro_operacion']));                   
                   $objAbast->setAbastecedor(trim($_POST['abastecedor']));                   
                   $objAbast->setCantidad($_POST['cant_comb']);           
                   $objAbast->setPrecio_u($_POST['precio_u']);
                   
                   $tot = $_POST['cant_comb'] * $_POST['precio_u'];
                   $objAbast->setTotal($tot);
                   
                    if ($objAbast->registrarAbastecimiento())
                    {
                        //die(" SI ".  var_dump($ret));
                        header("Location: ../../site/panel/ct_registro_comprobante.php?msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        //die("NO");
                        header("Location: ../../site/panel/ct_registro_comprobante.php?msj=".Funciones::encodeStrings('no',2));
                    }
                    //die(var_dump($_POST));
                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break;                                                                                          
                
         case 'editar_comp': 
                if (!empty($_POST))
                {
                    session_start();
                    $objAbast = new Abastecimiento();    
                    $objAbast->setId_abastecimiento(Funciones::decodeStrings($_POST['id_abastecimiento'],2));
                   $objAbast->setId_tipocomprobante($_POST['id_tipocomprobante']);
                   $objAbast->setId_tipocombustible($_POST['id_tipocombustible']);
                   
                   list($dia,$mes,$anio) = explode("/", $_POST['fecha']);
                    $fecha = $anio."-".$mes."-".$dia;
                   $objAbast->setFecha($fecha);
                   
                   $objAbast->setNro_comprobante(trim($_POST['nro_comprobante']));
                   $objAbast->setNro_operacion_ch(trim($_POST['nro_operacion']));                   
                   $objAbast->setAbastecedor(trim($_POST['abastecedor']));                   
                   $objAbast->setCantidad($_POST['cant_comb']);           
                   $objAbast->setPrecio_u($_POST['precio_u']);
                   
                   $tot = $_POST['cant_comb'] * $_POST['precio_u'];
                   $objAbast->setTotal($tot);
                   
                    if ($objAbast->editarAbastecimiento())
                    {
                        //die(" SI ".  var_dump($ret));
                        header("Location: ../../site/panel/ct_list_comprobantes.php");
                    }else
                    {
                        //die("NO");
                        header("Location: ../../site/panel/ct_list_comprobantes.php#NO");
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