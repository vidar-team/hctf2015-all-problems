<?php
require_once "header.php";
require_once "config/config.inc.php";
require_once "config/common.php";
?>

<div class="container">
    <script>
        alert('近日由于黑客攻击，注册功能暂时关闭，预计12月31日恢复，对此带来不便，表示歉意。');
    </script>
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    登录到 HDUISA MC服务器租售中心 <small></small>
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
                    <label for="password" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="password" name="password" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default">Sign in</button>
                    </div>
                </div>
            </form>
        </div>

        <?php

        if (!isset($_POST['username'], $_POST['password'])) {
            exit;
        }

        $username = SqlGuard($_POST['username'], $dbConn);
        $password = SqlGuard($_POST['password'], $dbConn);

        $password = md5($password);

        $sql = "SELECT * FROM mcshop_user WHERE username='$username' AND password='$password'";
        $result = $dbConn->query($sql);
        if ($result->num_rows == 1) {
            $row = $result->fetch_assoc();
            $_SESSION['username'] = $row['username'];
            $_SESSION['id'] = $row['id'];
            $_SESSION['token'] = $row['token'];
            $_SESSION['isLogin'] = 1;
            echo '登录成功，<a href="index.php">点我返回</a>';
        } else {
            echo '密码错误。';
            exit;
        }


        ?>


    </div>
</div>


<?php
require_once "footer.php";
?>
