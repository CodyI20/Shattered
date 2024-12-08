extends Panel

@export var puzzle_type : Enums.puzzle_types
@export_multiline var label_text : String

@onready var continue_button: Button = $ContinueButton
@onready var label: Label = $Label

func _ready() -> void:
	toggle_button_functionality(false)
	_enable_button()
	
	label.text = label_text
	continue_button.pressed.connect(disable_panel)
	
func _enable_button() -> void:
	await get_tree().create_timer(2).timeout
	toggle_button_functionality(true)
	
func toggle_button_functionality(toggle_on : bool) -> void:
	continue_button.visible = toggle_on
	continue_button.disabled = !toggle_on

# CONNECTED TO THE BUTTON
func disable_panel() -> void:
	Events.puzzle_started.emit(puzzle_type)
	queue_free()
