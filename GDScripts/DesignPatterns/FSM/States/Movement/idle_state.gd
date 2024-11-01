extends State
class_name PlayerIdle

func Enter():
	print_debug("Entering idle state...")
func Exit():
	print_debug("Exiting idle state...")
func Update(_delta: float):
	StateSwitchLogic()
func Physics_Update(_delta: float):
	pass
	
func StateSwitchLogic():
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		state_transition.emit(self, "Walking")
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jumping")
