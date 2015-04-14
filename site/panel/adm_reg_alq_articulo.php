<?php include '00header.php'; ?>
<script>

function validarForm(formulario) {                       
           
            if (formulario.fecha_alq.value.trim().length != 10)
            {
                formulario.fecha_alq.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            }            
            return true;
          }

</script>
<div id="page-wrapper">
    <div class="row">
        <?php if ($_SESSION['tipo_usuario'] != $config['typeUserAdmin']) { ?>
        <label style="font-size: 25px; color: #FF0000; margin-left: 50px">
            Esta operaci&oacute;n debe ser realizada por el administrador del sistema !!
        </label>
        <script>           
            setInterval(function(){ window.location.href = "./"; window.close(); },3000);            
        </script>
        <?php } ?>
    </div>
    
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Alquiler de art&iacute;culos</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_select_alq_articulos.php?contrato=<?php echo $_GET['contrato']; ?>">
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
                    
                    $query = "SELECT a.* FROM articulo a WHERE a.id_articulo = ".Funciones::decodeStrings($_GET['articulo'],2);
                    
                    $objDB = new Class_Db();
                    $con = $objDB->selectManager()->connect();
                    $result = $objDB->selectManager()->select($con, $query);
                    $precio_alq = $result[0]['precio_alq'];
                    ?>
                    <br>
                    <label style="color: #0000FF">
                        Art&iacute;culo: <?php echo $result[0]['nombre']." /SERIE: ".$result[0]['serie']; ?>
                    </label>
                </div>
                <div>
                    <?php if(!empty($_GET['msj'])) { ?>                                 

                    <?php if (Funciones::decodeStrings($_GET['msj'],2) == 'ok') { ?>
                    <script LANGUAGE="JavaScript">
                        var pagina="adm_select_alq_articulos.php?contrato=<?php echo $_GET['contrato']; ?>";
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
                        var pagina="adm_select_alq_articulos.php?contrato=<?php echo $_GET['contrato']; ?>";
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
                        var pagina="adm_select_alq_articulos.php?contrato=<?php echo $_GET['contrato']; ?>";
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
                        var pagina="adm_select_alq_articulos.php?contrato=<?php echo $_GET['contrato']; ?>";
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
                              action="./../../app/controllers/detalle_alquiler.php?event=registrar_art" >
                            <div class="form-group">
                                <!--label>Estado: <label style="color: #FF0000">(*)</label> </label-->
                                <input type="hidden" value='' id="estado" name="estado" class="form-control" placeholder="Estado del art&iacute;culo" maxlength="100"  required autofocus>
                                <!--p class="help-block">Estado.</p-->
                            </div>
                            <input type="hidden" name="contrato" id="contrato" value="<?php echo $_GET['contrato']; ?>" >
                            <input type="hidden" name="articulo" id="vph" value="<?php echo $_GET['articulo']; ?>" >
                             <div class="form-group">
                                <label>Fecha de alquiler: <label style="color: #FF0000">(*)</label> </label>
                                <input type="text" id="fecha_alq" name="fecha_alq" value="<?php echo $fecha; ?>" class="form-control fechas_v" placeholder="dd/mm/yyyy" maxlength="10" required>
                                <p class="help-block">Fecha de alquiler.</p>
                            </div>
                            <div class="form-group">
                                <label>Precio de alquiler: <label style="color: #FF0000">(*)</label> </label>
                                <input id="precio_alq" name="precio_alq" value="<?php echo $precio_alq; ?>" class="form-control" placeholder="000000.00" 
                                       required value="0" onkeypress="return NumCheck(event,this);" maxlength="15" >
                                <p class="help-block">Precio de alquiler.</p>
                            </div>
                            <!--div class="form-group">
                                <label>Obervaci&oacute;n: </label>
                                <textarea id="observacion" name="observacion" class="form-control" placeholder="Obervaci&oacute;n" cols="6" ></textarea>
                                <p class="help-block">Obervaci&oacute;n.</p>
                            </div-->  
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