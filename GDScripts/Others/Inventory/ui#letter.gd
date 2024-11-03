extends Control

@onready var ui_letter_label: Label = $"UI_Letter#Label"
var paper_text = "OMG i am so clumsy and forgetful! \n I am gonna write the code in this note now, it's: 1234"
@onready var CANVAS: CanvasLayer = $"../.."

@export var Item_type : ItemData
var being_interacted_with: bool = false

func _ready() -> void:
	Events.item_inspected.connect(pop_up_ui)
	Events.on_interact.connect(interact)

func set_item_type(data: ItemData):
	Item_type = data

func pop_up_ui(new_item_data: ItemData):
	if Item_type == new_item_data:
		interact_actions()

func interact(obj: Interactable):
	if obj is not PaperClass:
		return
	Item_type = (obj as PaperClass).Item_type
	interact_actions()

func interact_actions():
	set_process(true)
	CANVAS.layer = 11
	being_interacted_with = true
	get_tree().paused = true
	# Make the letter visible on screen.
	visible = true
	ui_letter_label.text = paper_text
	
func _process(_delta):
	if being_interacted_with and Input.is_action_just_pressed("Esc"):
		being_interacted_with = false
		CANVAS.layer = 1
		visible = false
		set_process(false)
