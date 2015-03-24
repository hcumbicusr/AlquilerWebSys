<?php

function table ($vehiculo)
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_mantenimientos",  Funciones::decodeStrings($vehiculo, 2));
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>                
        <td><?php echo $select[$i]['causa']; ?></td>
        <td><?php echo $select[$i]['descripcion']; ?></td>                      
        <td><?php echo $select[$i]['lugar_mant']; ?></td>
        <td><?php echo $select[$i]['horometro']; ?></td>
        <td><?php echo $select[$i]['f_ingreso']; ?></td>         
        <td><?php echo $select[$i]['f_salida']; ?></td>         
        <td><?php echo $select[$i]['estado_actual']; ?> </td>
        <td><?php echo "S/. ".$select[$i]['costo']; ?></td>             
    </tr>
     
   <?php }
   
    } ?>
  