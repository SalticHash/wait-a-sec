extends BoardElement2D

const trail_scene: PackedScene = preload("res://objects/trail_effect.tscn")


func _physics_process(_delta: float) -> void:
	super(_delta)
	if ScrGlobal.level_time > 0:
		_movement()


func _movement() -> void:
	var distance: int = 9
	if Input.is_action_pressed("key_shift"):
		distance = 18
	if Input.is_action_just_pressed("key_up"):
		_efective_move()
		position.y -= distance
	if Input.is_action_just_pressed("key_down"):
		_efective_move()
		position.y += distance
	if Input.is_action_just_pressed("key_left"):
		_efective_move()
		position.x -= distance
	if Input.is_action_just_pressed("key_right"):
		_efective_move()
		position.x += distance


func _efective_move() -> void:
	_instantiate_node(trail_scene)
	ScrGlobal.level_time -= 1


func _instantiate_node(packed_scene: PackedScene) -> void:
	var instance: Node = packed_scene.instantiate()
	get_parent().add_child(instance)
	instance.position = position


func _disappear() -> void:
	if not visible:
		return
	_instantiate_node(trail_scene)
	super()
