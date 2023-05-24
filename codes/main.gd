extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ballonAnim = get_node("About/Ballon/AIr Ballon/AnimationPlayer")
onready var message = get_node("UI/Message")
onready var arrow = get_node("UI/Arrow")
onready var button = get_node("UI/Button")

var window_y 
var closeDown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	window_y = get_viewport().size.y
#	if OS.get_name() == "Windows":
#	arrow.visible = false
#	button.visible = false
	message.rect_position.y = window_y + 200
	ballonAnim.play("Ballon Anim");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	window_y = get_viewport().size.y
	if closeDown == true:
		if OS.get_name() == "Android":
			arrow.visible = true
			button.visible = true
	if message.rect_position.y >= (window_y - 160) and closeDown == false:
		message.rect_position -= Vector2(0,3)
	if closeDown == true and message.rect_position.y <= 650:
		message.rect_position += Vector2(0,3)
#	print(get_viewport().size.y)

func _on_Close_button_down():
	closeDown = true





