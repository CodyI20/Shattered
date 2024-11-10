extends CheckButton

func _ready() -> void:
	Events.gate_not_solved.connect(reset_puzzle)

func _on_toggled(toggled_on: bool) -> void:
	Events.toggle_electricity.emit(toggled_on)
	toggle_mode = false

func reset_puzzle() -> void:
	toggle_mode = true
	button_pressed = false
