extends Control

@onready var http_request: HTTPRequest = $HTTPRequest
@onready var lista_partidas: VBoxContainer = $ScrollContainer/VBoxContainer

func _ready() -> void:
	http_request.request_completed.connect(_on_request_completed)
	get_matches()

func get_matches() -> void:
	var url = "http://localhost/pingpong/pingpong-API/api/get_matches.php"
	var error = http_request.request(url)
	if error != OK:
		print("Error al iniciar la petición HTTP: ", error)

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code != 200:
		print("Error del servidor. Código: ", response_code)
		return
		
	var json = JSON.new()
	var parse_error = json.parse(body.get_string_from_utf8())
	if parse_error != OK:
		print("Error al leer el JSON")
		return
		
	var data = json.data
	if data.has("matches"):
		mostrar_partidas(data["matches"])

func mostrar_partidas(matches: Array) -> void:
	for hijo in lista_partidas.get_children():
		hijo.queue_free()
		
	for partida in matches:
		var fila = Label.new()
		fila.text = "%s venció a %s  |  %s %s" % [
			partida["winner_username"],
			partida["loser_username"],
			partida["played_at_date"],
			partida["played_at_time"]
		]
		lista_partidas.add_child(fila)


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/menu-inicio.tscn")
	pass # Replace with function body.
