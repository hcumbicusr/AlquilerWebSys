<?php

function table ($var)
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect(); // el parametro de entrada el el id_contrato que biene como GET=cliente
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_vehiculos_x_contrato",  Funciones::decodeStrings($var, 2));
    //die(var_dump(Funciones::decodeStrings($var, 2)));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>                        
        <td><?php echo $select[$i]['nombre_c']; ?></td>        
        <?php if ($select[$i]['est_alq'] == 'A') { ?>
        <td align="center">                        
            <a href="ct_parte_maquinaria.php?cliente=<?php echo $_GET['cliente']; ?>&v=<?php echo Funciones::encodeStrings($select[$i]['id_detallealquiler'],2); ?>" 
               class="btn btn-info" alt="<?php echo $select[$i]['nombre_c']; ?>" 
               title="<?php echo $select[$i]['nombre_c']; ?>" >
                Parte diario
            </a><br>
            <a href="ct_control_combustible.php?cliente=<?php echo $_GET['cliente']; ?>&v=<?php echo Funciones::encodeStrings($select[$i]['id_detallealquiler'],2); ?>" 
               class="btn btn-primary" alt="<?php echo $select[$i]['nombre_c']; ?>" 
               title="<?php echo $select[$i]['nombre_c']; ?>" >
                Vale de consumo
            </a>
        </td> 
    <?php }else { ?>
        <td align="center">            
            <a href="#" disabled="true"
               class="btn btn-primary" alt="<?php echo $select[$i]['nombre_c']; ?>" 
               title="<?php echo $select[$i]['nombre_c']; ?>" >
                Parte diario
            </a><br>
            <a href="#" disabled="true"
               class="btn btn-info" alt="<?php echo $select[$i]['nombre_c']; ?>" 
               title="<?php echo $select[$i]['nombre_c']; ?>" >
                Vale de consumo
            </a>
        </td>
    </tr>
     
   <?php }
   
}

    } ?>   