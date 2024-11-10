extends TutorialStep
class_name TutorialSprintingStep

@export var other_actions : Array[String] = ["up", "down", "left", "right"]


func step_requirement_fulfilled() -> bool:
	for action in other_actions:
		if Input.is_action_pressed(action):
			if Input.is_action_just_pressed(tutorial_action):
				return true
	return false
