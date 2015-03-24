<?php include '00header.php'; ?>

<script>        
        //validar longitud de cadena
        function validarForm(formulario) {            
            
            if (formulario.password.value.trim().length < 6)
            {
                formulario.password.focus();   
                alert('La clave debe contener almenos 6 caracteres.'); 
                return false; //devolvemos el foco
            }
            return true;
          }
    </script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Cambio de clave</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Cambio de clave<br>                    
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">                            
                            <div>
                                
                                <div class="form-group">
                                    <label>Clave actual: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="password" id="actual" name="actual" class="form-control" placeholder="Clave actual" maxlength="20" required >
                                    <p id="msg_actual" class="help-block"> Clave actual.</p>
                                </div>
                                <div class="form-group">
                                    <label>Clave nueva: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="password" id="password" name="password" class="form-control" placeholder="Clave nueva" maxlength="20" required >
                                    <p id="msg_pass1" class="help-block"> Clave nueva.</p>
                                </div>
                                <div class="form-group">
                                    <label>Repetir Clave nueva: <label style="color: #FF0000">(*)</label> </label>
                                    <input type="password" id="password_r" name="password_r" class="form-control" placeholder="Clave nueva" maxlength="20" required >
                                    <p id="msg_pass" class="help-block">Repetir Clave nueva.</p>
                                </div>
                                
                                <div> <label style="color: #FF0000">(*) Datos obligatorios</label></div>
                                
                                <button id="btn_user_conf" class="btn btn-default">Guardar</button>                                
                                <button type="reset" class="btn btn-default">Limpiar todo</button>
                                <label id="mensaje_pass" class="text-info" ></label>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>