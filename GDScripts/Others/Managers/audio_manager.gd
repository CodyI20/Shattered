extends Node

# MUSIC / AMBIANCE
@onready var background_music: AudioStreamPlayer = $backgroundMusic

# SFX - OPTIONS MENU FEEDBACK
@onready var sfx_set_feedback: AudioStreamPlayer = $"SFX/OptionsMenu/SFX-set-feedback"

# SFX - PLAYER MOVEMENT
@onready var walk_sfx: AudioStreamPlayer = $SFX/PlayerMovementSFX/walkSFX
@onready var jump_sfx: AudioStreamPlayer = $SFX/PlayerMovementSFX/jumpSFX

# SFX - KEYPAD PUZZLE
@onready var correct_code_sound: AudioStreamPlayer = $SFX/KeypadPuzzle/CorrectCodeSound
@onready var key_sound: AudioStreamPlayer = $SFX/KeypadPuzzle/KeySound
@onready var wrong_code_sound: AudioStreamPlayer = $SFX/KeypadPuzzle/WrongCodeSound

# SFX - LOGIC GAME PUZZLE
@onready var electricity_on: AudioStreamPlayer = $SFX/LogicGatePuzzle/ElectricityOn

# SFX - PAPER
@onready var page_pick_up: AudioStreamPlayer = $SFX/Paper/PagePickUp

func _ready() -> void:
	_event_subscription()
	if background_music.stream == null:
		printerr("THERE IS NO STREAM IN YOUR MUSIC! FIX IT! ~Also check the bus it's in while you're at it~")
		return
	background_music.play()

func _event_subscription() -> void:
	# SFX - OPTIONS MENU FEEDBACK
	Events.sfx_slider_value_set.connect(play_sfx_slider_value_changed_sound)
	
	# SFX - PLAYER MOVEMENT
	Events.player_jumped.connect(play_jump_sound)
	Events.player_waking.connect(play_walk_sound)
	
	# SFX - KEYPAD PUZZLE
	Events.on_correct_password.connect(play_correct_code_sound)
	Events.on_wrong_password.connect(play_wrong_code_sound)
	Events.on_interact_with_keypad_button.connect(play_key_sound)
	
	# SFX - LOGIC GAME PUZZLE
	Events.gate_solved.connect(play_electricity_on_sound)
	
	# SFX - PAPER
	Events.on_interact.connect(play_interactable_sound)
	
func play_walk_sound(should_play: bool) -> void:
	if should_play:
		walk_sfx.play()
	else:
		walk_sfx.stop()

func play_jump_sound() -> void:
	jump_sfx.play()
	
func play_key_sound() -> void:
	key_sound.play()
	
func play_correct_code_sound() -> void:
	correct_code_sound.play()

func play_wrong_code_sound() -> void:
	wrong_code_sound.play()

func play_electricity_on_sound() -> void:
	electricity_on.play()
	
func play_interactable_sound(interactable: Interactable) -> void:
	if interactable is PaperClass:
		page_pick_up.play()
		
func play_sfx_slider_value_changed_sound() -> void:
	sfx_set_feedback.play()
