extends AudioStreamPlayer
class_name MusicBoxMainAudio

@export var puzzle_sounds : Array[AudioStream]
var new_sounds_array : Array[AudioStream]

@export var failure_sound : AudioStream

func _ready() -> void:
	_event_subscription()
	if failure_sound == null:
		printerr("Please assing a failure_sound for ", name)
	
func _event_subscription() -> void:
	Events.music_box_puzzle_reset.connect(puzzle_reset)
	Events.puzzle_started.connect(puzzle_setup)
	Events.music_box_button_pressed.connect(play_sound)
	Events.music_box_replay_sound.connect(play_sounds_no_event)
	
func puzzle_setup(puzzle_type : Enums.puzzle_types) -> void:
	if puzzle_type != Enums.puzzle_types.MUSIC_BOX:
		return
	print_debug("Starting the puzzle...")
	new_sounds_array.append_array(Utility.jumble_array(puzzle_sounds))
	await get_tree().create_timer(2.5).timeout
	play_sounds()

func puzzle_reset() -> void:
	await get_tree().create_timer(0.5).timeout
	new_sounds_array.clear()
	new_sounds_array.append_array(Utility.jumble_array(puzzle_sounds))
	stream = failure_sound
	play()
	await self.finished
	Events.music_box_puzzle_reset_sound_finished.emit()
	await get_tree().create_timer(1.5).timeout
	play_sounds()
	
func play_sounds() -> void:
	for i in range(0, new_sounds_array.size()):
		stream = new_sounds_array[i]
		play()
		await self.finished
		await get_tree().create_timer(0.5).timeout
	Events.music_box_audio_finished.emit()
	
func play_sounds_no_event() -> void:
	for i in range(0, new_sounds_array.size()):
		stream = new_sounds_array[i]
		play()
		await self.finished
		await get_tree().create_timer(0.5).timeout

func play_sound(sound : AudioStream) -> void:
	stream = sound
	play()
