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
var canPlayCrashSound = true
var canPlayCrashSound2 = true
var canPlayBrakeSound = true


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
	
	if vars.rem == false:
		canPlayBrakeSound = true
		
	if Input.is_action_just_pressed("ui_accept") or (vars.rem == true and canPlayBrakeSound == true):
		if linear_velocity.z < -0.3 or linear_velocity.z > 0.3:
			brake_sound.play()
			canPlayBrakeSound = false
	elif Input.is_action_pressed("ui_up") or vars.maju == true:
		if get_rotation_degrees().y >= -90 and get_rotation_degrees().y <= 90:
			if linear_velocity.z >= 0.3:
				if engine.pitch_scale <= 1.2:
					engine.pitch_scale += 0.01
		elif (get_rotation_degrees().y >= -180 and get_rotation_degrees().y <= -90) or get_rotation_degrees().y > 180:
			if linear_velocity.z <= -0.3:
				if engine.pitch_scale <= 1.2:
					engine.pitch_scale += 0.01
	elif Input.is_action_pressed("ui_down") or vars.mundur == true:
		if get_rotation_degrees().y >= -90 and get_rotation_degrees().y <= 90:
			if linear_velocity.z <= -0.3:
				if engine.pitch_scale <= 1:
					engine.pitch_scale += 0.01
				elif engine.pitch_scale >= 1:
					engine.pitch_scale -= 0.01
		elif (get_rotation_degrees().y >= -180 and get_rotation_degrees().y <= -90) or get_rotation_degrees().y > 180:
			if linear_velocity.z >= 0.3:
				if engine.pitch_scale <= 1:
					engine.pitch_scale += 0.01
				elif engine.pitch_scale >= 1:
					engine.pitch_scale -= 0.01
	else:
		if engine.pitch_scale >= 0.8:
			engine.pitch_scale -= 0.01	
			
func _on_Area_body_entered(body):
	if body is KinematicBody or body is StaticBody:
		if body.name == "Plane":
			if canPlayCrashSound2:
				crash2.play()
				canPlayCrashSound2 = false
			var t2 = Timer.new()
			t2.set_wait_time(1)
			t2.set_one_shot(true)
			self.add_child(t2)
			t2.start()
			yield(t2, "timeout")
			t2.queue_free()	
			canPlayCrashSound2 = true
		elif body.name != "Plane":
			if  linear_velocity.z > 1 or linear_velocity.z < -1:
				if canPlayCrashSound:
					crash.play()
					canPlayCrashSound = false
				var t = Timer.new()
				t.set_wait_time(1)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()	
				canPlayCrashSound = true	
	elif body is RigidBody and body.get_collision_layer() == 9 and body.collide == false:
		print(body.get_collision_layer())
		bata.play()
		body.collide = true
		

func _on_Area_body_exited(body):
	if body is RigidBody and body.get_collision_layer() == 9 and body.collide == true:
		body.collide = false
