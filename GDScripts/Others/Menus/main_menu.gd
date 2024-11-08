extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePaths.GAME_SCENE_PATH)
	Events.start_game.emit()
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
