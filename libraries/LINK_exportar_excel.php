<?php
if (empty($_POST['event']) || empty($_POST['desde']) || empty($_POST['hasta']))
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
    switch ($_POST['event'])
    {
        case 'guia': 
            echo "<a id='btnExportaGuias' class='btn btn-primary' href='../../reportes/rep_guias_exp.php?desde=".$_POST['desde']."&hasta=".$_POST['hasta']."' target='_blank'> Exportar (EXCEL)</a>";
            break;
        case 'comprobante': 
            break;
        
    }    
}