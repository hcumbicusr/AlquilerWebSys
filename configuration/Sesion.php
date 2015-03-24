<?php
/**
 * Description of Sesion
 *
 * @author hcumbicusr
 */

class Sesion {
    protected $param;
    
    public function getParam() {
        return $this->param;
    }

    public function setParam($param) {
        $this->param = $param;
    }

    public function inicioSesion()
    {        
        //se agregan los campos de la tabla como variables de la aplicacion
        //ejm. $this->getParam()[0]['usuario'] sera igual a  => $usuario
        extract($this->getParam()[0]); 
        
        //die(var_dump($config));
        session_regenerate_id();
        $_SESSION['sessionID'] = session_id();
        $_SESSION['session_time'] = time();        
        $_SESSION['id_usuario'] = $id_usuario;
        $_SESSION['usuario'] = $nombre;
        $_SESSION['apenom'] = Funciones::convertirEspecialesHtml($apellidos).", ".Funciones::convertirEspecialesHtml($nombres);        
        $_SESSION['dni'] = $dni;        
        $_SESSION['f_ultimo_acceso'] = $f_ultimo_acceso;               
        $_SESSION['tipo_usuario'] = $tipo;        
        $_SESSION['fecha_nac'] = $fecha_nac;
                
        if (empty($_SESSION['usuario']))
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    public function cerrarSesion ()
    {
        session_start();
        $_SESSION = array();
        session_destroy();
        return true;
    }
    
    function __construct($param=array()) {
        $this->param = $param;
    }
    function __destruct() {
        unset($this);
    }
}
