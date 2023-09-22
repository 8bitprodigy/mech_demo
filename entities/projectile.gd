extends Node3D

@export var speed : float = 10.0
@export var lifespan : float = 10.0
@export var projectile_length : float = 1.0
@export var attack : AttackInfo
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _enter_tree() -> void:
	$RayCast3D.target_position = Vector3.FORWARD * projectile_length
	if lifespan > 0.0:
		await get_tree().create_timer(lifespan).timeout
		

var old_position : Vector3 = Vector3.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	#global_position = old_position + (-global_transform.basis.z * speed * delta)
	#var half_projectile_length_vector = -global_transform.basis.z*0.5*projectile_length
	$RayCast3D.position = old_position
	$RayCast3D.target_position = old_position + (Vector3.FORWARD * speed * delta)
	$Raycast3D.force_raycast_update()
	$MeshInstance3D.position = $RayCast3D.target_position - (Vector3.FORWARD*projectile_length/2)
	old_position = $RayCast3D.target_position - (Vector3.FORWARD*projectile_length)
