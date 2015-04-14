<?php

Class DetalleAlquiler {
    private $id_detallealquiler;
    private $id_contrato;
    private $id_alquiler;
    private $id_vehiculoph;
    private $id_articulo;
    private $fecha;
    private $estado;
    private $observacion;
    private $precio_alq;

    public function getPrecio_alq() {
        return $this->precio_alq;
    }

    public function setPrecio_alq($precio_alq) {
        $this->precio_alq = $precio_alq;
    }
    
    public function getId_detallealquiler() {
        return $this->id_detallealquiler;
    }

    public function getId_contrato() {
        return $this->id_contrato;
    }

    public function getId_alquiler() {
        return $this->id_alquiler;
    }

    public function getId_articulo() {
        return $this->id_articulo;
    }

    public function getFecha() {
        return $this->fecha;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function getObservacion() {
        return $this->observacion;
    }

    public function setId_detallealquiler($id_detallealquiler) {
        $this->id_detallealquiler = $id_detallealquiler;
    }

    public function setId_contrato($id_contrato) {
        $this->id_contrato = $id_contrato;
    }

    public function setId_alquiler($id_alquiler) {
        $this->id_alquiler = $id_alquiler;
    }  

    public function setId_articulo($id_articulo) {
        $this->id_articulo = $id_articulo;
    }

    public function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }

    public function setObservacion($observacion) {
        $this->observacion = $observacion;
    }
    
    public function getId_vehiculoph() {
        return $this->id_vehiculoph;
    }

    public function setId_vehiculoph($id_vehiculoph) {
        $this->id_vehiculoph = $id_vehiculoph;
    }
    
    //----------------------------------------------------------------------------------
    public function registrarDetalleAlquiler()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_detalle_alquiler_v";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_contrato().","
                ."".$this->getId_vehiculoph().","
                ."".$this->getId_articulo().","
                ."'".$this->getFecha()."',"
                ."'".$this->getEstado()."',"
                ."'".$this->getObservacion()."',"
                ."".$this->getPrecio_alq()."";
        
        //die(var_dump($input));
                
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //----------------------------------------------------------------------------------
    public function registrarDetalleAlquiler_art()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_detalle_alquiler_ar";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_contrato().","
                ."".$this->getId_vehiculoph().","
                ."".$this->getId_articulo().","
                ."'".$this->getFecha()."',"
                ."'".$this->getEstado()."',"
                ."'".$this->getObservacion()."',"
                ."".$this->getPrecio_alq()."";
        
        //die(var_dump($input));
                
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    
    public function registrarDevolucionVH()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_devolucion_vehiculo";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_detallealquiler().","
                ."'".$this->getEstado()."',"
                ."'".$this->getObservacion()."',"                
                ."'".$this->getFecha()."'";
        
        //die(var_dump($input));
                
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    public function registrarDevolucionART()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_devolucion_articulo";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_detallealquiler().","
                ."'".$this->getEstado()."',"
                ."'".$this->getObservacion()."',"                
                ."'".$this->getFecha()."'";
        
        //die(var_dump($input));
                
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //---------------------------------- anulacion del alquiler solo si no se ha asignado un operario .-------------
    public function anularAlquilerVH()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_anular_alquiler_vehiculo";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_detallealquiler()."";
        
        //die(var_dump($input));
                
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //----------------------------------------------------------------------------------
    public function listarAquilerVehiculos()
    {
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        $result = $objDB->selectManager()->spSelect($con, "sp_listar_alquiler_vehiculos",  $this->getId_alquiler());
        return $result;
    }
    //----------------------------------------------------------------------------------
    public function datosContratoxAlquiler()
    {
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        $result = $objDB->selectManager()->spSelect($con, "sp_datos_contrato_x_alquiler",  $this->getId_alquiler());
        return $result;
    }
    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }

}