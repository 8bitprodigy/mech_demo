extends CharacterBody3D
class_name MechController

@export var SPEED : float = 5.0
@export var THROTTLE_MULTIPLIER : float = 2.0
@export var ACCELERATION : float = 15.0
var thrust : float = 0.0
@export var MAX_THRUST : float = 75.0

var angular_velocity : Vector3 = Vector3.ZERO

# Set by the authority, synchronized on spawn.
@export var player : int = 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		$input_synchronizer.set_multiplayer_authority(id)

# Player synchronized input.
@onready var input = $input_synchronizer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity : float = -ProjectSettings.get_setting("physics/3d/default_gravity")
@export var mass : float = 5
var applied_gravity : float = 0

func _ready():
	if player == multiplayer.get_unique_id():
		$turret/Camera3D.current = true
		$MeshInstance3D.hide()
	

func _enter_tree():
	if Engine.is_editor_hint(): return
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#prints("Player: ", player)
	$Label3D.text = str(player)

func _physics_process(delta):
	
	angular_velocity.x = clamp(
							lerp(
								angular_velocity.x,
								input.rotation_vector.x/200,
								delta*ACCELERATION),
							-0.1, 
							0.1)
	angular_velocity.y = clamp(
							lerp(
								angular_velocity.y,
								input.rotation_vector.y/200,
								delta*ACCELERATION),
							-0.1, 
							0.1)
	
	var leg_rotation : float = input.leg_rotation * delta
	rotate(basis.y.normalized(),leg_rotation)
	$turret/Camera3D.rotate($turret/Camera3D.basis.x.normalized(), angular_velocity.x)
	$turret/Camera3D.rotation.x = clampf($turret/Camera3D.rotation.x,-1.425,1.425)
	$turret/Camera3D.rotation.z = 0.0
	$turret.rotate(basis.y.normalized(), angular_velocity.y - leg_rotation)
	
	var speed : float  = clampf(Input.get_action_strength("throttle") * THROTTLE_MULTIPLIER , 1.0, THROTTLE_MULTIPLIER) * SPEED
	
	thrust = lerp(
				thrust, 
				MAX_THRUST * input.movement_vector.y, 
				delta)
	var direction : Vector3 = ((basis.x * input.movement_vector.x) + (basis.z * input.movement_vector.z)).normalized() * speed
	if is_on_floor(): applied_gravity = 0
	else: applied_gravity = lerp(applied_gravity, gravity*mass, delta)
	direction.y = lerp(direction.y, thrust+applied_gravity, delta*ACCELERATION)
	
	velocity = lerp(velocity,direction,delta*ACCELERATION)
	move_and_slide()
	if input.movement_vector.y == 0: apply_floor_snap()
