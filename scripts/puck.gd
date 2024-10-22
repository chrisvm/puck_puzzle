extends Node2D

@export var radius = 60
var color: Color = Color.WHITE
var dragging: bool = false
var delta: Vector2 = Vector2.ZERO
var current_mouse_pos: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RigidBody2D/CollisionShape2D.shape.radius = radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if radius changed, set the collision shape radius and redraw.
	if $RigidBody2D/CollisionShape2D.shape.radius != radius:
		$RigidBody2D/CollisionShape2D.shape.radius = radius
		queue_redraw()

func _draw() -> void:
	if dragging:
		color = Color.AQUAMARINE
	else:
		color = Color.WHITE
	
	draw_circle(position, radius, color, false, 4)
	draw_line(position, current_mouse_pos, Color.BROWN)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.position - position).length() < radius:
			# Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				dragging = true
				current_mouse_pos = event.position
			
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false
			current_mouse_pos = Vector2.ZERO
	
	if event is InputEventMouseMotion and dragging:
		current_mouse_pos = event.position
	
	queue_redraw()
