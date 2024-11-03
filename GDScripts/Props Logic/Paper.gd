extends Interactable

# This script makes the paper node interactable and puts the text in the paper.
#TODO: Make paper_text more expandable so we don't have to write the text in the code itself. Maybe have it import a .txt file or something.
#TODO: Add fancy animations to the paper opening, maybe a fade in or the letter scrolling up from the top.

# @export path to text file for letter
var paper_text = "OMG i am so clumsy and forgetful! \n I am gonna write the code in this note now, it's: 1234"
@onready var letter = get_tree().get_first_node_in_group("Letter")
@onready var letter_text = get_tree().get_first_node_in_group("LetterText")

	
func interact():
	Events.on_interact.emit()
	get_tree().paused = true
	# Make the letter visible on screen.
	letter.visible = true
# Grabs the paper_text variable and adds it to the label.
	letter_text.text = paper_text
func _process(_delta):
	if Input.is_action_just_pressed("Esc"):
		letter.visible = false
