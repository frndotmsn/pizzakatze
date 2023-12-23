extends Node2D

@export var message : Label
@export var average_score: Label
@export var threshold : float
@export var total_points : Label
@export var highscore : Label
@export var highscore_pizzas : Label
@export var old_or_new_highscore : Label
# Called when the node enters the scene tree for the first time.
func _ready():
	average_score.text = "%f" % Score.average()
	total_points.text = "%f" % Score.total()
	if Score.average() >= threshold:
		message.text = "won"
	else:
		message.text = "lost"
	
	if Score.total() <= Score.highscore:
		old_or_new_highscore.text = "Alter"
		highscore.text = "%f" % Score.highscore
		highscore_pizzas.text = "%d" % Score.highscore_pizzas
	else:
		Score.highscore = Score.total()
		Score.highscore_pizzas = Score.scores_of_the_day.size()
		old_or_new_highscore.text = "Neuer"
		highscore.text = "%f" % Score.highscore
		highscore_pizzas.text = "%d" % Score.highscore_pizzas

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_to_main_screen_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
