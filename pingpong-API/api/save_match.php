<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
require 'conexion.php';

$data = json_decode(file_get_contents("php://input"), true);

$winner = $data['winner'];
$loser = $data['loser'];
$xp_gained = 50;

$stmt = $conexion->prepare("UPDATE players SET xp = xp + ? WHERE username = ?");
$stmt->bind_param("is", $xp_gained, $winner);
$stmt->execute();

$stmt_match = $conexion->prepare("INSERT INTO matches (winner_username, loser_username) VALUES (?, ?)");
$stmt_match->bind_param("ss", $winner, $loser);
$stmt_match->execute();

echo json_encode(["status" => "success", "message" => "Partida registrada"]);
