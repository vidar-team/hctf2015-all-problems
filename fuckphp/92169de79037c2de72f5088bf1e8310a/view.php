<html>
	<head>
		<meta charset="utf-8">
		<title>Edward的小说站</title>

		<link href="css/bootstrap.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">

		<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>

		<?php
			session_start();
		?>

		<!-- 赛棍们不要做题啦~好好读读小说吧~ -->
	</head>

	<body>
		<?php
			if (!isset($_GET['id'])) {
				echo "亲你小说读完了嘛就做题？:)";
				exit;
			}

			$id = $_GET['id'];
			echo '<a href="index.php">返回</a> | ';
			//echo '<!-- 下载接口：download.php?file=SAO.7z -->';
			switch($id) {
				case 1:
					echo '<a href="view.php?id=2">下一章</a><br />';
					$file = file('novel/SAO01.txt');
					foreach ($file as $value) {
						echo $value."<br />";
					}
				case 2:
				echo '<a href="view.php?id=1">上一章</a> | <a href="view.php?id=3">下一章</a><br />';
					$file = file('novel/SAO02.txt');
					foreach ($file as $value) {
						echo $value."<br />";
					}
					break;
				case 3:
					echo '<a href="view.php?id=2">上一章</a><br />';
					$file = file('novel/SAO03.txt');
					foreach ($file as $value) {
						echo $value."<br />";
					}
					break;
				default:
					echo "亲你小说读完了嘛就做题？:)";
					exit;
			}
		?>
	</body>
<!-- 下载接口：download.php?file=SAO.7z -->
</html>
