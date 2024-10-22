extends Node2D

var dragging: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RigidBody2D/CollisionShape2D.shape.radius = $PuckCanvas.radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var radius = $PuckCanvas.radius
	# if radius changed, set the collision shape radius and redraw.
	if $RigidBody2D/CollisionShape2D.shape.radius != radius:
		$RigidBody2D/CollisionShape2D.shape.radius = radius
		$PuckCanvas.queue_redraw()

func _input(event):
	var delta = Vector2.ZERO
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var length_from_center = (event.position - position).length()
		var radius = $PuckCanvas.radius
		
		if length_from_center < radius:
			# Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				dragging = true
				delta = event.position - position
				$PuckCanvas.queue_redraw()
			
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false
			$PuckCanvas.queue_redraw()
	
	if event is InputEventMouseMotion and dragging:
		delta = event.position - position
		$PuckCanvas.queue_redraw()
	
	$PuckCanvas.delta = delta
