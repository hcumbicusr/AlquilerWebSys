<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Historial: Vales registrados hasta el momento</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Resumen de consumo de combustible
                </div>
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">
                        <a href="ct_list_clientes.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>
                                    <th>Fecha</th>                                                                        
                                    <th>Nro Gu&iacute;a</th>
                                    <th>Nro Vale</th>
                                    <th>Nro Surtidor</th>
                                    <th>Veh&iacute;culo</th>
                                    <th>Hor&oacute;metro</th>
                                    <th>Cant. Comb.</th>
                                    <th>Operario</th>                             
                                    <th>Cotrolador</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_consumo_comb.php'; 
                                table();
                                ?>
                            </tbody>
                        </table>
                        <a href="ct_list_clientes.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>