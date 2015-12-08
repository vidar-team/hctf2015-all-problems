<?php
require_once 'header.php';
require_once 'config/config.inc.php';
require_once 'config/common.php';
if (!isset($_SESSION['auth1'], $_SESSION['auth2'])) {
    header('Location: 404.html');
    exit;
}
?>

<?php
// 获取当前权限 from cookie
if (!isset($_COOKIE['ht'])) {
    header('Location: 404.html');
    exit;
}
$currentLevel = 2;
$cookieVal = $_COOKIE['ht'];
$arrayJsonEnc = base64_decode($cookieVal);
$arrayJson = mcrypt_decrypt(MCRYPT_BLOWFISH, $cbc_pass, $arrayJsonEnc, MCRYPT_MODE_CBC, $cbc_iv);
// echo $arrayJson;
// echo '<br />'.$arrayJson[29];
if ($arrayJson[29] == '0') {
    $currentLevel = 0;
} else if ($arrayJson[29] == '1') {
    $currentLevel = 1;
} else  if ($arrayJson[29] == '2') {
    $currentLevel = 2;
} else {
    $currentLevel = 2;
}

// $currentLevel = 0;
// echo 'current level:'.$currentLevel;

switch ($currentLevel) {
    case '2':
        echo <<< EOF
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="jumbotron">
				<h1>
					Hello, 管理员!
				</h1>
				<p>
					您的权限尚未生效，请耐心等待管理员分配权限。
				    <!-- Debug信息，调试完成后记得删除 -->
				    <!-- Cookie信息 -->
				    <!-- {"username":"xxxx","level":"99"} -->
				    <!-- 坐看楼上大神写代码 -->
				    <!-- 你这数据脱敏跟没脱一样啊！！快点删掉啊！ -->
				</p>
				<p>
					 <a class="btn btn-primary btn-large" href="http://www.google.com">Learn more</a>
				</p>
			</div>
		</div>
	</div>
</div>
EOF;

        break;
    case '1':
        echo <<< EOF
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="jumbotron">
				<h1>
					Hello, 商城管理员!
				</h1>
				<p>
					您可以管理用户信息，并且为用户充值。
				</p>
				<p>
					 <a class="btn btn-primary btn-large" href="manager-user.php">管理用户信息</a>
					 <a class="btn btn-primary btn-large" href="pay.php">充值</a>
				</p>
			</div>
		</div>
	</div>
</div>
EOF;

        break;
    case '0':
        echo <<< EOF
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="jumbotron">
				<h1>
					Hello, 超级管理员!
				</h1>
				<p>
					您可以交个flag。。。。
					<!-- Here is the flag : hctf{4!7hi3Pr0b1emZhEnTMbor1ng..}  -->
				</p>
				<p>
					<!-- 调试接口还在开发中，部分功能不完善。 <a class="btn btn-primary btn-large" href="debug.php">调试接口</a> -->
					<!-- 增加服务器数量的接口还在开发，各位暂时没有办法增加服务器数量 -->
				    <!-- 各位开发的时候注意下，用vim的删除自动保存文件 -->
				    <!-- 求别说。。我昨天用vim写后台代码的时候断电了。。 -->
				</p>
			</div>
		</div>
	</div>
</div>
EOF;
        break;
    default:
        header('Location: 404.html');
        exit;
        break;
}

?>

<?php
require_once 'footer.php';
?>
