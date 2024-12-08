@tool
extends Interactable
class_name KeypadKey
@export var number = "0": set = set_number

var interaction_text = "interact with key button"

signal on_interact

var active_puzzle := false

func _ready() -> void:
	Events.final_gate_solved.connect(_enable_key)
	
func _enable_key() -> void:
	active_puzzle = true

# Sets the number on the keypad to the numbner in the export value
func set_number(value):
	number = value
	if value:
		$SubViewport/Label.text = str(value)

# Shows interaction_text on the UI
func get_interaction_text():
	return interaction_text

# Send the number to the screen when you interact with the keypad button
func interact():
	if not active_puzzle:
		Events.on_interact_with_keypad_button_no_electricity.emit()
	else:
		Events.on_interact_with_keypad_button.emit()
		emit_signal("on_interact", number)	
