extends Node2D

var scores_of_the_day = []
var highscore : float = 0
var highscore_pizzas : int = 0

func average():
	return float(total())/float(scores_of_the_day.size())

func total():
	return scores_of_the_day.reduce(func(a, b): return a+b, 0)
