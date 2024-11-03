# This script checks if the RayCast is interacting with an interactable object and provides interactibility
extends RayCast3D

var current_collider: Object
# Grabs the interaction label node
@onready var interaction_label = get_tree().get_first_node_in_group("InteractionLabel")


func _ready() -> void:
	set_interaction_text("")


func _process(_delta):
	var collider = get_collider()
# Checks if the raycast is colliding with an interactable object
	if is_colliding() and collider is Interactable:
# Checks if it's a different interactable object than the one it already has
		if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider
# When the interact button is pressed, will interact with object
		if Input.is_action_just_pressed("Interact"):
			current_collider.interact()
			set_interaction_text(collider.get_interaction_text())
# If there is no object to interact with, sets the collider to nothing
	elif is_instance_valid(current_collider):
		current_collider = null
		set_interaction_text("")

func set_interaction_text(text):
	if interaction_label == null:
		return
# Shows the interaction text when raycast is colliding with an interactable object
	if !text:
		interaction_label.visible = false
	else:
		# Grabs the interact key from the interact keymap
		var key_name = OS.get_keycode_string(InputMap.action_get_events("Interact")[0].physical_keycode)
		interaction_label.text = "Press %s to interact" % [key_name]
		interaction_label.visible = true
