extends Spatial

# Script ini digunakan untuk membatasi agar mobil tidak terlalu jauh

var car
var firstPosition

func _ready():
	car = get_child(0)
	firstPosition = car.transform

func _physics_process(delta):
	if car.translation.x > 200 or car.translation.x < -500 or car.translation.z > 400 or car.translation.z < -400:
		car.transform = firstPosition
		car.linear_velocity = Vector3() 

