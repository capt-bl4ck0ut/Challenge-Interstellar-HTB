<?php
session_start();
unset($_SESSION["id"]);
unset($_SESSION["name"]);
session_destroy();
if (isset($_COOKIE['PHPSESSID'])) {
    unset($_COOKIE['PHPSESSID']); 
    setcookie('PHPSESSID', '', -1, '/'); 
}
header("Location: /");
exit();
?>
