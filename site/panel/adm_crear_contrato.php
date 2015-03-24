<?php include '00header.php'; ?>

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
        <div class="col-lg-12">
            <h1 class="page-header">Registro de nuevo contrato</h1>
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
                    Formulario de registro de contrato
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_list_clientes.php";
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
                                $query = "SELECT * FROM cliente WHERE id_cliente = ".Funciones::decodeStrings($_GET['cliente'],2);
                                //die(var_dump($query));
                                $result = $objDB->selectManager()->select($con, $query);
                                //die(var_dump($result[0]['nombre']));
                                ?>
                            
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/contrato.php?event=registrar">                                                                
                                
                                <div class="form-group">
                                    <label>Cliente: </label>
                                    <input id="cliente" name="cliente" class="form-control" placeholder="Nombre de Cliente" onkeypress="txNombres();" maxlength="100" required value="<?php echo $result[0]['nombre']; ?>" disabled >
                                    <p class="help-block">Cliente</p>
                                    <input type="hidden" name="id_cliente" id="id_cliente" value="<?php echo $_GET['cliente']; ?>" >
                                </div>
                                <div class="form-group">
                                    <label>Obra: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_obra';
                                    $table = 'obra';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class);
                                    ?>
                                    <p class="help-block">
                                        Elegir la obra.<sup><a href="adm_reg_obra.php" target="_blank">Si no ha registrado la obra, haga click AQU&Iacute;</a></sup>
                                    </p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha de inicio: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="f_inicio" name="f_inicio" class="form-control fechas_v" placeholder="dd/mm/yyyy" maxlength="10" required autofocus>
                                    <p class="help-block">Fecha de inicio.</p>
                                </div>
                                <!--div class="form-group">
                                    <label>Fecha de finalizaci&oacute;n: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="f_fin" name="f_fin" class="form-control fechas_v" placeholder="dd/mm/yyyy" maxlength="10" required>
                                    <p class="help-block">Fecha de finalizaci&oacute;n.</p>
                                </div -->
                                <!--div class="form-group">
                                    <label>Presupuesto: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="presupuesto" name="presupuesto" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <p class="help-block">Presupuesto.</p>
                                </div-->
                                <div class="form-group">
                                    <label>Descripci&oacute;n:</label>
                                    <textarea name="detalle" id="detalle" class="form-control" rows="5" placeholder="Descripci&oacute;n" ></textarea>
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