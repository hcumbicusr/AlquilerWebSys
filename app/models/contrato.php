<?php

Class Contrato {
    
    private $id_contrato;
    private $obra;
    private $id_cliente;
    private $f_inicio;
    private $f_fin;
    private $presupuesto;
    private $detalle;
    private $estado;
    //-------------------
    #private $id_obra;
    private $nombre_obra;
    private $id_tipoobra;
    //-------------------
    #private $id_cliente;
    private $id_tipocliente;
    private $codigo;
    private $nombre;
    private $direccion;
    private $telefono;    
    private $hora_min;


    public function getHora_min() {
        return $this->hora_min;
    }

    public function setHora_min($hora_min) {
        $this->hora_min = $hora_min;
    }
    
    public function getObra() {
        return $this->obra;
    }

    public function setObra($obra) {
        $this->obra = $obra;
    }

    public function getId_contrato() {
        return $this->id_contrato;
    }
    
    public function getId_cliente() {
        return $this->id_cliente;
    }

    public function getF_inicio() {
        return $this->f_inicio;
    }

    public function getF_fin() {
        return $this->f_fin;
    }

    public function getPresupuesto() {
        return $this->presupuesto;
    }

    public function getDetalle() {
        return $this->detalle;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function getNombre_obra() {
        return $this->nombre_obra;
    }

    public function getId_tipoobra() {
        return $this->id_tipoobra;
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

    public function setId_contrato($id_contrato) {
        $this->id_contrato = $id_contrato;
    }

    public function setId_cliente($id_cliente) {
        $this->id_cliente = $id_cliente;
    }

    public function setF_inicio($f_inicio) {
        $this->f_inicio = $f_inicio;
    }

    public function setF_fin($f_fin) {
        $this->f_fin = $f_fin;
    }

    public function setPresupuesto($presupuesto) {
        $this->presupuesto = $presupuesto;
    }

    public function setDetalle($detalle) {
        $this->detalle = $detalle;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }

    public function setNombre_obra($nombre_obra) {
        $this->nombre_obra = $nombre_obra;
    }

    public function setId_tipoobra($id_tipoobra) {
        $this->id_tipoobra = $id_tipoobra;
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
    
    //----------------------------------------------------------------------------------------
    
    public function registrarNuevoContrato()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_contrato";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."'".$this->getObra()."',"
                ."".$this->getId_cliente().","
                ."'".$this->getF_inicio()."',"
                ."'".$this->getF_fin()."',"
                ."".$this->getPresupuesto().","
                ."'".$this->getDetalle()."',"
                ."".$this->getHora_min()."";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
     //----------------------------------------------------------------------------------------
    
    public function finalizarContrato()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_finalizar_contrato";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_contrato().","
                ."".$this->getPresupuesto().","
                ."'".$this->getDetalle()."',"                
                ."'".$this->getF_fin()."'";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //----------------------------------------------------------------------------------------
    public function editarContrato()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_contrato";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_contrato().","
                ."'".$this->getF_inicio()."',"
                ."'".$this->getF_fin()."',"
                ."".$this->getPresupuesto().","
                ."'".$this->getDetalle()."'";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //----------------------------------------------------------------------------------------
    public function datosContrato()
    {
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        $result = $objDB->selectManager()->spSelect($con, "sp_datos_contrato",  $this->getId_contrato());
        return $result;
    }
    
    
    
    

    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }

}