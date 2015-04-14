<?php
session_start();
if (empty($_SESSION['sessionID']))
{
    header("Location: ../");
}
if (empty($_GET['contrato']))
{
    header("Location: ../site/panel/");
}

require '../Config.inc.php';
include_once '../configuration/Funciones.php';

/** Se agrega la libreria PHPExcel */
require_once '../libraries/PHPExcel/PHPExcel.php';

// Se crea el objeto PHPExcel
$objPHPExcel = new PHPExcel();

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();

$contrato= Funciones::decodeStrings($_GET['contrato'], 2);

$input = "$contrato";
$detalle_alq = $objDB->selectManager()->spSelect($con, "sp_listar_vehiculos_x_contrato", $input); //DATOS DE LA TABLA
//die(var_dump($detalle_alq));
$p = 0;

// Se asignan las propiedades del libro
    $objPHPExcel->getProperties()->setCreator("Piuramaq S.R.L.") //Autor
                                             ->setLastModifiedBy("Piuramaq S.R.L. [".$_SESSION['apenom']."]") //Ultimo usuario que lo modificó
                                             ->setTitle("Reporte Total Consumo: (".$detalle_alq[0]['cliente']."-".$detalle_alq[0]['obra'].")")
                                             ->setSubject("Reporte Total de consumo")
                                             ->setDescription("Reporte de consumo")
                                             ->setKeywords("reporte consumo vehiculos operarios")
                                             ->setCategory("Reporte excel");
    
     $titulosColumnas = array(
            'FECHA', 
            'Nro. PARTE', 
            'HORAS TRABAJADAS', 
            'MINUTOS',
            'TOTAL HORAS',
            'PETRÓLEO',
            'HOROMETRO ABAST.',
            'HORAS CONSUMO',
            'RENDIMIENTO',
            'INICIO HORÓMETRO',
            'TÉRMINO HORÓMETRO',
            '-',
            'LUGAR / MANTENIMIENTOS / CONSECUENCIAS'
            );
     
     $inicio_reg = 7;
    
     $cont = 0;

