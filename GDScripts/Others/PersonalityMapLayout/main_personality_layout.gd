extends State
class_name MainPersonalityLayoutState
@onready var main_pers_animator: AnimationPlayer = $MainPersAnimator


func _ready() -> void:
	main_pers_animator.play("RESET")
	Events.personality_swap.connect(on_personality_swap)

func Enter():
	main_pers_animator.play("SwitchToMainPersonality")
	
func Exit():
	print_debug("EXITING MAIN LAYOUT")
	main_pers_animator.play("SwitchFromMainPersonality")

func on_personality_swap(personality: int) -> void:
	if personality == Enums.PersonalityStates.ATLAS:
		state_transition.emit(self, "AtlasLayout")
