<?php

function table ()
{ 
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, "sp_listar_cliente");
    #die(var_dump($select));
    for ($i = 0; $i < count($select); $i++)
    {
        //generar la tabla
     ?>     
    <tr data-id="<?php echo $select[$i]['id_cliente']; ?>">
        <td class="openClientes"><?php echo $i+1; ?></td>
        <td class="openClientes"><?php echo $select[$i]['codigo']; ?></td>
        <td class="openClientes"><?php echo $select[$i]['nombre']; ?></td>
        <td class="openClientes"><?php echo $select[$i]['tipocliente']; ?></td>        
        <td class="openClientes"><?php echo $select[$i]['telefono']; ?></td>        
        <td>
            <a class="btn btn-primary" href="adm_crear_contrato.php?cliente=<?php echo Funciones::encodeStrings($select[$i]['id_cliente'], 2); ?>">Nuevo Contrato</a><br>
            <a class="btn btn-adn" href="adm_edit_cliente.php?cliente=<?php echo Funciones::encodeStrings($select[$i]['id_cliente'], 2); ?>"><i class="fa fa-edit fa-fw"></i>Editar</a>
        </td>
    </tr>
     
   <?php }
   
    }