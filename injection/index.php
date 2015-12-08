<?php


$re = array('and','or','count','select','from','union','group','by','limit','insert','where','order','alter','delete','having','max','min','avg','sum','sqrt','rand','concat','sleep');

setcookie('injection','c3FsaSBpcyBub3QgdGhlIG9ubHkgd2F5IGZvciBpbmplY3Rpb24=',time()+100000);

if(file_exists('t3stt3st.xml')) {
    $xml = simplexml_load_file('t3stt3st.xml');

    $user=$_GET['user'];

	$user=str_replace($re, ' ', $user);

  //  $user=str_replace("'", "&apos", $user);

    $query="user/username[@name='".$user."']";
  
    $ans = $xml->xpath($query);

    foreach($ans as $x => $x_value)
    {
        echo $x.":  " . $x_value;
        echo "<br />";
    }

}

?>

