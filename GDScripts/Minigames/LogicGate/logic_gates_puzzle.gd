extends Control

var puzzle_active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.puzzle_toggle.connect(toggle_puzzle)
	visible = false

func toggle_puzzle() -> void:
	puzzle_active = !puzzle_active
	visible = puzzle_active
	set_process(puzzle_active)
	if puzzle_active:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
