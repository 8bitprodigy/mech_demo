extends MultiplayerSynchronizer
class_name InputSynchronizer


@export var movement_vector : Vector3 = Vector3.ZERO
@export var rotation_vector : Vector3 = Vector3.ZERO
@export var leg_rotation    : float   = 0.0 
@export var rotation_basis  : Basis   = Basis.IDENTITY

@export var is_primary_firing   : bool = false
@export var is_secondary_firing : bool = false

func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())
	set_process_input(get_multiplayer_authority() == multiplayer.get_unique_id())

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#event.relative
		rotation_vector.x = -event.relative.y
		rotation_vector.y = -event.relative.x
	
	if Input.is_action_just_pressed("quit"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	leg_rotation = Input.get_action_strength("counter-clockwise")-Input.get_action_strength("clockwise")
	
	rotation_basis = Basis.IDENTITY
	rotation_basis = rotation_basis.rotated(Vector3.RIGHT, rotation_vector.x)
	rotation_basis = rotation_basis.rotated(Vector3.UP, rotation_vector.y)
	rotation_basis = rotation_basis.rotated(Vector3.FORWARD, rotation_vector.z)
	
	movement_vector = Vector3(Input.get_action_strength("right")-Input.get_action_strength("left"),
		Input.get_action_strength("up")-Input.get_action_strength("down"),
		Input.get_action_strength("backward")-Input.get_action_strength("forward")
	)
	
	is_primary_firing = Input.is_action_pressed("primary_fire")
	is_secondary_firing = Input.is_action_pressed("secondary_fire")
	
	rotation_vector.x = 0.0
	rotation_vector.y = 0.0



