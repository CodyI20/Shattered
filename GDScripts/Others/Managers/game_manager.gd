class_name gameManager
extends Node3D
 
signal paused
signal resumed

@onready var _saver_loader:SaverLoader = %SaveLoadManager

var LoadedLevel : String
var SpawnIndex : int
# If this is TRUE, it means that the game should NOT pause --> TRUE = NOT PAUSED ; FALSE = PAUSED
var NoPause : bool = false
var NoPauseStringArray : Array = ["Paper", "ElectricPanel"]

var game_is_paused_by_script : bool

func no_pause_interactions(interactable: Interactable):
	if NoPauseStringArray.has(interactable.get_interaction_text()):
		NoPause = true

func _ready() -> void:
	Events.on_interact.connect(no_pause_interactions)

func _process(delta: float) -> void:
	game_state_change()

func game_state_change():
	if Input.is_action_just_pressed("Esc"):
		if not NoPause:
			pause_game(!get_tree().paused)
		else:
			get_tree().paused = false
			NoPause = false

## This function handles both the pausing/resuming of the game and the event firing (emitting signals)
## CALL THIS FUNCTION WHENEVER YOU WANT TO PAUSE/RESUME THE GAME
func pause_game(shouldPause := false):
	get_tree().paused = shouldPause;
	if get_tree().paused:
		paused.emit()
	else:
		resumed.emit()
	

#region ButtonPresses
func _on_resume_button_pressed() -> void:
	pause_game(false)


func _on_restart_button_pressed() -> void:
	pause_game(false)
	get_tree().reload_current_scene()


func _on_options_button_pressed() -> void:
	print_debug("Pressing the options, for now...")


func _on_menu_button_pressed() -> void:
	pause_game(false);
	get_tree().change_scene_to_file(FilePaths.MENU_SCENE_PATH)


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_save_game() -> void:
	print("Saving game!")
	_saver_loader.save_game()

func _on_load_game() -> void:
	print("Loading game")
	_saver_loader.load_game()
	pause_game(false)
#endregion