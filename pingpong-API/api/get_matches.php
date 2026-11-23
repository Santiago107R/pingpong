<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
require 'conexion.php';

$query = "SELECT winner_username, loser_username, played_at_date, played_at_time FROM matches";

$stmt = $conexion->prepare($query);
$stmt->execute();
$matches = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

echo json_encode(["matches" => $matches]);