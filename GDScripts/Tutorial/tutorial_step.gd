extends Resource
class_name TutorialStep


@export var tutorial_text : String
@export var tutorial_action : String
var completed : bool = false

func Ready() -> void:
	event_subscription()
func Process() -> void:
	if completed == true:
		return
	if step_requirement_fulfilled():
		complete_step()
	
func event_subscription() -> void:
	pass

func step_requirement_fulfilled() -> bool:
	if Input.is_action_just_pressed(tutorial_action):
		return true
	return false
	
func complete_step() -> void:
	print_debug("Completed step: ", self)
	Events.complete_tutorial_step.emit(self)
	completed = true
