extends Node

signal keyPressed(key)

func _ready() -> void:
	# Set the mouse to confined at the start of the game
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_game_paused() -> void:
	# Set the mouse to free so we can access the menu
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_game_resumed() -> void:
	# Set the mouse to confined so we can play the game
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
