extends Node3D
	
signal paused
signal resumed

func _process(delta: float) -> void:
	game_state_change()

func game_state_change() -> void:
	if Input.is_action_just_pressed("Esc"):
		pause_game(!get_tree().paused)
		

## This function handles both the pausing/resuming of the game and the event firing (emitting signals)
## CALL THIS FUNCTION WHENEVER YOU WANT TO PAUSE/RESUME THE GAME
func pause_game(shouldPause := false) -> void:
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
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
#endregion