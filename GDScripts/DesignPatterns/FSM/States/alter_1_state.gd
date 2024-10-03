extends State
class_name Alter1State

func Enter():
	Events.alter1_swap.emit(true)
	print_debug("Entering Alter1State...")

func Exit():
	Events.alter1_swap.emit(false)
	print_debug("Exiting Alter1State...")

func Update(_delta: float):
	EasyStateSwap()
	

func EasyStateSwap() -> void:
	if Input.is_action_just_pressed("SwapMainPersonality"):
		state_transition.emit(self, "MainPersonality")
