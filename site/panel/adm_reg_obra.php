<?php include '00header.php'; ?>

<script>
               
        //validar longitud de cadena
        function validarForm(formulario) {            
           
            if (formulario.nombre.value.trim().length < 5)
            {
                formulario.nombre.focus();   
                alert('Ingrese un nombre válido'); 
                return false; //devolvemos el foco
            }                       
            
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Registro de una obra</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro de obras
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_reg_obra.php";
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
                                  action="./../../app/controllers/obra.php?event=registrar">                                                                
                                                                
                                <div class="form-group">
                                    <label>Nombre: <label style="color: #FF0000">(*)</label></label>
                                    <textarea name="nombre" id="nombre" class="form-control" rows="5" placeholder="Nombre de obra" required autofocus></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Tipo de Obra: <label style="color: #FF0000">(*)</label> </label>
                                    <?php 
                                    $name = 'id_tipoobra';
                                    $table = 'tipoobra';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class,true,3,true); //--> [3] = tipoobra STANDARD
                                    ?>                                    
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