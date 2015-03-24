<?php

function table ()
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_trabajadores");
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>
        <td><?php echo $select[$i]['apellidos'].", ".$select[$i]['nombres']; ?></td>
        <td><?php echo $select[$i]['fecha_nac']; ?></td>
        <td><?php echo $select[$i]['dni']; ?></td>
        <td><?php echo $select[$i]['ruc']; ?></td>
        <td><?php echo $select[$i]['telefono']; ?></td>        
        <td><?php echo $select[$i]['usuario']; ?></td>
        <td><?php echo $select[$i]['tipo']; ?></td>
        <?php if($select[$i]['estado'] == 'A') { ?>
        <td>ACTIVO</td>
        <?php }else { ?>
        <td>INACTIVO</td>
        <?php }?>        
        <td><?php echo $select[$i]['nro_licencia']; ?></td>
        <td>
            <?php  if ($select[$i]['id_trabajador'] == 1) { // ADMIN ADMIN  ?>
            <a class="btn btn-adn" href="#" disabled="true" ><i class="fa fa-edit fa-fw"></i>Editar</a>
            <?php }else { ?>
            <a class="btn btn-adn" href="adm_edit_trabajador.php?trab=<?php echo Funciones::encodeStrings($select[$i]['id_trabajador'], 2); ?>"><i class="fa fa-edit fa-fw"></i>Editar</a>
            <?php } ?>
        </td>
    </tr>
     
   <?php }
   
    }