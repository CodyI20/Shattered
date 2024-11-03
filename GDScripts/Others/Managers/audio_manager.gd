extends Node

@onready var background_music: AudioStreamPlayer = $backgroundMusic

@onready var walk_sfx: AudioStreamPlayer = $SFX/PlayerMovementSFX/walkSFX
@onready var jump_sfx: AudioStreamPlayer = $SFX/PlayerMovementSFX/jumpSFX

func _ready() -> void:
	_event_subscription()
	if background_music.stream == null:
		printerr("THERE IS NO STREAM IN YOUR MUSIC! FIX IT! ~Also check the bus it's in while you're at it~")
		return
	background_music.play()

func _event_subscription() -> void:
	Events.player_jumped.connect(play_jump_sound)
	Events.player_waking.connect(play_walk_sound)
	
func play_walk_sound(should_play: bool) -> void:
	if should_play:
		walk_sfx.play()
	else:
		walk_sfx.stop()

func play_jump_sound() -> void:
	jump_sfx.play()
