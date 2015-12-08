<?php
require_once "header.php";
require_once "config/config.inc.php";
require_once "config/common.php";
if (!isset($_SESSION['auth1'])) {
    header('Location: index.php');
    exit;
}
echo '<!-- Debug: -->';
echo '<!--'.$_SESSION['code'].'-->';
?>

<div class="container">
    <div class="row clearfix">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-10 column">
            <div class="page-header">
                <h1>
                    HDUISA MC 后台管理 <small>身份认证系统</small>
                </h1>
            </div>
            <form class="form-horizontal" role="form" action="" method="post">
                <div class="form-group">
                    <label for="pre-phone" class="col-sm-2 control-label">信任手机</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="pre-phone" name="pre-phone" readonly
                               <?php
                               if ($_SESSION['username'] == 'kirie') {
                                   echo 'value="132****4645"';
                               } else if ($_SESSION['username'] == 'mcshop_sale') {
                                   echo 'value="135****3728"';
                               } else {
                                   echo 'value="00000000000"';
                               }
                               ?>
                        />

                    </div>
                </div>
                <div class="form-group">
                    <label for="code" class="col-sm-2 control-label">收到的短信验证码：</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="code" name="code" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="idcard" class="col-sm-2 control-label">身份证号后4位：</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="idcard" name="idcard" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default">Sign in</button>
                    </div>
                </div>
            </form>
            <?php

            if (!isset($_POST['code'], $_POST['idcard'])) {
                exit;
            }

            if ($_POST['code'] == '' || $_POST['idcard'] == '') {
                header('Location: 404.html');
                exit;
            }

            $code = SqlGuard($_POST['code'], $dbConn);
            $idcard = SqlGuard($_POST['idcard'], $dbConn);

            // check code
            if ($code != $_SESSION['code']) {
                echo '<script>alert("短信验证码错误！");document.reload(true);</script>';
                exit;
            }

            // check idcard
            if ($_SESSION['username'] == 'kirie') {
                $realidcard = '3798';
            } else if ($_SESSION['username'] == 'mcshop_sale') {
                $realidcard = '3889';
            } else {
                $realidcard = 'xxxxx123123';
            }
            if ($idcard != $realidcard) {
                echo '<script>alert("身份证信息错误！");document.reload(true);</script>';
                exit;
            }

            $_SESSION['auth2'] = true;

            $username = $_SESSION['username'];
            $sql = "SELECT * FROM mcshop_admin WHERE username = '$username'";
            $result = $dbConn->query($sql);
            $admin_info = $result->fetch_assoc();

            $cookieArray = array();
            $cookieArray['username'] = $username;
            $cookieArray['level'] = $admin_info['level'];

            $cookieJson = json_encode($cookieArray);

            // print_r($cookieJson);

            $encCookie = mcrypt_encrypt(MCRYPT_BLOWFISH, $cbc_pass, $cookieJson, MCRYPT_MODE_CBC, $cbc_iv);
            $encCookie = base64_encode($encCookie);
            //echo $encCookie;
            setcookie('ht',$encCookie, time()+36000);
            header('Location: main.php');

            ?>
        </div>
        <div class="col-md-1 column">
        </div>
    </div>
</div>

<?php
require_once "footer.php";
?>
