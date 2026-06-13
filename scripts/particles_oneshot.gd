extends CPUParticles2D


func _ready() -> void:
	set_emitting(true)
	await finished
	queue_free()
