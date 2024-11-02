extends Control

var puzzle_active : bool = false
@onready var pausable_ui: CanvasLayer = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.puzzle_toggle.connect(toggle_puzzle)
	visible = false

func toggle_puzzle() -> void:
	puzzle_active = !puzzle_active
	visible = puzzle_active
	set_process(puzzle_active)
	if puzzle_active:
		pausable_ui.layer = 10
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		pausable_ui.layer = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
