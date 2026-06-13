extends Node2D


func _ready() -> void:
	SceneChanger.in_game = false
	Audio.toggle_music_muffle(false)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		SceneChanger.change_scene("res://scenes/game.tscn")
		SceneChanger.in_game = true
