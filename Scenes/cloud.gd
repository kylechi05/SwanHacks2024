extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.global_position.x -= delta*2
	if self.global_position.x < -100:
		self.global_position.x = 1100
	if Controller.isDay():
		set_modulate(Color(1,1,1, 0.5))
	else:
		set_modulate(Color(0.3, 0.3, 0.3, 0.5))
