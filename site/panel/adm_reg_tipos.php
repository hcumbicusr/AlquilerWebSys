<?php include '00header.php'; ?>

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
            <h1 class="page-header"> Registro de tipos</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Formulario de registro de tipos
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <?php if(!empty($_GET['msj'])) { ?>                                
                                <script LANGUAGE="JavaScript">
                                    var pagina="adm_reg_tipos.php";
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
                                  action="./../../app/controllers/tipo.php?event=registrar">                                                                
                                                                
                                <div class="form-group">
                                    <label>Nombre: <label style="color: #FF0000">(*)</label></label>
                                    <input name="nombre" id="nombre" class="form-control" placeholder="Nombre de tipo" required autofocus >
                                </div>
                                <div class="form-group">
                                    <label>Tipo al que pertenece: <label style="color: #FF0000">(*)</label> </label>
                                    <select name="tipo" required class="form-control">
                                        <option></option>
                                        <option value="ARTICULO">ART&Iacute;CULO</option>
                                        <option value="CLIENTE">CLIENTE</option>
                                        <option value="COMBUSTIBLE">COMBUSTIBLE</option>
                                        <option value="COMPROBANTE">COMPROBANTE</option>
                                        <option value="MARCA">MARCA</option>
                                        <option value="OBRA">OBRA</option>
                                        <option value="TRABAJADOR">TRABAJADOR</option>
                                        <option value="USUARIO">USUARIO</option>
                                        <option value="VEHICULO">VEH&Iacute;CULO</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Estado inicial: <label style="color: #FF0000">(*)</label> </label>
                                    <select name="estado" required class="form-control">                                        
                                        <option value="A">ACTIVO</option>
                                        <option value="B">INACTIVO</option>                                        
                                    </select> 
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