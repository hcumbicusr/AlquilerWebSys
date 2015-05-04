<?php
session_start();
if (empty($_SESSION['sessionID']))
{
    header("Location: ../");
}
if (empty($_GET['desde']) || empty($_GET['hasta']))
{
    header("Location: ../site/panel/ct_list_guias.php");
}

require '../Config.inc.php';
include_once '../configuration/Funciones.php';

//-------------------------------------------------
// Muestra solo las guias que presentan almenos un consumo 
$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();

list($dia,$mes,$anio) = explode("/", $_GET['desde']);
$desde = $anio."-".$mes."-".$dia;
//die(var_dump($desde));

list($dia,$mes,$anio) = explode("/", $_GET['hasta']);
$hasta = $anio."-".$mes."-".$dia;

$input = "'$desde','$hasta','MQ'";
//echo "sp_listar_guias_fechas($input)";
//die();
$misDatos = $objDB->selectManager()->spSelect($con, "sp_listar_guias_fechas", $input); //DATOS DE LA TABLA

for ($i = 0; $i < count($misDatos); $i++)
{
    if (!empty($misDatos[$i]['fecha_compra']))
    {
        list($anio,$mes,$dia) = explode("-", $misDatos[$i]['fecha_compra']);
        $misDatos[$i]['fecha_compra'] = $dia."/".$mes."/".$anio;
    }    
    
    if (!empty($misDatos[$i]['fecha_abast']))
    {
        list($anio,$mes,$dia) = explode("-", $misDatos[$i]['fecha_abast']);
        $misDatos[$i]['fecha_abast'] = $dia."/".$mes."/".$anio;
    }    
}

$fech_act = utf8_decode(date("d/m/Y H:i:s"));

$titulo = "GUÍAS DE COMBUSTIBLE";
$subtitulo = "DE ".$_GET['desde']." AL ".$_GET['hasta'];

$total_1 = 0;
$total_2 = 0;
$detrac_1 = 0;
$detrac_2 = 0;
$neto_1 = 0;
$neto_2 = 0;

