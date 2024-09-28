extends Area3D
# Reusable Event manager for playing sound
# Use CanPlayMultipleTimes to set if the event can be played multiple times
# Use VolumeToPlayAtInDB to set the volume for the audio

@export var AudioToPlay : AudioStream
var audioPlayer : AudioStreamPlayer
@export var CanPlayMultipleTimes : bool
@export var VolumeToPlayAtInDB : float
var E_GenericEventPlayed : bool


func _ready():
	audioPlayer = $AudioStreamPlayer
	audioPlayer.stream = AudioToPlay
	audioPlayer.volume_db = VolumeToPlayAtInDB

func _on_body_entered(body):
	if CanPlayMultipleTimes:
		audioPlayer.play()
	else:
		if !E_GenericEventPlayed:
			audioPlayer.play()
			E_GenericEventPlayed = true
