<?php 
require_once '../../Config.inc.php'; 
require_once '../../configuration/Funciones.php'; 
session_start();
if (empty($_SESSION['sessionID']))
{
    header("Location: ../");
}
?>
<!DOCTYPE html>
<html lang="es-ES">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Alquiler de maquinarias">
    <meta name="author" content="hcr">
    
    <link rel="shortcut icon" href="../img/favicon.ico" />

    <title>Piuramaq s.r.l. ( <?php echo $_SESSION['tipo_usuario']; ?> )</title>

    <!-- Bootstrap Core CSS -->
    <link href="../bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="../bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">
    
    <!-- DataTables CSS -->
    <link href="../bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet">
    
    <!-- DataTables Responsive CSS -->
    <link href="../bower_components/datatables-responsive/css/dataTables.responsive.css" rel="stylesheet">

    <!-- Timeline CSS -->
    <link href="../dist/css/timeline.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet">
    
    <link href="../dist/css/jquery-ui.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <!--link href="../bower_components/morrisjs/morris.css" rel="stylesheet"-->

    <!-- Custom Fonts -->
    <link href="../bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <style>
        .btn1{
                font-family: 'Jura', sans-serif;
                font-size: 1em;
                padding: 1em 1em;
                margin: 2em 0;
                background-color: #f7f7f7;
                background-color: #000028;
                color: #f7f7f7;
                border: none;
                -webkit-transition:all 0.4s;
        }
        .btn1:hover{
                background-color: #f7f7f7;
                color: #222;
                cursor: pointer;
        }
        
        /*ESTILOS PUPOP*/
        #popup {
            left: 0;
            position: absolute;
            top: 0;
            width: 100%;
            z-index: 1001;
        }

        .content-popup {
            margin:0px auto;
            margin-top:120px;
            position:relative;
            padding:10px;
            width:50%;
            min-height:250px;
            border-radius:4px;
            background-color:#C5DFE6;
            box-shadow: 0 2px 5px #666666;
        }

        .content-popup h2 {
            color:#48484B;
            border-bottom: 1px solid #48484B;
            margin-top: 0;
            padding-bottom: 4px;
        }

        .popup-overlay {
            left: 0;
            position: absolute;
            top: 0;
            width: 100%;
            z-index: 999;
            display:none;
            background-color: #777777;
            cursor: pointer;
            opacity: 0.7;
        }

        .close {
            position: absolute;
            right: 15px;
        }
        
        @media(max-width:475px) {
            .content-popup {
                width:90%;
            }
        }
    </style>
    
    
    <script language="Javascript">
    function preguntar(){
       salir=confirm("¿Seguro que desea salir?");
       //Redireccionamos si das a aceptar
       if (salir)       
         window.location.href = "../../app/router.php?event=<?php echo Funciones::encodeStrings('off',2); ?>"; 

    }
    </script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->   
    
</head>
<body>
    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.php">Piuramaq S.R.L.</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">                
                <!-- /.dropdown -->
                <li id="notifica" class="dropdown">
                    
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <?php echo $_SESSION['apenom']; ?> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li>
                            <?php if($_SESSION['tipo_usuario'] == 'SA') { ?>
                            <a href="../sa/panel.php">
                            <?php }else{ ?>
                                <a href="">
                            <?php } ?>
                                <i class="fa fa-user fa-fw"></i> 
                                    <?php echo $_SESSION['apenom']; ?>
                            </a>
                        </li>
                        <li>
                            <a href="config_user.php"><i class="fa fa-gear fa-fw"></i> <?php echo "NIVEL "." [".$_SESSION['tipo_usuario']."]"; ?></a>
                        </li>
                        
                        <li class="divider"></li>
                        <li>
                            <a href="javascript:preguntar()"> 
                                <i class="fa fa-sign-out fa-fw"></i> 
                                Cerrar Sesi&oacute;n
                            </a>                            
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->                        

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <?php include 'menu.php';  ?>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>