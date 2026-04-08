extends Node

# Screen resolution management
@onready var BaseSize := get_window().size

# Screen management
@onready var MainMenu := $MainMenu
@onready var GameWorld := $GameWorld
@onready var Settings := $Settings
@onready var GameResults := $GameResults
@onready var Upgrades := $Upgrades
@onready var Credits := $Credits

func _ready() -> void:
	# Screen resolution management
	get_window().set_min_size(BaseSize)
	get_window().size_changed.connect(_update_window_size)
	
	# Screen management
	remove_child(GameWorld)
	remove_child(Settings)
	remove_child(GameResults)
	remove_child(Upgrades)
	remove_child(Credits)
	
	# Other
	# get_tree().paused = true

# ------------------------------------------------------------------------------
# Screen resolution management
# ------------------------------------------------------------------------------
func _update_window_size() -> void:
	## Scales the UI and Game according to the size of the window
	var resolution : Vector2 = get_window().size
	var ratio : float = min(resolution.x/BaseSize.x, resolution.y / BaseSize.y)
	ratio = max(1, floor(ratio))
	get_window().content_scale_factor = ratio
	# Background Repeat
	GameWorld.resize_background(resolution, ratio)
	

# ------------------------------------------------------------------------------
# Screen management
# ------------------------------------------------------------------------------

# Hide the main menu, open game
func _on_main_menu_play_button_pressed() -> void:
	print("Main says: _on_main_menu_play_button_pressed() signal triggered")
	self.add_child(GameWorld)
	self.remove_child(MainMenu)

# Hide the main menu, open settings
func _on_main_menu_settings_button_pressed() -> void:
	print("Main says: _on_main_menu_settings_button_pressed() signal triggered")
	self.add_child(Settings)
	self.remove_child(MainMenu)

# Hide the main menu, open credits
func _on_main_menu_credits_button_pressed() -> void:
	print("Main says: _on_main_menu_credits_button_pressed() signal triggered")
	self.add_child(Credits)
	self.remove_child(MainMenu)



# Hide the game, open results

# Hide the game, open settings



# Hide the settings, return to previous screen

# Hide the settings, return to main menu



# Hide the credits, open main menu



# Hide the results, open upgrades



# Hide the upgrades, open game

# Hide the upgrades, open settings
