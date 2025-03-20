extends PlayerInteractionState

@export var impulse_strength := 5.0


func enter(previous_state_path: String, data := {}) -> void:
	player.interaction_panel.hide_ui()


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		finished.emit(IDLE)
	if Input.is_action_just_pressed("primary"):
		var impulse_direction =  player.camera_controller.global_transform.origin.direction_to(player.object.global_transform.origin).normalized()
		player.object.apply_impulse(impulse_direction * impulse_strength)
		finished.emit(IDLE)
		


func exit() -> void:
	player.object.is_grabbed = false
	player.object.gravity_scale = 1.0
	player.object.target_position = Vector3.ZERO
