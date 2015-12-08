<?php

if (!isset($_POST['arg'])) {
  $_POST['arg'] = '';
}

$charsetPool = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_+=-`{}[]|\\/?.,<>';
$keyLength = 512;
$streamKey = '';

$flag = 'hctf{D0YOuKnovvhOw7oFxxkRCA?iGuE55UCan...Ah}';
$encFlag = '';
for ($i = 0; $i < 512-strlen($flag); $i++) {
  $encFlag .= $charsetPool[ mt_rand(0, strlen($charsetPool) - 1) ];
}
$encFlag .= $flag;

// create rc4 key
for ($i = 0; $i < $keyLength; ++$i) {
  $streamKey .= $charsetPool[ mt_rand(0, strlen($charsetPool) - 1) ];
}

// encrypt the arg
$plain = $_POST['arg'];
$i = 0;
$enc = '';
while($i < strlen($plain)) {
  $enc .= $plain[$i] ^ $streamKey[$i%$keyLength];
  $i++;
}

// encrypt the flag
$flag = $encFlag;
$i = 0;
$encFlag = '';
while($i < strlen($flag)) {
  $encFlag .= $flag[$i] ^ $streamKey[$i%$keyLength];
  $i++;
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- Do You Know liumima? -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>Object not found!</title>
<link rev="made" href="mailto:postmaster@localhost" />
<style type="text/css"><!--/*--><![CDATA[/*><!--*/ 
    body { color: #000000; background-color: #FFFFFF; }
    a:link { color: #0000CC; }
    p, address {margin-left: 3em;}
    span {font-size: smaller;}
/*]]>*/--></style>
</head>

<body>
<h1>Object not found!</h1>
<p>


    The requested URL was not found on this server.

  

    If you entered the URL manually please check your
    spelling and try again.

  

</p>
<p>
If you think this is a server error, please contact
the <a href="mailto:postmaster@localhost">webmaster</a>.

</p>

<h2>Error Code: 404</h2>
<h2>Message: <?php 

  for ($i = 0; $i < strlen($enc); $i++) {
    echo '\x'.bin2hex($enc[$i]);
  }
?></h2>
<?php
  echo '<!-- Flag Here:'.$encFlag.'-->';
?>
</body>
</html>

