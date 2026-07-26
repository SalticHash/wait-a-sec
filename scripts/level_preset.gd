extends Node2D

@export var next_level: PackedScene
@export var final_level: bool = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("key_reset") and !ScrGlobal.won:
		ScrGlobal._reload_level()
		ScrGlobal.reset_level = true
	if ScrGlobal.won and !ScrGlobal.cutscene:
		ScrGlobal.cutscene = true
		var t = 0.5
		while ScrGlobal.level_time > 0:
			ScrGlobal.level_time -= 1
			await get_tree().create_timer(t).timeout
			t *= 0.8
		ScrGlobal.cutscene = false
		ScrGlobal._load_level(next_level)
		#queue_free()
	if Input.is_action_just_pressed("key_undo") and ScrGlobal.level_time < ScrGlobal.original_level_time and !ScrGlobal.won:
		ScrGlobal.level_time += 1
		ScrGlobal.undo.emit()

func _ready() -> void:
	if ScrGlobal.reset_level:
		$reset_sound.play()
		ScrGlobal.reset_level = false
	if name != "lvl_tutorial":
		var lvl = int(name.replace("lvl_", ""))
		$enter_level_popup/units.frame = lvl % 10
		$enter_level_popup/tens.frame = int(lvl / 10.0)
		$enter_level_popup/LevelText.show()
	else:
		$enter_level_popup/TutorialText.show()
		
		
	ScrGlobal.cutscene = true
	await get_tree().create_timer(1.0).timeout
	ScrGlobal.cutscene = false
	$enter_level_popup.hide()
	
