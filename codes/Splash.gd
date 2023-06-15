extends Node2D
onready var _transition_rect = $SceneTransitionRect

func _on_TouchScreenButton_pressed():
	get_tree().change_scene("res://scenes/Spatial.tscn")
