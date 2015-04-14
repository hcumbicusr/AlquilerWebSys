<?php include '00header.php'; ?>
<?php
$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
$query = "select concat(cl.nombre,' / ', ob.nombre) as contrato from contrato c
        INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente
        INNER JOIN obra ob ON c.id_obra = ob.id_obra 
        WHERE id_contrato = ".Funciones::decodeStrings($_GET['contrato'], 2);

$result = $objDB->selectManager()->select($con, $query);

?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Partes diarios registrados para: <br> <b> <?php echo $result[0]['contrato']; ?></b></h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="ct_historial_por_contrato.php">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Historial de Registro >> Partes diarios >> Partes por contrato
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
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_parte_x_contrato.php'; 
                                table($_GET['contrato']);
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