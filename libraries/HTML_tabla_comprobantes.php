<?php

function table ()
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_comprobantes");
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>                
        <td><?php echo $select[$i]['nro_comprobante']; ?></td>
        <td><?php echo $select[$i]['tipocomprobante']; ?></td>
        <td><?php echo $select[$i]['nro_operacion_ch']; ?></td>
        <td><?php echo $select[$i]['fecha']; ?></td>
        <td><?php echo $select[$i]['abastecedor']; ?></td>              
        <td><?php echo $select[$i]['cantidad']." GLN"; ?></td>
        <td><?php echo $select[$i]['tipocombustible']; ?></td>
        <td><?php echo "S/. ".$select[$i]['precio_u']; ?></td>
        <td><?php echo "S/. ".$select[$i]['total']; ?></td>
        <td title="Total de combustible que se encuentra en las guías asignadas"><?php echo $select[$i]['cantidad_guia']; ?></td>
        <td>
            <a class="btn btn-adn" href="ct_edit_comprobante.php?comp=<?php echo Funciones::encodeStrings($select[$i]['id_abastecimiento'], 2); ?>"><i class="fa fa-edit fa-fw"></i>Editar</a>
        </td>
    </tr>
     
   <?php }
   
    } ?>   