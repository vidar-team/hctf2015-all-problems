<?php
    require_once "header.php";
    require_once "config/config.inc.php";
    require_once "config/common.php";

if (!isset($_SESSION['isLogin'])) {
    echo '<script>alert("请先登录");</script>';
    exit;
}

$id = $_SESSION['id'];
$sql = "SELECT * FROM mcshop_user WHERE id='$id'";
$result = $dbConn->query($sql);
$row = $result->fetch_assoc();

$bank = $row['bank'];
if ($bank < 50000) {
    echo '<script>alert("抱歉，您的余额不足50000RMB，请先充值:)")</script>';
    exit;
}

if (!isset($_POST['p'])) {
    header('Location: 404.html');
    exit;
}

$p = SqlGuard($_POST['p'], $dbConn);
$server_name = 'server-'.$p;

// 取出该服务器的相关信息
$sql = "SELECT * FROM server_list WHERE server_name = '$server_name'";
$result = $dbConn->query($sql);
if ($result->num_rows != 1) {
    header('Location: 404.html');
    exit;
}
$server_info = $result->fetch_assoc();
//print_r($_SESSION);

// 插入到购物车表中
// 检查该用户购物车中是否有此商品
$uid = $_SESSION['id'];
$username = $_SESSION['username'];
$server_id = $server_info['id'];
$price = $server_info['price'];

$sql = "SELECT * FROM cart WHERE uid='$uid' AND server_id = '$server_id'";
$result = $dbConn->query($sql);
if ($result->num_rows == 1) {
    // 已经有了，update即可
    $sql = "UPDATE cart SET `cnt` = `cnt` + 1, sum_price = sum_price + $price WHERE uid='$id' AND server_id='$server_id'";
    //echo $sql;
    $result = $dbConn->query($sql);
} else {
    // 还没有，insert进去
    $sql = "INSERT INTO cart VALUES ('', '$uid', '$username', '$server_id', '$price', '1', '$price');";
    $result = $dbConn->query($sql);
}

// 修改服务器可用余量
if ($server_info['left_number'] < 1) {
    echo '<script>alert("服务器余量不足，添加到购物车失败:(");</script>';
    exit;
}
$sql = "UPDATE server_list SET inuse_number=inuse_number+1,left_number=left_number-1 WHERE id='$server_id'";
$result = $dbConn->query($sql);

if ($result) {
    echo '<script>alert("添加成功！");</script>';
    exit;
} else {
    echo '<script>alert("添加失败！原因未知！");</script>';
    exit;
}



    require_once "footer.php";

