extends CharacterBody2D

@export var speed: int = 500
var dB_cap : float = -25.0
var dB_floor : float = -40.0
var volume_factor : float = speed / abs(dB_cap - dB_floor)

signal laser(pos)

func _process(_delta: float) -> void:
	# Get movement direction
	var direction = Input.get_vector("left","right","up","down")
	
	
	# Get mouse relative position to player
	rotation = (get_global_mouse_position() - global_position).angle()
	
	var tween_move = self.create_tween().set_parallel()
	tween_move.set_ease(Tween.EASE_OUT_IN)
	tween_move.tween_property(self, 'velocity', direction * speed, 0.5)
	#if direction.length() > 0.0:
		 #tween_move.tween_property(self, 'rotation', direction.angle() + PI/2, 0.5)
		
	
	$ShipEngine.volume_db = velocity.length() / volume_factor + dB_floor
	
	move_and_slide()
	
	# shoot input
	if Input.is_action_just_pressed("shoot") and $LaserTimer.is_stopped():
		$LaserTimer.start()
		$LaserSound.play()
		laser.emit($LaserStartPos.global_position, rotation)
