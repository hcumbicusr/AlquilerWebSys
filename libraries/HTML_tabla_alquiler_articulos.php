<?php

function table2 ($contrato)
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_alquiler_articulos",  Funciones::decodeStrings($contrato,2));
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>        
        <td><?php echo $select[$i]['articulo']." - ".$select[$i]['serie']; ?></td>
        <td><?php echo $select[$i]['precio_alq']; ?></td>
        <td><?php echo $select[$i]['fecha']; ?></td>        
    </tr>
     
   <?php }
   
    }