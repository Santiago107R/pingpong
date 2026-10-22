<?php
$host = 'localhost';
$db   = 'pingpong';
$user = 'root';
$pass = '';

$conexion = new mysqli($host, $user, $pass, $db);

if ($conexion->connect_error) {
    die(json_encode(["error" => "Conexión fallida: " . $conexion->connect_error]));
}
$conexion->set_charset("utf8mb4");
