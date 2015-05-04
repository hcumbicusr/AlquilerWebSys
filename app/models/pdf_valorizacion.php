<?php
require('../libraries/fpdf/fpdf.php');
 
class PDF extends FPDF
{   
    protected $salto = 55; // inicio Y de la cabecera
    protected $total_val = 0;
    protected $total_flet = 0;
    protected $neto_val = 0; // valor neto de valorizacion
    protected $neto_flete = 0; //valor neto de flete
    protected $detraccion_val = 0; //detraccion de valorizacion
    protected $detraccion_flet = 0; //detraccion de flete
    
    public function getSalto() {
        return $this->salto;
    }

    public function getTotal_val() {
        return $this->total_val;
    }

    public function getTotal_flet() {
        return $this->total_flet;
    }

    public function getNeto_val() {
        return $this->neto_val;
    }

    public function getNeto_flete() {
        return $this->neto_flete;
    }

    public function getDetraccion_val() {
        return $this->detraccion_val;
    }

    public function getDetraccion_flet() {
        return $this->detraccion_flet;
    }

    public function setSalto($salto) {
        $this->salto = $salto;
    }

    public function setTotal_val($total_val) {
        $this->total_val = $total_val;
    }

    public function setTotal_flet($total_flet) {
        $this->total_flet = $total_flet;
    }

    public function setNeto_val($neto_val) {
        $this->neto_val = $neto_val;
    }

    public function setNeto_flete($neto_flete) {
        $this->neto_flete = $neto_flete;
    }

    public function setDetraccion_val($detraccion_val) {
        $this->detraccion_val = $detraccion_val;
    }

    public function setDetraccion_flet($detraccion_flet) {
        $this->detraccion_flet = $detraccion_flet;
    }

    //-------------------------------------------------------------------    
    function getIGV () // Config.inc.php
    {
        global $config;
        return $config['igv'];
    }
    function getDETRACCION ()// Config.inc.php
    {
        global $config;
        return $config['detraccion'];
    }
     function getDETRACCION_flete ()// Config.inc.php
    {
        global $config;
        return $config['detraccion_f'];
    }
    function getHFila()
    {
        return 6;
    }
    
    //-..------------------
    function generales($cabecera) {
        /******Datos generales de la cabecera*******/        
        $fila = $cabecera;
        //$y = 23; // altura de TITULO
        //Logo de la Empresa
        $this->Image('../site/img/logo_rep.jpg',15,10, 'JPEG');
        
        //Fecha
        $this->SetFont('Arial','', 8);
        $this->SetXY(133,10);
        $this->Cell(14, 8,  utf8_decode('Fecha de Impresión: '.date("d/m/Y H:i:s")), 0, 'L');
        
        //Texto de Título
        $this->SetFont('Arial','B',12);
        $this->SetXY(40, 23);
        
        $desde = $_GET['desde'];
        $hasta = $_GET['hasta'];
        
        $this->MultiCell(120, 9, utf8_decode("VALORIZACIÓN ACUMULADA ".$fila[0]['nombre']), 0, 'C');
        $this->Ln();$this->SetXY(70, 37);
        $this->MultiCell(79, 9, utf8_decode(" DE $desde AL $hasta"), 0, 'C');
        
        //Texto 
        //$this->SetFont('Arial','', 10);
        //$this->SetXY(75, 45);
        //$this->MultiCell(110, 4, utf8_decode('CLIENTE'), 0, 'J');
        
        //DATOS
        $this->SetFont('Arial','', 9);
        $this->SetXY(20,45);

        /*Datos del Manifiesto*/      
    }
    
