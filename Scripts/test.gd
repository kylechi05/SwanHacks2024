extends Sprite2D

var time = 0
var start_time = 2
var next_step = null
var step_toggle = false

func _ready() -> void:
	start_time -= (randi() % 60 + 1)/30
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Controller.TIME_OF_NIGHT < Controller.TIME_OF_DAY:
		if step_toggle == false:
			time = 0
			start_time = 1
			start_time -= (randi() % 30 + 1)/30
			next_step = null
			Controller.reset_schedule = false
			step_toggle = true
		else:
			if time == 0:
				next_step = Controller.find_next_step(self.global_position.x, self.global_position.y, Controller.places[self.get_meta("object_reference").getHome()][0])
				time += delta*Controller.CITIZEN_SPEED
			else:
				time += delta
				if(next_step != null):
					Controller.move_to_next_step(self, next_step, time)
					if time > 1:
						Controller.move_to_next_step(self, next_step, 1)
						time = 0

	else:
		if start_time < 0:
			if time == 0:
				next_step = Controller.find_next_step(self.global_position.x, self.global_position.y, Controller.places[self.get_meta("object_reference").getWork()][0])
				time += delta*Controller.CITIZEN_SPEED
			else:
				time += delta
				if(next_step != null):
					Controller.move_to_next_step(self, next_step, time)
					if time > 1:
						Controller.move_to_next_step(self, next_step, 1)
						time = 0
		else:
			start_time -= delta
