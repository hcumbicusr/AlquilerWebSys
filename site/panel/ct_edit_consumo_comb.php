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
            if (formulario.nro_vale.value.trim().length < 3)
            {
                formulario.nro_vale.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.trabajador.value.trim().length < 5)
            {
                formulario.trabajador.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.nro_surtidor.value.trim().length < 3)
            {
                formulario.nro_surtidor.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.tarea.value.trim().length < 3)
            {
                formulario.tarea.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.cant_comb.value.trim().length < 1)
            {
                formulario.cant_comb.focus();   
                alert('Ingrese datos válidos'); 
                return false; //devolvemos el foco
            }
            if (formulario.horometro.value.trim().length < 3)
            {
                formulario.horometro.focus();   
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
            <h1 class="page-header">Control de combustible diario (Modificar) </h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="ct_list_combustible.php">
        <img src="../img/atras.png" title="Consumo de combustible"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro del control de combustible<br>
                    <b>Encargado: </b><label style="color: #0000FF"> <?php echo $_SESSION['apenom']; ?></label>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <?php
                            $objDB = new Class_Db();
                            $con = $objDB->selectManager()->connect();
                            $result = $objDB->selectManager()->spSelect($con, "sp_listar_registro_consumo_ID",  Funciones::decodeStrings($_GET['consumo'], 2));
                            //echo $result[0]['estado_g'];
                            list($anio,$mes,$dia) = explode("-", $result[0]['fecha']);
                            $fecha = $dia."/".$mes."/".$anio;
                            ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/consumo.php?event=editar_consumo">                                    
                                
                                <div class="form-group">
                                    <label>Veh&iacute;culo/maquinaria: </label>                                    
                                    <input name="vehiculo" id="vehiculo" value="<?php echo $result[0]['vehiculo']; ?>" disabled class="form-control" >                                    
                                    <input type="hidden" name="id_consumo" id="id_trabvehiculo" value="<?php echo $_GET['consumo']; ?>" >
                                    <p class="help-block">Veh&iacute;culo a cargo.</p>
                                </div>
                                
                                <div class="form-group">
                                    <label>Operador: <label style="color: #FF0000">(*)</label>  </label>                                    
                                    <input name="trabajador" id="trabajador" value="<?php echo $result[0]['operario']; ?>"  placeholder="Operador" class="form-control"  maxlength="200" autofocus required >                                    
                                    <p id="msg_operario" class="help-block">Operador.</p>
                                </div>
                                                                
                                <div class="form-group">
                                    <label>Nro de Gu&iacute;a: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_guia" name="nro_guia" value="<?php echo $result[0]['nro_guia']; ?>" class="form-control" placeholder="000000" maxlength="20" required autofocus >
                                    <p id="msg_nro_guia" class="help-block">N&uacute;mero de Gu&iacute;a.</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de Vale: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_vale_i" name="nro_vale_i" value="<?php echo $result[0]['nro_vale']; ?>" class="form-control" placeholder="000000"  maxlength="20" required >
                                    <p class="help-block">N&uacute;mero de Vale.</p>
                                </div>
                                <div class="form-group">
                                    <label>Nro de Surtidor: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="nro_surtidor" name="nro_surtidor" value="<?php echo $result[0]['nro_surtidor']; ?>" class="form-control" placeholder="000000"  maxlength="20" required >
                                    <p class="help-block">N&uacute;mero de surtidor.</p>
                                </div>                                
                                <div class="form-group">
                                    <label>Cantidad de Combustible: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="cant_comb" name="cant_comb" value="<?php echo $result[0]['cant_combustible']; ?>" class="form-control" placeholder="000000.00 GLN" required onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Cantidad de combustible.</p>
                                </div>                                
                                <div class="form-group">
                                    <label>Hor&oacute;metro: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="horometro" name="horometro" value="<?php echo $result[0]['horometro']; ?>" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Hor&oacute;metro.</p>
                                </div>
                                <div class="form-group">
                                    <label>Kilometraje: </label>
                                    <input id="kilometraje" name="kilometraje" value="<?php echo $result[0]['kilometraje']; ?>" class="form-control" placeholder="000000.00" value="0" onkeypress="return NumCheck(event,this);" maxlength="13">
                                    <p class="help-block">Kilometraje.</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha" name="fecha" value="<?php echo $fecha; ?>" class="form-control fechas" placeholder="dd/mm/yyyy" required maxlength="10">
                                    <p class="help-block">Fecha.</p>
                                </div>
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['consumo'])) { ?>
                                <button id="btn_control" type="submit" class="btn btn-default">Guardar</button>
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