class_name Player extends CharacterBody3D

# Movement Variables
const IDLE_SPEED = 0.0
const WALK_SPEED = 4.0
const RUN_SPEED = 6.0
const JUMP_VELOCITY = 7.0
const ACCELERATION_RATE = 5.0
const DECELERATION_RATE = 8.5

@export var camera_controller : Node3D
@onready var stats = %PlayerStats

var mouse_sens_x = 0.1
var mouse_sens_y = 0.1

var input_dir := Vector2.ZERO
var direction := Vector3.ZERO
var current_speed := IDLE_SPEED

var object: InteractableObject
@onready var interaction_raycast: RayCast3D = %InteractionRaycast
@onready var interaction_panel: InteractionPanel = %InteractionPanel


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.player = self


func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_handle_camera_rotation(event)


func _handle_camera_rotation(event: InputEvent):
	rotate_y(deg_to_rad(-event.relative.x * mouse_sens_y))
	camera_controller.rotate_x(deg_to_rad(-event.relative.y * mouse_sens_x))
	camera_controller.rotation.x = clamp(camera_controller.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * 2 * delta
	else:
		input_dir = Input.get_vector("mv_left", "mv_right", "mv_fwd", "mv_back")
		if input_dir:
			direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * ACCELERATION_RATE)
			velocity.x = direction.x * current_speed
			velocity.z = direction.z * current_speed
		else:
			direction = lerp(direction, Vector3.ZERO, delta * DECELERATION_RATE)
			velocity.x = direction.x
			velocity.z = direction.z
	
	move_and_slide()
