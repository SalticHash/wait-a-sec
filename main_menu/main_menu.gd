extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("enter")

func _process(delta: float) -> void:
	if Input.is_anything_pressed() and $AnimationPlayer.current_animation_position > 4.5:
		get_tree().change_scene_to_file("res://levels/lvl_tutorial.tscn")

func _instantiate_node(anim_name: String) -> void:
	var instance: Node = ScrGlobal.TRAIL_SCENE.instantiate()
	get_parent().add_child(instance)
	instance.position = $Logo.position - Vector2(0, 9)
	if anim_name == "logo_trail_2":
		instance.position -= Vector2(9,0)
		instance.z_index =10
	instance.play(anim_name)
