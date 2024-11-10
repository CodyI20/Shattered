extends Control

@export var tutorial_steps_sequence : Array[TutorialStep]
var current_step_count = 0
var saved_current_step_count = 0

@export var tutorial_steps_non_sequence : Array[TutorialStep]

@onready var label = $Panel/Label

func _ready():
	Events.play_tutorial_step.connect(play_step)
	Events.complete_tutorial_step.connect(advance_tutorial)
	for step in tutorial_steps_non_sequence:
		step.Ready()
	play_step(tutorial_steps_sequence[current_step_count])

func _process(delta):
	if current_step_count >= tutorial_steps_sequence.size():
		return
	tutorial_steps_sequence[current_step_count].Process()

func play_step(step : TutorialStep) -> void:
	if step.completed == true:
		return
	self.visible = true
	var text_template = step.tutorial_text
	var action = step.tutorial_action
	label.text = text_template % OS.get_keycode_string(InputMap.action_get_events(action)[0].physical_keycode)


func advance_tutorial(finished_step: TutorialStep):
	if tutorial_steps_non_sequence.has(finished_step) and current_step_count < tutorial_steps_sequence.size():
		play_step(tutorial_steps_sequence[current_step_count])
		self.visible = true
		return

	current_step_count += 1
	
	if current_step_count < tutorial_steps_sequence.size():
		play_step(tutorial_steps_sequence[current_step_count])
	
	if current_step_count >= tutorial_steps_sequence.size():
		self.visible = false
