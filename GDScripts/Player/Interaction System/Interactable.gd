extends Node
class_name Interactable

# This Class checks if the object is interactable

func get_interaction_text():
	return "Interact"
	
func interact():
	Events.on_interact.emit(self)
	print("Interacted with %s" % name)
