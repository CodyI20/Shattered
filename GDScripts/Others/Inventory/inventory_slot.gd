extends Button
class_name InventorySlot

signal OnItemEquiped(SlotID)
signal OnItemDropped(fromSlotID, toSlotID)

@export var EquippedHighlight : Panel

var InventorySlotID : int = -1
var SlotFilled : bool = false

var SlotData : ItemData

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print_debug("Item: %s interacted with" % SlotData)
				Events.item_inspected.emit(SlotData)
			elif event.double_click:
				print_debug("InventorySlotID:", InventorySlotID)
				OnItemEquiped.emit(InventorySlotID)


func FillSlot(data : ItemData, equipped : bool):
	print_debug("Filling the slot with ", data)
	SlotData = data
	EquippedHighlight.visible = equipped
	if (SlotData != null):
		SlotFilled = true
		icon = data.Item
	else:
		SlotFilled = false
		icon = null

func _get_drag_data(at_position: Vector2) -> Variant:
	if (SlotFilled):
		var preview : TextureRect = TextureRect.new()
		preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		preview.size = icon.get_size()
		preview.pivot_offset = icon.get_size() / 2.0
		preview.rotation = 2.0
		preview.texture = icon
		set_drag_preview(preview)
		return {"Type": "Item", "ID": InventorySlotID}
	else:
		return false

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data["Type"] == "Item"
	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	OnItemDropped.emit(data["ID"], InventorySlotID)
