extends Control

@onready var nombreJugador = $HBoxContainer/VBoxContainer/Nombre 
@onready var nombreJugador2 = $HBoxContainer/VBoxContainer3/Nombre2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_text_edit_text_changed() -> void:
	pass # Replace with function body.


func _on_text_edit_2_text_changed() -> void:
	pass # Replace with function body.

func _on_button_pressed() -> void:
	if nombreJugador.text == "" || nombreJugador2.text == "":
		$AcceptDialog.popup_centered()
		return 
	
	var json = JSON.stringify({
		"player1": nombreJugador.text,
		"player2": nombreJugador2.text
	})
	
	var headers = ["Content-Type: application/json"]
	var url = "http://localhost/pingpong/pingpong-API/api/init_players.php"
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)
	
	Global.nombreJugador = nombreJugador.text.strip_edges()
	Global.nombreJugador2 = nombreJugador2.text.strip_edges()
	
	get_tree().change_scene_to_file("res://scenes/mapa.tscn")
	
	pass # Replace with function body.
