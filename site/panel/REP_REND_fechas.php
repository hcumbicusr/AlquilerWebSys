<?php include '00header.php'; ?>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Rendimiento de veh&iacute;culos entre fechas</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="REP_rendimiento_vh.php">
        <img src="../img/atras.png" title="Clientes"><label>Atr&aacute;s</label>
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
                                <input type="hidden" name="vehiculo_rend" id="vehiculo_rend" value="<?php echo $_GET['vehiculo']; ?>" >
                                <div class="form-group">
                                    <label>Desde: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="desde_rend" name="desde_rend"  class="form-control fechas" placeholder="dd/mm/yyyy"  required maxlength="10">
                                    <p class="help-block">Desde.</p>
                                </div>                                 
                                <div class="form-group">
                                    <label>Hasta: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="hasta_rend" name="hasta_rend"  class="form-control fechas" placeholder="dd/mm/yyyy"  required maxlength="10">
                                    <p class="help-block">Hasta.</p>
                                </div>                                 
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['vehiculo'])) { ?>
                                <a id="btnRendimiento" name="btnRendimiento" class="btn btn-default" > Procesar</a>
                                <?php }else { ?>
                                <script>
                                    setInterval(window.location.href = "REP_rendimiento_vh.php",2);
                                </script>
                                <?php } ?>
                                <button type="reset" class="btn btn-default">Limpiar todo</button><br>
                                <div id="link_rendimiento"></div>
                            </form>
                            
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>