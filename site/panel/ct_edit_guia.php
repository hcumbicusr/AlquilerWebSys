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
            
            if (formulario.nro_guia.value.trim().length < 3)
            {
                formulario.nro_guia.focus();   
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
            <h1 class="page-header"> Editar gu&iacute;as de compra de combustible</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="ct_list_guias.php">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Editar gu&iacute;as de la compra de combustible<br>
                    <b>Encargado: </b><label style="color: #0000FF"> <?php echo $_SESSION['apenom']; ?></label>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="ct_list_guias.php";
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
                            <?php
                            $objDB = new Class_Db();
                            $con = $objDB->selectManager()->connect();
                            $result = $objDB->selectManager()->spSelect($con, "sp_listar_guia_ID",  Funciones::decodeStrings($_GET['guia'], 2));
                            //echo $result[0]['estado_g'];
                            //die();
                            list($anio,$mes,$dia) = explode("-", $result[0]['fecha']);
                            $fecha = $dia."/".$mes."/".$anio;
                            ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/detalle_abastecimiento.php?event=editar_guia">
                                
                                <div class="form-group">
                                    <label>Nro de Gu&iacute;a: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="hidden" name="id_det_abast" value="<?php echo $_GET['guia']; ?>" >
                                    <input id="nro_guia" name="nro_guia" class="form-control" placeholder="000000" maxlength="20" required autofocus value="<?php echo $result[0]['nro_guia']; ?>" >
                                    <p class="help-block">N&uacute;mero de Gu&iacute;a.</p>
                                </div>
                                <div class="form-group">
                                    <label>Tipo de Combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipocombustible';
                                    $table = 'tipocombustible';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class,true,$result[0]['id_tipocombustible']);
                                    ?>      
                                    <p class="help-block">Tipo de combustible.</p>
                                </div>
                                <div class="form-group" title="<?php echo $result[0]['vehiculo']; ?>">
                                    <label>Nro de Placa de veh&iacute;culo SURTIDOR: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_placa" name="nro_placa" value="<?php echo $result[0]['placa']; ?>" class="form-control" placeholder="Nro Placa"  maxlength="20" required >
                                    <p id="nro_placaMsg" class="help-block">El veh&iacute;culo al cual pertenece este n&uacute;mero de placa 
                                        debe estar registrado como <b>Tipo de maquinaria</b> SURTIDOR, de lo contrario no se podr&aacute; realizar 
                                        el registro de la gu&iacute;a.</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de licencia de conducir: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_licencia" name="nro_licencia"  value="<?php echo $result[0]['nro_licencia']; ?>" class="form-control" placeholder="Nro Licencia"  maxlength="20" required  title="<?php echo $result[0]['conductor']; ?>">
                                    <p id="nro_licenciaMsg" class="help-block"><?php echo "Conductor: ". $result[0]['conductor']; ?></p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha" name="fecha" class="form-control fechas" placeholder="dd/mm/yyyy" required maxlength="10" value="<?php echo $fecha; ?>">
                                    <p class="help-block">Fecha.</p>
                                </div>                              
                                <div class="form-group">
                                    <label>Cantidad de Combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="cant_comb" name="cant_comb" class="form-control" placeholder="000000.00 GLN" required onkeypress="return NumCheck(event,this);" maxlength="13" value="<?php echo $result[0]['cantidad']; ?>">
                                    <p class="help-block">Cantidad de combustible.</p>
                                </div>
                                <div class="form-group">
                                    <label>Abastecedor: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="abastecedor" name="abastecedor" class="form-control" placeholder="Abastecedor"  maxlength="200" required value="<?php echo $result[0]['abastecedor']; ?>" >
                                    <p class="help-block">Abastecedor.</p>
                                </div>
                                <div class="form-group">
                                    <label>Vale de combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="vale_combustible" name="vale_combustible" class="form-control" placeholder="000000" maxlength="10" required value="<?php echo $result[0]['vale_combustible']; ?>">
                                    <p id="msg_valeCombustible_reg" class="help-block">N&uacute;mero de Gu&iacute;a.</p>
                                </div>
                                
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['guia'])) { ?>
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