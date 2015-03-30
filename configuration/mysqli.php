<?php

require_once 'interface.php';

class Class_Mysqli implements interfaceDb{
    
    public function connect(){
        global $config;

        $con = new mysqli($config['hostnameDataBase'], $config['userDataBase'], $config['passwordDataBase'],$config['nameDataBase']);
        $con->query("SET NAMES 'utf8'");
        if ($con->connect_errno) {
            //echo "Fallo de la conexion a MySQL: (" . $con->connect_error . ") ";
        }        
        return $con;    
    }
    
    public function select($con,$query){          
        $consult = $con->query($query);  
        $data = NULL;
        if ($consult != NULL)
        {
            while($row = mysqli_fetch_array($consult))
            {
                $data[] = $row;
            }
        }
        return $data;
    }        
    
    public function insert($con,$query) {
        $result = false;   
        //die(var_dump($query));
        if (!($stmt = $con->prepare($query)))
        {
            //echo "Fallo en la preparacion sentencia : ( ".$con->errno." ) ".$con->error;
            return false;
        }
        else
        {
            if (!$stmt->execute())
            {
                //echo "Fallo en la ejecucion : ( ".$con->errno." ) ".$con->error;     
                return false;
            }
            else
            {
                $result = true;
            }
        }                
        return $result;        
    }
    public function update($con,$query) {
        $result = false;
        if (!($stmt = $con->prepare($query)))
        {
            //echo "Fallo en la preparacion sentencia : ( ".$con->errno." ) ".$con->error;
            return false;
        }
        else
        {
            if (!$stmt->execute())
            {
                //echo "Fallo en la ejecucion : ( ".$con->errno." ) ".$con->error;                
                return false;
            }
            else
            {
                $result = true;
            }
        }        
        $stmt->close();       
        return $result;
    }
    public function delete($con,$query) {
        $result = false;
        if (!($stmt = $con->prepare($query)))
        {
            //echo "Fallo en la preparacion sentencia : ( ".$con->errno." ) ".$con->error;
            return false;
        }
        else
        {
            if (!$stmt->execute())
            {
               // echo "Fallo en la ejecucion : ( ".$con->errno." ) ".$con->error;                
                return false;
            }
            else
            {
                $result = true;
            }
        }        
        $stmt->close();        
        return $result;
    }
    
    public function spAll($con, $procedure, $input, $output = NULL) {        
                
        //die(var_dump("CALL $procedure($input,@salida); SELECT @salida;"));
        
        $consult = $con->multi_query("CALL $procedure($input,@salida); SELECT @salida;");          
        //die(var_dump($consult));
        $data = "";
        if ($consult) {
            do{
                if ($result = $con->store_result()) {                         
                    while ($row = $result->fetch_row())
                    {                        
                        foreach ($row as $cell) {
                            $data = $cell;#mensaje de salida del procedure                            
                        }
                    }                    
                    $result->close();                    
                    if ($con->more_results()) {
                        $data .= " \t";
                    }else
                    {                        
                        return $data;//return
                    }
                }
            }while($con->next_result());
        }
    }
    
    public function spInsert($con,$procedure,$input)
    {
        //die(var_dump("CALL $procedure($input)"));
        $ret = false;
        if(!$con->multi_query("CALL $procedure($input)"))
        {
            //echo "Falla en CALL: (" . $con->errno . ") " . $con->error;
            $ret = false;
        }else
        {
            $ret = true;
        }
        return $ret;
    }
    
    public function spSelect($con, $procedure, $input = NULL) {   
        if (empty($input))
        {
            $consult = $con->query("CALL $procedure()");
        }            
        else
        {
            $consult = $con->query("CALL $procedure($input)");
        }
        
        if ( !($consult) ) 
        {
            //echo "Fallo en la llamada: (" . $con->errno . ") " . $con->error;
            return false;
        }
        $data = NULL;        
        //die(var_dump($consult));
        if ($consult != NULL) {
            $i=0;
            while ($row = mysqli_fetch_array($consult))
            {
                $data[] = $row;                    
                $i++;
            }
        }        
        return $data;
    }

}