<?php
namespace think;

require __DIR__ . '/../vendor/autoload.php';

$http = (new App())->http;
$http->run();