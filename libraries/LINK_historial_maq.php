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
    echo "<a id='link_hist' class='btn btn-primary' href='../../reportes/rep_historial_maq.php?vehiculo=".$_POST['id']."&desde=".$_POST['desde']."&hasta=".$_POST['hasta']."' target='_blank'><i class='fa fa-file-excel-o'></i> Exportar (EXCEL)</a>";
}