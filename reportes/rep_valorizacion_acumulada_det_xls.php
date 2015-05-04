<?php
session_start();
if (empty($_SESSION['sessionID']))
{
    header("Location: ../");
}
if (empty($_GET['cliente']) || empty($_GET['desde']) || empty($_GET['hasta']))
{
    header("Location: ../site/panel/REP_valorizacion.php");
}

require '../Config.inc.php';
include_once '../configuration/Funciones.php';

//-------------------------------------------------
$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
$id= Funciones::decodeStrings($_GET['cliente'], 2);

list($dia,$mes,$anio) = explode("/", $_GET['desde']);
$desde = $anio."-".$mes."-".$dia;
//die(var_dump($desde));

list($dia,$mes,$anio) = explode("/", $_GET['hasta']);
$hasta = $anio."-".$mes."-".$dia;

$input = "$id,'$desde','$hasta'";

//die($input);

$misDatos = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_cliente_obra_xls", $input); //DATOS DE LA TABLA

$con = $objDB->selectManager()->connect();
//Sin usar
//$flete = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_cliente_flete", $input); //DATOS DE LA TABLA
/*
$con = $objDB->selectManager()->connect();
$cuentas = $objDB->selectManager()->spSelect($con, "sp_datos_cuenta_banco_empresa");
*/

$fech_act = utf8_decode(date("d/m/Y H:i:s"));

$clienteNom = $misDatos[0]['cliente'];
$clienteCod = $misDatos[0]['codigo'];
$titulo = "VALORIZACIÓN ACUMULADA";
$tituloPag = "VALORIZACIÓN";
$subtitulo = "DE ".$_GET['desde']." AL ".$_GET['hasta'];
$tituloFl = "FLETES DE MAQUINARIA";

$encabezado_tabla = array(
    'DIA',
    'FECHA',
    'PARTE',
    'HORAS',
    'MINUTOS',
    'TOTAL HRS.',
    'INICIO HOROM.',
    'TÉRMINO HOROM.',
    'LABOR',
    'HRS. MÍNIMAS'
);

$arr = array('[',']','/'); 

$pto_horas[] = "";
$pto_min[] = "";
$pto_thoras[] = "";
$pto_tit_obra[] = "";
$pto_thoras_min[] = "";

$arr_valorizacion [] = "";

