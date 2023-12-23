extends Node2D 
@export var buttons: Node2D
var current_button = 0

func _ready():
	for button in buttons.get_children():
		if button is Button:
			button.pressed.connect(next_button)
	display_button()

func next_button():
	current_button = current_button + 1
	if current_button == buttons.get_child_count():
		get_tree().change_scene_to_file("res://node_2d.tscn")
	else:
		display_button()
	
func display_button():
	for i in range (buttons.get_child_count()):
		if i != current_button:
			buttons.get_child(i).hide()
		else:
			buttons.get_child(i).show()

func T_main_menu():
	get_tree().change_scene_to_file("res://main_menu.tscn")
