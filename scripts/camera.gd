extends Camera2D

const SHAKE_AMOUNT: float = 2.0

var shaking: bool = false


func _process(_delta: float) -> void:
	if shaking:
		offset = Vector2(
			randf_range(-SHAKE_AMOUNT, SHAKE_AMOUNT),
			randf_range(-SHAKE_AMOUNT, SHAKE_AMOUNT)
		)


func start_shake(time: float = 0.2) -> void:
	shaking = true
	$ShakeTimer.start(time)


func _on_shake_timer_timeout() -> void:
	shaking = false
