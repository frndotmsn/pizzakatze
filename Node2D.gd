extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var andereSzene = preload("res://node_2d.tscn")

func ändereScene():
	get_tree().root.add_child(andereSzene.instantiate())
