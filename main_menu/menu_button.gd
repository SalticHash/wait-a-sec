extends Sprite2D
class_name WASMenuButton

const AUDIO_SCENE: PackedScene = preload("res://objects/instant_sound.tscn")
const SND_CLOCK_1 = preload("res://audio/snd_clock_1.ogg")
const SND_CLOCK_2 = preload("res://audio/snd_clock_2.ogg")
const SND_JIGGLE = preload("res://audio/snd_failed_move.ogg")


@export_group("Actions", "act_")
@export var act_interact: String = "res://levels/lvl_tutorial.tscn"
@export var act_left: WASMenuButton = null
@export var act_right: WASMenuButton = null
@export var act_up: WASMenuButton = null
@export var act_down: WASMenuButton = null

@export var on_spr: Rect2 = Rect2(0.0, 0.0, 27.0, 9.0)
@export var off_spr: Rect2 = Rect2(0.0, 9.0, 27.0, 9.0)
@export var trail_anim = "menu_start"
@export var button_id: int = -4
@export var select_target_id: int = -4


var selected: bool = false
var active_cooldown: int = 0


func _ready() -> void:
	if ScrGlobal.select_button_id == button_id:
		self.texture.region = on_spr
		selected = true
		ScrGlobal.select_button_id = -4
		if ScrGlobal.played_intro:
			_play_sound(SND_CLOCK_2)
		return
	self.texture.region = off_spr


func _physics_process(_delta: float) -> void:
	if not selected or not ScrGlobal.played_intro:
		return
	if active_cooldown > 0:
		active_cooldown -= 1
		return
	_act_left()
	_act_right()
	_act_up()
	_act_down()
	_act_interact()

# v # Button Action Functions # v #

func _act_left() -> void:
	if Input.is_action_just_pressed("key_left"):
		if act_left == null:
			_jiggle()
			return
		act_left._activate()
		self._deactivate()


func _act_right() -> void:
	if Input.is_action_just_pressed("key_right"):
		if act_right == null:
			_jiggle()
			return
		act_right._activate()
		self._deactivate()


func _act_up() -> void:
	if Input.is_action_just_pressed("key_up"):
		if act_up == null:
			_jiggle()
			return
		act_up._activate()
		self._deactivate()


func _act_down() -> void:
	if Input.is_action_just_pressed("key_down"):
		if act_down == null:
			_jiggle()
			return
		act_down._activate()
		self._deactivate()


func _act_interact() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		ScrGlobal.select_button_id = select_target_id
		get_tree().change_scene_to_file(act_interact)


# ^ # Button Action Functions # ^ #

# v # Other Button Functions # v #

func _activate() -> void:
	selected = true
	active_cooldown = 1
	self.texture.region = on_spr
	_play_sound(SND_CLOCK_1)


func _deactivate() -> void:
	selected = false
	self.texture.region = off_spr
	_create_trail()


func _jiggle() -> void:
	_play_sound(SND_JIGGLE)
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.advance(0)
	$AnimationPlayer.play("shake")
	$AnimationPlayer.advance(0)
	active_cooldown = 10

# ^ # Other Button Functions # ^ #

# v # Utility Functions # v #

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
