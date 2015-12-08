<?php
require_once 'header.php';
require_once 'config/config.inc.php';
require_once 'config/common.php';
if (!isset($_SESSION['auth1'], $_SESSION['auth2'])) {
    header('Location: 404.html');
}
?>

<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    后台充值操作 <small></small>
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
        $username = SqlGuard($_POST['username'], $dbConn);
        $rmb = (int)SqlGuard($_POST['rmb'], $dbConn);
        if ($rmb <= 0) {
            echo '你似不似傻？';
            exit;
        }
        // 检测用户是否存在
        $sql = "SELECT * FROM mcshop_user WHERE username = '$username'";
        $result = $dbConn->query($sql);
        if ($result->num_rows != 1) {
            echo '你似不似傻？';
            exit;
        }

        // 充钱
        $sql = "UPDATE mcshop_user SET bank = bank + '$rmb' WHERE username='$username'";
        $result = $dbConn->query($sql);
        echo '充值成功!';
        exit;

        ?>
    </div>
</div>


<?php
require_once 'footer.php';
?>
