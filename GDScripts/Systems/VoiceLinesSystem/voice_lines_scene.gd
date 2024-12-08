extends Control
class_name VoiceLines

#@export var voice_lines_datas : Array[VoiceLineData]

@export var keypad_voiceline : VoiceLineData
@export var clue_missed : VoiceLineData
@export var electricity_fixed : VoiceLineData
@export var start_of_game : VoiceLineData

@onready var subtitles_panel: Panel = $SubtitlesPanel
@onready var voice_lines_player: AudioStreamPlayer = $VoiceLinesPlayer
@onready var subtitles_label: Label = $SubtitlesPanel/MarginContainer/SubtitlesLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	subtitles_label.text = ""
	subtitles_panel.visible = false
	Events.on_interact_with_keypad_button_no_electricity.connect(play_keypad_voiceline)
	Events.player_left_important_area.connect(play_clue_missed_sound)
	Events.final_gate_solved.connect(play_final_gate_solved_sound)
	play_voice_line(start_of_game)
	
func play_keypad_voiceline() -> void:
	play_voice_line(keypad_voiceline)
	Events.on_interact_with_keypad_button_no_electricity.disconnect(play_keypad_voiceline)
	
func play_clue_missed_sound() -> void:
	play_voice_line(clue_missed)
	Events.player_left_important_area.disconnect(play_clue_missed_sound)
	
func play_final_gate_solved_sound() -> void:
	play_voice_line(electricity_fixed)
	Events.final_gate_solved.disconnect(play_final_gate_solved_sound)


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
