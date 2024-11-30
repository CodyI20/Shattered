extends Control

var layout_children : Array
var current_active_child_index := 0

func _ready() -> void:
	layout_children = get_children()
	if layout_children.size() > 0:
		toggle_item(layout_children[0], true)
	if layout_children.size() > 1:
		for i in range(1, layout_children.size()):
			toggle_item(layout_children[i])
		
	Events.gate_solved.connect(handle_gate_solved)

func toggle_item(item : Control, toggle_on : bool = false) -> void:
	item.visible = toggle_on
	if toggle_on:
		item.mouse_filter = Control.MOUSE_FILTER_PASS
	else:
		item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	

func handle_gate_solved() -> void:
	current_active_child_index += 1
	if current_active_child_index >= layout_children.size():
		Events.gate_solved.disconnect(handle_gate_solved)
		print_debug("GONNA GET OUT OF BOUNDS!")
		return
	await get_tree().create_timer(2).timeout
	Events.logic_gates_puzzle_layout_change.emit()
	toggle_item(layout_children[current_active_child_index-1])
	toggle_item(layout_children[current_active_child_index], true)
