extends Control

var level_scene := preload("uid://5lobrp15vwq4")

func _on_play_game_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)
	


func _on_settings_pressed() -> void:
	pass
	# $CenterContainer.add_child()
