extends Node2D

var time_survived: float = 0.0
var game_over: bool = false


func _process(delta: float) -> void:
	if game_over:
		if Input.is_action_just_pressed("reset"):
			get_tree().reload_current_scene()
		
		return
	
	time_survived += delta


func end_game() -> void:
	game_over = true
	
	$UI/ResetInfo.show()
	
	if Scores.new_score(time_survived):
		$UI/BestLabel/AnimationPlayer.play("new_best")
	
