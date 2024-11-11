extends TextureRect

func _on_input_legend_button_pressed() -> void:
	visible = !visible

func _process(delta: float) -> void:
	if visible and Input.is_action_just_pressed("Esc"):
		Events.no_resume_signal.emit()
		visible = false
		print_debug("Visible is : ", visible)
