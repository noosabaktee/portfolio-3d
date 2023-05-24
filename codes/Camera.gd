extends Camera

onready var vehicle = get_parent().get_node("Vehicle/VehicleBody")


func _process(delta):
#	transform.origin.y = vehicle.transform.origin.y + 30 #+ offset
	transform.origin.z = vehicle.transform.origin.z - 30 #+ offset
	transform.origin.x = vehicle.transform.origin.x - 12.5 #+ offset
