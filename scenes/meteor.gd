extends Area2D

var rotation_speed : float = 0
var speed : int
var direction : Vector2

signal collision
signal destroyed

var meteor_graphics := ["uid://c1e6uygjxtf4v",
						"uid://dsbjhurn4c1gf",
						"uid://n6lbi0b80s4a",
						"uid://dislacukgfs40"]

# For randomizing properties when instantiating meteors
var rng := RandomNumberGenerator.new()

func _ready():
	# start position
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)
	
	# randomize meteor graphic
	$MeteorImage.texture = load(meteor_graphics.pick_random())
	
	# randomize speed
	speed = rng.randi_range(250,350)
	
	# randomize direction
	direction = Vector2(rng.randf_range(-0.1,0.1), 1.0).normalized()
	
	# randomize rotation
	rotation_speed = rng.randf_range(1,2)
	rotation_speed *= [-1,1].pick_random()
	
func _process(delta):
	position += direction * speed * delta
	rotation_degrees += rotation_speed
	

func _on_body_entered(_body: Node2D) -> void:
	collision.emit()


func _on_area_entered(area: Area2D) -> void:
	destroyed.emit()
	area.queue_free()
	queue_free()
