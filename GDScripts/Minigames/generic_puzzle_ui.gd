extends Control
class_name PuzzleUI

## The name of the interactable ( refer to the get_interaction_text())
@export var puzzle_name : String
var puzzle_active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.on_interact.connect(toggle_puzzle)
	Events.exited_puzzle_area.connect(close_puzzle)
	#visible = false
	#mouse_filter = MOUSE_FILTER_IGNORE
	#puzzle_active = false

func toggle_puzzle(interactable: Interactable) -> void:
	if interactable.get_interaction_text() != puzzle_name:
		return
	toggle_puzzle_non_event()
	
func close_puzzle() -> void:
	if puzzle_active:
		toggle_puzzle_non_event()
		
func toggle_puzzle_non_event() -> void:
	puzzle_active = !puzzle_active
	visible = puzzle_active
	set_process(puzzle_active)
	if puzzle_active:
		mouse_filter = MOUSE_FILTER_STOP
		Events.logic_gate_puzzle_on.emit()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		mouse_filter = MOUSE_FILTER_IGNORE
		Events.logic_gate_puzzle_off.emit()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if puzzle_active && Input.is_action_just_pressed("Esc"):
		toggle_puzzle_non_event()
		accept_event()
