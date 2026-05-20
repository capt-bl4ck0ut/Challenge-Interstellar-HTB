<?php
session_start();

require_once('utils/smarty.php');
require_once('utils/database.php');
require_once('utils/emoji.php');
$name = isset($_SESSION['name']) ? $_SESSION['name'] : null;
$id = isset($_SESSION['id']) ? $_SESSION['id'] : null;
$action = $_REQUEST['action'];

$smarty = getSmarty();
if ($id) {
    if(empty($action)){
        try {
            $query = "CALL searchUser(?)";
            $stmt = $conn->prepare($query);
            $stmt->bind_param("s", $name);
            $stmt->execute();
            if ($stmt->errno) {
                http_response_code(500);
                echo "SQL Error: " . $stmt->error;
                exit;
            }     
            $result = $stmt->get_result();
    
            $user = $result->fetch_object();
            if (!$user) {
                throw new Exception("No user found.");
            }
            $planet=$user->planet;
            $planet_emoji = pick_emoji($planet);
            $smarty->assign('planet', $planet_emoji);
            $smarty->assign('name', $name);
    
            $smarty->display('index.tpl');
    
        } catch (Exception $e) {
            
            $smarty->assign('message', 'An error occurred: ' . $e->getMessage());
            $smarty->assign('name', $name);
            $smarty->display('index.tpl');
        }
    }elseif($action =="edit"){
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if ($_SERVER['REMOTE_ADDR'] != '127.0.0.1') {
                $smarty->assign('error', "Only localhost can use this function!");
                $smarty->display('index.tpl');
                exit();
            }
            $new_name = $_REQUEST['new_name'] ?? '';
            try {
                $query = "CALL editName(?, ?)";
                $stmt = $conn->prepare($query);
                $stmt->bind_param("is", $id, $new_name);
                $stmt->execute();
    
                if ($stmt->affected_rows > 0) {
                    $_SESSION['name'] = $new_name;
                    $smarty->assign('message', "Done!");
                    $smarty->display('index.tpl');
                    exit();
                } else {
                    $smarty->assign('error', "Failed!");
                    $smarty->display('index.tpl');
                    exit();
                }
                $stmt->close();
            } catch (Exception $e) {
                echo "An error occurred: " . $e->getMessage();
            }
        }
    }
   
} else {
    header("Location: login.php");
    exit();
}
?> 
