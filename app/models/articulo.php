<?php

Class Articulo {
    private $id_articulo;
    private $id_tipoarticulo;
    private $id_almacen;
    private $serie;
    private $nombre;
    private $descripcion;
    private $precio_alq;
    private $estado;
    
    public function getId_articulo() {
        return $this->id_articulo;
    }

    public function getId_tipoarticulo() {
        return $this->id_tipoarticulo;
    }

    public function getId_almacen() {
        return $this->id_almacen;
    }

    public function getSerie() {
        return $this->serie;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function getDescripcion() {
        return $this->descripcion;
    }

    public function getPrecio_alq() {
        return $this->precio_alq;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function setId_articulo($id_articulo) {
        $this->id_articulo = $id_articulo;
    }

    public function setId_tipoarticulo($id_tipoarticulo) {
        $this->id_tipoarticulo = $id_tipoarticulo;
    }

    public function setId_almacen($id_almacen) {
        $this->id_almacen = $id_almacen;
    }

    public function setSerie($serie) {
        $this->serie = $serie;
    }

    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    public function setDescripcion($descripcion) {
        $this->descripcion = $descripcion;
    }

    public function setPrecio_alq($precio_alq) {
        $this->precio_alq = $precio_alq;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }

    //----------------------------------------------------------------
    public function registrarArticulo()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_registro_articulos";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"                                
                ."".$this->getId_tipoarticulo().","
                ."".$this->getId_almacen().","
                ."'".$this->getSerie()."',"
                ."'".$this->getNombre()."',"
                ."'".$this->getDescripcion()."',"
                ."".$this->getPrecio_alq()."";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //----------------------------------------------------------------
    public function editarArticulo()
    {
        $val = false;
        $objDB = new Class_Db();
        $con = $objDB->selectManager()->connect();
        
        $browser = Funciones::DatosBrowser();
        
        $procedure = "sp_editar_articulo";
        $input = "".$_SESSION['id_usuario'].","
                ."'".$browser[0]."',"
                ."'".$browser[2]."',"
                ."'".$browser[1]."',"
                ."".$this->getId_articulo().","                               
                ."".$this->getId_tipoarticulo().","
                ."".$this->getId_almacen().","
                ."'".$this->getSerie()."',"
                ."'".$this->getNombre()."',"
                ."'".$this->getDescripcion()."',"
                ."".$this->getPrecio_alq()."";
        
        //die(var_dump($input));
        
        $result = $objDB->selectManager()->spAll($con, $procedure,$input);
        //die(var_dump($result));
        if ($result == 'OK')
        {            
            $val = true;
        }
        return $val;
    }
    
    //----------------------------------------------------------------

    
    function __construct() {
        
    }
    
    function __destruct() {
        unset($this);
    }

}