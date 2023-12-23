extends Node

var ten_second_timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	ten_second_timer = Timer.new()
	ten_second_timer.wait_time = 10
	ten_second_timer.timeout.connect(_on_timeout)

func 
