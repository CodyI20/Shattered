extends Control

func _on_menu_button_pressed() -> void:
	Utility.go_to_main_menu()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
