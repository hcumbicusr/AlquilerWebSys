<?php

Class Transporte {
    protected $id_transporte;
    protected $id_detallealquiler;
    protected $concepto;
    protected $observacion;
    protected $fecha;
    protected $monto;
    
    public function getId_transporte() {
        return $this->id_transporte;
    }

    public function getId_detallealquiler() {
        return $this->id_detallealquiler;
    }

    public function getConcepto() {
        return $this->concepto;
    }

    public function getObservacion() {
        return $this->observacion;
    }

    public function getFecha() {
        return $this->fecha;
    }

    public function getMonto() {
        return $this->monto;
    }

    public function setId_transporte($id_transporte) {
        $this->id_transporte = $id_transporte;
    }

    public function setId_detallealquiler($id_detallealquiler) {
        $this->id_detallealquiler = $id_detallealquiler;
    }

    public function setConcepto($concepto) {
        $this->concepto = $concepto;
    }

    public function setObservacion($observacion) {
        $this->observacion = $observacion;
    }

    public function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    public function setMonto($monto) {
        $this->monto = $monto;
    }

    //-------------------------------------------------------------------------
    public function registrarFlete() // tabla transporte
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_flete";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_detallealquiler().","
                ."'".$this->getConcepto()."',"
                ."'".$this->getObservacion()."',"
                ."'".$this->getFecha()."',"
                ."".$this->getMonto()."";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //-------------------------------------------------------------------------
    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }

}