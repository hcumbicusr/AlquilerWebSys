<?php

Class Vehiculo {
    private $id_marca;
    private $id_tipovehiculo;
    private $rendimiento;
    private $nombre;
    private $modelo;
    private $serie;
    private $motor;
    private $color;
    private $placa;
    private $estado;
    private $precio_h;
    private $horometro;
    private $kilometraje;
    private  $id_vehiculo;

    public function getId_vehiculo() {
        return $this->id_vehiculo;
    }

    public function setId_vehiculo($id_vehiculo) {
        $this->id_vehiculo = $id_vehiculo;
    }
    public function getRendimiento() {
        return $this->rendimiento;
    }

    public function setRendimiento($rendimiento) {
        $this->rendimiento = $rendimiento;
    }
            
    public function getId_marca() {
        return $this->id_marca;
    }

    public function getId_tipovehiculo() {
        return $this->id_tipovehiculo;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function getModelo() {
        return $this->modelo;
    }

    public function getSerie() {
        return $this->serie;
    }

    public function getMotor() {
        return $this->motor;
    }

    public function getColor() {
        return $this->color;
    }

    public function getPlaca() {
        return $this->placa;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function getPrecio_h() {
        return $this->precio_h;
    }
    public function setId_marca($id_marca) {
        $this->id_marca = $id_marca;
    }

    public function setId_tipovehiculo($id_tipovehiculo) {
        $this->id_tipovehiculo = $id_tipovehiculo;
    }

    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    public function setModelo($modelo) {
        $this->modelo = $modelo;
    }

    public function setSerie($serie) {
        $this->serie = $serie;
    }

    public function setMotor($motor) {
        $this->motor = $motor;
    }

    public function setColor($color) {
        $this->color = $color;
    }

    public function setPlaca($placa) {
        $this->placa = $placa;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }

    public function setPrecio_h($precio_h) {
        $this->precio_h = $precio_h;
    }

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

            //--------------------------------------------------------------------
    public function registrarVehiculo()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_vehiculos";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_marca().","
                ."".$this->getId_tipovehiculo().","
                ."'".$this->getRendimiento()."',"
                ."'".$this->getNombre()."',"
                ."'".$this->getModelo()."',"
                ."'".$this->getSerie()."',"
                ."'".$this->getMotor()."',"
                ."'".$this->getColor()."',"
                ."'".$this->getPlaca()."',"
                ."".$this->getPrecio_h().","
                ."".$this->getHorometro().","
                ."".$this->getKilometraje()."";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //--------------------------------------------------------------------
    public function editarVehiculo()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_vehiculo";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_vehiculo().","
                ."".$this->getId_marca().","
                ."".$this->getId_tipovehiculo().","
                ."'".$this->getRendimiento()."',"
                ."'".$this->getNombre()."',"
                ."'".$this->getModelo()."',"
                ."'".$this->getSerie()."',"
                ."'".$this->getMotor()."',"
                ."'".$this->getColor()."',"
                ."'".$this->getPlaca()."',"
                ."".$this->getPrecio_h().","
                ."".$this->getHorometro().","
                ."".$this->getKilometraje()."";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //--------------------------------------------------------------------
            
    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }

}