if(count($misDatos) > 0 ){  //verifica si hay datos para generar excel  
    if (PHP_SAPI == 'cli')
    {
        die('Este archivo solo se puede ver desde un navegador web');
    }
    /** Se agrega la libreria PHPExcel */
    require_once '../libraries/PHPExcel/PHPExcel.php';
    
    // Se crea el objeto PHPExcel
    $objPHPExcel = new PHPExcel();    
    
    // Se asignan las propiedades del libro
    $objPHPExcel->getProperties()->setCreator("Piuramaq S.R.L.") //Autor            
             ->setLastModifiedBy("Piuramaq S.R.L. [".$_SESSION['apenom']."]") //Ultimo usuario que lo modificó
             ->setTitle("Reporte Valorización")
             ->setSubject("Valorización Detallada de".$_GET['desde']." al ".$_GET['hasta'])
             ->setDescription("Valorización Detallada")
             ->setKeywords("reporte valorizacion")
             ->setCategory("Reporte excel");

    //--------------------------cuenta nro de vehiculos para crear paginas
    $vehiculos[] = "";
    $operario[] = "";
    $ind = 0;   
    
    // vehiculos
    $con = $objDB->selectManager()->connect();
    $vehiculos = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_group_vehiculo", $input); //vehiculos        
    
    //die(var_dump($misDatos));
    //$vehiculos = array_unique($vehiculos);
    //$operario = array_unique($operario); //----> revisar    
    
    //print_r("<pre>");
    //var_dump($vehiculos);    
    //cantidad de paginas que se debe crear
    $cant_vh = count($vehiculos);// FOR <=
    //$cant_ob = count($obras);// FOR <=    
    
    //print_r("</pre>");
    //die();
    //---------------------------------------------------------------------------        
    //$objPHPExcel->createSheet(0); //---------> se creará para Resumen de valorizacion
    // primero se crean las pagina de detalle, y al  final la pagina de resumen
    
    $titulo_vh = "";        
    
    $objPHPExcel->createSheet(0); //Crea página para valorizacion acumulada
    $objPHPExcel->setActiveSheetIndex(0);
    //incluir una imagen
    $objDrawing = new PHPExcel_Worksheet_Drawing();
    $objDrawing->setPath('../site/img/logo_rep.jpg'); //ruta
    $objDrawing->setHeight(40); //altura
    $objDrawing->setCoordinates('B1');
    $objDrawing->setWorksheet($objPHPExcel->getActiveSheet()); 
    //fin: incluir una imagen
    $objPHPExcel->getActiveSheet()->setTitle("VALORIZACIÓN ACUMULADA");
    
    for ($w = 0; $w < $cant_vh; $w++) { // recorrido por vehiculo, cant_pag = cant_vehiculos o maquinaria
        // $w == id_pagina
        // --- pagina
        $p = $w+1;               
        $ini_filas = 9;
        
        // obras del vehiculo actual
        $con = $objDB->selectManager()->connect();
        $obras = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_group_obra", $input.",".$vehiculos[$w]['id_vehiculo']); //obras                
        
         // Se agregan los titulos del reporte
        $objPHPExcel->setActiveSheetIndex($p)
                ->setCellValue("A3","Maquinaria: ".$obras[0]['vehiculo'])
                ->setCellValue("A4","Operador: ".$obras[0]['operario']);
                   
        $ultima_col = "A";
        $inicio = "A";
        //-for que recorre las obras que tiene el vehiculo                
        
        $titulo_vh = $vehiculos[$w]['vehiculo_c'];
        $titulo_vh = substr(str_replace($arr, '', $titulo_vh),0,30);
        
        $punto_filas = 0;
        
        for($a = 0; $a <count($obras);$a++)
        {                        
            //------------------encabezados tabla x obra            
            $objPHPExcel->setActiveSheetIndex($p)->mergeCells($ultima_col."5:".(Funciones::sumaLetras($ultima_col, 6))."5"); //titulo obra OBRA
            $objPHPExcel->setActiveSheetIndex($p)->mergeCells($ultima_col."6:".(Funciones::sumaLetras($ultima_col, 6))."6"); //titulo obra: tabla BD 
            $objPHPExcel->setActiveSheetIndex($p)->mergeCells($ultima_col."7:".(Funciones::sumaLetras($ultima_col, 6))."7"); //celda en blanco 
            $objPHPExcel->setActiveSheetIndex($p)->mergeCells((Funciones::sumaLetras($ultima_col, 7))."5:".(Funciones::sumaLetras($ultima_col, 7))."7"); 
            //echo (Funciones::sumaLetras($ultima_col, 6))."5:".(Funciones::sumaLetras($ultima_col, 6))."7";
            $objPHPExcel->setActiveSheetIndex($p) 
                    ->setCellValue($ultima_col."5","OBRA:")
                    ->setCellValue($ultima_col."6",$obras[$a]['obra'])                
                    ->setCellValue($ultima_col."7","")//vacía
                    ->setCellValue((Funciones::sumaLetras($ultima_col, 7))."5","Área Afectac. PPTO:");
            
            //-------titulo tablas
            $objPHPExcel->setActiveSheetIndex($p)
                    ->setCellValue($ultima_col."8",$encabezado_tabla[0])
                    ->setCellValue((Funciones::sumaLetras($ultima_col, 1))."8",$encabezado_tabla[1])
                    ->setCellValue((Funciones::sumaLetras($ultima_col, 2))."8",$encabezado_tabla[2])
                    ->setCellValue((Funciones::sumaLetras($ultima_col, 3))."8",$encabezado_tabla[3])                
                    ->setCellValue((Funciones::sumaLetras($ultima_col, 4))."8",$encabezado_tabla[4])
                    ->setCellValue((Funciones::sumaLetras($ultima_col, 5))."8",$encabezado_tabla[5])
                    ->setCellValue((Funciones::sumaLetras($ultima_col, 6))."8",$encabezado_tabla[9]) //---> horas minimas
                    ->setCellValue((Funciones::sumaLetras($ultima_col, 7))."8","");// en blanco
            
            $ultima_col = $objPHPExcel->getActiveSheet()->getHighestColumn(); //G
            $ultima_col_x = $ultima_col;
            $ultima_col = Funciones::sumaLetras($ultima_col, 1);                        
        
            //---------------llenado de la tabla ----------------------------- sp_REP_valorizacion_group_vehiculo_obra
            $con = $objDB->selectManager()->connect();
            $partes = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_group_vehiculo_obra", 
                    $input.",".$vehiculos[$w]['id_vehiculo'].",".$obras[$a]['id_obra']); //partes de vehiculo obra
            for ($i = 0; $i < count($partes); $i++)
            {        
                list($anio,$mes,$dia) = explode('-', $partes[$i]['fecha']);
                $partes[$i]['fecha'] = $dia.'/'.$mes.'/'.$anio;
            }            
            
            $tot_horas = 0;
            
            for($b = 0; $b <count($partes); $b++)
            {
                if($partes[$b]['valoriza'] == 'HR')
                {
                    $tot_horas = "=".Funciones::sumaLetras($inicio, 5).$ini_filas;
                }elseif($partes[$b]['valoriza'] == 'HM')
                {
                    $tot_horas = $partes[$b]["hora_min"];
                }
                $objPHPExcel->setActiveSheetIndex($p)                       
                        ->setCellValue($inicio.$ini_filas, substr(Funciones::nombreDia($partes[$b]["fecha"]), 0, 3))
                        ->setCellValue(Funciones::sumaLetras($inicio, 1).$ini_filas,  $partes[$b]["fecha"])
                        ->setCellValue(Funciones::sumaLetras($inicio, 2).$ini_filas,  $partes[$b]["nro_parte"])
                        ->setCellValue(Funciones::sumaLetras($inicio, 3).$ini_filas,  $partes[$b]["horas"])
                        ->setCellValue(Funciones::sumaLetras($inicio, 4).$ini_filas,  $partes[$b]["minutos"])
                        ->setCellValue(Funciones::sumaLetras($inicio, 5).$ini_filas,  $partes[$b]["total_horas"])
                        ->setCellValue(Funciones::sumaLetras($inicio, 6).$ini_filas,  $tot_horas);
                $ini_filas++;
            }
            
            // totales de tabla
            //horas
            $objPHPExcel->setActiveSheetIndex($p)                       
                        ->setCellValue(Funciones::sumaLetras($inicio, 3).($ini_filas+1), "=ROUND(SUM(".Funciones::sumaLetras($inicio, 3)."9:".Funciones::sumaLetras($inicio, 3)."".($ini_filas)."),2)" );
            $pto_horas[$a] = Funciones::sumaLetras($inicio, 3).($ini_filas+1);
            //minutos
            $objPHPExcel->setActiveSheetIndex($p)                       
                        ->setCellValue(Funciones::sumaLetras($inicio, 4).($ini_filas+1), "=ROUND(SUM(".Funciones::sumaLetras($inicio, 4)."9:".Funciones::sumaLetras($inicio, 4)."".($ini_filas)."),2)" );
            $pto_min[$a] = Funciones::sumaLetras($inicio, 4).($ini_filas+1);
            //tot horas            
            $objPHPExcel->setActiveSheetIndex($p)                       
                        ->setCellValue(Funciones::sumaLetras($inicio, 5).($ini_filas+1), "=ROUND(SUM(".Funciones::sumaLetras($inicio, 5)."9:".Funciones::sumaLetras($inicio, 5)."".($ini_filas)."),2)" );
            $pto_thoras[$a] = Funciones::sumaLetras($inicio, 5).($ini_filas+1);            
            //tot horas  MINIMAS          
            $objPHPExcel->setActiveSheetIndex($p)                       
                        ->setCellValue(Funciones::sumaLetras($inicio, 6).($ini_filas+1), "=ROUND(SUM(".Funciones::sumaLetras($inicio, 6)."9:".Funciones::sumaLetras($inicio, 6)."".($ini_filas)."),2)" );
            $pto_thoras_min[$a] = Funciones::sumaLetras($inicio, 6).($ini_filas+1);
            
            $pto_tit_obra[$a] = $obras[$a]['obra']; // titulo de la obra para resumen
            
            if ($punto_filas == 0) // solo lo hace una vez
            {
                $punto_filas = $ini_filas+4;
            }            
            
            $ultima_col_es = $objPHPExcel->getActiveSheet()->getHighestColumn(); //para estilos de tabla
            //echo $ultima_col_es;
            //---totales PIE de PAGINA
            //titulo
            $objPHPExcel->setActiveSheetIndex($p)->setCellValue("A".$punto_filas,"RESUMEN");
            //OBRA TOTAL  	 P.U. 	 V.V 	 IGV 18% 	 P.V 
            $objPHPExcel->setActiveSheetIndex($p)
                    ->setCellValue("A".($punto_filas+1),"OBRA")
                    ->setCellValue(Funciones::sumaLetras("A", 4).($punto_filas+1),"TOTAL S/.")
                    ->setCellValue(Funciones::sumaLetras("A", 5).($punto_filas+1),"P.U. S/.")
                    ->setCellValue(Funciones::sumaLetras("A", 6).($punto_filas+1),"V.V. S/.")
                    ->setCellValue(Funciones::sumaLetras("A", 7).($punto_filas+1),"IGV 18% S/.")
                    ->setCellValue(Funciones::sumaLetras("A", 8).($punto_filas+1),"P.V. S/.");                        
            
            //combina resumen  
            $objPHPExcel->setActiveSheetIndex($p)->mergeCells("A".($punto_filas+1).":D".($punto_filas+1));            
           
            $inicio = Funciones::sumaLetras($inicio, 7);// $objPHPExcel->getActiveSheet()->getHighestColumn(); //G
            
            $ini_filas--;
        }
        
        $punto_filas++;
        //rellena resumen
        //--------- puntero resumen
        $resumen[] = "";
        $in_resum = $punto_filas+1;
        for($c = 0; $c <count($pto_tit_obra); $c++)
        {
            $objPHPExcel->setActiveSheetIndex($p)                    
                    ->setCellValue("A".($punto_filas+1),$pto_tit_obra[$c])
                    ->setCellValue(Funciones::sumaLetras("A", 4).($punto_filas+1),"=".$pto_thoras_min[$c])
                    ->setCellValue(Funciones::sumaLetras("A", 5).($punto_filas+1),"=".$vehiculos[$w]['precio_alq'])
                    ->setCellValue(Funciones::sumaLetras("A", 6).($punto_filas+1),"=ROUND(PRODUCT(".Funciones::sumaLetras("A", 4).($punto_filas+1).",".Funciones::sumaLetras("A", 5).($punto_filas+1)."),2)")
                    ->setCellValue(Funciones::sumaLetras("A", 7).($punto_filas+1),"=ROUND(PRODUCT(".Funciones::sumaLetras("A", 6).($punto_filas+1).",0.18),2)")
                    ->setCellValue(Funciones::sumaLetras("A", 8).($punto_filas+1),"=ROUND(SUM(".Funciones::sumaLetras("A", 6).($punto_filas+1).",".Funciones::sumaLetras("A", 7).($punto_filas+1)."),2)");            
            //combina resumen  
            $objPHPExcel->setActiveSheetIndex($p)->mergeCells("A".($punto_filas+1).":D".($punto_filas+1)); 
            $punto_filas++;
        }
        //-------TOTAL HORAS POR FACTURAR
        if ($in_resum == $punto_filas)
        {            
            $objPHPExcel->setActiveSheetIndex($p)                   
                    ->setCellValue("A".($punto_filas+1),"TOTAL HORAS POR FACTURAR")
                    ->setCellValue(Funciones::sumaLetras("A", 4).($punto_filas+1),"=".Funciones::sumaLetras("A", 4).$in_resum)
                    ->setCellValue(Funciones::sumaLetras("A", 5).($punto_filas+1),"=".Funciones::sumaLetras("A", 5).($punto_filas))
                    ->setCellValue(Funciones::sumaLetras("A", 6).($punto_filas+1),"=".Funciones::sumaLetras("A", 6).$in_resum)
                    ->setCellValue(Funciones::sumaLetras("A", 7).($punto_filas+1),"=".Funciones::sumaLetras("A", 7).$in_resum)
                    ->setCellValue(Funciones::sumaLetras("A", 8).($punto_filas+1),"=".Funciones::sumaLetras("A", 8).$in_resum);
        //combina resumen  
            $objPHPExcel->setActiveSheetIndex($p)->mergeCells("A".($punto_filas+1).":D".($punto_filas+1)); 
        }else
        {
            $objPHPExcel->setActiveSheetIndex($p)                   
                    ->setCellValue("A".($punto_filas+1),"TOTAL HORAS POR FACTURAR")
                    ->setCellValue(Funciones::sumaLetras("A", 4).($punto_filas+1),"=ROUND(SUM(".Funciones::sumaLetras("A", 4).$in_resum.",".Funciones::sumaLetras("A", 4).($punto_filas)."),2)")
                    ->setCellValue(Funciones::sumaLetras("A", 5).($punto_filas+1),"=".Funciones::sumaLetras("A", 5).($punto_filas))
                    ->setCellValue(Funciones::sumaLetras("A", 6).($punto_filas+1),"=ROUND(SUM(".Funciones::sumaLetras("A", 6).$in_resum.",".Funciones::sumaLetras("A", 6).($punto_filas)."),2)")
                    ->setCellValue(Funciones::sumaLetras("A", 7).($punto_filas+1),"=ROUND(SUM(".Funciones::sumaLetras("A", 7).$in_resum.",".Funciones::sumaLetras("A", 7).($punto_filas)."),2)")
                    ->setCellValue(Funciones::sumaLetras("A", 8).($punto_filas+1),"=ROUND(SUM(".Funciones::sumaLetras("A", 8).$in_resum.",".Funciones::sumaLetras("A", 8).($punto_filas)."),2)");
        //combina resumen  
            $objPHPExcel->setActiveSheetIndex($p)->mergeCells("A".($punto_filas+1).":D".($punto_filas+1)); 
        }                        
        
        //punto total horas trabajadas
        $arr_valorizacion[$w] = array(
            "vehiculo" => $obras[0]['vehiculo'],
            "horas" => "='$titulo_vh'!".Funciones::sumaLetras("A", 4).($punto_filas+1),
            "precio" => "='$titulo_vh'!".Funciones::sumaLetras("A", 5).($punto_filas+1)
        );
        // ancho de filas
        for($a = "A"; $a <=$ultima_col;$a++)
        {
            $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension($a)->setWidth(11.4);            
        }
        // Encabezado cada page
        $objPHPExcel->setActiveSheetIndex($p)->setCellValue("C1",$tituloPag);
        //------------------maquinaria - operador
        $objPHPExcel->setActiveSheetIndex($p)->mergeCells("A3:".$ultima_col_x."3"); 
        $objPHPExcel->setActiveSheetIndex($p)->mergeCells("A4:".$ultima_col_x."4"); 
        $objPHPExcel->setActiveSheetIndex($p)->mergeCells("C1:".$ultima_col_x."2"); 
        
        //------------------totales parte inferior de c/tabla-----------------------
        //$ini_filas        
        
        //----------------------------
        
        $objPHPExcel->setActiveSheetIndex($p)->mergeCells($ultima_col."5:".(Funciones::sumaLetras($ultima_col, 5))."5"); //titulo obra OBRA
        ///------------aplicacion de estilos------------
        $estiloInformacion = new PHPExcel_Style();
        $estiloInformacion->applyFromArray(                
                array(
                    'font' => array(
                    'name'      => 'Arial',               
                    'color'     => array(
                            'rgb' => '000000'
                            )
                        ),
                    'fill' => array(
                        'type'		=> PHPExcel_Style_Fill::FILL_SOLID,
                        'color'		=> array('argb' => 'FFF2F2F2')
                        ),
                    'borders' => array(
                        'left'     => array(
                            'style' => PHPExcel_Style_Border::BORDER_THIN ,
                            'color' => array(
                                'rgb' => '3a2a47'
                                )
                            ),
                        'right'     => array(
                            'style' => PHPExcel_Style_Border::BORDER_THIN ,
                            'color' => array(
                                'rgb' => '3a2a47'
                                )
                            ),
                        'bottom'     => array(
                            'style' => PHPExcel_Style_Border::BORDER_THIN ,
                            'color' => array(
                                'rgb' => '3a2a47'
                                )
                            ),
                        'top'     => array(
                            'style' => PHPExcel_Style_Border::BORDER_THIN ,
                            'color' => array(
                                'rgb' => '3a2a47'
                                )
                            )
                        ),
                    'alignment' =>  array(
                            'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                            'vertical'   => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                            'wrap'          => TRUE
                    )
                )
         );
        
        
        //$objPHPExcel->getActiveSheet()->getStyle('B3:N3')->applyFromArray($estiloTituloReporte);
        //$objPHPExcel->getActiveSheet()->getStyle('B5:N5')->applyFromArray($estiloTituloColumnas);		
        $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "A1:".$ultima_col_es.($ini_filas+2)); //estilo tabla parte        
        $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "A".($in_resum-1).":I".($punto_filas+1)); //estilo tabla resumen
        // Se asigna el nombre a la hoja                
        
        $objPHPExcel->getActiveSheet()->freezePaneByColumnAndRow(0,9);
        $objPHPExcel->getActiveSheet()->setTitle($titulo_vh);
        $p++;
        $objPHPExcel->createSheet($p); //Crea dos páginas de más
        //incluir una imagen
        $objDrawing = new PHPExcel_Worksheet_Drawing();
        $objDrawing->setPath('../site/img/logo_rep.jpg'); //ruta
        $objDrawing->setHeight(40); //altura
        $objDrawing->setCoordinates('A1');
        $objDrawing->setWorksheet($objPHPExcel->getActiveSheet()); 
        //fin: incluir una imagen                     
        
    } //fin de página   
     //echo "<pre>";
     //die(var_dump($arr_valorizacion));
    
