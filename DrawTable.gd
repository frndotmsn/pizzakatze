extends Node2D

var width: float = 4
var drawing = false
var last_mouse_position: Vector2
@export var current_color: Color = Color.RED
@onready var rect = $ColorRect
var width = 6
var points = {}

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
		elif event.is_action_pressed("right_click"):
			print("Right Click!")
			roundness()
		
		if event is InputEventMouseMotion and drawing:
			var xy = [get_local_mouse_position().x, get_local_mouse_position().y]
			if points.has(current_color):
				points[current_color].append(xy)
			else:
				points[current_color] = [xy]
			_draw_line()
			last_mouse_position = get_local_mouse_position()

func _draw_line():
	var line2d = Line2D.new()
	line2d.width = width
	line2d.add_point(last_mouse_position + (last_mouse_position - get_local_mouse_position()).normalized())
	line2d.add_point(get_local_mouse_position() + (get_local_mouse_position() - last_mouse_position).normalized())
	line2d.default_color = current_color
	line2d.antialiased = true
	add_child(line2d)

func roundness():
	if points.has(Color.BLACK):
		return call_roundness_api(points[Color.BLACK])
	else:
		print("Error! Keine Schwarzen Punkte!")
		
func call_roundness_api(poly):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._on_request_completed)

	var headers = ["Content-Type: application/json"]
	var body = JSON.stringify({"points": poly})

	# Perform the HTTP request. The URL below returns a PNG image as of writing.
	var error = http_request.request("http://localhost:3000/roundness", headers, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var roundness = json["roundness"]
	var incircle_radius = json["incircle_radius"]
	var circumcircle_radius = json["circumcircle_radius"]
	print(json["roundness"])
	if json["roundness"] > 0.5:
		print("Rund!")
	else:
		print("Nicht Rund!")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
