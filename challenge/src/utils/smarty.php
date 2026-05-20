<?php

require_once 'vendor/autoload.php';  // Composer's autoloader

// Function to return the Smarty object
function getSmarty() {
    $smarty = new Smarty;

    // Set directories for templates, compiled templates, cache, and configs
    $smarty->setTemplateDir('templates/');
    $smarty->setCompileDir('templates_c/');
    $smarty->setCacheDir('cache/');
    $smarty->setConfigDir('configs/');

    return $smarty;
}
