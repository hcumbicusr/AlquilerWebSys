<?php

function table ()
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_clientes_con_alquiler"); // Retorna tambien el id_contrato que es el que se utiliza para listar los vehiculos
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>                
        <td><?php echo $select[$i]['codigo']; ?></td>
        <td><?php echo $select[$i]['nombre']; ?></td>
        <td><?php echo $select[$i]['obra']; ?></td>
        <td><?php echo $select[$i]['tipoobra']; ?></td>              
        <td><?php echo $select[$i]['f_inicio']; ?></td>
        <td><?php echo $select[$i]['f_fin']; ?></td>                                  
        <td align="center">   <!-- ?cliente == id_contrato --> 
            <?php if ($select[$i]['estado_con'] == 'B') { ?>
            <a href="#" 
               class="btn btn-danger" alt="<?php echo $select[$i]['nombre']; ?>" disabled
               title="<?php echo $select[$i]['nombre']; ?>" >
                Contrato Finalizado
            </a><br>
            <?php }else { ?>
            <a href="ct_list_vehiculos_asig.php?cliente=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'],2); ?>" 
               class="btn btn-primary" alt="<?php echo $select[$i]['nombre']; ?>" 
               title="<?php echo $select[$i]['nombre']; ?>" >
                Ver maquinaria
            </a><br>
            <?php } ?>
        </td>        
    </tr>
     
   <?php }
   
    } ?>   