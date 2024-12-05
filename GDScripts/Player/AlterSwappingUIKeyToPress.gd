extends Label

func _process(delta: float) -> void:
	text = InputMap.action_get_events("CyclePersonalities")[0].as_text().trim_suffix(" (Physical)")
