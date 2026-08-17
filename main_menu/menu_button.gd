extends Node2D

const AUDIO_SCENE: PackedScene = preload("res://objects/instant_sound.tscn")
const SND_CLOCK_1 = preload("res://audio/snd_clock_1.ogg")
const SND_CLOCK_2 = preload("res://audio/snd_clock_2.ogg")

@export var left: bool = false
var on_spr: Rect2 = Rect2(0.0, 0.0, 27.0, 9.0)
var off_spr: Rect2 = Rect2(0.0, 9.0, 27.0, 9.0)
var trail_anim = "menu_start"

func _ready() -> void:
	if left:
		on_spr = Rect2(0.0, 36.0, 36.0, 9.0)
		off_spr = Rect2(0.0, 45.0, 36.0, 9.0)
		$sprite.texture.region = off_spr
		trail_anim = "menu_opt"


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("key_left"):
		if left and $sprite.texture.region == off_spr:
			_play_sound(SND_CLOCK_1)
		if not left and $sprite.texture.region == on_spr:
			_create_trail()
		$sprite.texture.region = on_spr if left else off_spr
	if Input.is_action_just_pressed("key_right"):
		if not left and $sprite.texture.region == off_spr:
			_play_sound(SND_CLOCK_2)
		if left and $sprite.texture.region == on_spr:
			_create_trail()
		$sprite.texture.region = off_spr if left else on_spr


func _play_sound(custom_sound) -> void:
	var instant_snd: AudioStreamPlayer = AUDIO_SCENE.instantiate()
	self.add_child(instant_snd)
	instant_snd.stream = custom_sound
	instant_snd.play()


func _create_trail() -> void:
	var instance = ScrGlobal.TRAIL_SCENE.instantiate()
	get_parent().add_child(instance)
	instance.position = position
	instance.play(trail_anim)
