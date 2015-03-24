<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Listado de veh&iacute;culos y maquinarias</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Veh&iacute;culos y maquinarias
                </div>                
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">                        
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>                                                                      
                                    <th>Tipo</th>
                                    <th>Nombre</th>
                                    <th>Modelo</th>
                                    <th>Serie</th>
                                    <th>Motor</th>
                                    <th>Color</th>
                                    <th>Placa</th>
                                    <th>Precio Hora</th>
                                    <th>Estado</th>                                    
                                    <th>Reporte</th>   
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_vehiculos.php'; 
                                table('rend');
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