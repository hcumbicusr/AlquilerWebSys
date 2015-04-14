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
              regexp = /^[0-9]+$/10;
              return regexp.test(field.value);
            }
            return false;
          }
        //validar longitud de cadena
        function validarForm(formulario) {            
            
            if (formulario.nombre.value.trim().length < 5)
            {
                formulario.nombre.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            
            if (formulario.codigo.value.trim().length < 8)
            {
                formulario.codigo.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            
            if (formulario.direccion.value.trim().length < 8)
            {
                formulario.direccion.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.telefono.value.trim().length < 6)
            {
                formulario.telefono.focus();   
                alert('Ingrese datos válidos'); 
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
            <h1 class="page-header"> Editar datos de un cliente</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_clientes.php">
        <img src="../img/atras.png" title="Clientes"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de edici&oacute;n de cliente
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                 
                                                                
                                <?php if (Funciones::decodeStrings($_GET['msj'],2) == 'ok') { ?>
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_edit_cliente.php";
                                    function redireccionar() 
                                    {
                                        location.href=pagina;
                                    } 
                                    setTimeout ("redireccionar()", 3000);
                                </script>
                                <div class="form-group has-success">
                                    <label class="control-label" style="font-size: 20px" for="inputSuccess">
                                        Registrado con &eacute;xito.<br>
                                        <sub>En un momento ser&aacute; redirigido a la creaci&oacute;n de un contrato.</sub>
                                    </label>
                                </div>                                
                                <?php } else { ?>
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_registro_cliente.php";
                                    function redireccionar() 
                                    {
                                        location.href=pagina;
                                    } 
                                    setTimeout ("redireccionar()", 3000);
                                </script>
                                <div class="form-group has-error">
                                    <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido ingresar el registro</label>
                                </div>
                                <?php } } ?>
                            </div>
                             <?php
                            $objDB = new Class_Db();
                            $con = $objDB->selectManager()->connect();
                            $result = $objDB->selectManager()->spSelect($con, "sp_listar_cliente_ID",  Funciones::decodeStrings($_GET['cliente'], 2));
                            //echo $result[0]['estado_g'];
                            ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/cliente.php?event=editar">
                                
                                <div class="form-group">
                                    <label>Nombre: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="hidden" id="id_cliente" name="id_cliente" value="<?php echo $_GET['cliente']; ?>" >
                                    <input id="nombre" name="nombre" value="<?php echo $result[0]['nombre']; ?>" class="form-control" placeholder="Nombre de cliente" maxlength="100"  required autofocus>
                                    <p class="help-block">Nombre.</p>
                                </div>
                                <div class="form-group">
                                    <label>Tipo de cliente: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipocliente';
                                    $table = 'cliente';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class, true, $result[0]['id_tipocliente']);
                                    ?>
                                    <p class="help-block">Elegir el tipo de cliente.</p>
                                </div>                                
                                <div class="form-group">
                                    <label>DNI/RUC: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="codigo" name="codigo"  value="<?php echo $result[0]['codigo']; ?>" class="form-control" placeholder="C&oacute;digo" onkeypress="ValidaSoloNumeros();" maxlength="11" required>
                                    <p class="help-block">DNI/RUC.</p>
                                </div>
                                <div class="form-group">
                                    <label>Direcci&oacute;n: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="direccion" name="direccion" value="<?php echo $result[0]['direccion']; ?>" class="form-control" placeholder="Direcci&oacute;n" maxlength="200" required>
                                    <p class="help-block">Direcci&oacute;n.</p>
                                </div>
                                <div class="form-group">
                                    <label>Tel&eacute;fono: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="telefono" name="telefono" value="<?php echo $result[0]['telefono']; ?>" class="form-control" maxlength="15"  placeholder="Nro tel&eacute;fono" required>
                                    <p class="help-block">Tel&eacute;fono.</p>
                                </div>
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['cliente'])) { ?>
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