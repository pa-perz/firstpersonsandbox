extends PlayerMovementState


func enter(previous_state_path: String, data := {}) -> void:
	player.current_speed = player.IDLE_SPEED


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	if player.input_dir.length() > 0.0:
		if Input.is_action_pressed("run") and player.input_dir.y <= 0:
			finished.emit(RUN)
		else:
			finished.emit(WALK)
