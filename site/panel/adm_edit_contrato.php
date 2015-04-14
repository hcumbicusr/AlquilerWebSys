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
        
        function txNombres() {
         if ((event.keyCode != 32) && (event.keyCode < 65) || (event.keyCode > 90) && (event.keyCode < 97) || (event.keyCode > 122))
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
           
            if (formulario.f_inicio.value.trim().length != 10)
            {
                formulario.f_inicio.focus();   
                alert('Escriba la fecha completa con formato: dd/mm/yyyy'); 
                return false; //devolvemos el foco
            }
            if (formulario.f_fin.value.trim().length != 10)
            {
                formulario.f_fin.focus();   
                alert('Escriba la fecha completa con formato: dd/mm/yyyy'); 
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
            <h1 class="page-header"> Editar datos de contrato</h1>
        </div>
        
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_contratos.php">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro de contrato
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_list_contratos.php";
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
                            <?php
                            $objDB = new Class_Db();
                            $con = $objDB->selectManager()->connect();
                            $result = $objDB->selectManager()->spSelect($con, "sp_listar_contrato_ID",  Funciones::decodeStrings($_GET['contrato'], 2));
                            //echo $result[0]['estado_g'];
                            list($anio,$mes,$dia) = explode("-", $result[0]['f_inicio']);
                            $fecha_i = $dia."/".$mes."/".$anio;
                            list($anio,$mes,$dia) = explode("-", $result[0]['f_fin']);
                            $fecha_f = $dia."/".$mes."/".$anio;
                            ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/contrato.php?event=editar">                                                                
                                
                                <div class="form-group">
                                    <label>Cliente: </label>
                                    <input id="cliente" name="cliente" class="form-control" placeholder="Nombre de Cliente" onkeypress="txNombres();" maxlength="100" required value="<?php echo $result[0]['cliente']; ?>" disabled >
                                    <p class="help-block">Cliente</p>
                                    <input type="hidden" name="id_contrato" id="id_cliente" value="<?php echo $_GET['contrato']; ?>" >
                                </div>
                                <div class="form-group">
                                    <label>Obra: </label>
                                    <input id="obra" name="obra" class="form-control" placeholder="Nombre de Obra" onkeypress="txNombres();" maxlength="100" required value="<?php echo $result[0]['obra']; ?>" disabled >
                                    <p class="help-block">Obra.</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha de inicio: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="f_inicio" name="f_inicio" value="<?php echo $fecha_i; ?>" class="form-control fechas_v" placeholder="dd/mm/yyyy" maxlength="10" required autofocus>
                                    <p class="help-block">Fecha de inicio.</p>
                                </div>
                                <div class="form-group">
                                    <!--label>Fecha de finalizaci&oacute;n: <label style="color: #FF0000">(*)</label> </label-->
                                    <input type="hidden" id="f_fin" name="f_fin" value="<?php echo $fecha_f; ?>" class="form-control fechas_v" placeholder="dd/mm/yyyy" maxlength="10" required>
                                    <!--p class="help-block">Fecha de finalizaci&oacute;n.</p-->
                                </div>
                                <div class="form-group">
                                    <!--label>Presupuesto: <label style="color: #FF0000">(*)</label> </label-->
                                    <input type="hidden" id="presupuesto" name="presupuesto" value="<?php echo $result[0]['presupuesto']; ?>" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <!--p class="help-block">Presupuesto.</p-->
                                </div>
                                <div class="form-group">
                                    <label>Descripci&oacute;n:</label>
                                    <textarea name="detalle" id="detalle" class="form-control" rows="5" placeholder="Descripci&oacute;n" ><?php echo $result[0]['detalle']; ?></textarea>
                                </div>
                               <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['contrato'])) { ?>
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