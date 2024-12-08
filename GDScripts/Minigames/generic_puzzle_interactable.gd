extends Interactable
class_name PuzzleInteractable

## Set the type of puzzle interaction (e.g. ElectricPuzzle; MusicBox...)
@export var interaction_type : Enums.puzzle_types

func _ready() -> void:
	if interaction_type == Enums.puzzle_types.NONE:
		printerr("The type of the puzzle3D %s is NONE! Please fill it in!" % self.name)

func get_interaction_type():
	return interaction_type

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		Events.exited_puzzle_area.emit()
