extends PuzzleUI
class_name LogicGatesPuzzleUI

func _ready() -> void:
	super()
	Events.final_gate_solved.connect(close_puzzle_after_delay)

func close_puzzle_after_delay() -> void:
	await get_tree().create_timer(1.5).timeout
	close_puzzle()
