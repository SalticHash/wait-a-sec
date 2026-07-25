extends BoardElement2D

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


func _instantiate_node(packed_scene: PackedScene) -> void:
	var instance: Node = packed_scene.instantiate()
	get_parent().add_child(instance)
	instance.position = position
	instance.play("wall")


func _disappear() -> void:
	if not visible:
		return
	_instantiate_node(ScrGlobal.TRAIL_SCENE)
	super()
