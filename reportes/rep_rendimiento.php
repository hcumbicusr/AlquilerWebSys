<?php
session_start();
if (empty($_SESSION['sessionID']))
{
    header("Location: ../");
}
if (empty($_GET['vehiculo']) || empty($_GET['desde']) || empty($_GET['hasta']))
{
    header("Location: ../site/panel/REP_rendimiento.php");
}
//die();
require '../Config.inc.php';
include_once '../configuration/Funciones.php';

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();

//echo Funciones::encodeStrings(21,2);

$id= Funciones::decodeStrings($_GET['vehiculo'], 2);
list($dia,$mes,$anio) = explode("/", $_GET['desde']);
$desde = $anio."-".$mes."-".$dia;

list($dia,$mes,$anio) = explode("/", $_GET['hasta']);
$hasta = $anio."-".$mes."-".$dia;

$input = "'$desde','$hasta',$id";

$misDatos = $objDB->selectManager()->spSelect($con, "sp_REP_rendimiento", $input); //DATOS DE LA TABLA

$operario[] = "";

for ($i = 0; $i < count($misDatos); $i++)
{
    $operario[] = $misDatos[$i]['operario'];
    list($anio,$mes,$dia) = explode('-', $misDatos[$i]['f_parte']);
    $misDatos[$i]['f_parte'] = $dia.'/'.$mes.'/'.$anio;
}

//die(var_dump($misDatos));
$operario = array_unique($operario);

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

//die(var_dump($operario));

if(count($misDatos) > 0 ){    
    if (PHP_SAPI == 'cli')
    {
        die('Este archivo solo se puede ver desde un navegador web');
    }
    /** Se agrega la libreria PHPExcel */
    require_once '../libraries/PHPExcel/PHPExcel.php';
    
    // Se crea el objeto PHPExcel
    $objPHPExcel = new PHPExcel();
    $arr = array('[',']'); 
    $misDatos[0]['vehiculo'] = str_replace($arr, ' ', $misDatos[0]['vehiculo']);

    // Se asignan las propiedades del libro
    $objPHPExcel->getProperties()->setCreator("Piuramaq S.R.L.") //Autor
                                             ->setLastModifiedBy("Piuramaq S.R.L. [".$_SESSION['apenom']."]") //Ultimo usuario que lo modificó
                                             ->setTitle("Reporte Rendimiento")
                                             ->setSubject("Reporte de Rendimiento para ".$misDatos[0]['vehiculo']." / $operario")
                                             ->setDescription("Reporte de Rendimiento")
                                             ->setKeywords("reporte rendimiento vehiculos operarios")
                                             ->setCategory("Reporte excel");

    $tituloReporte = "HORAS TRABAJADAS POR: ".$misDatos[0]['vehiculo'];
    $tituloReporteOp = "OPERADOR: ".$operario;
    
    $titulosColumnas = array(
        'FECHA', 
        'Nro. PARTE', 
        'HORAS TRABAJADAS', 
        'MINUTOS',
        'TOTAL HORAS',
        'PETRÓLEO',
        'HOROM. ABASTECIMIENTO',
        'HORAS CONSUMO',
        'RENDIMIENTO',
        'INICIO HORÓMETRO',
        'TÉRMINO HORÓMETRO',
        ' -- ',
        'MANTENIMIENTOS'
        );
        //-------Titulo
        $objPHPExcel->setActiveSheetIndex(0)
                    ->mergeCells('B2:N2');
        $objPHPExcel->setActiveSheetIndex(0)
                    ->mergeCells('B3:F3');        

        // Se agregan los titulos del reporte
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('B2',$tituloReporte)
                ->setCellValue('B3',$tituloReporteOp)
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
                ->setCellValue('N5',$titulosColumnas[12]) ;

        
        
        //Se agregan los datos 
        $i = 7;
        $hr_consumo = 0;
        $rendimiento = 0;
        $valor = 0;
        
        for ($j = 0; $j < count($misDatos); $j++) {
            //var_dump("<- $j -> ".$misDatos[$j-1]['horom_abast']);
            
            // -------> eq = 0
            $valor = $misDatos[$j]['horometro_fin'] - $misDatos[$j]['horometro_inicio'] - $misDatos[$j]['total_h'];
            //die(var_dump($valor));
            if ($j == 0)
            {
                $objPHPExcel->setActiveSheetIndex(0)                    
                        ->setCellValue('B'.$i,  $misDatos[$j]['f_parte'])
                        ->setCellValue('C'.$i,  $misDatos[$j]['nro_parte'])
                        ->setCellValue('D'.$i,  $misDatos[$j]['hrs'])
                        ->setCellValue('E'.$i,  $misDatos[$j]['minuto'])
                        ->setCellValue('F'.$i,  $misDatos[$j]['total_h'])
                        ->setCellValue('G'.$i,  $misDatos[$j]['petroleo'])
                        ->setCellValue('H'.$i,  $misDatos[$j]['horom_abast'])
                        ->setCellValue('I'.$i,  0)
                        ->setCellValue('J'.$i,  0)
                        ->setCellValue('K'.$i,  $misDatos[$j]['horometro_inicio'])
                        ->setCellValue('L'.$i,  $misDatos[$j]['horometro_fin'])
                        ->setCellValue('M'.$i,  $valor)
                        ->setCellValue('N'.$i,  $misDatos[$j]['mantenimiento']);
            }else
            {
                $hr_consumo = $misDatos[$j]['horom_abast']-$misDatos[$j-1]['horom_abast'];
                if ($hr_consumo == 0)
                {
                    $rendimiento = 0;
                }else
                {
                    $rendimiento = round($misDatos[$j]['petroleo']/$hr_consumo,2);
                }                
                
                $objPHPExcel->setActiveSheetIndex(0)                    
                        ->setCellValue('B'.$i,  $misDatos[$j]['f_parte'])
                        ->setCellValue('C'.$i,  $misDatos[$j]['nro_parte'])
                        ->setCellValue('D'.$i,  $misDatos[$j]['hrs'])
                        ->setCellValue('E'.$i,  $misDatos[$j]['minuto'])
                        ->setCellValue('F'.$i,  $misDatos[$j]['total_h'])
                        ->setCellValue('G'.$i,  $misDatos[$j]['petroleo'])
                        ->setCellValue('H'.$i,  $misDatos[$j]['horom_abast'])
                        ->setCellValue('I'.$i,  $hr_consumo)
                        ->setCellValue('J'.$i,  $rendimiento)
                        ->setCellValue('K'.$i,  $misDatos[$j]['horometro_inicio'])
                        ->setCellValue('L'.$i,  $misDatos[$j]['horometro_fin'])
                        ->setCellValue('M'.$i,  $valor)
                        ->setCellValue('N'.$i,  $misDatos[$j]['mantenimiento']);
                
            }
            
            $i++;
        }
        //die();
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
                            )             
                        ),
                    'alignment' =>  array(
                            'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_RIGHT,
                            'vertical'   => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                            'wrap'          => TRUE
                    )
                )
         );

        $objPHPExcel->getActiveSheet()->getStyle('B2:N2')->applyFromArray($estiloTituloReporte);
        $objPHPExcel->getActiveSheet()->getStyle('B5:N5')->applyFromArray($estiloTituloColumnas);		
        $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "B6:N".($i-1));

