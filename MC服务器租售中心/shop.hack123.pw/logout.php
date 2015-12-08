<?php
session_start();

if (isset($_SESSION['isLogin'], $_SESSION['username'], $_SESSION['id'], $_SESSION['token'])) {
    unset($_SESSION['isLogin']);
    unset($_SESSION['username']);
    unset($_SESSION['id']);
    unset($_SESSION['token']);

    header('Location: index.php');
}