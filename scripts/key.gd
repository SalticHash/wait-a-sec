extends BoardElement2D


func _physics_process(_delta: float) -> void:
	if ScrGlobal.level_time == life_time or ScrGlobal.has_key:
		_disappear()
		return
	if ScrGlobal.level_time > life_time:
		_appear()
