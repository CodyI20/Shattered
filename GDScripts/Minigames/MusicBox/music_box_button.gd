extends Button
class_name MusicBoxButton

@export var sound : AudioStream
var has_been_pressed := false

func _ready() -> void:
	disabled = true
	_event_subscription()

func _event_subscription() -> void:
	Events.music_box_puzzle_reset.connect(restart_puzzle)
	Events.music_box_audio_finished.connect(start_puzzle)
	Events.music_box_button_pressed.connect(shortly_disable_button)
	pressed.connect(_on_pressed)

func start_puzzle() -> void:
	disabled = false
	has_been_pressed = false
	
func _on_pressed() -> void:
	Events.music_box_button_pressed.emit(sound)
	has_been_pressed = true
	disabled = true

func shortly_disable_button(input_sound : AudioStream) -> void:
	disabled = true
	await get_tree().create_timer(input_sound.get_length() + 0.25).timeout
	if not has_been_pressed:
		disabled = false

func restart_puzzle() -> void:
	disabled = true
	has_been_pressed = true
