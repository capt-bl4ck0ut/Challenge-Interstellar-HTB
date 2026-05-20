<?php
session_start();

require_once 'utils/smarty.php';

$id = isset($_SESSION['id']) ? $_SESSION['id'] : null;
$smarty = getSmarty();
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $url = $_POST['url'];
        $data = $_POST['data'] ?? [];
        if(filter_var($url, FILTER_VALIDATE_URL)) {
            $parsedUrl= parse_url($url);
            if(preg_match('/motherland\.com$/', $parsedUrl['host'])) {    //currently just support call to your mother land 
                try {
                    $ch = curl_init();
                    $sessCookie = isset($_COOKIE['PHPSESSID']) ? $_COOKIE['PHPSESSID'] : '';
                    curl_setopt($ch, CURLOPT_URL, $parsedUrl['host']);
                    curl_setopt($ch, CURLOPT_POST, true);
                    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch, CURLOPT_HTTPHEADER, [
                        "Cookie: PHPSESSID=$sessCookie;"
                    ]);
                    curl_setopt($ch, CURLOPT_TIMEOUT, 1);
                    $response = curl_exec($ch);
        
                    if (curl_errno($ch)) {
                        $error = 'cURL Error: ' . curl_error($ch);
                    } else {
                        $error = null;
                    }
        
                    curl_close($ch);
        
        
                    $smarty->assign('response', $response ?? '');
                    $smarty->assign('error', $error ?? '');
        
                    $smarty->display('communicate.tpl');
                } catch (Exception $e) {
                    $smarty->assign('error', 'An error occurred: ' . $e->getMessage());
                    $smarty->display('communicate.tpl');
                }
            }else{
                $smarty->assign('error','Wrong URL!');
                $smarty->display('communicate.tpl');
            }
        }else{
            $smarty->assign('error','Failed when parsing URL!');
            $smarty->display('communicate.tpl');
        }

    }else{
        $smarty->display('communicate.tpl');
    }

