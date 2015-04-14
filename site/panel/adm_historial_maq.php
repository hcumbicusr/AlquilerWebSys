<?php include '00header.php'; ?>
<?php
$query = "SELECT v.* FROM vehiculo v WHERE v.id_vehiculo = ".Funciones::decodeStrings($_GET['vh'],2);
//die ($query);
$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
$result = $objDB->selectManager()->select($con, $query);
?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Historial de alquiler de maquinaria</h1>
            <label style="color: #0000FF">
                Maquinaria: <?php echo $result[0]['nombre']." /MOD: ".$result[0]['modelo']." /SERIE: ".$result[0]['serie']." /PLACA: ".$result[0]['placa']; ?>
            </label>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_vehiculos.php">
        <img src="../img/atras.png" title="Maquinaria"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Seleccione las fechas<br>                    
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">                            
                            <form role="form">                                
                                <input type="hidden" name="maq" id="maq" value="<?php echo $_GET['vh']; ?>" >
                                <div class="form-group">
                                    <label>Desde: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="desde_val" name="desde_val" class="form-control desdeFech" placeholder="dd/mm/yyyy" required maxlength="10">
                                    <p class="help-block">Desde.</p>
                                </div>                                 
                                <div class="form-group">
                                    <label>Hasta: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="hasta_val" name="hasta_val" class="form-control hastaFech" placeholder="dd/mm/yyyy" required maxlength="10">
                                    <p class="help-block">Hasta.</p>
                                </div>                                 
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['vh'])) { ?>
                                <a id="btnHistorial" name="btnHistorial" class="btn btn-default" > Generar Excel</a>
                                <?php }else { ?>
                                <script>
                                    setInterval(window.location.href = "adm_list_vehiculos.php",2);
                                </script>
                                <?php } ?>
                                <button id="btnResetVal" type="reset" class="btn btn-default">Limpiar todo</button><br>
                                <div id="link_historial"></div>
                            </form>
                            
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>