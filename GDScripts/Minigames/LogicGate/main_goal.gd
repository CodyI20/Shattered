extends TextureRect

const LIGHTBULB_OFF = preload("res://Art/2D/LogicGatePuzzle/LightOff.png")
const LIGHTBULB_ON = preload("res://Art/2D/LogicGatePuzzle/LightOn.png")

@onready var drop_zones: Node = $"../DropZones"

@export var color_rect_node: NodePath

## Set this variable to true in order to mark the solution of this puzzle as the final completion (ONLY SET IT FOR THE LAST PUZZLE LAYOUT - HARD)
@export var final_main_goal : bool = false
#@onready var color_rect: ColorRect = $"../ColorRect"

var correct_gates : Array
var number_of_drop_zones

func _ready() -> void:
	_event_subscription()
	texture = LIGHTBULB_OFF
	number_of_drop_zones = drop_zones.get_child_count()
	
func _event_subscription() -> void:
	Events.correct_gate_entered.connect(increment_correct_gates_number)
	Events.wrong_gate_entered.connect(decrease_correct_gates_number)
	Events.toggle_electricity.connect(check_puzzle_solved)
	Events.logic_gates_puzzle_layout_change.connect(reset_puzzle)

func increment_correct_gates_number(o: DropZone) -> void:
	if get_parent().visible == false:
		return
	if !correct_gates.has(o):
		print_debug("Adding a gate to the ARRAY...")
		correct_gates.push_back(o)
		#if color_rect:
			#color_rect.change_to_green()
	
func decrease_correct_gates_number(o: DropZone) -> void:
	if get_parent().visible == false:
		return
	var index = correct_gates.find(o)
	print_debug(index)
	if index != -1:
		print_debug("Incorrect gate, removing from the array....")
		correct_gates.remove_at(index)

func reset_puzzle() -> void:
	if get_parent().visible == false:
		return
	print_debug("MainGOAL has been reset...")
	texture = LIGHTBULB_OFF
	number_of_drop_zones = drop_zones.get_child_count()
	correct_gates.clear()
	
func check_puzzle_solved(toggled_on : bool) -> void:
	if get_parent().visible == false:
		return
	if !toggled_on:
		return
	if correct_gates.size() == number_of_drop_zones:
		print_debug("GATE SOLVED!")
		texture = LIGHTBULB_ON
		if final_main_goal:
			Events.gate_solved.emit()
			Events.final_gate_solved.emit()
		else:
			Events.gate_solved.emit()
	else:
		Events.gate_not_solved_sound.emit()
		await get_tree().create_timer(3).timeout
		Events.gate_not_solved.emit()
