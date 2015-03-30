</div>
<footer>
    <center>
        <div class="copyright">
            &copy; Admin <a href="https://twitter.com/hcumbicusr" target="_blank">@hcumbicusr</a>
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
    
    <!-- Page-Level Demo Scripts - Tables - Use for reference Andrea Stephani Cárdenas Hernández -->
    <script>
        $(document).ready(function(){            
            $("#msg_sql").css("display","block");  
            $('#img').hide();            
            $("#btnSql_select").click(function(){
                $('#img').show();
                $('#tbl thead').text("");
                $('#tbl tbody').text("");
                var request = $.ajax({
                method: 'post',
                url: 'ajax.php',
                data:{
                    event: 'sql_select',
                    sql: $("#sql_select").val().trim()
                },
                success:function(result){                    
                    $('#img').hide();
                    if (result != 0)
                    {                        
                        $("#msg_sql").text(""); 
                        generarTabla(result);
                    }else
                    {
                        $("#msg_sql").text("Consulta no válida"); 
                    }
                }
            });
        });
        function generarTabla(datos) {
            if( datos != '' ) {
              var i;
              var valores = '';
              valores = JSON.parse(datos);
              var atributos = new Array();              
              if( valores.length > 0 ) {
                for( var aux in valores[0] )
                  atributos.push(aux);
              }
              //alert(valores[0].atributos[0]);
              var tabla = '';
              tabla = $('#tbl');
              var head = '';              
              head = $('#tbl thead').css('text-transform', 'capitalize');
              var trt = '';
              trt = '<tr>';
              for( i = 0; i < atributos.length; i++) {
                trt += '<td>' + atributos[i] + '</td>';
              }
              trt += '</tr>';
              head.append(trt);
              var tbody = '';
              tbody = $('#tbl tbody');   
              var tr = '';
              for(i = 0; i < valores.length; i++ ) {   
                  tr += '<tr>';
                for(j = 0; j < atributos.length; j++ ){                    
                    tr += '<td>' + eval('valores[i].' + atributos[j]) + '</td>';                    
                }
                tr += '</tr>';                
              }
              tbody.append(tr);
            }
          }

    });
    </script>
</body>

</html>