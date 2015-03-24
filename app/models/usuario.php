<?php

class Usuario {
    
    protected $id_usuario;
    protected $id_trabajador;
    protected $nombre;
    protected $clave;
    protected $tipo;
    protected $estado;  
    protected $f_registro;
    protected $f_modificacion;
    protected $f_ultimo_acceso;


    public function getId_usuario() {
        return $this->id_usuario;
    }

    public function getId_trabajador() {
        return $this->id_trabajador;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function getClave() {
        return $this->clave;
    }

    public function getTipo() {
        return $this->tipo;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function getF_registro() {
        return $this->f_registro;
    }

    public function getF_modificacion() {
        return $this->f_modificacion;
    }

    public function setId_usuario($id_usuario) {
        $this->id_usuario = $id_usuario;
    }

    public function setId_trabajador($id_trabajador) {
        $this->id_trabajador = $id_trabajador;
    }

    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    public function setClave($clave) {
        $this->clave = $clave;
    }

    public function setTipo($tipo) {
        $this->tipo = $tipo;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }

    public function setF_registro($f_registro) {
        $this->f_registro = $f_registro;
    }

    public function setF_modificacion($f_modificacion) {
        $this->f_modificacion = $f_modificacion;
    }
    
    public function getF_ultimo_acceso() {
        return $this->f_ultimo_acceso;
    }

    public function setF_ultimo_acceso($f_ultimo_acceso) {
        $this->f_ultimo_acceso = $f_ultimo_acceso;
    }
            
    /*---------------------------------------------------------------------------*/
    function inicioSesion()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        $browser = Funciones::DatosBrowser();
        $procedure = "sp_sesion";
        //$input ="'".$this->getUsuario()."','".md5($this->getClave())."'";
        $input ="'"
                .$this->getNombre()
                ."','".md5($this->getClave())
                ."','".$browser[0]
                ."','".$browser[2]
                ."','".$browser[1]
                ."'";
        $result = $objDB->selectManager()->spSelect($con, $procedure, $input);
        if (!empty($result))
        {
            $objSesion = new Sesion($result);
            if ($objSesion->inicioSesion())
            {
                $val = true;
            }
        }                
        return $val;
    }
    
    public function cerrarSesion ()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        //die(var_dump($browser));
        
        $procedure = "sp_cierre_sesion";
        $input ="".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."'" ;
        
        $result = $objDB->selectManager()->spInsert($con, $procedure, $input);
        //die(var_dump($result));
        if (!empty($result) && $result == true)
        {
            $val = true;
            $_SESSION = array();
            session_destroy();                        
        }                
        return $val;
    }
    
    public function registrarUsuario()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        $procedure = "sp_registro_usuario";
        $input = "'".md5($this->getClave())."',"
                ."'".$this->getApellido()."',"
                ."'".$this->getNombre()."',"
                ."'".$this->getDni()."',"
                ."'".$this->getCodigo()."',"
                ."'".$this->getFecha_nacimiento()."',"
                ."'".$this->getTelefono()."',"
                ."'".$this->getEmail()."',"
                ."".$this->getId_sede().","
                ."".$this->getId_tipo_usuario()."";
        
        $result = $objDB->selectManager()->spAll($con, $procedure, $input);
        //die(var_dump($result));
        if ($result == "OK")
        {            
            $val = true;
        }        
        return $val;
    }
    
    public function actualizarUsuario()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        $procedure = "sp_modifica_usuario";
        $input = "".$this->getId().","
                ."'".$this->getApellido()."',"
                ."'".$this->getNombre()."',"
                ."'".$this->getDni()."',"
                ."'".$this->getCodigo()."',"
                ."'".$this->getFecha_nacimiento()."',"
                ."'".$this->getTelefono()."',"
                ."'".$this->getEmail()."',"
                ."".$this->getId_sede().","
                ."".$this->getId_tipo_usuario()."";
        
        $result = $objDB->selectManager()->spAll($con, $procedure, $input);
        //die(var_dump($result));
        if ($result == "OK")
        {            
            $val = true;
        }        
        return $val;
    }
    /*---------------------------------------------------------------------------*/
    function deshabilitarUsuario()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        $consult = "UPDATE usuarios SET estado = 'IN' WHERE id = ".$this->getId();
        
        $result = $objDB->selectManager()->update($con, $consult);
        if ($result)
        {
            $val = true;
        }                
        return $val;
    }
    function habilitarUsuario()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        $consult = "UPDATE usuarios SET estado = 'AC' WHERE id = ".$this->getId();
        
        $result = $objDB->selectManager()->update($con, $consult);
        if ($result)
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