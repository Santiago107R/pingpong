extends Area2D

@export_enum("izquierda", "derecha") var lado: String = "izquierda"
@export var labelPuntos: Label
@export var mapa: Mapa

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Pelota:
		if lado == "izquierda":
			Global.puntos_j2 += 1
			if Global.puntos_j2 != 10:
				labelPuntos.text = str(Global.puntos_j2)
				mapa.otraRonda()
			else:
				body.queue_free() 
				Global.nombreGanador = Global.nombreJugador2
				Global.nombrePerdedor = Global.nombreJugador
				await mapa.guardarMatch()
				get_tree().change_scene_to_file("res://scenes/ganador.tscn")
		else:
			Global.puntos_j1 += 1
			if Global.puntos_j1 != 10:
				labelPuntos.text = str(Global.puntos_j1)
				mapa.otraRonda()
			else:
				body.queue_free() 
				Global.nombreGanador = Global.nombreJugador
				Global.nombrePerdedor = Global.nombreJugador2
				await mapa.guardarMatch()
				get_tree().change_scene_to_file("res://scenes/ganador.tscn")
