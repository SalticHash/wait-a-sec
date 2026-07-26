extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Text.text = $Text.text % str(ScrGlobal.score).pad_zeros(2)
