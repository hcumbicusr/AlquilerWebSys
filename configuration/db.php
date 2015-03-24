<?php
/**
 * Clase que sirve de redireccionador o selector del gestor de base de datos que
 * se elija en el archivo Config.inic.php $config['managerDataBase']
 * @package    application
 * @subpackage configuration
 * @author     Cumbicus Rivera Henry <hcumbicusr@gmail.com>
*/
/**
 * Requiere del archivo mysql.php para funcionar
 */
require_once 'config.php';
require_once 'mysqli.php';
class Class_Db{
    public function selectManager() {
            switch (Class_Config::get('managerDataBase')) {
                case 'mysqli':
                    return new Class_Mysqli();
                    break;
                case 'mssql':
                    
                    break;
                default :
                    return new Class_Mysqli();
                    break;
            }
    }
}