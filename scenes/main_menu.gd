extends Control

signal play_button_pressed
signal settings_button_pressed
signal credits_button_pressed

func _on_play_pressed() -> void:
	print("MainMenu says: _on_play_pressed() signal triggered")
	play_button_pressed.emit()

func _on_settings_pressed() -> void:
	print("MainMenu says: _on_settings_pressed() signal triggered")
	settings_button_pressed.emit()
	
func _on_credits_pressed() -> void:
	print("MainMenu says: _on_credits_pressed() signal triggered")
	credits_button_pressed.emit()
