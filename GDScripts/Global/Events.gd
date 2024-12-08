extends Node


#region PLAYER EVENTS

signal player_jumped()
signal player_waking(is_walking: bool)
signal toggle_inventory()
signal player_left_important_area()

#endregion
#region GAME EVENTS

signal start_game()
signal go_to_final_screen()

#endregion
#region ALTER EVENTS
signal personality_swap(personality: Enums)

#endregion
#region STATE EVENTS
signal on_state_swap(timer: Timer)

#endregion
#region INTERACTION EVENTS

signal on_interact(interactable: Interactable)
signal on_interact_with_keypad_button()
signal on_interact_with_keypad_button_no_electricity()

#endregion

#region PUZZLES
signal puzzle_started(puzzle_name : Enums)
signal puzzle_toggled_on(puzzle_name : Enums)
signal puzzle_toggled_off(puzzle_name : Enums)
#endregion
#region PASSWORD PUZZLE
signal on_correct_password()
signal on_wrong_password()
#endregion
#region LOGIC GATE PUZZLE
signal object_started_dragging(object: DragItem)
signal object_stopped_dragging(object: DragItem)
signal valid_drop_target_entered
signal valid_drop_target_exited

signal correct_gate_entered(zone: DropZone)
signal wrong_gate_entered(zone: DropZone)
signal final_gate_solved()
signal gate_solved()
signal gate_not_solved()
signal gate_not_solved_sound()
signal logic_gates_puzzle_layout_change()

signal toggle_electricity(toggled_on: bool)
#endregion
#region MUSIC BOX PUZZLE
signal music_box_audio_finished()
signal music_box_button_pressed(sound : AudioStream)
signal music_box_puzzle_reset()
signal music_box_puzzle_reset_sound_finished()
signal music_box_puzzle_complete()
signal music_box_replay_sound()
#endregion
#region UI PUZZLES
signal exited_puzzle_area()
#endregion


#region INVENTORY
signal OnItemPickedUp(item: ItemData)
signal item_inspected(item: ItemData)
#endregion
#region OPTIONS
signal options_menu_toggle(is_on: bool)
signal sfx_slider_value_set()
#endregion
#region TUTORIAL
signal play_tutorial_step(step: TutorialStep)
signal complete_tutorial_step(step: TutorialStep)
#endregion
#region PAUSE
signal no_pause_signal()
signal no_resume_signal()
#endregion
