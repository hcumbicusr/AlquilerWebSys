<?php
include '../Config.inc.php';
include '../configuration/Funciones.php';
if (empty($_POST))
{ ?>
<script>
    setInterval(window.location.href = '../',0);
</script>
<?php }

$event = $_POST['event'];

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
session_start();

switch ($event) {
    case 'partes':
        @list($dia,$mes,$anio) = explode("/", $_POST['desde']);
        $desde = $anio."-".$mes."-".$dia;
        @list($dia,$mes,$anio) = explode("/", $_POST['hasta']);
        $hasta = $anio."-".$mes."-".$dia;
        //echo $desde;
        //echo $hasta;
        $result = $objDB->selectManager()->spSelect($con, "sp_listar_partes_x_fechas","'$desde','$hasta'");
        //die(var_dump($result));
        if (!empty($result))
        {
            echo table($result);
        }else
        {
            echo 0;
        }
        
        break;         
}

function table ($select)
{ 
    $tabla = "<table class='table table-striped table-bordered table-hover' id='tblGuiasFech'>
                                            <thead>
                                                <tr>
                                                    <th>Nro</th>
                                                    <th>Fecha</th>                                    
                                                    <th>Nro Parte</th>
                                                    <th>Lugar</th>
                                                    <th>Tarea</th>
                                                    <th>Veh&iacute;culo</th>
                                                    <th>Turno</th>
                                                    <th>Horom. Inicial</th>
                                                    <th>Horom. Final</th>
                                                    <th>Total H.</th>
                                                    <th>Operador</th>
                                                    <th>Controlador</th>
                                                </tr>
                                            </thead>
                                            <tbody>";
    
    for ($i = 0; $i < count($select); $i++)
    {
        $tabla .= "
    <tr>
        <td>".($i+1)."</td>
        <td>".$select[$i]['fecha']."</td>                        
        <td>".$select[$i]['nro_parte']."</td>
        <td>".$select[$i]['lugar_trabajo']."</td>
        <td>".$select[$i]['tarea']."</td>
        <td>".$select[$i]['vehiculo']."</td>        
        <td>".$select[$i]['turno']."</td> 
        <td>".$select[$i]['horometro_inicio']."</td>
        <td>".$select[$i]['horometro_fin']."</td>
        <td>".$select[$i]['total_h']."</td>        
        <td>".$select[$i]['operario']."</td>
        <td>".$select[$i]['controlador']."</td>        
    </tr>";
    }
    $tabla .="</tbody></table>";
    //die(var_dump($tabla));
    return $tabla;
}