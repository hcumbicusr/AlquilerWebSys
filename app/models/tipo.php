<?php

Class Tipo {
    protected $id_tipo;
    protected $nombre;
    protected $descripcion;
    protected $estado;
    protected $nombre_tabla;


    public function getId_tipo() {
        return $this->id_tipo;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function getDescripcion() {
        return $this->descripcion;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function setId_tipo($id_tipo) {
        $this->id_tipo = $id_tipo;
    }

    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    public function setDescripcion($descripcion) {
        $this->descripcion = $descripcion;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }
    
    public function getNombre_tabla() {
        return $this->nombre_tabla;
    }

    public function setNombre_tabla($nombre_tabla) {
        $this->nombre_tabla = $nombre_tabla;
    }

        
    //------------------------------------------------------------------------
    
    public function registrarTipo()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_tipo";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                                
                ."'".$this->getNombre()."',"
                ."'".$this->getNombre_tabla()."',"
                ."'".$this->getEstado()."'";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    public function editarTipo()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_tipo";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_tipo().","
                ."'".$this->getNombre()."',"
                ."'".$this->getNombre_tabla()."',"
                ."'".$this->getEstado()."'";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    
    
    //------------------------------------------------------------------------


    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }

    
}