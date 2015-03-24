<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Listado de trabajadores registrados</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Trabajadores
                </div>
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">
                        <a href="adm_registro_trabajador.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>
                                    <th>Nombre</th>
                                    <th>Fecha de Nac.</th>
                                    <th>DNI</th>
                                    <th>RUC</th>
                                    <th>Tel&eacute;fono</th>
                                    <th>Usuario</th>
                                    <th>Tipo de usuario</th>
                                    <th>Estado</th>                                    
                                    <th>Nro. Licencia</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_trabajador.php'; 
                                table();
                                ?>
                            </tbody>
                        </table>
                        <a href="adm_registro_trabajador.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>