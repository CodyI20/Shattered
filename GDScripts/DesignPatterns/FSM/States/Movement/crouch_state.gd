extends State
class_name PlayerCrouch

@onready var player: Player = $"../.."

func Enter() -> void:
	player.movement_speed = player.WALK_SPEED
	print_debug("Entering crouching state...")
	
func Exit() -> void:
	print_debug("Exiting crouching state...")

func Update(_delta:float) -> void:
	pass
	
		
func StateSwitchLogic() -> void:
	#if Input.is_action_pressed("sprint"):
		#state_transition.emit(self, "Running")
	if Input.is_action_just_pressed("crouch"):
		state_transition.emit(self, "Walking")
	if Input.is_action_just_pressed("sprint"):
		state_transition.emit(self, "Running")
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jumping")
	if !player.is_on_floor():
		state_transition.emit(self, "Falling")

func Physics_Update(_delta:float) -> void:
	# Get input direction and handle movement.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (player.head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * player.movement_speed
		player.velocity.z = direction.z * player.movement_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.movement_speed)
		player.velocity.z = move_toward(player.velocity.x, 0, player.movement_speed)
	StateSwitchLogic()
