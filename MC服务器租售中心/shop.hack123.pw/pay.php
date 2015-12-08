<?php
include_once "header.php";
require_once "config/config.inc.php";
require_once "config/common.php";
?>

<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    HDUISA MC 充值中心 <small><!-- 老板说支付宝不会用，先关着这功能，先用银行卡转账。 --></small>
                </h1>
            </div>
            <form class="form-horizontal" role="form" action="" method="post">
                <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">Username</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="username" name="username" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="rmb" class="col-sm-2 control-label">RMB</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="rmb" name="rmb" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default">充钱！</button>
                    </div>
                </div>
            </form>
        </div>
        <?php

        if (!isset($_POST['username'], $_POST['rmb'])) {
            exit;
        } else {
            if ($_POST['username'] == "" || $_POST['rmb'] == "") {
                header("Location: 404.html");
                exit;
            }
            $username = SqlGuard($_POST['username'], $dbConn);
            $rmb = @(int)SqlGuard($_POST['rmb'], $dbConn);

            if ($username != $_SESSION['username']) {
                echo '<script>alert("你咋还要给别人充钱。。。");</script>';
                exit;
            }

            $sql = "SELECT * FROM mcshop_user WHERE username = '$username'";
            $result = $dbConn->query($sql);
            if ($result->num_rows != 1) {
                echo "<script>alert('用户不存在!');</script>";
                exit;
            }
            echo "<script>alert('充值成功咯!');</script>";
            exit;
        }

        ?>
    </div>
</div>



<?php
require_once "footer.php";
?>
