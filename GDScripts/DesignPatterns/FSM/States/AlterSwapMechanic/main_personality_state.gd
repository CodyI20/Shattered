extends State
class_name MainPersonalityState

func Enter():
	print_debug("Entering MainPersonalityState...")
	
func Exit():
	print_debug("Exiting MainPersonalityState...")
	
func Update(_delta: float):
	EasyStateSwap()
	

func EasyStateSwap() -> void:
	if Input.is_action_just_pressed("SwapAlter1"):
		Events.alter1_swap.emit()
		state_transition.emit(self, "Alter1")
