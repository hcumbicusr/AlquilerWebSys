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
            key = e.keyCode ? e.keyCode : e.which
            if (key == 8) return true
            if (key > 47 && key < 58) {
              if (field.value == "") return true
              regexp = /.[0-9]{10}$/
              return !(regexp.test(field.value))
            }
            if (key == 46) {
              if (field.value == "") return false
              regexp = /^[0-9]+$/
              return regexp.test(field.value)
            }
            return false
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
            <h1 class="page-header"> Edici&oacute;n de comprobante por compra de combustible</h1>
        </div>
        
        <!-- /.col-lg-12 -->
    </div>
    <a href="ct_list_comprobantes.php">
        <img src="../img/atras.png" title="Comprobantes de compra de combustible"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de Edici&oacute;n del comprobante por la compra de combustible<br>                    
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                           <?php
                            $objDB = new Class_Db();
                            $con = $objDB->selectManager()->connect();
                            $result = $objDB->selectManager()->spSelect($con, "sp_listar_comprobante_ID",  Funciones::decodeStrings($_GET['comp'], 2));
                            //echo $result[0]['estado_g'];
                            list($anio,$mes,$dia) = explode("-", $result[0]['fecha']);
                            $fecha = $dia."/".$mes."/".$anio;
                            ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/abastecimiento.php?event=editar_comp">
                                
                                <div class="form-group">
                                    <label>Nro de comprobante: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="hidden" name="id_abastecimiento" required value="<?php echo $_GET['comp']; ?>" >
                                    <input id="nro_comprobante" name="nro_comprobante" value="<?php echo $result[0]['nro_comprobante']; ?>" class="form-control" placeholder="000000" maxlength="20" required autofocus >
                                    <p class="help-block">N&uacute;mero de comprobante.</p>
                                </div>
                                <div class="form-group">
                                    <label>Tipo de Comprobante: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipocomprobante';
                                    $table = 'tipocomprobante';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class, true, $result[0]['id_tipocomprobante']);
                                    ?>      
                                    <p class="help-block">Tipo de comprobante.</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de Operaci&oacute;n/Cheque: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_operacion" name="nro_operacion" value="<?php echo $result[0]['nro_operacion_ch']; ?>" class="form-control" placeholder="000000" maxlength="20" required autofocus >
                                    <p class="help-block">Nro de Operaci&oacute;n/Cheque.</p>
                                </div>                                 
                                <div class="form-group">
                                    <label>Cantidad de Combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="cant_comb" name="cant_comb" value="<?php echo $result[0]['cantidad']; ?>" class="form-control" placeholder="000000.00 GLN" required onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Cantidad de combustible.</p>
                                </div>
                                <div class="form-group">
                                    <label>Tipo de Combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipocombustible';
                                    $table = 'tipocombustible';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class, true, $result[0]['id_tipocombustible']);
                                    ?>      
                                    <p class="help-block">Tipo de combustible.</p>
                                </div>
                                <div class="form-group">
                                    <label>Precio Unitario: S/. <label style="color: #FF0000">(*)</label> </label>
                                    <input id="precio_u" name="precio_u" value="<?php echo $result[0]['precio_u']; ?>" class="form-control" placeholder="S/. 000000.00" required onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Precio Unitario.</p>
                                </div>
                                <div class="form-group">
                                    <label>Abastecedor: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="abastecedor" name="abastecedor" value="<?php echo $result[0]['abastecedor']; ?>" class="form-control" placeholder="Abastecedor"  maxlength="200" required >
                                    <p class="help-block">Abastecedor.</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha" name="fecha" value="<?php echo $fecha; ?>" class="form-control fechas" placeholder="dd/mm/yyyy" required maxlength="10">
                                    <p class="help-block">Fecha.</p>
                                </div>                                                               
                                
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['comp'])) { ?>
                                <button type="submit" class="btn btn-default">Guardar</button>
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