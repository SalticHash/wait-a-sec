@tool
extends Node2D

var text_test = (
	"TEXT EXAMPLE
SPACE
A    . ,    (1,2)   + =  - 'Iç 
ÇHOLAÇ
B []  ()  {}
C
D  34567890
E !¡ ¿? A:B A;Ñ
*F   
* G    j   k   l"
)

@export_multiline var text: String = "I WISH I WHERE A BIRD!!!"
@export var text_texture: Resource = preload("res://textures/textureChunk_3.png")
@export var text_width: int = 3
@export var text_height: int = 5


func _draw() -> void:
	var loop_offset_y = 0
	for line in text.split("\n"):
		var loop_offset_x = 0
		for symbol in line:
			var atlas_pos: Vector2 = match_alphabet(symbol)
			draw_texture_rect_region(
				text_texture,
				Rect2(
					loop_offset_x * text_width + loop_offset_x,
					loop_offset_y * text_height + loop_offset_y,
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
			loop_offset_x += 1
		loop_offset_y += 1


func match_alphabet(letter) -> Vector2:
	var letter_pos = ScrGlobal.LETTER_MAP.get(letter)
	if letter_pos == null:
		letter_pos = Vector2(11, 11)
	return Vector2(letter_pos.x * text_width, letter_pos.y * text_height)
