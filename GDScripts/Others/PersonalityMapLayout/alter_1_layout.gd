extends State
class_name Alter1LayoutState

@onready var alter_1_animator: AnimationPlayer = $Alter1Animator


func _ready() -> void:
	alter_1_animator.play("RESET")
	Events.personality_swap.connect(on_personality_swap)
	
func Enter():
	alter_1_animator.play("SwitchToAlter1")

func Exit():
	print_debug("EXITING ALTER1LAYOUT")
	alter_1_animator.play("SwitchFromAlter1")

func on_personality_swap(personality: int) -> void:
	if personality == enums.PersonalityStates.NICK:
		state_transition.emit(self, "NickLayout")
