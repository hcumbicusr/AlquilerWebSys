<?php include '00header.php'; ?>

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
           
            if (formulario.nombre.value.trim().length < 5)
            {
                formulario.nombre.focus();   
                alert('Ingrese un nombre válido'); 
                return false; //devolvemos el foco
            } 
           
            if (formulario.serie.value.trim().length < 3)
            {
                formulario.serie.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            }
            if (formulario.descripcion.value.trim().length < 3)
            {
                formulario.descripcion.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            }
            if (formulario.precio_alq.value.trim() == 0)
            {
                formulario.precio_alq.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            }
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Registro de art&iacute;culos</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro de art&iacute;culos
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_reg_articulos.php";
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
                                  action="./../../app/controllers/articulo.php?event=registrar">                                   
                                <div class="form-group">
                                    <label>Nombre: <label style="color: #FF0000">(*)</label></label>
                                    <input name="nombre" id="nombre" class="form-control"  placeholder="Nombre del articulo" required autofocus >
                                    <p class="help-block">Nombre</p>
                                </div>
                                <div class="form-group">
                                    <label>Serie: <label style="color: #FF0000">(*)</label></label>
                                    <input name="serie" id="serie" class="form-control"  placeholder="Serie" required >
                                    <p class="help-block">Serie</p>
                                </div>
                                <div class="form-group">
                                    <label>Tipo de art&iacute;culo: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipoarticulo';
                                    $table = 'tipoarticulo';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class);
                                    ?>                                    
                                </div>
                                <div class="form-group">
                                    <label>Almac&eacute;n: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_almacen';
                                    $table = 'almacen';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class);
                                    ?>                                    
                                </div>
                                <div class="form-group">
                                    <label>Descripci&oacute;n: <label style="color: #FF0000">(*)</label></label>
                                    <textarea name="descripcion" id="descripcion" class="form-control" cols="5"  placeholder="Descripci&oacute;n" required ></textarea>
                                    <p class="help-block">Descripci&oacute;n</p>
                                </div>
                                 
                                 <div class="form-group">
                                    <label>Precio de Alquiler: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="precio_alq" name="precio_alq" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <p class="help-block">Precio Alquiler.</p>
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