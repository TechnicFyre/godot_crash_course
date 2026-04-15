class_name HitboxComponent

extends Area2D

## A component that defines an entity's shape and manages getting hit

@export var health : HealthComponent
@export var contact_attack : AttackComponent

func _ready() -> void:
	if health is not HealthComponent:
		print_debug(get_parent(), "'s HitboxComponent lacks HealthComponent")
	if contact_attack is not AttackComponent:
		print_debug(get_parent(), "'s HitboxComponent lacks AttackComponent")
		
func _on_area_entered(area: Area2D) -> void:
	if area is not HitboxComponent:
		print_debug(area.get_parent(), " entered ", get_parent(), " with Area2D not HitboxComponent")
		return
	if area.contact_attack is AttackComponent:
		# print(area.contact_attack.get_damage())
		if health is HealthComponent:
			health.damage_health(area.contact_attack.get_damage())
