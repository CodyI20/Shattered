extends Node3D

# I will comment everything out we don't need, but might need when we want sounds in this thing.

@export var correct_password = "1234"

signal on_clear_password
signal on_keypad_press

#var is_audio_playing = false
var password = ""

# Not needed right now, maybe when we get keypad sounds working
#@onready var pressed_audio = $PressedAudioStream
#@onready var correct_audio = $CorrectAudioStream
#@onready var wrong_audio = $WrongAudioStream

@onready var keys = $Keys
@onready var password_label = $PasswordViewport/PasswordLabel

# Grabs all the keys of the keypad
func _ready():
	for child in keys.get_children():
		if child is StaticBody3D:
			child.connect("on_interact", Callable(self, "on_button_interact"))
	
	password_label.text = ""

func on_button_interact(value):
	#if is_audio_playing:
		#return
	
	#is_audio_playing = true
	#pressed_audio.playing = true
	print("interacted with " + value)
	
# Logic for when enter key is pressed
	if value == ".":
# Logic to check if the password is correct
		if password == correct_password:
			#correct_audio.play()
			Events.on_correct_password.emit()
			print("You have entered the correct password!")
		else:
			#wrong_audio.play()
			Events.on_wrong_password.emit()
			print("You have entered the wrong password!")
		password = ""

# Logic for when the clear key is pressed
	elif value == "C":
		# Clears the current number
		emit_signal("on_clear_password", password)
		password = ""

# Logic for the digits
	else:
		# got a number value
		if password.length() == correct_password.length():
			return
		password += value
		emit_signal("on_keypad_press", password)
	
	password_label.text = password

#func _on_AudioStreamPlayer3D_finished():
	#is_audio_playing = false
