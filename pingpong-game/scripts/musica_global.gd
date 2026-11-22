extends Node

@onready var musica_fondo: AudioStreamPlayer2D = $MusicaFondo
@onready var sonido_rebote: AudioStreamPlayer2D = $rebote

func reproducir_rebote() -> void:
	sonido_rebote.play()
