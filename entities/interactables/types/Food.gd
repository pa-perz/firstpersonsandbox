extends InteractableObject

@export var food_name: String = "Replace food name"
@export var heal_value: float = +10.0


func _ready() -> void:
	interactable_name = food_name
	interactions.append_array([USE_ACTION, GRAB_ACTION, STORE_ACTION])
	super()


func use(by: Player) -> void:
	by.stats.update_health(heal_value)
