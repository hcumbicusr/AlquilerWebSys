<?php

function table ($ingreso)
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_guias");
    #die(var_dump($select));
    $count = 0;
    if ($ingreso == 'MQ') { //para maquinarias
        $cont = 0;
    for ($i = 0; $i < count($select); $i++)
    {
        if ($select[$i]['ingreso'] == 'MQ') {
            $cont++;
        //generar la tabla
        $count += $select[$i]['stock'];        
     ?>     
    <tr>
        <td><?php echo $cont; ?></td>                
        <td><?php echo $select[$i]['nro_guia']; ?></td>        
        <td><?php echo $select[$i]['vale_combustible']; ?></td>
        <td><?php echo $select[$i]['cantidad']." GLN"; ?></td>
        <?php if ($select[$i]['stock'] < 0) $color = "#FF0000"; else $color= "#000000"; ?>
        <td style="color: <?php echo $color; ?>" title="Si el Stock es NEGATIVO significa que ha tomado combustible de una guía anterior."><?php echo $select[$i]['stock']; ?></td>
        <td><?php echo $select[$i]['tipocombustible']; ?></td>
        <td><?php echo $select[$i]['fecha']; ?></td>
        <td><?php echo $select[$i]['abastecedor']; ?></td>
        <td><?php echo $select[$i]['conductor']; ?></td>              
        <td><?php echo $select[$i]['vehiculo']; ?></td>
        <td>
            <?php
            if (empty($select[$i]['nro_comprobante']))
            {
                echo $select[$i]['estado_g']; 
            }else
            {
                echo $select[$i]['estado_g']."<br>";  ?>
            <form role="form" method="POST" 
                  action="./../../app/controllers/detalle_abastecimiento.php?event=desasignar">
                <input type="hidden" name="det_abast" value="<?php echo Funciones::encodeStrings($select[$i]['id_detalleabastecimiento'], 2); ?>">
                <button type="submit" class="btn btn-adn" style="color: #FF0000;" title="DESASIGNAR"><i class="fa fa-times fa-fw"></i>Desasignar</button>   
            </form>                
           <?php }
            ?>
            <a class="btn btn-adn" href="ct_edit_guia.php?guia=<?php echo Funciones::encodeStrings($select[$i]['id_detalleabastecimiento'], 2); ?>"><i class="fa fa-edit fa-fw"></i>Editar</a>
        </td>       
    </tr>
             
    <?php } //IF
     } //FOR
    
    }else if($ingreso == 'VH') { //para vehiculos 
        $cont = 0;
        for ($i = 0; $i < count($select); $i++) {
            if($select[$i]['ingreso'] == 'VH') {
                $cont++;
        ?>    
    <tr>
        <td><?php echo $cont; ?></td>
        <td><?php echo $select[$i]['fecha']; ?></td>
        <td><?php echo $select[$i]['vale_combustible']; ?></td>
        <td><?php echo $select[$i]['cantidad']." GLN"; ?></td>                
        <td><?php echo $select[$i]['tipocombustible']; ?></td>       
        <td><?php echo $select[$i]['abastecedor']; ?></td>
        <td><?php echo $select[$i]['vehiculo']; ?></td>
        <td><?php echo $select[$i]['conductor']; ?></td>                      
        <td>            
            <a class="btn btn-adn" href="ct_edit_vale_comb.php?id=<?php echo Funciones::encodeStrings($select[$i]['id_detalleabastecimiento'], 2); ?>"><i class="fa fa-edit fa-fw"></i>Editar</a>
        </td>       
    </tr>
    <?php }
     }
    
        }

} ?>   