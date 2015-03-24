<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Listado de alquiler / Devoluci&oacute;n</h1>
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
                    Alquiler<br>
                    <?php
                    include '../../app/controllers/contrato.php';
                    $res = datosContrato(Funciones::decodeStrings($_GET['contrato'],2));                    
                    
                    echo "Datos: <b>(".$res[0]['codigo'].") ".$res[0]['cliente']." / ".$res[0]['obra']."</b>"; 
                    ?>
                </div>
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>                                                                      
                                    <th>Veh&iacute;culo/Art&iacute;culo</th>                                    
                                    <th>Estado</th>
                                    <th>Opci&oacute;n</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_alquiler_contrato.php'; 
                                table($_GET['contrato']);
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