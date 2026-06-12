extends CharacterBody2D

@export var health_container: Node
@export var color_mod: CanvasModulate

const SPEED: float = 14000.0
const DMG_COOLDOWN: float = 0.5
const SLIGHT_RED := Color(1.0, 0.7, 0.7)

var squish: float = 1.0
var health: int = 3
var dead: bool = false

@onready var sprite: Sprite2D = $Sprite
@onready var camera: Camera2D = $Camera
@onready var main: Node2D = get_parent()
@onready var trail_scene: PackedScene = preload("res://scenes/player_trail.tscn")


func _ready() -> void:
	$TrailTimer.start()


func _physics_process(delta: float) -> void:
	if health <= 0:
		return
	
	var input := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down",
	).normalized()
	
	if input != Vector2.ZERO:
		_update_sprite(input)
		squish = lerpf(squish, 0.2, 0.8)
	else:
		squish = lerpf(squish, 0.0, 0.8)
	
	#sprite.scale.x = 1.0 - squish
	#sprite.scale.y = 1.0 + squish
	
	velocity = input * SPEED * delta
	
	move_and_slide()


func take_damage() -> void:
	if $DamageCooldown.time_left > 0.0 or dead:
		return
	
	health -= 1
	
	if health <= 0:
		dead = true
		
		$DeathEffect.set_emitting(true)
		$Sprite.hide()
		
		main.end_game()
	
	for child in health_container.get_children():
		child.hide()
	
	for i in health:
		health_container.get_child(i).show()
	
	if health == 1:
		health_container.set_modulate(Color.RED)
		color_mod.target_col = SLIGHT_RED
	
	color_mod.color = Color.RED
	camera.start_shake()
	
	$DamageCooldown.start(DMG_COOLDOWN)


func _update_sprite(dest: Vector2) -> void:
	var rotation_value: float = global_position.angle_to_point(global_position + dest)
	rotation = lerp_angle(rotation, rotation_value, 0.8) + PI/2.0


func _on_trail_timer_timeout() -> void:
	if dead: return
	
	$TrailTimer.start()
	
	if velocity.length() == 0.0:
		return
	
	var trail_node = trail_scene.instantiate()
	get_parent().add_child(trail_node)
	trail_node.global_position = global_position
	trail_node.rotation = randf_range(-100, 100)
	
