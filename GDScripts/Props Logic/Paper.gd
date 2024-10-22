extends Interactable

var paper_text = "OMG i am so clumsy and forgetful! \n I am gonna write the code in this note now, it's: 1234"
@onready var letter = get_node("/root/UI/Letter")

signal on_interact

var interaction_text = "Press E to read the letter."

func get_interaction_text():
	return interaction_text
	
func interact():
	emit_signal("on_interact", paper_text)
	print(paper_text)
