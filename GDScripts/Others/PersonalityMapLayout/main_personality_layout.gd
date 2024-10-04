extends State
class_name MainPersonalityLayoutState
@onready var main_pers_animator: AnimationPlayer = $MainPersAnimator


func _ready() -> void:
	main_pers_animator.play("RESET")
	Events.alter1_swap.connect(on_alter1_swap)

func Enter():
	main_pers_animator.play("SwitchToMainPersonality")
	
func Exit():
	print_debug("EXITING MAIN LAYOUT")
	main_pers_animator.play("SwitchFromMainPersonality")

func on_alter1_swap() -> void:
	state_transition.emit(self,"Alter1Layout")
