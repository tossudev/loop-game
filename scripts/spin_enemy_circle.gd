extends Area2D

var time: float = 0.0


func _process(delta: float) -> void:
	time += delta
	
	var offset: float = time
	
	for child: Node2D in get_children():
		offset += 0.5
		
		child.scale.x = 1.2 + (cos(offset)/4.0)
		child.scale.y = 1.2 + (cos(offset)/4.0)
		
		child.rotation = offset / 2.0
