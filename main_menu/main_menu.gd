extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ScrGlobal.played_intro:
		$AnimationPlayer.play("entered")
		return
	$AnimationPlayer.play("enter")

func _process(_delta: float) -> void:
	if (
			$AnimationPlayer.current_animation_position > 4.5
			and not ScrGlobal.played_intro
	):
		ScrGlobal.played_intro = true

func _instantiate_node(anim_name: String) -> void:
	var instance: Node = ScrGlobal.TRAIL_SCENE.instantiate()
	get_parent().add_child(instance)
	instance.position = $Logo.position - Vector2(0, 9)
	if anim_name == "logo_trail_2":
		instance.position -= Vector2(9,0)
		instance.z_index = 10
	instance.play(anim_name)
