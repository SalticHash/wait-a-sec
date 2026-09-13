extends BoardElement2D
class_name WallNumber

func _ready() -> void:
	super()
	var units_digit = life_time % 10
	@warning_ignore("integer_division")
	var tens_digit = life_time / 10
	$units.frame = units_digit
	$tens.frame = tens_digit
	if tens_digit == 0:
		$tens.queue_free()
		$units.position.x = 3
