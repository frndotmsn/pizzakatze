@icon("res://yellow_star.png")
class_name Star
extends Node2D

@onready var animation_player = $"AnimationPlayer"
@onready var yellow_star = $"YellowStar"

func set_yellow(yellow):
	yellow_star.visible = yellow

func play():
	animation_player.play("new_animation")
