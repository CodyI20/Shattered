extends State

@onready var player := $"../.."

func Enter() -> void:
	print_debug("Entering falling state...")

func Exit() -> void:
	print_debug("Exiting falling state...")

func Update(_delta:float) -> void:
	StateSwitchLogic()

func Physics_Update(_delta:float) -> void:
	#if not player.is_on_floor():
		#player.velocity += player.get_gravity() * _delta
	pass
	
func StateSwitchLogic() -> void:
	if player.is_on_floor():
		state_transition.emit(self, "Landing")
	
