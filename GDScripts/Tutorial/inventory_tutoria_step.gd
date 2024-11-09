extends TutorialStep
class_name TutorialInventoryStep

func event_subscription() -> void:
	Events.OnItemPickedUp.connect(play_step)
	Events.toggle_inventory.connect(complete_step)
	
func play_step(item: ItemData) -> void:
	Events.play_tutorial_step.emit(self)
