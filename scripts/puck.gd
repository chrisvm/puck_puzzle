extends Node2D

@export var radius = 60
var color: Color = Color.WHITE
var dragging: bool = false
var delta: Vector2 = Vector2.ZERO

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
	color = Color.AQUAMARINE if dragging else Color.WHITE
	draw_circle(Vector2.ZERO, radius, color, false, 4)

	if dragging:
		draw_force_arrow()
		
func draw_force_arrow():
	draw_dashed_line(Vector2.ZERO, -delta, Color.BROWN, 4, delta.length()/10.0)
	draw_circle(Vector2.ZERO, 10, Color.BROWN, true)

	# arrow
	var endpoints = [Vector2(-10, 20), Vector2(10, 20)]
	var theta = (-delta).angle_to(Vector2.UP)
	for end in endpoints:
		var new_end = Vector2(cos(theta) * end.x - sin(theta) * end.y, sin(theta) * end.x + cos(theta) * end.y)
		end.x = new_end.x
		end.y = new_end.y
	
	draw_line(-delta, -delta + endpoints[0], Color.BROWN, 4)
	draw_line(-delta, -delta + endpoints[1], Color.BROWN, 4)
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var length_from_center = (event.position - position).length()
		print(length_from_center)
		print(event.position)
		if length_from_center < radius:
			# Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				dragging = true
				delta = event.position - position
			
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false
			delta = Vector2.ZERO
	
	if event is InputEventMouseMotion and dragging:
		delta = event.position - position
		
	queue_redraw()
