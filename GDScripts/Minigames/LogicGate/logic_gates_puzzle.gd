extends Control

var puzzle_active : bool = false
@onready var pausable_ui: CanvasLayer = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.on_interact.connect(toggle_puzzle)
	visible = false

func toggle_puzzle(interactable: Interactable) -> void:
	if interactable.get_interaction_text() != "ElectricPanel":
		return
	toggle_puzzle_non_event()
		
func toggle_puzzle_non_event() -> void:
	puzzle_active = !puzzle_active
	visible = puzzle_active
	set_process(puzzle_active)
	if puzzle_active:
		pausable_ui.layer = 10
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		pausable_ui.layer = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	if puzzle_active && Input.is_action_just_pressed("Esc"):
		toggle_puzzle_non_event()
