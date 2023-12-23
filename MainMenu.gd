extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spiel_beginnen_pressed():
	get_tree().change_scene_to_file("res://node_2d.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Tutorial.tscn")
