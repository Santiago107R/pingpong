<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
require 'conexion.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['player1']) || !isset($data['player2'])) {
    http_response_code(400);
    echo json_encode(["error" => "Faltan nombres de jugadores"]);
    exit;
}

$p1 = trim($data['player1']);
$p2 = trim($data['player2']);

$stmt = $conexion->prepare("INSERT IGNORE INTO players (username) VALUES (?), (?)");
$stmt->bind_param("ss", $p1, $p2);
$stmt->execute();
$stmt->close();

$stmt = $conexion->prepare("SELECT username, xp FROM players WHERE username IN (?, ?)");
$stmt->bind_param("ss", $p1, $p2);
$stmt->execute();
$result = $stmt->get_result();

$players = [];
while ($row = $result->fetch_assoc()) {
    $players[$row['username']] = $row;
}

echo json_encode([
    "player1" => $players[$p1],
    "player2" => $players[$p2]
]);
