extends CanvasLayer

@export var color_mod: CanvasModulate
@export var player: Node2D

const DEFAULT_SHAKE_AMOUNT: float = 0.25
const HEALTH_UI_OFFSET: float = 16.0

var time: float = 0.0

@onready var main: Node2D = get_parent()
@onready var time_label: RichTextLabel = $TimeLabel
@onready var best_label: RichTextLabel = $BestLabel


func _ready() -> void:
	color_mod.color = Color.BLACK


func _process(delta: float) -> void:
	time += delta
	
	time_label.set_text(
		get_formatted_time(main.time_survived, 10.0)
	)
	
	if main.time_survived > Scores.best_score:
		time_label.set_modulate(Color("00fe64"))
	
	best_label.set_text(
		"Best time:\n" + get_formatted_time(Scores.best_score, 6.0)
	)
	
	_do_ui_shake()


func _do_ui_shake() -> void:
	for _i: int in $HealthContainer.get_child_count():
		var _child: Node = $HealthContainer.get_child(_i)
		_child.offset.y = (cos(time * 4.0 + _i))
		
		_child.rotation_degrees = cos(time)
	
	if player.health <= 1:
		$HealthContainer.position = Vector2(
		HEALTH_UI_OFFSET + randf_range(-DEFAULT_SHAKE_AMOUNT, DEFAULT_SHAKE_AMOUNT),
		HEALTH_UI_OFFSET + randf_range(-DEFAULT_SHAKE_AMOUNT, DEFAULT_SHAKE_AMOUNT)
	)


func fade_invert(out: bool = false) -> void:
	var new_scale := Vector2(4.0, 4.0)
	
	if out:
		new_scale = Vector2.ZERO
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		$InvertEffect,
		"scale",
		new_scale,
		0.8
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


# so like idk if this is overly complicated of if everything should just be float but it works and makes sense to me so im saying this is probably a good enough solution for formatting time but anyway yeah
func get_formatted_time(t: float, font_size: float) -> String:
	var milli: float = fmod(t, 1.0) * 1000.0
	var seconds: int = int(t) % 60
	var minutes: int = int(t) % 3600 / 60
	
	return "%02d:%02d[font_size=%d].%03d" % [minutes, seconds, font_size, milli]
