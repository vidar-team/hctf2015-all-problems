<!DOCTYPE html>
<html>
<head>
	<title>colliding</title>
</head>
<body>

<pre>
if (isset($_GET['a']) and isset($_GET['b'])) {
    if ($_GET['a'] != $_GET['b'])
    	if (md5($_GET['a']) === md5($_GET['b']))
        	die('Flag: '.$flag);
    else
        print 'Wrong.';
</pre>

</body>
</html>

<?php
$flag='hctf{dd0g_fjdks4r3wrkq7jl}';
if (isset($_GET['a']) and isset($_GET['b'])) {
    if ($_GET['a'] != $_GET['b'])
    	if (md5($_GET['a']) === md5($_GET['b']))
        	die('Flag: '.$flag);
    else
        print 'Wrong.';
}

?>