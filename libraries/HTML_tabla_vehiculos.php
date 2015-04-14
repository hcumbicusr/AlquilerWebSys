<?php

function table ($var = NULL,$contrato = NULL)
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_vehiculos");
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>        
        <td><?php echo $select[$i]['tipovehiculo']; ?></td>
        <td><?php echo $select[$i]['nombre']; ?></td>
        <td><?php echo $select[$i]['modelo']; ?></td>
        <td><?php echo $select[$i]['serie']; ?></td>              
        <td><?php echo $select[$i]['motor']; ?></td>
        <td><?php echo $select[$i]['color']; ?></td>         
        <td><?php echo $select[$i]['placa']; ?></td>         
        <td><?php echo "S/. ".$select[$i]['precio_hora']; ?> </td>
        <td><?php echo $select[$i]['estado']; ?></td> 
        <?php if (!empty($var) && $var == 'list' && $_SESSION['tipo_usuario'] == 'ADMINISTRADOR') { ?>
        <td>
            <?php if($select[$i]['n_parte'] > 0) { ?>
            <a class="btn btn-primary" href="adm_historial_maq.php?vh=<?php echo Funciones::encodeStrings($select[$i]['id_vehiculo'], 2); ?>">
                <i class="fa fa-file-excel-o"></i> Historial de Alquiler
            </a><br>
            <?php } ?>
             <a class="btn btn-adn" href="adm_edit_vehiculo.php?vh=<?php echo Funciones::encodeStrings($select[$i]['id_vehiculo'], 2); ?>">
                <i class="fa fa-edit fa-fw"></i>Editar
            </a>            
        </td>
        <?php } ?>
        <?php if (empty($var)) { ?>
        <td align="center">
            <?php if(($select[$i]['estado'] != "ACTIVO" && $select[$i]['estado'] != "DISPONIBLE") || $select[$i]['tipovehiculo'] == 'SURTIDOR' ) { ?>
            <!--label style="color: #FF0000">< ?php echo $select[$i]['estado']; ?></label-->
            <a href="#" class="btn btn-primary" disabled="true" >Alquilar</a>
            <?php }else{ ?>
            <a href="adm_reg_alq_vehiculo.php?contrato=<?php echo $contrato ?>&v=<?php echo Funciones::encodeStrings($select[$i]['id_vehiculo'],2); ?>" 
               class="btn btn-primary" alt="<?php echo $select[$i]['nombre']; ?>" 
               title="<?php echo $select[$i]['nombre']; ?>" >Alquilar</a>           
            <?php } ?>
        </td>
        <?php }else if (!empty ($var) && $var == "mant") { ?>
        <td align="center">
            <a href="ct_registro_mantenimiento.php?v=<?php echo Funciones::encodeStrings($select[$i]['id_vehiculo'],2); ?>" 
               class="btn btn-primary" alt="<?php echo $select[$i]['nombre']; ?>" 
               title="<?php echo $select[$i]['nombre']; ?>" > Registro</a>
            <?php if ($select[$i]['n_mant'] > 0) { ?>
            <a href="ct_listar_mantenimientos.php?v=<?php echo Funciones::encodeStrings($select[$i]['id_vehiculo'],2); ?>" 
               class="btn btn-info" alt="<?php echo $select[$i]['nombre']; ?>" 
               title="<?php echo $select[$i]['nombre']; ?>" >Detalle</a>
            <?php } ?>
        </td>
        <?php }else if (!empty ($var) && $var == "rend") { ?>
        <td> <!-- Rendimiento de vehiculo -->
            <a class="btn btn-primary" href="REP_REND_fechas.php?vehiculo=<?php echo Funciones::encodeStrings($select[$i]['id_vehiculo'], 2); ?>">
                RENDIMIENTO
            </a>
        </td>
        <?php } ?>
    </tr>
     
   <?php }
   
    } ?>