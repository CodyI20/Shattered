extends MainMechanicLayoutBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.main_personality_swap.connect(on_alter_swap)
