extends Node2D

@export_multiline var text: String = "TEST"
@export var text_texture: Resource = preload("res://textures/textureChunk_3.png")
@export var text_width: int = 3
@export var text_height: int = 5

var letter_map: Dictionary = {
	"A": Vector2(0, 0),
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
	"X": Vector2(0, 2),
	"Y": Vector2(1, 2),
	"Z": Vector2(2, 2),
	"-----------": Vector2(0, 0),
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
	"----------------": Vector2(0, 0),
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
}

func _draw() -> void:
	var loop_offset = 0
	for symbol in text:
		var text_space = 0
		if loop_offset > 0:
			text_space = 1
		print(loop_offset)
		var atlas_pos: Vector2 = match_alphabet(symbol)
		draw_texture_rect_region(
			text_texture,
			Rect2(
				position.x + loop_offset * text_width + text_space,
				position.y,
				text_width,
				text_height
			),
			Rect2(
				atlas_pos.x,
				atlas_pos.y,
				text_width,
				text_height
			)
		)
		loop_offset += 1

func match_alphabet(letter) -> Vector2:
	var letter_pos = letter_map.get(letter)
	if letter_pos == null:
		letter_pos = letter_map["?"]
	return Vector2(letter_pos.x * text_width, letter_pos.y * text_height)
