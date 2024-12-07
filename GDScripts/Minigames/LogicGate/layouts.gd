extends Control

const LAYOUT___EASY = preload("res://Scenes/PuzzleScenes/ElectricPuzzle/Layout/Variants/layout___easy.tscn")
const LAYOUT___MEDIUM = preload("res://Scenes/PuzzleScenes/ElectricPuzzle/Layout/Variants/layout___medium.tscn")
const LAYOUT___HARD = preload("res://Scenes/PuzzleScenes/ElectricPuzzle/Layout/Variants/layout___hard.tscn")

var layout_children : Array
var current_active_layout := 0

func _ready() -> void:
	Events.gate_solved.connect(handle_gate_solved)

func next_layout() -> void:
	var first_child = get_child(0)
	first_child.queue_free()
	var new_child
	if current_active_layout == 0:
		new_child = LAYOUT___EASY.instantiate()
	elif current_active_layout == 1:
		new_child = LAYOUT___MEDIUM.instantiate()
	elif current_active_layout == 2:
		new_child = LAYOUT___HARD.instantiate()
	add_child(new_child)

func handle_gate_solved() -> void:
	current_active_layout += 1
	if current_active_layout >= 3:
		Events.gate_solved.disconnect(handle_gate_solved)
		print_debug("GONNA GET OUT OF BOUNDS!")
		return
	await get_tree().create_timer(2).timeout
	Events.logic_gates_puzzle_layout_change.emit()
	next_layout()
