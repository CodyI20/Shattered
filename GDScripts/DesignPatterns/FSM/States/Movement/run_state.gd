extends State
class_name PlayerRun

@onready var player: Player = $"../.."

func Enter() -> void:
	player.movement_speed = player.SPRINT_SPEED
	print_debug("Entering running state...")
	
func Exit() -> void:
	print_debug("Exiting running state...")

func Update(_delta:float) -> void:
	pass
	
		
func StateSwitchLogic() -> void:
	if Input.is_action_pressed("left") and Input.is_action_pressed("right") or Input.is_action_pressed("up") and Input.is_action_pressed("down") or Input.is_action_pressed("left") and Input.is_action_pressed("right") and Input.is_action_pressed("up") and Input.is_action_pressed("down"):
		state_transition.emit(self, "Idle")
	if Input.is_action_just_pressed("sprint"):
		state_transition.emit(self, "Walking")
	if !Input.is_action_pressed("left") and !Input.is_action_pressed("right") and !Input.is_action_pressed("up") and !Input.is_action_pressed("down"):
		state_transition.emit(self, "Idle")
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jumping")
	if !player.is_on_floor():
		state_transition.emit(self, "Falling")

func Physics_Update(_delta:float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (player.head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * player.movement_speed
		player.velocity.z = direction.z * player.movement_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.movement_speed)
		player.velocity.z = move_toward(player.velocity.x, 0, player.movement_speed)
	StateSwitchLogic()