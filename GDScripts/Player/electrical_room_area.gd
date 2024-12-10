extends Area3D
class_name ElectricalRoomArea

var can_emit := false
var objective_solved := false

func _ready() -> void:
	Events.final_gate_solved.connect(enable_emitting)
	Events.OnItemPickedUp.connect(disable_emitting)

func enable_emitting() -> void:
	if objective_solved == false:
		can_emit = true
	
func disable_emitting(data : ItemData) -> void:
	if data.ItemName == "Paper":
		objective_solved = true
		can_emit = false
	
func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and can_emit:
		Events.player_left_important_area.emit()
