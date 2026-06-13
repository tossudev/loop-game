extends Node2D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		SceneChanger.change_scene("res://scenes/game.tscn")
