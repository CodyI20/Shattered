extends Node

#region SETTINGS - INPUT ACTIONS TO REMAP
var input_actions = {
	"up" : "Move Forward",
	"down" : "Move Backwards",
	"left" : "Move Left",
	"right" : "Move Right",
	"jump" : "Jump",
	"sprint" : "Toggle Sprint",
	"crouch" : "Crouch",
	"inventory" : "Toggle Inventory",
	"CyclePersonalities" : "Alter swap",
	"Interact" : "Interact"
}
#endregion

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

func get_random_result(input: Array):
	var random_generator = RandomNumberGenerator.new()
	var position = random_generator.randi_range(0, input.size()-1)
	return input[position]

## Generates a new array with the same elements, but in different positions
func jumble_array(input: Array) -> Array:
	# Random number here for performance...
	var random_generator = RandomNumberGenerator.new()
	
	var new_array : Array
	var input_array_size := input.size()
	var input_copy : Array
	input_copy.append_array(input)
	for i in range(0,input_array_size):
		var position = random_generator.randi_range(0, input_copy.size()-1)
		var element_to_append = input_copy[position]
		new_array.append(element_to_append)
		# ... no need for input.find() anymore
		input_copy.remove_at(position)
	return new_array
