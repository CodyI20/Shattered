extends TextureRect

const LINE_CONNECTED = preload("res://Art/2D/LogicGatePuzzle/LineConnected.png")
const LINE_DISCONNECTED = preload("res://Art/2D/LogicGatePuzzle/LineDisconnected.png")

var saved_texture := LINE_DISCONNECTED
@export var connected_drop_zone : DropZone
@export var SWITCH_GATE : bool = false
@export var FINAL_GATE : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_line_to_disconnected()
	apply_saved_texture(true)
	Events.gate_not_solved.connect(reset_puzzle)
	if SWITCH_GATE:
		FINAL_GATE = false
		connected_drop_zone = null
		Events.toggle_electricity.connect(switch_gate_logic)
	if FINAL_GATE:
		SWITCH_GATE = false
		connected_drop_zone = null
		Events.gate_solved.connect(final_gate_logic)
	if SWITCH_GATE and FINAL_GATE:
		printerr("You are setting it as both SWITCH_GATE and FINAL_GATE. Please choose one!")
	if SWITCH_GATE or FINAL_GATE:
		return
	_event_subscription()
	
	if !SWITCH_GATE and !FINAL_GATE and connected_drop_zone == null:
		printerr("There seems to be no drop zone connected to this line...")
		
func _event_subscription() -> void:
	Events.correct_gate_entered.connect(display_line_connected)
	Events.wrong_gate_entered.connect(display_line_disconnected)
	Events.toggle_electricity.connect(apply_saved_texture)
	
func display_line_connected(zone: DropZone) -> void:
	if zone == connected_drop_zone:
		set_line_to_connected()

func display_line_disconnected(zone: DropZone) -> void:
	if zone == connected_drop_zone:
		set_line_to_disconnected()

func set_line_to_connected() -> void:
	saved_texture = LINE_CONNECTED

func set_line_to_disconnected() -> void:
	saved_texture = LINE_DISCONNECTED
	
func switch_gate_logic(toggle_on: bool) -> void:
	if toggle_on:
		set_line_to_connected()
	else:
		set_line_to_disconnected()
	apply_saved_texture(true)

func final_gate_logic() -> void:
	set_line_to_connected()
	apply_saved_texture(true)
	
func apply_saved_texture(should_apply: bool) -> void:
	if !should_apply:
		texture = LINE_DISCONNECTED
	else:
		texture = saved_texture

func reset_puzzle() -> void:
	print_debug("ConnectionLine has been reset...")
	set_line_to_disconnected()
	apply_saved_texture(true)
