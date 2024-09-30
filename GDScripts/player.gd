class_name Player
extends CharacterBody3D

# @onready var _world_root: WorldRoot = %WorldRoot


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

var gravity = 9.8

var is_crouching : bool = false

@onready var head = $head
@onready var camera = $head/Camera3D


var initial_camera_y = 0.0

func _input(event):
	if event.is_action_pressed("crouch"):
		toggle_crouch()

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

func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
			Events.player_waking.emit(true)
		if Input.is_action_just_released("up") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
			Events.player_waking.emit(false)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		Events.player_jumped.emit()
		velocity.y = JUMP_VELOCITY

	# Get input direction and handle movement.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	
	t_bob += delta * velocity.length() * float(is_on_floor())

	var camera_pos = camera.transform.origin
	camera_pos.y = initial_camera_y + _headbob(t_bob).y
	camera.transform.origin = camera_pos

	move_and_slide()
	
func toggle_crouch():
	if is_crouching == true:
		print("Uncrouch")
	elif is_crouching == false:
		print("Crouching")
	is_crouching = !is_crouching

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	return pos
