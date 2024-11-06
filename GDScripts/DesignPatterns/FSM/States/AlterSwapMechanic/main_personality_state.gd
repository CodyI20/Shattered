extends State
class_name MainPersonalityState

func Enter():
	Events.personality_swap.emit(enums.PersonalityStates.NICK)
	print_debug("Entering MainPersonalityState...")
	
func Exit():
	print_debug("Exiting MainPersonalityState...")
	
func Update(_delta: float):
	EasyStateSwap()
	

func EasyStateSwap() -> void:
	if Input.is_action_just_pressed("CyclePersonalities"):
		state_transition.emit(self, "Atlas")
