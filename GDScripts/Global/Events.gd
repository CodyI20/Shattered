extends Node

# PLAYER EVENTS

signal player_jumped()
signal player_waking(is_walking: bool)

# ALTER EVENTS

signal alter1_swap()
signal main_personality_swap()

# LOGIC GATE MINIGAME EVENTS
signal object_started_dragging(object: DragItem)
signal object_stopped_dragging(object: DragItem)
signal valid_drop_target_entered
signal valid_drop_target_exited

signal correct_gate_entered(zone: DropZone)
signal wrong_gate_entered(zone: DropZone)
signal gate_solved()

signal puzzle_toggle()
