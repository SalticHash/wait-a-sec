extends WallNumber


func _physics_process(_delta: float) -> void:
	if ScrGlobal.level_time == life_time:
		_appear()
	else:
		_disappear()


func _appear() -> void:
	if $area.monitoring:
		return
	$sprite.texture.region = Rect2(27.0, 9.0, 9.0, 9.0)
	$units.texture = load("res://textures/numberDisplay_small.png")
	if life_time > 9:
		$tens.texture = load("res://textures/numberDisplay_small.png")
	$area.monitoring = true
	$area.monitorable = true
	_create_trail()


func _disappear() -> void:
	if not $area.monitoring:
		return
	$sprite.texture.region = Rect2(27.0, 18.0, 9.0, 9.0)
	$units.texture = load("res://textures/numberDisplay_small_dark.png")
	if life_time > 9:
		$tens.texture = load("res://textures/numberDisplay_small_dark.png")
	$area.monitoring = false
	$area.monitorable = false
	_create_trail()
