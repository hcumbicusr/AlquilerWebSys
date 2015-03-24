<?php

Class Abastecimiento {
    protected $id_abastecimiento;
    protected $id_tipocomprobante;
    protected $id_tipocombustible;
    protected $fecha;
    protected $nro_comprobante;
    protected $nro_operacion_ch;
    protected $abastecedor;
    protected $cantidad;
    protected $precio_u;
    protected $total;
    
    public function getId_abastecimiento() {
        return $this->id_abastecimiento;
    }

    public function getId_tipocomprobante() {
        return $this->id_tipocomprobante;
    }

    public function getId_tipocombustible() {
        return $this->id_tipocombustible;
    }

    public function getFecha() {
        return $this->fecha;
    }

    public function getNro_comprobante() {
        return $this->nro_comprobante;
    }

    public function getNro_operacion_ch() {
        return $this->nro_operacion_ch;
    }

    public function getAbastecedor() {
        return $this->abastecedor;
    }

    public function getCantidad() {
        return $this->cantidad;
    }

    public function getPrecio_u() {
        return $this->precio_u;
    }

    public function getTotal() {
        return $this->total;
    }

    public function setId_abastecimiento($id_abastecimiento) {
        $this->id_abastecimiento = $id_abastecimiento;
    }

    public function setId_tipocomprobante($id_tipocomprobante) {
        $this->id_tipocomprobante = $id_tipocomprobante;
    }

    public function setId_tipocombustible($id_tipocombustible) {
        $this->id_tipocombustible = $id_tipocombustible;
    }

    public function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    public function setNro_comprobante($nro_comprobante) {
        $this->nro_comprobante = $nro_comprobante;
    }

    public function setNro_operacion_ch($nro_operacion_ch) {
        $this->nro_operacion_ch = $nro_operacion_ch;
    }

    public function setAbastecedor($abastecedor) {
        $this->abastecedor = $abastecedor;
    }

    public function setCantidad($cantidad) {
        $this->cantidad = $cantidad;
    }

    public function setPrecio_u($precio_u) {
        $this->precio_u = $precio_u;
    }

    public function setTotal($total) {
        $this->total = $total;
    }
    
    //----------------------------------------------------------------------------------
     public function registrarAbastecimiento()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_abastecimiento";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_tipocomprobante().","
                ."".$this->getId_tipocombustible().","
                ."'".$this->getFecha()."',"
                ."'".$this->getNro_comprobante()."',"
                ."'".$this->getNro_operacion_ch()."',"
                ."'".$this->getAbastecedor()."',"
                ."".$this->getCantidad().","
                ."".$this->getPrecio_u().","
                ."".$this->getTotal()."";
        
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
     public function editarAbastecimiento()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_abastecimiento";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_abastecimiento().","
                ."".$this->getId_tipocomprobante().","
                ."".$this->getId_tipocombustible().","
                ."'".$this->getFecha()."',"
                ."'".$this->getNro_comprobante()."',"
                ."'".$this->getNro_operacion_ch()."',"
                ."'".$this->getAbastecedor()."',"
                ."".$this->getCantidad().","
                ."".$this->getPrecio_u().","
                ."".$this->getTotal()."";
        
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
    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }

}