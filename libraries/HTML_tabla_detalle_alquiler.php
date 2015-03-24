<?php

function table ()
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_contrato");
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>        
        <td><?php echo $select[$i]['cliente']; ?></td>
        <td><?php echo $select[$i]['obra']; ?></td>
        <td><?php echo $select[$i]['f_inicio']; ?></td>              
        <td><?php echo $select[$i]['f_fin']; ?></td>
        <td><?php echo $select[$i]['presupuesto']; ?></td>
        <td><?php echo $select[$i]['detalle']; ?></td>
        <td><?php echo $select[$i]['estado']; ?></td>
        <td>
            <a class="btn btn-primary" href="adm_select_alq_vehiculos.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'], 2); ?>">Realizar Alquiler</a><br>
            <?php if(!empty($select[$i]['alquiler'])){ ?>
            <a class="btn btn-primary" href="adm_list_detalleal.php?alquiler=<?php echo Funciones::encodeStrings($select[$i]['alquiler'], 2); ?>">Detalle Alquiler</a>
            <?php } ?>
        </td>
    </tr>
     
   <?php }
   
    }