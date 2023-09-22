extends Node
class_name HealthComponent


@export var MAX_HEALTH : float = 1.0
@onready var health : float = MAX_HEALTH

func damage(attack:AttackInfo):
	health -= attack.attack_damage
	
	if health <= 0:
		get_parent().queue_free()
