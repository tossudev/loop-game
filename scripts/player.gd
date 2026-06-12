extends CharacterBody2D

@export var health_container: Node
@export var color_mod: CanvasModulate

const SPEED: float = 14000.0
const DMG_COOLDOWN: float = 0.5

var squish: float = 1.0
var health: int = 3
var dead: bool = false

@onready var sprite: Sprite2D = $Sprite
@onready var camera: Camera2D = $Camera
@onready var main: Node2D = get_parent()


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
	
	color_mod.color = Color.RED
	camera.start_shake()
	
	$DamageCooldown.start(DMG_COOLDOWN)


func _update_sprite(dest: Vector2) -> void:
	var rotation_value: float = global_position.angle_to_point(global_position + dest)
	rotation = lerp_angle(rotation, rotation_value, 0.8) + PI/2.0
