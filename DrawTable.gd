extends Node2D

var drawing = false
var last_mouse_position: Vector2
@export var current_color: Color = Color.BLACK
@onready var rect = $ColorRect

func set_color(new_color):
	current_color = new_color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if rect.get_rect().has_point(get_local_mouse_position()):
		if event.is_action_pressed("left_click"):
			drawing = true
			last_mouse_position = get_local_mouse_position()
		elif event.is_action_released("left_click"):
			drawing = false
		
		if event is InputEventMouseMotion and drawing:
			_draw_line()
			last_mouse_position = get_local_mouse_position()

func _draw_line():
	var line2d = Line2D.new()
	line2d.add_point(last_mouse_position + (last_mouse_position - get_local_mouse_position()).normalized())
	line2d.add_point(get_local_mouse_position() + (get_local_mouse_position() - last_mouse_position).normalized())
	line2d.width = 6
	line2d.default_color = current_color
	line2d.antialiased = true
	add_child(line2d)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
