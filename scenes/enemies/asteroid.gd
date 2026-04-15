extends Node2D

func _on_health_component_health_reached_zero() -> void:
	queue_free()
	
