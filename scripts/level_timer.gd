extends Node2D

@export var level_time: int = 15

func _ready() -> void:
	ScrGlobal.level_time = level_time

func _physics_process(_delta: float) -> void:
	var str_time = str(ScrGlobal.level_time)
	var units_digit = int(str_time[1]) if ScrGlobal.level_time > 9 else int(str_time[0])
	var tens_digit = int(str_time[0]) if ScrGlobal.level_time > 9 else 0
	$units.frame = units_digit
	$tens.frame = tens_digit
