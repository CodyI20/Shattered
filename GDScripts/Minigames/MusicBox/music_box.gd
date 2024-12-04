extends Interactable

## Type in the name of the interaction (e.g. ElectricPuzzle; MusicBox...)
@export var interaction_text : String

func get_interaction_text():
	return interaction_text

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		Events.exited_puzzle_area.emit()
