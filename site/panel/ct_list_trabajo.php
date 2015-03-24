<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Historial: Partes diarios registrados hasta el momento</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Resumen de trabajo realizado
                </div>
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">
                        <a href="ct_list_clientes.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>
                                    <th>Fecha</th>                                    
                                    <th>Nro Parte</th>
                                    <th>Lugar</th>
                                    <th>Tarea</th>
                                    <th>Veh&iacute;culo</th>
                                    <th>Turno</th>
                                    <th>Horom. Inicial</th>
                                    <th>Horom. Final</th>
                                    <th>Total H.</th>
                                    <th>Operario</th>
                                    <th>Controlador</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_parte_maquinaria.php'; 
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