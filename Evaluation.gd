extends Node2D

@export var message : Label
@export var average_score: Label
@export var threshold : float
# Called when the node enters the scene tree for the first time.
func _ready():
	average_score.text = "%f" % Score.average
	if Score.average >= threshold:
		message.text = "won"
	else:
		message.text = "lost"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_to_main_screen_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
