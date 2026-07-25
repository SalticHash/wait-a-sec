extends BoardElement2D
class_name WallNumber

func _ready() -> void:
	super()
	var str_time = str(life_time)
	if life_time > 9:
		var units_digit = int(str_time[1])
		var tens_digit = int(str_time[0]) 
		$units.frame = units_digit
		$tens.frame = tens_digit
	else:
		$tens.queue_free()
		$units.position.x = 3
		$units.frame = life_time
