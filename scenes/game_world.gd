extends Node2D

var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var asteroid_scene: PackedScene = load("uid://bxgdcmlt57wtw")

var health: int = 5

var rng := RandomNumberGenerator.new()

var lower_fog
var lower_fog_noise

enum ScreenSides {LEFT, RIGHT, UPPER, LOWER}

# func _enter_tree() -> void:

func _enter_tree() -> void:
	get_tree().call_group('UI', 'set_health', health)
	
	# for calculating positions later
	#var width := get_viewport_rect().size[0]
	#var height := get_viewport_rect().size[1]
	#var random_x : int
	#var random_y : int
	
	# Spawn in random stars
	#var star : AnimatedSprite2D
	#var count := rng.randi_range(20,30)
	#for i in range(count):
		## copy the invisible star, make it visible
		#star = $Stars/Star.duplicate()
		#star.visible = true
		#
		## randomize position
		#random_x = rng.randi_range(0, int(width))
		#random_y = rng.randi_range(0, int(height))
		#star.position = Vector2(random_x, random_y)
		#
		## randomize size, default is 1.0
		#var size = rng.randf_range(0.3, 0.8)
		#star.scale = Vector2(size, size)
		#
		## randomize animation speed, default is 1.0
		#star.speed_scale = rng.randf_range(0.5,2)
		#
		## add it to Stars
		#$Stars.add_child(star)
	
	# Background set up
	# lower_fog= $Background/LowerFog
	# lower_fog_noise = $Background/LowerFog.get_texture().get_noise()

# func _physics_process(delta: float) -> void:
	# var fog_position = $Player.global_position
	
	# lower_fog.offset = fog_position / lower_fog.scale.x
	# lower_fog_noise.offset = Vector3(floor(fog_position.x / lower_fog.scale.x), floor(fog_position.y / lower_fog.scale.x), 0.0)
	# print(lower_fog.offset)

func resize_background(resolution: Vector2i, size: float) -> void:
	## Resize Parallax2D layers to specified size
	resize_layer(resolution, size, $Background/DeepSpaceParallax)
	resize_layer(resolution, size, $Background/LowerFogParallax)
	resize_layer(resolution, size, $Background/UpperFogParallax)
	
func resize_layer(resolution: Vector2i, size: float, layer: Parallax2D) -> void:
	## Resize an individual Parralax layer
	var tile : Vector2 = layer.repeat_size
	layer.repeat_times = int(ceil(max(resolution.x / tile.x, resolution.y / tile.y)) / size)
	
	
func _on_meteor_timer_timeout() -> void:
	pass
	# 2. create an instance
	# var meteor = meteor_scene.instantiate()
	
	# 3. attach the node to the scene tree
	# $Meteors.add_child(meteor)
	
	# connect the signal
	# meteor.connect('collision', _on_meteor_collision)
	# meteor.connect('destroyed', _on_meteor_destroyed)

func _on_meteor_collision():
	health -= 1
	get_tree().call_group('UI', 'set_health', health)
	$Audio/ShipDamaged.pitch_scale = rng.randf_range(0.8,1.2)
	$Audio/ShipDamaged.play()
	if health <= 0:
		# explode ship
		$Audio/ShipDestroyed.play()
		await $Audio/ShipDestroyed.finished
		# switch to results
		get_tree().change_scene_to_file("uid://cy8vfc5o4h74i")

func _on_meteor_destroyed():
	$Audio/MeteorDestroyed.pitch_scale = rng.randf_range(0.8,1.2)
	$Audio/MeteorDestroyed.play()

func _on_player_laser(laser_position, laser_rotation) -> void:
	var laser = laser_scene.instantiate()
	laser.position = laser_position
	laser.rotation = laser_rotation
	$Lasers.add_child(laser)


func _on_enemy_spawn_timer_timeout() -> void:
	# Determine border of the screen
	var center = get_viewport().get_camera_2d().get_screen_center_position()
	var size = get_viewport_rect().size
	var upper_left = center - size / 2
	var lower_right = center + size / 2
	
	# Get random position to spawn enemy
	# x values increase from left to right
	# y values increase from top to bottom
	var side = ScreenSides.values().pick_random()
	
	var spawn_position : Vector2
	const SPAWN_MARGIN = 100
	match side:
		ScreenSides.LEFT:
			spawn_position = Vector2(randf_range(upper_left.x - SPAWN_MARGIN, upper_left.x), randf_range(upper_left.y, lower_right.y))
		ScreenSides.RIGHT:
			spawn_position = Vector2(randf_range(lower_right.x, lower_right.x + SPAWN_MARGIN), randf_range(upper_left.y, lower_right.y))
		ScreenSides.UPPER:
			spawn_position = Vector2(randf_range(upper_left.x, lower_right.x), randf_range(upper_left.y - SPAWN_MARGIN, upper_left.y))
		ScreenSides.LOWER:
			spawn_position = Vector2(randf_range(upper_left.x, lower_right.x), randf_range(lower_right.y, lower_right.y + SPAWN_MARGIN))
	
	print(spawn_position)
	# Spawn an enemy
	var enemy : Asteroid = asteroid_scene.instantiate()
	enemy.prepare($Player, spawn_position)
	
	$Meteors.add_child(enemy)
