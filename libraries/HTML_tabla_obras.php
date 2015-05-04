<?php

function table ()
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_obras");
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>       
        <td><?php echo $select[$i]['obra']; ?></td>        
        <td><?php echo $select[$i]['fecha']; ?></td>        
<!--        <td>
            <a class="btn btn-adn" href="adm_edit_obra.php?obra=< ? php echo Funciones::encodeStrings($select[$i]['id_obra'], 2); ? >"><i class="fa fa-edit fa-fw"></i>Editar</a>
        </td> -->
    </tr>
     
   <?php }
   
    }