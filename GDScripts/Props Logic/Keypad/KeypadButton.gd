@tool
extends Interactable
@export var number = "0": set = set_number

var interaction_text = "interact with key button"

signal on_interact

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
	emit_signal("on_interact", number)
