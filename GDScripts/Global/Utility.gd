extends Node

func findByClass(node: Node, className : String, result : Array) -> Array:
	if node.is_class(className) :
		result.push_back(node)
	for child in get_children():
		findByClass(child, className, result)
	return result

func go_to_main_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(FilePaths.MENU_SCENE_PATH)

func quit_game() -> void:
	get_tree().quit()
