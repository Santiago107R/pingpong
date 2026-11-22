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
	var p1 = nombreJugador.text.strip_edges()
	var p2 = nombreJugador2.text.strip_edges()

	if p1 == "" or p2 == "":
		$AcceptDialog.popup_centered()
		return 
	
	# Opcional: desactivar el botón para evitar doble clic mientras carga
	$HBoxContainer/VBoxContainer2/Button.disabled = true 
	
	var json = JSON.stringify({
		"player1": p1,
		"player2": p2
	})
	
	var headers = ["Content-Type: application/json"]
	var url = "http://localhost/pingpong/pingpong-API/api/init_players.php"
	
	var error = $HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)
	if error != OK:
		print("Error al iniciar la petición HTTP: ", error)
		$HBoxContainer/VBoxContainer2/Button.disabled = false
		return

	# Esperamos a que el servidor responda antes de destruir la escena
	var response = await $HTTPRequest.request_completed
	var response_code = response[1]
	
	if response_code == 200:
		Global.nombreJugador = p1
		Global.nombreJugador2 = p2
		get_tree().change_scene_to_file("res://scenes/mapa.tscn")
	else:
		print("Error en el servidor. Código HTTP: ", response_code)
		$HBoxContainer/VBoxContainer2/Button.disabled = false
