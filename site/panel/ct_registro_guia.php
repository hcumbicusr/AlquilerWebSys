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
            
            if (formulario.nro_guiaReg.value.trim().length < 3)
            {
                formulario.nro_guiaReg.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.nro_licencia.value.trim().length < 2)
            {
                formulario.nro_licencia.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.nro_placa.value.trim().length < 3)
            {
                formulario.nro_placa.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }            
            if (formulario.cant_comb.value.trim().length < 1)
            {
                formulario.cant_comb.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }            
            if (formulario.fecha.value.trim().length != 10)
            {
                formulario.fecha.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.abastecedor.value.trim().length < 4)
            {
                formulario.abastecedor.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Registro de gu&iacute;as de compra de combustible</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro de gu&iacute;a de la compra de combustible<br>
                    <b>Encargado: </b><label style="color: #0000FF"> <?php echo $_SESSION['apenom']; ?></label>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="ct_registro_guia.php";
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
                                <?php } 
                                
                                } ?>
                            </div>
                            <form id="frmRegGuia" role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/detalle_abastecimiento.php?event=registrar_guia">
                                
                                <div class="form-group">
                                    <label>Nro de Gu&iacute;a: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_guiaReg" name="nro_guiaReg" value="001-" class="form-control" placeholder="000000" maxlength="20" required >
                                    <p id="msg_nro_guiaReg" class="help-block">N&uacute;mero de Gu&iacute;a.</p>
                                </div>
                                <div class="form-group">
                                    <label>Tipo de Combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipocombustible';
                                    $table = 'tipocombustible';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class);
                                    ?>      
                                    <p class="help-block">Tipo de combustible.</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de Placa de veh&iacute;culo SURTIDOR: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_placa" name="nro_placa" class="form-control" placeholder="Nro Placa"  maxlength="20" required >
                                    <p id="nro_placaMsg" class="help-block">El veh&iacute;culo al cual pertenece este n&uacute;mero de placa 
                                        debe estar registrado como <b>Tipo de maquinaria</b> SURTIDOR, de lo contrario no se podr&aacute; realizar 
                                        el registro de la gu&iacute;a.</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de licencia de conducir: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_licencia" name="nro_licencia" class="form-control" placeholder="Nro Licencia"  maxlength="20" required >
                                    <p id="nro_licenciaMsg" class="help-block">Nro de licencia de conducir.</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha" name="fecha" class="form-control fechas" placeholder="dd/mm/yyyy"  required maxlength="10">
                                    <p class="help-block">Fecha.</p>
                                </div>                              
                                <div class="form-group">
                                    <label>Cantidad de Combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="cant_comb" name="cant_comb" class="form-control" placeholder="000000.00 GLN" required onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Cantidad de combustible.</p>
                                </div>
                                <div class="form-group">
                                    <label>Abastecedor: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="abastecedor" name="abastecedor" class="form-control" placeholder="Ejm.: Grifo xyz "  maxlength="200" required >
                                    <p class="help-block">Abastecedor.</p>
                                </div>
                                <div class="form-group">
                                    <label>Vale de combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="vale_combustible" name="vale_combustible" class="form-control" placeholder="000000" maxlength="10" required >
                                    <p id="msg_valeCombustible_reg" class="help-block">Vale de combustible.</p>
                                </div>
                                
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                
                                <button id="btnRegGuia" type="submit" class="btn btn-default">Guardar</button>
                                
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