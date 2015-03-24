<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Contratos</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="REP_consumo_contrato.php">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Contratos
                </div>                
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">                        
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>                                                                                                          
                                    <th>RUC</th>
                                    <th>Nombre</th>
                                    <th>Obra</th>
                                    <th>Tipo</th>
                                    <th>F. Inicio</th>
                                    <th>F. Fin</th>                                                                       
                                    <th>Opci&oacute;n</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_contratos_rep.php'; 
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