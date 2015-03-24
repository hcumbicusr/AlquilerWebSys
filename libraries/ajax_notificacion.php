<?php
include '../Config.inc.php';

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();

$result = $objDB->selectManager()->spSelect($con, "sp_datos_notificaciones");

$datos = array();

for ($i = 0; $i < count($result); $i++) {
    if ( $result[$i]['unidad'] == "H")
    {
        $aux[$i] = calculaMantenimientoHoras($result[$i]['id_vehiculo'], $result[$i]['horometro_ac'], $result[$i]['intervalo'],
                $result[$i]['notifica_val'],$result[$i]['notificacion']);       
    }else if ($result[$i]['unidad'] == "KM")
    {
        $aux[$i] = calculaMantenimientoKilom($result[$i]['id_vehiculo'], $result[$i]['kilometraje_ac'], $result[$i]['intervalo'],
                $result[$i]['notifica_val'],$result[$i]['notificacion']);       
    }
}

for ($i = 0; $i < count($result); $i++) {
    $datos[$i] = array(
        "ID_V" => $result[$i]['id_vehiculo'],
        "VEHICULO" => $result[$i]['nombre'],
        "T_VEHICULO" => $result[$i]['tipovehiculo'],
        "MARCA" => $result[$i]['marca'],
        "KILOMETRAJE" => $result[$i]['kilometraje_ac'],
        "HOROMETRO" => $result[$i]['horometro_ac'],
        "RESUMEN" => $aux[$i]
    );    
}

$encode = json_encode($datos);

//_-------------------------------------------------------------------------------------

function calculaMantenimientoHoras($id_vehiculo, $horometro,$intervalo,$val_min,$mensaje)
{
    $horometro = floatval($horometro);
    $intervalo = floatval($intervalo);        
    
    $separa = explode(".", $horometro);

    if (empty($separa[1]))
    {
        $separa[1] = 0;
    }

    $h_i = $separa[0]; ///solo horas en base 60 min
    $m_i = $separa[1]; /// solo porcion hora en base (m_i/10)*60

    $resto = $h_i%$intervalo;

    $div = $h_i/$intervalo;

    $horas_faltan = $intervalo-$resto;
    $nmant = intval($div);

    $horas_faltan += $m_i/10;
    
    $notificacion = NULL;
    
    if ($horas_faltan <= $val_min)
    {
        $notificacion = $mensaje;
    }
    
    $objDB = new Class_Db();
    $con = $objDB->selectManager()->connect();
    
    $query = "SELECT count(m.id_mantenimiento) cantidad FROM mantenimiento m
            WHERE m.id_vehiculo = $id_vehiculo";
    
    $result = $objDB->selectManager()->select($con, $query);    
    
    return array(        
        "NMANT" => $nmant,
        "NMANT_OK" => $result[0]['cantidad'],
        "FALTA" => $horas_faltan,
        "UNIDAD" => "H",
        "NOTIFICACION" => $notificacion,
        "INTERVALO" => $intervalo,
        "VAL_MIN" => $val_min);    
}

function calculaMantenimientoKilom($id_vehiculo, $kilom,$intervalo,$val_min,$mensaje)
{
    $kilom = floatval($kilom);
    $intervalo = floatval($intervalo);        
    
    $separa = explode(".", $kilom);

    if (empty($separa[1]))
    {
        $separa[1] = 0;
    }

    $k_i = $separa[0]; ///solo horas en base 60 min
    $m_i = $separa[1]; /// DEBERIA SER siempre 0

    $resto = $k_i%$intervalo;

    $div = $k_i/$intervalo;

    $km_faltan = $intervalo-$resto;
    $nmant = intval($div);

    //$km_faltan += $m_i/10;
    
    $notificacion = NULL;
    
    if ($km_faltan <= $val_min)
    {
        $notificacion = $mensaje;
    }
    
    $objDB = new Class_Db();
    $con = $objDB->selectManager()->connect();
    
    $query = "SELECT count(m.id_mantenimiento) cantidad FROM mantenimiento m
            WHERE m.id_vehiculo = $id_vehiculo";
    
    $result = $objDB->selectManager()->select($con, $query); 
    
    return array(        
        "NMANT" => $nmant,
        "NMANT_OK" => $result[0]['cantidad'],
        "FALTA" => $km_faltan,
        "UNIDAD" => "KM",
        "NOTIFICACION" => $notificacion,
        "INTERVALO" => $intervalo,
        "VAL_MIN" => $val_min);    
}

