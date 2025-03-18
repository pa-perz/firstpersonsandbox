class_name PlayerInteractionSM extends StateMachine


func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	super(target_state_path, data)
	print(target_state_path)
