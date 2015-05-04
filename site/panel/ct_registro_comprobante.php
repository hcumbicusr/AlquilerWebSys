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
            
            if (formulario.nro_comprobante.value.trim().length < 2)
            {
                formulario.nro_comprobante.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.nro_operacion.value.trim().length < 2)
            {
                formulario.nro_operacion.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }                    
            if (formulario.cant_comb.value.trim().length < 1)
            {
                formulario.cant_comb.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }  
            if (formulario.precio_u.value.trim().length < 1)
            {
                formulario.precio_u.focus();   
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
            <h1 class="page-header">Registro de comprobante por compra de combustible</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro del comprobante por la compra de combustible<br>
                    <b>Encargado: </b><label style="color: #0000FF"> <?php echo $_SESSION['apenom']; ?></label>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="ct_registro_comprobante.php";
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
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/abastecimiento.php?event=registrar_comp">
                                
                                <div class="form-group">
                                    <label>Nro de comprobante: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_comprobanteReg" name="nro_comprobanteReg" value="001-" class="form-control" placeholder="000000" maxlength="20" required >
                                    <p id="nro_comprobanteRegMsg" class="help-block">N&uacute;mero de comprobante.</p>
                                </div>
                                <div class="form-group">
                                    <label>Tipo de Comprobante: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipocomprobante';
                                    $table = 'tipocomprobante';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class);
                                    ?>      
                                    <p class="help-block">Tipo de comprobante.</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de Operaci&oacute;n/Cheque: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_operacion" name="nro_operacion" class="form-control" placeholder="000000" maxlength="20" required  >
                                    <p class="help-block">Nro de Operaci&oacute;n/Cheque.</p>
                                </div>                                 
                                <div class="form-group">
                                    <label>Cantidad de Combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="cant_comb" name="cant_comb" class="form-control" placeholder="000000.00 GLN" required onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Cantidad de combustible.</p>
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
                                    <label>Precio Unitario (Con I.G.V.): S/. <label style="color: #FF0000">(*)</label> </label>
                                    <input id="precio_u" name="precio_u" class="form-control" placeholder="S/. 000000.00" required onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Precio Unitario.</p>
                                </div>
                                <div class="form-group">
                                    <label>Abastecedor: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="abastecedor" name="abastecedor" class="form-control" placeholder="Ejm.: Grifo xyz "  maxlength="200" required >
                                    <p class="help-block">Abastecedor.</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha" name="fecha" class="form-control fechas" placeholder="dd/mm/yyyy" required maxlength="10">
                                    <p class="help-block">Fecha.</p>
                                </div>                                                               
                                
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                
                                <button id="btnComprobReg" type="submit" class="btn btn-default">Guardar</button>
                                
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