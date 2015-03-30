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
        <!--td><?php echo $select[$i]['detalle']; ?></td-->
        <td><?php echo $select[$i]['estado']; ?></td>
        <td>
            <?php if ($select[$i]['estado'] == 'ACTIVO') { ?>
            <a class="btn btn-primary" href="adm_select_alq_vehiculos.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'], 2); ?>">Alquilar Maquinaria</a><br>
            <a class="btn btn-primary" href="adm_select_alq_articulos.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'], 2); ?>">Alquilar Art&iacute;culos</a><br>
            <?php if(!empty($select[$i]['id_detallealquiler'])){ ?>
            <a class="btn btn-info" href="adm_list_detallealvh.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'],2); ?>">Ver Alquiler</a><br>
            <a class="btn btn-danger" href="adm_list_devolucion.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'],2); ?>"><i class="fa fa-remove fa-fw"></i>Devoluci&oacute;n</a><br>
            <?php } ?>
            <a class="btn btn-warning" href="adm_finaliza_contrato.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'], 2); ?>" title="Finaliza el contrato en su totalidad">
                <i class="fa fa-close fa-fw"></i>Finalizar
            </a>
            <a class="btn btn-normal" href="adm_edit_contrato.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'], 2); ?>"><i class="fa fa-edit fa-fw"></i>Editar</a><br>
            <?php }else { ?>
            El contrato ha finalizado
            <?php } ?>
        </td>
    </tr>
     
   <?php }
   
    }