extends BoardElement2D

var had_key: Array[bool] = [false]
var got: bool = false
func _ready() -> void:
	super()
	ScrGlobal.keys_left += 1
	ScrGlobal.undo.connect(_return)
	ScrGlobal.time_changed.connect(
		func(last_time,new_time):
			if last_time > new_time:
				had_key.push_back(got)
	)


func _physics_process(_delta: float) -> void:
	if ScrGlobal.level_time == life_time or got:
		_disappear()
		return
	if ScrGlobal.level_time > life_time:
		_appear()

func _return() -> void:
	var still_got = had_key.pop_back()
	print(still_got)
	if still_got != got: ScrGlobal.keys_left += 1
	got = still_got

func _player_entered(_area: Area2D) -> void:
	if got: return
	ScrGlobal.keys_left -= 1
	$key_sound.play()
	got = true
