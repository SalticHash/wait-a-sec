extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$units.frame = ScrGlobal.score % 10
	$tens.frame = int(ScrGlobal.score / 10.0)
