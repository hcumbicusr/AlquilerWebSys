</div>
<footer>
    <center>
        <div class="copyright">
            &copy; 2015 <a href="http://www.piuramaq.com/" target="_blank">Piuramaq S.R.L.</a> Alquiler de maquinarias
    </div>
    </center>
</footer>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="../bower_components/jquery/dist/jquery.min.js"></script>
    
    <script src="../bower_components/jquery/dist/jquery-ui-1.10.4.custom.min.js"></script>
    
    <script src="../bower_components/jquery/dist/jquery-ui.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="../bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="../bower_components/raphael/raphael-min.js"></script>
    <!--script src="../bower_components/morrisjs/morris.min.js"></script-->
    <!--script src="../js/morris-data.js"--></script>

    <!-- DataTables JavaScript -->
    <script src="../bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
    <script src="../bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
    
    <!-- sonidos -->
    <script src="../resources/sound_app/ion.sound.js" > </script>

    <!-- Custom Theme JavaScript -->
    <script src="../dist/js/sb-admin-2.js"></script>            
    <link href="../css/jquery-ui.css" rel="stylesheet">
    
    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
                
        $('#dataTables-example').DataTable({
                responsive: true
        });
        
         $('#dataTable_check').DataTable({
                responsive: true,
                bPaginate: false,
                bFilter: false
        });
        $("#select_todo").change(function(){
            if ($(this).is(":checked"))
            {
                $("#dataTable_check input[type=checkbox]").prop("checked",true);
            }else
            {
                $("#dataTable_check input[type=checkbox]").prop("checked",false);
            }
        });
        
        $("#mensaje_pass").css("display","none");
        $("#btn_user_conf").attr("disabled",true);
        
        $("#btn_check_asig").attr("disabled",true);
        $("#comprobante_chk").blur(function (){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/ajax_comprobante.php',
                data:{
                    comprobante: $("#comprobante_chk").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {
                        $("#msg_comprobante_chk").html("El Nro comprobante ingresado NO existe. <a href='ct_registro_comprobante.php' target='_blank'>Registrar uno nuevo</a>").css("color","#FF0000");
                        $("#btn_check_asig").attr("disabled",true);
                    }else
                    {
                        $("#msg_comprobante_chk").text("Comprobante OK.").css("color","#00FF00");
                        $("#btn_check_asig").attr("disabled",false);
                    }                    
                }
            });
        });
        
        $("#actual").blur(function () {
            $("#mensaje_pass").css("display","none");            
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/ajax_password.php',
                data:{
                    event: 'clave',
                    actual: $("#actual").val(),
                    nueva: $("#password").val(),
                    nueva_r: $("#password_r").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {
                        $("#msg_actual").text("Clave incorrecta").css("color","#FF0000");
                        $("#btn_user_conf").attr("disabled",true);
                    }else
                    {
                        $("#msg_actual").text("OK").css("color","#0000FF");
                        $("#btn_user_conf").attr("disabled",true);
                    }                    
                }
            });
        });
        
        $("#password").blur(function (){
            if ( $("#password").val().length < 6)
            {
                $("#msg_pass1").text("Debe contener almenos 6 caracteres").css("color","#FF0000");
            }else
            {
                $("#msg_pass1").text("Clave nueva.").css("color","#000000");
            }
        });
        
        $("#password_r").blur(function () {
            $("#mensaje_pass").css("display","none");                        
            
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/ajax_password.php',
                data:{
                    event: 'igual',
                    actual: $("#actual").val(),
                    nueva: $("#password").val(),
                    nueva_r: $("#password_r").val()
                },
                success:function(result){                     
                    if (result == 0)
                    {
                        $("#msg_pass").text("Clave no coincide").css("color","#FF0000");
                        $("#btn_user_conf").attr("disabled",true);
                    }else
                    {
                        $("#msg_pass").text("OK").css("color","#0000FF");
                        $("#btn_user_conf").attr("disabled",false);
                    }                    
                }
            });
        });
        
        $("#btn_user_conf").click(function (){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/ajax_password.php',
                data:{
                    event: 'save',
                    actual: $("#actual").val(),
                    nueva: $("#password").val(),
                    nueva_r: $("#password_r").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {
                        $("#mensaje_pass").css("display","block");                        
                        $("#mensaje_pass").text("No se ha podido guardar la nueva clave.");
                        $("#btn_user_conf").attr("disabled",true);                        
                    }else if (result == 1)
                    {
                        $("#mensaje_pass").css("display","block");
                        $("#mensaje_pass").text("La clave ha sido cambiada.");                        
                        $("#btn_user_conf").attr("disabled",false);
                    }                    
                }
            });
        });                
        
        $("#divGuiasFech").css("display","none");
        $("#tablaPartes").html(""); 
        $("#btnMuestra").click(function (){
            $("#tablaPartes").html(""); 
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/ajax_partes_fechas.php',
                data:{
                    event: 'partes',
                    desde: $("#desde_val").val(),
                    hasta: $("#hasta_val").val()
                },
                success:function(result){                    
                    if (result != 0)
                    {              
                        $("#msgPartesFech").text("");
                        $("#divGuiasFech").css("display","block");                    
                        $("#tablaPartes").append(result);
                        $('#tblGuiasFech').DataTable();
                    }else
                    {
                        $("#msgPartesFech").css("color","#FF00FF");
                        $("#msgPartesFech").text("No se han encontrado partes diarios en este rango de fechas");
                        $("#divGuiasFech").css("display","none");
                        $("#tablaPartes").html("");
                    }                    
                }
            });
        });
        
        $("#btn_control").attr("disabled",false);
        $("#trabajador").blur(function(){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'nombre',
                    nombre: $("#trabajador").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {                                                                                               
                        $("#btn_control").attr("disabled",true);                        
                        $("#msg_operario").html("Este trabajador no está registrado<br><a href='adm_registro_trabajador.php' target='_blank'>Registrar Nuevo trabajador</a>").css("color","#FF0000");
                    }else if (result == 1)
                    {
                        $("#msg_operario").text("OK").css("color","#0000FF");
                        $("#btn_control").attr("disabled",false);
                    }  
                    if ($("#trabajador").val().trim().length < 5)
                    {                                        
                        $("#btn_control").attr("disabled",true); 
                        $("#msg_operario").text("Ingrese un nombre válido").css("color","#FF0000");
                    }
                }
            });            
        });
        
        $("#dni").blur(function(){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'trabajador',
                    nombre: $("#dni").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {                                                                                               
                        $("#btnRegTrab").attr("disabled",false);                        
                        $("#dniMsg").text("OK").css("color","#0000FF");
                    }else if (result == 1)
                    {                        
                        $("#dniMsg").html("Este dni ya se ha registrado<br><a href='adm_list_trabajadores.php#"+$("#dni").val()+"' target='_blank'>Ver Resgistros</a>").css("color","#FF0000");
                        $("#btnRegTrab").attr("disabled",true);
                    }  
                    if ($("#dni").val().trim().length < 8)
                    {                                        
                        $("#btnRegTrab").attr("disabled",true);
                        $("#dniMsg").text("Ingrese un DNI válido").css("color","#FF0000");
                    }
                }
            });            
        });
        
         $("#nro_guia").blur(function(){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'guia',
                    nombre: $("#nro_guia").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {                                                                        
                        $("#btn_control").attr("disabled",true);     
                        $("#msg_nro_guia").html("Esta guía no se encuentra registrada<br><a href='ct_registro_guia.php' target='_blank'>Registrar Guía</a>").css("color","#FF0000");
                    }else if (result == 1)
                    {
                        $("#msg_nro_guia").text("OK").css("color","#0000FF");
                        $("#btn_control").attr("disabled",false);
                    }                    
                }
            });
        });
        
        $("#nro_parte").blur(function(){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'parte',
                    nombre: $("#nro_parte").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {                                                                        
                        $("#btn_control").attr("disabled",false);                             
                        $("#nro_parteMsg").text("OK").css("color","#0000FF");
                    }else if (result == 1)
                    {
                        $("#nro_parteMsg").html("Ya se ha registrado un parte con este número<br><a href='ct_list_trabajo.php#"+$("#nro_parte").val()+"' target='_blank'>Revisar registro de parte diario</a>").css("color","#FF0000");                        
                        $("#btn_control").attr("disabled",true);
                    }
                    if ($("#nro_parte").val().trim().length == 0)
                    {
                        $("#nro_parteMsg").html("Debe ingresar un valor").css("color","#FF0000"); 
                        $("#nro_parte").focus();
                        $("#btn_control").attr("disabled",true);
                    }
                }
            });
        });
        
        $("#nro_vale").blur(function(){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'vale',
                    nombre: $("#nro_vale").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {                                                                        
                        $("#btn_control").attr("disabled",false);                             
                        $("#nro_valeMsg").text("OK").css("color","#0000FF");
                    }else if (result == 1)
                    {
                        $("#nro_valeMsg").html("Ya se ha registrado un vale con este número<br><a href='ct_list_combustible.php#"+$("#nro_vale").val()+"' target='_blank'>Revisar registro de vale de consumo</a>").css("color","#FF0000");                        
                        $("#btn_control").attr("disabled",true);
                    }  
                    if ($("#nro_vale").val().trim().length == 0)
                    {
                        $("#nro_valeMsg").html("Debe ingresar un valor").css("color","#FF0000"); 
                        $("#nro_vale").focus();
                        $("#btn_control").attr("disabled",true);
                    }
                }
            });
        });
        
        $("#nro_guiaReg").blur(function(){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'guia2',
                    nombre: $("#nro_guiaReg").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {   
                        $("#msg_nro_guiaReg").text("OK").css("color","#0000FF");
                        $("#btnRegGuia").attr("disabled",false);                        
                    }else if (result == 1)
                    {
                        $("#btnRegGuia").attr("disabled",true);     
                        $("#msg_nro_guiaReg").html("Esta guía ya se encuentra registrada<br><a href='ct_list_guias.php' target='_blank'>Revisar Guía</a>").css("color","#FF0000");
                    }else if (result == 2)
                    {
                        $("#btnRegGuia").attr("disabled",true);     
                        $("#msg_nro_guiaReg").html("Ingrese un número de guía").css("color","#FF0000");
                        $("#nro_guiaReg").focus();
                    }
                }
            });
        });
        
        $("#nro_placa").blur(function(){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'placa',
                    nombre: $("#nro_placa").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {                                                                        
                        $("#btnRegGuia").attr("disabled",true);     
                        $("#nro_placaMsg").html("No se ha encontrado un SURTIDOR con esta placa.<br><a href='adm_reg_vehiculo.php' target='_blank'>Registrar Veh&iacute;culo SURTIDOR</a>").css("color","#FF0000");
                    }else if (result == 1)
                    {
                        $("#nro_placaMsg").text("OK").css("color","#0000FF");
                        $("#btnRegGuia").attr("disabled",false);
                    }                    
                }
            });
        });
        
        $("#nro_licencia").blur(function(){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'licencia',
                    nombre: $("#nro_licencia").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {                                                                        
                        $("#btnRegGuia").attr("disabled",true);     
                        $("#nro_licenciaMsg").html("No se ha encontrado un OPERARIO con esta licencia.<br><a href='adm_registro_trabajador.php' target='_blank'>Registrar Trabajador</a>").css("color","#FF0000");
                    }else if (result == 1)
                    {
                        $("#nro_licenciaMsg").text("OK").css("color","#0000FF");
                        $("#btnRegGuia").attr("disabled",false);
                    }                    
                }
            });
        });
        
        $("#nro_licenciaReg").blur(function(){
            $("#btnRegTrab").attr("disabled",false);
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'licencia',
                    nombre: $("#nro_licenciaReg").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {                                                
                        $("#nro_licenciaRegMsg").html("OK").css("color","#0000FF");
                    }else if (result == 1)
                    {
                        $("#nro_licenciaRegMsg").html("Ya existe un OPERADOR con esta licencia.<br><a href='adm_list_trabajadores.php' target='_blank'>Ver Trabajador</a>").css("color","#FF0000");
                        $("#btnRegTrab").attr("disabled",true);
                    }                    
                }
            });
        });
        
        $("#nro_comprobanteReg").blur(function(){
            var request = $.ajax({
                method: 'post',
                url: '../../libraries/valida_nombre.php',
                data:{
                    event: 'comprobante',
                    nombre: $("#nro_comprobanteReg").val()
                },
                success:function(result){                    
                   if (result == 0)
                    {   
                        $("#nro_comprobanteRegMsg").text("OK").css("color","#0000FF");
                        $("#btnComprobReg").attr("disabled",false);                        
                    }else if (result == 1)
                    {
                        $("#btnComprobReg").attr("disabled",true);     
                        $("#nro_comprobanteRegMsg").html("Este comprobante ya se encuentra registrado<br><a href='ct_list_comprobantes.php' target='_blank'>Revisar Comprobantes</a>").css("color","#FF0000");
                    }else if (result == 2)
                    {
                        $("#btnComprobReg").attr("disabled",true);     
                        $("#nro_comprobanteRegMsg").html("Ingrese un número de comprobante").css("color","#FF0000");
                        $("#nro_comprobanteReg").focus();
                    }                   
                }
            });
        });
        
        $("#tipo_tabla").change(function (){
            //console.log($("#tipo_tabla").val());
            var request = $.ajax({
                method: 'get',
                url: '../../libraries/ajax_tipos.php',
                data:{
                    nombre:  $("#tipo_tabla").val()
                },
                success:function(result){                    
                    if (result == 0)
                    {                                                
                        $("#msg_tabla").text("Sin datos para mostrar.").css("color","#FF0000");
                        $("#tbl_tipos tbody").html("");
                    }else
                    {
                        $("#msg_tabla").text("");
                        $("#tbl_tipos tbody").html(result);                        
                    }                    
                }
            });
        });
        
        //----------------------datepicker
        //_-------------datepicker
    
        $.datepicker.regional['es'] = 
        {
            closeText: 'Cerrar', 
            prevText: 'Previo', 
            nextText: 'Próximo',

            monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
            'Julio','Agosto','Setiembre','Octubre','Noviembre','Diciembre'],
            monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun',
            'Jul','Ago','Set','Oct','Nov','Dic'],
            monthStatus: 'Ver otro mes', yearStatus: 'Ver otro año',
            dayNames: ['Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'],
            dayNamesShort: ['Dom','Lun','Mar','Mie','Jue','Vie','Sáb'],
            dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sa'],
            dateFormat: 'dd/mm/yy', firstDay: 0, 
            initStatus: 'Selecciona la fecha', 
            isRTL: false
        };
       $.datepicker.setDefaults($.datepicker.regional['es']);
        //-------------------------
        $(".fechas").datepicker({ // restrinccion de fecha actual
            changeMonth: true,
            changeYear: true,
            showOtherMonths: true,
            selectOtherMonths: true,
            maxDate: "+0M +0D",
            position: "bottom"
        });
        //-------------------------
        $(".fechas_v").datepicker({ // restrinccion de fecha actual
            changeMonth: true,
            changeYear: true,
            showOtherMonths: true,
            selectOtherMonths: true
        });
        $(".desdeFech").datepicker({            
            changeMonth: true,
            changeYear: true,
            numberOfMonths: 1,
            maxDate: "+0D",
            onClose: function( selectedDate ) {
              $( ".hastaFech" ).datepicker( "option", "minDate", selectedDate );
            }
        });
        $( ".hastaFech" ).datepicker({            
            changeMonth: true,
            changeYear: true,
            numberOfMonths: 1,
            maxDate: "+0D",
            onClose: function( selectedDate ) {
              $( ".desdeFech" ).datepicker( "option", "maxDate", selectedDate );
            }
       });
       // fecha actual por default
       $("#fecha_dev").datepicker("setDate", "+0D");
       $("#fecha_fin").datepicker("setDate", "+0D");
       $("#fecha_fin").datepicker("option",'minDate', $("#fecha_inicio_contrato").val());
       
       //--------------------PUPOP---------------------CLIENTES
       $('.openClientes').click(function(){
           var cliente = $(this).parents("tr:first").data("id");
           
           var request = $.ajax({
                method: 'post',
                url: '../../libraries/datos_cliente.php',
                data:{
                    cliente:  cliente
                },
                success:function(result){                    
                    if (result != null)
                    {          
                        var data = $.parseJSON(result);
                        console.log(data);
                        $('#popup').fadeIn('slow');
                        $('.popup-overlay').fadeIn('slow');
                        $('.popup-overlay').height($(window).height());                                                
                        
                        var datosCli = 
                                "<h2>"+data[0].nombre+"</h2>"+
                                "<h4>DNI/RUC: "+data[0].codigo+"</h4>"+
                                "<h4>DIRECCIÓN: "+data[0].direccion+"</h4>"+
                                "<h4>REGISTRO: "+data[0].f_registro+"</h4>"+
                                "<h4>TELÉFONO: "+data[0].telefono+"</h4>"+
                                "<h4>TIPO: "+data[0].tipocliente+"</h4>"+
                                "<h4 style='color: #FF0000'>Nro. CONTRATOS: "+data[0].nro_contratos+"</h4>";
                        $("#popup .content-popup #contenidoCliente").html(datosCli);
                        
                    }else
                    {
                        $("#popup .content-popup #contenidoCliente").html("Sin datos");
                    }                    
                }
            });            
            
            return false;
        });

        $('#close').click(function(){
            $('#popup').fadeOut('slow');
            $('.popup-overlay').fadeOut('slow');
            return false;
        });
       
       
    });
    </script>
    <script>        
        $(function (){
            var autocompletar = new Array();
            <?php 
            include '../../libraries/autocomplete.php';
            for ($i = 0; $i < count($arreglo); $i++) { ?>
                autocompletar.push('<?php echo $arreglo[$i]; ?>');
           <?php } ?>
           $("#trabajador").autocomplete({
               source: autocompletar
           });
        });
    </script>
    <script>
      $(document).ready(function(){
        var callAjax = function(){
          $.ajax({
            method:'get',
            url:'../../libraries/ajax_notificacion.php',
            success:function(data){
              $("#notifica").html(data);
            }
          });
        };        
        setInterval(callAjax,2000); // actualiza cada 1 min
      });
    </script>
    <!-- Notificacion emergente navegador -->
    <!-- script>
        //-------------------------------notificaciones--------------------------------------------
            $("#solicita").on("click", function() {
                if (Notification) {
                    Notification.requestPermission();
                }                
            });
            /*mostrar u ocultar boton de solicitud*/
            if (Notification.permission == 'granted')
            {
                document.getElementById('solicita').style.display = 'none';                
            }else
            {
                document.getElementById('solicita').style.display = 'block';
            }
            /*notificar*/
            $("#notifica1").on("load", function () {
                switch (Notification.permission)
                {
                    case "granted":            
                        var options = {
                            lang: "es-ES",
                            body: "Vehículo para mantenimineto.",
                            icon: "../img/logo_min.jpg"
                        };
                        var notif = new Notification("Piuramaq Alert!", options);
                        ion.sound.play("door_bump");
                        notif.onclick = function() {
                          window.location.href = "#";
                        };
                        setTimeout(notif.close, 5000);
                        break;
                    case "denied":
                        alert("Haga click en el Botón azul, para activar notificaciones");
                        break;
                    default:
                        alert("Haga click en el Botón azul, para activar notificaciones");
                        break;
                        }
            });
            
            //--------------------------fin-----notificaciones--------------------------------------------
            //----------------------------dsnidos--------------------------------------------
            ion.sound({
                sounds: [
                    {name: "door_bump"}
                ],
                volume: 0.5,
                path: "../resources/sounds/",
                preload: true
            });

            $("#son").on("click", function(){
                ion.sound.play("aplauso");
            });
            //--------------------------fin--donidos--------------------------------------------                      
    </script -->
    <script>
     $(document).ready(function(){
      $("#btnValoriza").click(function(){ 
          var id = $("#cliente_val").val();          
          var desde = $("#desde_val").val();
          var hasta = $("#hasta_val").val();
        $.post("../../libraries/LINK_valoriza.php",
        {
            id: id,
            desde: desde,
            hasta: hasta
        },        
        function(data, status){
            $("#link_valoriza").html(data);            
        });
    });
    //_---------------- exporta historial de maq
    $("#btnHistorial").click(function(){ 
          var id = $("#maq").val();          
          var desde = $("#desde_val").val();
          var hasta = $("#hasta_val").val();
        $.post("../../libraries/LINK_historial_maq.php",
        {
            id: id,
            desde: desde,
            hasta: hasta
        },        
        function(data, status){
            $("#link_historial").html(data);            
        });
    });
    //-------- Exportar guias
    $("#btnExportaGuia").click(function(){           
          var desde = $("#desde_val").val();
          var hasta = $("#hasta_val").val();
        $.post("../../libraries/LINK_exportar_excel.php",
        {
            event: 'guia',
            desde: desde,
            hasta: hasta
        },        
        function(data, status){
            $("#link_exportar").html(data);            
        });
    });
    
    $("#desde_val").focus(function(){
        $("#linkValPDF").css("display","none");
        $("#linkValXLS").css("display","none");
        $("#linkValXLS_all").css("display","none");
        $("#link_hist").css("display","none");
        $("#btnExportaGuias").css("display","none");
    });
    
    $("#hasta_val").focus(function(){
        $("#linkValPDF").css("display","none");
        $("#linkValXLS").css("display","none");
        $("#linkValXLS_all").css("display","none");
        $("#link_hist").css("display","none");
        $("#btnExportaGuias").css("display","none");
    });
    
    $("#btnResetVal").click(function(){
        $("#desde_val").focus();
        $("#linkValPDF").css("display","none");
        $("#linkValXLS").css("display","none");
        $("#linkValXLS_all").css("display","none");
        $("#btnExportaGuias").css("display","none");
        $("#link_hist").css("display","none");
        $("#divGuiasFech").css("display","none");        
    });
    
    $("#btnRendimiento").click(function(){ 
          var id = $("#vehiculo_rend").val();          
          var desde = $("#desde_rend").val();
          var hasta = $("#hasta_rend").val();
        $.post("../../libraries/LINK_rendimiento.php",
        {
            id: id,
            desde: desde,
            hasta: hasta
        },        
        function(data, status){
            $("#link_rendimiento").html(data);            
        });
    });
    
    });
    </script>
</body>

</html>