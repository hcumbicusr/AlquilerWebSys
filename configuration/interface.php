<?php
/**
 * Clase que sirve de modelo para la implementacion de los diferentes gestores de BD
 * @package    application
 * @subpackage configuration
 * @author     Cumbicus Rivera Henry <hcumbicusr@gmail.com>
*/
interface interfaceDb{
    /**
     * Funcion que realizara la conexion con la base de datos
     */
   public function connect();
   /**
    * Funcion que realizara las consultas de seleccion 
    */
   public function select($con,$query);
   /**
    * Funcion que realizara las consultas de insercion
    */
   public function insert($con,$query);
   /**
    * Funcion que realizara las consultas de actualizacion o modificacion
    */
   public function update($con,$query);
   /**
    * Funcion que realizara las consultas de eliminacion
    */
   public function delete($con,$query);
   /**
    * Funcion que ejecuta procedures solo INPUT
    */
   public function spSelect($con,$procedure,$input);
   /**
    * Funcion que ejecuta procedures con variables OUTPUT
    */
   public function spAll($con,$procedure,$input,$output);
   }