<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Gu&iacute;as de compra de combustible</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Gu&iacute;as 
                </div>
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">
                        <a href="ct_registro_guia.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>N</th>                                  
                                    <th>Nro.</th>
                                    <th>Cant.</th>
                                    <th>Stock</th>
                                    <th>Tipo Comb.</th>
                                    <th>Fecha</th>
                                    <th>Abastecedor</th>
                                    <th>Conductor</th>
                                    <th>Veh&iacute;culo</th>                                    
                                    <th>Comprobante</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_guias.php'; 
                                table();
                                ?>
                            </tbody>
                        </table>
                        <a href="ct_registro_guia.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>