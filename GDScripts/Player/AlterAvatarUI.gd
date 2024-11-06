extends TextureRect

const CHARACTER_SELECTION_INDICATOR_ATLAS = preload("res://Art/2D/UI/Alter-Related/character-selection-indicator-atlas.svg")
const CHARACTER_SELECTION_INDICATOR_MITCH = preload("res://Art/2D/UI/Alter-Related/character-selection-indicator-mitch.svg")
const CHARACTER_SELECTION_INDICATOR_NICK = preload("res://Art/2D/UI/Alter-Related/character-selection-indicator-nick.svg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.personality_swap.connect(set_alter_icon)

func set_alter_icon(personality : int) -> void:
	match personality:
		enums.PersonalityStates.NICK:
			texture = CHARACTER_SELECTION_INDICATOR_NICK
		enums.PersonalityStates.ATLAS:
			texture = CHARACTER_SELECTION_INDICATOR_ATLAS
