<?php

class Consumo {
    
    protected $id_consumo;
    protected $id_vehiculo;
    protected $id_trabajador;
    protected $id_responsable;
    protected $id_trabvehiculo;
    protected $id_tipocombustible;
    protected $id_detalleabastecimiento;
    protected $fecha;    
    protected $nro_guia;
    protected $nro_vale;
    protected $nro_surtidor;
    protected $cant_combustible;
    protected $horometro;
    protected $kilometraje;
    
    public function getId_consumo() {
        return $this->id_consumo;
    }

    public function getId_vehiculo() {
        return $this->id_vehiculo;
    }

    public function getId_trabajador() {
        return $this->id_trabajador;
    }

    public function getId_responsable() {
        return $this->id_responsable;
    }

    public function getId_tipocombustible() {
        return $this->id_tipocombustible;
    }

    public function getFecha() {
        return $this->fecha;
    }

    public function getNro_guia() {
        return $this->nro_guia;
    }

    public function getNro_surtidor() {
        return $this->nro_surtidor;
    }

    public function getCant_combustible() {
        return $this->cant_combustible;
    }

    public function setId_consumo($id_consumo) {
        $this->id_consumo = $id_consumo;
    }

    public function setId_vehiculo($id_vehiculo) {
        $this->id_vehiculo = $id_vehiculo;
    }

    public function setId_trabajador($id_trabajador) {
        $this->id_trabajador = $id_trabajador;
    }

    public function setId_responsable($id_responsable) {
        $this->id_responsable = $id_responsable;
    }

    public function setId_tipocombustible($id_tipocombustible) {
        $this->id_tipocombustible = $id_tipocombustible;
    }

    public function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    public function setNro_guia($nro_guia) {
        $this->nro_guia = $nro_guia;
    }

    public function setNro_surtidor($nro_surtidor) {
        $this->nro_surtidor = $nro_surtidor;
    }

    public function setCant_combustible($cant_combustible) {
        $this->cant_combustible = $cant_combustible;
    }
    
    public function getNro_vale() {
        return $this->nro_vale;
    }

    public function setNro_vale($nro_vale) {
        $this->nro_vale = $nro_vale;
    }
    public function getId_trabvehiculo() {
        return $this->id_trabvehiculo;
    }

    public function setId_trabvehiculo($id_trabvehiculo) {
        $this->id_trabvehiculo = $id_trabvehiculo;
    }
    public function getId_detalleabastecimiento() {
        return $this->id_detalleabastecimiento;
    }

    public function getHorometro() {
        return $this->horometro;
    }

    public function getKilometraje() {
        return $this->kilometraje;
    }

    public function setId_detalleabastecimiento($id_detalleabastecimiento) {
        $this->id_detalleabastecimiento = $id_detalleabastecimiento;
    }

    public function setHorometro($horometro) {
        $this->horometro = $horometro;
    }

    public function setKilometraje($kilometraje) {
        $this->kilometraje = $kilometraje;
    }
           
        //--------------------------------------------------------------------------------------
    
    public function registrarConsumoComb()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_control_combustible";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_vehiculo().","
                ."'".$this->getId_trabajador()."',"
                ."'".$this->getFecha()."',"                
                ."'".$this->getNro_guia()."',"
                ."'".$this->getNro_vale()."',"
                ."'".$this->getNro_surtidor()."',"
                ."".$this->getCant_combustible().","
                ."".$this->getHorometro().","
                ."".$this->getKilometraje()."";
        //die(var_dump($input));
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = 'OK';
        }else if ('NO' == substr($result, 0, 2))
        {
            $val = substr($result, 4); // retorna la cantidad en la que excede
        }else if ('PARTE' == $result)
        {
            $val = $result;
        }
        //die(var_dump($val));
        return $val;
    }
    
    //--------------------------------------------------------------------------------------
    
    public function editarConsumoComb()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_control_combustible";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_consumo().","
                ."'".$this->getId_trabajador()."',"                
                ."'".$this->getFecha()."',"                
                ."'".$this->getNro_guia()."',"
                ."'".$this->getNro_vale()."',"
                ."'".$this->getNro_surtidor()."',"
                ."".$this->getCant_combustible().","
                ."".$this->getHorometro().","
                ."".$this->getKilometraje()."";
        //die(var_dump($input));
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }else if ('PARTE' == $result)
        {
            $val = $result;
        }else
        {
            $val = false;
        }
        //die(var_dump($val));
        return $val;
    }

//--------------------------------------------------------------------------------------
    
    function __construct() {
        
    }
    function __destruct() {
        unset($this);
    }
    
}
