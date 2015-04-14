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
            if (formulario.trabajador.value.trim().length < 5)
            {
                formulario.trabajador.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.horometro_ini.value.trim().length < 2)
            {
                formulario.horometro_ini.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }            
            if (formulario.horometro_fin.value.trim().length < 2)
            {
                formulario.horometro_fin.focus();   
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
            <h1 class="page-header">Parte diario de maquinaria</h1>
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
                    Formulario de registro del uso de la maquinaria<br>
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
                                <?php } else { ?>
                                <div class="form-group has-error">
                                    <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido ingresar el registro</label>
                                </div>
                                <?php } } ?>
                            </div>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/control_trabajo.php?event=registrar_parte">
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
                                    <label>Nro Interno:  </label>
                                    <input id="nro_interno" name="nro_interno" class="form-control" value="0" onkeypress="ValidaSoloNumeros();" placeholder="00" maxlength="5" >
                                    <p class="help-block">N&uacute;mero interno</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de Parte: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_parte" name="nro_parte" class="form-control" placeholder="000000" onkeypress="ValidaSoloNumeros();" maxlength="20" required >
                                    <p id="nro_parteMsg" class="help-block">N&uacute;mero de parte</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha" name="fecha" class="form-control fechas" placeholder="dd/mm/yyyy" maxlength="10" required >
                                    <p class="help-block">Fecha</p>
                                </div>
                                <div class="form-group">
                                    <label>Lugar de trabajo: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="lugar_trabajo" name="lugar_trabajo" class="form-control" placeholder="Lugar de trabajo" required>
                                    <p class="help-block">Lugar de trabajo.</p>
                                </div>
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        Consumo Galones
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label>Agua: </label>
                                            <input id="agua" name="agua" class="form-control" placeholder="000000.00" value="0" onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Agua</p>
                                        </div>
                                        <div class="form-group">
                                            <label>Petr&oacute;leo: </label>
                                            <input id="petroleo" name="petroleo" class="form-control" placeholder="000000.00" value="0" onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Petr&oacute;leo</p>
                                        </div>
                                        <div class="form-group">
                                            <label>Gasolina: </label>
                                            <input id="gasolina" name="gasolina" class="form-control" placeholder="000000.00" value="0" onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Gasolina</p>
                                        </div>
                                        <div class="form-group">
                                            <label>AC.Motor: </label>
                                            <input id="ac_motor" name="ac_motor" class="form-control" placeholder="AC.Motor" value="0" onkeypress="return NumCheck(event,this);" >
                                            <p class="help-block">AC.Motor.</p>
                                        </div>
                                        <div class="form-group">
                                            <label>AC.Transmisi&oacute;n: </label>
                                            <input id="ac_transmision" name="ac_transmision" class="form-control" placeholder="AC.Transmisi&oacute;n" onkeypress="return NumCheck(event,this);" value="0" >
                                            <p class="help-block">AC.Transmisi&oacute;n.</p>
                                        </div>
                                        <div class="form-group">
                                            <label>AC.Hidra&uacute;lico: </label>
                                            <input id="ac_hidraulico" name="ac_hidraulico" class="form-control" placeholder="AC.Hidra&uacute;lico" onkeypress="return NumCheck(event,this);" value="0">
                                            <p class="help-block">AC.Hidra&uacute;lico.</p>
                                        </div>
                                        <div class="form-group">
                                            <label>Grasa (libras): </label>
                                            <input id="grasa" name="grasa" class="form-control" placeholder="Grasa" value="0" onkeypress="return NumCheck(event,this);" >
                                            <p class="help-block">Grasa.</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label>Labor realizada: <label style="color: #FF0000">(*)</label> </label>
                                    <textarea id="tarea" name="tarea" class="form-control" placeholder="Labor realizada" required></textarea>
                                    <p class="help-block">Labor realizada.</p>
                                </div>
                                <div class="form-group">
                                    <label>Observaci&oacute;n: </label>
                                    <textarea id="observacion" name="observacion" class="form-control" placeholder="Registre alguna observaci&oacute;n" maxlength="400" ></textarea>
                                    <p class="help-block">Observaci&oacute;n.</p>
                                </div>
                                <hr size="10" noshade="noshade" >
                                
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <label>Turno: <label style="color: #FF0000">(*)</label> </label>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label class="radio-inline">
                                                <input type="radio" id="m" name="turno" value="M" checked> <label for="m">Ma&ntilde;ana</label><br>
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" id="t" name="turno" value="T"> <label for="t">Tarde</label><br>
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" id="c" name="turno" value="C"> <label for="c">Completo</label><br>
                                            </label>                                                                        
                                        </div>
                                        <div class="form-group">
                                            <label>Hor&oacute;metro inicio: <label style="color: #FF0000">(*)</label> </label>
                                            <input id="horometro_ini" name="horometro_ini" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Hor&oacute;metro inicio.</p>
                                        </div>
                                        <div class="form-group">
                                            <label>Hor&oacute;metro final: <label style="color: #FF0000">(*)</label> </label>
                                            <input id="horometro_fin" name="horometro_fin" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Hor&oacute;metro final.</p>
                                        </div>                                        
                                    </div>                                    
                                </div>
                                
                                <hr size="10" noshade="noshade" >
                                <div class="form-group">
                                    <label>Descuento Hrs.: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="descuento" name="descuento" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" value="0" maxlength="15">
                                    <p class="help-block">Descuento Hrs.</p>
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