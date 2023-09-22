extends Area3D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(attack:AttackInfo):
	if health_component:
		health_component.damage(attack)
