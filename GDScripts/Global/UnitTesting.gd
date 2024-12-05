extends Node


func _ready() -> void:
	print_debug("Unit testing starting...")
	print('\n')
	utility_jumble_array_test()
	
func utility_jumble_array_test() -> void:
	var test_array := ['1', '2', '3', '4']
	print_rich("[b] Utility Jumble Array testing with array: [/b]", test_array)
	
	var new_array := Utility.jumble_array(test_array)
	print_rich("[b] The new array is: [/b]", new_array)
