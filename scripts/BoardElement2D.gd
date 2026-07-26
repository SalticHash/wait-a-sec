extends Node2D
class_name BoardElement2D

@export var life_time: int = 5
@export_enum(
	"player",
	"goal",
	"wall",
	"wall_orange",
	"wallgreens",
	"wall_cyan"
) var trail_anim: String

func _ready() -> void:
	if ScrGlobal.level_time <= life_time:
		_disappear()


func _physics_process(_delta: float) -> void:
	if ScrGlobal.level_time == life_time:
		_disappear()
	if ScrGlobal.level_time > life_time:
		_appear()


func _disappear() -> void:
	if not visible:
		return
	$area.set_deferred("monitoring", false)
	$area.set_deferred("monitorable", false)
	visible = false
	_create_trail()


func _create_trail() -> void:
	var instance = ScrGlobal.TRAIL_SCENE.instantiate()
	get_parent().add_child(instance)
	instance.position = position
	instance.play(trail_anim)


func _appear() -> void:
	if visible:
		return
	$area.set_deferred("monitoring", true)
	$area.set_deferred("monitorable", true)
	visible = true
