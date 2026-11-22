extends CharacterBody2D

class_name Pelota

@export var velocidad_inicial: float = 600.0
#@export var incremento_velocidad: float = 20.0 

var velocidad_actual: float
var puede_moverse: bool = false
var posicion_inicial: Vector2 # 1. Nueva variable para guardar el centro

func _ready() -> void:
	posicion_inicial = global_position # 2. Guarda donde estaba al iniciar
	preparar_pelota()

func _physics_process(delta: float) -> void:
	if not puede_moverse:
		return

	var colision = move_and_collide(velocity * delta)

	if colision:
		var objeto_chocado = colision.get_collider()
		
		if objeto_chocado is Player:
			MusicaGlobal.reproducir_rebote()
		
		var direccion_rebote = velocity.bounce(colision.get_normal())

		#velocidad_actual += incremento_velocidad
		velocity = direccion_rebote.normalized() * velocidad_actual

func preparar_pelota() -> void:
	puede_moverse = false
	velocity = Vector2.ZERO
	velocidad_actual = velocidad_inicial
	global_position = posicion_inicial # 3. La devuelve al centro en cada ronda

func arrancar_movimiento() -> void:
	velocidad_actual = velocidad_inicial

	var dir_x = [-1, 1].pick_random()
	var dir_y = randf_range(-0.5, 0.5)

	velocity = Vector2(dir_x, dir_y).normalized() * velocidad_actual
	puede_moverse = true
