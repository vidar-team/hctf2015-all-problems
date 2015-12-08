<?php
require_once 'header.php';
require_once 'config/config.inc.php';
require_once 'config/common.php';
if (!isset($_SESSION['auth1'], $_SESSION['auth2'])) {
    header('Location: 404.html');
}
?>
<!-- debug.php?server_name=&cnt=  -->

<?php
$server_name = $_GET['server_name'];
$cnt = $_GET['cnt'];
$list = array('a','b','c','d','e','f');

if (!in_array($server_name, $list)) {
	exit;
}
$server_name = SqlGuard(trim($server_name), $dbConn);
$cnt = intval(SqlGuard(trim($cnt), $dbConn));

if ($server_name == '' || $cnt == '' || $cnt <= 0) {
	exit;		
}

$sql = "UPDATE server_list SET sum_number=sum_number+$cnt, left_number=sum_number-inuse_number WHERE server_name='server-$server_name'";
$result = $dbConn->query($sql);
if (!$result) {
	exit;
} else {
	echo 'got!';
}

?>

<?php
require_once 'footer.php';
?>
