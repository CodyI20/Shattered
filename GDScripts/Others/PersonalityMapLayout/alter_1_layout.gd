extends MainMechanicLayoutBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.alter1_swap.connect(on_alter_swap)
