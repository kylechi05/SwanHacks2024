extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.global_position.y <= 720 and Controller.TIME_OF_DAY > 24:
		self.global_position = Vector2i(0, self.global_position.y + 10)
		if self.global_position.y > 720:
			self.global_position.y = 720
	elif Controller.TIME_OF_DAY < 24:
		self.global_position.y = 0
		
