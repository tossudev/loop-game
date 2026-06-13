extends CanvasLayer

const TRANSITION_TIME: float = 0.25
const QUIT_TIME_WINDOW: float = 2.0

var transition_playing: bool = false
var quitting: bool = false
var quit_time: float = 0.0
var in_game: bool = false


# this should not be here but whatever
func _process(delta: float) -> void:
	quit_time -= delta
	
	$QuitInfo.set_self_modulate(Color(
		Color.WHITE,
		clampf(quit_time, 0.0, 1.0)
		)
	)
	
	if Input.is_action_just_pressed("ui_back"):
		if quit_time > 0.0:
			if in_game:
				change_scene("res://scenes/menu.tscn")
			else:
				quit()
		
		else:
			quit_time = QUIT_TIME_WINDOW
	
	if Input.is_action_just_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


# Change scene to filepath, do transition animation.
func change_scene(to: String) -> void:
	if transition_playing:
		return
	
	transition_playing = true
	_scene_transition(true)
	
	await get_tree().create_timer(TRANSITION_TIME).timeout
	
	get_tree().change_scene_to_file(to)
	
	_scene_transition(false)
	transition_playing = false
	quit_time = 0.0


func quit() -> void:
	if transition_playing:
		return
	
	transition_playing = true
	quitting = true
	_scene_transition(true)
	
	await get_tree().create_timer(TRANSITION_TIME).timeout
	
	get_tree().quit()


func _scene_transition(fade_in: bool) -> void:
	var final_col := Color.BLACK
	
	if !fade_in:
		final_col.a = 0.0
	
	var tween = create_tween()
	tween.tween_property(
		$SceneFade,
		"color",
		final_col,
		TRANSITION_TIME
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
