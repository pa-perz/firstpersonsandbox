extends PlayerMovementState


func physics_update(_delta: float) -> void:
	if player.is_on_floor():
		if player.input_dir.length() == 0:
			finished.emit(IDLE)
		else:
			if Input.is_action_pressed("run") and player.input_dir.y <= 0:
				finished.emit(RUN)
			else:
				finished.emit(WALK)
