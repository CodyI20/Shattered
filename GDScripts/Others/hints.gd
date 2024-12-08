extends Control

var hints = [
	"This is the first hint",
	"This is the second hint",
	"This is the third hint",
	"This is the fourth hint"
]

var current_hint_index = 0
var max_objects = 4
var interacted_objects = 0

@onready var hint_label: Label = $Panel/MarginContainer/Label
@onready var hint_timer: Timer = $Timer
@onready var hint_panel: Panel = $Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready function called!")
	hint_panel.visible = false
	hint_label.text = ""
	
	hint_timer.wait_time = 4.0
	hint_timer.connect("timeout", Callable(self, "on_timer_timeout"))
	
	hint_timer.start()
	print("Timer started with wait time:", hint_timer.wait_time)
	
	hint_timer.emit_signal("timeout")

func _on_timer_timeout():
	print("Timer fired")
	if interacted_objects <= current_hint_index:
		show_ui_with_hint()

func show_ui_with_hint():
	print("Showing hint:", hints[current_hint_index])
	hint_label.text = hints[current_hint_index]
	hint_panel.visible = true

func close_ui():
	hint_panel.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("key_1") and current_hint_index == 0:
		on_interacted_objects(0)
	elif Input.is_action_just_pressed("key_2") and current_hint_index == 1:
		on_interacted_objects(1)
	elif Input.is_action_just_pressed("key_3") and current_hint_index == 2:
		on_interacted_objects(2)
	elif Input.is_action_just_pressed("key_4") and current_hint_index == 3:
		on_interacted_objects(3)
	
	if Input.is_action_just_pressed("ui_cancel"):
		close_ui()

func on_interacted_objects(index: int):
	if index == interacted_objects:
		interacted_objects += 1
		current_hint_index = interacted_objects
		
		hint_label.text = ""
		hint_panel.visible = false
		
		if interacted_objects < max_objects:
			hint_timer.start()

func reopen_ui():
	if interacted_objects < max_objects:
		current_hint_index = interacted_objects
		show_ui_with_hint()
