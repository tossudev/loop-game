extends Node

@export var music_lowpass: AudioEffectLowPassFilter
@export var music_reverb: AudioEffectReverb

const BUS_MUSIC: int = 1

var music_muffled: bool = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mute"):
		AudioServer.set_bus_mute(0, !AudioServer.is_bus_mute(0))


func toggle_music_muffle(on: bool) -> void:
	if on and !music_muffled:
		music_muffled = true
		AudioServer.add_bus_effect(BUS_MUSIC, music_lowpass)
		AudioServer.add_bus_effect(BUS_MUSIC, music_reverb)
	
	elif music_muffled:
		music_muffled = false
		AudioServer.remove_bus_effect(BUS_MUSIC, 1)
		AudioServer.remove_bus_effect(BUS_MUSIC, 0)
