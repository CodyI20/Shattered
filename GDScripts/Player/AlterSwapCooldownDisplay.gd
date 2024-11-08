extends VSlider

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.on_state_swap.connect(grab_timer)
	
func _process(delta: float) -> void:
	update_slider()

func grab_timer(input_timer: Timer) -> void:
	visible = true
	timer = input_timer
	
func update_slider() -> void:
	if timer == null:
		return
	value = timer.time_left * max_value/2
	visible = value != 0
