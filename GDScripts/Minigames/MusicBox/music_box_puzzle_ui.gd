extends PuzzleUI
class_name MusicBoxPuzzleUI

@onready var main_audio: MusicBoxMainAudio = $MainAudio

var current_sound_index := 0
var correct_sounds_in_sequence := 0

func _ready() -> void:
	super()
	_event_subscription()
	
func _event_subscription() -> void:
	Events.music_box_button_pressed.connect(check_button_press)

func check_button_press(sound : AudioStream) -> void:
	current_sound_index += 1
	if current_sound_index == main_audio.new_sounds_array.size():
		if correct_sounds_in_sequence == main_audio.new_sounds_array.size():
			Events.music_box_puzzle_complete.emit()
			await get_tree().create_timer(1.5).timeout
			close_puzzle()
		else:
			print_debug("Sounds are different...")
			reset_puzzle()
		return
	if sound == main_audio.new_sounds_array[current_sound_index]:
		print_debug("Sound is the same!...")
		correct_sounds_in_sequence += 1
		

func _on_replay_button_pressed() -> void:
	Events.music_box_replay_sound.emit()

func reset_puzzle() -> void:
	current_sound_index = 0
	correct_sounds_in_sequence = 0
	Events.music_box_puzzle_reset.emit()
