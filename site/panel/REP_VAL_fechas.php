<?php include '00header.php'; ?>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Valorizaci&oacute;n acumulada entre fechas</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="REP_valorizacion.php">
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
                                <input type="hidden" name="cliente_val" id="cliente_val" value="<?php echo $_GET['cliente']; ?>" >
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
                                <?php if (!empty($_GET['cliente'])) { ?>
                                <a id="btnValoriza" name="btnValoriza" class="btn btn-default" >Generar Valorizaci&oacute;n</a>
                                <?php }else { ?>
                                <script>
                                    setInterval(window.location.href = "REP_valorizacion.php",2);
                                </script>
                                <?php } ?>
                                <button id="btnResetVal" type="reset" class="btn btn-default">Limpiar todo</button><br>
                                <div id="link_valoriza"></div>
                            </form>
                            
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>