<?php include '00header.php'; ?>
<?php if(empty($_GET)) { ?>
<script >
    setTimeout (location.href='./', 0);
</script>
<?php } ?>
<script>
               
        //validar longitud de cadena
        function validarForm(formulario) {            
           
            if (formulario.nombre.value.trim().length < 2)
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
            <h1 class="page-header"> Edici&oacute;n de tipos</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <a href="adm_list_tipos.php">
        <img src="../img/atras.png" title="Tipos"><label>Atr&aacute;s</label>
    </a>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de edici&oacute;n de tipos
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_list_tipos.php";
                                    function redireccionar() 
                                    {
                                        location.href=pagina;
                                    } 
                                    setTimeout ("redireccionar()", 3000);
                                </script>
                                <?php if (Funciones::decodeStrings($_GET['msj'],2) == 'ok') { ?>
                                <div class="form-group has-success">
                                    <label class="control-label" style="font-size: 20px" for="inputSuccess">Modificado con &eacute;xito</label>
                                </div>
                                <?php } else { ?>
                                <div class="form-group has-error">
                                    <label class="control-label" style="font-size: 20px" for="inputError">No se ha podido Modificar el registro</label>
                                </div>
                                <?php } } ?>
                            </div>                                                        
                            <?php
                            $objDB = new Class_Db();
                            $con = $objDB->selectManager()->connect();
                            $input = "'".Funciones::decodeStrings($_GET['tipo'], 2)."','".Funciones::decodeStrings($_GET['id'], 2)."'";                            
                            $result = $objDB->selectManager()->spSelect($con, "sp_listar_tipos_ID", $input );                            
                            ?>
                            <form role="form"  onsubmit="return validarForm(this);" method="POST" 
                                  action="./../../app/controllers/tipo.php?event=editar">                                                                
                                                                
                                <div class="form-group">
                                    <label>Nombre: <label style="color: #FF0000">(*)</label></label>
                                    <input name="nombre" id="nombre" class="form-control" value="<?php echo $result[0]['nombre']; ?>" placeholder="Nombre de tipo" required autofocus >
                                    <input type="hidden" name="id" value="<?php echo $_GET['id']; ?>" >
                                    <input type="hidden" name="ntab" value="<?php echo $_GET['tipo']; ?>" >
                                </div>                                
                                <div class="form-group">
                                    <label>Estado: <label style="color: #FF0000">(*) <sup>Si selecciona el estado <b>INACTIVO</b> este no se mostrar&aacute; en las opciones de registro</sup></label> </label>                                     
                                    <?php 
                                    $name = 'estado';
                                    $table = 'estado';
                                    $class = 'form-control';
                                    require_once '../../libraries/HTML_armar_select.php';    
                                    select($name, $table, $class, true, $result[0]['estado']);
                                    ?>                                                                    
                                    <p class="help-block">Estado.</p>
                                </div>
                               <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                <?php if (!empty($_GET['tipo']) || !empty($_GET['id'])) { ?>
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