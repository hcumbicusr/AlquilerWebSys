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
            
            if (formulario.nro_guia.value.trim().length < 3)
            {
                formulario.nro_guia.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.nro_vale.value.trim().length < 3)
            {
                formulario.nro_vale.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.nro_surtidor.value.trim().length < 2)
            {
                formulario.nro_surtidor.focus();   
                alert('Ingrese datos válidos: 2 dígitos'); 
                return false; //devolvemos el foco
            }
            if (formulario.tarea.value.trim().length < 3)
            {
                formulario.tarea.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.trabajador.value.trim().length < 5)
            {
                formulario.trabajador.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.cant_comb.value.trim().length < 1)
            {
                formulario.cant_comb.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.horometro.value.trim().length < 3)
            {
                formulario.horometro.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.fecha.value.trim().length != 10)
            {
                formulario.fecha.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Control de combustible diario</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="ct_list_vehiculos_asig.php?cliente=<?php echo $_GET['cliente']; ?>">
        <img src="../img/atras.png" title="Ve&iacute;culos contratados"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro del control de combustible<br>
                    <b>Encargado: </b><label style="color: #0000FF"> <?php echo $_SESSION['apenom']; ?></label>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="ct_list_vehiculos_asig.php?cliente=<?php echo $_GET['cliente']; ?>";
                                    function redireccionar() 
                                    {
                                        location.href=pagina;
                                    } 
                                    setTimeout ("redireccionar()", 3000);
                                </script>
                                <?php if (Funciones::decodeStrings($_GET['msj'],2) == 'ok') { ?>
                                <div class="form-group has-success">
                                    <label class="control-label" style="font-size: 20px" for="inputSuccess">Registrado con &eacute;xito</label>
                                </div>
                                <?php } else if(Funciones::decodeStrings($_GET['msj'],2) == 'no') { ?>
                                <div class="form-group has-error">
                                    <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido ingresar el registro</label>
                                </div>
                                <?php } else if(Funciones::decodeStrings($_GET['msj'],2) == 'PARTE') { ?>
                                <div class="form-group has-error">
                                    <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido ingresar el registro. El parte Diario para este vale aún no ha sido registrado.</label>
                                </div>
                                <?php } else { ?>                                
                                <div class="form-group has-error">
                                    <script>
                                        alert('No se ha podido registrar. \n\
                                                La cantidad de combustible ingresado supera el stock que se posee para esta guía. \n\
                                                Excede en: [<?php echo Funciones::decodeStrings($_GET['msj'],2); ?>  GLN]');
                                    </script>
                                </div>                                
                                <?php } } ?>
                            </div>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/consumo.php?event=registrar_consumo">
                                    <?php 
                                    $objDB = new Class_Db();
                                    $con = $objDB->selectManager()->connect();
                                    $select = $objDB->selectManager()->spSelect($con, 'sp_datos_vehiculo',  Funciones::decodeStrings($_GET['v'], 2));
                                    ?>
                                
                                <div class="form-group">
                                    <label>Maquinaria: </label>                                    
                                    <input name="vehiculo" id="vehiculo" value="<?php echo $select[0]['nombre_c']; ?>" disabled class="form-control" >
                                    <input type="hidden" name="cliente" id="cliente" value="<?php echo $_GET['cliente']; ?>" >
                                    <input type="hidden" name="id_detallealquiler" id="id_detallealquiler" value="<?php echo $_GET['v']; ?>" >
                                    <p class="help-block">Maquinaria a cargo.</p>
                                </div> 
                                
                                <div class="form-group">
                                    <label>Operador: <label style="color: #FF0000">(*)</label>  </label>                                    
                                    <input name="trabajador" id="trabajador"  placeholder="Operador" class="form-control"  maxlength="200" autofocus required >                                    
                                    <p id="msg_operario" class="help-block">Operador.</p>
                                </div>
                                                               
                                <div class="form-group">
                                    <label>Nro de Gu&iacute;a: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_guia" name="nro_guia" class="form-control" placeholder="000000" maxlength="20" required  >
                                    <p id="msg_nro_guia" class="help-block">N&uacute;mero de Gu&iacute;a.</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de Vale: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_vale" name="nro_vale" class="form-control" placeholder="000000"  maxlength="20" required >
                                    <p ID="nro_valeMsg" class="help-block">N&uacute;mero de Vale.</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de Surtidor: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_surtidor" name="nro_surtidor" class="form-control" placeholder="000000"  maxlength="20" required >
                                    <p class="help-block">N&uacute;mero de surtidor.</p>
                                </div>                                
                                <div class="form-group">
                                    <label>Cantidad de Combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="cant_comb" name="cant_comb" class="form-control" placeholder="000000.00 GLN" required onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Cantidad de combustible.</p>
                                </div>                                
                                <div class="form-group">
                                    <label>Hor&oacute;metro: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="horometro" name="horometro" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Hor&oacute;metro.</p>
                                </div>
                                <div class="form-group">
                                    <label>Kilometraje: </label>
                                    <input id="kilometraje" name="kilometraje" class="form-control" placeholder="000000.00" value="0" onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Kilometraje.</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha" name="fecha" class="form-control fechas" placeholder="dd/mm/yyyy" required maxlength="10">
                                    <p class="help-block">Fecha.</p>
                                </div>
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($select)) { ?>
                                <button id="btn_control" type="submit" class="btn btn-default">Guardar</button>
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