for ($w = 0; $w < count($detalle_alq); $w++) {                  
         
    $con = $objDB->selectManager()->connect();
    $misDatos = $objDB->selectManager()->spSelect($con, "sp_REP_consumo_detal", $detalle_alq[$w]['id_detallealquiler']); //DATOS DE LA TABLA       
        
    //-----Horometro anterior
    $con = $objDB->selectManager()->connect();
    $input = "'".$misDatos[0]['f_alquiler']."',".$misDatos[0]['id_vehiculo'];
    $horom = $objDB->selectManager()->spSelect($con, "sp_horometro_anterior", $input); //Horometro
    $horom_ant = $horom[0]['horom_ant']; // horometro anterior a este reporte
    $petroleo_ant = $horom[0]['petroleo']; // petroleo anterior
    //--------------------------------fin horom

    if(count($misDatos) > 0 ){    
    if (PHP_SAPI == 'cli')
    {
        die('Este archivo solo se puede ver desde un navegador web');
    }
        $operario = "";
        $cliente = $misDatos[0]['cliente'];
        $obra = $misDatos[0]['obra'];
        $vehiculo = $misDatos[0]['vehiculo'];
        //die(var_dump($misDatos));
        for ($i = 0; $i < count($misDatos); $i++)
        {
            //$operario[$i] = $misDatos[$i]['operario'];
            list($anio,$mes,$dia) = explode('-', $misDatos[$i]['fecha']);
            $misDatos[$i]['fecha'] = $dia.'/'.$mes.'/'.$anio;
        }
        //$operario = array_unique($operario);
        //die(var_dump($operario));
        $arr = array('[',']'); 
        $vehiculo = substr(str_replace($arr, '', $vehiculo), 0,25);          
        
        
        if (count($operario) > 1)
        {
            $aux = "";
            for ($i = 1; $i < count($operario); $i++)
            {
                $aux .= $operario[$i]." - ";        
            }
            $operario = substr($aux, 0, -3);
        }else
        {
            $operario = $misDatos[0]['operario'];
        }                                       
        
        $tituloReporte = "COMBUSTIBLE CONSUMIDO POR: ".$vehiculo;
        $tituloReporteOp = "OPERADOR: ".$operario;        
        
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

        // Se agregan los titulos del reporte
        $objPHPExcel->setActiveSheetIndex($p)
                ->setCellValue('E1',$cliente)
                ->setCellValue('E2',$obra)
                ->setCellValue('B3',$tituloReporte)
                ->setCellValue('B4',$tituloReporteOp)                
                ->setCellValue('B5',$titulosColumnas[0])
                ->setCellValue('C5',$titulosColumnas[1])
                ->setCellValue('D5',$titulosColumnas[2])
                ->setCellValue('E5',$titulosColumnas[3])
                ->setCellValue('F5',$titulosColumnas[4])
                ->setCellValue('G5',$titulosColumnas[5])
                ->setCellValue('H5',$titulosColumnas[6])
                ->setCellValue('I5',$titulosColumnas[7])
                ->setCellValue('J5',$titulosColumnas[8])
                ->setCellValue('K5',$titulosColumnas[9])
                ->setCellValue('L5',$titulosColumnas[10])
                ->setCellValue('M5',$titulosColumnas[11])
                ->setCellValue('N5',$titulosColumnas[12]);
        
        // Se asigna el nombre a la hoja
        $objPHPExcel->getActiveSheet()->setTitle($vehiculo);
                
        //Se agregan los datos 
        $i = 7;
        $hr_consumo = 0;
        $rendimiento = 0;
        $valor = 0;
        
        //--> Horometro de abastecimiento anterior a esta obra
        $objPHPExcel->setActiveSheetIndex($p)     
                ->setCellValue('G'.($i-1),  $petroleo_ant)
                ->setCellValue('H'.($i-1),  $horom_ant);
        
        for ($j = 0; $j < count($misDatos); $j++) {                        
            
            $objPHPExcel->setActiveSheetIndex($p)                    
                    ->setCellValue('B'.$i,  $misDatos[$j]['fecha'])
                    ->setCellValue('C'.$i,  $misDatos[$j]['nro_parte'])
                    ->setCellValue('D'.$i,  $misDatos[$j]['hrs'])
                    ->setCellValue('E'.$i,  $misDatos[$j]['minuto'])
                    ->setCellValue('F'.$i,  $misDatos[$j]['total_h'])
                    ->setCellValue('G'.$i,  $misDatos[$j]['petroleo'])
                    ->setCellValue('H'.$i,  $misDatos[$j]['horom_abast'])
                    ->setCellValue('I'.$i,  "=ROUND(H$i-H".($i-1).",2)")
                    ->setCellValue('J'.$i,  "=ROUND(I$i/G$i,2)")
                    ->setCellValue('K'.$i,  $misDatos[$j]['horometro_inicio'])
                    ->setCellValue('L'.$i,  $misDatos[$j]['horometro_fin'])
                    ->setCellValue('M'.$i,  "=ROUND(L$i-K$i-F$i,2)")
                    ->setCellValue('N'.$i,  $misDatos[$j]['lugar_mant']);
            $i++;
        }
        
        // pie de pagina totales
        $n = $i;
        $objPHPExcel->setActiveSheetIndex($p)
                ->mergeCells("B".($i+1).":C".($i+1))
                ->setCellValue('B'.($i+1),  "TOTAL")
                ->setCellValue('D'.($i+1),  "=SUM(D$inicio_reg:D$n)")
                ->setCellValue('E'.($i+1),  "=SUM(E$inicio_reg:E$n)")
                ->setCellValue('F'.($i+1),  "=SUM(F$inicio_reg:F$n)")
                ->setCellValue('G'.($i+1),  "=SUM(G$inicio_reg:G$n)")
                ->setCellValue('J'.($i+1),  "=SUM(J$inicio_reg:J$n)");
        
        // estilos
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
        
        $objPHPExcel->getActiveSheet()->getStyle('B3:N3')->applyFromArray($estiloTituloReporte);
        $objPHPExcel->getActiveSheet()->getStyle('B5:N5')->applyFromArray($estiloTituloColumnas);		
        $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "B6:N".($i+1));
        
        //----------ancho de columnas
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('B')->setWidth(11.71);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('C')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('D')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('E')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('F')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('G')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('H')->setWidth(17.71);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('I')->setWidth(13.57);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('J')->setWidth(13.86);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('K')->setWidth(17.71);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('L')->setWidth(17.71);  
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('M')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex($p)->getColumnDimension('N')->setWidth(30.57);
                
         // Inmovilizar paneles 
        //$objPHPExcel->getActiveSheet(0)->freezePane('A4');
        $objPHPExcel->getActiveSheet()->freezePaneByColumnAndRow(0,6);
                
        $p++;
        $objPHPExcel->createSheet($p);//creamos la pestaña        
        //incluir una imagen
        $objDrawing = new PHPExcel_Worksheet_Drawing();
        $objDrawing->setPath('../site/img/logo_rep.jpg'); //ruta
        $objDrawing->setHeight(40); //altura
        $objDrawing->setCoordinates('B1');
        $objDrawing->setWorksheet($objPHPExcel->getActiveSheet()); 
        //fin: incluir una imagen                
        
    }else
    {
        $cont++;
    }     
    
}
if ($cont == count($detalle_alq))
{
    echo "Sin datos para mostrar";
}
else
{
    //elimina la ultima apgina en blanco
        $objPHPExcel->removeSheetByIndex($p);
        // Se activa la hoja para que sea la que se muestre cuando el archivo se abre
        $objPHPExcel->setActiveSheetIndex(0);        

        // Se envia el archivo al navegador web, con el nombre que se indica (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header("Content-Disposition: attachment;filename=Reporte_Total_Consumo: (".$detalle_alq[0]['cliente']."-".$detalle_alq[0]['obra'].").xlsx");
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $objWriter->save('php://output');
        exit;
}