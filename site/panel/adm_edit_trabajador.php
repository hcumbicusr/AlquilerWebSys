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
            if (formulario.apellidos.value.trim().length < 5)
            {
                formulario.apellidos.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.nombres.value.trim().length < 3)
            {
                formulario.nombres.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.fecha_nac.value.trim().length != 10)
            {
                formulario.fecha_nac.focus();   
                alert('Escriba la fecha completa con formato: dd/mm/yyyy'); 
                return false; //devolvemos el foco
            }
            if (formulario.dni.value.trim().length < 8)
            {
                formulario.dni.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }                        
            
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Modificaci&oacute;n de datos de trabajador</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_trabajadores.php">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de modificaci&oacute;n de trabajador
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_list_trabajadores.php";
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
                            $result = $objDB->selectManager()->spSelect($con, "sp_listar_trabajador_ID",  Funciones::decodeStrings($_GET['trab'], 2));
                            //echo $result[0]['estado_g'];
                            //die();
                            list($anio,$mes,$dia) = explode("-", $result[0]['fecha_nac']);
                            $fecha = $dia."/".$mes."/".$anio;
                            ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/trabajador.php?event=editar">
                                
                                <div class="form-group">
                                    <label>Apellidos: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="hidden" name="id_trabajador" value="<?php echo $_GET['trab']; ?>" >
                                    <input id="apellidos" name="apellidos" class="form-control" value="<?php echo $result[0]['apellidos']; ?>" placeholder="Apellidos del trabajador"  maxlength="50" required autofocus >
                                    <p class="help-block">Apellidos</p>
                                </div>
                                <div class="form-group">
                                    <label>Nombres: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nombres" name="nombres" class="form-control" value="<?php echo $result[0]['nombres']; ?>" placeholder="Nombre(s) del trabajador"  maxlength="50"  required>
                                    <p class="help-block">Nombres.</p>
                                </div>
                                <div class="form-group">
                                    <label>Tipo de TRABAJADOR: <label style="color: #FF0000">(*)</label> </label>                                     
                                    <?php 
                                    $name = 'id_tipotrabajador';
                                    $table = 'tipotrabajador';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class, true, $result[0]['id_tipotrabajador']);
                                    ?>                                                                    
                                    <p class="help-block">Tipo de trabajador.</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha de nacimiento: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha_nac" value="<?php echo $fecha; ?>" name="fecha_nac" class="form-control fechas" placeholder="dd/mm/yyyy" maxlength="10" required>
                                    <p class="help-block">Fecha de nacimiento.</p>
                                </div>
                                <div class="form-group">
                                    <label>DNI: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="dni" name="dni" class="form-control" value="<?php echo $result[0]['dni']; ?>" placeholder="Nro DNI" onkeypress="ValidaSoloNumeros();" maxlength="8" required>
                                    <p class="help-block">DNI.</p>
                                </div>
                                <div class="form-group">
                                    <label>RUC: </label>
                                    <input id="ruc" name="ruc" class="form-control" value="<?php echo $result[0]['ruc']; ?>" onkeypress="ValidaSoloNumeros();" placeholder=" Nro RUC" maxlength="11">
                                    <p class="help-block">RUC.</p>
                                </div>
                                <div class="form-group">
                                    <label>Tel&eacute;fono: </label>
                                    <input id="telefono" name="telefono" class="form-control"  value="<?php echo $result[0]['telefono']; ?>" maxlength="15"  placeholder="Nro tel&eacute;fono">
                                    <p class="help-block">Tel&eacute;fono.</p>
                                </div>    
                                <div class="form-group">
                                    <label>Nro. Licencia de conducir: </label>
                                    <input id="nro_licencia" name="nro_licencia"  value="<?php echo $result[0]['nro_licencia']; ?>" class="form-control" maxlength="20"  placeholder="Nro Licencia">
                                    <p class="help-block">Nro. Licencia.</p>
                                </div> 
                                <div class="form-group">
                                    <label>Tipo de USUARIO <b style="color: #FF0000">(Para acceso al sistema)</b>: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipousuario';
                                    $table = 'tipousuario';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class, true, $result[0]['id_tipousuario']);
                                    ?>
                                    <p class="help-block">Tipo de usuario (Para acceso al sistema).<sub style="color: #0000FF">[**OPERARIO] Actualmente No tiene acceso al sistema</sub></p>
                                </div>
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                    
                                <?php if (!empty($_GET['trab'])) { ?>
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