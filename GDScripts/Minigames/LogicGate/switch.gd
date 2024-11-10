extends CheckButton

func _ready() -> void:
	Events.gate_not_solved.connect(reset_puzzle)

func _on_toggled(toggled_on: bool) -> void:
	Events.toggle_electricity.emit(toggled_on)
	disabled = true

func reset_puzzle() -> void:
	button_pressed = false
	disabled = false