for ($x = 0; $x < $cant_vh; $x++) { // resumen
    // obras del vehiculo actual
    $input = "$id,'$desde','$hasta',".$vehiculos[$x]['id_vehiculo'];
    //die(var_dump($input));
    $con = $objDB->selectManager()->connect();
    $obras = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_group_vh_resumen", $input); //obras del vehiculo
    
    //_------------------------------------------
    $ini_filas = 6;
               
     // Se agregan los titulos del reporte
    $objPHPExcel->setActiveSheetIndex($p)
            ->setCellValue("B2","HORAS TRABAJADAS POR : ".$obras[0]['vehiculo'])
            ->setCellValue("B3","Operador: ".$obras[0]['operario']);

    $ultima_col = "B";
    $inicio = "B";
    //-for que recorre las obras que tiene el vehiculo                

    $titulo_vh = $vehiculos[$x]['vehiculo_c'];

    $punto_filas = 0;
    
    for ($i = 0; $i < count($obras); $i++)
    {        
        list($anio,$mes,$dia) = explode('-', $obras[$i]['fecha']);
        $obras[$i]['fecha'] = $dia.'/'.$mes.'/'.$anio;
    }
    //var_dump(count($obras));
    //-------titulo tablas
    $objPHPExcel->setActiveSheetIndex($p)
            ->setCellValue((Funciones::sumaLetras($ultima_col, 0))."5",$encabezado_tabla[1])
            ->setCellValue((Funciones::sumaLetras($ultima_col, 1))."5",$encabezado_tabla[2])
            ->setCellValue((Funciones::sumaLetras($ultima_col, 2))."5",$encabezado_tabla[3])                
            ->setCellValue((Funciones::sumaLetras($ultima_col, 3))."5",$encabezado_tabla[4])
            ->setCellValue((Funciones::sumaLetras($ultima_col, 4))."5",$encabezado_tabla[5])
            ->setCellValue((Funciones::sumaLetras($ultima_col, 5))."5",$encabezado_tabla[9])
            ->setCellValue((Funciones::sumaLetras($ultima_col, 6))."5",$encabezado_tabla[6])
            ->setCellValue((Funciones::sumaLetras($ultima_col, 7))."5",$encabezado_tabla[7])
            ->setCellValue((Funciones::sumaLetras($ultima_col, 8))."5","")// en blanco
            ->setCellValue((Funciones::sumaLetras($ultima_col, 9))."5",$encabezado_tabla[8]);
        
//    echo "<pre>";
//    var_dump($obras);
//    echo "</pre>";
    for($a = 0; $a <count($obras);$a++)
    {                        
        //------------------encabezados tabla x obra            
        $objPHPExcel->setActiveSheetIndex($p)->mergeCells($ultima_col."2:".(Funciones::sumaLetras($ultima_col, 6))."2"); //titulo obra OBRA
        $objPHPExcel->setActiveSheetIndex($p)->mergeCells($ultima_col."3:".(Funciones::sumaLetras($ultima_col, 6))."3"); //titulo obra: tabla BD                      

        //---------------llenado de la tabla ----------------------------- sp_REP_valorizacion_group_vehiculo_obra
        //$xp = Funciones::sumaLetras($inicio, 6).$ini_filas." -".Funciones::sumaLetras($inicio, 5).$ini_filas." -".Funciones::sumaLetras($inicio, 4).$ini_filas;
        //die(var_dump($xp));
        $tot_horas = 0;
        
        if($obras[$a]['valoriza'] == 'HR')
        {
            $tot_horas = "=".Funciones::sumaLetras($inicio, 4).$ini_filas;
        }elseif($obras[$a]['valoriza'] == 'HM')
        {
            $tot_horas = $obras[$a]["hora_min"];
        }
        
        $objPHPExcel->setActiveSheetIndex($p)                       
                ->setCellValue(Funciones::sumaLetras($inicio, 0).$ini_filas,  $obras[$a]["fecha"])
                ->setCellValue(Funciones::sumaLetras($inicio, 1).$ini_filas,  $obras[$a]["nro_parte"])
                ->setCellValue(Funciones::sumaLetras($inicio, 2).$ini_filas,  $obras[$a]["horas"])
                ->setCellValue(Funciones::sumaLetras($inicio, 3).$ini_filas,  $obras[$a]["minutos"])
                ->setCellValue(Funciones::sumaLetras($inicio, 4).$ini_filas,  $obras[$a]["total_horas"])                
                ->setCellValue(Funciones::sumaLetras($inicio, 5).$ini_filas,  $tot_horas)
                ->setCellValue(Funciones::sumaLetras($inicio, 6).$ini_filas,  $obras[$a]["horometro_inicio"])
                ->setCellValue(Funciones::sumaLetras($inicio, 7).$ini_filas,  $obras[$a]["horometro_fin"])
                ->setCellValue(Funciones::sumaLetras($inicio, 8).$ini_filas,  "=ROUND(".Funciones::sumaLetras($inicio, 7).$ini_filas."-".Funciones::sumaLetras($inicio, 6).$ini_filas."-".Funciones::sumaLetras($inicio, 4).$ini_filas.",2)")
                ->setCellValue(Funciones::sumaLetras($inicio, 9).$ini_filas,  $obras[$a]["labor"]);
        
//        echo "=> ".Funciones::sumaLetras($inicio, 7).$ini_filas;
//        echo "=> "."=ROUND(".Funciones::sumaLetras($inicio, 6).$ini_filas."-".Funciones::sumaLetras($inicio, 5).$ini_filas."-".Funciones::sumaLetras($inicio, 4).$ini_filas.",2)";               
        
        $ini_filas++;        
        //echo "".$ini_filas;        
                           
        //$ini_filas--;
    }
    //echo $ini_filas;
    // totales de tabla
        //horas
    $objPHPExcel->setActiveSheetIndex($p)                       
                ->setCellValue(Funciones::sumaLetras($inicio, 2).($ini_filas+1), "=ROUND(SUM(".Funciones::sumaLetras($inicio, 2)."6:".Funciones::sumaLetras($inicio, 2).($ini_filas)."),2)" );    
    //minutos
    $objPHPExcel->setActiveSheetIndex($p)                       
                ->setCellValue(Funciones::sumaLetras($inicio, 3).($ini_filas+1), "=ROUND(SUM(".Funciones::sumaLetras($inicio, 3)."6:".Funciones::sumaLetras($inicio, 3).($ini_filas)."),2)" );    
    //tot horas            
    $objPHPExcel->setActiveSheetIndex($p)                       
                ->setCellValue(Funciones::sumaLetras($inicio, 4).($ini_filas+1), "=ROUND(SUM(".Funciones::sumaLetras($inicio, 4)."6:".Funciones::sumaLetras($inicio, 4).($ini_filas)."),2)" );          
    
    //tot horas_min            
    $objPHPExcel->setActiveSheetIndex($p)                       
                ->setCellValue(Funciones::sumaLetras($inicio, 5).($ini_filas+1), "=ROUND(SUM(".Funciones::sumaLetras($inicio, 5)."6:".Funciones::sumaLetras($inicio, 5).($ini_filas)."),2)" );          
    
    $ultima_col_es = $objPHPExcel->getActiveSheet()->getHighestColumn(); //para estilos de tabla

    $punto_filas++;    
    
    ///------------aplicacion de estilos------------
    $estiloInformacion = new PHPExcel_Style();
    $estiloInformacion->applyFromArray(                
            array(
                'font' => array(
                'name'      => 'Arial',               
                'color'     => array(
                        'rgb' => '000000'
                        )
                    ),
                'fill' => array(
                    'type'		=> PHPExcel_Style_Fill::FILL_SOLID,
                    'color'		=> array('argb' => 'FFF2F2F2')
                    ),
                'borders' => array(
                    'left'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        ),
                    'right'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        ),
                    'bottom'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        ),
                    'top'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        )
                    ),
                'alignment' =>  array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical'   => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                        'wrap'          => TRUE
                )
            )
     );
    
    // ancho de filas
    for($r = "A"; $r <"K";$r++)
    {
        $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension($r)->setWidth(11.4);            
    }
    $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension("K")->setWidth(40);
    


    //$objPHPExcel->getActiveSheet()->getStyle('B3:N3')->applyFromArray($estiloTituloReporte);
    //$objPHPExcel->getActiveSheet()->getStyle('B5:N5')->applyFromArray($estiloTituloColumnas);		
    $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "B5:K".($ini_filas)); //estilo tabla parte
    $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, Funciones::sumaLetras($inicio, 2).($ini_filas+1).":".Funciones::sumaLetras($inicio, 5).($ini_filas+1));
    //$objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "A".($in_resum-1).":I".($punto_filas+1)); //estilo tabla resumen
    // Se asigna el nombre a la hoja

    $titulo_vh = substr(str_replace($arr, '', $titulo_vh),0,25);

    //$objPHPExcel->getActiveSheet()->freezePaneByColumnAndRow(0,9);
    $objPHPExcel->getActiveSheet()->setTitle("RES-".$titulo_vh);
    $p++;
    //die(var_dump($p));
    $objPHPExcel->createSheet($p); //Crea dos páginas de más
    //-------------------------------------------------
}
   // die();    

    //$objPHPExcel->setActiveSheetIndex(0)->setCellValue("A2", $arr_valorizacion[0]['vehiculo'] );

