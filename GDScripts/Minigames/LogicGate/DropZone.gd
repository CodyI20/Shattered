extends TextureRect
class_name DropZone

var item : DragItem = null  # Reference to the item currently in this slot
var is_hovered = false  # Tracks if an item is hovering over this slot
var puzzle_active = false

@export var correct_gate = Enums.gate_type.NONE

func _ready() -> void:
	Events.object_started_dragging.connect(clear_item)
	Events.logic_gate_puzzle_on.connect(toggle_on)
	Events.logic_gate_puzzle_off.connect(toggle_off)
	Events.gate_not_solved.connect(reset_puzzle)
	Events.logic_gates_puzzle_layout_change.connect(reset_puzzle)
	puzzle_active = true
	
func reset_puzzle() -> void:
	print_debug("DropZone has been reset...")
	set_item(null, false)

# Called when mouse enters the slot
func _on_mouse_entered():
	is_hovered = true
	Events.valid_drop_target_entered.emit(self)

# Called when mouse exits the slot
func _on_mouse_exited():
	is_hovered = false
	Events.valid_drop_target_exited.emit(self)
	
func toggle_on() -> void:
	puzzle_active = true

func toggle_off() -> void:
	puzzle_active = false
	
func clear_item(input_item: DragItem):
	if input_item == item:
		item = null
	
# Function to place the item in this slot
func set_item(new_item: DragItem, checkItem: bool = true):
	if not puzzle_active:
		return
		
	if correct_gate != Enums.gate_type.NONE and item == null:
		print_debug("WRONG GATE ENTERED! BECAUSE IT'S EMPTY")
		Events.wrong_gate_entered.emit(self)

	if item != null and checkItem:
		# If there is an existing item, handle it (e.g., swap or return it)
		var original_slot = new_item.current_slot
		item.current_slot = original_slot
		original_slot.set_item(item,false)

	item = new_item  # Set the new item that will be slotted
	if item != null:
		item.current_slot = self
		# Calculate the center position of the slot
		var slot_center = global_position + (size / 4)

		# Calculate the offset needed to center the item
		var item_offset = item.size / 2

		# Adjust item position to center it on the slot
		item.global_position = slot_center - item_offset
		
		if item.gatetype == correct_gate:
			print_debug("CORRECT GATE!")
			Events.correct_gate_entered.emit(self)
		else:
			print_debug("WRONG GATE ENTERED!")
			Events.wrong_gate_entered.emit(self)
