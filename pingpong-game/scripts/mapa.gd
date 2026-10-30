extends Node2D

@onready var controlContador: Control = $Control
@onready var label: Label = $Control/Label
@onready var jugador: Player = $CharacterBody2D
@onready var jugador2: Player = $CharacterBody2D2

func contadorInicio()->void:
	jugador.stun = true
	jugador2.stun = true
	
	controlContador.visible = true
	
	label.text = "3"
	await get_tree().create_timer(1.0).timeout
	
	label.text = "2"
	await get_tree().create_timer(1.0).timeout
	
	label.text = "1"
	await get_tree().create_timer(1.0).timeout
	
	label.text = ""
	controlContador.visible = false
	jugador.stun = false
	jugador2.stun = false
	
	pass

func empezarJuego()->void:
	get_tree().paused = false
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	
	contadorInicio()
	
	empezarJuego()
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
