extends TextureRect
class_name DropZone

var item : DragItem = null  # Reference to the item currently in this slot
var is_hovered = false  # Tracks if an item is hovering over this slot

@export var correct_gate = GateEnum.gate_type.AND

func _ready() -> void:
	Events.object_started_dragging.connect(clear_item)

# Called when mouse enters the slot
func _on_mouse_entered():
	is_hovered = true
	Events.valid_drop_target_entered.emit(self)

# Called when mouse exits the slot
func _on_mouse_exited():
	is_hovered = false
	Events.valid_drop_target_exited.emit(self)
	

func clear_item(input_item: DragItem):
	if input_item == item:
		item = null
	
# Function to place the item in this slot
func set_item(new_item: DragItem, checkItem: bool = true):
	if item != null and checkItem:
		# If there is an existing item, handle it (e.g., swap or return it)
		var original_slot = new_item.current_slot
		item.current_slot = original_slot
		original_slot.set_item(item,false)

	item = new_item  # Set the new item that will be slotted
	item.current_slot = self
	# Calculate the center position of the slot
	var slot_center = global_position + (size / 2)

	# Calculate the offset needed to center the item
	var item_offset = item.size / 2

	# Adjust item position to center it on the slot
	item.global_position = slot_center - item_offset
	
	if item.gatetype == correct_gate:
		print_debug("CORRECT GATE!")
		Events.correct_gate_entered.emit(self)
