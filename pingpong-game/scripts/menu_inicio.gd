extends Control

func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/nombreJugadores.tscn")
	pass # Replace with function body.

@onready var btn_opciones: Button = $VBoxContainer/Button3
@onready var panel_opciones: Panel = $PanelOpciones
@onready var btn_cerrar: Button = $PanelOpciones/BtnCerrar
@onready var slider_musica: HSlider = $PanelOpciones/SliderMusica
@onready var slider_sonidos: HSlider = $PanelOpciones/SliderSonidos

var bus_musica: int
var bus_sonidos: int

func _ready() -> void:
	panel_opciones.visible = false

	bus_musica = AudioServer.get_bus_index("Musica")
	bus_sonidos = AudioServer.get_bus_index("Sonidos")

	if bus_musica != -1:
		slider_musica.value = db_to_linear(AudioServer.get_bus_volume_db(bus_musica))
	if bus_sonidos != -1:
		slider_sonidos.value = db_to_linear(AudioServer.get_bus_volume_db(bus_sonidos))

	btn_opciones.pressed.connect(_on_abrir_opciones)
	btn_cerrar.pressed.connect(_on_cerrar_opciones)
	slider_musica.value_changed.connect(_on_musica_changed)
	slider_sonidos.value_changed.connect(_on_sonidos_changed)

func _on_abrir_opciones() -> void:
	panel_opciones.visible = true

func _on_cerrar_opciones() -> void:
	panel_opciones.visible = false

func _on_musica_changed(valor: float) -> void:
	if bus_musica == -1:
		return
	var db := linear_to_db(max(valor, 0.0001)) if valor > 0.0 else -80.0
	AudioServer.set_bus_volume_db(bus_musica, db)
	AudioServer.set_bus_mute(bus_musica, valor <= 0.001)

func _on_sonidos_changed(valor: float) -> void:
	if bus_sonidos == -1:
		return
	var db := linear_to_db(max(valor, 0.0001)) if valor > 0.0 else -80.0
	AudioServer.set_bus_volume_db(bus_sonidos, db)
	AudioServer.set_bus_mute(bus_sonidos, valor <= 0.001)


func _on_button_4_button_down() -> void:
	get_tree().quit()


func _on_button_2_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/historial.tscn")
	pass # Replace with function body.
