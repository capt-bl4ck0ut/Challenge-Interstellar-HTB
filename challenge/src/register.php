<?php
session_start();
require_once 'utils/database.php';
require_once 'utils/smarty.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $name = preg_replace('/[^a-zA-Z0-9]/', '', $name);
    if (empty($name)) {
        $smarty = getSmarty();
        $smarty->assign('error', 'Name cannot be empty');
        $smarty->display('register.tpl');
        exit();
    }
    $username = $_POST['username'];
    $password = $_POST['password'];
    $planets = ['Earth', 'Moon', 'Somewhere'];
    $randomPlanet = $planets[array_rand($planets)];

    $stmt = $conn->prepare("SELECT COUNT(*) AS user_count FROM users WHERE username = ?");
    if (!$stmt) {
        die("Prepare failed: " . $conn->error);
    }
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();

    if ($row['user_count'] > 0) {
        $smarty = getSmarty();
        $smarty->assign('error', 'Username already taken');
        $smarty->assign('name', $name);
        $smarty->assign('username', $username);
        $smarty->display('register.tpl');
        exit();
    }

    try {
        $stmt = $conn->prepare("CALL registerUser(?, ?, ?, ?)");
        if (!$stmt) {
            die("Prepare failed for procedure: " . $conn->error);
        }
        $stmt->bind_param('ssss', $name, $username, $password, $randomPlanet);
        $stmt->execute();

        $_SESSION['message'] = 'User registered successfully';
        header('Location: login.php');
        exit();
    } catch (Exception $e) {
        $smarty = getSmarty();
        $smarty->assign('error', 'An error occurred: ' . $e->getMessage());
        $smarty->assign('name', $name);
        $smarty->assign('username', $username);
        $smarty->display('register.tpl');
        exit();
    }
}

$smarty = getSmarty();
$smarty->display('register.tpl');
