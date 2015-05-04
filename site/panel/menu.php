<ul class="nav" id="side-menu">
    <li>
        <a href="./"><i class="fa fa-dashboard fa-fw"></i> Inicio</a>
    </li>        
    
    <?php if ($_SESSION['tipo_usuario'] == $config['typeUserAdmin']) { ?>    
    <!-- SOLO ADMINISTRADOR -->
    <li>
        <a href="#">
            <i class="fa fa-steam fa-fw"></i> Tipos<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">
            <li>
                <a href="adm_reg_tipos.php"><i class="fa fa-plus fa-fw"></i> Registro de Tipos</a>
            </li>
            <li>
                <a href="adm_list_tipos.php"><i class="fa fa-book fa-fw"></i> Tipos registrados</a>
            </li>
        </ul>
    </li>    
    <li>
        <a href="#">
            <i class="fa fa-group fa-fw"></i> Trabajador<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">
            <li>
                <a href="adm_registro_trabajador.php"><i class="fa fa-edit fa-fw"></i> Registro de trabajador</a>
            </li>
            <li>
                <a href="adm_list_trabajadores.php"><i class="fa fa-edit fa-fw"></i> Trabajadores registrados</a>
            </li>
        </ul>
    </li>                
    
    <!-- SOLO ADMINISTRADOR -->
    <li>
        <a href="#">
            <i class="fa fa-briefcase fa-fw"></i> Clientes<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">            
            <li>
                <a href="adm_registro_cliente.php"><i class="fa fa-edit fa-fw"></i> Registro de nuevo cliente</a>
            </li>
            <li>
                <a href="adm_list_clientes.php"><i class="fa fa-edit fa-fw"></i> Clientes registrados</a>
            </li>            
        </ul>
    </li>
    <?php } ?> 
    
    <li>
        <a href="#">
            <i class="fa fa-pencil fa-fw"></i> Contratos<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">
            <?php if ($_SESSION['tipo_usuario'] == $config['typeUserAdmin']) { ?>
            <!-- SOLO ADMINISTRADOR -->
            <li>
                <a href="adm_list_contratos.php"><i class="fa fa-pencil-square-o fa-fw"></i> Contratos registrados</a>
            </li> 
            <?php } ?>
            <li> <!-- para controladores -->
                <a href="ct_list_clientes.php"><i class="fa fa-male fa-fw"></i> Contratos Activos</a>
            </li>
        </ul>
        
    </li>
    <li>
        <a href="#">
            <i class="fa fa-truck fa-fw"></i> Maquinaria<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">
            <?php if ($_SESSION['tipo_usuario'] == $config['typeUserAdmin']) { ?>
            <!-- SOLO ADMINISTRADOR -->
            <li>
                <a href="adm_reg_vehiculo.php"><i class="fa fa-edit fa-fw"></i> Registro de maquinaria</a>
            </li>            
            <li>
                <a href="adm_list_vehiculos.php"><i class="fa fa-edit fa-fw"></i> Listado de maquinaria</a>
            </li>
            <?php } ?>
            <li>
                <a href="ct_list_vehiculos.php"><i class="fa fa-truck fa-fw"></i> Mantenimiento/Reparaci&oacute;n</a>
            </li>
        </ul>
        
    </li>
    <li>
        <a href="#">
            <i class="fa fa-th fa-fw"></i> Art&iacute;culos<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">
            <?php if ($_SESSION['tipo_usuario'] == $config['typeUserAdmin']) { ?>
            <!-- SOLO ADMINISTRADOR -->
            <li>
                <a href="adm_reg_articulos.php"><i class="fa fa-edit fa-fw"></i> Registro de art&iacute;culos</a>
            </li>
            <?php } ?>
            <li>
                <a href="adm_list_articulos.php"><i class="fa fa-edit fa-fw"></i> Listado de art&iacute;culos</a>
            </li>
        </ul>
        
    </li>
    
    <li>
        <a href="#">
            <i class="fa fa-bars fa-fw"></i> Abastecimiento<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">
            <li>
                <a href="ct_registro_guia.php"><i class="fa fa-edit fa-fw"></i> Registro de gu&iacute;as</a>
            </li>
            <li>
                <a href="ct_registro_comprobante.php"><i class="fa fa-edit fa-fw"></i> Registro de comprobantes</a>
            </li>
            <li>
                <a href="ct_abastecimiento_vh.php"><i class="fa fa-edit fa-fw"></i> Consumo de veh&iacute;culos</a>
            </li>
            <li>
                <a href="ct_list_guias.php"><i class="fa fa-edit fa-fw"></i> Listado de gu&iacute;as</a>
            </li>
            <li>
                <a href="ct_list_comprobantes.php"><i class="fa fa-edit fa-fw"></i> Listado de comprobantes</a>
            </li>            
            <li>
                <a href="ct_list_vale_comb.php"><i class="fa fa-edit fa-fw"></i> Listado de vale de combustible</a>
            </li>
        </ul>                 
    </li>
    <li>
        <a href="#">
            <i class="fa fa-book fa-fw"></i> Historial de Registro<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">
            <li>
                <a href="ct_list_combustible.php"><i class="fa fa-book fa-fw"></i> Control de combustible</a>
            </li>
            <li>
                <a href="#"> Partes diarios<span class="fa arrow"></span></a>
                <ul class="nav nav-third-level">
                    <li>
                        <a href="ct_list_trabajo.php"> Todo</a>
                    </li>
                    <li>
                        <a href="ct_historial_por_contrato.php"> Por Contrato</a>
                    </li>
                    <li>
                        <a href="ct_historal_entre_fechas.php"> Entre Fechas</a>
                    </li>
                </ul>
            </li>
        </ul>        
    </li>
    <li>
        <a href="#">
            <i class="fa fa-exchange fa-fw"></i> Asignaci&oacute;n de Gu&iacute;as<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">
            <li>
                <a href="ct_asigna_fech.php"><i class="fa fa-calendar fa-fw"></i> Asignaci&oacute;n r&aacute;pida</a>
            </li> 
            <li>
                <a href="ct_asigna_check.php"><i class="fa fa-check-square-o fa-fw"></i> Asignaci&oacute;n personalizada</a>
            </li> 
        </ul>
    </li>
       
    <li>
        <a href="#">
            <i class="fa fa-th-list fa-fw"></i> Reportes<span class="fa arrow"></span>
        </a>
        <ul class="nav nav-second-level">
            <li>
                <a href="REP_valorizacion.php"><i class="fa fa-edit fa-fw"></i> Valorizaci&oacute;n acumulada</a>
            </li>
            <?php if ($_SESSION['tipo_usuario'] == $config['typeUserAdmin']) { ?>
            <!-- SOLO ADMINISTRADOR -->
            <li>
                <a href="REP_consumo_contrato.php"><i class="fa fa-edit fa-fw"></i> Consumo por obra</a>
            </li>
            <?php } ?>
        </ul>
        
    </li> 
    
    <li>
        <a href="adm_list_obras.php">
            <i class="fa fa-cubes fa-fw"></i> Obras Registradas<span class="fa arrow"></span>
        </a>        
    </li>
    
    <li>
        <a href="logs.php">
            <i class="fa fa-eye fa-fw"></i> Registro de actividades<span class="fa arrow"></span>
        </a>        
    </li>
</ul>   
