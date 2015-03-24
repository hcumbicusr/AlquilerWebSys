<?php

Class Trabajador {
    
    private $id_trabajador;
    private $id_tipotrabajador;
    private $apellidos;
    private $nombres;
    private $fecha_nac;
    private $dni;
    private $ruc;
    private $telefono;
    private $estado;
    private $id_tipousuario;
    private $id_usuario;
    private $nro_licencia;
    
    public function getId_trabajador() {
        return $this->id_trabajador;
    }

    public function getApellidos() {
        return $this->apellidos;
    }

    public function getNombres() {
        return $this->nombres;
    }

    public function getFecha_nac() {
        return $this->fecha_nac;
    }

    public function getDni() {
        return $this->dni;
    }

    public function getRuc() {
        return $this->ruc;
    }

    public function getTelefono() {
        return $this->telefono;
    }

    public function getEstado() {
        return $this->estado;
    }
    public function setId_trabajador($id_trabajador) {
        $this->id_trabajador = $id_trabajador;
    }

    public function setApellidos($apellidos) {
        $this->apellidos = $apellidos;
    }

    public function setNombres($nombres) {
        $this->nombres = $nombres;
    }

    public function setFecha_nac($fecha_nac) {
        $this->fecha_nac = $fecha_nac;
    }

    public function setDni($dni) {
        $this->dni = $dni;
    }

    public function setRuc($ruc) {
        $this->ruc = $ruc;
    }

    public function setTelefono($telefono) {
        $this->telefono = $telefono;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }
   
    public function getId_tipotrabajador() {
        return $this->id_tipotrabajador;
    }

    public function setId_tipotrabajador($id_tipotrabajador) {
        $this->id_tipotrabajador = $id_tipotrabajador;
    }
    public function getId_tipousuario() {
        return $this->id_tipousuario;
    }

    public function setId_tipousuario($id_tipousuario) {
        $this->id_tipousuario = $id_tipousuario;
    }
    public function getId_usuario() {
        return $this->id_usuario;
    }

    public function setId_usuario($id_usuario) {
        $this->id_usuario = $id_usuario;
    }
    public function getNro_licencia() {
        return $this->nro_licencia;
    }

    public function setNro_licencia($nro_licencia) {
        $this->nro_licencia = $nro_licencia;
    }


//--------------------------------------------------------------------------------------
    public function registrarTrabajador()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_trabajador";
        $input = "".$this->getId_usuario().","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."'".$this->getApellidos()."',"
                ."'".$this->getNombres()."',"
                ."'".$this->getFecha_nac()."',"
                ."'".$this->getDni()."',"
                ."'".$this->getRuc()."',"
                ."'".$this->getTelefono()."',"
                ."".$this->getId_tipousuario().","
                ."".$this->getId_tipotrabajador().","
                ."'".$this->getNro_licencia()."'";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //--------------------------------------------------------------------------------------
    public function editarTrabajador()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_trabajador";
        $input = "".$this->getId_usuario().","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_trabajador().","
                ."'".$this->getApellidos()."',"
                ."'".$this->getNombres()."',"
                ."'".$this->getFecha_nac()."',"
                ."'".$this->getDni()."',"
                ."'".$this->getRuc()."',"
                ."'".$this->getTelefono()."',"
                ."".$this->getId_tipousuario().","
                ."".$this->getId_tipotrabajador().","
                ."'".$this->getNro_licencia()."'";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    
    
    
    
    
    
    
    
    
    
    
     //--------------------------------------------------------------------------------------
    
    function __construct() {
        
    }
    function __destruct() {
        unset($this);
    }


    
}