extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.options_menu_toggle.connect(toggle_menu_items)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePaths.GAME_SCENE_PATH)
	Events.start_game.emit()
	
func _on_options_button_pressed() -> void:
	Events.options_menu_toggle.emit(true)
	
func toggle_menu_items(toggle_on : bool) -> void:
	v_box_container.visible = !toggle_on
	v_box_container.set_process(!toggle_on)
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
