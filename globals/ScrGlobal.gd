extends Node

const TRAIL_SCENE: PackedScene = preload("res://objects/trail_effect.tscn")

var level_time: int = 99
var won: bool = false
var current_level = preload("res://levels/lvl_tutorial.tscn")

func _reload_level() -> void:
	var instance = current_level.instantiate()
	get_tree().get_current_scene().add_child(instance)

func _load_level(level) -> void:
	current_level = level
	won = false
	_reload_level()
