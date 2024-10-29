extends TextureRect

const LIGHTBULB_OFF = preload("res://Art/2D/LogicGatePuzzle/lightbulb_off.png")
const LIGHTBULB_ON = preload("res://Art/2D/LogicGatePuzzle/lightbulb_on.png")

func _ready() -> void:
	texture = LIGHTBULB_ON
