extends Node

# PLAYER EVENTS

signal player_jumped()
signal player_waking(is_walking: bool)
signal toggle_inventory()

# ALTER EVENTS

signal personality_swap(personality: String)

# INTERACTION EVENTS

signal on_interact(interactable: Interactable)

# PASSWORD PUZZLE
signal on_correct_password()
signal on_wrong_password()

# LOGIC GATE MINIGAME EVENTS
signal object_started_dragging(object: DragItem)
signal object_stopped_dragging(object: DragItem)
signal valid_drop_target_entered
signal valid_drop_target_exited

signal correct_gate_entered(zone: DropZone)
signal wrong_gate_entered(zone: DropZone)
signal gate_solved()

# INVENTORY
signal OnItemPickedUp(item: Interactable)
