<?php
require_once "header.php";
require_once "config/config.inc.php";
require_once "config/common.php";
?>

<div class="container">
    <div class="row clearfix">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-10 column">
            <div class="page-header">
                <h1>
                    HDUISA MC 后台管理 <small>后台已开启双因子认证，请尽快绑定安全手机</small>
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
            <?php

            if (!isset($_POST['username'], $_POST['password'])) {
                exit;
            }

            $username = SqlGuard($_POST['username'], $dbConn);
            $password = SqlGuard($_POST['password'], $dbConn);

            if ($username == "" || $password == "") {
                header('404.html');
                exit;
            }

            $password = md5($password);

            $sql = "SELECT * FROM mcshop_admin WHERE username = '$username' AND password = '$password'";
            $result = $dbConn->query($sql);
            if ($result->num_rows != 1) {
                echo '<script>alert("登录失败！");</script>';
                exit;
            } else {
                // check XFF

                // 验证通过则进入二次验证
                $_SESSION['auth1'] = true;
                $_SESSION['username'] = $username;
                $_SESSION['code'] = CreateRandomString(6);
                header('Location: index2.php');
            }

            ?>
        </div>
        <div class="col-md-1 column">
        </div>
    </div>
</div>

<?php
require_once "footer.php";
?>
