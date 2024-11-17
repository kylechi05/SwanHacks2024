extends Sprite2D

var time = 0
var next_step = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time == 0:
		next_step = Controller.find_next_step(self.global_position.x, self.global_position.y, 1)
		time += delta*30
	else:
		time += delta
		if(next_step != null):
			Controller.move_to_next_step(self, next_step, time)
			if time > 1:
				Controller.move_to_next_step(self, next_step, 1)
				time = 0
