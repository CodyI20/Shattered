extends MeshInstance3D

const OUTLINED_SHADER = preload("res://Art/Shaders/outlined_shader.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.personality_swap.connect(toggle_outline)

func toggle_outline(personality: String) -> void:
	if personality == "Alter1":
		material_overlay = OUTLINED_SHADER
	else:
		material_overlay = null
