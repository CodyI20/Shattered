extends State
class_name MainPersonalityState

func Enter():
	Events.main_personality_swap.emit(true)
	print_debug("Entering MainPersonalityState...")
	
func Exit():
	Events.main_personality_swap.emit(false)
	print_debug("Exiting MainPersonalityState...")
	
func Update(_delta: float):
	EasyStateSwap()
	

func EasyStateSwap() -> void:
	if Input.is_action_just_pressed("SwapAlter1"):
		state_transition.emit(self, "Alter1")
