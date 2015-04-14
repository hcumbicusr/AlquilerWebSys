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
          
function validarForm(formulario) {                                  
           
            if (formulario.fecha_fin.value.trim().length != 10 )
            {
                formulario.fecha_fin.focus();   
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
            <h1 class="page-header">Finalizaci&oacute;n de Contrato</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_contratos.php">
        <img src="../img/atras.png" title="Contratos"><label>Atr&aacute;s</label>
    </a>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <?php
                    $objDB = new Class_Db();
                    $con = $objDB->selectManager()->connect();
                    $result = $objDB->selectManager()->spSelect($con, "sp_listar_contrato_ID",  Funciones::decodeStrings($_GET['contrato'], 2));
                    
                    list($anio,$mes,$dia) = explode("-", $result[0]['f_inicio']);
                    $f_inicio = $dia."/".$mes."/".$anio;

//die(var_dump($result));
                    ?>
                    <br>
                    <label style="color: #0000FF">
                        Obra: <?php echo $result[0]['obra']; ?>
                    </label>
                </div>
                <div>
                    <?php if(!empty($_GET['msj'])) { ?>                                 

                    <?php if (Funciones::decodeStrings($_GET['msj'],2) == 'ok') { ?>
                    <script LANGUAGE="JavaScript">
                        var pagina="adm_list_contratos.php";
                        function redireccionar() 
                        {
                            location.href=pagina;
                        } 
                        setTimeout ("redireccionar()", 3000);
                    </script>
                    <div class="form-group has-success">
                        <label class="control-label" style="font-size: 20px" for="inputSuccess">
                            El contrato se ha finalizado.<br>
                        </label>
                    </div>                                
                    <?php } else if (Funciones::decodeStrings($_GET['msj'],2) == 'no'){ ?>
                    <script LANGUAGE="JavaScript">
                        var pagina="adm_list_contratos.php";
                        function redireccionar() 
                        {
                            location.href=pagina;
                        } 
                        setTimeout ("redireccionar()", 3000);
                    </script>
                    <div class="form-group has-error">
                        <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido finalizar el contrato.</label>
                    </div>
                    <?php }
                    
                    } ?>
                </div>
                <div class="panel-body">
                    <div class="col-lg-6">
                        <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                              action="./../../app/controllers/contrato.php?event=finalizar" >                            
                            <input type="hidden" name="contrato" id="contrato" value="<?php echo $_GET['contrato']; ?>" >
                            <div class="form-group">
                                <label>Fecha de inicio: </label>
                                <input id="fecha_inicio_contrato" disabled value="<?php echo $f_inicio; ?>"  class="form-control" placeholder="dd/mm/yyyy" maxlength="10" >
                                <p class="help-block">Fecha de inicio.</p>
                            </div>
                            <div class="form-group">
                                <label>Fecha de finalizaci&oacute;n: <label style="color: #FF0000">(*)</label> </label>
                                <input type="text" id="fecha_fin" name="fecha_fin" class="form-control fechas" placeholder="dd/mm/yyyy" maxlength="10" required>
                                <p class="help-block">Fecha de finalizaci&oacute;n.</p>
                            </div>
                            <div class="form-group">
                                <label>Presupuesto: </label>
                                <input id="presupuesto" name="presupuesto" class="form-control" placeholder="000000.00" onkeypress="return NumCheck(event,this);" maxlength="15" >
                                <p class="help-block">Presupuesto.</p>
                            </div>
                            <div class="form-group">
                                <label>Observaci&oacute;n: </label>
                                <textarea id="observacion" name="observacion" class="form-control" placeholder="Observaci&oacute;n" cols="6" ><?php echo $result[0]['detalle']; ?></textarea>
                                <p class="help-block">Observaci&oacute;n.</p>
                            </div>  
                            <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                            <br>
                            <div class="alert alert-warning">
                                <p>
                                    <b>NOTA</b><br>
                                    - Al finalizar el contrato las maquinarias o art&iacute;culos que este tenga ser&aacute;n liberados y estar&aacute;n disponibles para volver a ser alquilados.<br>
                                    - El contrato aparecer&aacute; deshabilitado para cualquier operaci&oacute;n.
                                </p>
                            </div>
                            <?php if (!empty($_GET['contrato'])) { ?>
                            <button type="submit" class="btn btn-danger" title="Finalizar el contrato"><i class="fa fa-close fa-fw"></i>Finalizar</button>
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

<?php include '00footer.php'; ?>