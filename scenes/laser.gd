extends Area2D

func _on_area_entered(_area: Area2D) -> void:
	pass # Replace with function body.

@export var speed = 500

func _ready():
	var tween = create_tween()
	tween.tween_property($Sprite2D, 'scale', Vector2(1,1), 0.2).from(Vector2(0,0.2))

func _process(delta: float) -> void:
	position.y -= speed * delta
