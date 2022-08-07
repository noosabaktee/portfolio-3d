extends VehicleBody

# ------------------------------------------------
# Script author: Bastiaan Olij, modified by Warrpy
# ------------------------------------------------

############################################################
# behaviour values

export var MAX_ENGINE_FORCE = 200.0
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

var steer_target = 0.0
var steer_angle = 0.0

############################################################
# Input

export var joy_steering = JOY_ANALOG_LX
export var steering_mult = -1.0
export var joy_throttle = JOY_ANALOG_R2
export var throttle_mult = 1.0
export var joy_brake = JOY_ANALOG_L2
export var brake_mult = 1.0

# Get global vaariables
onready var vars = get_node("/root/Variables")
onready var engine = get_parent().get_node("Sound/Engine")
onready var brake_sound = get_parent().get_node("Sound/Brake")
onready var crash2 = get_parent().get_node("Sound/Crash2")
onready var crash = get_parent().get_node("Sound/Crash")
onready var bata = get_parent().get_node("Sound/Bata")

var las_velocity = 0
var last_move = 0 #1 = maju, 2= mundur
var info = ""


func _physics_process(delta):
	var steer_val = steering_mult * Input.get_joy_axis(0, joy_steering)
	var throttle_val = throttle_mult * Input.get_joy_axis(0, joy_throttle)
	var brake_val = brake_mult * Input.get_joy_axis(0, joy_brake)
	
	if Input.is_action_pressed("ui_up") or vars.maju == true:
		throttle_val = 1.0
	if Input.is_action_pressed("ui_down") or vars.mundur == true:
		throttle_val = -1.0
	if Input.is_action_pressed("ui_accept") or vars.rem == true:
		brake_val = 1.0
	if Input.is_action_pressed("ui_left") or vars.kiri == true:
		steer_val = 1.0
	if Input.is_action_pressed("ui_right") or vars.kanan == true:
		steer_val = -1.0
	
	engine_force = throttle_val * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	
	steer_target = steer_val * MAX_STEER_ANGLE
	if (steer_target < steer_angle):
		steer_angle -= steer_speed * delta
		if (steer_target > steer_angle):
			steer_angle = steer_target
	elif (steer_target > steer_angle):
		steer_angle += steer_speed * delta
		if (steer_target < steer_angle):
			steer_angle = steer_target
	steering = steer_angle
	
#	if Input.is_action_pressed("ui_up") or vars.maju == true:
#		if las_velocity <= 0:
#			if linear_velocity.z > 0.3:
##				if engine.pitch_scale <= 1.2:
##					engine.pitch_scale += 0.01
#				info = "maju"
#		elif las_velocity >= 0:
#			if linear_velocity.z < -0.3:
##				if engine.pitch_scale <= 1.2:
##					engine.pitch_scale += 0.01		
#				info = "maju"
#	elif Input.is_action_pressed("ui_down") or vars.mundur == true:
#		if las_velocity <= 0:
#			if linear_velocity.z < -0.3:
##				if engine.pitch_scale <= 1:
##					engine.pitch_scale += 0.01
#					info = "mundur"
#		elif las_velocity >= 0:
#			if linear_velocity.z > 0.3:
##				if engine.pitch_scale <= 1:
##					engine.pitch_scale += 0.01
#					info = "mundur"
#	elif Input.is_action_just_pressed("ui_accept") or vars.rem == true:
#		if linear_velocity.z < -0.3 or linear_velocity.z > 0.3:
#			brake_sound.play()
#	else:
#		if engine.pitch_scale >= 0.8:
#			engine.pitch_scale -= 0.01
#
#	if Input.is_action_just_released("ui_up"):
#		las_velocity = linear_velocity.z
#	elif Input.is_action_just_released("ui_down"):
#		las_velocity = linear_velocity.z
#	elif Input.is_action_just_released("ui_accept"):
#		las_velocity = linear_velocity.z
#		print(info)




func _on_Area_body_entered(body):
	if body is KinematicBody or body is StaticBody:
		if linear_velocity.z > 1 or linear_velocity.z < -1:
			crash.play()
		elif body.name == "Plane":
			crash2.play()
#	elif body is RigidBody:
#		bata.play()
#		if body.name == "Plane":
#			crash2.play()
#		else:
#			crash.play()

