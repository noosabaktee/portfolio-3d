extends Node2D

func _ready():
	yield(get_tree().create_timer(3.0), "timeout")
	play()


func play():
	get_tree().change_scene("res://scenes/Spatial.tscn")
