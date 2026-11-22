extends CanvasLayer

@onready var contenedor_pausa: Control = $Control
@onready var btn_reanudar: Button = $Control/VBoxContainer/Button
@onready var btn_opciones: Button = $Control/VBoxContainer/Button2
@onready var btn_menu: Button = $Control/VBoxContainer/Button3
@onready var panel_opciones: Panel = $Control/PanelOpciones
@onready var btn_cerrar: Button = $Control/PanelOpciones/BtnCerrar
@onready var slider_musica: HSlider = $Control/PanelOpciones/SliderMusica
@onready var slider_sonidos: HSlider = $Control/PanelOpciones/SliderSonidos

var bus_musica: int
var bus_sonidos: int

func _ready() -> void:
	contenedor_pausa.visible = false
	panel_opciones.visible = false

	bus_musica = AudioServer.get_bus_index("Musica")
	bus_sonidos = AudioServer.get_bus_index("Sonidos")

	if bus_musica != -1:
		slider_musica.value = db_to_linear(AudioServer.get_bus_volume_db(bus_musica))
	if bus_sonidos != -1:
		slider_sonidos.value = db_to_linear(AudioServer.get_bus_volume_db(bus_sonidos))

	btn_reanudar.pressed.connect(alternar_pausa)
	btn_opciones.pressed.connect(_on_abrir_opciones)
	btn_menu.pressed.connect(_on_ir_al_menu)
	btn_cerrar.pressed.connect(_on_cerrar_opciones)
	slider_musica.value_changed.connect(_on_musica_changed)
	slider_sonidos.value_changed.connect(_on_sonidos_changed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().current_scene.scene_file_path == "res://scenes/menu-inicio.tscn":
			return
			
		alternar_pausa()

func alternar_pausa() -> void:
	var pausado = not get_tree().paused
	get_tree().paused = pausado
	contenedor_pausa.visible = pausado
	
	if not pausado:
		panel_opciones.visible = false

func _on_abrir_opciones() -> void:
	actualizar_sliders()
	panel_opciones.visible = true

func actualizar_sliders() -> void:
	if bus_musica != -1:
		if AudioServer.is_bus_mute(bus_musica):
			slider_musica.set_value_no_signal(0.0)
		else:
			slider_musica.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(bus_musica)))
			
	if bus_sonidos != -1:
		if AudioServer.is_bus_mute(bus_sonidos):
			slider_sonidos.set_value_no_signal(0.0)
		else:
			slider_sonidos.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(bus_sonidos)))

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

func _on_ir_al_menu() -> void:
	get_tree().paused = false
	contenedor_pausa.visible = false
	panel_opciones.visible = false
	get_tree().change_scene_to_file("res://scenes/menu-inicio.tscn")
