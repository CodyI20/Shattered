extends Control

var tutorial_steps = [
	"Press 'W' to move forward",
	"Press 'A' to move left",
	"Press 'S' to move backward",
	"Press 'D' to move right",
	"Press 'N' to switch alter"
]

var current_step = 0

@onready var label = $Panel/Label

func _ready():
	label.text = tutorial_steps[current_step]
	self.visible = true

func _process(delta):
	if current_step == 0 and Input.is_action_just_pressed("up"):
		advance_tutorial()
	elif current_step == 1 and Input.is_action_just_pressed("left"):
		advance_tutorial()
	elif current_step == 2 and Input.is_action_just_pressed("down"):
		advance_tutorial()
	elif current_step == 3 and Input.is_action_just_pressed("right"):
		advance_tutorial()
	elif current_step == 4 and Input.is_action_just_pressed("CyclePersonalities"):
		advance_tutorial()

func advance_tutorial():
	current_step += 1
	if current_step < tutorial_steps.size():
		label.text = tutorial_steps[current_step]
	else:
		self.visible = false