if(count($misDatos) > 0){    
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
        $objDrawing->setCoordinates('A1');
        $objDrawing->setWorksheet($objPHPExcel->getActiveSheet()); 
        //fin: incluir una imagen

    // Se asignan las propiedades del libro
    $objPHPExcel->getProperties()->setCreator("Piuramaq S.R.L.") //Autor
                                             ->setLastModifiedBy("Piuramaq S.R.L. [".$_SESSION['apenom']."]") //Ultimo usuario que lo modificó
                                             ->setTitle("Guías de combustible")
                                             ->setSubject("Guías de combustible de".$_GET['desde']." al ".$_GET['hasta'])
                                             ->setDescription("Guías de combustible")
                                             ->setKeywords("Guías de combustible")
                                             ->setCategory("Reporte excel");

//    $tituloReporte = "COMBUSTIBLE CONSUMIDO POR: ".$vehiculo;
//    $tituloReporteOp = "OPERADOR: ".$operario;
/* FECHA	"FACTURA O 
TICKET"	"Nº FACTURA 
TICKET"	"NUMERO DE OPERACIÓN 
O CHEQUE"	Nº  DE GUIA	TOTAL DE INGRESADO		INGRESO	MAQUINARIA	Nº VALE	ABASTECIMIENTO	"HORÓMETRO 
 KILOMETRAJE"	CONTOMETRO	TRANSPORTISTA	STOCK
   */ 
    $titulosColumnas = array(
        'FECHA',
        'COMPROBANTE',
        'N° COMPR.',
        'N° OPERACIÓN / CHEQUE',
        'N° GUÍA',
        'TOTAL INGRESADO',
        'INGRESO',
        'MAQUINARIA',
        'N° VALE',
        'ABASTECIMIENTO',
        'HOROMETRO',
        'TRANSPORTISTA',
        'STOCK');        
    
    $inicio_reg = 6;
    //------------------cliente - obra
        $objPHPExcel->setActiveSheetIndex(0)
                    ->mergeCells('E1:I1'); 
        $objPHPExcel->setActiveSheetIndex(0)
                    ->mergeCells('E2:I2'); 
        
        //-------Titulo
        //$objPHPExcel->setActiveSheetIndex(0)->mergeCells('B3:I3');
        //$objPHPExcel->setActiveSheetIndex(0)->mergeCells('B5:F5');

        // Se agregan los titulos del reporte
        $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('E1',$titulo)
                ->setCellValue('E2',$subtitulo)           
                ->setCellValue('A4',$titulosColumnas[0])
                ->setCellValue('B4',$titulosColumnas[1])
                ->setCellValue('C4',$titulosColumnas[2])
                ->setCellValue('D4',$titulosColumnas[3])
                ->setCellValue('E4',$titulosColumnas[4])
                ->setCellValue('F4',$titulosColumnas[5])
                ->setCellValue('G4',$titulosColumnas[6])
                ->setCellValue('H4',$titulosColumnas[7])
                ->setCellValue('I4',$titulosColumnas[8])
                ->setCellValue('J4',$titulosColumnas[9])
                ->setCellValue('K4',$titulosColumnas[10])
                ->setCellValue('L4',$titulosColumnas[11])
                ->setCellValue('M4',$titulosColumnas[12]);
        
        //Se agregan los datos 
        $i = $inicio_reg;
//        $hr_consumo = 0;
//        $rendimiento = 0;
//        $valor = 0;
        
                
        $guia_act = "";
        $ant = 0;
        $puntero = $i;
        
        for ($j = 0; $j < count($misDatos); $j++) {  
            
            //$puntero = $i;            
            
            if (!empty($misDatos[$j-1]['nro_guia']))
            {
                $guia_act = $misDatos[$j-1]['nro_guia'];
                //$puntero = $i;
                
                if ($guia_act != $misDatos[$j]['nro_guia'])
                {
                    $guia_act = $misDatos[$j-1]['nro_guia'];
                    
                    $objPHPExcel->setActiveSheetIndex(0)                    
                            ->setCellValue('A'.$puntero,  $misDatos[$j]['fecha_compra'])
                            ->setCellValue('B'.$puntero,  $misDatos[$j]['tipo_comprobante'])
                            ->setCellValue('C'.$puntero,  $misDatos[$j]['nro_comprobante'])
                            ->setCellValue('D'.$puntero,  $misDatos[$j]['nro_operacion_ch'])
                            ->setCellValue('E'.$puntero,  $misDatos[$j]['nro_guia'])
                            ->setCellValue('F'.$puntero,  $misDatos[$j]['cantidad']);
                    $puntero = $i;
                }  else {
                    //$puntero = $i;
                }
            }else
            {
                $objPHPExcel->setActiveSheetIndex(0)                    
                        ->setCellValue('A'.$i,  $misDatos[$j]['fecha_compra'])
                        ->setCellValue('B'.$i,  $misDatos[$j]['tipo_comprobante'])
                        ->setCellValue('C'.$i,  $misDatos[$j]['nro_comprobante'])
                        ->setCellValue('D'.$i,  $misDatos[$j]['nro_operacion_ch'])
                        ->setCellValue('E'.$i,  $misDatos[$j]['nro_guia'])
                        ->setCellValue('F'.$i,  $misDatos[$j]['cantidad']);
                
                $puntero = $i;
                
            }
            $objPHPExcel->setActiveSheetIndex(0)                                        
                    ->setCellValue('G'.$i,  $misDatos[$j]['fecha_abast'])
                    ->setCellValue('H'.$i,  $misDatos[$j]['vehiculo'])
                    ->setCellValue('I'.$i,  $misDatos[$j]['nro_vale'])
                    ->setCellValue('J'.$i,  $misDatos[$j]['cant_combustible'])
                    ->setCellValue('K'.$i,  $misDatos[$j]['horometro'])
                    ->setCellValue('L'.$i,  $misDatos[$j]['operario'])
                    ->setCellValue('M'.$i,  "=ROUND(M".($i-1)."+F$i-J$i,2)");                    
            $i++;
        }
        $n = $i;
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("A$n:E$n"); // total
        $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A'.$n,  "TOTAL COMPRADO");
        
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("G$n:I$n"); // total
        $objPHPExcel->setActiveSheetIndex(0)->setCellValue('G'.$n,  "TOTAL ABASTECIDO");                       
        
        $objPHPExcel->setActiveSheetIndex(0)->mergeCells("A".($n+1).":E".($n+1));
        $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A'.($n+1),  "SALDO GLOBAL");
        
        //$objPHPExcel->setActiveSheetIndex(0)->setCellValue('L'.($n-1),  "STOCK");
        
        $objPHPExcel->setActiveSheetIndex(0)                
                ->setCellValue('F'.$n,  "=ROUND(SUM(F".($inicio_reg-1).":F".($n-1)."),2)") // total ingresado
                ->setCellValue('J'.$n,  "=ROUND(SUM(J".($inicio_reg-1).":J".($n-1)."),2)") //total abastecido
                ->setCellValue('H'.($n+1),  "=ROUND(F".($n)."-J".($n).",2)"); // saldo global
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
        $objPHPExcel->getActiveSheet()->getStyle('A4:M4')->applyFromArray($estiloTituloColumnas);		
        $objPHPExcel->getActiveSheet()->setSharedStyle($estiloInformacion, "A".($inicio_reg-1).":M".($n));                

        //----------ancho de columnas
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('A')->setWidth(13.71);         
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('B')->setWidth(15.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('C')->setWidth(15.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('D')->setWidth(15.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('E')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('F')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('G')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('H')->setWidth(35.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('I')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('J')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('K')->setWidth(13.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('L')->setWidth(35.71);
         $objPHPExcel->setActiveSheetIndex(0)->getColumnDimension('M')->setWidth(13.71);
         
         //---------------------------------------------------        
                
        // Se asigna el nombre a la hoja
        $objPHPExcel->getActiveSheet()->setTitle($titulo);

        // Se activa la hoja para que sea la que se muestre cuando el archivo se abre
        $objPHPExcel->setActiveSheetIndex(0);
        // Inmovilizar paneles 
        //$objPHPExcel->getActiveSheet(0)->freezePane('A4');
        $objPHPExcel->getActiveSheet(0)->freezePaneByColumnAndRow(0,5);
        //DIE();
        // Se envia el archivo al navegador web, con el nombre que se indica (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="GUÍAS_'.$fech_act.'.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $objWriter->save('php://output');
        exit;
}
else{
        print_r('No hay resultados para mostrar');
}