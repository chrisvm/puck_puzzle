extends Node2D

@export var radius = 60
var color: Color = Color.WHITE
var dragging: bool = false
var delta: Vector2 = Vector2.ZERO



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
	var theta = -(delta).angle_to(Vector2.UP)
	for end in endpoints:
		var new_end = Vector2(	
			cos(theta) * end.x - sin(theta) * end.y, 
			sin(theta) * end.x + cos(theta) * end.y
		)
		draw_line(-delta, -delta + new_end, Color.BROWN, 4)
	
