extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("enter")

func _process(delta: float) -> void:
	if Input.is_anything_pressed() and $AnimationPlayer.current_animation_position > 4.5:
		get_tree().change_scene_to_file("res://levels/lvl_tutorial.tscn")
