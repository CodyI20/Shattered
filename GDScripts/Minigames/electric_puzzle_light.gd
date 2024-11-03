extends SpotLight3D

@export var energy = 12

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.gate_solved.connect(turn_light_on)
	light_energy = 0

func turn_light_on() -> void:
	light_energy = energy
