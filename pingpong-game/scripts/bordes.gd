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
			labelPuntos.text = str(Global.puntos_j2)
		else:
			Global.puntos_j1 += 1
			labelPuntos.text = str(Global.puntos_j1)
		mapa.otraRonda()
	pass # Replace with function body.
