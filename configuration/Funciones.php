<?php

class Funciones {
    /**
     * @todo genera codigo html para mostrar un combobox
     * @param array $array Array bidimensional de BD
     * @param int $filas = 0 Cantidad de filas
     * @param int $columnas = 0 Cantidad de columnas
     * @return String Cadena de <option>
     */
    public static function armarCombo ($array, $selected = NULL, $filas = 0, $columnas =0)
    {              
        #die("dddddddddd ".$selected);
        if ($filas == 0)
        {
            $filas = count($array);
        }        
        if ($columnas == 0) { #si no hay campos especificados
            for ($i = 0; $i < 1; $i++) {
                $columnas = ((count($array[$i])));    
            }
        }        
        for ($i = 0; $i < $filas; $i++) {
            $cbo = "\n<option value='";
            for ($j = 0; $j < $columnas; $j++) { 
                $id = $array[$i]['id'];
                $value = $array[$i]['nombre'];       
            }
            $cbo .="$id' ";
            if (!empty($selected) && ($id) == $selected)
            {
                $cbo .=" selected ";
            }
            $cbo .=" >";
            
            $cbo .=$value;
            $cbo .="</option>";
            $option[$i] = $cbo;
            $cbo = "";
        }               
        for ($i = 0; $i < count($option); $i++) {
            $cbo .= $option[$i]."\n";
        } 
        return $cbo;        
    }
    
    /**
     * @author hcumbicusr <hcumbicusr@gmail.com>
     * @name filtraCaracteresEspeciales
     * @param String $cadena String o Array a ser reemplazado
     */
    public static function filtraCaracteresEspeciales ($cadena) 
    {
        $search = ['Á','É','Í','O','Ú','á','é','í','ó','ú','Ü','ü','Ñ','ñ'];
        $replace = ['&#193;','&#201;','&#205;','&#211;','&#218;','&#225;','&#233;','&#237;','&#243;','&#250;','&#220;','&#252;','&#209;','&#241;'];               
        return str_replace($search, $replace,$cadena);        
    }
    
    public static function convertirEspecialesHtml($str){
        if (!isset($GLOBALS["carateres_latinos"])){
            $todas = get_html_translation_table(HTML_ENTITIES, ENT_NOQUOTES);
            $etiquetas = get_html_translation_table(HTML_SPECIALCHARS, ENT_NOQUOTES);
            $GLOBALS["carateres_latinos"] = array_diff($todas, $etiquetas);
        }
        $str = strtr($str, $GLOBALS["carateres_latinos"]);
        return $str;
    }
    
    function array_envia($array) { 
        $tmp = serialize($array); 
        $tmp = urlencode($tmp); 
        return $tmp; 
   } 
   
   function array_recibe($array) { 
        $tmp = stripslashes($array); 
        $tmp = urldecode($tmp); 
        $tmp = unserialize($tmp); 
       return $tmp; 
   } 
   
   public static function sessionTime ($transcurrido,$limite)
   {
       if ($transcurrido > $limite) {
           return true;
       }       
       return false;
   }
   
