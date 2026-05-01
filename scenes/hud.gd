extends CanvasLayer

var image = load("res://resources/lives/playerLife1_green.png")

func _ready() -> void:
	PlayerInfo.score = 0

func set_health(amount):
	# remove all children
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	
	# create new children amount is set by health
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		$MarginContainer2/HBoxContainer.add_child(text_rect)
		

func _on_score_timer_timeout():
	PlayerInfo.score += 1
	# $MarginContainer/Score.text = str(PlayerInfo.score)
