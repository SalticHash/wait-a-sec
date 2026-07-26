extends BoardElement2D

@export_enum("0", "1") var on_off_number: int = 0

func _physics_process(_delta: float) -> void:
	if ScrGlobal.level_time % 2 == on_off_number:
		_appear()
	else:
		_disappear()


func _appear() -> void:
	if $area.monitoring:
		return
	$sprite.texture.region = Rect2(36.0 + 9.0 * on_off_number, 9.0, 9.0, 9.0)
	$area.monitoring = true
	$area.monitorable = true
	_create_trail()


func _disappear() -> void:
	if not $area.monitoring:
		return
	$sprite.texture.region = Rect2(36.0 + 9.0 * on_off_number, 18.0, 9.0, 9.0)
	$area.monitoring = false
	$area.monitorable = false
	_create_trail()
