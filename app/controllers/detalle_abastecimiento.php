<?php
require_once '../../Config.inc.php';
require_once '../../app/models/detalle_abastecimiento.php';
require_once '../../configuration/Funciones.php';
require_once '../../configuration/Sesion.php';

function handler()
{
    if (!empty($_GET['event']))
    {
        switch ($_GET['event'])
        {
            case 'registrar_guia': 
                if (!empty($_POST))
                {
                    session_start();
                    $objDetAbast = new DetalleAbastecimiento();                                                        
                   $objDetAbast->setNro_guia(trim($_POST['nro_guiaReg']));
                   $objDetAbast->setNro_placa(trim($_POST['nro_placa']));
                   $objDetAbast->setNro_liciencia(trim($_POST['nro_licencia']));
                   $objDetAbast->setCantidad($_POST['cant_comb']);
                   
                   list($dia,$mes,$anio) = explode("/", $_POST['fecha']);
                    $fecha = $anio."-".$mes."-".$dia;
                   
                   $objDetAbast->setFecha($fecha);
                   
                   $objDetAbast->setId_tipocombustible($_POST['id_tipocombustible']);  
                   $objDetAbast->setAbastecedor(trim($_POST['abastecedor']));
                   $objDetAbast->setVale_combustible(trim($_POST['vale_combustible']));
                   $objDetAbast->setIngreso("MQ"); //MAquinaria
                   
                    if ($objDetAbast->registrarDetalleAbastecimiento())
                    {
                        //die(" SI ".  var_dump($ret));
                        header("Location: ../../site/panel/ct_registro_guia.php?msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        //die("NO");
                        header("Location: ../../site/panel/ct_registro_guia.php?msj=".Funciones::encodeStrings('no',2));
                    }
                    //die(var_dump($_POST));
                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break;                                        
             case 'asignar_fc': 
                if (!empty($_POST))
                {
                    session_start();
                    $objDetAbast = new DetalleAbastecimiento();                                                        
                   $objDetAbast->setNro_comprobante(trim(Funciones::reemplazaEspeciales($_POST['comprobante'])));
                   
                   list($dia,$mes,$anio) = explode("/", $_POST['desde']);
                    $desde = $anio."-".$mes."-".$dia;
                    
                    list($dia,$mes,$anio) = explode("/", $_POST['hasta']);
                    $hasta = $anio."-".$mes."-".$dia;
                    
                   $objDetAbast->setF_desde(trim($desde));
                   $objDetAbast->setF_hasta(trim($hasta));
                   
                   $n = $objDetAbast->asignarGuiaFechas();
                   
                    if ($n >= 0)
                    {
                        //die(" SI ".  var_dump($n));
                        header("Location: ../../site/panel/ct_asigna_fech.php?msj=".Funciones::encodeStrings($n,2));
                    }else
                    {
                        //die("NO");
                        header("Location: ../../site/panel/ct_asigna_fech.php?msj=".Funciones::encodeStrings('no',2));
                    }
                    //die(var_dump($_POST));
                }else
                {                    
                    header("Location: ../../site/panel/index.php");
                }                
                break; 
           case 'asignar_chk': 
                if (!empty($_POST))
                {
                    if (!empty($_POST['chk']))
                    {
                        if (is_array($_POST['chk'])) // comprobamos si es un array
                        {
                            $objDB = new Class_Db();
                            $con = $objDB->selectManager()->connect();
                            
                            $query = "SELECT ifnull(id_abastecimiento,0) as id_abastecimiento FROM abastecimiento WHERE nro_comprobante = '".$_POST['comprobante']."'";
                            
                            $result = $objDB->selectManager()->select($con, $query);
                            $id_abastecimiento = $result[0]['id_abastecimiento'];
                            $n = count($_POST['chk']); // nro registros afectados
                            
                            if (!empty($id_abastecimiento))
                            {                                
                                $update = "INSERT INTO detalleabastecimiento (id_detalleabastecimiento,id_abastecimiento)
                                            VALUES ";                                        

                                while (list($key,$value) = each($_POST['chk']))
                                {
                                    $update .= "($value,$id_abastecimiento),";
                                }
                                $update = substr($update,0, -1);
                                $update .= " ON DUPLICATE KEY
                                            UPDATE
                                            id_detalleabastecimiento = VALUES(id_detalleabastecimiento),
                                            id_abastecimiento = VALUES(id_abastecimiento)";
                                //die(var_dump($update));
                                $con = NULL;
                                //die(var_dump($update));
                                $con = $objDB->selectManager()->connect();
                                $result_b = $objDB->selectManager()->insert($con, $update);
                                
                                $update_b = "UPDATE abastecimiento
                                                SET cantidad_guia =
                                                (SELECT SUM(cantidad) FROM detalleabastecimiento
                                                WHERE id_abastecimiento = $id_abastecimiento) WHERE id_abastecimiento = $id_abastecimiento";
                                
                                $con = NULL;
                                $con = $objDB->selectManager()->connect();
                                $result_c = $objDB->selectManager()->update($con, $update_b);                                                                
                                
                                if ($result_b)
                                {
                                    header("Location: ../../site/panel/ct_asigna_check.php?msj=".Funciones::encodeStrings($n,2));                                    
                                }else {
                                    header("Location: ../../site/panel/ct_asigna_check.php?msj=".Funciones::encodeStrings('no',2));
                                }
                                
                            }else {
                                header("Location: ../../site/panel/ct_asigna_check.php?msj=".Funciones::encodeStrings('comp',2));
                            }                                                                                    
                            
                        }else 
                        {
                            header("Location: ../../site/panel/ct_asigna_check.php");
                        }
                        
                    }else
                    {
                        header("Location: ../../site/panel/ct_asigna_check.php?msj=".Funciones::encodeStrings('sel',2));//selecciones alguna guia No hay check
                    }
                    //die(var_dump($_POST));
                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break;
            case 'desasignar':
                if (!empty($_POST))
                {
                    session_start();
                    $objDetAbast = new DetalleAbastecimiento();
                    $objDetAbast->setId_detalleabastecimiento(Funciones::decodeStrings($_POST['det_abast'], 2));
                    if ($objDetAbast->desAsignarGuia())
                    {
                        header("Location: ../../site/panel/ct_list_guias.php");
                    }else{
                        header("Location: ../../site/panel/ct_list_guias.php#NO");
                    }
                }else
                {                    
                    header("Location: ../../site/panel/");
                }
                break;
           
           case 'editar_guia': 
                if (!empty($_POST))
                {
                    session_start();
                    $objDetAbast = new DetalleAbastecimiento(); 
                    $objDetAbast->setId_detalleabastecimiento(Funciones::decodeStrings($_POST['id_det_abast'], 2));
                   $objDetAbast->setNro_guia(trim($_POST['nro_guia']));
                   
                   if (empty($_POST['nro_placa']))
                   {
                       $guia = false;
                       $placa = $_POST['nro_placa_v'];
                   }elseif(empty($_POST['nro_placa_v']))
                   {
                       $guia = true;
                       $placa = $_POST['nro_placa'];
                   }
                   
                   $objDetAbast->setNro_placa(trim($placa));
                   
                   $objDetAbast->setNro_liciencia(trim($_POST['nro_licencia']));
                   $objDetAbast->setCantidad($_POST['cant_comb']);
                   
                   list($dia,$mes,$anio) = explode("/", $_POST['fecha']);
                   
                   $objDetAbast->setFecha($anio."-".$mes."-".$dia);
                   $objDetAbast->setId_tipocombustible($_POST['id_tipocombustible']);  
                   $objDetAbast->setAbastecedor(trim($_POST['abastecedor']));
                   
                   if (is_numeric($_POST['vale_combustible']))
                   {
                       $objDetAbast->setVale_combustible(trim($_POST['vale_combustible']));
                   }else
                   {
                       $objDetAbast->setVale_combustible(0);
                   }                                      
                   
                    if ($objDetAbast->editarDetalleAbastecimiento())
                    {
                        //die(" SI ".  var_dump($ret));
                        if($guia){
                            header("Location: ../../site/panel/ct_list_guias.php");
                        }else
                        {
                            header("Location: ../../site/panel/ct_list_vale_comb.php");
                        }
                    }else
                    {
                        //die("NO");
                        if($guia){                        
                            header("Location: ../../site/panel/ct_list_guias.php#NO");
                        }else
                        {
                            header("Location: ../../site/panel/ct_list_vale_comb.php#NO");
                        }
                    }
                    //die(var_dump($_POST));
                }else
                {                    
                    header("Location: ../../site/panel/");
                }                
                break;
            
           case 'registrar_vale_comb': 
                if (!empty($_POST))
                {
                    session_start();
                    $objDetAbast = new DetalleAbastecimiento();                                                        
                   $objDetAbast->setNro_guia("000000");
                   $objDetAbast->setNro_placa(trim($_POST['nro_placa_v']));
                   $objDetAbast->setNro_liciencia(trim($_POST['nro_licencia']));
                   $objDetAbast->setCantidad($_POST['cant_comb']);
                   
                   list($dia,$mes,$anio) = explode("/", $_POST['fecha']);
                    $fecha = $anio."-".$mes."-".$dia;
                   
                   $objDetAbast->setFecha($fecha);
                   
                   $objDetAbast->setId_tipocombustible($_POST['id_tipocombustible']);  
                   $objDetAbast->setAbastecedor(trim($_POST['abastecedor']));
                   $objDetAbast->setVale_combustible(trim($_POST['vale_combustible']));
                   $objDetAbast->setIngreso("VH"); //Vehículo
                   
                    if ($objDetAbast->registrarDetalleAbastecimiento())
                    {
                        //die(" SI ".  var_dump($ret));
                        header("Location: ../../site/panel/ct_abastecimiento_vh.php?msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        //die("NO");
                        header("Location: ../../site/panel/ct_abastecimiento_vh.php?msj=".Funciones::encodeStrings('no',2));
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