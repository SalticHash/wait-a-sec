extends Node2D

@export var next_level: PackedScene
@export var final_level: bool = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("key_undo"):
		ScrGlobal._reload_level()
		queue_free()
	if ScrGlobal.won:
		ScrGlobal._load_level(next_level)
		queue_free()

func _ready() -> void:
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
	
