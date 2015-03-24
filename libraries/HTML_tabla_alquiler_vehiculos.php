<?php

function table ($contrato)
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_alquiler_vehiculos",  Funciones::decodeStrings($contrato,2));
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr>
        <td><?php echo $i+1; ?></td>        
        <td><?php echo $select[$i]['vehiculo']." /MOD: ".$select[$i]['modelo']." /SERIE: ".$select[$i]['serie']." /PLACA: ".$select[$i]['placa']; ?></td>
        <td><?php echo "S/. ".$select[$i]['precio_hora']; ?></td>
        <td><?php echo $select[$i]['fecha']; ?></td>  
        <td>
            <!-- si no tiene registro en trabvehiculo  -->
            
            <a href="adm_asigna_op.php?contr=<?php echo $contrato; ?>&detal=<?php echo Funciones::encodeStrings($select[$i]['id_detallealquiler'],2); ?>" class="btn-primary form-control" 
               title="Asignar Operario">
                Asignar Operario
            </a><br>            
            <a href="adm_transporte_maquinaria.php?contr=<?php echo $contrato; ?>&detal=<?php echo Funciones::encodeStrings($select[$i]['id_detallealquiler'],2); ?>" class="btn-info form-control" >
                Registrar Flete
            </a><br>            
            <a href="adm_anula_alquiler.php?contr=<?php echo $contrato; ?>&detal=<?php echo Funciones::encodeStrings($select[$i]['id_detallealquiler'],2); ?>" class="btn-danger form-control"
               title="Se anula solo si no tiene asignado un operario">
                Anular alquiler
            </a><br>
        </td>
    </tr>
     
   <?php }
   
    }