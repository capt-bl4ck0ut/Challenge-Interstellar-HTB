<?php
session_start();
require_once 'utils/database.php';
require_once 'utils/smarty.php';


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    $query = "CALL loginUser(?, ?)";

    $stmt = $conn->prepare($query);
    if (!$stmt) {
        die("Prepare failed: " . $conn->error);
    }

    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {

        $user = $result->fetch_assoc();

        $_SESSION['name'] = $user['name'];
        $_SESSION['id'] = $user['id'];
        header('Location: /');
        exit;
    } else {

        $_SESSION['error'] = 'Invalid credentials';
        $smarty = getSmarty();
        $smarty->assign('error', $_SESSION['error']);
        $smarty->assign('username', $username);
        $smarty->display('login.tpl');
        exit;
    }
    
}

$smarty = getSmarty();
$smarty->display('login.tpl');

$conn->close();
?>
