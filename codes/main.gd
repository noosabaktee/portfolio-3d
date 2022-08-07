extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ballonAnim = get_node("About/Ballon/AIr Ballon/AnimationPlayer")
onready var message = get_node("UI/Message")
onready var arrow = get_node("UI/Arrow")
onready var button = get_node("UI/Button")

var closeDown = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	if OS.get_name() == "Windows":
	arrow.visible = false
	button.visible = false
	ballonAnim.play("Ballon Anim");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if closeDown == true:
		if OS.get_name() == "Android":
			arrow.visible = true
			button.visible = true
	if message.rect_position.y >= 440 and closeDown == false:
		message.rect_position -= Vector2(0,3)
	if closeDown == true and message.rect_position.y <= 650:
		message.rect_position += Vector2(0,3)


func _on_Close_button_down():
	closeDown = true





