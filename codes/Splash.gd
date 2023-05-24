extends Node2D
onready var _transition_rect = $SceneTransitionRect

func _ready():
	yield(get_tree().create_timer(1), "timeout")
#	get_tree().change_scene("res://scenes/Spatial.tscn")


