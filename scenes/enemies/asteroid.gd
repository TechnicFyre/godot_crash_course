class_name Asteroid

extends Node2D

var target : Node2D
var initial_pos : Vector2
var initial_route : Vector2
var orthogonal : Vector2
var curve_progress : float = 0.5

func prepare(target_node: Node2D, start_position: Vector2) -> void:
	position = start_position
	
	target = target_node
	initial_pos = position
	initial_route = target.position - position
	var rand = randf_range(0.4,0.6)
	# print(rand)
	orthogonal = initial_route.orthogonal() * rand

func _process(delta) -> void:
	# Progress a percentage of the way along the initial route every second
	const ROUTE_PERCENTAGE = 0.5
	position += initial_route * ROUTE_PERCENTAGE * delta
	# curve_progress -= ROUTE_PERCENTAGE * delta
	# position += orthogonal * curve_progress * delta

func _on_health_component_health_reached_zero() -> void:
	queue_free()
