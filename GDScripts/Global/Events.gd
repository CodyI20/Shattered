extends Node

# PLAYER EVENTS

signal player_jumped
signal player_waking(is_walking: bool)

# ALTER EVENTS

signal alter1_swap(entered: bool)
signal main_personality_swap(entered: bool)
