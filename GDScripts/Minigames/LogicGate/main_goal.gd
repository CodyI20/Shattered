extends TextureRect

const LIGHTBULB_OFF = preload("res://Art/2D/LogicGatePuzzle/lightbulb_off.png")
const LIGHTBULB_ON = preload("res://Art/2D/LogicGatePuzzle/lightbulb_on.png")

var correct_gates : Array
const number_of_gates = 3

func _ready() -> void:
	texture = LIGHTBULB_OFF
	Events.correct_gate_entered.connect(increment_correct_gates_number)
	Events.wrong_gate_entered.connect(decrease_correct_gates_number)

func increment_correct_gates_number(o: DropZone) -> void:
	if !correct_gates.has(o):
		print_debug("Adding a gate to the ARRAY...")
		correct_gates.push_back(o)
		
	if correct_gates.size() == 3:
		print_debug("GATE SOLVED!")
		texture = LIGHTBULB_ON
		Events.gate_solved.emit()
	
func decrease_correct_gates_number(o: DropZone) -> void:
	var index = correct_gates.find(o)
	print_debug(index)
	if index != -1:
		print_debug("Incorrect gate, removing from the array....")
		correct_gates.remove_at(index)
	
