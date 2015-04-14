<?php include '00header.php'; ?>
<?php if(empty($_GET)) { ?>
<script >
    setTimeout (location.href='./', 0);
</script>
<?php } ?>
<script>
           
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
           
            if (formulario.nombre.value.trim().length < 5)
            {
                formulario.nombre.focus();   
                alert('Ingrese un nombre válido'); 
                return false; //devolvemos el foco
            } 
            if (formulario.rendimiento.value.trim().length < 2)
            {
                formulario.rendimiento.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            }
            if (formulario.modelo.value.trim().length < 3)
            {
                formulario.modelo.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            } 
            if (formulario.serie.value.trim().length < 3)
            {
                formulario.serie.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            } 
            if (formulario.motor.value.trim().length < 3)
            {
                formulario.motor.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            } 
            if (formulario.color.value.trim().length < 3)
            {
                formulario.color.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            }
            if (formulario.placa.value.trim().length < 3)
            {
                formulario.placa.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            }
            if (formulario.horometro.value.trim().length < 1)
            {
                formulario.horometro.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            }
            if (formulario.kilometraje.value.trim().length < 1)
            {
                formulario.kilometraje.focus();   
                alert('Ingrese datos validos'); 
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
            <h1 class="page-header"> Editar datos de maquinaria</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_vehiculos.php">
        <img src="../img/atras.png" title="Vechiculos"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de edici&oacute;n de maquinaria
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_list_vehiculos.php";
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
                            $result = $objDB->selectManager()->spSelect($con, "sp_listar_vehiculo_ID",  Funciones::decodeStrings($_GET['vh'], 2));
                            //echo $result[0]['estado_g'];
                            ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/vehiculo.php?event=editar">                                   
                                <div class="form-group">
                                    <label>Nombre: <label style="color: #FF0000">(*)</label></label>
                                    <input type="hidden" name="id_vehiculo" value="<?php echo $_GET['vh']; ?>" required >
                                    <input name="nombre" id="nombre" class="form-control" value="<?php echo $result[0]['nombre']; ?>"  placeholder="Nombre de maquinaria" required autofocus >
                                    <p class="help-block">Nombre</p>
                                </div>
                                <div class="form-group">
                                    <label>Marca: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_marca';
                                    $table = 'marca';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class, true, $result[0]['id_marca']);
                                    ?>                                    
                                </div>
                                <div class="form-group">
                                    <label>Tipo de maquinaria: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipovehiculo';
                                    $table = 'tipovehiculo';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class, true, $result[0]['id_tipovehiculo']);
                                    ?>                                    
                                </div>
                                <div class="form-group">
                                    <label>Rendimiento de F&aacute;brica: <label style="color: #FF0000">(*)</label></label>
                                    <input name="rendimiento" id="rendimiento" value="<?php echo $result[0]['rendimiento']; ?>" class="form-control"  placeholder="Rendimiento" required maxlength="10" >
                                    <p class="help-block">Rendimiento</p>
                                </div>
                                <div class="form-group">
                                    <label>Modelo: <label style="color: #FF0000">(*)</label></label>
                                    <input name="modelo" id="modelo" value="<?php echo $result[0]['modelo']; ?>" class="form-control"  placeholder="Modelo" required >
                                    <p class="help-block">Modelo</p>
                                </div>
                                 <div class="form-group">
                                    <label>Serie: <label style="color: #FF0000">(*)</label></label>
                                    <input name="serie" id="serie"  value="<?php echo $result[0]['serie']; ?>" class="form-control"  placeholder="Serie" required >
                                    <p class="help-block">Serie</p>
                                </div>
                                 <div class="form-group">
                                    <label>Motor: <label style="color: #FF0000">(*)</label></label>
                                    <input name="motor" id="motor"  value="<?php echo $result[0]['motor']; ?>" class="form-control"  placeholder="Motor" required >
                                    <p class="help-block">Motor</p>
                                </div>
                                 <div class="form-group">
                                    <label>Color: <label style="color: #FF0000">(*)</label></label>
                                    <input name="color" id="color" value="<?php echo $result[0]['color']; ?>" class="form-control"  placeholder="Color" required >
                                    <p class="help-block">Color</p>
                                </div>
                                 <div class="form-group">
                                    <label>Placa: <label style="color: #FF0000">(*)</label></label>
                                    <input name="placa" id="placa"  value="<?php echo $result[0]['placa']; ?>" class="form-control"  placeholder="Placa" required >
                                    <p class="help-block">Placa</p>
                                </div>
                                 <div class="form-group">
                                    <label>Precio Hora: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="precio_h" name="precio_h" value="<?php echo $result[0]['precio_hora']; ?>" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <p class="help-block">Precio Hora.</p>
                                </div>
                                <div class="form-group">
                                    <label>Horometro: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="horometro" name="horometro" value="<?php echo $result[0]['horometro_ac']; ?>" class="form-control" placeholder="000000.00" required value="0" onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <p class="help-block">Horometro.</p>
                                </div>
                                <div class="form-group">
                                    <label>Kilometraje: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="kilometraje" name="kilometraje" value="<?php echo $result[0]['kilometraje_ac']; ?>" class="form-control" placeholder="000000.00" required value="0" onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <p class="help-block">Kilometraje.</p>
                                </div>
                                
                               <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['vh'])) { ?>
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