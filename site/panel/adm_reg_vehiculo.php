<?php include '00header.php'; ?>

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
                alert('Ingrese un nombre válido'); 
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
        <div class="col-lg-12">
            <h1 class="page-header">Registro de maquinaria</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro de maquinaria
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_reg_vehiculo.php";
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
                                  action="./../../app/controllers/vehiculo.php?event=registrar">                                   
                                <div class="form-group">
                                    <label>Nombre: <label style="color: #FF0000">(*)</label></label>
                                    <input name="nombre" id="nombre" class="form-control"  placeholder="Nombre de maquinaria" required autofocus maxlength="50" >
                                    <p class="help-block">Nombre</p>
                                </div>
                                <div class="form-group">
                                    <label>Marca: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_marca';
                                    $table = 'marca';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class);
                                    ?>                                    
                                </div>
                                <div class="form-group">
                                    <label>Tipo de maquinaria: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipovehiculo';
                                    $table = 'tipovehiculo';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class);
                                    ?>                                    
                                </div>
                                <div class="form-group">
                                    <label>Rendimiento de F&aacute;brica: <label style="color: #FF0000">(*)</label></label>
                                    <input name="rendimiento" id="rendimiento" class="form-control"  placeholder="00.00" onkeypress="return NumCheck(event,this);" required maxlength="10" >
                                    <p class="help-block">Rendimiento</p>
                                </div>
                                <div class="form-group">
                                    <label>Modelo: <label style="color: #FF0000">(*)</label></label>
                                    <input name="modelo" id="modelo" class="form-control"  placeholder="Modelo" required maxlength="20" >
                                    <p class="help-block">Modelo</p>
                                </div>
                                 <div class="form-group">
                                    <label>Serie: <label style="color: #FF0000">(*)</label></label>
                                    <input name="serie" id="serie" class="form-control"  placeholder="Serie" required maxlength="20" >
                                    <p class="help-block">Serie</p>
                                </div>
                                 <div class="form-group">
                                    <label>Motor: <label style="color: #FF0000">(*)</label></label>
                                    <input name="motor" id="motor" class="form-control"  placeholder="Motor" required maxlength="30" >
                                    <p class="help-block">Motor</p>
                                </div>
                                 <div class="form-group">
                                    <label>Color: <label style="color: #FF0000">(*)</label></label>
                                    <input name="color" id="color" class="form-control"  placeholder="Color" required maxlength="20" >
                                    <p class="help-block">Color</p>
                                </div>
                                 <div class="form-group">
                                    <label>Placa: <label style="color: #FF0000">(*)</label></label>
                                    <input name="placa" id="placa" class="form-control"  placeholder="Placa" required maxlength="20" >
                                    <p class="help-block">Placa</p>
                                </div>
                                 <div class="form-group">
                                    <label>Precio Hora: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="precio_h" name="precio_h" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <p class="help-block">Precio Hora.</p>
                                </div>
                                <div class="form-group">
                                    <label>Horometro: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="horometro" name="horometro" class="form-control" placeholder="000000.00" required value="0" onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <p class="help-block">Horometro.</p>
                                </div>
                                <div class="form-group">
                                    <label>Kilometraje: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="kilometraje" name="kilometraje" class="form-control" placeholder="000000.00" required value="0" onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <p class="help-block">Kilometraje.</p>
                                </div>
                                
                               <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <button type="submit" class="btn btn-default">Guardar</button>
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