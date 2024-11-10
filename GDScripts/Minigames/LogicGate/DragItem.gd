extends TextureRect
class_name DragItem

var dragging = false
var original_position = Vector2.ZERO
var valid_drop_target = null  # Store a reference to the valid drop target if it exists
var current_slot : DropZone = null  # Reference to the slot this item is currently in
var personal_zone : DropZone
@export var gatetype = Enums.gate_type.NONE

func _ready() -> void:
	original_position = global_position
	personal_zone = DropZone.new()
	create_drop_zone()
	Events.valid_drop_target_entered.connect(_on_valid_drop_target_entered)
	Events.valid_drop_target_exited.connect(_on_valid_drop_target_exited)
	Events.gate_solved.connect(disable_process)
	Events.gate_not_solved.connect(reset_puzzle)

func reset_puzzle() -> void:
	print_debug("DragItem has been reset...")
	personal_zone.set_item(self)
	
func create_drop_zone() -> void:
	if current_slot == null:
		personal_zone.global_position = global_position + (size / 2)
		personal_zone.correct_gate = Enums.gate_type.NONE
		add_sibling.call_deferred(personal_zone)
		current_slot = personal_zone
		personal_zone.set_item(self)

# Called when the dragging starts
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and get_rect().has_point(event.position):
			Events.object_started_dragging.emit(self)
			dragging = true
			original_position = position
			mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE  # Ignore mouse events while dragging
			
		elif !event.is_pressed() and dragging:
			dragging = false
			Events.object_stopped_dragging.emit(self)
			mouse_filter = MouseFilter.MOUSE_FILTER_PASS
			if valid_drop_target is DropZone:
				valid_drop_target.set_item(self)
				valid_drop_target = null
			else:
				position = original_position  # Reset to original position if no valid drop target

# Dragging logic
func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() - size * 0.5  # Center the item on the cursor

func set_valid_drop_target(target: DropZone):
	valid_drop_target = target

# Slot signals handling
func _on_valid_drop_target_entered(dropTarget: DropZone):
	set_valid_drop_target(dropTarget)

func _on_valid_drop_target_exited(dropTarget: DropZone):
	set_valid_drop_target(null)
	
func disable_process() -> void:
	set_script(null)
