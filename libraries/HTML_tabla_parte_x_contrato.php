<?php

function table ($contrato)
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_partes_x_contrato",  Funciones::decodeStrings($contrato, 2));
    // die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td>
            <?php echo $i+1; ?>            
        </td>
        <td><?php echo $select[$i]['fecha']; ?></td>                        
        <td><?php echo $select[$i]['nro_parte']; ?></td>
        <td><?php echo $select[$i]['lugar_trabajo']; ?></td>
        <td><?php echo $select[$i]['tarea']; ?></td>
        <td><?php echo $select[$i]['vehiculo']; ?></td>        
        <td><?php echo $select[$i]['turno']; ?></td> 
        <td><?php echo $select[$i]['horometro_inicio']; ?></td>
        <td><?php echo $select[$i]['horometro_fin']; ?></td>
        <td><?php echo $select[$i]['total_h']; ?></td>        
        <td><?php echo $select[$i]['operario']; ?></td>
        <td><?php echo $select[$i]['controlador']; ?></td>
    </tr>
     
   <?php }
   
    }