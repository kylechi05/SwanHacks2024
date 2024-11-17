extends RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = "-----------------------\nINFECTED:\n" + str(len(Controller.infected)) + "\n\nDead:\n"+str(len(Controller.dead))+ "\n\nAlive:\n" + str(Controller.num_people - len(Controller.dead))+ "\n\nDays Left:\n"+str(Controller.TOTAL_DAYS - Controller.current_day)
