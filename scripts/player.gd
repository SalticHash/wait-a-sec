extends BoardElement2D


@onready var last_position: Array[Vector2] = [position]
var last_rotation: Array[float] = [0.0]
var stuck: bool = false


func _ready() -> void:
	ScrGlobal.undo.connect(_return)

func _physics_process(_delta: float) -> void:
	if ScrGlobal.level_time == 0:
		_disappear()

	if visible and !ScrGlobal.cutscene and !ScrGlobal.won and !stuck:
		_movement()


func can_move(dir: Vector2) -> bool:
	match dir:
		Vector2(0, 9): return !$down.has_overlapping_areas()
		Vector2(0, -9): return !$up.has_overlapping_areas()
		Vector2(9, 0): return !$right.has_overlapping_areas()
		Vector2(-9, 0): return !$left.has_overlapping_areas()
		
		Vector2(0, 18): return !$down_far.has_overlapping_areas() and !$down_skip.has_overlapping_areas()
		Vector2(0, -18): return !$up_far.has_overlapping_areas() and !$up_skip.has_overlapping_areas()
		Vector2(18, 0): return !$right_far.has_overlapping_areas() and !$right_skip.has_overlapping_areas()
		Vector2(-18, 0): return !$left_far.has_overlapping_areas() and !$left_skip.has_overlapping_areas()
	return false

func _movement() -> void:
	var distance: int = 9
	if Input.is_action_pressed("key_shift"):
		distance = 18
	
	var dir: Vector2 = Vector2.ZERO
	if Input.is_action_just_pressed("key_up"): dir = Vector2(0, -distance)
	if Input.is_action_just_pressed("key_down"): dir = Vector2(0, distance)
	if Input.is_action_just_pressed("key_right"): dir = Vector2(distance, 0)
	if Input.is_action_just_pressed("key_left"): dir = Vector2(-distance, 0)
	

	
	if dir:
		if can_move(dir):
			last_rotation.push_back($sprite.rotation)
			last_position.push_back(position)
			_efective_move()
			$sprite.rotation = dir.angle()
			position += dir
			await get_tree().physics_frame
			if $inside.has_overlapping_areas() and !stuck:
				_disappear()
				$inside.monitoring = false
				stuck = true
		else:
			$sprite/AnimationPlayer.play("RESET")
			$sprite/AnimationPlayer.advance(0)
			$sprite/AnimationPlayer.play("shake")
			$sprite/AnimationPlayer.advance(0)
			if randf() >= 0.995 and !ScrGlobal.heard_meme:
				$fail_sound_meme.play()
				ScrGlobal.heard_meme = true
			else:
				$fail_sound.play()


func _return() -> void:
	if !visible:
		_appear()
	if stuck:
		$inside.monitoring = true
		stuck = false
	position = last_position.pop_back()
	$sprite.rotation = last_rotation.pop_back()

func _efective_move() -> void:
	_create_trail()
	ScrGlobal.level_time -= 1
	


func _on_touch_goal(_area: Area2D) -> void:
	if ScrGlobal.won: return
	_create_trail()
	$sprite.hide()
	ScrGlobal.won = true
