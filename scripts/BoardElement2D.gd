extends Node2D
class_name BoardElement2D

@export var life_time: int = 5
@export var exceptions: Array[int] = []

func _ready() -> void:
	if ScrGlobal.level_time <= life_time:
		_disappear()

func _physics_process(_delta: float) -> void:
	if ScrGlobal.level_time == life_time:
		_disappear()
	if len(exceptions) > 0:
		for exception in exceptions:
			if exception == ScrGlobal.level_time:
				_appear()

func _disappear() -> void:
	if not visible:
		return
	$area.monitoring = false
	$area.monitorable = false
	visible = false

func _appear() -> void:
	if visible:
		return
	$area.monitoring = true
	$area.monitorable = true
	visible = true
