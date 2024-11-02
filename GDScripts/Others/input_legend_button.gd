extends Button

func _on_game_paused() -> void:
	visible = true

func _on_game_resumed() -> void:
	visible = false
