extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.logic_gate_puzzle_on.connect(set_canvas_layer_high)
	Events.logic_gate_puzzle_off.connect(set_canvas_layer_low)

func set_canvas_layer_high() -> void:
	layer = 11

func set_canvas_layer_low() -> void:
	layer = 0
