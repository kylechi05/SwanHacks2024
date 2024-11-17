extends GPUParticles2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Controller.isDay():
		emitting = true
	else:
		emitting = false
