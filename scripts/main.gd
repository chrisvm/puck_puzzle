extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set the player puck to the starting marker
	$Puck.position = $PuckStartingPosition.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
