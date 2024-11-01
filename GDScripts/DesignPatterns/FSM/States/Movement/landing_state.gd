extends State

@onready var player := $"../.."

func Enter() -> void:
	player.velocity.x = 0
	player.velocity.z = 0
	print_debug("Entering landing state...")

func Exit() -> void:
	print_debug("Exiting landing state...")

func Update(_delta:float) -> void:
	StateSwitchLogic()

func Physics_Update(_delta:float) -> void:
	pass
	
func StateSwitchLogic() -> void:
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("up") or Input.is_action_pressed("down")):
		state_transition.emit(self, "Walking")
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jumping")
	if player.is_on_floor():
		state_transition.emit(self, "Idle")

## Signal from -//- so the animation can fully play before entering Idle state
#func AnimationFinished() -> void:
	#if player.is_on_floor():
		#state_transition.emit(self, "Idle")
