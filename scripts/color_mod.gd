extends CanvasModulate


func _process(_delta: float) -> void:
	color = lerp(color, Color.WHITE, 0.05)
