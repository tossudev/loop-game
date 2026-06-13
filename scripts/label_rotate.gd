extends Label

var time: float = 0.0


func _process(delta: float) -> void:
	time += delta
	
	rotation_degrees = cos(time * 3.0) * 2.0
