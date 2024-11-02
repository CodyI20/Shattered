extends Node
class_name Interactable

# This Class checks if the object is interactable

func get_interaction_text():
	return "Interact"
	
func interact():
	print("Interacted with %s" % name)
