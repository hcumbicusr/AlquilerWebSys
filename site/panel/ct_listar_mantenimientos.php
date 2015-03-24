<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Mantenimientos/reparaciones de maquinaria</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="ct_list_vehiculos.php">
        <img src="../img/atras.png" title="Ve&iacute;culos"><label>Atr&aacute;s</label>
    </a>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <?php 
                        $objDB = new Class_Db();
                        $con = $objDB->selectManager()->connect();
                        $query = "SELECT concat( v.nombre,'[',ifnull(v.modelo,''),'][',ifnull(v.serie,''),'][',ifnull(v.placa,''),']' ) as nombre_c "
                                . " FROM vehiculo v WHERE id_vehiculo = ".Funciones::decodeStrings($_GET['v'], 2);
                        $select = $objDB->selectManager()->select($con, $query);
                        //
                        ?>
                    Maquinaria: <b> <?php echo $select[0]['nombre_c']; ?> </b>
                </div>                
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">                        
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>                                                                      
                                    <th>Causa</th>
                                    <th>Descripci&oacute;n</th>                                    
                                    <th>Lugar de mantenimiento</th>
                                    <th>Horometro</th>
                                    <th>Ingreso</th>
                                    <th>Salida</th>
                                    <th>Actualmente</th>                                                                                                       
                                    <th>Costo</th>  
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_mantenimientos.php'; 
                                table($_GET['v']);
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