extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func start_game():
		# set the player puck to the starting marker
	$Puck.position = $PuckStartingPosition.position
