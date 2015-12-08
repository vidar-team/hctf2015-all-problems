<?php

    define("ROOT_PATH", '/');

    // ENV : debug product
    define("ENV", 'product');

    $dbConfig = array();
    $dbConfig['debug']['host'] = 'localhost';
    $dbConfig['debug']['username'] = 'root';
    $dbConfig['debug']['password'] = '123456';
    $dbConfig['debug']['dbname'] = 'mcshop';

    $dbConfig['product']['host'] = 'localhost';
    $dbConfig['product']['username'] = 'mcshop';
    $dbConfig['product']['password'] = 'mcshop123***';
    $dbConfig['product']['dbname'] = 'mcshop';

    $dbConfig = $dbConfig[ENV];

    if (!isset($dbConn)) {
        static $dbConn;
        $dbConn = new mysqli($dbConfig['host'], $dbConfig['username'], $dbConfig['password'], $dbConfig['dbname']);
        if (mysqli_connect_errno()) {
            die('Connect to database error.');
        }
    }

    $dbConn->set_charset("utf8mb4");
    date_default_timezone_set('Asia/Shanghai');

    function SqlGuard($input, $db) {
        if (get_magic_quotes_gpc()) {
            $input = stripcslashes($input);
        }
        $input = strip_tags($input);
        $input = $db->real_escape_string(trim($input));
        return $input;
    }
