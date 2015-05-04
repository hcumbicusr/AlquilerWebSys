<?php include '00header.php'; ?>

<script>               
        function validarForm(formulario) {
            if (formulario.comprobante.value.trim().length < 5)
            {
                formulario.comprobante.focus();   
                alert('Ingrese un comprobante válido'); 
                return false; //devolvemos el foco
            }
                      
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Asignaci&oacute;n personalizada de gu&iacute;as a comprobantes</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Asignaci&oacute;n Personalizada<br>                    
                </div>
                <div class="panel-body table-responsive" >
                    <div class="row" >
                        <div class="col-lg-12">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="ct_asigna_check.php";
                                    function redireccionar() 
                                    {
                                        location.href=pagina;
                                    }                                     
                                </script>
                                <?php if (Funciones::decodeStrings($_GET['msj'],2) == 'no') { ?>
                                <div class="form-group has-error">
                                    <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido realizar la asignaci&oacute;n</label>
                                    <script>setTimeout ("redireccionar()", 2000);</script>
                                </div>                               
                                <?php } else if (Funciones::decodeStrings($_GET['msj'],2) == 'comp') { ?>
                                 <div class="form-group has-warning">
                                    <label class="control-label" style="font-size: 20px" for="inputWarning"> 
                                        El nro de comprobrante ingresado no se encuentra registrado. Vaya a <a href="ct_registro_comprobante.php">Registro de comprobantes</a>
                                    </label>
                                    <script>setTimeout ("redireccionar()", 2000);</script>
                                </div>
                                <?php }else if (Funciones::decodeStrings($_GET['msj'],2) == 'sel'){ ?>
                                <div class="form-group has-warning">
                                    <label class="control-label" style="font-size: 20px" for="inputWarning"> 
                                        No se ha seleccionado gu&iacute;as para ser asignadas.
                                    </label>
                                     <script>setTimeout ("redireccionar()", 2000);</script>
                                </div>
                              <?php  }else { ?>
                               <div class="form-group has-warning">
                                    <label class="control-label" style="font-size: 20px" for="inputWarning"> 
                                        Asignaci&oacute;n realizada con &eacute;xito.<br>
                                        <?php echo Funciones::decodeStrings($_GET['msj'],2); ?> gu&iacute;as han sido asignadas. <a href="ct_list_guias.php">Ver</a>
                                    </label>
                                     <script>setTimeout ("redireccionar()", 4000);</script>
                                </div>
                              <?php }                                                                 
                                } ?>                                
                            </div>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/detalle_abastecimiento.php?event=asignar_chk" style="width: 100%">                                 
                                <!-- /.panel -->
                                <div class="form-group">
                                    <label>Nro. Comprobante: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="comprobante_chk" name="comprobante" class="form-control" style="width: 160px" autofocus placeholder="Nro. Comprobante" required maxlength="15">
                                    <p  id="msg_comprobante_chk" class="help-block">Comprobante.</p>
                                </div>                                
                                
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                
                                <button id="btn_check_asig" type="submit" class="btn btn-default">Guardar Asignaci&oacute;n</button>
                                <button type="reset" class="btn btn-default">Limpiar todo</button>
                                
                                <div class="panel-body table-responsive">
                                    <div class="dataTable_wrapper">
                                        <table class="table table-striped table-bordered table-hover" id="dataTable_check">
                                            <thead>
                                                <tr>
                                                    <th>N</th>         
                                                    <th>Fecha</th>
                                                    <th>Nro.</th>
                                                    <th>Vale Comb.</th>
                                                    <th>Cant.</th>
                                                    <th>Stock</th>
                                                    <th>Tipo Comb.</th>                                          
                                                    <th>Abastecedor</th>
                                                    <th>Conductor</th>
                                                    <th>Veh&iacute;culo</th>                                    
                                                    <th><label for="select_todo">TODO</label><input type="checkbox" id="select_todo" style="width: 19px; height: 19px" > </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php 
                                                require_once '../../libraries/HTML_tabla_asigna_check.php'; 
                                                table();
                                                ?>
                                            </tbody>
                                        </table>
                                    </div>
                                </div> 
                                <button type="submit" class="btn btn-default">Guardar Asignaci&oacute;n</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>