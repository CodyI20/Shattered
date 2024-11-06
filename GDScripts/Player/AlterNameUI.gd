extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.personality_swap.connect(set_alter_name)


func set_alter_name(personality : int):
	match personality:
		Enums.PersonalityStates.NICK:
			text = Enums.PersonalityStates.keys()[Enums.PersonalityStates.NICK]
		Enums.PersonalityStates.ATLAS:
			text = Enums.PersonalityStates.keys()[Enums.PersonalityStates.ATLAS]
