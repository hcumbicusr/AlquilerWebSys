<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#ssrequire '../Config.inc.php';
#require '../configuration/Funciones.php';

function select ($name, $table, $class = NULL, $required = false, $selected = NULL, $disabled = false) 
{
    $objBD = new Class_Db();
    $con = $objBD->selectManager()->connect();
    $select = $objBD->selectManager()->spSelect($con, 'sp_combo', "'$table'");
    #echo "select armado: <br>";
    #die(var_dump($select));
    
    //$cbo = "<option >ELEGIR ESCUELA</option>";
    if (!empty($select)){
        if (!empty($selected))
        {
            $cbo = Funciones::armarCombo($select,$selected);
        }else
        {
            $cbo = Funciones::armarCombo($select);
        }
        if ($disabled)
        {
        ?>
        <select name="<?php echo $name; ?>" id="<?php echo $name; ?>" disabled class="<?php echo $class?>" <?php if ($required) echo 'required'; ?> >
        <?php }else { ?>
        <select name="<?php echo $name; ?>" id="<?php echo $name; ?>" class="<?php echo $class?>" <?php if ($required) echo 'required'; ?> >
        <?php } ?>
            <?php echo $cbo; ?>
        </select>
<?php }else { ?>
    
        <select style="color: #FF0000" name="<?php echo $name; ?>" id="<?php echo $name; ?>" class="<?php echo $class?>" <?php if ($required) echo 'required'; ?> >
            <option value="">Sin registros para mostrar</option>
        </select>
 
<?php } 
}