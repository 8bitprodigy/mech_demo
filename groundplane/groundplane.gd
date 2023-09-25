extends StaticBody3D

@export var ground_texture : Texture

# Called when the node enters the scene tree for the first time.
func _ready():
	top_level = true
	if ground_texture:
		$MeshInstance3D.get_active_material(0).texture = ground_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera : Camera3D = get_viewport().get_camera_3d()
	if camera:
		global_position = camera.global_position
		global_position.y = 0
