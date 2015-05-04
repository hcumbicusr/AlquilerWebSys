<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Consumo de combustible de veh&iacute;culos</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Vales de combustible 
                </div>
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">
                        <a href="ct_abastecimiento_vh.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                        <a href="adm_exportar_guias.php?rep=vale" class="btn btn-primary" style="margin: 5px">Exportar excel</a>
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>N</th> 
                                    <th>Fecha</th>
                                    <th>Vale</th>
                                    <th>Cant.</th>                                    
                                    <th>Tipo Comb.</th>                                    
                                    <th>Abastecedor</th>
                                    <th>Veh&iacute;culo</th>
                                    <th>Conductor</th>                                    
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_guias.php'; 
                                table("VH"); // listado de maquinaria
                                ?>
                            </tbody>
                        </table>
                        <a href="ct_abastecimiento_vh.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                        <a href="adm_exportar_guias.php?rep=vale" class="btn btn-primary" style="margin: 5px">Exportar excel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>