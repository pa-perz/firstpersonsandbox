class_name InteractionPanel extends Control

@onready var vbox: VBoxContainer = $VBoxContainer

func _ready() -> void:
	position.x += 120.0

func update_ui(object_name: String, actions: Array, selected_interaction: int):
	for child in vbox.get_children():
		child.queue_free()
	
	var name_button = Button.new()
	name_button.text = object_name
	vbox.add_child(name_button)

	# Add new actions
	var count = 1
	for action in actions:
		var button = Button.new()
		button.text = str(count) + ". " + action
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.toggle_mode = true
		if count == selected_interaction + 1:
			button.button_pressed = true
		count += 1
		vbox.add_child(button)

	visible = true

func hide_ui() -> void:
	visible = false
