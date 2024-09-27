extends Node

@export var initial_state : State

var current_state : State
var states: Dictionary = {}

signal new_state_signal

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()]=child
			child.state_transition.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
		new_state_signal.emit(current_state.name)

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(source_state: State, new_state_name: String) -> void:
	if source_state != current_state:
		print_debug("Can't change state as you are now in: " + source_state.name)
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print_debug("State with name " + new_state_name + " not found!")
		return
		
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	
	current_state = new_state
	new_state_signal.emit(new_state.name)
