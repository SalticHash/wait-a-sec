extends BoardElement2D

@export var use_key: bool = false

func _physics_process(_delta: float) -> void:
	if ScrGlobal.level_time == 0:
		_disappear()
		return
	if use_key:
		if ScrGlobal.keys_left == 0: _appear()
		else: _disappear()
	else:
		_appear()
