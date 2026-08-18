extends Node

const TRAIL_SCENE: PackedScene = preload("res://objects/trail_effect.tscn")

const LETTER_MAP: Dictionary = {
	"A": Vector2(0, 0), # Line ID = 0 v v v
	"B": Vector2(1, 0),
	"C": Vector2(2, 0),
	"D": Vector2(3, 0),
	"E": Vector2(4, 0),
	"F": Vector2(5, 0),
	"G": Vector2(6, 0),
	"H": Vector2(7, 0),
	"I": Vector2(8, 0),
	"J": Vector2(9, 0),
	"K": Vector2(10, 0),
	"L": Vector2(11, 0),
	"--------- --": Vector2(0, 0), # Line ID = 1 v v v
	"M": Vector2(0, 1),
	"N": Vector2(1, 1),
	"Ñ": Vector2(2, 1),
	"O": Vector2(3, 1),
	"P": Vector2(4, 1),
	"Q": Vector2(5, 1),
	"R": Vector2(6, 1),
	"S": Vector2(7, 1),
	"T": Vector2(8, 1),
	"U": Vector2(9, 1),
	"V": Vector2(10, 1),
	"W": Vector2(11, 1),
	"----- ------": Vector2(0, 0), # Line ID = 2 v v v
	"X": Vector2(0, 2),
	"Y": Vector2(1, 2),
	"Z": Vector2(2, 2),
	"-----------": Vector2(0, 0), # Line ID = 3 v v v
	"0": Vector2(0, 3),
	"1": Vector2(1, 3),
	"2": Vector2(2, 3),
	"3": Vector2(3, 3),
	"4": Vector2(4, 3),
	"5": Vector2(5, 3),
	"6": Vector2(6, 3),
	"7": Vector2(7, 3),
	"8": Vector2(8, 3),
	"9": Vector2(9, 3),
	"----------------": Vector2(0, 0), # Line ID = 4 v v v
	".": Vector2(0, 4),
	",": Vector2(1, 4),
	"'": Vector2(2, 4),
	"ç": Vector2(3, 4),
	"Ç": Vector2(4, 4),
	":": Vector2(5, 4),
	";": Vector2(6, 4),
	"¡": Vector2(7, 4),
	"!": Vector2(8, 4),
	"¿": Vector2(9, 4),
	"?": Vector2(10, 4),
	" ": Vector2(11, 4),
	"----- -----------": Vector2(0, 0), # Line ID = 5 v v v
	"*": Vector2(0, 5),
	"[": Vector2(1, 5),
	"]": Vector2(2, 5),
	"(": Vector2(3, 5),
	")": Vector2(4, 5),
	"{": Vector2(5, 5),
	"}": Vector2(6, 5),
	"|": Vector2(7, 5),
	"/": Vector2(8, 5),
	"-": Vector2(9, 5),
	"+": Vector2(10, 5),
	"=": Vector2(11, 5),
}

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
var played_intro: bool = false

var select_button_id: int = 0


func _reload_level() -> void:
	get_tree().change_scene_to_packed(current_level)

func _load_level(level) -> void:
	current_level = level
	won = false
	_reload_level()
