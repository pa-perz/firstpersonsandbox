extends PlayerMovementState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.y += player.JUMP_VELOCITY
	finished.emit(AIR)
