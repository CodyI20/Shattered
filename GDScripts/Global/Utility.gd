extends Node

func findByClass(node: Node, className : String, result : Array) -> Array:
	if node.is_class(className) :
		result.push_back(node)
	for child in get_children():
		findByClass(child, className, result)
	return result

func go_to_main_menu() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_packed(FilePaths.MENU_SCENE_PATH)

func quit_game() -> void:
	get_tree().quit()

func go_to_game_scene() -> void:
	get_tree().change_scene_to_packed(FilePaths.GAME_SCENE_PATH)
	Events.start_game.emit()

func go_to_cinematic_scene() -> void:
	get_tree().change_scene_to_packed(FilePaths.CINEMATIC_SCENE_PATH)

func go_to_final_screen() -> void:
	Events.go_to_final_screen.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false
	get_tree().change_scene_to_packed(FilePaths.END_DEMO_SCENE)
