extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("RESET")

func _on_game_paused() -> void:
	animation_player.play("Blur")

func _on_game_resumed() -> void:
	animation_player.play_backwards("Blur")
	
