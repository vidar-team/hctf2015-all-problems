<?php
	require_once "./flag.php";

	$target1 = false;
	$target2 = true;

	$getFlag = function ($flag, $cbc_key, $cbc_iv) {
		$encFlag = function () use($flag, $cbc_key, $cbc_iv) {
			return base64_encode(mcrypt_encrypt(MCRYPT_BLOWFISH, $cbc_key, $flag, MCRYPT_MODE_CBC, $cbc_iv));
		};
		return $encFlag();
	};

	$echoFlag = function ($flag) {
		$x = function () use (&$flag) {
			return $flag;
		};
		echo $x();
	};

	$getUserInfo = function() {
		$username = $_GET['username'];
		$password = $_GET['password'];
		if (is_array($username) || is_array($password)) {
			exit;
		}
		if (strlen($username) != 16 || strlen($password) != 16) {
			echo 'sb!';
			exit;
		}
		$split2array = function ($arg) {
			return str_split($arg, 4);
		};
		return array_map($split2array, array($username,$password));
	};

	$checkTarget1 = function() use ($getUserInfo, &$target1) {
		$arrUserInfo = $getUserInfo();
		$arrUsername = $arrUserInfo[0];
		$arrPassword = $arrUserInfo[1];

		$getMinCount = function () use ($arrUsername, $arrPassword) {
			if (!function_exists('getArrayLength')) {
				function getArrayLength ($arg) {
					return count($arg);
				}
			}
			return array_map("getArrayLength", array($arrUsername, $arrPassword))[0] > 
				array_map("getArrayLength", array($arrUsername, $arrPassword))[1] ? 
				array_map("getArrayLength", array($arrUsername, $arrPassword))[0] : 
				array_map("getArrayLength", array($arrUsername, $arrPassword))[1];
		};

		$getStrLen = function ($arg) {
			return is_array($arg) ? exit : strlen($arg);
		};

		$checkStrLen = function ($arg) use ($getStrLen) {
			return $getStrLen($arg) == 4 ? true : false;
		};

		$checkStrValid = function ($username, $password) use ($checkStrLen) {
			foreach (array_map($checkStrLen, array($username, $password)) as $key => $value) {
			 	if (!$value) {
			 		exit;
			 	} 
			} 
		};

		$getXorStr = function ($arg1, $arg2) {
			$xoredStr = '';
			for ($i=0; $i < strlen($arg1); $i++) { 
				$xoredStr .= $arg1[$i] ^ $arg2[$i];
			}
			return $xoredStr;
		};

		$cnt = 0;
		$serialNumber = '';
		while ($cnt < $getMinCount()) {
			$strUsername = $arrUsername[$cnt];
			$strPassword = $arrPassword[$cnt];
			$checkStrValid($strUsername, $strPassword);
			$serialNumber .= $getXorStr($strUsername, $strPassword);
			$cnt++;
		}

		if ($serialNumber === 'ILoveAklisheheha') {
			$target1 = true;
		}
	};

	$checkTarget1();
	
	if ($target1 && $target2) {
		$flag = $getFlag($flag, $cbc_key, $cbc_iv);
			$echoFlag($flag);
			$echoFlag($cbc_iv);
			$echoFlag($cbc_key);
	}
?>
