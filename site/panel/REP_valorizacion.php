<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Listado de clientes VALORIZACION</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Clientes
                </div>
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>                                                                      
                                    <th>DNI/RUC</th>
                                    <th>Nombre</th>
                                    <th>Tipo Cliente</th>
                                    <th>Direcci&oacute;n</th>
                                    <th>Tel&eacute;fono</th>
                                    <th>F. Registro</th>
                                    <th>Opci&oacute;n</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php // valorizacion por cliente TOTAL
                                require_once '../../libraries/HTML_cliente_valorizacion.php'; 
                                table();
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