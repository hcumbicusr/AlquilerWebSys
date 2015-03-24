<?php include '00header.php'; ?>

<script>               
        function validarForm(formulario) {
            if (formulario.comprobante.value.trim().length < 5)
            {
                formulario.comprobante.focus();   
                alert('Ingrese un comprobante válido'); 
                return false; //devolvemos el foco
            }
            if (formulario.desde.value.trim().length != 10)
            {
                formulario.desde.focus();   
                alert('Ingrese una fecha correcta'); 
                return false; //devolvemos el foco
            }
            if (formulario.hasta.value.trim().length != 10)
            {
                formulario.hasta.focus();   
                alert('Ingrese una fecha correcta'); 
                return false; //devolvemos el foco
            }            
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Asignaci&oacute;n de gu&iacute;as a comprobantes entre fechas</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Selecciones las fechas<br>                    
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="ct_asigna_fech.php";
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
                                <?php } else { ?>
                                 <div class="form-group has-success">
                                    <label class="control-label" style="font-size: 20px" for="inputSuccess"> 
                                        Asignaci&oacute;n realizada con &eacute;xito.<br>
                                        Asignaciones realizadas: <?php echo Funciones::decodeStrings($_GET['msj'],2); ?>
                                    </label>
                                     <script>setTimeout ("redireccionar()", 5000);</script>
                                </div>
                                <?php } 
                                
                                } ?>
                            </div>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/detalle_abastecimiento.php?event=asignar_fc">
                                                                
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Tenga en cuenta!
                                    </div>
                                    <div class="alert alert-warning">
                                        <p>
                                            Las gu&iacute;as cuya fecha sea igual a la indicada en los l&iacute;mites (Desde y Hasta)
                                            <b>SI</b> son inclu&iacute;das en la asignaci&oacute;n.                                       
                                        </p>
                                    </div>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">
                                        <!-- Button trigger modal -->
                                        <button class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">
                                            Ver ejemplo
                                        </button>
                                        <!-- Modal -->
                                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                        <h4 class="modal-title" id="myModalLabel">Ejemplo de asignaci&oacute;n r&aacute;pida</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <table align="center">
                                                            <tr>
                                                                <td style="font-weight: bold">Fechas</td>
                                                                <td align="center" style="font-weight: bold">Condici&oacute;n</td>
                                                                <td style="font-weight: bold">Resultado</td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    01/02/2015<br>
                                                                    <b>02/02/2015</b><br>
                                                                    03/02/2015<br>
                                                                    <b>04/02/2015</b><br>
                                                                    05/02/2015<br>
                                                                    06/02/2015<br>
                                                                    07/02/2015<br>
                                                                </td>
                                                                <td style="padding: 17px">
                                                                    <b>Desde: 02/02/2015 </b><br>  <b>Hasta: 04/02/2015</b>
                                                                </td>
                                                                <td>
                                                                    <b>02/02/2015</b><br>
                                                                    03/02/2015<br>
                                                                    <b>04/02/2015</b><br>
                                                                </td>
                                                            </tr>
                                                        </table>                                                        
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>                                                        
                                                    </div>
                                                </div>
                                                <!-- /.modal-content -->
                                            </div>
                                            <!-- /.modal-dialog -->
                                        </div>
                                        <!-- /.modal -->
                                    </div>
                                    <!-- .panel-body -->
                                </div>
                                <!-- /.panel -->
                                <div class="form-group">
                                    <label>Nro. Comprobante: <label style="color: #FF0000">(*)</label> </label>
                                    <input id="comprobante_chk" name="comprobante" class="form-control" autofocus placeholder="Nro. Comprobante" required maxlength="15">
                                    <p id="msg_comprobante_chk" class="help-block">Comprobante.</p>
                                </div>
                                <div class="form-group">
                                    <label>Desde: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="desde" name="desde" class="form-control desdeFech" placeholder="dd/mm/yyyy" required maxlength="10">
                                    <p class="help-block">Desde.</p>
                                </div> 
                                <div class="form-group">
                                    <label>Hasta: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="text" id="hasta" name="hasta" class="form-control hastaFech" placeholder="dd/mm/yyyy" required maxlength="10">
                                    <p class="help-block">Hasta.</p>
                                </div> 
                                
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                
                                <button id="btn_check_asig" type="submit" class="btn btn-default">Guardar</button>
                                
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