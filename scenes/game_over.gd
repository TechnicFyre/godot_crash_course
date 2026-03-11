extends CanvasLayer

var level_scene : PackedScene = load("res://scenes/level.tscn")

func _ready() -> void:
	$"Center Screen/VBoxContainer/Score".text = $"Center Screen/VBoxContainer/Score".text + str(Global.score)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit game over"):
		get_tree().change_scene_to_packed(level_scene)
	
