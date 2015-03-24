<?php

Class Cliente {
    private $id_cliente;
    private $id_tipocliente;
    private $codigo;
    private $nombre;
    private $direccion;
    private $telefono;
    private $estado;
    
    public function getId_cliente() {
        return $this->id_cliente;
    }

    public function getId_tipocliente() {
        return $this->id_tipocliente;
    }

    public function getCodigo() {
        return $this->codigo;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function getDireccion() {
        return $this->direccion;
    }

    public function getTelefono() {
        return $this->telefono;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function setId_cliente($id_cliente) {
        $this->id_cliente = $id_cliente;
    }

    public function setId_tipocliente($id_tipocliente) {
        $this->id_tipocliente = $id_tipocliente;
    }

    public function setCodigo($codigo) {
        $this->codigo = $codigo;
    }

    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    public function setDireccion($direccion) {
        $this->direccion = $direccion;
    }

    public function setTelefono($telefono) {
        $this->telefono = $telefono;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }
    
    //-----------------------------------------------------------------------------------
    public function registrarCliente()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_cliente";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_tipocliente().","
                ."'".$this->getCodigo()."',"
                ."'".$this->getNombre()."',"
                ."'".$this->getDireccion()."',"                                
                ."'".$this->getTelefono()."'";
        
        //die(var_dump($input));
                
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if (!empty($result))
        {            
            return $val = $result;
        }
        return $val;
    }
    
    //-----------------------------------------------------------------------------------
    public function editarCliente()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_cliente";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_cliente().","
                ."".$this->getId_tipocliente().","
                ."'".$this->getCodigo()."',"
                ."'".$this->getNombre()."',"
                ."'".$this->getDireccion()."',"                                
                ."'".$this->getTelefono()."'";
        
        //die(var_dump($input));
                
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            return $val = true;
        }
        return $val;
    }
    
    //-----------------------------------------------------------------------------------

    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }

}