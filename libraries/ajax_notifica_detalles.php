<?php
include '../Config.inc.php';

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();

$result = $objDB->selectManager()->spSelect($con, "sp_datos_notificaciones");

$datos = array();

for ($i = 0; $i < count($result); $i++) {
    if ( $result[$i]['unidad'] == "H")
    {
        $aux[$i] = calculaMantenimientoHoras($result[$i]['horometro_ac'], $result[$i]['intervalo'],
                $result[$i]['notifica_val'],$result[$i]['notificacion']);       
    }else if ($result[$i]['unidad'] == "KM")
    {
        $aux[$i] = calculaMantenimientoKilom($result[$i]['kilometraje_ac'], $result[$i]['intervalo'],
                $result[$i]['notifica_val'],$result[$i]['notificacion']);       
    }
}

for ($i = 0; $i < count($result); $i++) {
    $datos[$i] = array(
        "VEHICULO" => $result[$i]['nombre'],
        "T_VEHICULO" => $result[$i]['tipovehiculo'],
        "MARCA" => $result[$i]['marca'],
        "KILOMETRAJE" => $result[$i]['kilometraje_ac'],
        "HOROMETRO" => $result[$i]['horometro_ac'],
        "RESUMEN" => $aux[$i]
    );    
}

//print_r("<pre>");
////print_r(var_dump($datos));
//print_r("</pre>");
//
//print_r("<br>");
//
$encode = json_encode($datos);
//print_r(json_decode($encode));
//
//print_r("<pre>");
//print_r($encode);
//print_r("</pre>");
//
//print_r("<br>");
//
//print_r("<pre>");
////print_r(json_decode($encode));
//print_r("</pre>");


//_-------------------------------------------------------------------------------------

function calculaMantenimientoHoras($horometro,$intervalo,$val_min,$mensaje)
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

    return array(
        "NMANT" => $nmant,
        "FALTA" => $horas_faltan,
        "UNIDAD" => "H",
        "NOTIFICACION" => $notificacion,
        "INTERVALO" => $intervalo,
        "VAL_MIN" => $val_min);    
}

function calculaMantenimientoKilom($kilom,$intervalo,$val_min,$mensaje)
{
    $kilom = floatval($horometro);
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

    return array(
        "NMANT" => $nmant,
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
    <i class="fa fa-truck fa-fw"></i>  <i class="fa fa-caret-down"></i>
</a>
<ul class="dropdown-menu dropdown-tasks">
    <?php 
    $array = json_decode($encode);
    
for ($i = 0; $i < count($array); $i++) { ?>
    <li>
        <a href="#">
            <div>
                <p>
                    <strong><?php echo $array[$i]->VEHICULO; ?></strong>
                    <?php 
                    $porc = ($array[$i]->RESUMEN->FALTA*100)/($array[$i]->RESUMEN->INTERVALO); 
                    $porc_a = 100-$porc;
                        ?>
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
                        <?php if ($array[$i]->RESUMEN->FALTA >= $array[$i]->RESUMEN->VAL_MIN) { ?>
                        <span id="notifica1" class="sr-only"><?php echo $porc_a; ?>%</span>
                        <?php } ?>
                    </div>
                </div>
            </div>                                
        </a>
    </li>
    <li class="divider"></li>
<?php
  }
    ?>       
</ul>                