extends Node3D
class_name Gun

@export_node_path("InputSynchronizer") var _input_synchronizer : NodePath
@onready var input : Node = get_node(_input_synchronizer)
@export_node_path("Marker3D") var _muzzle_point : NodePath
@onready var muzzle : Node = get_node(_muzzle_point)
@export var refactory_time : float = 1.0

signal fire_projectile
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if !visible: return
	if input.is_primary_firing: fire.rpc()
	pass

var can_fire : bool = true
@rpc
func fire() -> void:
	if !can_fire : return
	#TODO: trigger flashy firing effects
	if !multiplayer.is_server(): return
	can_fire = false
	emit_signal("fire_projectile", multiplayer.get_unique_id())
	await get_tree().create_timer(refactory_time).timeout
	can_fire = true
	
