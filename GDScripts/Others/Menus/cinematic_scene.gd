extends Control

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer

func _ready() -> void:
	await video_stream_player.finished.connect(Utility.go_to_game_scene)

func _on_skip_button_pressed() -> void:
	Utility.go_to_game_scene()
