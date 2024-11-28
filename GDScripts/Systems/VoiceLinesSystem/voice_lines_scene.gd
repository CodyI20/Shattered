extends Control
class_name VoiceLines

@export var voice_lines_datas : Array[VoiceLineData]

@onready var subtitles_panel: Panel = $SubtitlesPanel
@onready var voice_lines_player: AudioStreamPlayer = $VoiceLinesPlayer
@onready var subtitles_label: Label = $SubtitlesPanel/MarginContainer/SubtitlesLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	subtitles_label.text = ""
	subtitles_panel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Quick check
	if Input.is_action_just_pressed("Interact"):
		if voice_lines_datas.size() == 0:
			return
		play_voice_line(voice_lines_datas[0])


func play_voice_line(voice_line : VoiceLineData) -> void:
	# Stop any current voice line:
	voice_lines_player.stop()
	subtitles_label.text = ""
	subtitles_panel.visible = false
	
	# Set the new one
	voice_lines_player.stream = voice_line.audio_clip
	voice_lines_player.play()
	subtitles_label.text = voice_line.subtitles
	subtitles_panel.visible = true
	
	await voice_lines_player.finished
	subtitles_label.text = ""
	subtitles_panel.visible = false
