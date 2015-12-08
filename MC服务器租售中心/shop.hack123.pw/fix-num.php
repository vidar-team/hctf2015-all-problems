<?php
require_once "header.php";
require_once "config/config.inc.php";
require_once "config/common.php";
?>

<?php

if (!isset($_GET['a'], $_GET['t'], $_GET['n']) || $_GET['a'] == '' || $_GET['t'] == '') {
    header('Location: 404.html');
    exit;
}

// 获取数据
$act = SqlGuard($_GET['a'], $dbConn);
$t = SqlGuard($_GET['t'], $dbConn);
if (!isset($_GET['n'])) {
    $n = 1;
} else {
    $n = (int)SqlGuard($_GET['n'], $dbConn);
}
$uid = $_SESSION['id'];

// 判断操作类型
if ($act == 'a') {
    // add to cart
    // 检查购物车中是否有这个产品，检查输入是不是负数
    $sql = "SELECT * FROM cart WHERE uid='$uid' AND server_id='$t'";
    $result = $dbConn->query($sql);
    // 有则添加，没有就404
    if ($result->num_rows != 1) {
        // 没有
        header('Location: 404.html');
        exit;
    } else {
        // 有这个东西，进行数据检查
        if ($n <= 0) {
            header('Location: 404.html');
            exit;
        }

        // 更新服务器余量
        // 检查余量是否充足
        $sql = "SELECT * FROM server_list WHERE id='$t'";
        $result = $dbConn->query($sql);
        $server_info = $result->fetch_assoc();

        if ($server_info['left_number'] < $n) {
            echo '<script>alert("服务器余量不足~")</script>';
            header('Refresh:0.1;url=mycart.php');
            exit;
        }

        // 更新服务器余量
        $sql = "UPDATE server_list SET inuse_number=inuse_number+'$n',left_number=left_number-'$n' WHERE id='$t'";
        $result = $dbConn->query($sql);

        // 修改购物车
        $sql = "UPDATE cart SET cnt = cnt + '$n', sum_price = sum_price + '$n'*price WHERE server_id='$t' AND uid='$uid'";
        $result = $dbConn->query($sql);

        echo '<script>alert("修改成功");</script>';
        echo '<!-- 这购物车谁写的。。太烂了。。 -->';
        header('Refresh:0.1;url=mycart.php');
        exit;
    }

} else if ($act == 's') {
    // sub from cart
    // 检查购物车中是否有这个商品，留坑：不检查输入数据
    $sql = "SELECT * FROM cart WHERE uid='$uid' AND server_id='$t'";
    $result = $dbConn->query($sql);
    // 有则删除，没有就404
    if ($result->num_rows != 1) {
        // 购物车里没有
        header('Location: 404.html');
        exit;
    } else {
        // 购物车里有
        // 检查数据完整性，减掉比0小就404
        $row = $result->fetch_assoc();
        $oldCnt = $row['cnt'];
        if ($oldCnt - $n < 0) {
            header('Location: 404.html');
            exit;
        } else if ($oldCnt - $n == 0) {
            $sql = "DELETE FROM cart WHERE uid='$uid' AND server_id='$t'";
            $result = $dbConn->query($sql);
        } else {
            $n = $_GET['n'];
			$pattern = '/ifnull|substr|or|and|benchmark/i';
			$n = preg_replace($pattern, 'aa', $n);
            $sql = "UPDATE cart SET cnt = cnt - '$n', sum_price = sum_price - '$n'*price WHERE server_id='$t' AND uid='$uid'";
            $result = $dbConn->query($sql);
			//echo mysqli_error($dbConn);
			//echo '<br/>'.$sql;
        }

        // 更新服务器余量
        // t - server_id
        // n - count
        $n = SqlGuard($_GET['n'], $dbConn);
        $sql = "UPDATE server_list SET inuse_number=inuse_number-'$n',left_number=left_number+'$n' WHERE id='$t'";
        $result = $dbConn->query($sql);

        echo '<script>alert("删除成功！");</script>';
        header('Refresh:0.1;url=mycart.php');
        exit;
    }
} else {
    header('Location: 404.html');
}
?>

<?php
require_once "footer.php";
?>
