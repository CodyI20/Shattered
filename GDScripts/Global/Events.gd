extends Node

# PLAYER EVENTS

signal player_jumped()
signal player_waking(is_walking: bool)
signal toggle_inventory()

# GAME EVENTS

signal start_game()
signal go_to_final_screen()

# ALTER EVENTS

signal personality_swap(personality: Enums)

# STATE EVENTS

signal on_state_swap(timer: Timer)

# INTERACTION EVENTS

signal on_interact(interactable: Interactable)
signal on_interact_with_keypad_button()

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
signal gate_not_solved()
signal gate_not_solved_sound()

signal logic_gate_puzzle_on()
signal logic_gate_puzzle_off()

signal toggle_electricity(toggled_on: bool)

# UI PUZZLES
signal exited_puzzle_area()

# INVENTORY
signal OnItemPickedUp(item: ItemData)
signal item_inspected(item: ItemData)

# OPTIONS
signal options_menu_toggle(is_on: bool)
signal sfx_slider_value_set()

# TUTORIAL
signal play_tutorial_step(step: TutorialStep)
signal complete_tutorial_step(step: TutorialStep)

# PAUSE
signal no_pause_signal()
signal no_resume_signal()
