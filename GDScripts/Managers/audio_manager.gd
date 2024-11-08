extends Node

@onready var walk_sfx: AudioStreamPlayer = $walkSFX
@onready var jump_sfx: AudioStreamPlayer = $jumpSFX
@onready var start_sfx: AudioStreamPlayer = $startSFX

func _ready() -> void:
	Events.player_jumped.connect(play_jump_sound)
	Events.player_waking.connect(play_walk_sound)
	Events.start_game.connect(start_game_sound)

func play_walk_sound(should_play: bool) -> void:
	if should_play:
		walk_sfx.play()
	else:
		walk_sfx.stop()

func play_jump_sound() -> void:
	jump_sfx.play()

func start_game_sound() -> void:
	start_sfx.play()
