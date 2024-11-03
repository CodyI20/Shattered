extends Control

@onready var animation_player: AnimationPlayer = $Pause/AnimationPlayer
@onready var pause_container: Control = $Pause

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.options_menu_toggle.connect(toggle_pause_container)
	animation_player.play("RESET")

func _on_game_paused() -> void:
	animation_player.play("Blur")

func _on_game_resumed() -> void:
	animation_player.play_backwards("Blur")

func toggle_pause_container(turn_on: bool) -> void:
	pause_container.visible = !turn_on
	pause_container.set_process(!turn_on)
	
