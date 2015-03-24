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

$misDatos = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_cliente_obra_xls", $input); //DATOS DE LA TABLA

$con = $objDB->selectManager()->connect();
$flete = $objDB->selectManager()->spSelect($con, "sp_REP_valorizacion_cliente_flete", $input); //DATOS DE LA TABLA
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

$total_1 = 0;
$total_2 = 0;
$detrac_1 = 0;
$detrac_2 = 0;
$neto_1 = 0;
$neto_2 = 0;

if(count($misDatos) > 0 ){    
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

    for ($i = 0; $i < count($misDatos); $i++)
    {
        $vehiculos[] = $misDatos[$i]['vehiculo'];
        $operario[] = $misDatos[$i]['operario'];
        list($anio,$mes,$dia) = explode('-', $misDatos[$i]['fecha']);
        $misDatos[$i]['fecha'] = $dia.'/'.$mes.'/'.$anio;
    }

    //die(var_dump($misDatos));
    $vehiculos = array_unique($vehiculos);
    $operario = array_unique($operario);
    //print_r("<pre>");
    //var_dump($vehiculos);    
    //cantidad de paginas que se debe crear
    $cant_pag = count($vehiculos);// FOR <=
    $arr = array('[',']'); 
    $vehiculos = substr(str_replace($arr, '', $vehiculos), 0,25);
    //print_r("</pre>");
    //die();
    //---------------------------------------------------------------------------        
    
    // primero se crean las pagina de detalle, y al  final la pagina de resumen
    for ($w = 0; $w < $cant_pag; $w++) {
        // $w == id_pagina
        // --- pagina
        $p = $w+1;
        //incluir una imagen
        $objDrawing = new PHPExcel_Worksheet_Drawing();
        $objDrawing->setPath('../site/img/logo_rep.jpg'); //ruta
        $objDrawing->setHeight(40); //altura
        $objDrawing->setCoordinates('B1');
        $objDrawing->setWorksheet($objPHPExcel->getActiveSheet()); 
        //fin: incluir una imagen                   
        
        //------------------cliente - obra
        $objPHPExcel->setActiveSheetIndex($p)
                    ->mergeCells('E1:N1'); 
        $objPHPExcel->setActiveSheetIndex($p)
                    ->mergeCells('E2:N2'); 
        
        //-------Titulo
        $objPHPExcel->setActiveSheetIndex($p)
                    ->mergeCells('B3:N3');
        $objPHPExcel->setActiveSheetIndex($p)
                    ->mergeCells('B4:G4'); 
        
    } //fin de página       

    $vehiculo = "";
    $operario = $operario;
    
    //encabezados de cada tabla
    
    
    $titulosColumnas = array(
        'EQUIPO',
        'TOTAL HORAS',
        'COSTO POR HORA S/.',
        'TOTAL');        
    
    $inicio_reg = 6;
    //------------------cliente - obra
        $objPHPExcel->setActiveSheetIndex(0)
                    ->mergeCells('E1:I1'); 
        $objPHPExcel->setActiveSheetIndex(0)
                    ->mergeCells('E2:I2'); 
        
        //-------Titulo
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells('B3:I3');
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells('B5:F5');

        // Se agregan los titulos del reporte
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('E1',$titulo)
                ->setCellValue('E2',$subtitulo)
                ->setCellValue('B3',$clienteCod."  ".$clienteNom)
                ->setCellValue('B4','')                
                ->setCellValue('B5',$titulosColumnas[0])
                ->setCellValue('G5',$titulosColumnas[1])
                ->setCellValue('H5',$titulosColumnas[2])
                ->setCellValue('I5',$titulosColumnas[3]);
        
        //Se agregan los datos 
        $i = $inicio_reg;
//        $hr_consumo = 0;
//        $rendimiento = 0;
//        $valor = 0;
        
        for ($j = 0; $j < count($misDatos); $j++) {            
            $objPHPExcel->setActiveSheetIndex(0)->mergeCells("B$i:F$i");
            $objPHPExcel->setActiveSheetIndex(0)                    
                    ->setCellValue('B'.$i,  $misDatos[$j]['vehiculo'])
                    ->setCellValue('G'.$i,  "=ROUND(".utf8_decode(number_format($misDatos[$j]['total_horas'], 2).",2)"))
                    ->setCellValue('H'.$i,  "=ROUND(".utf8_decode(number_format($misDatos[$j]['precio_alq'], 2).",2)"))
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
        $estiloTituloReporte = array(
            
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

        $estiloTituloColumnas = array(
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
                    'argb' => 'FFA4A4A4'
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
                            )
                        ),
                    'alignment' =>  array(
                            'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_RIGHT,
                            'vertical'   => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                            'wrap'          => TRUE
                    )
                )
         );
        
        //-----------------------fin estilos
        
        //-------------------------valorizacion
        $objPHPExcel->getActiveSheet()->getStyle('B3:I3')->applyFromArray($estiloTituloReporte);
        $objPHPExcel->getActiveSheet()->getStyle('B5:I5')->applyFromArray($estiloTituloColumnas);		
        $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "B$inicio_reg:I".($n-1));                

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
                    ->setCellValue('G'.$n,  "Detracción 10% S/.")
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
        
            $objPHPExcel->getActiveSheet()->getStyle("B".($n_ac-1).":I".($n_ac-1))->applyFromArray($estiloTituloColumnas);		
            $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "B$n_ac:I".($n-1));                

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
        
        
        $objPHPExcel->getActiveSheet()->getStyle("F".($n_n).":I".($n))->applyFromArray($estiloTituloColumnas);		
        
        // Se asigna el nombre a la hoja
        $objPHPExcel->getActiveSheet()->setTitle($titulo);

        // Se activa la hoja para que sea la que se muestre cuando el archivo se abre
        $objPHPExcel->setActiveSheetIndex(0);
        // Inmovilizar paneles 
        //$objPHPExcel->getActiveSheet(0)->freezePane('A4');
        //$objPHPExcel->getActiveSheet(0)->freezePaneByColumnAndRow(0,6);

        // Se envia el archivo al navegador web, con el nombre que se indica (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="Valorización_acumulada_'.$clienteNom.'.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $objWriter->save('php://output');
        exit;
}
else{
        print_r('No hay resultados para mostrar');
}