<?php include '00header.php'; ?>
<?php if (empty($_GET)) {  ?>
<script LANGUAGE="JavaScript">
    var pagina="index.php";
    function redireccionar() 
    {
        location.href=pagina;
    } 
    setTimeout ("redireccionar()", 0);
</script>
<?php } ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Seleccione la maquinaria</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="REP_consumo_contrato.php">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <?php 
                    $objDB = new Class_Db();
                    $con = $objDB->selectManager()->connect();
                    $query = "SELECT c.nombre as cliente,o.nombre as obra FROM cliente c "
                            . "INNER JOIN contrato con ON c.id_cliente = con.id_cliente "
                            . "INNER JOIN obra o ON con.id_obra = o.id_obra "
                            . "WHERE con.id_contrato = ".Funciones::decodeStrings($_GET['contrato'], 2); 
                    //die(var_dump($query));
                    $select = $objDB->selectManager()->select($con, $query);
                    ?>
                <div class="panel-heading">                    
                    Seleccione la maquinaria<br>
                    <label>Cliente/Obra:</label>
                    <label style="color: #0000FF">
                        <?php echo $select[0]['cliente']." / ".$select[0]['obra']; ?>
                    </label>
                </div>                
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">                        
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>                                                      
                                    <th>Nombre de Maquinaria</th>                                                                     
                                    <th>Opci&oacute;n</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                require_once '../../libraries/HTML_tabla_consumo_vh.php'; 
                                table($_GET['contrato']);
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