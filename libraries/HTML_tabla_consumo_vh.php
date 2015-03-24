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
        <?php
        $con = $objBD->selectManager()->connect();
        $input = $select[$i]['id_detallealquiler'];
        $misDatos = $objBD->selectManager()->spSelect($con, "sp_REP_consumo_detal", $input); //Ver si hay datos para reporte
        //echo "sp_REP_consumo_detal(".$input.")";
        //echo var_dump($misDatos);
        $nreg = count($misDatos);
        if ($nreg > 0) //habilita boton
        { ?>
        <td align="center">            
            <a href="../../reportes/rep_consumo_contrato.php?det=<?php echo Funciones::encodeStrings($select[$i]['id_detallealquiler'],2); ?>" 
               class="btn btn-primary" alt="<?php echo $select[$i]['nombre_c']; ?>" 
               title="<?php echo $select[$i]['nombre_c']; ?>" target="_blank" >
                Generar reporte (<?php echo $nreg; ?>)
            </a>
        </td>
        <?php }else //deshabilita boton
        { ?>
        <td align="center">            
            <a href="#" 
               class="btn btn-danger" alt="<?php echo $select[$i]['nombre_c']; ?>" 
               title="<?php echo $select[$i]['nombre_c']; ?>" disabled >
                Sin Datos
            </a>
        </td>    
        <?php }
        ?>
                
    </tr>
   
<?php }

    }