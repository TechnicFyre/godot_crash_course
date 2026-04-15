class_name HealthComponent

extends Node2D

## A component that defines maximum health and current health

signal health_changed
signal health_reached_zero

const dead : float = 0.0

@export var max_health : float
@export var current_health : float

func damage_health(damage: float) -> void:
	## Decrease health by damage (must be positive)
	if damage <= 0:
		return
	elif damage < current_health:
		current_health -= damage
	else:
		current_health = 0
		health_reached_zero.emit()
	health_changed.emit()

func heal_health(heal: float) -> void:
	## Increase health by heal (must be positive)
	if heal <= 0:
		return
	elif current_health + heal < max_health:
		current_health += heal
	else:
		current_health = max_health
	health_changed.emit()

func overheal_health(heal: float) -> void:
	## Increase health by heal (must be positive) - CAN heal more than max health
	if heal <= 0:
		return
	else:
		current_health += heal
	health_changed.emit()
