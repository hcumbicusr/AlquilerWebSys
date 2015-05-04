<?php

function table ()
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_guias_sin_asignar");
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>                
        <td><?php echo $select[$i]['fecha']; ?></td>
        <td><?php echo $select[$i]['nro_guia']; ?></td>        
        <td><?php echo $select[$i]['vale_combustible']; ?></td>
        <td><?php echo $select[$i]['cantidad']." GLN"; ?></td>
        <td><?php echo $select[$i]['stock']." GLN"; ?></td>
        <td><?php echo $select[$i]['tipocombustible']; ?></td>        
        <td><?php echo $select[$i]['abastecedor']; ?></td>
        <td><?php echo $select[$i]['conductor']; ?></td>              
        <td><?php echo $select[$i]['vehiculo']; ?></td>
        <td align="center">
            <input type="checkbox" name="chk[]" value="<?php echo $select[$i]['id_detalleabastecimiento']; ?>" 
                   class="form-control" style="width: 19px; height: 19px" >
        </td>       
    </tr>
     
   <?php }
   
    } ?>   