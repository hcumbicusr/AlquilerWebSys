<?php

function table ($var = NULL,$contrato = NULL)
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_articulos");
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>        
        <td><?php echo $select[$i]['tipoarticulo']; ?></td>
        <td><?php echo $select[$i]['nombre']; ?></td>        
        <td><?php echo $select[$i]['serie']; ?></td>              
        <td><?php echo $select[$i]['descripcion']; ?></td>                         
        <td><?php echo "S/. ".$select[$i]['precio_alq'];  ?> </td>
        <td><?php echo $select[$i]['estado']; ?></td>    
        <td>
            <?php if ($_SESSION['tipo_usuario'] == 'ADMINISTRADOR') { ?>
            <a class="btn btn-adn" href="adm_edit_articulo.php?art=<?php echo Funciones::encodeStrings($select[$i]['id_articulo'], 2); ?>"><i class="fa fa-edit fa-fw"></i>Editar</a>
            <?php } ?>
        </td>
        <?php if(empty($var)) { ?>
        <td align="center">
            <?php if($select[$i]['estado'] != "ACTIVO" && $select[$i]['estado'] != "DISPONIBLE") { ?>
            <label style="color: #FF0000"><?php echo $select[$i]['estado']; ?></label>
            <?php }else{ ?>
            <a href="adm_reg_alq_articulo.php?contrato=<?php echo $contrato ?>&articulo=<?php echo Funciones::encodeStrings($select[$i]['id_articulo'],2); ?>" 
               class="btn btn-primary" alt="<?php echo $select[$i]['nombre']; ?>" 
               title="<?php echo $select[$i]['nombre']; ?>" >Alquilar</a>     
            <?php } ?>
        </td>
        <?php } ?>
    </tr>
     
   <?php }
   
    } ?>

    <!-- ----------------------------------------------------------------------------------------
    
    < php if(empty($var)) { ?>
        <td align="center">
            < php if($select[$i]['estado'] != "ACTIVO") { ?>
            <input type="checkbox" name="seleccion" class="checkbox" disabled style="height: 18px; width: 18px" 
                   alt="ALQUILADO" title="ALQUILADO">
            < php }else{ ?>
            <input type="checkbox" id="seleccion" name="seleccion[]"  class="checkbox" style="height: 18px; width: 18px" 
                   value="< php echo Funciones::encodeStrings($select[$i]['id_articulo'],2); ?>" 
                   alt="< php echo $select[$i]['nombre']; ?>" title="< php echo $select[$i]['nombre']; ?>">
            < php } ?>
        </td>
        < php } ?>

    -->