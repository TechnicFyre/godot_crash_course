extends Node2D

# 1. load the scene
var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")

var rng := RandomNumberGenerator.new()

func _ready() -> void:
	# for calculating positions later
	var width := get_viewport_rect().size[0]
	var height := get_viewport_rect().size[1]
	var random_x : int
	var random_y : int
	
	# Spawn in random stars
	var star : AnimatedSprite2D
	var count := rng.randi_range(20,30)
	for i in range(count):
		# copy the invisible star, make it visible
		star = $Stars/Star.duplicate()
		star.visible = true
		
		# randomize position
		random_x = rng.randi_range(0, int(width))
		random_y = rng.randi_range(0, int(height))
		star.position = Vector2(random_x, random_y)
		
		# randomize size, default is 1.0
		var size = rng.randf_range(0.3, 0.8)
		star.scale = Vector2(size, size)
		
		# randomize animation speed, default is 1.0
		star.speed_scale = rng.randf_range(0.5,2)
		
		# add it to Stars
		$Stars.add_child(star)

func _on_meteor_timer_timeout() -> void:
	# 2. create an instance
	var meteor = meteor_scene.instantiate()
	
	# 3. attach the node to the scene tree
	$Meteors.add_child(meteor)
	


func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
