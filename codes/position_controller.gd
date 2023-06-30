extends Spatial

# Script ini digunakan untuk membatasi agar mobil tidak terlalu jauh

var car
var firstPosition
var timer = Timer.new()
var flip = false
# Flip ini digunakan agar kode tidak terus berjalan dalam _physic_proccess

func _ready():
	car = get_child(0)
	firstPosition = car.transform
	timer.connect("timeout",self,"reset")
	timer.wait_time = 3
	timer.one_shot = true
	add_child(timer)

func _physics_process(delta):
	if (car.rotation_degrees.x < -150 or car.rotation_degrees.x > 150 or car.rotation_degrees.z < -150 or car.rotation_degrees.z > 150) and !flip :
		flip = true
		timer.start()	
	elif !(car.rotation_degrees.x < -150 or car.rotation_degrees.x > 150 or car.rotation_degrees.z < -150 or car.rotation_degrees.z > 150) and flip:
		flip = false
		timer.stop()
	
	if car.translation.x > 200 or car.translation.x < -500 or car.translation.z > 400 or car.translation.z < -400:
		reset()
	
func reset():
#	timer.stop()
	flip = false
	car.transform = firstPosition
	car.linear_velocity = Vector3() 


