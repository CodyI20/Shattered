extends State
class_name Alter1LayoutState

@onready var alter_1_animator: AnimationPlayer = $Alter1Animator


func _ready() -> void:
	alter_1_animator.play("RESET")
	Events.main_personality_swap.connect(on_main_personality_swap)
	
func Enter():
	alter_1_animator.play("SwitchToAlter1")

func Exit():
	print_debug("EXITING ALTER1LAYOUT")
	alter_1_animator.play("SwitchFromAlter1")

func on_main_personality_swap() -> void:
	state_transition.emit(self, "MainPersonalityLayout")
