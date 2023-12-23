class_name Sterne
extends CenterContainer

var stern_scene = preload("res://Stern.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func play(score):
	show()
	print(show)
	
	for i in range(get_children().size()):
		var stern = get_child(i)
		if stern is Star:
			stern.set_yellow(i < score)

	for stern in get_children():
		if stern is Star:
			stern.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
