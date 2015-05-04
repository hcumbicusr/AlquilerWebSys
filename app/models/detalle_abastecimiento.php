<?php

Class DetalleAbastecimiento {
    protected $id_detalleabastecimiento;
    protected $abastecimiento;
    protected $id_vehiculo;
    protected $id_trabajador;
    protected $id_tipocombustible;
    protected $fecha;
    protected $nro_guia;
    protected $cantidad;
    protected $stock;
    protected $nro_placa;
    protected $nro_liciencia;
    protected $abastecedor;
    protected $vale_combustible;
    
    protected $f_desde;
    protected $f_hasta;
    protected $nro_comprobante;
    protected $ingreso;

    public function getIngreso() {
        return $this->ingreso;
    }

    public function setIngreso($ingreso) {
        $this->ingreso = $ingreso;
    }

    public function getVale_combustible() {
        return $this->vale_combustible;
    }

    public function setVale_combustible($vale_combustible) {
        $this->vale_combustible = $vale_combustible;
    }

    public function getId_detalleabastecimiento() {
        return $this->id_detalleabastecimiento;
    }

    public function getAbastecimiento() {
        return $this->abastecimiento;
    }

    public function getId_vehiculo() {
        return $this->id_vehiculo;
    }

    public function getId_trabajador() {
        return $this->id_trabajador;
    }

    public function getFecha() {
        return $this->fecha;
    }

    public function getNro_guia() {
        return $this->nro_guia;
    }

    public function getCantidad() {
        return $this->cantidad;
    }

    public function getStock() {
        return $this->stock;
    }

    public function getNro_placa() {
        return $this->nro_placa;
    }

    public function getNro_liciencia() {
        return $this->nro_liciencia;
    }

    public function setId_detalleabastecimiento($id_detalleabastecimiento) {
        $this->id_detalleabastecimiento = $id_detalleabastecimiento;
    }

    public function setAbastecimiento($abastecimiento) {
        $this->abastecimiento = $abastecimiento;
    }

    public function setId_vehiculo($id_vehiculo) {
        $this->id_vehiculo = $id_vehiculo;
    }

    public function setId_trabajador($id_trabajador) {
        $this->id_trabajador = $id_trabajador;
    }

    public function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    public function setNro_guia($nro_guia) {
        $this->nro_guia = $nro_guia;
    }

    public function setCantidad($cantidad) {
        $this->cantidad = $cantidad;
    }

    public function setStock($stock) {
        $this->stock = $stock;
    }

    public function setNro_placa($nro_placa) {
        $this->nro_placa = $nro_placa;
    }

    public function setNro_liciencia($nro_liciencia) {
        $this->nro_liciencia = $nro_liciencia;
    }
    
    public function getId_tipocombustible() {
        return $this->id_tipocombustible;
    }

    public function setId_tipocombustible($id_tipocombustible) {
        $this->id_tipocombustible = $id_tipocombustible;
    }
    public function getAbastecedor() {
        return $this->abastecedor;
    }

    public function setAbastecedor($abastecedor) {
        $this->abastecedor = $abastecedor;
    }
    public function getF_desde() {
        return $this->f_desde;
    }

    public function getF_hasta() {
        return $this->f_hasta;
    }

    public function setF_desde($f_desde) {
        $this->f_desde = $f_desde;
    }

    public function setF_hasta($f_hasta) {
        $this->f_hasta = $f_hasta;
    }
    public function getNro_comprobante() {
        return $this->nro_comprobante;
    }

    public function setNro_comprobante($nro_comprobante) {
        $this->nro_comprobante = $nro_comprobante;
    }

            
        //-------------------------------------------------------------------------
    
     public function registrarDetalleAbastecimiento()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_detalle_abastecimiento";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_tipocombustible().","
                ."'".$this->getNro_placa()."',"
                ."'".$this->getNro_liciencia()."',"
                ."'".$this->getFecha()."',"
                ."'".$this->getNro_guia()."',"
                ."".$this->getCantidad().","
                ."'".$this->getAbastecedor()."',"
                ."'".$this->getVale_combustible()."',"
                ."'".$this->getIngreso()."'";
        
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
    public function asignarGuiaFechas()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_asignar_guias_fechas";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."'".$this->getNro_comprobante()."',"
                ."'".$this->getF_desde()."',"
                ."'".$this->getF_hasta()."'";
                        
        //die(var_dump($input));
                
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result >= 0)
        {            
            $val = $result;
        }else if (empty ($result))
        {
            $val = false;
        }
        return $val;
    }
    
    //-------------------------------------------------------------------------
    public function desAsignarGuia()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_desasignar_guia";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_detalleabastecimiento()."";
                        
        //die(var_dump($input));
                
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }else if (empty ($result))
        {
            $val = false;
        }
        return $val;
    }
    
    public function editarDetalleAbastecimiento()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_detalle_abastecimiento";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_detalleabastecimiento().","
                ."".$this->getId_tipocombustible().","
                ."'".$this->getFecha()."',"
                ."'".$this->getNro_guia()."',"
                ."".$this->getCantidad().","
                ."'".$this->getAbastecedor()."',"
                ."'".$this->getNro_liciencia()."',"
                ."'".$this->getNro_placa()."',"
                ."'".$this->getVale_combustible()."'";
        
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
