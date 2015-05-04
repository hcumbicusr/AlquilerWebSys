<?php
if (empty($_POST['id']) || empty($_POST['desde']) || empty($_POST['hasta']))
{
    echo ' 
    <div class="alert alert-warning">
        <p>
            Debe ingresar el rango de fechas.                                       
        </p>
    </div>
    ';
}else
{
    //echo "<a id='linkValPDF' class='btn btn-primary' href='../../reportes/rep_valorizacion_acumulada.php?cliente=".$_POST['id']."&desde=".$_POST['desde']."&hasta=".$_POST['hasta']."' target='_blank'>Ver valorización (PDF)</a>";
    //echo "<br><a id='linkValXLS' class='btn btn-info' href='../../reportes/rep_valorizacion_acumulada_xls.php?cliente=".$_POST['id']."&desde=".$_POST['desde']."&hasta=".$_POST['hasta']."' target='_blank'>Ver valorización (EXCEL)</a>";
    echo "<br><a  id='linkValXLS_all' class='btn btn-primary' href='../../reportes/rep_valorizacion_acumulada_det_xls.php?cliente=".$_POST['id']."&desde=".$_POST['desde']."&hasta=".$_POST['hasta']."' target='_blank'>Ver valorización Detallada (EXCEL)</a>";
}
