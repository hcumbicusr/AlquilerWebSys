<?php include '00header.php'; ?>

<script>
           
           function NumCheck(e, field) {
            key = e.keyCode ? e.keyCode : e.which
            if (key == 8) return true
            if (key > 47 && key < 58) {
              if (field.value == "") return true;
              regexp = /.[0-9]{10}$/
              return !(regexp.test(field.value))
            }
            if (key == 46) {
              if (field.value == "") return false;
              regexp = /^[0-9]+$/
              return regexp.test(field.value)
            }
            return false;
          }
        //validar longitud de cadena
        function validarForm(formulario) {            
            
            if (formulario.fecha.value.trim().length != 10)
            {
                formulario.fecha.focus();   
                alert('Ingrese datos validos'); 
                return false; //devolvemos el foco
            }
            if (formulario.id_trabajador.value.trim() < 0)
            {
                formulario.id_trabajador.focus();   
                alert('No hay un operario disponible'); 
                return false; //devolvemos el foco
            }
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Transporte de maquinaria</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">                
                <a href="adm_list_detallealvh.php?contrato=<?php echo $_GET['contr']; ?>">
                    <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
                </a>
                
                <div class="panel-heading">
                    <?php
                    include '../../app/controllers/trab_vehiculo.php';
                    $res = datosVechiculoAsigna(Funciones::decodeStrings($_GET['detal'],2));
                    
                    echo "Veh&iacute;culo/Maquinaria: <b>(".$res[0]['tipovehiculo'].") ".$res[0]['vehiculo']." / ".$res[0]['marca']." / MOD: ".$res[0]['modelo']." / SERIE: ".$res[0]['serie']." / PLACA: ".$res[0]['placa']."</b>"; 
                    ?>
                </div>
                
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_list_detallealvh.php?contrato=<?php echo $_GET['contr']; ?>";
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
                            
                            $query = "SELECT count(*) as cantidad
                                        FROM transporte t                                        
                                        WHERE t.id_detallealquiler = ".Funciones::decodeStrings($_GET['detal'],2);
                            $result = $objDB->selectManager()->select($con, $query);
                            if (!empty($result)) {
                            ?>
                            <div class="alert alert-warning">
                                <p>
                                    Esta unidad tiene <b>[ <?php echo $result[0]['cantidad']; ?> ]</b> registro(s) de transporte. <br>                                    
                                </p>
                            </div>
                            <?php } ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/transporte.php?event=registrar">
                                <div class="form-group">                                    
                                    <input type="hidden" name="id_detallealquiler" id="id_detallealquiler" value="<?php echo $_GET['detal']; ?>" >
                                    <input type="hidden" name="id_contrato" id="id_contrato" value="<?php echo $_GET['contr']; ?>" >
                                </div>
                                <div class="form-group">
                                    <label>Concepto: <label style="color: #FF0000">(*)</label> </label>
                                    <select id="concepto" name="concepto" class="form-control" autofocus required>
                                        <option value="MOVILIZACIÓN">MOVILIZACI&Oacute;N</option>
                                        <option value="DESMOVILIZACIÓN">DESMOVILIZACI&Oacute;N</option>
                                    </select>
                                    <p class="help-block">Concepto</p>
                                </div>
                                <div class="form-group">
                                    <label>Monto: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="monto" name="monto" class="form-control" placeholder="000000.00" required onkeypress="return NumCheck(event,this);" maxlength="15" >
                                    <p class="help-block">Monto.</p>
                                </div>
                                <div class="form-group">
                                    <label>Fecha de movilizaci&oacute;n: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="fecha" name="fecha" class="form-control fechas_v" 
                                           placeholder="dd/mm/yyyy" maxlength="10" required autofocus>
                                    <p class="help-block">Fecha de movilizaci&oacute;n.</p>
                                </div>
                                <div class="form-group">
                                    <label>Observaci&oacute;n:  </label>
                                    <textarea id="observacion" name="observacion" class="form-control" cols="6" maxlength="400" placeholder="Observaci&oacute;n"></textarea>
                                    <p class="help-block">Observaci&oacute;n</p>
                                </div>                                                            
                               <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <button type="submit" class="btn btn-default">Guardar</button>                                
                                <button type="reset" class="btn btn-default">Limpiar</button>                                
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>