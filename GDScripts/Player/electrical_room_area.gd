extends Area3D
class_name ElectricalRoomArea

var can_emit := false

func _ready() -> void:
	Events.final_gate_solved.connect(enable_emitting)

func enable_emitting() -> void:
	can_emit = true
	
func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and can_emit:
		Events.player_left_important_area.emit()
