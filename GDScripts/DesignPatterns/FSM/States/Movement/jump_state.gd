extends State
class_name PlayerJump

const JUMP_VELOCITY := 5

@onready var player := $"../.."

func Enter() -> void:
	if player.is_on_floor():
		Events.player_jumped.emit()
		player.velocity.y = JUMP_VELOCITY
	print_debug("Entering jump state...")

func Exit() -> void:
	print_debug("Exiting jump state...")

func Update(_delta:float) -> void:
	StateSwitchLogic()

func StateSwitchLogic() -> void:
	state_transition.emit(self, "Falling")
