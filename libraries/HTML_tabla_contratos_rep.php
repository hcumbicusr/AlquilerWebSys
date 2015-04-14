<?php

function table ($entrada = NULL)
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
            <?php if (empty($entrada)) { ?>
            <a href="REP_consumo_vh.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'],2); ?>" 
               class="btn btn-primary" alt="<?php echo $select[$i]['nombre']; ?>" 
               title="<?php echo $select[$i]['nombre']; ?>" >
                Por maquinaria
            </a><br>
            <a href="../../reportes/rep_consumo_contrato_tot.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'],2); ?>" 
               class="btn btn-info" alt="<?php echo $select[$i]['nombre']; ?>" 
               title="<?php echo $select[$i]['nombre']; ?>" target="_blank" >
                Consumo Total
            </a>
            <?php }else if ($entrada == 'hist_contrato') { ?>
            <a href="ct_list_partes_contrato.php?contrato=<?php echo Funciones::encodeStrings($select[$i]['id_contrato'],2); ?>" 
               class="btn btn-primary" alt="<?php echo $select[$i]['nombre']; ?>" 
               title="<?php echo $select[$i]['nombre']; ?>" >
                Ver Partes
            </a>
            <?php } ?>
        </td>        
    </tr>
     
   <?php }
   
    } ?>   