class_name DrawingColorRect
extends ColorRect

var drawing: bool = false
var last_mouse_position: Vector2
@export var width_slider: HSlider
@export var current_color: Color

func clear():
	for child in get_children(): 
		if child is Line2D:
			child.queue_free()

func _input(event):
	if get_rect().has_point(get_local_mouse_position()):
		if event.is_action_pressed("left_click"):
			drawing = true
			last_mouse_position = get_local_mouse_position()
			begin.emit(get_local_mouse_position())
		elif event.is_action_released("left_click"):
			drawing = false
		
		if event is InputEventMouseMotion and drawing:
			new_line.emit(last_mouse_position, get_local_mouse_position())
			_draw_line()
			last_mouse_position = get_local_mouse_position()

signal begin(from)

signal new_line(previous, next)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw_line():
	var width = width_slider.value
	var line2d = Line2D.new()
	line2d.width = width
	line2d.add_point(last_mouse_position + (last_mouse_position - get_local_mouse_position()).normalized() * width)
	line2d.add_point(get_local_mouse_position() + (get_local_mouse_position() - last_mouse_position).normalized() * width)
	line2d.default_color = current_color
	line2d.antialiased = true
	add_child(line2d)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
