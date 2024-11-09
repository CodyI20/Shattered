extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.on_correct_password.connect(open_door)
	animation_player.play("RESET")

func open_door() -> void:
	if animation_player == null:
		return
	animation_player.play("Door_open")
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "Door_open":
		animation_player.queue_free()
