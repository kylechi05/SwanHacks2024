extends RichTextLabel
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = "Budget:\n $"+str(Controller.total_money-500)+"\n+$500\n-----------\n $"+str(Controller.total_money)+"\n-----------\n"
