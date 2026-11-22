extends Node2D

class_name Mapa

@onready var controlContador: Control = $Control
@onready var label: Label = $Control/Label
@onready var jugador: Player = $CharacterBody2D
@onready var jugador2: Player = $CharacterBody2D2
@export var pelota: CharacterBody2D

@onready var nombreJugadorLabel: Label = $barra/ColorRect/HBoxContainer/Label
@onready var nombreJugadorLabel2: Label = $barra/ColorRect/HBoxContainer/Label2

var pos_inicial_j1: Vector2
var pos_inicial_j2: Vector2

func _ready() -> void:
	pos_inicial_j1 = jugador.global_position
	pos_inicial_j2 = jugador2.global_position
	
	nombreJugadorLabel.text = Global.nombreJugador
	nombreJugadorLabel2.text = Global.nombreJugador2
	
	empezarJuego()
	contadorInicio()

func contadorInicio() -> void:
	jugador.stun = true
	jugador2.stun = true

	if pelota != null:
		pelota.preparar_pelota()

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

	if pelota != null:
		pelota.arrancar_movimiento()

func otraRonda() -> void:
	jugador.stun = true
	jugador2.stun = true

	if pelota != null:
		pelota.preparar_pelota()
		
	jugador.global_position = pos_inicial_j1
	jugador2.global_position = pos_inicial_j2

	await get_tree().create_timer(1.0).timeout

	jugador.stun = false
	jugador2.stun = false

	if pelota != null:
		pelota.arrancar_movimiento()

func empezarJuego() -> void:
	get_tree().paused = false
