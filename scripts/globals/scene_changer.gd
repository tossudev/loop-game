extends CanvasLayer

const TRANSITION_TIME: float = 0.25

var transition_playing: bool = false
var quitting: bool = false


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
