extends Node3D

@export var sky : SkyboxResource
var shader : Shader = preload("res://skybox/skybox.gdshader")
@export var sky_rotation : Vector3 = Vector3(0.0,0.0,0.0)
@export var rotation_axis : Vector3 = Vector3(0.0,1.0,0.0)
@export var rotation_speed : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	global_rotation = sky_rotation
	top_level = true
	
	var up_shader : ShaderMaterial = ShaderMaterial.new()
	up_shader.shader = shader
	up_shader.set_shader_parameter("texture_albedo",sky.up)
	$cube.mesh.surface_set_material(0,up_shader )
	
	var down_shader : ShaderMaterial = ShaderMaterial.new()
	down_shader.shader = shader
	down_shader.set_shader_parameter("texture_albedo",sky.down)
	$cube.mesh.surface_set_material(1,down_shader)
	
	var north_shader : ShaderMaterial = ShaderMaterial.new()
	north_shader.shader = shader
	north_shader.set_shader_parameter("texture_albedo",sky.north)
	$cube.mesh.surface_set_material(3,north_shader)
	
	var south_shader : ShaderMaterial = ShaderMaterial.new()
	south_shader.shader = shader
	south_shader.set_shader_parameter("texture_albedo",sky.south)
	$cube.mesh.surface_set_material(2,south_shader)
	
	var east_shader : ShaderMaterial = ShaderMaterial.new()
	east_shader.shader = shader
	east_shader.set_shader_parameter("texture_albedo",sky.east)
	$cube.mesh.surface_set_material(5,east_shader)
	
	var west_shader : ShaderMaterial = ShaderMaterial.new()
	west_shader.shader = shader
	west_shader.set_shader_parameter("texture_albedo",sky.west)
	$cube.mesh.surface_set_material(4,west_shader)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera : Camera3D = get_viewport().get_camera_3d()
	if camera:
		global_position = camera.global_position
		global_transform.basis = global_transform.basis.rotated(rotation_axis,rotation_speed*delta)
