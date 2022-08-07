extends KinematicBody

export(Texture) var image
onready var screen = get_node("Screen")
onready var material_one = screen.get_surface_material(0)

func _ready():
	material_one.albedo_texture = image
	screen.set_surface_material(0, material_one)


