extends Area2D

func _on_area_entered(_area: Area2D) -> void:
	pass # Replace with function body.

@export var speed = 500

func _process(delta: float) -> void:
	position.y -= speed * delta
