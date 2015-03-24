<?php

Class Mantenimiento {
    
    protected $id_mantenimiento;
    protected $id_vehiculo;
    protected $causa;
    protected $descripcion;
    protected $lugar_av;
    protected $lugar_mant;
    protected $f_ingreso;
    protected $f_salida;
    protected $estado_actual;
    protected $costo;
    protected $horometro;
    protected $kilometraje;
    
    
    public function getHorometro() {
        return $this->horometro;
    }

    public function getKilometraje() {
        return $this->kilometraje;
    }

    public function setHorometro($horometro) {
        $this->horometro = $horometro;
    }

    public function setKilometraje($kilometraje) {
        $this->kilometraje = $kilometraje;
    }   

    public function getId_mantenimiento() {
        return $this->id_mantenimiento;
    }

    public function getId_vehiculo() {
        return $this->id_vehiculo;
    }

    public function getCausa() {
        return $this->causa;
    }

    public function getDescripcion() {
        return $this->descripcion;
    }

    public function getLugar_av() {
        return $this->lugar_av;
    }

    public function getLugar_mant() {
        return $this->lugar_mant;
    }

    public function getF_ingreso() {
        return $this->f_ingreso;
    }

    public function getF_salida() {
        return $this->f_salida;
    }

    public function getEstado_actual() {
        return $this->estado_actual;
    }

    public function getCosto() {
        return $this->costo;
    }

    public function setId_mantenimiento($id_mantenimiento) {
        $this->id_mantenimiento = $id_mantenimiento;
    }

    public function setId_vehiculo($id_vehiculo) {
        $this->id_vehiculo = $id_vehiculo;
    }

    public function setCausa($causa) {
        $this->causa = $causa;
    }

    public function setDescripcion($descripcion) {
        $this->descripcion = $descripcion;
    }

    public function setLugar_av($lugar_av) {
        $this->lugar_av = $lugar_av;
    }

    public function setLugar_mant($lugar_mant) {
        $this->lugar_mant = $lugar_mant;
    }

    public function setF_ingreso($f_ingreso) {
        $this->f_ingreso = $f_ingreso;
    }

    public function setF_salida($f_salida) {
        $this->f_salida = $f_salida;
    }

    public function setEstado_actual($estado_actual) {
        $this->estado_actual = $estado_actual;
    }

    public function setCosto($costo) {
        $this->costo = $costo;
    }

    
    //----------------------------------------------------------------------------------
     public function registrarMantenimiento()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_mantenimiento";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_vehiculo().","
                ."'".$this->getCausa()."',"
                ."'".$this->getDescripcion()."',"
                ."'".$this->getLugar_av()."',"
                ."'".$this->getLugar_mant()."',"
                ."".$this->getHorometro().","
                ."".$this->getKilometraje().","
                ."'".$this->getF_ingreso()."',"
                ."'".$this->getF_salida()."',"
                ."'".$this->getEstado_actual()."',"
                ."".$this->getCosto()."";
        
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
