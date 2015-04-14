<?php include '00header.php'; ?>
<?php if(empty($_GET)) { ?>
<script >
    setTimeout (location.href='./', 0);
</script>
<?php } ?>
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
            <h1 class="page-header"> Editar Parte diario de maquinaria</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="ct_list_trabajo.php">
        <img src="../img/atras.png" title="Partes diarios"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de edici&oacute;n del uso de la maquinaria<br>                    
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <?php
                            $objDB = new Class_Db();
                            $con = $objDB->selectManager()->connect();
                            $result = $objDB->selectManager()->spSelect($con, "sp_listar_registro_parted_ID",  Funciones::decodeStrings($_GET['parte'], 2));
                            //echo $result[0]['estado_g'];
                            list($anio,$mes,$dia) = explode("-", $result[0]['fecha']);
                            $fecha = $dia."/".$mes."/".$anio;
                            ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/control_trabajo.php?event=editar_parte">
                                                                
                                <div class="form-group">
                                    <label>Veh&iacute;culo/maquinaria: </label> 
                                    <input type="hidden" name="id_controltrabajo" value="<?php echo $_GET['parte']; ?>" >
                                    <input name="vehiculo" id="vehiculo" value="<?php echo $result[0]['vehiculo']; ?>" disabled class="form-control" >                                    
                                    <p class="help-block">Veh&iacute;culo a cargo.</p>
                                </div>
                                
                                <div class="form-group">
                                    <label>Operador: <label style="color: #FF0000">(*)</label>  </label>                                    
                                    <input name="trabajador" id="trabajador" value="<?php echo $result[0]['operario']; ?>"  placeholder="Operador" class="form-control"  maxlength="200" autofocus required >                                    
                                    <p id="msg_operario" class="help-block">Operador.</p>
                                </div> 
                                
                                <div class="form-group">
                                    <label>Nro de Parte: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_parte" name="nro_parte" value="<?php echo $result[0]['nro_parte']; ?>" class="form-control" placeholder="000000" onkeypress="ValidaSoloNumeros();" maxlength="20" required >
                                    <p class="help-block">N&uacute;mero de parte</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha" name="fecha" value="<?php echo $fecha; ?>" class="form-control fechas" placeholder="dd/mm/yyyy" maxlength="10" required >
                                    <p class="help-block">Fecha</p>
                                </div>
                                <div class="form-group">
                                    <label>Lugar de trabajo: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="lugar_trabajo" name="lugar_trabajo" value="<?php echo $result[0]['lugar_trabajo']; ?>" class="form-control" placeholder="Lugar de trabajo" required>
                                    <p class="help-block">Lugar de trabajo.</p>
                                </div>
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        Consumo Galones
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label>Agua: </label>
                                            <input id="agua" name="agua" value="<?php echo $result[0]['agua']; ?>" class="form-control" placeholder="000000.00" value="0" onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Agua</p>
                                        </div>
                                        <div class="form-group">
                                            <label>Petr&oacute;leo: </label>
                                            <input id="petroleo" name="petroleo" value="<?php echo $result[0]['petroleo']; ?>" class="form-control" placeholder="000000.00" value="0" onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Petr&oacute;leo</p>
                                        </div>
                                        <div class="form-group">
                                            <label>Gasolina: </label>
                                            <input id="gasolina" name="gasolina" value="<?php echo $result[0]['gasolina']; ?>" class="form-control" placeholder="000000.00" value="0" onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Gasolina</p>
                                        </div>
                                        <div class="form-group">
                                            <label>AC.Motor: </label>
                                            <input id="ac_motor" name="ac_motor" value="<?php echo $result[0]['ac_motor']; ?>" class="form-control" placeholder="AC.Motor" value="0" onkeypress="return NumCheck(event,this);" >
                                            <p class="help-block">AC.Motor.</p>
                                        </div>
                                        <div class="form-group">
                                            <label>AC.Transmisi&oacute;n: </label>
                                            <input id="ac_transmision" name="ac_transmision" value="<?php echo $result[0]['ac_transmision']; ?>" class="form-control" placeholder="AC.Transmisi&oacute;n" onkeypress="return NumCheck(event,this);" value="0" >
                                            <p class="help-block">AC.Transmisi&oacute;n.</p>
                                        </div>
                                        <div class="form-group">
                                            <label>AC.Hidra&uacute;lico: </label>
                                            <input id="ac_hidraulico" name="ac_hidraulico" value="<?php echo $result[0]['ac_hidraulico']; ?>" class="form-control" placeholder="AC.Hidra&uacute;lico" onkeypress="return NumCheck(event,this);" value="0">
                                            <p class="help-block">AC.Hidra&uacute;lico.</p>
                                        </div>
                                        <div class="form-group">
                                            <label>Grasa (libras): </label>
                                            <input id="grasa" name="grasa" value="<?php echo $result[0]['grasa']; ?>" class="form-control" placeholder="Grasa" value="0" onkeypress="return NumCheck(event,this);" >
                                            <p class="help-block">Grasa.</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label>Labor realizada: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="tarea" name="tarea" value="<?php echo $result[0]['tarea']; ?>" class="form-control" placeholder="Labor realizada" required>
                                    <p class="help-block">Labor realizada.</p>
                                </div>
                                <div class="form-group">
                                    <label>Observaci&oacute;n: </label>
                                    <textarea id="observacion" name="observacion" class="form-control" placeholder="Registre alguna observaci&oacute;n" maxlength="400" ><?php echo $result[0]['observacion']; ?></textarea>
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
                                                <?php if ($result[0]['turno'] == 'M') { ?>
                                                <input type="radio" id="m" name="turno" value="M" checked> <label for="m">Ma&ntilde;ana</label><br>
                                                <?php }else { ?>
                                                <input type="radio" id="m" name="turno" value="M"> <label for="m">Ma&ntilde;ana</label><br>
                                                <?php } ?>                                                
                                            </label>
                                            <label class="radio-inline">
                                                <?php if ($result[0]['turno'] == 'T') { ?>
                                                <input type="radio" id="t" name="turno" value="T" checked> <label for="t">Tarde</label><br>
                                                <?php }else { ?>
                                                <input type="radio" id="t" name="turno" value="T"> <label for="t">Tarde</label><br>
                                                <?php } ?>
                                            </label>
                                            <label class="radio-inline">
                                                <?php if ($result[0]['turno'] == 'C') { ?>
                                                <input type="radio" id="c" name="turno" value="C" checked> <label for="c">Completo</label><br>
                                                <?php }else { ?>
                                                <input type="radio" id="c" name="turno" value="C"> <label for="c">Completo</label><br>
                                                <?php } ?>
                                            </label>                                                                        
                                        </div>
                                        <div class="form-group">
                                            <label>Hor&oacute;metro inicio: <label style="color: #FF0000">(*)</label> </label>
                                            <input id="horometro_ini" name="horometro_ini" value="<?php echo $result[0]['horometro_inicio']; ?>" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Hor&oacute;metro inicio.</p>
                                        </div>
                                        <div class="form-group">
                                            <label>Hor&oacute;metro final: <label style="color: #FF0000">(*)</label> </label>
                                            <input id="horometro_fin" name="horometro_fin" value="<?php echo $result[0]['horometro_fin']; ?>" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15">
                                            <p class="help-block">Hor&oacute;metro final.</p>
                                        </div>                                        
                                    </div>                                    
                                </div>
                                
                                <hr size="10" noshade="noshade" >
                                <div class="form-group">
                                    <label>Descuento Hrs.: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="descuento" name="descuento" value="<?php echo $result[0]['descuento']; ?>" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" value="0" maxlength="15">
                                    <p class="help-block">Descuento Hrs.</p>
                                </div>
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['parte'])) { ?>
                                <button id="btn_control" type="submit" class="btn btn-default">Guardar</button>
                                <?php }else { ?>
                                <script>
                                    setTimeout (location.href="./",0);
                                </script>
                                <?php } ?>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>