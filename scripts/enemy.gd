extends CharacterBody2D

const SPIN_SPEED: float = 1.0
const SPEED: float = 6.5
const ROT_VARIATION: float = 0.45
const SPEED_VARIATION: float = 0.6

var direction: Vector2
var speed_var: float = 1.0

var pastel_colors: Array[Color] = [
	Color(1.0, 0.70, 0.85),      # Pastel pink
	Color(0.63, 0.84, 0.97),     # Pastel blue
	Color(0.70, 0.90, 0.70),     # Pastel green
	Color(1.0, 0.93, 0.70),      # Pastel yellow
	Color(0.85, 0.70, 1.0),      # Pastel purple
	Color(1.0, 0.85, 0.70),      # Pastel peach
	Color(0.70, 0.94, 0.90),     # Pastel mint
]

@onready var main: Node2D = get_parent().get_parent()


func _ready() -> void:
	set_modulate(pastel_colors.pick_random())


func _physics_process(delta: float) -> void:
	if main.game_over:
		return
	
	rotation += SPIN_SPEED * delta
	
	velocity = direction * SPEED * delta * speed_var
	move_and_slide()


func init(pos: Vector2, dir: Vector2) -> void:
	global_position = pos
	
	direction = dir.rotated(randf_range(-ROT_VARIATION, ROT_VARIATION))
	
	speed_var = randf_range(1.0 - SPEED_VARIATION, 1.0 + SPEED_VARIATION)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.take_damage()


func _on_despawn_timer_timeout() -> void:
	if main.game_over:
		return
	
	queue_free()
