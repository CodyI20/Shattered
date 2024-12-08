extends CanvasLayer
class_name PuzzlePausableUI

var puzzle_type : Enums.puzzle_types
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var child = get_child(0)
	if child is PuzzleUI:
		print_debug("Getting the type of the puzzle for %s" % self)
		puzzle_type = child.puzzle_type
	Events.puzzle_toggled_on.connect(set_canvas_layer_high)
	Events.puzzle_toggled_off.connect(set_canvas_layer_low)

func set_canvas_layer_high(input_puzzle_type : Enums.puzzle_types) -> void:
	if input_puzzle_type != puzzle_type:
		return
	layer = 11

func set_canvas_layer_low(input_puzzle_type : Enums.puzzle_types) -> void:
	if input_puzzle_type != puzzle_type:
		return
	layer = 0