//        for($i = 'B'; $i <= 'N'; $i++){
//                $objPHPExcel->setActiveSheetIndex(0)			
//                        ->getColumnDimension($i)->setAutoSize(TRUE);
//        }
        //----------ancho de columnas
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('B')->setWidth(11.71);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('C')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('D')->setWidth(16.29);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('E')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('F')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('G')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('H')->setWidth(17.71);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('I')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('J')->setWidth(14.14);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('K')->setWidth(13.14);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('L')->setWidth(13.14);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('M')->setWidth(10.71);
         $objPHPExcel->setActiveSheetIndex(0)	
                 ->getColumnDimension('N')->setWidth(48.14);
         
        
        //incluir una imagen
        $objDrawing = new PHPExcel_Worksheet_Drawing();
        $objDrawing->setPath('../site/img/logo_rep.jpg'); //ruta
        $objDrawing->setHeight(40); //altura
        $objDrawing->setCoordinates('B1');
        $objDrawing->setWorksheet($objPHPExcel->getActiveSheet()); //incluir la imagen
        //fin: incluir una imagen

        // Se asigna el nombre a la hoja
        $objPHPExcel->getActiveSheet()->setTitle($misDatos[0]['vehiculo']);

        // Se activa la hoja para que sea la que se muestre cuando el archivo se abre
        $objPHPExcel->setActiveSheetIndex(0);
        // Inmovilizar paneles 
        //$objPHPExcel->getActiveSheet(0)->freezePane('A4');
        $objPHPExcel->getActiveSheet(0)->freezePaneByColumnAndRow(0,6);

        // Se manda el archivo al navegador web, con el nombre que se indica (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="Reporte_Rendimiento_'.$misDatos[0]['vehiculo'].'.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $objWriter->save('php://output');
        exit;
}
else{
        print_r('No hay resultados para mostrar');
}