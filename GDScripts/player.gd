extends CharacterBody3D
class_name Player

# @onready var _world_root: WorldRoot = %WorldRoot

# The unit of Speed (in Godot?)is m/s so the default for a player walking 5 km/h would be 1.388 m/s
# The default for a player running 10 km/h would be 2.778 m/s 
# The default for a player sprinting 21 km/h would be 5.833 m/s 
const WALK_SPEED = 1.388
const JOG_SPEED = 2.778
const SPRINT_SPEED = 5.833
@export var movement_speed := 2.778

const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

# For the head bobbing
const BOB_FREQ = 10.0
const BOB_AMP = 0.02
var t_bob = 0.0
var t_bob_factor = 1.6 # change to bob a bit faster

var gravity = 9.8

# Toggle variables
var is_crouching : bool = false
var is_sprinting : bool = false

@onready var head = $head
@onready var camera = $head/Camera3D


var initial_camera_y = 0.0

func _input(event):
	if event.is_action_pressed("crouch"):
		toggle_crouch()
	if event.is_action_pressed("sprint"):
		toggle_sprint()

func _ready():
	# Capture the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


	initial_camera_y = camera.transform.origin.y
	# _world_root = get_node(world_root)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	t_bob += delta * float(is_on_floor()) * velocity.length() * t_bob_factor / movement_speed

	var camera_pos = camera.transform.origin
	camera_pos.y = initial_camera_y + _headbob(t_bob).y
	camera.transform.origin = camera_pos

	move_and_slide()
	
	#These toggles have to be turned into states later
func toggle_crouch():
	if is_crouching == true:
		print("Crouch")
		movement_speed = WALK_SPEED
		print("movement_speed=", movement_speed)
	elif is_crouching == false:
		print("Uncrouching")
		movement_speed = JOG_SPEED
		print("movement_speed=", movement_speed)
	is_crouching = !is_crouching

func toggle_sprint():
	if is_sprinting == true:
		print("Sprinting")
		movement_speed = SPRINT_SPEED
		print("movement_speed=", movement_speed)
	elif is_sprinting == false:
		print("Stop sprinting")
		movement_speed = JOG_SPEED
		print("movement_speed=", movement_speed)
	is_sprinting = !is_sprinting

# Bobs head
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	return pos
