extends Interactable


func get_interaction_text():
	return "ElectricPanel"


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		Events.exited_puzzle_area.emit()
