class_name PlayerMovementState extends State

# Declare all possible movement states
const IDLE 		= "Idle"
const WALK 		= "Walk"
const RUN 		= "Run"
const JUMP 		= "Jump"
const AIR 		= "Air"

var player : Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
