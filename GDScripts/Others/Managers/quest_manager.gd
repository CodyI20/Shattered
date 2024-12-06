extends Control

@export var quests: Array[Dictionary] = [
	{
		"name": "Quest 1",
		"description": "Press Key 1 to complete this quest.",
		"validate": self.validate_key_1  # Reference to a function
	},
	{
		"name": "Quest 2",
		"description": "Reach the designated area to complete this quest.",
		"validate": self.validate_key_1  # Reference to a function
	},
	{
		"name": "Quest 3",
		"description": "Interact with the NPC to complete this quest.",
		"validate": self.validate_key_1  # Reference to a function
	}
]

var current_quest_index: int = 0
var completed_quests: Array[bool] = []

@onready var quest_log: VBoxContainer = $Panel/Quests/QuestLog
@onready var quest_title_label: Label = $Panel/About/QuestTitle
@onready var quest_description_label: Label = $Panel/About/QuestDescription
@onready var quest_manager_panel: Panel = $Panel  # Reference to the main quest manager panel

func _ready():
	# Initialize completed quests tracking
	completed_quests = []
	for quest in quests:
		completed_quests.append(false)
	
	# Display only the first quest initially
	_generate_quest_buttons()
	_update_quest_info()

	# Initially hide the quest manager
	quest_manager_panel.visible = false

func _process(delta: float):
	# Dynamically check if the current quest is completed
	if not completed_quests[current_quest_index]:
		var validate_func = quests[current_quest_index]["validate"]
		if validate_func.call():  # Call the function to validate the quest
			_complete_current_quest()

	# Toggle visibility with Tab key
	if Input.is_action_just_pressed("Quests"):
		_toggle_quest_manager()

func _generate_quest_buttons():
	# Clear existing buttons
	for child in quest_log.get_children():
		child.queue_free()

	# Generate buttons for all completed quests and the current active quest
	for i in range(quests.size()):
		if i > current_quest_index:  # Only allow up to the current quest
			break

		var quest = quests[i]
		var quest_button = Button.new()
		quest_button.text = quest["name"] if not completed_quests[i] else "[COMPLETED] " + quest["name"]
		quest_button.name = "QuestButton_%d" % i

		# Style the button based on state
		if completed_quests[i]:
			quest_button.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))  # Dimmed color for completed
		elif i == current_quest_index:
			quest_button.add_theme_color_override("font_color", Color(1, 1, 0))  # Highlight active quest
		else:
			quest_button.add_theme_color_override("font_color", Color(1, 1, 1))  # Normal color

		# Connect the button's pressed signal
		quest_button.pressed.connect(_on_quest_selected.bind(i))

		# Add button to the quest log
		quest_log.add_child(quest_button)

func _update_quest_info():
	# Update the title and description of the current quest
	var current_quest = quests[current_quest_index]
	quest_title_label.text = current_quest["name"]
	quest_description_label.text = current_quest["description"]

func _on_quest_selected(index: int):
	# Update the selected quest
	current_quest_index = index
	_update_quest_info()
	_highlight_selected_button()

func _complete_current_quest():
	# Mark the current quest as completed
	completed_quests[current_quest_index] = true
	print("Quest completed: ", quests[current_quest_index]["name"])
	
	# Update the quest log buttons
	_generate_quest_buttons()

	# Unlock and start the next quest if available
	if current_quest_index + 1 < quests.size():
		current_quest_index += 1
		_update_quest_info()
		_generate_quest_buttons()  # Refresh buttons to show the new quest
	else:
		print("All quests completed!")

func _highlight_selected_button():
	# Highlight the selected button in the quest log
	for button in quest_log.get_children():
		if button.name == "QuestButton_%d" % current_quest_index:
			button.add_theme_color_override("font_color", Color(1, 1, 0))  # Yellow highlight
		else:
			if button.text.begins_with("[COMPLETED]"):
				button.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))  # Dimmed color
			else:
				button.add_theme_color_override("font_color", Color(1, 1, 1))  # Default color

func _toggle_quest_manager():
	# Toggle the visibility of the quest manager panel
	quest_manager_panel.visible = not quest_manager_panel.visible

	# If the panel is now visible, regenerate the quest buttons to ensure they are interactable
	if quest_manager_panel.visible:
		_generate_quest_buttons()

# Utility functions for quest validation
func validate_key_1() -> bool:
	# Check if Key 1 is pressed
	return Input.is_action_just_pressed("key_1")

func validate_area_reached() -> bool:
	# Example: check if the player is in a specific area
	# Replace this with your actual implementation
	return is_player_in_area("QuestZone")

func validate_npc_interaction() -> bool:
	# Example: check if the player has interacted with an NPC
	# Replace this with your actual implementation
	return has_interacted_with_npc("QuestNPC")

func is_player_in_area(area_name: String) -> bool:
	# Example implementation of area checking
	return false

func has_interacted_with_npc(npc_name: String) -> bool:
	# Example implementation of NPC interaction
	return false
