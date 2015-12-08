<?php

require_once 'config/config.inc.php';
session_start();
$uid = $_SESSION['id'];


$sql = "DELETE FROM cart WHERE uid='$uid'";
$result = $dbConn->query($sql);

echo '<script>alert("清空购物车成功!");</script>';
header('Refresh:0.1;url=mycart.php');
exit;