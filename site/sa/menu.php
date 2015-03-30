<?php
$objDB = new Class_Db();
$con = $objDB->selectManager()->connect();
$query = "SELECT * FROM INFORMATION_SCHEMA.tables WHERE TABLE_SCHEMA = '".$config['nameDataBase']."'";
$tablas = $objDB->selectManager()->select($con, $query);
//echo substr("SELECT--*", 0, 6);
// die(var_dump($tablas));
?>
<ul class="nav" id="side-menu">
    <li>
        <a href="panel.php"><i class="fa fa-dashboard fa-fw"></i> Tablas <?php echo $config['nameDataBase']."(".count($tablas).")"; ?> </a>
    </li>
    <?php for($i=0;$i<count($tablas);$i++){ ?>
    <li>
        <a href="#">
            <i class="fa fa-table fa-fw"></i> <?php echo $tablas[$i]['TABLE_NAME']; ?><span class="fa arrow"></span>
        </a>
        <?php 
        $con = $objDB->selectManager()->connect();
        $query = "DESCRIBE ".$tablas[$i]['TABLE_NAME'];
        $campos = $objDB->selectManager()->select($con, $query);
        ?>
        <ul class="nav nav-second-level">
            <?php for($j=0;$j<count($campos); $j++){ ?>
            <li>
                <a href="#"><i class="fa fa-columns fa-fw"></i> <?php echo $campos[$j]['Field']." ".$campos[$j]['Type'].""; ?></a>
            </li>            
            <?php } ?>
        </ul>
    </li>
    <?php } ?>
</ul>   
