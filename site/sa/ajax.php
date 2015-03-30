<?php
include '../../Config.inc.php';
if (empty($_POST))
{ ?>
<script>
    setInterval(window.location.href = '../',0);
</script>
<?php }

$event = $_POST['event'];

$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
session_start();

switch ($event) {
    case 'sql_select':        
        $query = $_POST['sql'];   
        if (strtoupper(substr(trim($query), 0, 6)) == 'SELECT'){
            // $result = $objDB->selectManager()->select($con, $query);
            $result = select($con, $query);
            echo json_encode($result);
        }else
        {            
            echo 0;
        }
        break;    
}
function select($con,$query){          
    $consult = $con->query($query);  
    $data = NULL;
    if ($consult != NULL)
    {
        while($row = mysqli_fetch_assoc($consult))
        {
            $data[] = $row;
        }
    }
    return $data;
}