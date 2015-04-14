<?php
session_start();
if (empty($_SESSION['sessionID']))
{
    header("Location: ../");
}
if (empty($_GET['vehiculo']) || empty($_GET['desde']) || empty($_GET['hasta']))
{
    header("Location: ../site/panel/adm_list_vehiculos.php");
}

require '../Config.inc.php';
include_once '../configuration/Funciones.php';

//-------------------------------------------------
$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
$id= Funciones::decodeStrings($_GET['vehiculo'], 2);

list($dia,$mes,$anio) = explode("/", $_GET['desde']);
$desde = $anio."-".$mes."-".$dia;
//die(var_dump($desde));

list($dia,$mes,$anio) = explode("/", $_GET['hasta']);
$hasta = $anio."-".$mes."-".$dia;

$input = "$id,'$desde','$hasta'";

$con = $objDB->selectManager()->connect();
$misDatos = $objDB->selectManager()->spSelect($con, "sp_historial_maquinaria_fechas", $input); //DATOS DE LA TABLA

$fech_act = utf8_decode(date("d/m/Y H:i:s"));

$titulo = "HISTORIAL DE ALQUILER DE MAQUINARIA";
$subtitulo = "DE ".$_GET['desde']." AL ".$_GET['hasta'];
$vehiculo = $misDatos[0]['nombre_c'];
$arr = array('[',']'); 
$vehiculo_c = str_replace($arr, '_', $misDatos[0]['nombre']);

for ($i = 0; $i < count($misDatos); $i++)
{        
    list($anio,$mes,$dia) = explode('-', $misDatos[$i]['fecha']);
    $misDatos[$i]['fecha'] = $dia.'/'.$mes.'/'.$anio;
}

