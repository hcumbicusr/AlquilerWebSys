<?php include '00header.php'; ?>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Partes diarios entre fechas</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Historial de Registro >> Partes diarios >> Entre Fechas<br>                    
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
                                
                                <a id="btnMuestra" name="btnMuestra" class="btn btn-default" > Mostrar Partes Diarios</a>
                                
                                <button id="btnResetVal" type="reset" class="btn btn-default">Limpiar todo</button><br>
                                
                            </form>
                            <br>
                            <label id="msgPartesFech"></label>
                        </div>
                        
                        <div id="divGuiasFech" class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Partes diarios
                                </div>
                                <div class="panel-body table-responsive">
                                    <div id="tablaPartes" class="dataTable_wrapper">
                                        <a href="ct_list_clientes.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                                        
                                        <a href="ct_list_clientes.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>