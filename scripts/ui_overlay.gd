extends CanvasLayer

@export var color_mod: CanvasModulate

var time: float = 0.0

@onready var main: Node2D = get_parent()
@onready var time_label: Label = $TimeLabel
@onready var best_label: Label = $BestLabel


func _ready() -> void:
	color_mod.color = Color.BLACK


func _process(delta: float) -> void:
	time += delta
	
	time_label.set_text(
		get_formatted_time(main.time_survived)
	)
	
	best_label.set_text(
		"Best time:\n" + get_formatted_time(Scores.best_score)
	)
	
	_do_ui_shake()


func _do_ui_shake() -> void:
	for _i: int in $HealthContainer.get_child_count():
		var _child: Node = $HealthContainer.get_child(_i)
		_child.scale.x = (cos(time + _i)) / 6.0 + 1.0
		_child.scale.y = (sin(time + _i)) / 6.0 + 1.0
		
		_child.rotation_degrees = cos(time)
	
	$ResetInfo.rotation_degrees = cos(time * 3.0) * 2.0


func get_formatted_time(t: float) -> String:
	var minutes = t / 60
	var seconds = fmod(t, 60)
	
	var time_formatted: String = "%02d:%02d" % [minutes, seconds]
	return time_formatted
