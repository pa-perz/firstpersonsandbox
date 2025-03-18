class_name PlayerInteractionState extends State

# Declare all possible movement states
const IDLE 		= "Idle"
const LIST		= "List"
const USE		= "Use"
const GRAB 		= "Grab"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
