<?php
//require_once('/usr/local/lib/php/smarty/libs/Smarty.class.php');
require_once('Smarty.class.php');
$smarty = new Smarty();

$smarty->template_dir = '/var/www/html/smarty/templates/';
$smarty->compile_dir  = '/var/www/html/smarty/templates_c/';
$smarty->config_dir   = '/var/www/html/smarty/configs/';
$smarty->cache_dir    = '/var/www/html/smarty/cache/';

$smarty->assign('title', 'Sample');
$smarty->display('sample.tpl');
//phpinfo();
