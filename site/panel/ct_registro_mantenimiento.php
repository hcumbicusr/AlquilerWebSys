<?php include '00header.php'; ?>

<script>
        //Función que permite solo Números
        function ValidaSoloNumeros() {
         if ((event.keyCode < 48) || (event.keyCode > 57)) 
          event.returnValue = false;
        }
        
        function NumCheck(e, field) {
            key = e.keyCode ? e.keyCode : e.which;
            if (key == 8) return true;
            if (key > 47 && key < 58) {
              if (field.value == "") return true;
              regexp = /.[0-9]{10}$/;
              return !(regexp.test(field.value));
            }
            if (key == 46) {
              if (field.value == "") return false;
              regexp = /^[0-9]+$/;
              return regexp.test(field.value);
            }
            return false;
          }
        //validar longitud de cadena
        function validarForm(formulario) {            
            if (formulario.nro_parte.value.trim().length < 4)
            {
                formulario.nro_parte.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.lugar_trabajo.value.trim().length < 3)
            {
                formulario.lugar_trabajo.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.tarea.value.trim().length < 3)
            {
                formulario.tarea.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.horometro.value.trim().length < 2)
            {
                formulario.horometro.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.kilometraje.value.trim().length < 1)
            {
                formulario.kilometraje.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.fecha.value.trim().length != 10)
            {
                formulario.fecha.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.descuento.value.trim().length == 0)
            {
                formulario.descuento.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Registro de Mantenimiento/Reparaci&oacute;n</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="ct_list_vehiculos.php">
        <img src="../img/atras.png" title="Ve&iacute;culos"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro de Mantenimiento/Reparaci&oacute;n<br>
                    <b>Encargado: </b><label style="color: #0000FF"> <?php echo $_SESSION['apenom']; ?></label>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="ct_registro_mantenimiento.php?v=<?php echo $_GET['v']; ?>";
                                    function redireccionar() 
                                    {
                                        location.href=pagina;
                                    } 
                                    setTimeout ("redireccionar()", 2000);
                                </script>
                                <?php if (Funciones::decodeStrings($_GET['msj'],2) == 'ok') { ?>
                                <div class="form-group has-success">
                                    <label class="control-label" style="font-size: 20px" for="inputSuccess">Registrado con &eacute;xito</label>
                                </div>
                                <?php } else { ?>
                                <div class="form-group has-error">
                                    <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido ingresar el registro</label>
                                </div>
                                <?php } } ?>
                            </div>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/mantenimiento.php?event=registrar_mant">
                                <?php 
                                    $objDB = new Class_Db();
                                    $con = $objDB->selectManager()->connect();
                                    $select = $objDB->selectManager()->spSelect($con, 'sp_datos_vehiculo_v',  Funciones::decodeStrings($_GET['v'], 2));
                                    ?>
                                <div class="form-group">
                                    <label>Maquinaria: </label>                                    
                                    <input name="vehiculo" id="vehiculo" value="<?php echo $select[0]['nombre_c']; ?>" disabled class="form-control" >                                    
                                    <input type="hidden" name="id_vehiculo" id="id_trabvehiculo" value="<?php echo Funciones::encodeStrings($select[0]['id_vehiculo'],2); ?>" >
                                    <p class="help-block">Maquinaria.</p>
                                </div>
                                <div class="form-group">
                                    <label>Motivo: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="motivo" name="motivo" class="form-control" placeholder="Motivo" maxlength="200" required  autofocus>
                                    <p class="help-block">Motivo</p>
                                </div>
                                <div class="form-group">
                                    <label>Descripci&oacute;n: </label>
                                    <textarea id="descripcion" name="descripcion" class="form-control" placeholder="Descripci&oacute;n" maxlength="400" ></textarea>
                                    <p class="help-block">Descripci&oacute;n.</p>
                                </div>
                                <div class="form-group">
                                    <label>Lugar de aver&iacute;a: </label>
                                    <input id="lugar_av" name="lugar_av" class="form-control" placeholder="Lugar de aver&iacute;a" maxlength="200" >
                                    <p class="help-block">Lugar de aver&iacute;a</p>
                                </div>
                                <div class="form-group">
                                    <label>Lugar de mantenimiento: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="lugar_mant" name="lugar_mant" class="form-control" placeholder="Lugar de mantenimiento" maxlength="200" required>
                                    <p class="help-block">Lugar de mantenimiento</p>
                                </div>
                                <div class="form-group">
                                    <label>Hor&oacute;metro: <label style="color: #FF0000">(*)</label>  </label>
                                    <input id="horometro" name="horometro" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15">
                                    <p class="help-block">Hor&oacute;metro</p>
                                </div>
                                <div class="form-group">
                                    <label>Kilometraje: <label style="color: #FF0000">(*)</label>  </label>
                                    <input id="kilometraje" name="kilometraje" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" value="0" maxlength="15">
                                    <p class="help-block">Kilometraje</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha de ingreso: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="f_ingreso" name="f_ingreso" class="form-control desdeFech" placeholder="dd/mm/yyyy" maxlength="10" required >
                                    <p class="help-block">Fecha de ingreso</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha de salida: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="f_salida" name="f_salida"  class="form-control hastaFech" placeholder="dd/mm/yyyy" maxlength="10" required >
                                    <p class="help-block">Fecha de salida</p>
                                </div>
                                <div class="form-group">
                                    <label>Estado actual: <label style="color: #FF0000">(*)</label></label>
                                    <input id="estado" name="estado" class="form-control" placeholder="Estado actual" required>
                                    <p class="help-block">Estado actual.</p>
                                </div>
                                
                                <div class="form-group">
                                    <label>Costo: </label>
                                    <input id="costo" name="costo" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" value="0" maxlength="15">
                                    <p class="help-block">Costo</p>
                                </div>
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($select)) { ?>
                                <button type="submit" class="btn btn-default">Guardar</button>
                                <?php } ?>
                                <button type="reset" class="btn btn-default">Limpiar todo</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>