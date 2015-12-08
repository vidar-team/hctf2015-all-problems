<?php
require_once "header.php";
require_once "config/config.inc.php";
require_once "config/common.php";
?>

<?php
    $uid = $_SESSION['id'];
    $username = $_SESSION['username'];

    function getCartSumPrice($uid, $dbConn) {
        $sql = "SELECT * FROM cart WHERE uid='$uid'";
        $result = $dbConn->query($sql);
        if ($result->num_rows == 0) {
            echo '0';
        } else {
            $sum = 0;
            while ($row = $result->fetch_assoc()) {
                $sum = $sum + $row['sum_price'];
            }
            echo $sum;
        }

    }
?>

<div class="container">
    <div class="row clearfix">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-10 column">
            <div class="page-header">
                <h1>
                    您的购物车 <small>总金额 <?php getCartSumPrice($uid,$dbConn);?> RMB</small>
                </h1>
            </div>
            <table class="table">
                <thead>
                <tr>
                    <th>
                        产品名称
                    </th>
                    <th>
                        配置
                    </th>
                    <th>
                        单价
                    </th>
                    <th>
                        数量
                    </th>
                    <th>
                        操作
                    </th>
                    <th>
                        总价
                    </th>
                </tr>
                </thead>
                <tbody>
                <?php

                $sss = array();

                $sql = "SELECT * FROM (SELECT * FROM `cart` WHERE uid='$uid')a JOIN (SELECT * FROM `server_list`)b ON a.server_id=b.id";
                $result = $dbConn->query($sql);

                while ($row = $result->fetch_assoc()) {
                    echo '<tr>';
                    echo '<th id="'.$row['server_name'].'">'.$row['server_name'].'</th>';
                    echo '<th>'.$row['cpu'].'核，内存'.$row['memory'].'GB，SSD：'.($row['ssd']?'是':'否').'</th>';
                    echo '<th>'.$row['price'].'</th>';
                    echo '<th>'.$row['cnt'].'</th>';
                    echo '<th><a href="fix-num.php?a=a&n=1&t='.$row['server_id'].'" id="fix-add">+</a>&nbsp;&nbsp;&nbsp;&nbsp;';
                    echo '<a href="fix-num.php?a=s&n=1&t='.$row['server_id'].'" id="fix-sub">-</a></th>';
                    echo '<th>'.$row['sum_price'].'</th>';
                    echo '</tr>';
                    $server_id = $row['server_id'];
                    $sss["$server_id"]['count'] = $row['cnt'];
                    $sss["$server_id"]['sum_price'] = $row['sum_price'];
                    $_SESSION['cart'] = $sss;
                }
                #print_r($_SESSION['cart']);

                ?>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary" id="buycart">购买</button>
            <button type="button" class="btn btn-danger" id="clearcart">清空</button>
        </div>
        <div id="cart-result" class="col-md-1 column">
        </div>
    </div>
</div>

<?php
require_once "footer.php";
?>
