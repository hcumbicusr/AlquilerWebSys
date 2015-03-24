<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Tipos</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                     Tipos
                </div>                
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">                        
                        <div class="col-lg-6">
                            
                            <div class="form-group">
                                <label>Tipo al que pertenece: <label style="color: #FF0000">(*)</label> </label>
                                <select id="tipo_tabla" name="tipo" required class="form-control">
                                    <option></option>
                                    <option value="ARTICULO">ART&Iacute;CULO</option>
                                    <option value="CLIENTE">CLIENTE</option>
                                    <option value="COMBUSTIBLE">COMBUSTIBLE</option>
                                    <option value="COMPROBANTE">COMPROBANTE</option>
                                    <option value="MARCA">MARCA</option>
                                    <option value="OBRA">OBRA</option>
                                    <option value="TRABAJADOR">TRABAJADOR</option>
                                    <option value="USUARIO">USUARIO</option>
                                    <option value="VEHICULO">VEH&Iacute;CULO</option>
                                </select>
                                <p id="msg_tabla"></p>
                            </div>
                            <a href="adm_reg_tipos.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                        </div>
                        <div class="col-lg-6">
                            <table class="table table-striped table-bordered table-hover" id="tbl_tipos">
                                <thead>
                                    <tr>
                                        <th>Nro</th>
                                        <th>Nombre</th>
                                        <th>Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                            <a href="adm_reg_tipos.php" class="btn btn-primary" style="margin: 5px">Registrar</a>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>