extends ColorRect
class_name MusicBoxPuzzleOutcome

@export var failure_color : Color
@export var success_color : Color

func _ready() -> void:
	visible = false
	mouse_filter = MOUSE_FILTER_IGNORE
	_event_subscription()
	
func _event_subscription() -> void:
	Events.music_box_puzzle_reset.connect(handle_puzzle_fail)
	Events.music_box_puzzle_reset_sound_finished.connect(handle_puzzle_fail_end)
	Events.music_box_puzzle_complete.connect(handle_puzzle_complete)

func handle_puzzle_fail() -> void:
	await get_tree().create_timer(0.5).timeout
	color = failure_color
	visible = true

func handle_puzzle_fail_end() -> void:
	visible = false

func handle_puzzle_complete() -> void:
	color = success_color
	visible = true
