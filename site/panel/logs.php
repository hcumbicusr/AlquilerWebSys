<?php include '00header.php'; ?>
<div id="page-wrapper">
    <div class="row">
        <?php if ($_SESSION['tipo_usuario'] != $config['typeUserAdmin']) { ?>
        <label style="font-size: 25px; color: #FF0000; margin-left: 50px">
            Secci&oacute;n disponible solo para el administrador del sistema !!
        </label>
        <script>           
            setInterval(function(){ window.location.href = "./"; window.close(); },3000);            
        </script>
        <?php } ?>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Registro de actividad en el sistema</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <?php
                    $query = "SELECT
                        r.`id`,
                        r.`fecha`,
                        u.nombre as usuario,
                        concat(t.apellidos,', ',
                        t.nombres) as nombre,
                        r.`accion`,
                        r.`tablas_afectadas`,
                        r.`ip_cliente`,
                        r.`nav_cliente`,
                        r.`so_cliente`
                        FROM regs r
                        INNER JOIN usuario u ON r.id_usuario = u.id_usuario
                        INNER JOIN trabajador t ON u.id_trabajador = t.id_trabajador
                        ORDER BY r.fecha DESC, t.apellidos";
                    $objDB = new Class_Db();
                    $con = $objDB->selectManager()->connect();
                    $select = $objDB->selectManager()->select($con, $query);
                    //die(var_dump($select));
                    ?>
                </div>                
                <div class="panel-body table-responsive">
                    <div class="dataTable_wrapper">
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Nro</th>                                                                                                          
                                    <th>Fecha</th>
                                    <th>Usuario</th>
                                    <th>Nombre</th>
                                    <th>Acci&oacute;n</th>
                                    <th>IP</th>                                                                       
                                    <th>Navegador</th>
                                    <th>Sistema Op.</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                for ($i = 0; $i < count($select); $i++)
                                {
                                 ?>     
                                <tr>
                                    <td><?php echo $i+1; ?></td>                
                                    <td><?php echo $select[$i]['fecha']; ?></td>
                                    <td><?php echo $select[$i]['usuario']; ?></td>
                                    <td><?php echo $select[$i]['nombre']; ?></td>        
                                    <td><?php echo $select[$i]['accion']; ?></td>
                                    <td><?php echo $select[$i]['ip_cliente']; ?></td>                                  
                                    <td><?php echo $select[$i]['nav_cliente']; ?></td>
                                    <td><?php echo $select[$i]['so_cliente']; ?></td>                                          
                                </tr>
                               <?php } ?>
                            </tbody>
                        </table>                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '00footer.php'; ?>