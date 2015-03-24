<?php include '00header.php'; ?>
<script>

function validarForm(formulario) {                                  
           
            if (formulario.fecha_dev.value.trim().length != 10 )
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
        <div class="col-lg-12">
            <h1 class="page-header">Devoluci&oacute;n de maquinaria</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_devolucion.php?contrato=<?php echo $_GET['contrato']; ?>">
        <img src="../img/atras.png" title="Alquiler por Contrato"><label>Atr&aacute;s</label>
    </a>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <?php
                    include '../../app/controllers/contrato.php';
                    $res = datosContrato(Funciones::decodeStrings($_GET['contrato'],2));                    
                    
                    echo "Datos: <b>(".$res[0]['codigo'].") ".$res[0]['cliente']." / ".$res[0]['obra']."</b>"; 
                    
                    $query = "SELECT v.* FROM vehiculo v "
                            . "INNER JOIN detallealquiler da ON v.id_vehiculo = da.id_vehiculo "                            
                            . "WHERE da.id_detallealquiler = ".Funciones::decodeStrings($_GET['det_alq'],2);
                    
                    $objDB = new Class_Db();
                    $con = $objDB->selectManager()->connect();
                    $result = $objDB->selectManager()->select($con, $query);
                    //die(var_dump($result));
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
                        var pagina="adm_list_devolucion.php?contrato=<?php echo $_GET['contrato']; ?>";
                        function redireccionar() 
                        {
                            location.href=pagina;
                        } 
                        setTimeout ("redireccionar()", 3000);
                    </script>
                    <div class="form-group has-success">
                        <label class="control-label" style="font-size: 20px" for="inputSuccess">
                            Se ha registrado la devoluci&oacute;n exitosamente.<br>
                        </label>
                    </div>                                
                    <?php } else if (Funciones::decodeStrings($_GET['msj'],2) == 'no'){ ?>
                    <script LANGUAGE="JavaScript">
                        var pagina="adm_list_devolucion.php?contrato=<?php echo $_GET['contrato']; ?>";
                        function redireccionar() 
                        {
                            location.href=pagina;
                        } 
                        setTimeout ("redireccionar()", 3000);
                    </script>
                    <div class="form-group has-error">
                        <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido realizar la operaci&oacute;n.</label>
                    </div>
                    <?php }
                    
                    } ?>
                </div>
                <div class="panel-body">
                    <div class="col-lg-6">
                        <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                              action="./../../app/controllers/detalle_alquiler.php?event=dev_vh" >
                            <div class="form-group">
                                <!--label>Estado del veh&iacute;culo: <label style="color: #FF0000">(*)</label> </label-->
                                <input type="hidden" value='' id="estado" name="estado" class="form-control" placeholder="Estado del veh&iacute;culo" maxlength="100"  required autofocus>
                                <!--p class="help-block">Estado.</p-->
                            </div>
                            <input type="hidden" name="contrato" id="contrato" value="<?php echo $_GET['contrato']; ?>" >
                            <input type="hidden" name="det_alq" id="vph" value="<?php echo $_GET['det_alq']; ?>" >
                            <div class="form-group">
                                <label>Fecha de devoluci&oacute;n: <label style="color: #FF0000">(*)</label> </label>
                                <input type="text" id="fecha_dev" name="fecha_dev" class="form-control fechas" placeholder="dd/mm/yyyy" maxlength="10" required>
                                <p class="help-block">Fecha de devoluci&oacute;n.</p>
                            </div>
                            <div class="form-group">
                                <label>Obervaci&oacute;n: </label>
                                <textarea id="observacion" name="observacion" class="form-control" placeholder="Obervaci&oacute;n" cols="6" ></textarea>
                                <p class="help-block">Obervaci&oacute;n.</p>
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