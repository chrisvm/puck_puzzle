extends RigidBody2D

@export var impulse_force: float = 40.0

var dragging: bool:
	set(value):
		$PuckCanvas.dragging = value
	get:
		return $PuckCanvas.dragging

var radius: int:
	set(value):
		$PuckCanvas.radius = value
	get:
		return $PuckCanvas.radius
		
var delta: Vector2:
	set(value):
		$PuckCanvas.delta = value
	get:
		return $PuckCanvas.delta

var _score: int
var score: int:
	set(value):
		_score = value
		$Label.text = str(value)
	get:
		return _score
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CollisionShape2D.shape.radius = radius
	score = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if radius changed, set the collision shape radius and redraw.
	if $CollisionShape2D.shape.radius != radius:
		$CollisionShape2D.shape.radius = radius

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var length_from_center = (event.position - position).length()
		if length_from_center < radius:
			# Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				dragging = true
				delta = event.position - position
				$PuckCanvas.queue_redraw()
			
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false
			shove(-delta * impulse_force)
			delta = Vector2.ZERO
			$PuckCanvas.queue_redraw()
	
	if event is InputEventMouseMotion and dragging:
		delta = event.position - position
		$PuckCanvas.queue_redraw()
	
func shove(direction: Vector2):
	apply_central_force(direction)
	score -= 1
