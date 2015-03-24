<?php

Class Obra {
    private $id_obra;
    private $id_tipoobra;
    private $nombre;
    private $estado;
    
    public function getId_obra() {
        return $this->id_obra;
    }

    public function getId_tipoobra() {
        return $this->id_tipoobra;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function setId_obra($id_obra) {
        $this->id_obra = $id_obra;
    }

    public function setId_tipoobra($id_tipoobra) {
        $this->id_tipoobra = $id_tipoobra;
    }

    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }
    
    //----------------------------------------------------------
     public function registrarObra()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_obra";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                                
                ."".$this->getId_tipoobra().","
                ."'".$this->getNombre()."'";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //----------------------------------------------------------
     public function editarObra()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_obra";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_obra().","
                ."".$this->getId_tipoobra().","
                ."'".$this->getNombre()."'";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    //----------------------------------------------------------

        
    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }

    
}