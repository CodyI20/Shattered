extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")

func _on_game_paused() -> void:
	$AnimationPlayer.play("Blur")

func _on_game_resumed() -> void:
	$AnimationPlayer.play_backwards("Blur")
