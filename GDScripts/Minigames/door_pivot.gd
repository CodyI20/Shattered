extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.on_correct_password.connect(open_door)

func open_door() -> void:
	animation_player.play("Door_open")