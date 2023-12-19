extends Node2D

var width: float = 4
var drawing = false
var last_mouse_position: Vector2
@export var current_color: Color = Color.RED
@onready var rect = $ColorRect

func set_width(new_width):
	width = new_width

func clear():
	for child in get_children(): 
		if child is Line2D:
			child.queue_free()
			
		

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

var my_dict = {}

func _draw_line():
	var tupel=[last_mouse_position,get_local_mouse_position()]
	if my_dict.has(current_color):
		my_dict[current_color].append(tupel)
	else:
		my_dict[current_color]=[tupel]
	var line2d = Line2D.new()
	line2d.width = width
	line2d.add_point(last_mouse_position + (last_mouse_position - get_local_mouse_position()).normalized())
	line2d.add_point(get_local_mouse_position() + (get_local_mouse_position() - last_mouse_position).normalized())
	line2d.default_color = current_color
	line2d.antialiased = true
	add_child(line2d)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
