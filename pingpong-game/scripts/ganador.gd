extends Control

@onready var ganadorLabel: Label = $VBoxContainer/Label
@onready var perdedorLabel: Label = $VBoxContainer/Label2

func _ready() -> void:
	ganadorLabel.text = "Ganador: " + Global.nombreGanador
	perdedorLabel.text = "Perdedor: " + Global.nombrePerdedor


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/mapa.tscn")
	pass # Replace with function body.


func _on_button_2_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/menu-inicio.tscn")
	pass # Replace with function body.
