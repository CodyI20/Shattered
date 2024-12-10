extends Button
class_name MusicBoxOtherButtons

func _ready() -> void:
	Events.music_box_puzzle_complete.connect(disable_button)
	
func disable_button() -> void:
	disabled = true
