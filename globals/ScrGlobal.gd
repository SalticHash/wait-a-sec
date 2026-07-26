extends Node

const TRAIL_SCENE: PackedScene = preload("res://objects/trail_effect.tscn")

@warning_ignore_start("unused_signal")
signal undo
signal time_changed(last_time, new_time)



var keys_left: int = 0
var reset_level: bool = false
var level_time: int = 99 :
	set(value):
		if level_time == value: return
		time_changed.emit(level_time, value)
		level_time = value

var heard_meme: bool = false
var original_level_time: int = 99
var won: bool = false
var current_level = preload("res://levels/lvl_tutorial.tscn")
var cutscene: bool = false
var score: int = 0

func _reload_level() -> void:
	get_tree().change_scene_to_packed(current_level)

func _load_level(level) -> void:
	current_level = level
	won = false
	_reload_level()
