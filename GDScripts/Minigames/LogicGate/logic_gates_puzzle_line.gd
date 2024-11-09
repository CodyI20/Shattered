extends TextureRect

const LINE_CONNECTED = preload("res://Art/2D/LogicGatePuzzle/LineConnected.png")
const LINE_DISCONNECTED = preload("res://Art/2D/LogicGatePuzzle/LineDisconnected.png")

# Drag in the zone that will determine wether this line is considered connected
@export var zone_for_gate: DropZone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.correct_gate_entered.connect(set_line_connected)
	Events.wrong_gate_entered.connect(set_line_disconnected)
	
func set_line_connected(zone: DropZone) -> void:
	if zone != zone_for_gate:
		return
	texture = LINE_CONNECTED

func set_line_disconnected(zone: DropZone) -> void:
	if zone != zone_for_gate:
		return
	texture = LINE_DISCONNECTED
