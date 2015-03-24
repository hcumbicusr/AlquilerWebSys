<?php 
session_start();
if (!empty($_SESSION))
{
    header("Location: site/panel/");
}
?>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="es-ES"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
	<meta charset="utf-8" />
	<title>Piuramaq s.r.l. | Acceso</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<meta content="Alquiler de maquinarias" name="description" />
	<meta content="hcr" name="author" />
	<!-- BEGIN GLOBAL MANDATORY STYLES -->
	<link href="site/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="site/assets/plugins/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
        <link href="site/assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<link href="site/assets/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="site/assets/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="site/assets/css/style-responsive.css" rel="stylesheet" type="text/css"/>
        
	<!-- END GLOBAL MANDATORY STYLES -->
	<!-- BEGIN PAGE LEVEL STYLES -->
	<link href="site/assets/css/pages/login-soft.css" rel="stylesheet" type="text/css"/>
	<!-- END PAGE LEVEL STYLES -->
        <link rel="shortcut icon" href="site/img/favicon.ico" />
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="login">
	<!-- BEGIN LOGO -->
	<div class="logo">
		<!-- PUT YOUR LOGO HERE -->
                <img src="site/assets/img/logo.jpg" alt="Piuramaq s.r.l.">
	</div>
	<!-- END LOGO -->
	<!-- BEGIN LOGIN -->
	<div class="content">
		<!-- BEGIN LOGIN FORM -->
		<form class="form-vertical login-form" action="app/router.php" method="post">
                    <h3 class="form-title" style="font-weight: bold">Acceso</h3>
			<div class="alert alert-error hide">
				<button class="close" data-dismiss="alert"></button>
                                <span>Ingrese su usuario y contrase&ntilde;a</span>
			</div>
			<div class="control-group">
				<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
				<label class="control-label visible-ie8 visible-ie9">Usuario</label>
				<div class="controls">
					<div class="input-icon left">
						<i class="icon-user"></i>
                                                <input class="m-wrap placeholder-no-fix" type="text" autocomplete="off" placeholder="Usuario" name="username" autofocus/>
					</div>
				</div>
			</div>
			<div class="control-group">
                            <label class="control-label visible-ie8 visible-ie9">Contrase&ntilde;a</label>
				<div class="controls">
					<div class="input-icon left">
						<i class="icon-lock"></i>
						<input class="m-wrap placeholder-no-fix" type="password" autocomplete="off" placeholder="Contrase&ntilde;a" name="password"/>
					</div>
				</div>
			</div>
			<div class="form-actions">
				<button type="submit" class="btn blue pull-right">
				Ingresar <i class="m-icon-swapright m-icon-white"></i>
				</button>            
			</div>
                        
                        <?php if (!empty($_GET['msj'])) { ?>
                        <div class="warning" style="color: #FF0000; font-weight: bold; font-size: 17px">
                            <?php 
                            require_once 'configuration/Funciones.php'; 
                            echo Funciones::decodeStrings($_GET['msj'], 2);
                            ?>
                        </div>
                        <?php } ?>
                        
		</form>
		<!-- END LOGIN FORM -->		
	</div>
	<!-- END LOGIN -->
	<!-- BEGIN COPYRIGHT -->
	<div class="copyright">
            2015 &copy; <a href="http://www.piuramaq.com/" target="_blank">Piuramaq S.R.L.</a> Alquiler de maquinarias
	</div>
	<!-- END COPYRIGHT -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<!-- BEGIN CORE PLUGINS -->   <script src="site/assets/plugins/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="site/assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
	<script src="site/assets/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="site/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	
	<!--[if lt IE 9]>
	<script src="site/assets/plugins/excanvas.min.js"></script>
	<script src="site/assets/plugins/respond.min.js"></script>  
	<![endif]--> 
        
	<!-- END CORE PLUGINS -->
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script src="site/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript"></script>
	<script src="site/assets/plugins/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="site/assets/plugins/select2/select2.min.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="site/assets/scripts/app.js" type="text/javascript"></script>
	<script src="site/assets/scripts/login-soft.js" type="text/javascript"></script>      
	<!-- END PAGE LEVEL SCRIPTS --> 
	<script>
		jQuery(document).ready(function() {     
		  App.init();
		  Login.init();
		});
	</script>
	<!-- END JAVASCRIPTS -->	
</body>
<!-- END BODY -->
</html>