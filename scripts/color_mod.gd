extends CanvasModulate

var target_col := Color.WHITE


func _process(_delta: float) -> void:
	color = lerp(color, target_col, 0.03)
