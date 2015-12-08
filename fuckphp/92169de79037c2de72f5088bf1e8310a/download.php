<?php
	session_start();
	if (!isset($_GET['file'])) {
		header('Location: http://www.baidu.com');
		exit;
	}

	$file = $_GET['file'];
	switch($file) {
		case 'SAO.7z':
			break;
		case 'backup.zip':
			break;
		default:
			exit;
			break;
	}

	$filename = 'novel/'.$_GET['file'];
	if (!file_exists($filename)) {
		exit;
	}

	header("Content-type: application/octet-stream");
	header("Accept-Ranges: bytes");
	header("Accept-Length: ".filesize($filename));
	header("Content-Disposition: attachment; filename=".$file);
	// $fff = open($filename,'r');
	// echo fread($fff, filesize($filename));
	// fclose($fff);
	echo file_get_contents($filename);
	exit;
?>
