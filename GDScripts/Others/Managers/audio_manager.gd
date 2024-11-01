extends Node

@onready var walk_sfx: AudioStreamPlayer = $walkSFX
@onready var jump_sfx: AudioStreamPlayer = $jumpSFX

func _ready() -> void:
	Events.player_jumped.connect(play_jump_sound)
	Events.player_waking.connect(play_walk_sound)

func play_walk_sound(should_play: bool) -> void:
	if should_play:
		walk_sfx.play()
	else:
		walk_sfx.stop()

func play_jump_sound() -> void:
	jump_sfx.play()
