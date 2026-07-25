extends Node2D

const AUDIO_SCENE: PackedScene = preload("res://objects/instant_sound.tscn")
const SND_CLOCK_1 = preload("res://audio/snd_clock_1.ogg")
const SND_CLOCK_2 = preload("res://audio/snd_clock_2.ogg")

@export var level_time: int = 15

var last_time: int


func _ready() -> void:
	ScrGlobal.level_time = level_time
	last_time = ScrGlobal.level_time
	_update_number()


func _physics_process(_delta: float) -> void:
	_update_number()
	if last_time != ScrGlobal.level_time:
		_play_clock_snd()
	last_time = ScrGlobal.level_time


func _update_number() -> void:
	var str_time = str(ScrGlobal.level_time)
	var units_digit = int(str_time[1]) if ScrGlobal.level_time > 9 else int(str_time[0])
	var tens_digit = int(str_time[0]) if ScrGlobal.level_time > 9 else 0
	$units.frame = units_digit
	$tens.frame = tens_digit


func _play_clock_snd() -> void:
	if ScrGlobal.level_time % 2 == 1:
		_play_sound(SND_CLOCK_2)
	else:
		_play_sound(SND_CLOCK_1)


func _play_sound(custom_sound) -> void:
	var instant_snd: AudioStreamPlayer = AUDIO_SCENE.instantiate()
	self.add_child(instant_snd)
	instant_snd.stream = custom_sound
	instant_snd.play()
