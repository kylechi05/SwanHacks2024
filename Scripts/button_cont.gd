extends TextureRect

@export var func_name : String

func _input(event):
	if Input.is_action_just_pressed("left_click") and Controller.item_overlap(self.get_global_position(), self.get_size(), get_global_mouse_position()):
		Controller.call(func_name)
