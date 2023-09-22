extends Marker3D
class_name ProjectileEmitter

signal fire_projectile

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _enter_tree():
	#if multiplayer.is_server():
	#	prints("ProjectileEmitter entered tree!")
	#	MultiplayerManager.register_gun(multiplayer.get_unique_id(),self)
	pass

@rpc
func fire():
	emit_signal("fire_projectile", multiplayer.get_unique_id())
