class_name PlayerStats extends Node

# Player stats
@export var current_health: float = 50.0
@export var min_health: float = 0.0
@export var max_health: float = 100.0

@onready var health_label: Label = %HealthLabel

func update_health(value: float):
	current_health = clamp(current_health + value, min_health, max_health)
	if current_health <= min_health:
		# TODO: implement player death
		pass


func _physics_process(delta: float) -> void:
	health_label.text = "Health: " + str(current_health)
