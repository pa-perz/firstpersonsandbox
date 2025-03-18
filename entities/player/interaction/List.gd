extends PlayerInteractionState


func enter(previous_state_path: String, data := {}) -> void:
	player.object = data["object"]
	player.object.selected_interaction = 0 if player.object.interactions and !player.object.interactions.is_empty() else null
	player.interaction_panel.update_ui(player.object.interactable_name, player.object.interactions, player.object.selected_interaction)


func physics_update(delta: float) -> void:
	var new_obj = player.interaction_raycast.get_collider()
	if not new_obj:
		finished.emit(IDLE)
	if new_obj:
		if new_obj != player.object:
			finished.emit(LIST, {"object": new_obj})
		else:
			if Input.is_action_just_pressed("next_interaction"):
				player.object.next_selected()
				player.interaction_panel.update_ui(player.object.interactable_name, player.object.interactions, player.object.selected_interaction)
			if Input.is_action_just_pressed("previous_interaction"):
				player.object.previous_selected()
				player.interaction_panel.update_ui(player.object.interactable_name, player.object.interactions, player.object.selected_interaction)
			if Input.is_action_just_pressed("interact"):
				match player.object.interactions[player.object.selected_interaction]:
					player.object.USE_ACTION:
						player.object.use(player)
					player.object.GRAB_ACTION:
						player.object.grab(player)
						finished.emit(GRAB)
					player.object.STORE_ACTION:
						player.object.store(player)
