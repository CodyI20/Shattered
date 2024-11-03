extends State
class_name Alter1State

func Enter():
	print_debug("Entering Alter1State...")

func Exit():
	print_debug("Exiting Alter1State...")

func Update(_delta: float):
	EasyStateSwap()
	

func EasyStateSwap() -> void:
	if Input.is_action_just_pressed("SwapMainPersonality"):
		Events.personality_swap.emit("MainPersonality")
		state_transition.emit(self, "MainPersonality")
