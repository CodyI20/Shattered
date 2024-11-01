extends State
class_name PlayerRun

const SPEED = 500.0
@onready var player := $"../.."
@onready var animated_sprite := $"../../AnimatedSprite2D"

func Enter() -> void:
	animated_sprite.play("Running")
	print_debug("Entering running state...")
	
func Exit() -> void:
	print_debug("Exiting running state...")

func Update(_delta:float) -> void:
	pass
	
		
func StateSwitchLogic() -> void:
	if Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
		state_transition.emit(self, "Idle")
	if !Input.is_action_pressed("Run"):
		state_transition.emit(self, "Walking")
	if !Input.is_action_pressed("Left") and !Input.is_action_pressed("Right"):
		state_transition.emit(self, "Idle")
	if Input.is_action_just_pressed("Jump"):
		state_transition.emit(self, "Jumping")
	if !player.is_on_floor():
		state_transition.emit(self, "Falling")

func Physics_Update(_delta:float) -> void:
	var direction := Input.get_axis("Left","Right")
	
	if direction != 0:
		player.velocity.x = direction * SPEED
		animated_sprite.flip_h = direction > 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		
	StateSwitchLogic()