    function cabeceraHorizontal()
    {
        $salto = $this->getSalto();
        $this->SetXY(10,$salto);
        $this->SetFont('Arial','B',10);
        $this->SetFillColor(255, 204, 75); //anaranjado
        $this->SetTextColor(0, 0, 0); //Letra color blanco
        //**************************************
        $this->CellFitSpace(110,  $this->getHFila(), utf8_decode('Equipo'),1, 0 , 'C', true);
        $this->CellFitSpace(23,$this->getHFila(), utf8_decode('Tot. Horas'),1, 0 , 'C', true);
        $this->CellFitSpace(23,$this->getHFila(), utf8_decode('Cost. Hora S/.'),1, 0 , 'C', true);
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode('Total'),1, 0 , 'C', true);
        //$this->CellFitSpace(30,7, utf8_decode('Estado'),1, 0 , 'L', true);
    }
    
    function datosHorizontal($datos)
    {
        $fila = $datos;
        $salto = $this->getSalto()+$this->getHFila();
        $this->SetXY(10,$salto);
        $this->SetFont('Arial','',10);
        $this->SetFillColor(229, 229, 229); //Gris tenue de cada fila
        $this->SetTextColor(3, 3, 3); //Color del texto: Negro
        $bandera = false; //Para alternar el relleno
        //while($fila = mysql_fetch_array($datos)){ 
        //foreach($fila AS $key => $value) { $fila[$key] = stripslashes($value); }            
        // -------- parte de calculo
        $tot_venta = 0;        
        //------------------------------------
        for ($i = 0;$i < count($fila); $i++) {      
            $tot_horas = 0;
        
            if($fila[$i]['valoriza'] == 'HR')
            {
                $tot_horas = $fila[$i]['total'];
            }elseif($fila[$i]['valoriza'] == 'HM')
            {
                $tot_horas = $fila[$i]["hora_min"];
            }
            //Usaremos CellFitSpace en lugar de Cell
            $this->CellFitSpace(110,$this->getHFila(), utf8_decode($fila[$i]['vehiculo']),1, 0 , 'L');
            $this->CellFitSpace(23,$this->getHFila(), utf8_decode(number_format($fila[$i]['total_horas'], 2)),1, 0 , 'R');
            $this->CellFitSpace(23,$this->getHFila(), utf8_decode(number_format($fila[$i]['precio_alq'], 2)),1, 0 , 'R');
            $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($fila[$i]['total'], 2)),1, 0 , 'R');
            //$this->CellFitSpace(30,7, utf8_decode($fila[$i]['estado']),1, 0 , 'L', $bandera );
            $salto+=$this->getHFila();
            $this->Ln();//Salto de línea para generar otra fila
            $bandera = !$bandera;//Alterna el valor de la bandera
            //-----------------------------calculo
            $tot_venta+=$fila[$i]['total']; // total bruto del alquiler            
        }
        
        $val_igv = round($tot_venta*($this->getIGV()/100), 2);
        $total = $tot_venta + $val_igv;
        
        // ----- detraccion
        $detraccion = round($total*($this->getDETRACCION()/100), 2);
        
        // importe neto de valorizacion
        $neto_val = round($total - $detraccion, 2);
        
        $this->setTotal_val($total);
        $this->setNeto_val($neto_val);
        $this->setDetraccion_val($detraccion);
        
        //die(var_dump(number_format($tot_venta, 2),$val_igv,$total,$detraccion,$neto_val));
        
        ////--------------en el PDF
        //Importe val        
        $this->SetFont('Arial','',10);        
        $this->SetXY(120,$salto);
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("Valor Venta S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($tot_venta, 2)),1, 0 , 'R');
        
        $salto+=$this->getHFila();
        $this->SetXY(120,$salto);        
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("IGV ".$this->getIGV()."% S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($val_igv, 2)),1, 0 , 'R');
        
        $salto+=$this->getHFila();                
        $this->SetXY(120,$salto);
        $this->SetFont('Arial','B',10);
        $this->SetFillColor(255, 204, 75); //anaranjado                
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("Total S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($total, 2)),1, 0 , 'R');
        
        $salto+=$this->getHFila();
        $this->SetFont('Arial','',10); 
        $this->SetXY(120,$salto);        
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("Detracción ".$this->getDETRACCION()."% S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($detraccion, 2)),1, 0 , 'R');
        
        $salto+=$this->getHFila();
        $this->SetFont('Arial','B',10);
        $this->SetFillColor(255, 204, 75); //anaranjado               
        $this->SetXY(120,$salto);        
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("Importe Neto S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($neto_val, 2)),1, 0 , 'R');
        
        $salto+=$this->getHFila(); //ultimo salto
        $this->setSalto($salto);
    }
    //----------------- FLETES DE MAQUINARIA--------------------------------------------------------
    function cabeceraHorizontalSec2()
    {        
        $salto = $this->getSalto()+$this->getHFila();
        
        //Texto de Título sec 2
        $this->SetFont('Arial','B',12);
        $this->SetXY(70, $salto);        
        
        $this->MultiCell(65, 9, utf8_decode("FLETES DE MAQUINARIA"), 0, 'C');
        
        $salto+=$this->getHFila()+3;
        
        $this->SetXY(10,$salto);
        $this->SetFont('Arial','B',10);
        $this->SetFillColor(255, 204, 75); //anaranjado
        $this->SetTextColor(0, 0, 0); //Letra color blanco
        //**************************************
        $this->CellFitSpace(156,  $this->getHFila(), utf8_decode('Equipo'),1, 0 , 'C', true);
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode('Total'),1, 0 , 'C', true);
        //$this->CellFitSpace(30,7, utf8_decode('Estado'),1, 0 , 'L', true);
        
        $this->setSalto($salto);
    }
    
    function datosHorizontalSec2($datos)
    {
        $fila = $datos;
        $salto = $this->getSalto()+$this->getHFila();
        $this->SetXY(10,$salto);
        $this->SetFont('Arial','',10);
        $this->SetFillColor(229, 229, 229); //Gris tenue de cada fila
        $this->SetTextColor(3, 3, 3); //Color del texto: Negro
        $bandera = false; //Para alternar el relleno
        //while($fila = mysql_fetch_array($datos)){ 
        //foreach($fila AS $key => $value) { $fila[$key] = stripslashes($value); }            
        // -------- parte de calculo
        $tot_venta = 0;        
        //------------------------------------
        for ($i = 0;$i < count($fila); $i++) {              
            //Usaremos CellFitSpace en lugar de Cell
            $this->CellFitSpace(156,$this->getHFila(), utf8_decode($fila[$i]['concepto']),1, 0 , 'L');
            $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($fila[$i]['monto'], 2)),1, 0 , 'R');
            //$this->CellFitSpace(30,7, utf8_decode($fila[$i]['estado']),1, 0 , 'L', $bandera );
            $salto+=$this->getHFila();
            $this->Ln();//Salto de línea para generar otra fila
            $bandera = !$bandera;//Alterna el valor de la bandera
            //-----------------------------calculo
            $tot_venta+=$fila[$i]['monto']; // total bruto del alquiler            
        }
        
        $val_igv = round($tot_venta*($this->getIGV()/100), 2);
        $total = $tot_venta + $val_igv;
        
        // ----- detraccion
        $detraccion = round($total*($this->getDETRACCION_flete()/100), 2);
        
        // importe neto de valorizacion
        $neto_val = round($total - $detraccion, 2);
        
        $this->setTotal_flet($total);
        $this->setNeto_flete($neto_val);
        $this->setDetraccion_flet($detraccion);
        
        //die(var_dump(number_format($tot_venta, 2),$val_igv,$total,$detraccion,$neto_val));
        
        ////--------------en el PDF
        //Importe val        
        $this->SetFont('Arial','',10);        
        $this->SetXY(120,$salto);
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("Valor Venta S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($tot_venta, 2)),1, 0 , 'R');
        
        $salto+=$this->getHFila();
        $this->SetXY(120,$salto);        
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("IGV ".$this->getIGV()."% S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($val_igv, 2)),1, 0 , 'R');
        
        $salto+=$this->getHFila();                
        $this->SetXY(120,$salto);
        $this->SetFont('Arial','B',10);
        $this->SetFillColor(255, 204, 75); //anaranjado                
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("Total S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($total, 2)),1, 0 , 'R');
        
        $salto+=$this->getHFila();
        $this->SetFont('Arial','',10); 
        $this->SetXY(120,$salto);        
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("Detracción ".$this->getDETRACCION_flete()."% S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($detraccion, 2)),1, 0 , 'R');
        
        $salto+=$this->getHFila();
        $this->SetFont('Arial','B',10);
        $this->SetFillColor(255, 204, 75); //anaranjado               
        $this->SetXY(120,$salto);        
        $this->CellFitSpace(46,$this->getHFila(), utf8_decode("Importe Neto S/."),1, 0 , 'L');
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode(number_format($neto_val, 2)),1, 0 , 'R');        
        
        $this->setSalto($salto);
    }        
    
    //----------------------------RESUMEN DEL TOTAL-----------------------------------------------------------
    
     function resumenTotales()
    {        
        $salto = $this->getSalto()+$this->getHFila()*3;
        
        // operaciones
        $total = $this->getTotal_val() +  $this->getTotal_flet();
        $detraccion = $this->getDetraccion_val() +  $this->getDetraccion_flet();
        $neto = $this->getNeto_val() + $this->getNeto_flete();
                      
        $this->SetXY(40,$salto);        
        $this->SetFont('Arial','B',10);
        $this->SetFillColor(219, 219, 219); //Gris tenue de cada fila        
        $this->SetTextColor(0, 0, 0); //Letra color blanco
        
        //**************************************
        $salto+=$this->getHFila();
        $this->CellFitSpace(126,  $this->getHFila(), utf8_decode('TOTAL A PAGAR'),1, 0 , 'C', true);
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode('S/. '.  number_format($total, 2)),1, 0 , 'R', true);
        
        $this->SetXY(40,$salto);
        $salto+=$this->getHFila();
        $this->CellFitSpace(126,  $this->getHFila(), utf8_decode('TOTAL DETRACCIÓN A PAGAR'),1, 0 , 'C', true);
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode('S/. '.  number_format($detraccion, 2)),1, 0 , 'R', true);
        //$this->CellFitSpace(30,7, utf8_decode('Estado'),1, 0 , 'L', true);
        
        $this->SetXY(40,$salto);
        $salto+=$this->getHFila();
        $this->CellFitSpace(126,  $this->getHFila(), utf8_decode('TOTAL NETO A PAGAR'),1, 0 , 'C', true);
        $this->CellFitSpace(30,$this->getHFila(), utf8_decode('S/. '.  number_format($neto, 2)),1, 0 , 'R', true);
        $this->setSalto($salto);
    }
    
    //----------------------------------------------------------------------------------------------------
 
    function cuentasPagar($cuentas)
    {        
        $salto = $this->getSalto()+$this->getHFila()*3;        
                      
        $this->SetXY(10,$salto);        
        $this->SetFont('Arial','B',10);
        $this->SetFillColor(255, 255, 255); //Gris tenue de cada fila        
        $this->SetTextColor(0, 0, 255); //Letra color blanco                       
        $this->CellFitSpace(100,  $this->getHFila(), utf8_decode($cuentas[0]['banco']),0, 0 , 'L', true);
        $this->CellFitSpace(60,  $this->getHFila(), utf8_decode("Nro.Cta."),0, 0 , 'C', true);
        
        $salto+=$this->getHFila();
        $this->SetXY(10,$salto);        
        $this->SetFont('Arial','',10);
        $this->SetFillColor(255, 255, 255); //Gris tenue de cada fila        
        $this->SetTextColor(0, 0, 0); //Letra color blanco
        $this->CellFitSpace(100,$this->getHFila(), utf8_decode($cuentas[0]['descripcion']),0, 0 , 'L', true);               
        $this->CellFitSpace(60,  $this->getHFila(), utf8_decode($cuentas[0]['cuenta']),0, 0 , 'C', true);               
        
        $salto+=$this->getHFila();
        $this->SetXY(10,$salto);        
        $this->SetFont('Arial','',10);
        $this->SetFillColor(255, 255, 255); //Gris tenue de cada fila        
        $this->SetTextColor(0, 0, 0); //Letra color blanco
        $this->CellFitSpace(100,$this->getHFila(), utf8_decode($cuentas[1]['descripcion']),0, 0 , 'L', true);              
        $this->CellFitSpace(60,  $this->getHFila(), utf8_decode($cuentas[1]['cuenta']),0, 0 , 'C', true);    
        
        $salto+=$this->getHFila();
        $this->SetXY(10,$salto);        
        $this->SetFont('Arial','B',10);
        $this->SetFillColor(255, 255, 255); //Gris tenue de cada fila        
        $this->SetTextColor(0, 0, 255); //Letra color blanco                       
        $this->CellFitSpace(100,  $this->getHFila(), utf8_decode($cuentas[2]['banco']),0, 0 , 'L', true);
        
        $salto+=$this->getHFila();
        $this->SetXY(10,$salto);        
        $this->SetFont('Arial','',10);
        $this->SetFillColor(255, 255, 255); //Gris tenue de cada fila        
        $this->SetTextColor(0, 0, 0); //Letra color blanco
        $this->CellFitSpace(100,$this->getHFila(), utf8_decode($cuentas[2]['descripcion']),0, 0 , 'L', true);
        $this->CellFitSpace(60,  $this->getHFila(), utf8_decode($cuentas[2]['cuenta']),0, 0 , 'C', true);
    }
    
    //----------------------------------------------------------------------------------------------------
    
    function tablaHorizontal($datosHorizontal,$cabecera,$cuentas,$datosFlete = NULL) //por si posee movilizacion de maquinaria
    {
        $this->generales($cabecera);
        $this->cabeceraHorizontal();
        $this->datosHorizontal($datosHorizontal);
        if (!empty($datosFlete))
        {
            $this->cabeceraHorizontalSec2();
            $this->datosHorizontalSec2($datosFlete);
        }
        $this->resumenTotales();
        //$this->cuentasPagar($cuentas);
    }
    //***** Aquí comienza código para ajustar texto *************
    //***********************************************************
    function CellFit($w, $h=0, $txt='', $border=0, $ln=0, $align='', $fill=false, $link='', $scale=false, $force=true)
    {
        //Get string width
        $str_width=$this->GetStringWidth($txt);
 
        //Calculate ratio to fit cell
        if($w==0)
            $w = $this->w-$this->rMargin-$this->x;
        $ratio = ($w-$this->cMargin*2)/$str_width;
 
        $fit = ($ratio < 1 || ($ratio > 1 && $force));
        if ($fit)
        {
            if ($scale)
            {
                //Calculate horizontal scaling
                $horiz_scale=$ratio*100.0;
                //Set horizontal scaling
                $this->_out(sprintf('BT %.2F Tz ET',$horiz_scale));
            }
            else
            {
                //Calculate character spacing in points
                $char_space=($w-$this->cMargin*2-$str_width)/max($this->MBGetStringLength($txt)-1,1)*$this->k;
                //Set character spacing
                $this->_out(sprintf('BT %.2F Tc ET',$char_space));
            }
            //Override user alignment (since text will fill up cell)
            $align='';
        }
 
        //Pass on to Cell method
        $this->Cell($w,$h,$txt,$border,$ln,$align,$fill,$link);
 
        //Reset character spacing/horizontal scaling
        if ($fit)
            $this->_out('BT '.($scale ? '100 Tz' : '0 Tc').' ET');
    }
 
    function CellFitSpace($w, $h=0, $txt='', $border=0, $ln=0, $align='', $fill=false, $link='')
    {
        $this->CellFit($w,$h,$txt,$border,$ln,$align,$fill,$link,false,false);
    }
 
    //Patch to also work with CJK double-byte text
    function MBGetStringLength($s)
    {
        if($this->CurrentFont['type']=='Type0')
        {
            $len = 0;
            $nbbytes = strlen($s);
            for ($i = 0; $i < $nbbytes; $i++)
            {
                if (ord($s[$i])<128)
                    $len++;
                else
                {
                    $len++;
                    $i++;
                }
            }
            return $len;
        }
        else
            return strlen($s);
    }
//************** Fin del código para ajustar texto *****************
//******************************************************************
} // FIN Class PDF