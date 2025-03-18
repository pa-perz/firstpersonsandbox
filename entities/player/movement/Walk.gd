extends PlayerMovementState


func enter(previous_state_path: String, data := {}) -> void:
	player.current_speed = player.WALK_SPEED


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	if Input.is_action_pressed("run") and player.input_dir.y <= 0:
		finished.emit(RUN)
	if player.input_dir.length() == 0.0:
		finished.emit(IDLE)
