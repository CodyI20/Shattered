extends Node

signal keyPressed(key)
var interact_action = "Interact"

func _ready() -> void:
	# Set the mouse to confined at the start of the game
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_game_paused() -> void:
	# Set the mouse to free so we can access the menu
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_game_resumed() -> void:
	# Set the mouse to confined so we can play the game
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# -------------------- #
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(interact_action):
		Events.test_key_press.emit(interact_action)
