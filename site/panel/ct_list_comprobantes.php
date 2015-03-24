<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Comprobantes de compra de combustible</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Comprobantes
                </div>
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">
                        <a href="ct_registro_comprobante.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>N</th>                                  
                                    <th>Nro.</th>
                                    <th>Tipo</th>
                                    <th>Nro.Operaci&oacute;n o Cheque</th>
                                    <th>Fecha</th>
                                    <th>Abastecedor</th>
                                    <th>Compra</th>
                                    <th>Tipo Comb.</th>
                                    <th>Precio Unit.</th>
                                    <th>Total de Compra</th>                                    
                                    <th>En gu&iacute;as</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_comprobantes.php'; 
                                table();
                                ?>
                            </tbody>
                        </table>
                        <a href="ct_registro_comprobante.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>