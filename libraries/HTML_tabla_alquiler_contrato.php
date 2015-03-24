<?php

function table ($contrato)
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_todo_alquiler_activo_x_contrato",Funciones::decodeStrings($contrato,2));
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>        
        <?php if ($select[$i]['id_vehiculo'] != 0) { ?>
        <td><?php echo $i+1; ?></td>
        <td><?php echo $select[$i]['vehiculo']." /MOD: ".$select[$i]['modelo']." SERIE: ".$select[$i]['serie_v']." /PLACA: ".$select[$i]['placa']; ?></td>
        <?php } 
        if ($select[$i]['id_articulo'] != 0){ ?>
        <td><?php echo $i+1; ?></td>
        <td><?php echo $select[$i]['articulo']." /SERIE: ".$select[$i]['serie_a']; ?></td>
        <?php } ?>
        <td><?php echo $select[$i]['estado_alq']; ?></td>        
        <?php if ($select[$i]['est_alq'] == 'A') { ?>
        <td>
             <?php if ($select[$i]['id_vehiculo'] != 0) { ?>
            <a class="btn btn-primary" href="adm_reg_dev_vehiculo.php?contrato=<?php echo $contrato; ?>&det_alq=<?php echo Funciones::encodeStrings($select[$i]['id_detallealquiler'], 2); ?>"> Devoluci&oacute;n de Veh&iacute;culo</a><br>
            <?php }
            if ($select[$i]['id_articulo'] != 0){ ?>
            <a class="btn btn-info" href="adm_reg_dev_articulo.php?contrato=<?php echo $contrato; ?>&det_alq=<?php echo Funciones::encodeStrings($select[$i]['id_detallealquiler'], 2); ?>"> Devoluci&oacute;n de Art&iacute;culo</a>
            <?php } ?>
        </td>
        <?php }else { ?>
        <td>
            <label style="color: #008000">Devuelto</label>
        </td>
        <?php } ?>
    </tr>
     
   <?php }
   
    }