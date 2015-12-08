<?php
require_once "header.php";
require_once "config/config.inc.php";
require_once "config/common.php";

$step = $_GET['step'];
switch ($step) {
    case '0':
        echo "<script>alert('别试啦！注册真的关闭了！');</script>";
        //echo '别试啦！注册真的关闭了啊！';
        header("Refresh:0.1;url=index.php");
        exit;
        break;
    case '1':
        // 输出表单
        echo <<< EOF
<div class="container">
<!-- 老板说：由于近日受到大量的ddos和恶意攻击，暂时关闭注册功能 -->
<!-- 后面不管是谁看到这个注释请在维护的时候删掉。 2015.10 -->
<!-- 楼上真辛苦，国庆还在加班，我暂时把注册功能关掉了，相关的代码又不能删，真坑爹。 2015.10 -->
<!-- 卧槽，谁告诉我git怎么用啊，怎么不小心滚到上个版本了？！ 2015.10 -->
<!-- 老板说他昨天把.git删了，只剩下数据库的结构备份了，开发都去日狗了。。怎么遇上个这二货老板 2015.10-->
<!-- 切绘酱我们晚上去哪里吃饭啊？ -->
<!-- 噫，人家才不要跟你去吃饭呢！ --萌萌的切绘酱。 -->
<!-- 楼上的楼上好逗，切绘酱女神是我的！ -->
<!-- 。。。快点把注释删了，被用户看到不好！ --萌萌的切绘酱。 -->

	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="page-header">
				<h1>
					HDUISA MC 销售中心 会员注册 <small></small>
				</h1>
			</div>
			<form class="form-horizontal" role="form" action="register.php?step=2" method="POST">
				<div class="form-group">
					 <label for="username" class="col-sm-2 control-label">Username</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="username" name="username" />
					</div>
				</div>
				<div class="form-group">
					 <label for="password1" class="col-sm-2 control-label">Password</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="password1" name="password1" />
					</div>
				</div>
				<div class="form-group">
					<label for="password2" class="col-sm-2 control-label">Password Confirm</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="password2" name="password2" />
					</div>
				</div>
				<div class="form-group">
					 <label for="email" class="col-sm-2 control-label">Email</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="email" name="email" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						 <button type="submit" class="btn btn-default">Sign up</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
EOF;
        break;
    case '2':
        // array(4) { ["username"]=> string(9) "lightless"
        // ["password1"]=> string(6) "111111" ["password2"]=> string(6) "111111"
        // ["email"]=> string(9) "li@qq.com" }

        if (!isset($_POST['username'], $_POST['password1'], $_POST['password2'], $_POST['email'])) {
            header('Location: 404.html');
            exit;
        }

        if ($_POST['username'] == "" || $_POST['password1'] == "" || $_POST['password2'] == "" || $_POST['email'] == "") {
            header('Location: 404.html');
            exit;
        }

        echo '<script>alert("注册真的关了，别特么试了。。");</script>';
        header("Refresh:0.1;url=404.html");

        $username = SqlGuard($_POST['username'], $dbConn);
        $password1 = SqlGuard($_POST['password1'], $dbConn);
        $password2 = SqlGuard($_POST['password2'], $dbConn);
        $email = SqlGuard($_POST['email'], $dbConn);

		$password = md5($password1);
		$token = CreateRandomString(64);

		$sql = "SELECT * FROM mcshop_user WHERE username = '$username'";
		$result = $dbConn->query($sql);
		if ($result->num_rows != 0) {
			exit;
		}

		$sql = "INSERT INTO mcshop_user VALUES ('', '$username', '$password', '$email', '$token', '0', '0')";
		//echo $sql;
		$result = $dbConn->query($sql);

        break;

    default:
        header('Location: 404.html');
        exit;
}
require_once "footer.php";