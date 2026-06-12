extends Node2D

const SPAWN_DISTANCE: float = 450.0

const SPAWN_INTERVAL: float = 2.0


@onready var enemy_scene: PackedScene = preload("res://scenes/spin_enemy.tscn")


func _ready() -> void:
	$Timer.start(SPAWN_INTERVAL)


func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	
	var pos := Vector2(SPAWN_DISTANCE, 0.0)
	pos = pos.rotated(randf_range(-100, 100))
	var dir = -pos
	
	enemy.init(pos, dir)
	
	add_child(enemy)


func _on_timer_timeout() -> void:
	spawn_enemy()
	$Timer.start(SPAWN_INTERVAL)
