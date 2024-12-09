extends AudioStreamPlayer3D


func _ready() -> void:
	Events.music_box_puzzle_complete.connect(play)
