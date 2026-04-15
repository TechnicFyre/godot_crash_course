class_name AttackComponent

extends Node2D

## A component that defines attack damage and defense penetration

@export var attack_damage : float
@export var defense_penetration : float

func get_damage() -> float:
	## Returns this attack's damage
	return attack_damage
