extends Panel

@onready var continue_button: Button = $ContinueButton

func _ready() -> void:
	toggle_button_functionality(false)
	_enable_button()
	continue_button.pressed.connect(disable_panel)
	
func _enable_button() -> void:
	await get_tree().create_timer(2).timeout
	toggle_button_functionality(true)
	
func toggle_button_functionality(toggle_on : bool) -> void:
	continue_button.visible = toggle_on
	continue_button.disabled = !toggle_on

# CONNECTED TO THE BUTTON
func disable_panel() -> void:
	Events.music_box_puzzle_started.emit()
	queue_free()
