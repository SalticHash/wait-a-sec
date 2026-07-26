extends Node2D

@export var next_level: PackedScene
@export var final_level: bool = false

var intro_buffer = 0.25
func _physics_process(delta: float) -> void:
	if ScrGlobal.won:
		if !ScrGlobal.cutscene:
			ScrGlobal.cutscene = true
			var time_left = ScrGlobal.level_time
			while ScrGlobal.level_time > 0:
				ScrGlobal.level_time -= 1
				ScrGlobal.score += 1
				$Score.text = "SCORE:"+str(ScrGlobal.score).pad_zeros(2)
				await get_tree().create_timer(
					clampf(remap(ScrGlobal.level_time, time_left, time_left / 3.0, 0.25, 0.05), 0.05, 0.25)
				).timeout
			await get_tree().create_timer(1.25).timeout
			ScrGlobal.cutscene = false
			ScrGlobal._load_level(next_level)
		return
	if ScrGlobal.cutscene:
		intro_buffer -= delta
		if Input.is_action_just_pressed("continue") and intro_buffer < 0.0:
			ScrGlobal.cutscene = false
			$enter_level_popup.hide()
		return
	$UndoTip.visible = ScrGlobal.level_time == 0 or $level_objects/player.stuck
	if Input.is_action_just_pressed("key_reset"):
		ScrGlobal._reload_level()
		ScrGlobal.reset_level = true
	if Input.is_action_just_pressed("key_undo") and ScrGlobal.level_time < ScrGlobal.original_level_time:
		ScrGlobal.level_time += 1
		ScrGlobal.undo.emit()

func _ready() -> void:
	$Score.text = "SCORE:"+str(ScrGlobal.score).pad_zeros(2)
	$enter_level_popup.show()
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
	
