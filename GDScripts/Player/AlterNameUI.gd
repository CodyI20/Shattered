extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.personality_swap.connect(set_alter_name)


func set_alter_name(personality : int):
	match personality:
		enums.PersonalityStates.NICK:
			text = enums.PersonalityStates.keys()[enums.PersonalityStates.NICK]
		enums.PersonalityStates.ATLAS:
			text = enums.PersonalityStates.keys()[enums.PersonalityStates.ATLAS]
