extends Node3D

@onready var input = get_parent().input
# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().connect("size_changed", update_indicator)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera3D/Node2D/legs.rotation = get_parent().get_node("turret").rotation.y

func update_indicator():
	$Camera3D/Node2D.position = get_viewport().size/2