if(count($misDatos) > 0 ){    
    if (PHP_SAPI == 'cli')
    {
        die('Este archivo solo se puede ver desde un navegador web');
    }
    /** Se agrega la libreria PHPExcel */
    require_once '../libraries/PHPExcel/PHPExcel.php';
    
    // Se crea el objeto PHPExcel
    $objPHPExcel = new PHPExcel();    
    
    //incluir una imagen
        $objDrawing = new PHPExcel_Worksheet_Drawing();
        $objDrawing->setPath('../site/img/logo_rep.jpg'); //ruta
        $objDrawing->setHeight(40); //altura
        $objDrawing->setCoordinates('B1');
        $objDrawing->setWorksheet($objPHPExcel->getActiveSheet()); 
        //fin: incluir una imagen

    // Se asignan las propiedades del libro
    $objPHPExcel->getProperties()->setCreator("Piuramaq S.R.L.") //Autor
                                             ->setLastModifiedBy("Piuramaq S.R.L. [".$_SESSION['apenom']."]") //Ultimo usuario que lo modificó
                                             ->setTitle("Reporte Historial de maquinaria")
                                             ->setSubject("Historial de maquinaria de".$_GET['desde']." al ".$_GET['hasta'])
                                             ->setDescription("Historial de maquinaria")
                                             ->setKeywords("reporte Historial de maquinaria")
                                             ->setCategory("Reporte excel");
    
    $titulosColumnas = array(
        'Nro.',
        'FECHA',
        'CLIENTE',
        'OBRA',                
        'PRECIO ALQ. S/.',
        'NRO. PARTE',
        'OPERADOR',
        'LUGAR DE TRABAJO',
        'LABOR',
        'OBSERVACIÓN',
        'HOROM. INICIO',
        'HOROM. FIN',
        'HORAS',
        'MINUTOS',
        'TOTAL HORAS',
        'NRO. VALE',
        'HOROM. ABAST.',        
        'COMBUSTIBLE',
        'HRS. CONSUMO',
        'RENDIMIENTO',
        'CONTROLADOR');        
    
    $inicio_reg = 7;
    //------------------cliente - obra
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells('E1:I1'); //
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells('E2:I2'); //
        
        //-------Titulo
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells('B3:I3'); //DATOS DEL VEHICULO
//        $objPHPExcel->setActiveSheetIndex(0)->mergeCells('B5:F5');

        // Se agregan los titulos del reporte
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('E1',$titulo)
                ->setCellValue('E2',$subtitulo)
                ->setCellValue('B3',$vehiculo)
                ->setCellValue('B4',"Generado: $fech_act")                
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
                ->setCellValue('N5',$titulosColumnas[12])
                ->setCellValue('O5',$titulosColumnas[13])
                ->setCellValue('P5',$titulosColumnas[14])
                ->setCellValue('Q5',$titulosColumnas[15])
                ->setCellValue('R5',$titulosColumnas[16])
                ->setCellValue('S5',$titulosColumnas[17])
                ->setCellValue('T5',$titulosColumnas[18])
                ->setCellValue('U5',$titulosColumnas[19])
                ->setCellValue('V5',$titulosColumnas[20]);
                
                
        
        //Se agregan los datos 
        $i = $inicio_reg;

        for ($j = 0; $j < count($misDatos); $j++) {                        
            $objPHPExcel->setActiveSheetIndex(0)                    
                    ->setCellValue('B'.$i,  $j+1)
                    ->setCellValue('C'.$i,  $misDatos[$j]['fecha'])
                    ->setCellValue('D'.$i,  $misDatos[$j]['cliente'])
                    ->setCellValue('E'.$i,  $misDatos[$j]['obra'])
                    ->setCellValue('F'.$i,  $misDatos[$j]['precio_alq'])
                    ->setCellValue('G'.$i,  $misDatos[$j]['nro_parte'])
                    ->setCellValue('H'.$i,  $misDatos[$j]['operario'])
                    ->setCellValue('I'.$i,  $misDatos[$j]['lugar_trabajo'])
                    ->setCellValue('J'.$i,  $misDatos[$j]['tarea'])
                    ->setCellValue('K'.$i,  $misDatos[$j]['observacion'])
                    ->setCellValue('L'.$i,  $misDatos[$j]['horometro_inicio'])
                    ->setCellValue('M'.$i,  $misDatos[$j]['horometro_fin'])
                    ->setCellValue('N'.$i,  $misDatos[$j]['hrs'])
                    ->setCellValue('O'.$i,  $misDatos[$j]['minuto'])
                    ->setCellValue('P'.$i,  $misDatos[$j]['total_h'])
                    ->setCellValue('Q'.$i,  $misDatos[$j]['nro_vale'])
                    ->setCellValue('R'.$i,  $misDatos[$j]['horom_abast'])
                    ->setCellValue('S'.$i,  $misDatos[$j]['cant_combustible'])
                    ->setCellValue('T'.$i,  "=ROUND(R".($i)."-R".($i-1).",2)")
                    ->setCellValue('U'.$i,  "=ROUND(T".($i)."-S".($i).",2)")
                    ->setCellValue('V'.$i,  $misDatos[$j]['responsable']);
            $i++;
        }
        
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
        $objPHPExcel->getActiveSheet()->getStyle('B5:V5')->applyFromArray($estiloTituloColumnas);		
        $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "B".($inicio_reg-1).":V".($i-1));               

        //----------ancho de columnas
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('B')->setWidth(5);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('C')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('D')->setWidth(30);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('E')->setWidth(30);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('F')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('G')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('H')->setWidth(30);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('I')->setWidth(30);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('J')->setWidth(30);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('K')->setWidth(30);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('L')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('M')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('N')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('O')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('P')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('Q')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('R')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('S')->setWidth(17);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('T')->setWidth(12);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('U')->setWidth(17);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('V')->setWidth(30);
         
         //---------------------------------------------------      

        // Se asigna el nombre a la hoja
        $objPHPExcel->getActiveSheet()->setTitle($vehiculo_c);

        // Se activa la hoja para que sea la que se muestre cuando el archivo se abre
        $objPHPExcel->setActiveSheetIndex(0);
        // Inmovilizar paneles 
        //$objPHPExcel->getActiveSheet(0)->freezePane('A4');
        $objPHPExcel->getActiveSheet(0)->freezePaneByColumnAndRow(0,6);
        //die();
        // Se envia el archivo al navegador web, con el nombre que se indica (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="Historial_'.$vehiculo_c.'.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $objWriter->save('php://output');
        exit;
}
else{
        print_r('No hay resultados para mostrar');
}