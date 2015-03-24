<?php

function table ()
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_registro_consumo");
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>
        <td><?php echo $select[$i]['fecha']; ?></td>                
        <td><?php echo $select[$i]['nro_guia']; ?></td>
        <td><?php echo $select[$i]['nro_vale']; ?></td>
        <td><?php echo $select[$i]['nro_surtidor']; ?></td>
        <td><?php echo $select[$i]['vehiculo']; ?></td>
        <td><?php echo $select[$i]['horometro']; ?></td>
        <td><?php echo $select[$i]['cant_combustible']; ?></td>
        <td><?php echo $select[$i]['operario']; ?></td>                        
        <td><?php echo $select[$i]['controlador']; ?></td>
        <td>
            <a class="btn btn-adn" href="ct_edit_consumo_comb.php?consumo=<?php echo Funciones::encodeStrings($select[$i]['id_consumo'], 2); ?>"><i class="fa fa-edit fa-fw"></i>Editar</a>
        </td>
    </tr>
     
   <?php }
   
    }