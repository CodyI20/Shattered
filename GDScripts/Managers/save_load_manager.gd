class_name SaverLoader
extends Node

@onready var _player: Player = %player

@onready var _world_root:WorldRoot = %WorldRoot


func save_game():
	var saved_game := SavedGame.new()
	
	# save the path to the currently loaded level
	saved_game.level_path = _world_root.get_current_level_path()
	
	# store player position
	saved_game.player_position = _player.global_position
	
	# write the savegame to disk
	ResourceSaver.save(saved_game, "user://savegame.tres")

	
	
func load_game():
	
	# fix any paths that may be broken after a game update
	var fixed_path = PathFixer.fix_paths("user://savegame.tres")
	print("Loading from ", fixed_path )
	
	# load the savegame securely
	var saved_game:SavedGame = SafeResourceLoader.load(fixed_path) as SavedGame
	if saved_game == null:
		return
	
	# first restore the level
	# this may take a few frames, so we wait with await
	await _world_root.load_level_async(saved_game.level_path)
	
	# clear the stage
	get_tree().call_group("game_events", "on_before_load_game")
	
	# restore player position
	_player.global_position = saved_game.player_position