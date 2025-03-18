class_name InteractableObject extends RigidBody3D


const USE_ACTION = "Use"
const GRAB_ACTION = "Grab"
const STORE_ACTION = "Store"

@export var interactable_name: String = "Replace my name"
@export var grab_distance: Vector3 = Vector3(0,0,-2)

var interactions: Array[String]
var selected_interaction: int = 0
var is_grabbed = false
var target_position: Vector3
var move_force: float = 20.0
@export var stiffness: float = 50.0  # Spring strength
@export var damping: float = 10.0    # Damping to reduce overshoot



func _ready() -> void:
	selected_interaction = 0 if interactions and !interactions.is_empty() else null
	freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	

func _physics_process(delta: float) -> void:
	if is_grabbed:
		var camera_transform = Global.player.camera_controller.global_transform
		target_position = camera_transform.translated_local(grab_distance).origin
		
		var distance = global_transform.origin.distance_to(target_position)
		var direction = (target_position - global_transform.origin).normalized()
		
		apply_central_force(direction * move_force * clamp(distance, 0, 1))


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if target_position:
		var position_error = target_position - global_transform.origin
		var velocity_error = -state.linear_velocity

		var force = (position_error * stiffness) + (velocity_error * damping)
		state.apply_central_force(force)


func use(by: Player) -> void:
	pass


func grab(by: Player) -> void:
	is_grabbed = true
	gravity_scale = 0.0
	

func store(by: Player) -> void:
	queue_free()


func next_selected() -> void:
	if selected_interaction == interactions.size() - 1:
		selected_interaction = 0
	else:
		selected_interaction += 1


func previous_selected() -> void:
	if selected_interaction == 0:
		selected_interaction = interactions.size() - 1
	else:
		selected_interaction -= 1
