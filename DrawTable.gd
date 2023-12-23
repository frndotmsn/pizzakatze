extends Node2D

var drawing = false
var last_mouse_position: Vector2
@export var current_color: Color = Color.RED
@export var sterne: Sterne
@export var rect : DrawingColorRect
@export var win_threshold: float
@export var google_review_label: Label
@export var pizzas_served : Label
@export var average_stars : Label

var points = {}

var scores = []

func average_score():
	return (float(scores.reduce(sum, 0))/float(scores.size()))

func evaluate_day():
	Score.set_average(average_score())
	get_tree().change_scene_to_file("res://evaluation.tscn")

func sum(accumulator, next):
	return accumulator + next

func add_score(score: int):
	scores.append(score)
	
func clear():
	points = {}
	rect.clear()

func set_color(new_color):
	current_color = new_color
	rect.current_color = current_color

# Called when the node enters the scene tree for the first time.
func _ready():
	LoadGoogleReview.google_pizza_review_requester.done.connect(_on_pizza_generated)
	LoadGoogleReview.neue_pizza()

func _on_pizza_generated(review):
	google_review_label.text = "Google Rezension der bestellten Pizza: %s" % review

func in_den_ofen_schieben():
	roundness()

func reveal_score(score: int):
	sterne.play(score)
	add_score(score)

func hide_score():
	sterne.hide()

func roundness():
	var dough_color = Color8(240, 165, 124).to_rgba32()
	
	if points.has(dough_color):
		return call_roundness_api(points[dough_color])
	else:
		print("Error! Keine Teigfarbenen Punkte!")
		
func call_roundness_api(poly):
	$RoundnessCalculator.calculate(PackedVector2Array(poly))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_roundness_calculator_roundness(incircle_radius, circumcircle_radius, incircle_center, circumcircle_center, roundness):
	var optimal_circle_radius = (incircle_radius+circumcircle_radius)/2 
	var optimal_circle_center = (incircle_center+circumcircle_center)/2
	print(_sauce_calculator(optimal_circle_radius,optimal_circle_center))
	
	reveal_score(round(roundness * 5))

func add_point(point):
	var rgba_current_color = current_color.to_rgba32()
	if points.has(rgba_current_color):
		points[rgba_current_color].append(point)
	else:
		points[rgba_current_color] = [point]

func _on_color_rect_new_line(previous, next):
	add_point(next)

func _on_roundness_calculator_invalid_polygon():
	print("Invalid Polygon")
	reveal_score(0)
	clear()
	
func _sauce_calculator(optimal_circle_radius,optimal_circle_center):
	return points_of_color_in_optimal_circle(Color.RED, optimal_circle_radius, optimal_circle_center)
	
func points_of_color_in_optimal_circle(color, optimal_circle_radius, optimal_circle_center):
	if points.has(color.to_rgba32()):
		var red_points = points[color.to_rgba32()]
		var red_points_with_distances_to_optimal_circle_center = red_points.map(func(point): return [point, point.distance_to(optimal_circle_center)])
		var red_points_inside_optimal_circle = red_points_with_distances_to_optimal_circle_center.filter(func(point_with_distance): return point_with_distance[1] <= optimal_circle_radius*0.9)
		if not red_points.size() == 0:
			return (red_points_inside_optimal_circle.size() as float)/(red_points.size() as float)
		else:
			return 1
	else:
		return 0

func _on_color_rect_begin(from):
	add_point(from)

func _on_tomato_button_pressed():
	set_color(Color.RED)

func _on_mozarella_button_pressed():
	set_color(Color.GHOST_WHITE)

func _on_dough_button_pressed():
	set_color( Color8(240, 165, 124))

func _on_salami_button_pressed():
	set_color(Color.DEEP_PINK)

func _on_prosciutto_button_pressed():
	set_color(Color.PINK)

func _on_rucola_button_pressed():
	set_color(Color.WEB_GREEN)

func _on_basil_button_pressed():
	set_color(Color.SEA_GREEN)

func _on_pineapple_button_pressed():
	set_color(Color.YELLOW)

func _on_olives_button_pressed():
	set_color(Color.BLACK)

func _on_pesto_button_pressed():
	set_color(Color.DARK_GREEN)

func _on_next_pizza_pressed():
	hide_score()
	LoadGoogleReview.neue_pizza()
	clear()
	pizzas_served.text = "Bisher servierte Pizzen: %d" % scores.size()
	average_stars.text = "Durchschnittliche Sterne:\n%f" % average_score()
	if scores.size() == 3:
		evaluate_day()

func _on_new_pizza_pressed():
	LoadGoogleReview.neue_pizza()
