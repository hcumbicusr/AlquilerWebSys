<?php
include '../Config.inc.php';
if (empty($_POST))
{ ?>
<script>
    setInterval(window.location.href = '../',0);
</script>
<?php }

$event = $_POST['event'];
$actual = md5($_POST['actual']);
$nueva = md5($_POST['nueva']);
$nueva_r = md5($_POST['nueva_r']);

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
session_start();

switch ($event) {
    case 'clave':
        $query = "SELECT COUNT(*) as n FROM usuario WHERE id_usuario = ".$_SESSION['id_usuario']." AND clave = '$actual'";
        //die(var_dump($query));
        $result = $objDB->selectManager()->select($con, $query);
        //die(var_dump(intval($result[0]['n'])));
        echo intval($result[0]['n']);
        break;
    case 'igual':
        if (trim($nueva) == trim($nueva_r))
            echo 1;
        else
            echo 0;
        break;
    case 'save':
        $query = "UPDATE usuario SET f_modificacion = now(), cambio_clave = 1, clave = '$nueva_r' WHERE id_usuario = ".$_SESSION['id_usuario']." AND clave = '$actual'";
        $result = $objDB->selectManager()->update($con, $query);
        $query2 = "SELECT count(*) as n FROM usuario WHERE id_usuario = ".$_SESSION['id_usuario']." AND clave = '$nueva_r'";
        $result2 = $objDB->selectManager()->select($con, $query2);                
        
        echo intval($result2[0]['n']);;
        break;
}