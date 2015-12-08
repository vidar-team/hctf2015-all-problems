<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<link href="./style.css" rel="stylesheet" type="text/css">
	<title>HDUISA MC服务器租售中心 - 留言系统</title>
</head>

<body class="basic-grey">
	<form action="" method="post" class="basic-grey">
		<h1>HDUISA MC服务器租售中心 留言系统
			<span>请填写下面的所有内容：</span>
		</h1>
		<label>
			<span>您的名字 :</span>
			<input id="name" type="text" name="name" placeholder="Your Full Name" />
		</label>
		<label>
			<span>您的邮箱地址 :</span>
			<input id="email" type="email" name="email" placeholder="Valid Email Address" />
		</label>
		<label>
			<span>留言内容 :</span>
			<textarea id="message" name="message" placeholder="Your Message to Us"></textarea>
		</label>
		<label>
			<span>问题分类 :</span><select name="selection">
			<option value="Job">求职申请</option>
			<option value="shop">售前/售后咨询</option>
			<option value="general">其他疑问</option>
		</select>
		</label>
		<label>
			<span>&nbsp;</span>
			<input type="submit" class="button" value="发送" />
		</label>
</form>
<?php
	// print_r($_SERVER);
	// Array ( [name] => xxx [email] => zzz@qq.com [message] => ttt [selection] => shop )
	// HTTP_USER_AGENT
	// REMOTE_ADDR
	// REQUEST_TIME
	if (!isset($_POST['name'],$_POST['email'],$_POST['message'],$_POST['selection'])) {
		exit;
	}

	$name = $_POST['name'];
	$email = $_POST['email'];
	$message = $_POST['message'];
	$selection = $_POST['selection'];

	if ($name == "" || $email == "" || $message == "" || $selection == "") {
		header('Location: 404.html');
		exit;
	}

	$data = "==========\n";
	$data = $data . 'name: ' . $name . "\n";
	$data = $data . 'email: '. $email . "\n";
	$data = $data . 'message: '. $message . "\n";
	$data = $data . 'selection: '. $message. "\n";
	$data = $data . 'UA: '. $_SERVER['HTTP_USER_AGENT'] . "\n";
	$data = $data . 'IP: ' . $_SERVER['REMOTE_ADDR'] . "\n";
	$data = $data . 'time: ' . $_SERVER['REQUEST_TIME'] . "\n";
	$data = $data . "==========\n";
	//echo $data;
	$res = file_put_contents('messagehahaha.txt', $data, FILE_APPEND | LOCK_EX);

	if (!$res) {
		echo '留言失败，大概是服务器跪了。。';
		exit;
	} else {
		echo '留言成功，请等待管理员回复！';
		exit;
	}


?>

</body>

</html>
