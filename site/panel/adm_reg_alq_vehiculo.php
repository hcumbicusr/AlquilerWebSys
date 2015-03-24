<?php include '00header.php'; ?>
<script>

function validarForm(formulario) {            
                       
            if (formulario.fecha_alq.value.trim().length != 10 )
            {
                formulario.fecha_alq.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco 
            } 
            if (formulario.observacion.value.trim().length < 4 )
            {
                formulario.observacion.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco 
            } 
            return true;
          }

</script>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Alquiler de Maquinaria</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_select_alq_vehiculos.php?contrato=<?php echo $_GET['contrato']; ?>">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <?php
                    include '../../app/controllers/contrato.php';
                    $res = datosContrato(Funciones::decodeStrings($_GET['contrato'],2));                    
                    
                    echo "Datos: <b>(".$res[0]['codigo'].") ".$res[0]['cliente']." / ".$res[0]['obra']."</b>"; 
                    
                    $query = "SELECT v.* FROM vehiculo v WHERE v.id_vehiculo = ".Funciones::decodeStrings($_GET['v'],2);
                    
                    $objDB = new Class_Db();
                    $con = $objDB->selectManager()->connect();
                    $result = $objDB->selectManager()->select($con, $query);
                    ?>
                    <br>
                    <label style="color: #0000FF">
                        Maquinaria: <?php echo $result[0]['nombre']." /MOD: ".$result[0]['modelo']." /SERIE: ".$result[0]['serie']." /PLACA: ".$result[0]['placa']; ?>
                    </label>
                </div>
                <div>
                    <?php if(!empty($_GET['msj'])) { ?>                                 

                    <?php if (Funciones::decodeStrings($_GET['msj'],2) == 'ok') { ?>
                    <script LANGUAGE="JavaScript">
                        var pagina="adm_select_alq_vehiculos.php?contrato=<?php echo $_GET['contrato']; ?>";
                        function redireccionar() 
                        {
                            location.href=pagina;
                        } 
                        setTimeout ("redireccionar()", 3000);
                    </script>
                    <div class="form-group has-success">
                        <label class="control-label" style="font-size: 20px" for="inputSuccess">
                            Registrado con &eacute;xito.<br>
                        </label>
                    </div>                                
                    <?php } else if(Funciones::decodeStrings($_GET['msj'],2) == 'inc') { ?>
                    <script LANGUAGE="JavaScript">
                        var pagina="adm_select_alq_vehiculos.php?contrato=<?php echo $_GET['contrato']; ?>";
                        function redireccionar() 
                        {
                            location.href=pagina;
                        } 
                        setTimeout ("redireccionar()", 3000);
                    </script>
                    <div class="form-group has-error">
                        <label class="control-label" style="font-size: 20px" for="inputError">No se han registrado todos los vehiculos/maquinarias</label>
                    </div>
                    <?php }else if (Funciones::decodeStrings($_GET['msj'],2) == 'no'){ ?>
                    <script LANGUAGE="JavaScript">
                        var pagina="adm_select_alq_vehiculos.php?contrato=<?php echo $_GET['contrato']; ?>";
                        function redireccionar() 
                        {
                            location.href=pagina;
                        } 
                        setTimeout ("redireccionar()", 3000);
                    </script>
                    <div class="form-group has-error">
                        <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido realizar la operaci&oacute;n.</label>
                    </div>
                    <?php }else { ?>
                    <script LANGUAGE="JavaScript">
                        var pagina="adm_select_alq_vehiculos.php?contrato=<?php echo $_GET['contrato']; ?>";
                        function redireccionar() 
                        {
                            location.href=pagina;
                        } 
                        setTimeout ("redireccionar()", 3000);
                    </script>
                    <div class="form-group has-error"
                        <label class="control-label" style="font-size: 20px" for="inputError">No se han seleccionado veh&iacute;culos o maquinarias.</label>
                    </div>  
                    <?php } } ?>
                </div>
                <div class="panel-body">
                    <div class="col-lg-6">
                        <?php                        
                        $con = $objDB->selectManager()->connect();
                        $contrato = Funciones::decodeStrings($_GET['contrato'], 2);
                        $query = "SELECT date(f_inicio) as f_inicio FROM contrato WHERE id_contrato = $contrato";                        
                        $result = $objDB->selectManager()->select($con, $query);
                        
                        list($anio,$mes,$dia) = explode("-", $result[0]['f_inicio']);
                        $fecha = $dia."/".$mes."/".$anio;
                        ?>
                        <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                              action="./../../app/controllers/detalle_alquiler.php?event=registrar_vh" >
                            <div class="form-group">
                                <!--label>Estado del veh&iacute;culo: <label style="color: #FF0000">(*)</label> </label-->
                                <input type="hidden" value='' id="estado" name="estado" class="form-control" placeholder="Estado del veh&iacute;culo" maxlength="100"  required autofocus>
                                <!--p class="help-block">Estado.</p-->
                            </div>
                            <input type="hidden" name="contrato" id="contrato" value="<?php echo $_GET['contrato']; ?>" >
                            <input type="hidden" name="v" id="vph" value="<?php echo $_GET['v']; ?>" >
                            <div class="form-group">
                                <label>Fecha de alquiler: <label style="color: #FF0000">(*)</label> </label>
                                <input type="text" id="fecha_alq" name="fecha_alq" value="<?php echo $fecha; ?>" class="form-control fechas_v" placeholder="dd/mm/yyyy" maxlength="10" required>
                                <p class="help-block">Fecha de alquiler.</p>
                            </div>
                            <div class="form-group">
                                <label>Labor: <label style="color: #FF0000">(*)</label> </label>
                                <textarea id="observacion" name="observacion" class="form-control" placeholder="Labor" cols="6" required ></textarea>
                                <p class="help-block">Labor.</p>
                            </div>  
                            <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                            <button type="submit" class="btn btn-default">Guardar</button>
                            <button type="reset" class="btn btn-default">Limpiar todo</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>