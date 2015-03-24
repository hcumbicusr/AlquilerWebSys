<?php
/**
 * Clase que filtra las variables de configuracion
 * @package WebTopic
 * @subpackage configuration
 * @author Cumbicus Rivera Henry <hcumbicusr@gmailcom>
*/

class Class_Config{
    /**
     * Filtra la variable de configuracion ingresada
     * @global type $config
     * @param type $key
     * @return type $config[$key]
     * 
     */
    public static function get($key){
        global $config;
        if(!empty($key)&&!empty($config[$key])){
            return $config[$key];
            
        }else{
            var_dump($key);
            die('Variable de configuracion no existe');
        }
}
}