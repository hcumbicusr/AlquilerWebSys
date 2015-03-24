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
            <h1 class="page-header">Anulaci&oacute;n de Alquiler</h1>
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
                    
                    echo "Maquinaria: <b>(".$res[0]['tipovehiculo'].") ".$res[0]['vehiculo']." / ".$res[0]['marca']." / MOD: ".$res[0]['modelo']." / SERIE: ".$res[0]['serie']." / PLACA: ".$res[0]['placa']."</b>"; 
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
                                    <label class="control-label" style="font-size: 20px" for="inputSuccess"> El alquiler ha sido anulado exitosamente</label>
                                </dv>
                                <?php } else { ?>
                                <div class="form-group has-error">
                                    <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido anular el alquiler</label>
                                </div>
                                <?php } } ?>
                            </div> 
                            <?php 
                            $objDB = new Class_Db();
                            $con = $objDB->selectManager()->connect();                            
                            
                            $query = "SELECT count(*) as asignado
                                        FROM detallealquiler da
                                        WHERE da.est_alq = 'A' AND
                                        da.id_detallealquiler IN (SELECT t.id_detallealquiler FROM trabvehiculo t)
                                        AND da.id_detallealquiler = ".Funciones::decodeStrings($_GET['detal'],2);
                            $result = $objDB->selectManager()->select($con, $query);
                            if (!empty($result)) {
                                if ($result[0]['asignado'] == 1) {
                            ?>
                            <div class="alert alert-danger">
                                <p>
                                    NO se puede anular el alquiler debido a que esta unidad ya ha sido asignada a un operario.<br>
                                    Usted debe realizar el proceso de <a href="adm_reg_dev_vehiculo.php?contrato=<?php echo $_GET['contr']; ?>&det_alq=<?php echo $_GET['detal']; ?>" class="link">[[ DEVOLUCI&Oacute;N de Alquiler ]]</a>
                                    <br>                                    
                                </p>
                            </div>
                                <?php }else{ ?>
                              <div class="alert alert-success">
                                <p>
                                    La unidad seleccionada ser&aacute; retirada del contrato.<br>                                    
                                </p>
                            </div>      
                             <?php   } } ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/detalle_alquiler.php?event=anula_alq">
                                <div class="form-group">                                    
                                    <input type="hidden" name="id_detallealquiler" id="id_detallealquiler" value="<?php echo $_GET['detal']; ?>" >
                                    <input type="hidden" name="id_contrato" id="id_contrato" value="<?php echo $_GET['contr']; ?>" >
                                </div>                                
                                <?php if ($result[0]['asignado'] == 0) { ?>
                               <button type="submit" class="btn btn-default">Cancelar Alquiler</button>                                
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