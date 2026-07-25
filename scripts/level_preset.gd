extends Node2D

@export var next_level: PackedScene
@export var final_level: bool = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("key_undo"):
		ScrGlobal._reload_level()
		queue_free()
	if ScrGlobal.won:
		ScrGlobal._load_level(next_level)
		queue_free()