//--------------------Pagina de valorizacion acumulada --------------------------------
    $objDB = new Class_Db();
    $con = $objDB->selectManager()->connect();
    $query = "SELECT
        c.id_cliente,
        c.codigo,
        c.nombre
        FROM cliente c
        INNER JOIN contrato ct ON c.id_cliente = ct.id_cliente
        INNER JOIN detallealquiler da ON ct.id_contrato = da.id_contrato
        WHERE c.id_cliente = $id
        GROUP BY c.id_cliente";
    $cliente = $objDB->selectManager()->select($con, $query); //Datos del cliente
    //
    $titulo = "VALORIZACIÓN ACUMULADA ".$cliente[0]['nombre'];
    $subtitulo = "DE ".$_GET['desde']." AL ".$_GET['hasta'];
    $tituloFl = "FLETES DE MAQUINARIA";     
    
    $input = "$id,'$desde','$hasta'";

    $con = $objDB->selectManager()->connect();
    $flete = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_cliente_flete", $input); //DATOS DE LA TABLA
    //die(var_dump($flete));
    $titulosColumnas = array(
        'EQUIPO',
        'TOTAL HORAS',
        'COSTO POR HORA S/.',
        'TOTAL');
    
    $total_1 = 0;
    $total_2 = 0;
    $detrac_1 = 0;
    $detrac_2 = 0;
    $neto_1 = 0;
    $neto_2 = 0;
    
    $inicio_reg = 6;
    //titulo
    $objPHPExcel->setActiveSheetIndex(0)
                    ->mergeCells('E1:I1'); 
    $objPHPExcel->setActiveSheetIndex(0)
                    ->mergeCells('E2:I2'); 
    
    //equipo
    $objPHPExcel->setActiveSheetIndex(0)->mergeCells('B5:F5');
    // Se agregan los titulos del reporte
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('E1',$titulo.$clienteNom)
            ->setCellValue('E2',$subtitulo)                
            ->setCellValue('B4','')                
            ->setCellValue('B5',$titulosColumnas[0])
            ->setCellValue('G5',$titulosColumnas[1])
            ->setCellValue('H5',$titulosColumnas[2])
            ->setCellValue('I5',$titulosColumnas[3]);

    //Se agregan los datos 
    $i = $inicio_reg;
    //die(var_dump(count($arr_valorizacion))); $arr_valorizacion[0]['vehiculo']
    for ($j = 0; $j < count($arr_valorizacion); $j++) {
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$i:F$i");
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('B'.$i,  $arr_valorizacion[$j]['vehiculo'])
                ->setCellValue('G'.$i,  $arr_valorizacion[$j]['horas'])
                ->setCellValue('H'.$i,  $arr_valorizacion[$j]['precio'])
                ->setCellValue('I'.$i,  "=ROUND(G$i*H$i,2)");
        $i++;
    }
    
    $n = $i;
    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('G'.$n,  "Valor Venta S/.")
            ->setCellValue('I'.$n,  "=ROUND(SUM(I$inicio_reg:I".($n-1)."),2)");
    $n++;

    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");                
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('G'.$n,  "I.G.V. 18% S/.")
            ->setCellValue('I'.$n,  "=ROUND(PRODUCT(I".($n-1).",0.18),2)");
    $n++;

    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");                
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('G'.$n,  "Total S/.")
            ->setCellValue('I'.$n,  "=ROUND(SUM(I".($n-2).":I".($n-1)."),2)");
    $total_1 = $n;
    $n++;

    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");                
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('G'.$n,  "Detracción 10% S/.")
            ->setCellValue('I'.$n,  "=ROUND(PRODUCT(I".($n-1).",0.1),2)");
    $detrac_1 = $n;
    $n++;

    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");                
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('G'.$n,  "Importe Neto S/.")
            ->setCellValue('I'.$n,  "=ROUND(I".($n-2)."-I".($n-1).",2)");
    $neto_1 = $n;
    $n++;
    
    //-----------------Estilos-----------------------------------
    $estiloTituloReporte_val = array(
        'font' => array(
            'name'      => 'Verdana',
            'bold'      => true,
            'italic'    => false,
            'strike'    => false,
            'size' => 12,
            'color'     => array(
                'rgb' => 'FFFFFF'
                )
        ),
        'fill' => array(
                    'type'	=> PHPExcel_Style_Fill::FILL_SOLID,
                    'color'	=> array('argb' => 'FF220835')
            ),
        'borders' => array(
            'allborders' => array(
            'style' => PHPExcel_Style_Border::BORDER_NONE                    
            )
        ), 
        'alignment' =>  array(
                    'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    'vertical'   => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                    'rotation'   => 0,
                    'wrap'          => TRUE
        )
    );

    $estiloTituloColumnas_val = array(
        'font' => array(
            'name'      => 'Arial',
            'bold'      => true,      
             'size' => 10,

            'color'     => array(
            'rgb' => '000000'
            )
        ),
        'fill' 	=> array(
            'type'		=> PHPExcel_Style_Fill::FILL_GRADIENT_LINEAR,
            'rotation'   => 90,
            'startcolor' => array(
                'rgb' => 'FFCC4B'
                ),
            'endcolor'   => array(
                'rgb' => 'FFCC4B'
                )
            ),
        'borders' => array(
            'top'     => array(
            'style' => PHPExcel_Style_Border::BORDER_MEDIUM ,
            'color' => array(
                'rgb' => '143860'
                )
            ),
        'bottom'     => array(
            'style' => PHPExcel_Style_Border::BORDER_MEDIUM ,
            'color' => array(
                'rgb' => '143860'
                )
            )
        ),
        'alignment' =>  array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical'   => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                'wrap'          => TRUE
        ));

    $estiloTotales_val = array(
        'font' => array(
            'name'      => 'Arial',
            'bold'      => true,      
             'size' => 10,

            'color'     => array(
            'rgb' => '000000'
            )
        ),
        'fill' 	=> array(
            'type'		=> PHPExcel_Style_Fill::FILL_GRADIENT_LINEAR,
            'rotation'   => 90,
            'startcolor' => array(
                'rgb' => 'BDBDBD'
                ),
            'endcolor'   => array(
                'rgb' => 'BDBDBD'
                )
            ),
        'borders' => array(
            'top'     => array(
            'style' => PHPExcel_Style_Border::BORDER_MEDIUM ,
            'color' => array(
                'rgb' => '143860'
                )
            ),
        'bottom'     => array(
            'style' => PHPExcel_Style_Border::BORDER_MEDIUM ,
            'color' => array(
                'rgb' => '143860'
                )
            )
        ),
        'alignment' =>  array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical'   => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                'wrap'          => TRUE
        ));

    $estiloInformacion_val = new PHPExcel_Style();
    $estiloInformacion_val->applyFromArray(                
            array(
                'font' => array(
                'name'      => 'Arial',               
                'color'     => array(
                        'rgb' => '000000'
                        )
                    ),
                'fill' => array(
                    'type'		=> PHPExcel_Style_Fill::FILL_SOLID,
                    'color'		=> array('argb' => 'FFFFFFFF')
                    ),
                'borders' => array(
                    'left'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        ),
                    'right'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        ),
                    'bottom'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        )
                    ),
                'alignment' =>  array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_RIGHT,
                        'vertical'   => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                        'wrap'          => TRUE
                )
            )
     );

     $estiloInfIzquierda_val = new PHPExcel_Style();
    $estiloInfIzquierda_val->applyFromArray(                
            array(
                'font' => array(
                'name'      => 'Arial',               
                'color'     => array(
                        'rgb' => '000000'
                        )
                    ),
                'fill' => array(
                    'type'		=> PHPExcel_Style_Fill::FILL_SOLID,
                    'color'		=> array('argb' => 'FFFFFFFF')
                    ),
                'borders' => array(
                    'left'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        ),
                    'right'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        ),
                    'bottom'     => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN ,
                        'color' => array(
                            'rgb' => '3a2a47'
                            )
                        )
                    ),
                'alignment' =>  array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_LEFT,
                        'vertical'   => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                        'wrap'          => TRUE
                )
            )
     );

    //-----------------------fin estilos
    $objPHPExcel->setActiveSheetIndex(0);
    //-------------------------valorizacion
    // $objPHPExcel->getActiveSheet()->getStyle('B3:I3')->applyFromArray($estiloTituloReporte);
    $objPHPExcel->getActiveSheet()->getStyle('B5:I5')->applyFromArray($estiloTituloColumnas_val);		
    $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion_val, "B$inicio_reg:I".($i-1)); 
    //$objPHPExcel->getActiveSheet()->getStyle("G".($i+1).":I".($n-1))->applyFromArray($estiloInformacion_val);		    
    //$estiloInfIzquierda
    $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInfIzquierda_val, "B$inicio_reg:B".($i-1)); 
    
    $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion_val, "G".($i).":I".($i+4)); 

    //----------ancho de columnas
     $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('B')->setWidth(13.71);
     $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('C')->setWidth(13.71);
     $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('D')->setWidth(13.71);
     $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('E')->setWidth(13.71);
     $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('F')->setWidth(13.71);
     $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('G')->setWidth(13.71);
     $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('H')->setWidth(13.71);
     $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('I')->setWidth(13.71);

     //---------------------------------------------------
     //FLETE--------------
     // deja 3 espacios
    $n += 4;
    //----------------------Flete si existe-------------------------------------        
    $n_ac = $n;
    
    if (count($flete) > 0) //si hay flete
    {
        // Se agregan los titulos del reporte
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("E".($n-3).":I".($n-3));
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B".($n-1).":H".($n-1));

        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('E'.($n-3),$tituloFl)
                ->setCellValue('B'.($n-1),$titulosColumnas[0])
                ->setCellValue("I".($n-1),$titulosColumnas[3]);

        for ($j = 0; $j < count($flete); $j++) {            
            $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:H$n");
            $objPHPExcel->setActiveSheetIndex(0)                    
                    ->setCellValue("B$n",  $flete[$j]['concepto'])
                    ->setCellValue("I$n",  $flete[$j]['monto']);
            $n++;
        }

        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('G'.$n,  "Valor Venta S/.")
                ->setCellValue('I'.$n,  "=ROUND(SUM(I$n_ac:I".($n-1)."),2)");
        $n++;

        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");                
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('G'.$n,  "I.G.V. 18% S/.")
                ->setCellValue('I'.$n,  "=ROUND(PRODUCT(I".($n-1).",0.18),2)");
        $n++;

        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");                
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('G'.$n,  "Total S/.")
                ->setCellValue('I'.$n,  "=ROUND(SUM(I".($n-2).":I".($n-1)."),2)");
        $total_2 = $n;
        $n++;

        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");                
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('G'.$n,  "Detracción 4% S/.")
                ->setCellValue('I'.$n,  "=ROUND(PRODUCT(I".($n-1).",0.04),2)");
        $detrac_2 = $n;
        $n++;

        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$n:F$n");
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:H$n");                
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('G'.$n,  "Importe Neto S/.")
                ->setCellValue('I'.$n,  "=ROUND(I".($n-2)."-I".($n-1).",2)");
        $neto_2 = $n;
        $n++;

        $objPHPExcel->getActiveSheet()->getStyle("B".($n_ac-1).":I".($n_ac-1))->applyFromArray($estiloTituloColumnas_val);		
        $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion_val, "B$n_ac:I".($n-1));                
        $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInfIzquierda_val, "B$n_ac:H".($n-1));

        //----------ancho de columnas
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('B')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('C')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('D')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('E')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('F')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('G')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('H')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('I')->setWidth(13.71);

    } // Flete

    // deja espacio
    $n +=4;
    $n_n = $n;

    $for_tot ="";
    $for_det = "";
    $for_net = "";

    if ($total_2 == 0)
    {
        $for_tot = "=I$total_1";
    }else
    {
        $for_tot = "=ROUND(I$total_1+I$total_2,2)";
    }
    if ($detrac_2 == 0)
    {
        $for_det = "=I$detrac_1";
    }  else {
        $for_det = "=ROUND(I$detrac_1+I$detrac_2,2)";
    }
    if ($neto_2 == 0)
    {
        $for_net = "=I$neto_1";
    }  else {
        $for_net = "=ROUND(I$neto_1+I$neto_2,2)";
    }

    // Total a pagar
    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("F$n:H$n");
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('F'.$n,  "TOTAL A PAGAR")
            ->setCellValue('I'.$n,  $for_tot);
    $n++;

    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("F$n:H$n");
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('F'.$n,  "TOTAL DETRACCIÓN A PAGAR")
            ->setCellValue('I'.$n, $for_det );
    $n++;

    $objPHPExcel->setActiveSheetIndex(0)->mergeCells("F$n:H$n");
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('F'.$n,  "TOTAL NETO A PAGAR")
            ->setCellValue('I'.$n, $for_net );


    $objPHPExcel->getActiveSheet()->getStyle("F".($n_n).":I".($n))->applyFromArray($estiloTotales_val);
//--------------------------------------------------------------------------------------    

    $clienteNom = $misDatos[0]['cliente'];

    //elimina la ultima apgina en blanco
    $objPHPExcel->removeSheetByIndex($p);
    // Se activa la hoja para que sea la que se muestre cuando el archivo se abre
    $objPHPExcel->setActiveSheetIndex(0);

    // Se envia el archivo al navegador web, con el nombre que se indica (Excel2007)
    header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    header('Content-Disposition: attachment;filename="Valorización_acumulada_DET_'.$clienteNom.'.xlsx"');
    header('Cache-Control: max-age=0');
    $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
    $objWriter->save('php://output');
    exit;
        
}
else{
        print_r('No hay resultados para mostrar');
}