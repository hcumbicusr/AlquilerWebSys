<?php include '00header.php'; ?>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <?php if($_GET['rep'] == 'guia') { ?>
            <h1 class="page-header">Exportar gu&iacute;as entre fechas</h1>
            <?php } else if($_GET['rep'] == 'vale') { ?>
            <h1 class="page-header">Exportar vales entre fechas</h1>
            <?php } ?>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <?php if($_GET['rep'] == 'guia') { ?>
    <a href="ct_list_guias.php">
    <?php } else if($_GET['rep'] == 'vale') { ?>
    <a href="ct_list_vale_comb.php">
    <?php } ?>
        <img src="../img/atras.png" title=""><label>Atr&aacute;s</label>
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
                                <a id="btnExportaGuia" name="btnExportaGuia" class="btn btn-default" > Generar Excel</a>                                
                                <button id="btnResetVal" type="reset" class="btn btn-default">Limpiar todo</button><br>
                                <div id="link_exportar"></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>