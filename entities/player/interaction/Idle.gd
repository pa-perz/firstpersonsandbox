extends PlayerInteractionState


func enter(previous_state_path: String, data := {}) -> void:
	player.object = null
	player.interaction_panel.visible = false


func physics_update(delta: float) -> void:
	var object = player.interaction_raycast.get_collider()
	if object and object is InteractableObject:
		finished.emit(LIST, {"object": object})
