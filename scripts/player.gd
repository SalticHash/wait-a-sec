extends BoardElement2D

const TRAIL_SCENE: PackedScene = preload("res://objects/trail_effect.tscn")


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
		_spr_dir_down()
		$sprite.flip_h = true
	if Input.is_action_just_pressed("key_down"):
		_efective_move()
		position.y += distance
		_spr_dir_down()
	if Input.is_action_just_pressed("key_left"):
		_efective_move()
		position.x -= distance
		_spr_dir_reset()
		$sprite.flip_h = true
	if Input.is_action_just_pressed("key_right"):
		_efective_move()
		position.x += distance
		_spr_dir_reset()


func _efective_move() -> void:
	_instantiate_node(TRAIL_SCENE)
	ScrGlobal.level_time -= 1


func _spr_dir_down() -> void:
	$sprite.rotation = deg_to_rad(90.0)
	$sprite.offset.y = -9
	$sprite.flip_h = false


func _spr_dir_reset() -> void:
	$sprite.rotation = 0
	$sprite.offset.y = 0
	$sprite.flip_h = false


func _instantiate_node(packed_scene: PackedScene) -> void:
	var instance: Node = packed_scene.instantiate()
	get_parent().add_child(instance)
	instance.position = position


func _disappear() -> void:
	if not visible:
		return
	_instantiate_node(TRAIL_SCENE)
	super()