$alert = array(
    "info" => "progress-bar progress-bar-info",
    "success" => "progress-bar progress-bar-success",
    "warning" => "progress-bar progress-bar-warning",
    "danger" => "progress-bar progress-bar-danger"
    );
?>
<a class="dropdown-toggle" data-toggle="dropdown" href="#">
    <i class="fa fa-truck fa-fw"></i>  <i class="fa fa-caret-down"></i><label>Mantenimientos</label>
</a>
<ul class="dropdown-menu dropdown-tasks">
    <?php 
    $array = json_decode($encode);            
    
for ($i = 0; $i < count($array); $i++) { 
    $porc = ($array[$i]->RESUMEN->FALTA*100)/($array[$i]->RESUMEN->INTERVALO); 
    $porc_a = round(100-$porc,2);                    
    
    if ($porc_a > $config['muestraVH']) {
    //if ($porc_a >= 0) {
   ?>
    <li>
        <a href="ct_mant_vehiculos.php#<?php echo $array[$i]->ID_V; ?>">
            <div>
                <p>
                    <strong><?php echo $array[$i]->VEHICULO; ?></strong>                    
                    <span class="pull-right text-muted">
                        <?php echo ($array[$i]->RESUMEN->INTERVALO-$array[$i]->RESUMEN->FALTA)."/".($array[$i]->RESUMEN->INTERVALO)." ".$array[$i]->RESUMEN->UNIDAD; ?>
                    </span>                    
                </p>
                <div class="progress progress-striped active">
                    <div 
                        class="
                            <?php 
                            if($porc_a <= 100 && $porc_a > 90) echo $alert['danger']; 
                            else if ($porc_a <= 90 && $porc_a > 70) echo $alert['warning']; 
                            else if ($porc_a <= 70 && $porc_a > 30) echo $alert['success'];
                            else if ($porc_a <= 30) echo $alert['info'];
                            ?>
                            " 
                         role="progressbar" 
                         aria-valuenow="<?php echo ($array[$i]->RESUMEN->INTERVALO - $array[$i]->RESUMEN->FALTA); ?>" 
                         aria-valuemin="0" 
                         aria-valuemax="<?php echo $array[$i]->RESUMEN->INTERVALO; ?>" 
                         style="width: <?php echo $porc_a; ?>%">                        
                        <?php 
                        echo "<b style='color: #000;'>".$porc_a."%</b>";
                        if ($array[$i]->RESUMEN->FALTA >= $array[$i]->RESUMEN->VAL_MIN) {  ?>
                        <span id="notifica1" class="sr-only"><?php echo $porc_a."%"; ?></span>
                        <?php } ?>
                    </div>
                </div>
                <p>
                    <strong><?php echo "( REAL: ". $array[$i]->RESUMEN->NMANT_OK." ) ( RECOM: ". $array[$i]->RESUMEN->NMANT." )"; ?></strong>
                    <span class="pull-right text-muted">                        
                    </span>
                </p>
            </div>                                
        </a>
    </li>
    <li class="divider"></li>
<?php
    }

}
    ?>    
    <li>
        <a class="text-center" href="ct_mant_vehiculos.php">
            <strong>Ver TODO</strong>
            <i class="fa fa-angle-right"></i>
        </a>
    </li>
</ul>                