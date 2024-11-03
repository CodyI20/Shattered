extends Interactable
class_name PaperClass

# This script makes the paper node interactable and puts the text in the paper.
#TODO: Make paper_text more expandable so we don't have to write the text in the code itself. Maybe have it import a .txt file or something.
#TODO: Add fancy animations to the paper opening, maybe a fade in or the letter scrolling up from the top.
@export var Item_type : ItemData
var being_interacted_with: bool = false

func _ready() -> void:
	Events.OnItemPickedUp.connect(destroy_self)

func get_interaction_text():
	return "Paper"

func interact():
	Events.on_interact.emit(self)
	Events.OnItemPickedUp.emit(Item_type)
	being_interacted_with = true
	
func destroy_self(item: ItemData):
	if item == Item_type:
		queue_free()
