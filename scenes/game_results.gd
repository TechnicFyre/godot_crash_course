extends CanvasLayer

var GameWorld : PackedScene = load("uid://5lobrp15vwq4")

func _ready() -> void:
	$"Center Screen/VBoxContainer/Score".text = $"Center Screen/VBoxContainer/Score".text + str(PlayerInfo.score)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		get_tree().change_scene_to_packed(GameWorld)
	
