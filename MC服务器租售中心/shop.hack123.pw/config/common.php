<?php
/**
 * Created by PhpStorm.
 * User: lightless
 * Date: 2015/10/6
 * Time: 14:05
 */

function CreateRandomString($len) {
    $str = null;
    $strPol = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    $max = strlen($strPol)-1;

    for ($i=0; $i < $len; ++$i) {
        $str .= $strPol[mt_rand(0, $max)];
    }

    return $str;
}

function getAllMyCart($dbConn) {
    if (!isset($_SESSION['isLogin'])) {
        return 0;
    }
    $id = $_SESSION['id'];
    $sql = "SELECT * FROM cart WHERE uid='$id'";
    $result = $dbConn->query($sql);
    return $result->num_rows;
}