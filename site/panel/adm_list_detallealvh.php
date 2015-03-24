<?php include '00header.php'; ?>

<div id="page-wrapper">
    
    <div class="row">        
        <div class="col-lg-12">
            <h1 class="page-header">Maquinaria alquilada</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_contratos.php">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <?php
                    include '../../app/controllers/detalle_alquiler.php';
                    $res = datosContrato(Funciones::decodeStrings($_GET['contrato'],2));
                    
                    echo "Maquinaria alquilada para: <b>(".$res[0]['codigo'].") ".$res[0]['cliente']." / ".$res[0]['obra']."</b>"; 
                    ?>
                </div>
                <div class="panel-body table-responsive">                    
                    <div class="dataTable_wrapper">
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>                                                                      
                                    <th>Maquinaria</th>
                                    <th>Precio Hora</th>
                                    <th>Fecha Alquiler</th> 
                                    <th>Opci&oacute;n</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_alquiler_vehiculos.php'; 
                                table($_GET['contrato']);
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- /////////////////////////////////////////  -->
    
    <div class="row">        
        <div class="col-lg-12">
            <h1 class="page-header">Art&iacute;culos</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_contratos.php">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <?php                                        
                    echo "Art&iacute;culos alquilados para: <b>(".$res[0]['codigo'].") ".$res[0]['cliente']." / ".$res[0]['obra']."</b>"; 
                    ?>
                </div>
                <div class="panel-body table-responsive">                    
                    <div class="dataTable_wrapper">
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>                                                                      
                                    <th>Art&iacute;culos</th>
                                    <th>Precio Hora</th>
                                    <th>Fecha Alquiler</th>                                                                        
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_alquiler_articulos.php'; 
                                table2($_GET['contrato']);
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
       
</div>

<?php include '00footer.php'; ?>