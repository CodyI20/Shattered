extends Control

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var animation_player: AnimationPlayer = $Subtitles/AnimationPlayer

var paused : bool = false

func _ready() -> void:
	if animation_player!=null:
		animation_player.play("display_subtitles")
	await video_stream_player.finished.connect(Utility.go_to_game_scene)

func _on_skip_button_pressed() -> void:
	Utility.go_to_game_scene()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		paused = !paused
		video_stream_player.paused = paused
		if paused:
			animation_player.pause()
		else:
			animation_player.play()
		Events.options_menu_toggle.emit(paused)
