<?php

class ControlTrabajo {
    
    protected $id_controltrabajo;
    protected $id_vehiculo;
    protected $id_trabajador;
    protected $id_trabvehiculo;
    protected $id_responsable;
    protected $nro_parte;
    protected $nro_interno;
    protected $agua;
    protected $petroleo;
    protected $gasolina;
    protected $fecha;
    protected $lugar_trabajo;
    protected $tarea;
    protected $ac_motor;
    protected $ac_transmision;
    protected $ac_hidraulico;
    protected $grasa;
    protected $observacion;
    protected $turno;
    protected $descuento;    
    protected $horometro_inicio;
    protected $horometro_fin;
    protected $total_h;
    //--------------- Horas y minutos
    protected $hrs;
    protected $min;
    
    public function getId_controltrabajo() {
        return $this->id_controltrabajo;
    }

    public function getId_vehiculo() {
        return $this->id_vehiculo;
    }

    public function getId_trabajador() {
        return $this->id_trabajador;
    }

    public function getId_trabvehiculo() {
        return $this->id_trabvehiculo;
    }

    public function getId_responsable() {
        return $this->id_responsable;
    }

    public function getNro_parte() {
        return $this->nro_parte;
    }

    public function getNro_interno() {
        return $this->nro_interno;
    }

    public function getAgua() {
        return $this->agua;
    }

    public function getPetroleo() {
        return $this->petroleo;
    }

    public function getGasolina() {
        return $this->gasolina;
    }

    public function getFecha() {
        return $this->fecha;
    }

    public function getLugar_trabajo() {
        return $this->lugar_trabajo;
    }

    public function getTarea() {
        return $this->tarea;
    }

    public function getAc_motor() {
        return $this->ac_motor;
    }

    public function getAc_transmision() {
        return $this->ac_transmision;
    }

    public function getAc_hidraulico() {
        return $this->ac_hidraulico;
    }

    public function getGrasa() {
        return $this->grasa;
    }

    public function getObservacion() {
        return $this->observacion;
    }

    public function getTurno() {
        return $this->turno;
    }

    public function getDescuento() {
        return $this->descuento;
    }

    public function getHorometro_inicio() {
        return $this->horometro_inicio;
    }

    public function getHorometro_fin() {
        return $this->horometro_fin;
    }

    public function getTotal_h() {
        return $this->total_h;
    }

    public function getHrs() {
        return $this->hrs;
    }

    public function getMin() {
        return $this->min;
    }

    public function setId_controltrabajo($id_controltrabajo) {
        $this->id_controltrabajo = $id_controltrabajo;
    }

    public function setId_vehiculo($id_vehiculo) {
        $this->id_vehiculo = $id_vehiculo;
    }

    public function setId_trabajador($id_trabajador) {
        $this->id_trabajador = $id_trabajador;
    }

    public function setId_trabvehiculo($id_trabvehiculo) {
        $this->id_trabvehiculo = $id_trabvehiculo;
    }

    public function setId_responsable($id_responsable) {
        $this->id_responsable = $id_responsable;
    }

    public function setNro_parte($nro_parte) {
        $this->nro_parte = $nro_parte;
    }

    public function setNro_interno($nro_interno) {
        $this->nro_interno = $nro_interno;
    }

    public function setAgua($agua) {
        $this->agua = $agua;
    }

    public function setPetroleo($petroleo) {
        $this->petroleo = $petroleo;
    }

    public function setGasolina($gasolina) {
        $this->gasolina = $gasolina;
    }

    public function setFecha($fecha) {
        $this->fecha = $fecha;
    }

    public function setLugar_trabajo($lugar_trabajo) {
        $this->lugar_trabajo = $lugar_trabajo;
    }

    public function setTarea($tarea) {
        $this->tarea = $tarea;
    }

    public function setAc_motor($ac_motor) {
        $this->ac_motor = $ac_motor;
    }

    public function setAc_transmision($ac_transmision) {
        $this->ac_transmision = $ac_transmision;
    }

    public function setAc_hidraulico($ac_hidraulico) {
        $this->ac_hidraulico = $ac_hidraulico;
    }

    public function setGrasa($grasa) {
        $this->grasa = $grasa;
    }

    public function setObservacion($observacion) {
        $this->observacion = $observacion;
    }

    public function setTurno($turno) {
        $this->turno = $turno;
    }

    public function setDescuento($descuento) {
        $this->descuento = $descuento;
    }

    public function setHorometro_inicio($horometro_inicio) {
        $this->horometro_inicio = $horometro_inicio;
    }

    public function setHorometro_fin($horometro_fin) {
        $this->horometro_fin = $horometro_fin;
    }

    public function setTotal_h($total_h) {
        $this->total_h = $total_h;
    }

    public function setHrs($hrs) {
        $this->hrs = $hrs;
    }

    public function setMin($min) {
        $this->min = $min;
    }

    
        //--------------------------------------------------------------------------------------
    
    public function registrarParte()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_parte_maquinaria";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_vehiculo().","
                ."'".$this->getId_trabajador()."',"
                ."".$this->getNro_interno().","
                ."'".$this->getNro_parte()."',"
                ."'".$this->getFecha()."',"
                ."'".$this->getLugar_trabajo()."',"
                ."'".$this->getTarea()."',"
                ."".$this->getAgua().","
                ."".$this->getPetroleo().","
                ."".$this->getGasolina().","
                ."".$this->getAc_motor().","
                ."".$this->getAc_transmision().","
                ."".$this->getAc_hidraulico().","
                ."".$this->getGrasa().","
                ."'".$this->getObservacion()."',"
                ."'".$this->getTurno()."',"
                ."".$this->getDescuento().","
                ."".$this->getHorometro_inicio().","
                ."".$this->getHorometro_fin().","
                ."".$this->getTotal_h().","
                ."".$this->getHrs().","
                ."".$this->getMin()."";
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
    
    public function editarParte()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_parte_maquinaria";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_controltrabajo().","
                ."'".$this->getId_trabajador()."',"
                ."'".$this->getNro_parte()."',"
                ."'".$this->getFecha()."',"
                ."'".$this->getLugar_trabajo()."',"
                ."'".$this->getTarea()."',"
                ."".$this->getAgua().","
                ."".$this->getPetroleo().","
                ."".$this->getGasolina().","
                ."".$this->getAc_motor().","
                ."".$this->getAc_transmision().","
                ."".$this->getAc_hidraulico().","
                ."".$this->getGrasa().","
                ."'".$this->getObservacion()."',"
                ."'".$this->getTurno()."',"
                ."".$this->getDescuento().","
                ."".$this->getHorometro_inicio().","
                ."".$this->getHorometro_fin().","
                ."".$this->getTotal_h().","
                ."".$this->getHrs().","
                ."".$this->getMin()."";
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