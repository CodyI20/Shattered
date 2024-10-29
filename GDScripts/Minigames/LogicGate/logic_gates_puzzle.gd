extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.puzzle_toggle.connect(toggle_puzzle)
	visible = false

func toggle_puzzle() -> void:
	get_tree().paused = !get_tree().paused
	visible = !visible
	if visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
