extends CharacterBody2D

@export var speed: int = 500

signal laser(pos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(100,100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	
	# shoot input
	if Input.is_action_just_pressed("shoot") and $LaserTimer.is_stopped():
		$LaserTimer.start()
		laser.emit($LaserStartPos.global_position)
