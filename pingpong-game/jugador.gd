extends CharacterBody2D

@export_enum("ws", "arrows") var controls: String = "ws"
const SPEED = 300.0

func _physics_process(delta: float) -> void:
	var direction := 0.0
	
	if controls == "ws":
		direction = Input.get_axis("w", "s")
	else:
		direction = Input.get_axis("ui_up", "ui_down")
	
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	velocity.x = 0

	move_and_slide()