   /**
     * Reemplaza todos los acentos por sus equivalentes sin ellos
     *
     * @param $string
     *  string la cadena a sanear
     *
     * @return $string
     *  string saneada
     */
    function reemplazarString($string)
    {        
        $string = trim($string);        
        $string = str_replace(
            array('á', 'à', 'ä', 'â', 'ª', 'Á', 'À', 'Â', 'Ä'),
            array('a', 'a', 'a', 'a', 'a', 'A', 'A', 'A', 'A'),
            $string
        );

        $string = str_replace(
            array('é', 'è', 'ë', 'ê', 'É', 'È', 'Ê', 'Ë'),
            array('e', 'e', 'e', 'e', 'E', 'E', 'E', 'E'),
            $string
        );

        $string = str_replace(
            array('í', 'ì', 'ï', 'î', 'Í', 'Ì', 'Ï', 'Î'),
            array('i', 'i', 'i', 'i', 'I', 'I', 'I', 'I'),
            $string
        );
        
        $string = str_replace(
            array('ó', 'ò', 'ö', 'ô', 'Ó', 'Ò', 'Ö', 'Ô'),
            array('o', 'o', 'o', 'o', 'O', 'O', 'O', 'O'),
            $string
        );

        $string = str_replace(
            array('ú', 'ù', 'ü', 'û', 'Ú', 'Ù', 'Û', 'Ü'),
            array('u', 'u', 'u', 'u', 'U', 'U', 'U', 'U'),
            $string
        );

        $string = str_replace(
            array('ñ', 'Ñ', 'ç', 'Ç'),
            array('n', 'N', 'c', 'C',),
            $string
        );

        //Esta parte se encarga de eliminar cualquier caracter extraño
        $string = str_replace(
            array("\\", "¨", "º", "-", "~",
                 "#", "@", "|", "!", "\"",
                 "·", "$", "%", "&", "/",
                 "(", ")", "?", "'", "¡",
                 "¿", "[", "^", "`", "]",
                 "+", "}", "{", "¨", "´",
                 ">", "< ", ";", ",", ":",
                 ".", " "),
            '',
            $string
        );        
        return $string;
    }
    
    public static function reemplazaEspeciales($string)
    {
         $string = str_replace(
            array("\\", "¨",
                 "\"",
                 "·", "$",
                 "'",
                 "^", "`",
                 "¨", "´",
                 ">", "<",
                "</","--",
                "#",
                "select"),
            ' ',
            $string
        );
         return $string;
    }
    
    public static  function encodeStrings ($string, $n = 1)
    {
        $cad = $string;
        for ($i = 0; $i < $n; $i++)
        {
            $cad = base64_encode($cad);
        }
        return $cad;
    }
    
    public static  function decodeStrings ($string, $n = 1)
    {
        $cad = $string;
        for ($i = 0; $i < $n; $i++)
        {
            $cad = base64_decode($cad);
        }
        return $cad;
    }
    /**
     * Conversion de unidades
     * @author http://stackoverflow.com/questions/5501427/php-filesize-mb-kb-conversion
     */
    
    public static function formatSizeUnits($bytes)
    {
        if ($bytes >= 1073741824)
        {
            $bytes = number_format($bytes / 1073741824, 2) . ' GB';
        }
        elseif ($bytes >= 1048576)
        {
            $bytes = number_format($bytes / 1048576, 2) . ' MB';
        }
        elseif ($bytes >= 1024)
        {
            $bytes = number_format($bytes / 1024, 2) . ' KB';
        }
        elseif ($bytes > 1)
        {
            $bytes = $bytes . ' bytes';
        }
        elseif ($bytes == 1)
        {
            $bytes = $bytes . ' byte';
        }
        else
        {
            $bytes = '0 bytes';
        }

        return $bytes;
    }

    /**
     * $temp[0] = IP
     * $temp[1] = SO
     * $temp[2] = NAVEGADOR
     */
    public static function DatosBrowser()
    {
        $temp=array();
        $ip=$_SERVER['REMOTE_ADDR'];
        $datos=$_SERVER['HTTP_USER_AGENT'];
        array_push($temp,$ip);
        if(strpos($datos,"Windows")!==false)
          array_push($temp,"Windows");
        elseif(strpos($datos,"Mac")!==false)
          array_push($temp,"Mac");
        elseif(strpos($datos,"Linux")!==false)
          array_push($temp,"Linux");

        if(strpos($datos,"MSIE")!==false)
          array_push($temp,"Internet Explorer");
        elseif(strpos($datos,"Firefox")!==false)
          array_push($temp,"Firefox");
        elseif(strpos($datos,"Chrome")!==false)
          array_push($temp,"Google Chrome");
        elseif(strpos($datos,"Safari")!==false)
          array_push($temp,"Safari");
        elseif(strpos($datos,"Opera")!==false)
          array_push($temp,"Opera");
        else
          array_push($temp,"Navegador desconocido");

        return $temp;   

  }
}