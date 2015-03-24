<?php

Class TrabVehiculo {
    protected $id_trabvehiculo;
    protected $id_vehiculoph;
    protected $id_trabajador;
    protected $f_inicio;
    protected $f_fin;
    protected $estado;
    
    public function getId_trabvehiculo() {
        return $this->id_trabvehiculo;
    }

    public function getId_trabajador() {
        return $this->id_trabajador;
    }

    public function getF_inicio() {
        return $this->f_inicio;
    }

    public function getF_fin() {
        return $this->f_fin;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function setId_trabvehiculo($id_trabvehiculo) {
        $this->id_trabvehiculo = $id_trabvehiculo;
    }

    public function setId_trabajador($id_trabajador) {
        $this->id_trabajador = $id_trabajador;
    }

    public function setF_inicio($f_inicio) {
        $this->f_inicio = $f_inicio;
    }

    public function setF_fin($f_fin) {
        $this->f_fin = $f_fin;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }
    public function getId_vehiculoph() {
        return $this->id_vehiculoph;
    }

    public function setId_vehiculoph($id_vehiculoph) {
        $this->id_vehiculoph = $id_vehiculoph;
    }

        
    //-------------------------------------------------------------------------
    
    public function registrarAsignacionTrab()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_asigna_operario";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_vehiculoph().","
                ."".$this->getId_trabajador().","
                ."'".$this->getF_inicio()."'";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    
    
    public function datosAsignacionV_O()
    {
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        //die(var_dump($this->getId_vehiculoph()));
        // se le envia el id_detallealquiler
        $result = $objDB->selectManager()->spSelect($con, "sp_vehiculo_asignacion_op",  $this->getId_vehiculoph());
        return $result;
    }
    
    
    
    
    //-------------------------------------------------------------------------
    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }



}