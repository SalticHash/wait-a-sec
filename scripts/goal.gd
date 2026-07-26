extends BoardElement2D

@export var use_key: bool = false

func _physics_process(_delta: float) -> void:
	if ScrGlobal.level_time == 0:
		_disappear()
		return
	else:
		_appear()
	if use_key:
		if ScrGlobal.keys_left == 0:
			_activate()
		else:
			_deactivate()

func _deactivate() -> void:
	if not $area.monitoring:
		return
	$area.set_deferred("monitoring", false)
	$area.set_deferred("monitorable", false)
	$sprite.texture.region = Rect2(36.0, 0.0, 9.0, 9.0)

func _activate() -> void:
	if $area.monitoring:
		return
	$area.set_deferred("monitoring", true)
	$area.set_deferred("monitorable", true)
	$sprite.texture.region = Rect2(27.0, 0.0, 9.0, 9.0)
	_create_trail()
